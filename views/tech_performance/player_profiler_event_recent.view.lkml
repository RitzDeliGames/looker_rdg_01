view: player_profiler_event_recent {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-07-18'

create or replace table tal_scratch.player_profiler_event_recent as

with

      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      base_data as (

        select
          timestamp as timestamp_utc
          , created_at
          , platform
          , country
          , version
          , user_type
          , session_id
          , event_name
          , extra_json
          , ltv
          , currencies
          , experiments
          , rdg_id
          , device_id
          , social_id
          , `language` as language_json
          , install_version
          , engagement_ticks
          , quests_completed
          , session_count
          , advertising_id
          , display_name
          , last_level_id
          , last_level_serial
          , win_streak
          , user_id
          , hardware
          , devices
          , end_of_content_levels
          , end_of_content_zones
          , current_zone
          , current_zone_progress
        from
          `eraser-blast.game_data.events` a
        where

          ------------------------------------------------------------------------
          -- Date selection
          -- We use this because the FIRST time we run this query we want all the data going back
          -- but future runs we only want the last 9 days
          ------------------------------------------------------------------------

        date(timestamp) >=
            case
                -- select date(current_date())
                when date(current_date()) <= '2023-06-21' -- Last Full Update
                then '2022-06-01'
                else date_add(current_date(), interval -30 day)
                end
        and date(timestamp) <= date_add(current_date(), interval -1 DAY)

        ------------------------------------------------------------------------
        -- user type selection
        -- We only want users that are marked as "external"
        -- This removes any bots or internal QA accounts
        ------------------------------------------------------------------------

        and user_type = 'external'

        ------------------------------------------------------------------------
        -- event type
        ------------------------------------------------------------------------

        and event_name = 'profiler'

      )

      -----------------------------------------------------------------------
      -- break out profiler events
      ------------------------------------------------------------------------

      , break_out_profiler_events as (

        select
          a.rdg_id
          , a.timestamp_utc
          , a.event_name
          , a.extra_json
          , safe_cast(json_extract_scalar(a.extra_json, "$.type") as string) as event_type
          , profiler_milestone_unnest
          , safe_cast(json_extract_scalar(profiler_milestone_unnest, "$.step") as string) as step
          , safe_divide(safe_cast(json_extract_scalar(profiler_milestone_unnest, "$.dt") as numeric),1000) step_time_in_seconds
          , safe_divide(safe_cast(json_extract_scalar(profiler_milestone_unnest, "$.t") as numeric),1000) cumulative_event_time_in_seconds
          , safe_cast(json_extract_scalar(profiler_milestone_unnest, "$.frame") as numeric) as frame_number

          -- additional fields
          , platform
          , country
          , version
          , last_level_serial
          , last_level_id
          , hardware
          , devices

        from
          base_data a
          cross join unnest(json_query_array( extra_json, "$.data.milestones" ) ) as profiler_milestone_unnest

      )

      -----------------------------------------------------------------------
      -- select *
      ------------------------------------------------------------------------

      select
        *
        , rank() over ( partition by rdg_id, timestamp_utc, event_type order by frame_number ) as step_number
      from
        break_out_profiler_events


      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    publish_as_db_view: yes

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
    || '_' || ${TABLE}.event_name
    || '_' || ${TABLE}.event_type
    || '_' || ${TABLE}.step

    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Date Groups
####################################################################

  dimension_group: rdg_date {
    label: "Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension_group: timestamp_utc {
    label: "Event Time"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: rdg_id {type:string}
  dimension: event_name {type:string}
  dimension: extra_json {type:string}
  dimension: event_type {type:string}
  dimension: profiler_milestone_unnest {type:string}
  dimension: step {type:string}
  dimension: step_time_in_seconds {type:number}
  dimension: cumulative_event_time_in_seconds {type:number}
  dimension: frame_number {type:number}
  dimension: platform {type:string}
  dimension: country {type:string}
  dimension: version {type:string}
  dimension: last_level_serial {type:number}
  dimension: last_level_id {type:string}
  dimension: hardware {type:string}
  dimension: devices {type:string}
  dimension: step_number {type:number}

####################################################################
## Count Players
####################################################################

  measure: count_distinct_users {
    label: "Count Distinct Users"
    type: number
    value_format_name: decimal_0
    sql:
      count(distinct ${TABLE}.rdg_id)

              ;;
  }

####################################################################
## Count Instances
####################################################################

  measure: count_rows {
    label: "Count Rows"
    type: number
    value_format_name: decimal_0
    sql:
      sum(1) ;;
  }


####################################################################
## Average Step Time
####################################################################

 measure: mean_step_time {
    group_label: "Performance Calculations"
    label: "Average Step Time In Seconds"
    value_format_name: decimal_1
    sql: avg(${TABLE}.step_time_in_seconds) ;;

 }

  measure: step_time_10 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 10
    sql: ${TABLE}.step_time_in_seconds ;;
  }

  measure: step_time_25 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 25
    sql: ${TABLE}.step_time_in_seconds ;;
  }

  measure: step_time_50 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 50
    sql: ${TABLE}.step_time_in_seconds ;;
  }

  measure: step_time_75 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 75
    sql: ${TABLE}.step_time_in_seconds ;;
  }

  measure: step_time_95 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 95
    sql: ${TABLE}.step_time_in_seconds ;;
  }

####################################################################
## Cumualtive Time
####################################################################


  measure: mean_cumulative_event_time {
    group_label: "Performance Calculations"
    label: "Average Cumulative Event Time In Seconds"
    value_format_name: decimal_1
    sql: avg(${TABLE}.cumulative_event_time_in_seconds) ;;

  }

  measure: cumulative_event_time_10 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 10
    sql: ${TABLE}.cumulative_event_time_in_seconds ;;
  }

  measure: cumulative_event_time_25 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 25
    sql: ${TABLE}.cumulative_event_time_in_seconds ;;
  }

  measure: cumulative_event_time_50 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 50
    sql: ${TABLE}.cumulative_event_time_in_seconds ;;
  }

  measure: cumulative_event_time_75 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 75
    sql: ${TABLE}.cumulative_event_time_in_seconds ;;
  }

  measure: cumulative_event_time_95 {
    group_label: "Performance Calculations"
    type: percentile
    value_format_name: decimal_1
    percentile: 95
    sql: ${TABLE}.cumulative_event_time_in_seconds ;;
  }


}
