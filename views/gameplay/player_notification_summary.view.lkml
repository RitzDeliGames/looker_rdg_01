view: player_notification_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-03-25'

      -- create or replace table tal_scratch.player_notification_summary as

      select

        -- All columns from incremental table
        rdg_id
        , rdg_date
        , timestamp_utc
        , event_name
        , notification_id
        , created_at
        , version
        , session_id
        , experiments
        , win_streak
        , last_level_serial
        , cumulative_time_played_minutes
        , notification_events
        , notification_channel
        , notification_title
        , notification_group
        , notification_time_to_click
        , notification_name
        , notification_send
        , notification_open
        , send_to_open_in_seconds

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

      from
        ${player_notification_incremental.SQL_TABLE_NAME}

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (3) + 2 )*( -10 ) minute)) ;;
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
    || '_' || ${TABLE}.event_name
    || '_' || ${TABLE}.notification_id
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

  # Date Groups
  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension_group: timestamp_utc {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

  dimension_group: created_date_timestamp {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: notification_send {
    type: time
    timeframes: [date, week, month, year,time]
    sql: ${TABLE}.notification_send ;;
  }

  dimension_group: notification_open {
    type: time
    timeframes: [date, week, month, year,time]
    sql: ${TABLE}.notification_open ;;
  }


  # Strings
  dimension: rdg_id {type:string}
  dimension: event_name {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: notification_channel {type: string}
  dimension: notification_title {type: string}
  dimension: notification_group {type: string}
  dimension: notification_name {type: string}

  # Numbers
  dimension: cumulative_time_played_minutes {type:number}
  dimension: notification_id {type: number}
  dimension: win_streak {type: number}
  dimension: last_level_serial {type: number}
  dimension: send_to_open_in_seconds {type: number}
  dimension: days_since_created {type: number}
  dimension: notification_events {type: number}
  dimension: day_number {type:number}

  # Calculated Dimensions
  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }




################################################################
## Measures
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  ## Event Counts
  measure: sum_notification_events {
    type: sum
    sql: ${TABLE}.notification_events ;;
  }


################################################################
## Notifications Per Player w/ At Least 1 Notification
################################################################

measure: notifications_per_player_w_at_least_1_notification_mean {
  type: number
  label: "Notifications Per Player w/ At Least 1 Notification"
  value_format_name: decimal_1
  sql:
    safe_divide(
      sum(${TABLE}.notification_events)
      ,
      count(distinct ${TABLE}.rdg_id)
    )
  ;;
}






}
