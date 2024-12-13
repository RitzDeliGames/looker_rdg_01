view: adhoc_check_applovin_ads_vs_telemetry {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    with

    applovin_data as (

      select
        rdg_date
        , sum( est_revenue ) as applovin_revenue
        , sum( impressions ) as applovin_impressions
      from
        ${applovin_ads_data_summary.SQL_TABLE_NAME}
      where
        date(rdg_date) >= '2024-12-08'
      group by
        1

    )

    , telemetry_data as (

      select
        rdg_date
        , sum( ad_view_dollars ) as telemetry_revenue
        , sum( count_ad_views ) as telemetry_impressions
      from
        ${player_ad_view_summary.SQL_TABLE_NAME}
      where
        safe_cast(version as numeric) >= 13613
        and date(rdg_date) >= '2024-12-08'
      group by
        1

    )

    select
      a.*
      , b.* except( rdg_date )
    from
      telemetry_data a
      left join applovin_data b
        on a.rdg_date = b.rdg_date
    order by
      1

      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: my_primary_key {
    type: number
    sql:
    ${TABLE}.rdg_date
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Generic Dimensions
####################################################################

####################################################################
## Date Group
####################################################################

  dimension_group: rdg_date_analysis {
    label: "Activity"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

####################################################################
## Measures
####################################################################

  measure: count_rows {
    type: sum
    sql: 1 ;;
  }

####################################################################
## Custom Measures
####################################################################

  # , sum( est_revenue ) as applovin_revenue
  # , sum( impressions ) as applovin_impressions
  # , sum( ad_view_dollars ) as telemetry_revenue
  # , sum( count_ad_views ) as telemetry_impressions

  measure: applovin_impressions {
    type: sum
    value_format_name: decimal_0
  }

  measure: telemetry_impressions {
    type: sum
    value_format_name: decimal_0
  }

  measure: applovin_revenue {
    type: sum
    value_format_name: usd
  }

  measure: telemetry_revenue {
    type: sum
    value_format_name: usd
  }

  measure: applovin_average_ecpm {
    type: number
    value_format_name: usd
    sql:
      1000
      *
      safe_divide(
        sum(${TABLE}.applovin_revenue)
        ,
        sum(${TABLE}.applovin_impressions)
      )
    ;;
  }

  measure: telemetry_average_ecpm {
    type: number
    value_format_name: usd
    sql:
      1000
      *
      safe_divide(
        sum(${TABLE}.telemetry_revenue)
        ,
        sum(${TABLE}.telemetry_impressions)
      )
    ;;
  }

  measure: diff_revenue {
    type: number
    value_format_name: usd
    sql:
      sum(${TABLE}.telemetry_revenue) - sum(${TABLE}.applovin_revenue)
    ;;
  }

  measure: diff_impressions {
    type: number
    value_format_name: decimal_0
    sql:
      sum(${TABLE}.telemetry_impressions) - sum(${TABLE}.applovin_impressions)
    ;;
  }

  measure: diff_revenue_percent {
    type: number
    value_format_name: percent_0
    sql:
      safe_divide(
        sum(${TABLE}.telemetry_revenue) - sum(${TABLE}.applovin_revenue)
        ,
        sum(${TABLE}.telemetry_revenue)
        )
    ;;
  }

  measure: diff_impressions_percent {
    type: number
    value_format_name: percent_0
    sql:
      safe_divide(
        sum(${TABLE}.telemetry_impressions) - sum(${TABLE}.applovin_impressions)
        , sum(${TABLE}.telemetry_impressions)
        )
    ;;
  }















}
