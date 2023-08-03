view: revenue_model {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


    with

    --------------------------------------------------------------
    -- UA Spend dates
    -- main inputs: start date, number of days to spend
    --------------------------------------------------------------

    my_ua_spend_dates as (

    select
      install_date
    from
      unnest( generate_date_array(
        date({% parameter selected_start_date %})
        , date_add(
            date({% parameter selected_start_date %})
            , interval {% parameter selected_number_of_spend_days %}-1 day)
        )) as install_date

    )

    --------------------------------------------------------------
    -- UA Spend
    --------------------------------------------------------------

    , my_ua_spend as (

    select
      install_date
      , 'US' as region
      , safe_cast({% parameter selected_us_paid_cpi %} as float64) as cpi
      , safe_divide({% parameter selected_ua_spend %},{% parameter selected_number_of_spend_days %}) * {% parameter selected_us_percent_of_spend %} as ua_spend
    from
      my_ua_spend_dates

    union all
    select
      install_date
      , 'WW' as region
      , safe_cast({% parameter selected_ww_paid_cpi %} as float64) as cpi
      , safe_divide({% parameter selected_ua_spend %},{% parameter selected_number_of_spend_days %}) * (1-{% parameter selected_us_percent_of_spend %}) as ua_spend
    from
      my_ua_spend_dates

    )

    --------------------------------------------------------------
    -- UA installs
    --------------------------------------------------------------

    , my_ua_installs as (

      select
        install_date
        , region
        , cpi
        , ua_spend
        , safe_cast( round( safe_divide( ua_spend , cpi ), 0) as int64) as installs
      from
        my_ua_spend

    )

    --------------------------------------------------------------
    -- organic installs
    -- assume we'll get some additional % of organic installs
    --------------------------------------------------------------

    , my_organic_installs as (

      select
        install_date
        , region
        , 0 as cpi
        , 0 as ua_spend
        , safe_cast( round( installs * {% parameter selected_percent_additional_organic_installs %} , 0) as int64) as installs
      from
        my_ua_installs

    )

    --------------------------------------------------------------
    -- combined installs
    --------------------------------------------------------------

    , my_combined_installs as (

      select
        install_date
        , region
        , 'paid' as paid_vs_organic
        , cpi
        , ua_spend
        , installs
      from
        my_ua_installs

      union all

      select
        install_date
        , region
        , 'organic' as paid_vs_organic
        , cpi
        , ua_spend
        , installs
      from
        my_organic_installs

    )

    --------------------------------------------------------------
    -- Retention Curve
    -- step 1
    -- here I'm building out 2000 days, which should be enough for 5 year modeling
    --------------------------------------------------------------

    , my_retention_curve_step_1 as (

      select
        day_number
        , safe_cast( {% parameter selected_retention_d2 %} as float64 ) as retention_d2
        , safe_cast( {% parameter selected_retention_d8 %} as float64 ) as retention_d8
        , safe_cast( {% parameter selected_retention_d31 %} as float64 ) as retention_d31
        , safe_cast( {% parameter selected_retention_d91 %} as float64 ) as retention_d91
        , safe_cast( {% parameter selected_retention_d181 %} as float64 ) as retention_d181
        , safe_cast( {% parameter selected_retention_d366 %} as float64 ) as retention_d366
        , safe_cast( {% parameter selected_retention_d371 %} as float64 ) as retention_d731

      from
        unnest(
          generate_array(1,2000)
        ) as day_number

    )

    --------------------------------------------------------------
    -- Retention Curve
    -- step 2
    --------------------------------------------------------------

    , my_retention_curve as (

      select
          day_number
          , retention_d2
          , retention_d8
          , retention_d31
          , retention_d91
          , retention_d181
          , retention_d366
          , retention_d731
          , safe_cast( case
              when day_number <= 1 then round( 1 , 4 )
              when day_number <= 2 then round( retention_d2 , 4 )

              when day_number <= 3 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.45 ) , 4 )
              when day_number <= 4 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.65 ) , 4 )
              when day_number <= 5 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.80 ) , 4 )
              when day_number <= 6 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.87 ) , 4 )
              when day_number <= 7 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.95 ) , 4 )

              when day_number <= 8 then retention_d8

              when day_number <= 9 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.17 ) , 4 )
              when day_number <= 10 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.29 ) , 4 )
              when day_number <= 11 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.38 ) , 4 )
              when day_number <= 12 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.46 ) , 4 )
              when day_number <= 13 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.51 ) , 4 )
              when day_number <= 14 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.56 ) , 4 )
              when day_number <= 15 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.6 ) , 4 )
              when day_number <= 16 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.64 ) , 4 )
              when day_number <= 17 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.68 ) , 4 )
              when day_number <= 18 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.72 ) , 4 )
              when day_number <= 19 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.75 ) , 4 )
              when day_number <= 20 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.78 ) , 4 )
              when day_number <= 21 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.81 ) , 4 )
              when day_number <= 22 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.84 ) , 4 )
              when day_number <= 23 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.86 ) , 4 )
              when day_number <= 24 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.88 ) , 4 )
              when day_number <= 25 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.91 ) , 4 )
              when day_number <= 26 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.93 ) , 4 )
              when day_number <= 27 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.95 ) , 4 )
              when day_number <= 28 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.97 ) , 4 )
              when day_number <= 29 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.98 ) , 4 )
              when day_number <= 30 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.98 ) , 4 )

              when day_number <= 31 then round( retention_d31 , 4 )

              when day_number <= 32 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.1553 ) , 4 )
              when day_number <= 33 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.1902 ) , 4 )
              when day_number <= 34 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.2174 ) , 4 )
              when day_number <= 35 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.2522 ) , 4 )
              when day_number <= 36 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.2648 ) , 4 )
              when day_number <= 37 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.2826 ) , 4 )
              when day_number <= 38 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.2977 ) , 4 )
              when day_number <= 39 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.3278 ) , 4 )
              when day_number <= 40 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.3612 ) , 4 )
              when day_number <= 41 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.408 ) , 4 )
              when day_number <= 42 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.4314 ) , 4 )
              when day_number <= 43 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.4582 ) , 4 )
              when day_number <= 44 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.4682 ) , 4 )
              when day_number <= 45 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.495 ) , 4 )
              when day_number <= 46 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.5084 ) , 4 )
              when day_number <= 47 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.5184 ) , 4 )
              when day_number <= 48 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.5318 ) , 4 )
              when day_number <= 49 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.5385 ) , 4 )
              when day_number <= 50 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.5619 ) , 4 )
              when day_number <= 51 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.5853 ) , 4 )
              when day_number <= 52 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.6087 ) , 4 )
              when day_number <= 53 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.6254 ) , 4 )
              when day_number <= 54 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.6589 ) , 4 )
              when day_number <= 55 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.6756 ) , 4 )
              when day_number <= 56 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.7023 ) , 4 )
              when day_number <= 57 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.7224 ) , 4 )
              when day_number <= 58 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.7291 ) , 4 )
              when day_number <= 59 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.7492 ) , 4 )
              when day_number <= 60 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.7793 ) , 4 )
              when day_number <= 61 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.786 ) , 4 )
              when day_number <= 62 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.8127 ) , 4 )
              when day_number <= 63 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.8194 ) , 4 )
              when day_number <= 64 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.8294 ) , 4 )
              when day_number <= 65 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.8462 ) , 4 )
              when day_number <= 66 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.8595 ) , 4 )
              when day_number <= 67 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.8628 ) , 4 )
              when day_number <= 68 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.8662 ) , 4 )
              when day_number <= 69 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.8863 ) , 4 )
              when day_number <= 70 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.903 ) , 4 )
              when day_number <= 71 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.913 ) , 4 )
              when day_number <= 72 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9173 ) , 4 )
              when day_number <= 73 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9216 ) , 4 )
              when day_number <= 74 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.926 ) , 4 )
              when day_number <= 75 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9303 ) , 4 )
              when day_number <= 76 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9347 ) , 4 )
              when day_number <= 77 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9391 ) , 4 )
              when day_number <= 78 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9435 ) , 4 )
              when day_number <= 79 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9479 ) , 4 )
              when day_number <= 80 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9524 ) , 4 )
              when day_number <= 81 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9569 ) , 4 )
              when day_number <= 82 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9614 ) , 4 )
              when day_number <= 83 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9659 ) , 4 )
              when day_number <= 84 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9704 ) , 4 )
              when day_number <= 85 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.975 ) , 4 )
              when day_number <= 86 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9796 ) , 4 )
              when day_number <= 87 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9842 ) , 4 )
              when day_number <= 88 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9888 ) , 4 )
              when day_number <= 89 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9935 ) , 4 )
              when day_number <= 90 then round( retention_d31 - ( (retention_d31 - retention_d91) * 0.9981 ) , 4 )

              --when day_number <= 90 then round( retention_d31 - ( ( retention_d31 - retention_d91 ) * safe_divide( day_number - 31 , 60 ) ), 4 )
              when day_number <= 91 then round( retention_d91 , 4 )

              when day_number <= 180 then round( retention_d91 - ( ( retention_d91 - retention_d181 ) * safe_divide( day_number - 91 , 90 ) ), 4 )
              when day_number <= 181 then round( retention_d181 , 4 )

              when day_number <= 365 then round( retention_d181 - ( ( retention_d181 - retention_d366 ) * safe_divide( day_number - 181 , 185 ) ), 4 )
              when day_number <= 366 then round( retention_d366 , 4 )

              when day_number <= 730 then round( retention_d366 - ( ( retention_d366 - retention_d731 ) * safe_divide( day_number - 366 , 365 ) ), 4 )
              when day_number <= 731 then round( retention_d731 , 4 )

              when day_number <= 1999 then round( retention_d731 - ( ( retention_d731 - safe_divide( retention_d731, 2) ) * safe_divide( day_number - 731 , 1269 ) ), 4 )
              when day_number <= 2000 then round( safe_divide( retention_d731, 2)  , 4 )

              when day_number <= 3999 then round( safe_divide( retention_d731, 2) - ( ( safe_divide( retention_d731, 2) - safe_divide( retention_d731, 4) ) * safe_divide( day_number - 2000 , 2000 ) ), 4 )
              when day_number <= 4000 then round( safe_divide( retention_d731, 4)  , 4 )



              else safe_divide( retention_d731, 4) end
              as float64
              ) as retention_curve
      from
        my_retention_curve_step_1

    )

    --------------------------------------------------------------
    -- Combine Retention Curve With Installs
    -- this will calculate DAU
    -- also add Gross ARPDAU for Ads and MTX
    --------------------------------------------------------------

    -- US Gross ARPDAU: $0.65 (Gross is before platform fees are subtracted)
    -- WW Gross ARPDAU: $0.32 (proportional to assumed CPI ratios)
    -- % Ads of Gross: 35%
    -- (Tal: this means
    --   US MTX = 0.65 * 0.65 = 0.4225
    --   WW MTX = 0.32 * 0.65 = 0.208

    --   US Ads = 0.65 * 0.35 = 0.2275
    --   WW Ads = 0.32 * 0.35 = 0.112

    --   )

    , full_dau_curve as (

      select
          a.install_date
          , a.region
          , a.paid_vs_organic
          , a.installs as retention_denominator
          , round( case when b.day_number = 1 then a.ua_spend else 0 end , 2 ) as ua_spend
          , case when b.day_number = 1 then a.installs else 0 end as installs
          , cast( round( a.installs * retention_curve , 0 ) as int64 ) as daily_active_users
          , b.day_number
          , date_add(a.install_date, interval b.day_number - 1 day ) as rdg_date
          , b.retention_curve
          , safe_cast( round( case
              when region = 'US' then {% parameter selected_us_gross_arpdau %} * (1-{% parameter selected_ads_percent_of_arpdau %})
              when region = 'WW' then {% parameter selected_ww_gross_arpdau %} * (1-{% parameter selected_ads_percent_of_arpdau %})
              else 0
              end , 4 ) as float64 )
              as gross_mtx_arpdau
          , safe_cast( round( case
              when region = 'US' then {% parameter selected_us_gross_arpdau %} * ({% parameter selected_ads_percent_of_arpdau %})
              when region = 'WW' then {% parameter selected_ww_gross_arpdau %} * ({% parameter selected_ads_percent_of_arpdau %})
              else 0
              end , 4 ) as float64 )
              as gross_ads_arpdau
      from
        my_combined_installs a
        cross join my_retention_curve b

    )

    --------------------------------------------------------------
    -- add revenue
    --------------------------------------------------------------

    , full_revenue_curve as (

      select
          timestamp(date(install_date)) as install_date
          , region
          , paid_vs_organic
          , ua_spend
          , installs
          , retention_denominator
          , daily_active_users
          , day_number
          , timestamp(date(rdg_date)) as rdg_date

          -- Gross Revenue
          , safe_cast( round( gross_mtx_arpdau * daily_active_users , 2 ) as float64 ) as gross_mtx_revenue
          , safe_cast( round( gross_ads_arpdau * daily_active_users , 2 ) as float64 ) as gross_ads_revenue
          , safe_cast( round( ( gross_mtx_arpdau + gross_ads_arpdau ) * daily_active_users , 2 ) as float64 ) as gross_combined_revenue

          -- Net Revenue (excluding 30% app store cut)
          , safe_cast( round( gross_mtx_arpdau * daily_active_users * 0.70 , 2 ) as float64 ) as net_mtx_revenue
          , safe_cast( round( gross_ads_arpdau * daily_active_users * 0.70 , 2 ) as float64 ) as net_ads_revenue
          , safe_cast( round( ( gross_mtx_arpdau + gross_ads_arpdau ) * daily_active_users * 0.70 , 2 ) as float64 ) as net_combined_revenue

      from
        full_dau_curve

    )

    --------------------------------------------------------------
    -- Summary
    --------------------------------------------------------------

    select * from full_revenue_curve

      ;;
    publish_as_db_view: no


  }
  # select * from ${player_summary_new.SQL_TABLE_NAME}
  # saving code for later
  # {% if selected_display_name._is_filtered %}
  # and display_name = {% parameter selected_display_name %}
  # {% endif %}


