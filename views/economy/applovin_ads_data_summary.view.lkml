view: applovin_ads_data_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-12-13'

      select
        *
      from
        ${applovin_ads_data_incremental.SQL_TABLE_NAME} a

      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
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
      ${TABLE}.rdg_date
      || '_' || ${TABLE}.event_timestamp
      || '_' || ${TABLE}.platform
      || '_' || ${TABLE}.country
      || '_' || ${TABLE}.ad_type
      ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Generic Dimensions
####################################################################


  dimension: application {type: string}
  dimension: itunes_id {type: string}
  dimension: package_name {type: string}
  dimension: network {type: string}
  dimension: network_type {type: string}
  dimension: campaign_name {type: string}
  dimension: network_placement {type: string}
  dimension: ad_unit {type: string}
  dimension: waterfall {type: string}
  dimension: ad_unit_test {type: string}
  dimension: ad_placement {type: string}
  dimension: platform {type: string}
  dimension: country {type: string}
  dimension: ad_type {type: string}
  dimension: has_idfa {type: string}

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

  measure: impressions {
    type: sum
    value_format_name: decimal_0
    }

  measure: est_revenue {
    type: sum
    value_format_name: usd
    }

  measure: average_ecpm {
    type: number
    value_format_name: usd
    sql:
      1000
      *
      safe_divide(
        sum(${TABLE}.est_revenue)
        ,
        sum(${TABLE}.impressions)
      )
    ;;
    }

















}
