view: player_reward_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-04-30'

      -- create or replace table tal_scratch.player_reward_summary as

      select

      -- All columns from incremental table
      rdg_id
      , rdg_date
      , timestamp_utc
      , event_name
      , reward_type
      , game_mode
      , battle_pass_reward_type
      , battle_pass_level
      , created_at
      , version
      , session_id
      , experiments
      , win_streak
      , last_level_serial
      , cumulative_time_played_minutes
      , reward_events
      , reward_amount

      -- Player Age Information
      , timestamp(date(created_at)) as created_date -- Created Date
      , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
      , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

      from
      ${player_reward_incremental.SQL_TABLE_NAME}

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
    || '_' || ${TABLE}.reward_type
    || '_' || ${TABLE}.game_mode
    || '_' || ${TABLE}.battle_pass_reward_type
    || '_' || ${TABLE}.battle_pass_level
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

  # Strings
  dimension: rdg_id {type:string}
  dimension: event_name {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: reward_type {type:string}
  dimension: game_mode {type:string}
  dimension: battle_pass_reward_type {type:string}

  # Numbers
  dimension: cumulative_time_played_minutes {type:number}
  dimension: win_streak {type: number}
  dimension: last_level_serial {type: number}
  dimension: days_since_created {type: number}
  dimension: day_number {type:number}
  dimension: battle_pass_level {type:number}
  dimension: reward_events {type:number}
  dimension: reward_amount {type:number}

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
  measure: sum_reward_events {
    type: sum
    sql: ${TABLE}.reward_events ;;
  }

  ## Reward Amounts Counts
  measure: sum_reward_amount {
    type: sum
    sql: ${TABLE}.reward_amount ;;
  }



}
