view: player_reward_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-04-30'

      -- create or replace table tal_scratch.player_reward_incremental as

      with

      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      base_data as (

          select
              rdg_id
              , timestamp as timestamp_utc
              , created_at
              , version
              , user_type
              , session_id
              , event_name
              , extra_json
              , experiments
              , win_streak
              , currencies
              , last_level_serial
              , engagement_ticks
          from
              `eraser-blast.game_data.events`
          where

              ------------------------------------------------------------------------
              -- Date selection
              -- We use this because the FIRST time we run this query we want all the data going back
              -- but future runs we only want the last 9 days
              ------------------------------------------------------------------------

              date(timestamp) >=
                  case
                      -- select date(current_date())
                      when date(current_date()) <= '2024-04-30' -- Last Full Update
                      then '2022-06-01'
                      else date_add(current_date(), interval -9 day)
                      end
              and date(timestamp) <= date_add(current_date(), interval -1 DAY)

              ------------------------------------------------------------------------
              -- user type selection
              -- We only want users that are marked as "external"
              -- This removes any bots or internal QA accounts
              ------------------------------------------------------------------------

              and user_type = 'external'

              ------------------------------------------------------------------------
              -- this event information
              ------------------------------------------------------------------------

              and event_name in ( 'reward' )

          )

      ------------------------------------------------------------------------
      -- data_from_extra_json
      ------------------------------------------------------------------------

      -- select extra_json from base_data limit 10

      , get_data_from_extra_json as (

          select
              rdg_id
              , timestamp(date(timestamp_utc)) as rdg_date
              , timestamp_utc
              , created_at
              , version
              , session_id
              , experiments
              , win_streak
              , last_level_serial
              , round(cast(engagement_ticks as int64) / 2) cumulative_time_played_minutes
              , 1 as reward_events

              --------------------------------------------------------------------------------------------
              -- extra json info
              --------------------------------------------------------------------------------------------

            , event_name as event_name
            , safe_cast(json_extract_scalar(extra_json,"$.reward_event") as string ) reward_event
            , safe_cast(json_extract_scalar(extra_json,"$.reward_type") as string ) reward_type
            , safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) as reward_amount
            , safe_cast(json_extract_scalar(extra_json,"$.game_mode") as string ) game_mode
            , safe_cast(json_extract_scalar(extra_json,"$.battle_pass_reward_type") as string ) battle_pass_reward_type
            , safe_cast(json_extract_scalar(extra_json,"$.battle_pass_level") as numeric) as battle_pass_level


          from
              base_data

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      select
          -- primary key
          rdg_id
          , rdg_date
          , timestamp_utc
          , event_name
          , reward_type
          , game_mode
          , battle_pass_reward_type
          , battle_pass_level

          -- other fields
          , max( created_at ) as created_at
          , max( version ) as version
          , max( session_id ) as session_id
          , max( experiments ) as experiments
          , max( win_streak ) as win_streak
          , max( last_level_serial ) as last_level_serial
          , max( cumulative_time_played_minutes ) as cumulative_time_played_minutes
          , sum( reward_events ) as reward_events
          , sum( reward_amount ) as reward_amount


      from
          get_data_from_extra_json
      group by
          1,2,3,4,5,6,7,8


      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (1) + 2 )*( -10 ) minute)) ;;

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
    || '_' || ${TABLE}.event_name
    || '_' || ${TABLE}.reward_type
    || '_' || ${TABLE}.game_mode
    || '_' || ${TABLE}.battle_pass_reward_type
    || '_' || ${TABLE}.battle_pass_level

    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Dimensions
####################################################################

  # # Define your dimensions and measures here, like this:
  dimension_group: rdg_date_analysis {
    description: "date as defined by rdg_date function"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: rdg_date {
    type: date
  }

  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
}
