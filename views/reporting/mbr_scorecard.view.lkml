view: mbr_scorecard {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

     with

    --------------------------------------------------------------------------
    -- Base Daily Data
    --------------------------------------------------------------------------

    base_daily_data as (

      select
        date( extract( year from a.rdg_date ), extract( month from a.rdg_date ) , 1 ) as month_start_date
        , date( extract( year from date({% parameter prior_month %})), extract( month from date({% parameter prior_month %})), 1 ) as prior_month
        , date( extract( year from date({% parameter current_month %})), extract( month from date({% parameter current_month %})), 1 ) as current_month
        , safe_divide( sum(1), count(distinct a.rdg_date)) as average_dau
        , coalesce(sum(a.new_player_indicator ), 0) as new_players
        , safe_divide( sum(a.mtx_purchase_dollars), sum(a.count_days_played)) as average_iap_arpdau
        , safe_divide( sum(a.ad_view_dollars), sum(a.count_days_played)) as average_iaa_arpdau
        , safe_divide( sum(a.round_end_events), sum(a.count_days_played)) as average_rounds_per_day
        , safe_divide( sum(a.count_sessions), sum(a.count_days_played)) as average_sessions_per_day
        , safe_divide(sum(a.round_time_in_minutes), sum(a.count_sessions)) as average_round_time_per_session

      from
        ${player_daily_summary.SQL_TABLE_NAME} a
        left join ${player_summary_new.SQL_TABLE_NAME} as b
          on a.rdg_id = b.rdg_id

      where
        date( extract( year from a.rdg_date ), extract( month from a.rdg_date ), 1 ) in (
            date( extract( year from date({% parameter current_month %})), extract( month from date({% parameter current_month %})), 1 )
            , date( extract( year from date({% parameter prior_month %})), extract( month from date({% parameter prior_month %})), 1 )
          )

        -- Country Filter
        {% if country._is_filtered %}
        and b.country in ( {% parameter country %} )
        {% endif %}

      group by
        1
    )

    --------------------------------------------------------------------------
    -- Base Player Level Data
    --------------------------------------------------------------------------

    , base_player_level_data as (

      select
        date( extract( year from a.created_date ), extract( month from a.created_date ) , 1 ) as install_month_start_date
        , date( extract( year from date({% parameter prior_month %})), extract( month from date({% parameter prior_month %})), 1 ) as prior_month
        , date( extract( year from date({% parameter current_month %})), extract( month from date({% parameter current_month %})), 1 ) as current_month

        -- D2 Retention (Big Fish D1)
        , safe_divide(
            sum(case when a.max_available_day_number >= 2
              then a.retention_d2
              else 0
              end )
          ,
            count( distinct
              case
                when a.max_available_day_number >= 2
                then a.rdg_id
                else null
                end )
        ) as big_fish_retention_d1

        -- D15 Retention (Big Fish D14)
        , safe_divide(
          sum(
            case
              when a.max_available_day_number >= 15
              then a.retention_d15
              else 0
              end )
          ,
          count( distinct
            case
              when a.max_available_day_number >= 15
              then a.rdg_id
              else null
              end )
        ) as big_fish_retention_d14

        -- D31 Retention (Big Fish D30)
        , safe_divide(
          sum(
            case
              when a.max_available_day_number >= 31
              then a.retention_d31
              else 0
              end )
          ,
          count( distinct
            case
              when a.max_available_day_number >= 31
              then a.rdg_id
              else null
              end )
        )
         as big_fish_retention_d30

      from
        ${player_summary_new.SQL_TABLE_NAME} AS a

      where
          date( extract( year from a.created_date ), extract( month from a.created_date ), 1 ) in (
          date( extract( year from date({% parameter current_month %})), extract( month from date({% parameter current_month %})), 1 )
          , date( extract( year from date({% parameter prior_month %})), extract( month from date({% parameter prior_month %})), 1 )
        )

        -- Country Filter
        {% if country._is_filtered %}
        and a.country in ( {% parameter country %} )
        {% endif %}

      group by
        1

    )

    --------------------------------------------------------------------------
    -- Player Level Paid US Data
    --------------------------------------------------------------------------

    , player_level_paid_data as (

      select

        date( extract( year from a.created_date ), extract( month from a.created_date ) , 1 ) as install_month_start_date
        , date( extract( year from date({% parameter prior_month %})), extract( month from date({% parameter prior_month %})), 1 ) as prior_month
        , date( extract( year from date({% parameter current_month %})), extract( month from date({% parameter current_month %})), 1 ) as current_month

        -- D15 ROAS (Big Fish D14)
        , safe_divide(
            sum(a.cumulative_combined_dollars_d15)
            ,
            sum(a.attributed_campaign_cost)
          ) as roas_estimate_d15

        -- D15 IAP ROAS (Big Fish D14)
        , safe_divide(
            sum(a.cumulative_mtx_purchase_dollars_d15)
            ,
            sum(a.attributed_campaign_cost)
          ) as iap_roas_estimate_d15

        -- D15 IAA ROAS (Big Fish D14)
        , safe_divide(
            sum(a.cumulative_ad_view_dollars_d15)
            ,
            sum(a.attributed_campaign_cost)
          ) as iaa_roas_estimate_d15

      from
        ${player_summary_new.SQL_TABLE_NAME} a

      where
        date( extract( year from a.created_date ), extract( month from a.created_date ), 1 ) in (
          date( extract( year from date({% parameter current_month %})), extract( month from date({% parameter current_month %})), 1 )
          , date( extract( year from date({% parameter prior_month %})), extract( month from date({% parameter prior_month %})), 1 )
          )

        -- Country Filter
        {% if country._is_filtered %}
        and a.country in ( {% parameter country %} )
        {% endif %}

        -- and a.max_available_day_number >= 15
        and a.mapped_singular_campaign_name_clean IS NOT NULL

      GROUP BY
          1
    )

    --------------------------------------------------------------------------
    -- Combined Table
    --------------------------------------------------------------------------

    , combined_table as (

    --------------------------------------------------------------------------
    -- Header Line 2
    --------------------------------------------------------------------------

      select
      1.0 as my_order
      , '' as my_metric
      , null as start_month_number
      , null as end_month_number

      --------------------------------------------------------------------------
      -- DAU
      --------------------------------------------------------------------------
      union all
      select
      2
      , 'DAU'
      , max( case
          when month_start_date = prior_month
          then average_dau
          else null
          end
          )
      , max( case
          when month_start_date = current_month
          then average_dau
          else null
          end
          )

      from
        base_daily_data

      --------------------------------------------------------------------------
      -- Installs
      --------------------------------------------------------------------------

      union all
      select
      3
      , 'Installs'
      , max( case
          when month_start_date = prior_month
          then new_players
          else null
          end
          )
      , max( case
          when month_start_date = current_month
          then new_players
          else null
          end
          )

      from
        base_daily_data

      --------------------------------------------------------------------------
      -- IAP ARPDAU
      --------------------------------------------------------------------------

      union all
      select
      4
      , 'IAP ARPDAU'
      , max( case
          when month_start_date = prior_month
          then average_iap_arpdau
          else null
          end
          )
      , max( case
          when month_start_date = current_month
          then average_iap_arpdau
          else null
          end
          )

      from
        base_daily_data

      --------------------------------------------------------------------------
      -- IAA ARPDAU
      --------------------------------------------------------------------------

      union all
      select
      5
      , 'IAA ARPDAU'
      , max( case
          when month_start_date = prior_month
          then average_iaa_arpdau
          else null
          end
          )
      , max( case
          when month_start_date = current_month
          then average_iaa_arpdau
          else null
          end
          )

      from
        base_daily_data

      --------------------------------------------------------------------------
      -- D1 Retention
      --------------------------------------------------------------------------

      union all
      select
      6
      , 'D1 Retention'
      , max( case
          when install_month_start_date = prior_month
          then big_fish_retention_d1
          else null
          end
          )
      , max( case
          when install_month_start_date = current_month
          then big_fish_retention_d1
          else null
          end
          )

      from
        base_player_level_data

      --------------------------------------------------------------------------
      -- D14 Retention
      --------------------------------------------------------------------------

      union all
      select
      7
      , 'D14 Retention'
      , max( case
          when install_month_start_date = prior_month
          then big_fish_retention_d14
          else null
          end
          )
      , max( case
          when install_month_start_date = current_month
          then big_fish_retention_d14
          else null
          end
          )

      from
        base_player_level_data

      --------------------------------------------------------------------------
      -- D30 Retention
      --------------------------------------------------------------------------

      union all
      select
      8
      , 'D30 Retention'
      , max( case
          when install_month_start_date = prior_month
          then big_fish_retention_d30
          else null
          end
          )
      , max( case
          when install_month_start_date = current_month
          then big_fish_retention_d30
          else null
          end
          )

      from
        base_player_level_data


      --------------------------------------------------------------------------
      -- Game Rounds Per Day
      --------------------------------------------------------------------------

      union all
      select
      9
      , 'Average Game Rounds Per Day'
      , max( case
          when month_start_date = prior_month
          then average_rounds_per_day
          else null
          end
          )
      , max( case
          when month_start_date = current_month
          then average_rounds_per_day
          else null
          end
          )

      from
        base_daily_data

      --------------------------------------------------------------------------
      -- Sessions Per Day
      --------------------------------------------------------------------------

      union all
      select
      10
      , 'Average Sessions Per Day'
      , max( case
          when month_start_date = prior_month
          then average_sessions_per_day
          else null
          end
          )
      , max( case
          when month_start_date = current_month
          then average_sessions_per_day
          else null
          end
          )

      from
        base_daily_data

      --------------------------------------------------------------------------
      -- Round Time Per Sessions
      --------------------------------------------------------------------------

      union all
      select
      11
      , 'Average Round Time Per Session'
      , max( case
          when month_start_date = prior_month
          then average_round_time_per_session
          else null
          end
          )
      , max( case
          when month_start_date = current_month
          then average_round_time_per_session
          else null
          end
          )
      from
        base_daily_data

      --------------------------------------------------------------------------
      -- Paid ROAS
      --------------------------------------------------------------------------

      union all
      select
      12
      , 'Paid D14 ROAS'
      , max( case
          when install_month_start_date = prior_month
          then roas_estimate_d15
          else null
          end
          )
      , max( case
          when install_month_start_date = current_month
          then roas_estimate_d15
          else null
          end
          )

      from
        player_level_paid_data

      --------------------------------------------------------------------------
      -- Paid IAP ROAS
      --------------------------------------------------------------------------

      union all
      select
      13
      , 'Paid D14 IAP ROAS'
      , max( case
          when install_month_start_date = prior_month
          then iap_roas_estimate_d15
          else null
          end
          )
      , max( case
          when install_month_start_date = current_month
          then iap_roas_estimate_d15
          else null
          end
          )

      from
        player_level_paid_data

      --------------------------------------------------------------------------
      -- Paid IAA ROAS
      --------------------------------------------------------------------------

      union all
      select
      14
      , 'Paid D14 IAA ROAS'
      , max( case
          when install_month_start_date = prior_month
          then iaa_roas_estimate_d15
          else null
          end
          )
      , max( case
          when install_month_start_date = current_month
          then iaa_roas_estimate_d15
          else null
          end
          )

      from
        player_level_paid_data

    )

    --------------------------------------------------------------------------
    -- Table with formatting
    --------------------------------------------------------------------------

    , combined_table_with_formatting as (

      -- https://cloud.google.com/bigquery/docs/reference/standard-sql/format-elements#format_numeric_type_as_string

      select
        *
        , safe_divide( end_month_number, start_month_number ) -1 as percent_change_number
        , ifnull( case
            when my_order = 1 then FORMAT_DATE("%B %Y", date( extract( year from date({% parameter prior_month %})), extract( month from date({% parameter prior_month %})), 1 ))
            when my_metric = 'DAU' then safe_cast(round(start_month_number,0) AS string format '999,999,999')
            when my_metric = 'Installs' then safe_cast(round(start_month_number,0) AS string format '999,999,999')
            when my_metric = 'IAP ARPDAU' then safe_cast(round(start_month_number,2) AS string format '$0.99')
            when my_metric = 'IAA ARPDAU' then safe_cast(round(start_month_number,2) AS string format '$0.99')
            when my_metric = 'D1 Retention' then safe_cast(round(start_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'D14 Retention' then safe_cast(round(start_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'D30 Retention' then safe_cast(round(start_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'Average Game Rounds Per Day' then safe_cast(round(start_month_number,1) AS string format '999,999,999.9')
            when my_metric = 'Average Sessions Per Day' then safe_cast(round(start_month_number,1) AS string format '999,999,999.9')
            when my_metric = 'Average Round Time Per Session' then safe_cast(round(start_month_number,1) AS string format '999,999,999.9')
            when my_metric = 'Paid D14 ROAS' then safe_cast(round(start_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'Paid D14 IAP ROAS' then safe_cast(round(start_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'Paid D14 IAA ROAS' then safe_cast(round(start_month_number*100,1) AS string format '999,999,999.9') ||'%'

            else ''
            end, '') as StartMonth

        , ifnull( case
            when my_order = 1 then FORMAT_DATE("%B %Y", date( extract( year from date({% parameter current_month %})), extract( month from date({% parameter current_month %})), 1 ))
            when my_metric = 'DAU' then safe_cast(round(end_month_number,0) AS string format '999,999,999')
            when my_metric = 'Installs' then safe_cast(round(end_month_number,0) AS string format '999,999,999')
            when my_metric = 'IAP ARPDAU' then safe_cast(round(end_month_number,2) AS string format '$0.99')
            when my_metric = 'IAA ARPDAU' then safe_cast(round(end_month_number,2) AS string format '$0.99')
            when my_metric = 'D1 Retention' then safe_cast(round(end_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'D14 Retention' then safe_cast(round(end_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'D30 Retention' then safe_cast(round(end_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'Average Game Rounds Per Day' then safe_cast(round(end_month_number,1) AS string format '999,999,999.9')
            when my_metric = 'Average Sessions Per Day' then safe_cast(round(end_month_number,1) AS string format '999,999,999.9')
            when my_metric = 'Average Round Time Per Session' then safe_cast(round(end_month_number,1) AS string format '999,999,999.9')
            when my_metric = 'Paid D14 ROAS' then safe_cast(round(end_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'Paid D14 IAP ROAS' then safe_cast(round(end_month_number*100,1) AS string format '999,999,999.9') ||'%'
            when my_metric = 'Paid D14 IAA ROAS' then safe_cast(round(end_month_number*100,1) AS string format '999,999,999.9') ||'%'

            else ''
            end, '') as EndMonth


      from combined_table

    )

    --------------------------------------------------------------------------
    -- Formatt Change
    --------------------------------------------------------------------------

    select
      *
      , ifnull( case
            when my_order = 1 then '% Change'
            when round(percent_change_number * 100 ,0) = 0 then '' || safe_cast( round( percent_change_number * 100 , 0 ) as string ) || '%'
            when percent_change_number > 0 then '+' || safe_cast( round( percent_change_number * 100 , 0 ) as string ) || '%'
            else safe_cast( round( percent_change_number * 100 , 0 ) as string ) || '%'
            end
            , '' ) as MonthlyChange
    from
      combined_table_with_formatting

    order by
    1



      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: level_serial_key {
    type: number
    sql:
    ${TABLE}.level_serial
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

  parameter: current_month {
    type: date
    default_value: "2024-03-01"
  }

  parameter: prior_month {
    type: date
    default_value: "2024-02-01"
  }

  parameter: country {
    type: string
  }

################################################################
## Dimensions
################################################################

  dimension: my_order {type: number}
  dimension: my_metric {type: string}
  dimension: start_month_number {type: number}
  dimension: end_month_number {type: number}
  dimension: percent_change_number {type: number}
  dimension: StartMonth {type: string}
  dimension: EndMonth {type: string}
  dimension: MonthlyChange {type: string}








}
