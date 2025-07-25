view: player_mtx_purchase_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-30'

      -- create or replace table tal_scratch.player_mtx_purchase_summary as

      with

      my_currency_exhange_data as (

        select
          timestamp(a.date) as rdg_date
          , a.currency_exchange as country_currency_code
          , safe_divide(1, max(a.exchange_rate)) as exchange_rate
        from
          eraser-blast.analytics.currency_exchange a
        where
          a.currency_exchange is not null
        group by
          1,2

        -- overrides
        union all select timestamp(date('2025-02-01')), 'VND', 0.000039
        union all select timestamp(date('2025-02-01')), 'CLP', 0.0011
        union all select timestamp(date('2025-02-01')), 'USD', 1

      )

      , my_currency_exhange_data_with_lag as (

        select
          a.*
          , lag(rdg_date) over ( partition by country_currency_code order by rdg_date ) as rdg_date_lag
          , lead(rdg_date) over ( partition by country_currency_code order by rdg_date ) as rdg_date_lead
          , max(rdg_date) over ( partition by country_currency_code ) as rdg_date_max
        from
          my_currency_exhange_data a

      )

      , my_date_list as (

        select
          timestamp(rdg_date) as rdg_date
        from
          unnest( generate_date_array('2025-02-01', current_date()) ) as rdg_date

      )

      , my_currency_list as (

        select
          distinct country_currency_code
        from
          my_currency_exhange_data
      )

      , my_date_and_currency_list as (

        select
          *
        from
          my_date_list, my_currency_list

      )

      , my_fixed_currency_list as (

        select
          a.rdg_date
          , a.country_currency_code
          , max( coalesce( b.exchange_rate, c.exchange_rate , d.exchange_rate ) ) as exchange_rate
        from
          my_date_and_currency_list a
          left join my_currency_exhange_data_with_lag b
            on a.rdg_date = b.rdg_date
            and a.country_currency_code = b.country_currency_code
          left join my_currency_exhange_data_with_lag c
            on a.rdg_date > c.rdg_date
            and a.rdg_date < c.rdg_date_lead
            and a.country_currency_code = c.country_currency_code
          left join my_currency_exhange_data_with_lag d
            on a.rdg_date > d.rdg_date_max
            and d.rdg_date = d.rdg_date_max
            and a.country_currency_code = d.country_currency_code
        group by
          1,2
        order by
          2,1
      )

      , base_data as (

        select
          *
          , safe_cast(json_extract_scalar(a.extra_json,"$.transaction_purchase_amount") as numeric) as telemetry_transaction_purchase_amount

          , safe_cast(json_extract_scalar(a.extra_json,"$.localized_price_string") as string) as telemetry_localized_price_string

          , safe_cast(json_extract_scalar( extra_json , "$.country_currency_code") as string) as country_currency_code
        from
          ${player_mtx_purchase_incremental.SQL_TABLE_NAME} a

      )

      , base_data_with_exchange_rates as (

        select
          a.*
          , b.exchange_rate
        from
          base_data a
          left join my_fixed_currency_list b
            on a.rdg_date = b.rdg_date
            and a.country_currency_code = b.country_currency_code

      )

      , my_iap_amount_fix_table as (

--the code below was a band-aid until Oscar built the daily FX pull; it only applies to the five versions below---
        select
          * except ( mtx_purchase_dollars, mtx_purchase_dollars_15 )
          , case
              when version in ( '13663', '13664', '13665' , '13666' , '13671' )
              then
                case

                  when country_currency_code = 'SEK'
                  then telemetry_transaction_purchase_amount * 0.70 * 0.094 * 0.01

                  when country_currency_code = 'DKK'
                  then telemetry_transaction_purchase_amount * 0.70 * 0.14 * 0.01

                  when country_currency_code = 'VND'
                  then telemetry_transaction_purchase_amount * 0.70 * 0.000039 * 0.01

                  when left( telemetry_localized_price_string , 1 ) = '₩'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, '.', ','), '[^0-9.]', '') as numeric) * 0.70 * 0.00070

                  when left( telemetry_localized_price_string , 1 ) = '￥'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.0066

                  when right( telemetry_localized_price_string , 3 ) = 'PHP'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.017

                  when left( telemetry_localized_price_string , 1 ) = '₱'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.017

                  when right( telemetry_localized_price_string , 2 ) = 'Ft'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.0026

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'CL'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, '.', ','), '[^0-9.]', '') as numeric) * 0.70 * 0.00105

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'MX'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.049

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'CA'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.70

                  when left( telemetry_localized_price_string , 1 ) = '$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70

                  when left( telemetry_localized_price_string , 1 ) = '$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70

                  when left( telemetry_localized_price_string , 3 ) = 'MYR'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.2247

                  when substr(telemetry_localized_price_string , -1) = '€'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 1.03

                  when left( telemetry_localized_price_string , 2 ) = 'R$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.1706

                  when left( telemetry_localized_price_string , 3 ) = 'AU$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.64

                  when left( telemetry_localized_price_string , 3 ) = 'US$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70

                  when left( telemetry_localized_price_string , 1 ) = '₹'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.012

                  else mtx_purchase_dollars
                  end
              when safe_cast(version as numeric) > 13671
              then
                case

                  when exchange_rate is not null
                  then telemetry_transaction_purchase_amount * 0.70 * exchange_rate * 0.01

                  when country_currency_code = 'PYG'
                  then telemetry_transaction_purchase_amount * 0.70 * 0.000125 * 0.01

                  else mtx_purchase_dollars
                  end
              else
                mtx_purchase_dollars
              end as telemetry_mtx_purchase_dollars_fix
          , case
              when version in ( '13663', '13664', '13665' , '13666' , '13671' )
              then
                case

                  when country_currency_code = 'SEK'
                  then telemetry_transaction_purchase_amount * 0.70 * 0.094 * 0.01

                  when country_currency_code = 'DKK'
                  then telemetry_transaction_purchase_amount * 0.70 * 0.14 * 0.01

                  when country_currency_code = 'VND'
                  then telemetry_transaction_purchase_amount * 0.70 * 0.000039 * 0.01

                  when left( telemetry_localized_price_string , 1 ) = '₩'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, '.', ','), '[^0-9.]', '') as numeric) * 0.70 * 0.00070

                  when left( telemetry_localized_price_string , 1 ) = '￥'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.0066

                  when right( telemetry_localized_price_string , 3 ) = 'PHP'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.017

                  when left( telemetry_localized_price_string , 1 ) = '₱'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.017

                  when right( telemetry_localized_price_string , 2 ) = 'Ft'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.0026

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'CL'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, '.', ','), '[^0-9.]', '') as numeric) * 0.70 * 0.00105

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'MX'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.049

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'CA'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.70

                  when left( telemetry_localized_price_string , 1 ) = '$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70

                  when left( telemetry_localized_price_string , 1 ) = '$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70

                  when left( telemetry_localized_price_string , 3 ) = 'MYR'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.2247

                  when substr(telemetry_localized_price_string , -1) = '€'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 1.03

                  when left( telemetry_localized_price_string , 2 ) = 'R$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.1706

                  when left( telemetry_localized_price_string , 3 ) = 'AU$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.64

                  when left( telemetry_localized_price_string , 3 ) = 'US$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70

                  when left( telemetry_localized_price_string , 1 ) = '₹'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.70 * 0.012

                  else mtx_purchase_dollars
                  end
              when safe_cast(version as numeric) > 13671
              then
                case

                  when exchange_rate is not null
                  then telemetry_transaction_purchase_amount * 0.70 * exchange_rate * 0.01

                  when country_currency_code = 'PYG'
                  then telemetry_transaction_purchase_amount * 0.70 * 0.000125 * 0.01

                  else mtx_purchase_dollars
                  end
              else
                mtx_purchase_dollars
              end as mtx_purchase_dollars
          , case
              when version in ( '13663', '13664', '13665' , '13666' , '13671' )
              then
                case

                  when country_currency_code = 'SEK'
                  then telemetry_transaction_purchase_amount * 0.85 * 0.094 * 0.01

                  when country_currency_code = 'DKK'
                  then telemetry_transaction_purchase_amount * 0.85 * 0.14 * 0.01

                  when country_currency_code = 'VND'
                  then telemetry_transaction_purchase_amount * 0.85 * 0.000039 * 0.01

                  when left( telemetry_localized_price_string , 1 ) = '₩'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, '.', ','), '[^0-9.]', '') as numeric) * 0.85 * 0.00070

                  when left( telemetry_localized_price_string , 1 ) = '￥'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.0066

                  when right( telemetry_localized_price_string , 3 ) = 'PHP'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.017

                  when left( telemetry_localized_price_string , 1 ) = '₱'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.017

                  when right( telemetry_localized_price_string , 2 ) = 'Ft'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.0026

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'CL'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, '.', ','), '[^0-9.]', '') as numeric) * 0.85 * 0.00105

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'MX'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.049

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'CA'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.70

                  when left( telemetry_localized_price_string , 1 ) = '$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85

                  when left( telemetry_localized_price_string , 1 ) = '$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85

                  when left( telemetry_localized_price_string , 3 ) = 'MYR'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.2247

                  when substr(telemetry_localized_price_string , -1) = '€'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 1.03

                  when left( telemetry_localized_price_string , 2 ) = 'R$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.1706

                  when left( telemetry_localized_price_string , 3 ) = 'AU$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.64

                  when left( telemetry_localized_price_string , 3 ) = 'US$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85

                  when left( telemetry_localized_price_string , 1 ) = '₹'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.012

                  else mtx_purchase_dollars_15
                  end
              when safe_cast(version as numeric) > 13671
              then
                case

                  when exchange_rate is not null
                  then telemetry_transaction_purchase_amount * 0.85 * exchange_rate * 0.01

                  when country_currency_code = 'PYG'
                  then telemetry_transaction_purchase_amount * 0.85 * 0.000125 * 0.01

                  else mtx_purchase_dollars_15
                  end
              else
                mtx_purchase_dollars_15
              end as telemetry_mtx_purchase_dollars_fix_15
          , case
              when version in ( '13663', '13664', '13665' , '13666' , '13671' )
              then
                case

                  when country_currency_code = 'SEK'
                  then telemetry_transaction_purchase_amount * 0.85 * 0.094 * 0.01

                  when country_currency_code = 'DKK'
                  then telemetry_transaction_purchase_amount * 0.85 * 0.14 * 0.01

                  when country_currency_code = 'VND'
                  then telemetry_transaction_purchase_amount * 0.85 * 0.000039 * 0.01

                  when left( telemetry_localized_price_string , 1 ) = '₩'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, '.', ','), '[^0-9.]', '') as numeric) * 0.85 * 0.00070

                  when left( telemetry_localized_price_string , 1 ) = '￥'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.0066

                  when right( telemetry_localized_price_string , 3 ) = 'PHP'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.017

                  when left( telemetry_localized_price_string , 1 ) = '₱'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.017

                  when right( telemetry_localized_price_string , 2 ) = 'Ft'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.0026

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'CL'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, '.', ','), '[^0-9.]', '') as numeric) * 0.85 * 0.00105

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'MX'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.049

                  when left( telemetry_localized_price_string , 1 ) = '$' and country = 'CA'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.70

                  when left( telemetry_localized_price_string , 1 ) = '$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85

                  when left( telemetry_localized_price_string , 1 ) = '$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85

                  when left( telemetry_localized_price_string , 3 ) = 'MYR'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.2247

                  when substr(telemetry_localized_price_string , -1) = '€'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 1.03

                  when left( telemetry_localized_price_string , 2 ) = 'R$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.1706

                  when left( telemetry_localized_price_string , 3 ) = 'AU$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.64

                  when left( telemetry_localized_price_string , 3 ) = 'US$'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85

                  when left( telemetry_localized_price_string , 1 ) = '₹'
                  then safe_cast(regexp_replace(replace(telemetry_localized_price_string, ',', '.'), '[^0-9.]', '') as numeric) * 0.85 * 0.012

                  else mtx_purchase_dollars_15
                  end
