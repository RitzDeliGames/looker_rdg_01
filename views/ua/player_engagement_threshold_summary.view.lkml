view: player_engagement_threshold_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-12-17'

      with

      base_data as (

        select
          *
          , safe_cast(json_extract(extra_json, '$.ticks') as numeric) as ticks
          , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
          , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number
        from
          ${player_engagement_threshold_incremental.SQL_TABLE_NAME}

      )

      select
        *
        , safe_divide(ticks,2) as minutes_threshold
      from
        base_data
      where
        ticks in (10,30,60,120)



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

  dimension: ticks {
    type:  number
  }

  dimension: minutes_threshold {
    type:  number
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

  measure: count_rows {
    type: sum
    sql: 1 ;;
  }


}
