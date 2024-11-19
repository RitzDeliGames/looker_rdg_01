view: player_popup_and_iam_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-09-27' v2


      select
        *
      from
        ${player_popup_and_iam_incremental.SQL_TABLE_NAME}


      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (2) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
    increment_key: "rdg_date"
    increment_offset: 7

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
    || '_' || ${TABLE}.button_tag

    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Generic Dimensions
####################################################################

  dimension: rdg_id {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: count_iam_messages {type:number}
  dimension: cumulative_time_played_minutes {type:number}


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
## In App Message Details
####################################################################

  dimension: iam_group {
    group_label: "In App Message Detail"
    label: "In App Message Group"
    type:  string
    sql: @{iam_group} ;;
  }

  dimension: iam_type {
    group_label: "In App Message Detail"
    label: "In App Message Type"
    type:  string
    sql: @{iam_type} ;;
  }

  dimension: iam_conversion {
    group_label: "In App Message Detail"
    label: "In App Message Conversion"
    type:  number
    sql: @{iam_conversion} ;;
  }

  dimension: button_tag {
    group_label: "In App Message Detail"
    label: "Button Tag"
    type:  string
    sql: ${TABLE}.button_tag ;;
  }

####################################################################
## Level Buckets
####################################################################

  parameter: dynamic_level_bucket_size {
    type: number
  }

  dimension: dynamic_level_bucket {
    label: "Dynamic Level Bucket"
    type:string
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.last_level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as string
      )
    || ' to '
    ||
    safe_cast(
      ceiling(safe_divide(${TABLE}.last_level_serial+1,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}-1
      as string
      )
    ;;
  }

  dimension: dynamic_level_bucket_order {
    label: "Dynamic Level Bucket Order"
    type:number
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.last_level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as int64
      )
    ;;
  }

####################################################################
## Measures
####################################################################

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: sum_in_app_messages {
    type: sum
    sql: ${TABLE}.count_iam_messages ;;
  }

  measure: iam_conversion_rate {
    label: "Conversion Rate"
    value_format_name: percent_2
    type: number
    sql:
      safe_divide(
        sum(ifnull(safe_cast( @{iam_conversion} as int64 ),0) )
        ,
        sum(${TABLE}.count_iam_messages)
      )
    ;;
  }



}