--see comment above---
              when safe_cast(version as numeric) > 13671
              then
                case

                  when exchange_rate is not null
                  then telemetry_transaction_purchase_amount * 0.85 * exchange_rate * 0.01

                  when country_currency_code = 'PYG'
                  then telemetry_transaction_purchase_amount * 0.85 * 0.000125 * 0.01

                  else mtx_purchase_dollars_15
                  end
              else
                mtx_purchase_dollars_15
              end as mtx_purchase_dollars_15
        from
          base_data_with_exchange_rates

      )

      , my_remove_hacker_table as (

        select
          *
        from
          my_iap_amount_fix_table
        where
          rdg_id <> '6a7e54eb-c520-4f61-9323-dc37c0207bcd'

      )

      select

        -- All columns from player_mtx_purchase_incremental
        *

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

        -- Cumulative fields
        , sum(ifnull(mtx_purchase_dollars,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_mtx_purchase_dollars

        , sum(ifnull(mtx_purchase_dollars_15,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_mtx_purchase_dollars_15

        , sum(ifnull(count_mtx_purchases,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_count_mtx_purchases

        , @{iap_id_strings_new} as iap_id_strings
        , @{iap_id_strings_grouped_new} as iap_id_strings_grouped

      from
        -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_incremental` a
        my_remove_hacker_table a

      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (2) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

####################################################################
## Primary Key
####################################################################

dimension: primary_key {
  type: string
  sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.rdg_date
    || '_' || ${TABLE}.timestamp_utc
    || '_' || ${TABLE}.transaction_id
    ;;
  primary_key: yes
  hidden: yes
}

################################################################
## Parameters
################################################################

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

################################################################
## Dimensions
################################################################

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  dimension: country_currency_code {
    group_label: "Telemetry Check"
    type: string
  }

  dimension: extra_json {
    group_label: "Telemetry Check"
    type: string
    }
  dimension: telemetry_transaction_purchase_amount  {
    group_label: "Telemetry Check"
    type: number
    }
  dimension: telemetry_localized_price_string  {
    group_label: "Telemetry Check"
    type: string
    }

  dimension: telemetry_mtx_purchase_dollars_fix {
  group_label: "Telemetry Check - 30%"
  type: number
  value_format_name: usd
  }

  dimension: telemetry_mtx_purchase_dollars_fix_15 {
    group_label: "Telemetry Check - 15%"
    type: number
    value_format_name: usd
  }

  dimension: exchange_rate {
    group_label: "Telemetry Check"
    type: number
    value_format_name: decimal_0

  }

  # rdg_date for join
  dimension: join_rdg_date {
    type: date
    sql: date(${TABLE}.rdg_date) ;;
    }

  # dates
  dimension_group: rdg_date {
    group_label: "Activity Dates"
    label: "Activity Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  # dates
  dimension_group: timestamp_utc {
    group_label: "Activity Dates"
    label: "Activity Time"
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

  dimension_group: created_date_timestamp {
    group_label: "Installed On Dates"
    label: "Installed On"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  # Strings
  dimension: rdg_id {type:string}
  dimension: transaction_id {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: order_id {
    label: "Google Play Order Id"
    description: "The id provided by the app store (e.g., Google Play Order ID starting with GPA.) for a validated transaction."
    type:string
  }
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: store_session_id {type:string}

  # Round Info
  dimension: round_game_mode {
    group_label: "Round Info"
    type: string}
  dimension: core_game_mechanic {
    group_label: "Round Info"
    type: string}
  dimension: round_purchase_type {
    group_label: "Round Info"
    type: string}
  dimension: round_count {
    group_label: "Round Info"
    type: number}
  dimension_group: round_start_timestamp_utc {
    group_label: "Round Info"
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.round_start_timestamp_utc ;;
  }
  dimension_group: round_end_timestamp_utc {
    group_label: "Round Info"
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.round_end_timestamp_utc ;;
  }


  dimension: source_id {
    group_label: "SKU Information"
    type:string}

  dimension: iap_purchase_item {
    group_label: "SKU Information"
    type:string}

  dimension: iap_id {
    group_label: "SKU Information"
    type:string}

  dimension: iap_id_strings {
    group_label: "SKU Information"
    label: "IAP Names"
  }

  dimension: iap_id_strings_grouped {
    group_label: "SKU Information"
    label: "IAP Names Grouped"
  }

  dimension: iap_purchase_qty {
    group_label: "SKU Information"
    type:number}


  # Numbers
  dimension: last_level_serial {type:number}
  dimension: last_level_serial_bin {
    type:bin
    bins: [0,500,1000,1500,2000,2500,3000]
    sql: ${last_level_serial} ;;
    }
  dimension: count_mtx_purchases {type:number}

  dimension: mtx_purchase_dollars {
    type:number
    label: "IAP Dollars - 30%"
  }

  dimension: mtx_purchase_dollars_15 {
    type:number
    label: "IAP Dollars - 15%"
  }
  dimension: coins_balance {type:number}
  dimension: lives_balance {type:number}
  dimension: stars_balance {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: cumulative_mtx_purchase_dollars {
    label: "LTV - IAP - 30%"
    type: number
    value_format_name: usd
  }
  dimension: cumulative_mtx_purchase_dollars_15 {
    label: "LTV - IAP - 15%"
    type: number
    value_format_name: usd
  }
  dimension: cumulative_count_mtx_purchases {
    label: "Cumulative Count IAP"
    type: number
    value_format_name: decimal_0
  }

  dimension: treasure_trove_week_start_date {
    label: "Treasure Trove Week Start"
    type: date
    sql:
      date_add(
        date(${TABLE}.rdg_date)
        , interval
          (-1)*(extract( dayofweek from date(${TABLE}.rdg_date)) - 1)
          day
        )
    ;;
  }

################################################################
## Calculated Fields
################################################################

  measure: mean_cost_per_purchase {
    group_label: "Calculated Fields"
    label: "Average Selling Price (ASP) - 30%"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        sum(${TABLE}.count_mtx_purchases)
        )
    ;;
    value_format_name: usd
  }

  measure: mean_cost_per_purchase_15 {
    group_label: "Calculated Fields"
    label: "Average Selling Price (ASP) - 15%"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars_15)
        ,
        sum(${TABLE}.count_mtx_purchases)
        )
    ;;
    value_format_name: usd
  }

  measure: mtx_dollars_per_spender {
    group_label: "Calculated Fields"
    label: "IAP Dollars Per Spender - 30%"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
        )
    ;;
    value_format_name: usd
  }

  measure: mtx_dollars_per_spender_15 {
    group_label: "Calculated Fields"
    label: "IAP Dollars Per Spender - 15%"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars_15)
        ,
        count(distinct ${TABLE}.rdg_id)
        )
    ;;
    value_format_name: usd
  }

  measure: mean_purchases_per_spender {
    group_label: "Calculated Fields"
    label: "Purchases Per Spender"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_mtx_purchases)
        ,
        count(distinct ${TABLE}.rdg_id)
        )
    ;;
    value_format_name: decimal_1
  }
  measure: mtx_dollars_per_unique_day {
    group_label: "Calculated Fields"
    label: "IAP Dollars Per Day - 30%"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        count(distinct ${TABLE}.rdg_date)
        )
    ;;
    value_format_name: usd_0
  }
  measure: mtx_dollars_per_unique_day_15 {
    group_label: "Calculated Fields"
    label: "IAP Dollars Per Day - 15%"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars_15)
        ,
        count(distinct ${TABLE}.rdg_date)
        )
    ;;
    value_format_name: usd_0
  }




################################################################
## Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    label: "Count Distinct Spenders"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: new_spender_count {
    group_label: "Unique Player Counts"
    label: "New Spender Count"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_count_mtx_purchases = 1
          then ${TABLE}.rdg_id
          else null
          end
        )
    ;;
    value_format_name: decimal_0
  }

################################################################
## Sums and Percentiles
################################################################

  measure: sum_count_mtx_purchases {
    group_label: "Sum Count IAPs"
    type:sum
    sql: ${TABLE}.count_mtx_purchases ;;
  }

  measure: sum_mtx_purchase_dollars {
    label: "Sum IAP Dollars - 30%"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.mtx_purchase_dollars ;;
    drill_fields: [timestamp_utc_time,rdg_id,iap_id,iap_id_strings,mtx_purchase_dollars]
  }

  measure: sum_mtx_purchase_dollars_15 {
    label: "Sum IAP Dollars - 15%"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.mtx_purchase_dollars_15 ;;
    drill_fields: [timestamp_utc_time,rdg_id,iap_id,iap_id_strings,mtx_purchase_dollars]
  }

  measure: sum_cumulative_mtx_purchase_dollars {
    label: "Sum LTV - IAP - 30%"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }

  measure: sum_cumulative_mtx_purchase_dollars_15 {
    label: "Sum LTV - IAP - 15%"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_15 ;;
  }

}