####################################################################
## Primary Key
####################################################################

  dimension: my_primary_key {
    type: string
    sql:
    ${TABLE}.install_date
    || ${TABLE}.region
    || ${TABLE}.paid_vs_organic
    || ${TABLE}.day_number
    || ${TABLE}.rdg_date
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################


  dimension_group: install_date {
    group_label: "Dates"
    label: "Install Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.install_date ;;
  }

  dimension: region { type: string }
  dimension: paid_vs_organic { type: string }

  dimension: day_number {
    label: "Day Number"
    type: number
    value_format_name: decimal_0
  }

  dimension_group: rdg_date {
    group_label: "Dates"
    label: "Activity Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

####################################################################
## Measures
####################################################################

  measure: total_installs {
    label: "Total Installs"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.installs ;;
  }

  measure: total_ua_spend {
    label: "Total UA Spend"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.ua_spend ;;

  }

  measure: average_daily_active_users {
    label: "Average Daily Active Users"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.daily_active_users) , count(distinct ${TABLE}.rdg_date ) ) ;;
  }

  measure: total_gross_mtx_revenue {
    label: "Total Gross MTX Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_mtx_revenue ;;
  }

  measure: total_gross_ads_revenue {
    label: "Total Gross Ads Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_ads_revenue ;;
  }

  measure: total_gross_combined_revenue {
    label: "Total Gross Combined Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_combined_revenue ;;
  }

  measure: total_net_mtx_revenue {
    label: "Total Net MTX Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_mtx_revenue ;;
  }

  measure: total_net_ads_revenue {
    label: "Total Net Ads Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_ads_revenue ;;
  }

  measure: total_net_combined_revenue {
    label: "Total Net Combined Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_combined_revenue ;;
  }

  measure: net_mtx_arpdau {
    label: "Net Mtx ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.net_mtx_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: gross_mtx_arpdau {
    label: "Gross Mtx ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.gross_mtx_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: net_ads_arpdau {
    label: "Net Ads ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.net_ads_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: gross_ads_arpdau {
    label: "Gross Ads ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.gross_ads_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: net_combined_arpdau {
    label: "Net Combined ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.net_combined_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: gross_combined_arpdau {
    label: "Gross Combined ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.gross_combined_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: retention {
    label: "Retention"
    type: number
    value_format_name: percent_1
    sql: safe_divide( sum(${TABLE}.daily_active_users) , sum(${TABLE}.retention_denominator) ) ;;
  }

  measure: cpi {
    label: "CPI"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.ua_spend ) , sum(${TABLE}.installs) ) ;;
  }

  measure: net_combined_roas {
    label: "Net Combiend ROAS"
    type: number
    value_format_name: percent_1
    sql: safe_divide( sum(${TABLE}.net_combined_revenue ) , sum(${TABLE}.ua_spend) ) ;;
  }

####################################################################
## Parameters
####################################################################

  parameter: selected_start_date {
    group_label: "Inputs"
    type: date
    default_value: "2023-07-01"
  }

  parameter: selected_number_of_spend_days {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_ua_spend {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_us_percent_of_spend {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_us_paid_cpi {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_ww_paid_cpi {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_percent_additional_organic_installs {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_retention_d2 {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_retention_d8 {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_retention_d31 {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_retention_d91 {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_retention_d181 {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_retention_d366 {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_retention_d371 {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_us_gross_arpdau {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_ww_gross_arpdau {
    group_label: "Inputs"
    type: number
  }

  parameter: selected_ads_percent_of_arpdau {
    group_label: "Inputs"
    type: number
  }




}
