view: player_popup_and_iam_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-09-27' v2


      select
        *
        , @{iam_group} as iam_group
        , @{iam_type} as iam_type
        , @{iam_conversion} as iam_conversion
        , @{iam_destination_type} as iam_destination_type
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number
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
  dimension: version_number {type:number sql: safe_cast(${TABLE}.version as numeric ) ;;}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: count_iam_messages {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: day_number {type: number}

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
  }

  dimension: iam_type {
    group_label: "In App Message Detail"
    label: "In App Message Type"
    type:  string
  }

  dimension: iam_conversion {
    group_label: "In App Message Detail"
    label: "In App Message Conversion"
    type:  number
  }

  dimension: iam_destination_type {
    group_label: "In App Message Detail"
    label: "Destination Type"
    type:  string
    sql:  ${TABLE}.iam_destination_type ;;
  }

  dimension: button_tag {
    group_label: "In App Message Detail"
    label: "Button Tag"
    type:  string
    sql: ${TABLE}.button_tag ;;
  }

####################################################################
## Experiments
####################################################################

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
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
        sum(ifnull(safe_cast( ${TABLE}.iam_conversion as int64 ),0) )
        ,
        sum(${TABLE}.count_iam_messages)
      )
    ;;
  }



}
