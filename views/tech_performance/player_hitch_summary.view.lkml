view: player_hitch_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-12-06'

      with

      base_data as (

        select
          *
          , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
          , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

          -- extra_json
          , safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) as button_tag
          , safe_cast(json_extract_scalar( extra_json , "$.total_time") as numeric) as total_time
          , safe_cast(json_extract_scalar( extra_json , "$.max_frame_time") as numeric) as max_frame_time
          , safe_cast(json_extract_scalar( extra_json , "$.config_timestamp") as numeric) as config_timestamp
          , safe_cast(json_extract_scalar( extra_json , "$.frame_count") as numeric) as frame_count
          , safe_cast(json_extract_scalar( extra_json , "$.round_count") as numeric) as round_count
          , safe_cast(json_extract_scalar( extra_json , "$.level_id") as string) as level_id
          , safe_cast(json_extract_scalar( extra_json , "$.level_serial") as numeric) as level_serial
          , safe_cast(json_extract_scalar( extra_json , "$.level_hash") as numeric) as level_hash
          , safe_cast(json_extract_scalar( extra_json , "$.errors_this_session") as numeric) as errors_this_session

        from
          ${player_hitch_incremental.SQL_TABLE_NAME}
      )

      select
        *
      from
        base_data a

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
      ${TABLE}.rdg_id
      || '_' || ${TABLE}.rdg_date
      || '_' || ${TABLE}.timestamp_utc
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
  dimension: cumulative_time_played_minutes {type:number}
  dimension: day_number {type: number}
  dimension: extra_json {type: string}
  dimension: event_name {type: string}

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
## Custom Dimensions
####################################################################

  dimension: button_tag {type:string}
  dimension: total_time {type:number}
  dimension: max_frame_time {type:number}
  dimension: config_timestamp {type:number}
  dimension: frame_count {type:number}
  dimension: round_count {type:number}
  dimension: level_id {type:string}
  dimension: level_serial {type:number}
  dimension: level_hash {type:number}
  dimension: errors_this_session {type:number}

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
## Basic Measures
####################################################################

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: count_of_rows {
    type: sum
    sql: 1 ;;
  }

####################################################################
## Custom Measures
####################################################################


}
