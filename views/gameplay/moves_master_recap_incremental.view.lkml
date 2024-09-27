view: moves_master_recap_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-09-27'

      -- create or replace table tal_scratch.moves_master_recap_incremental as

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
              , tickets
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
                      when date(current_date()) <= '2024-09-27' -- Last Full Update (come back to that)
                      then '2024-07-10' -- Moves Master Recap Event Start
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

              and event_name = 'moves_master_recap_state'

              ------------------------------------------------------------------------
              -- check my data
              -- this is adhoc if I want to check a query with my own data
              ------------------------------------------------------------------------

              -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba' -- me
              -- and rdg_id = '8ee87da9-7cf2-4e6b-930e-801cc291bb34'
              -- and date(timestamp) between '2024-07-01' and '2024-08-18'

          )

      -- SELECT * FROM base_data

      ------------------------------------------------------------------------
      -- data_from_extra_json
      ------------------------------------------------------------------------

      -- select distinct lower(json_extract_scalar(extra_json,"$.reward_type")) as reward_type from base_data order by 1

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
              , 1 as count_events

              , safe_cast(json_extract_scalar( extra_json , "$.event_id") as string) as event_id
              , safe_cast(json_extract_scalar( extra_json , "$.rank") as int64) as player_event_rank
              , safe_cast(json_extract_scalar( extra_json , "$.player_count") as int64) as player_count
              , safe_cast(json_extract_scalar( extra_json , "$.score") as int64) as score
              , safe_cast(json_extract_scalar( extra_json , "$.instance_id") as string) as instance_id
              , safe_cast(json_extract_scalar( extra_json , "$.tier") as int64) as tier

              -- reward_0
              , safe_cast(json_extract_scalar( extra_json , "$.reward_0") as string) as reward_0
              , safe_cast(split(json_extract_scalar(extra_json,'$.reward_0'), ',')[0] as string) as reward_0_type
              , safe_cast(split(json_extract_scalar(extra_json,'$.reward_0'), ',')[1] as numeric) as reward_0_amount

              -- reward_1
              , safe_cast(json_extract_scalar( extra_json , "$.reward_1") as string) as reward_1
              , safe_cast(split(json_extract_scalar(extra_json,'$.reward_1'), ',')[0] as string) as reward_1_type
              , safe_cast(split(json_extract_scalar(extra_json,'$.reward_1'), ',')[1] as numeric) as reward_1_amount

              -- reward_2
              , safe_cast(json_extract_scalar( extra_json , "$.reward_2") as string) as reward_2
              , safe_cast(split(json_extract_scalar(extra_json,'$.reward_2'), ',')[0] as string) as reward_2_type
              , safe_cast(split(json_extract_scalar(extra_json,'$.reward_2'), ',')[1] as numeric) as reward_2_amount

              -- reward_3
              , safe_cast(json_extract_scalar( extra_json , "$.reward_3") as string) as reward_3
              , safe_cast(split(json_extract_scalar(extra_json,'$.reward_3'), ',')[0] as string) as reward_3_type
              , safe_cast(split(json_extract_scalar(extra_json,'$.reward_3'), ',')[1] as numeric) as reward_3_amount

          from
              base_data

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      select
        -- unique info
        rdg_id
        , rdg_date
        , timestamp_utc

        -- side info
        , max(created_at) as created_at
        , max(version) as version
        , max(session_id) as session_id
        , max(experiments) as experiments
        , max(win_streak) as win_streak
        , max(last_level_serial) as last_level_serial
        , max(cumulative_time_played_minutes) as cumulative_time_played_minutes
        , max(count_events) as count_events

        -- extra_json info
        , max(event_id) as event_id
        , max(player_event_rank) as player_event_rank
        , max(player_count) as player_count
        , max(score) as score
        , max(instance_id) as instance_id
        , max(tier) as tier

        , max(reward_0) as reward_0
        , max(reward_0_type) as reward_0_type
        , max(reward_0_amount) as reward_0_amount

        , max(reward_1) as reward_1
        , max(reward_1_type) as reward_1_type
        , max(reward_1_amount) as reward_1_amount

        , max(reward_2) as reward_2
        , max(reward_2_type) as reward_2_type
        , max(reward_2_amount) as reward_2_amount

        , max(reward_3) as reward_3
        , max(reward_3_type) as reward_3_type
        , max(reward_3_amount) as reward_3_amount

      from
         get_data_from_extra_json
      group by
        1,2,3

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
      ;;
    primary_key: yes
    hidden: yes
  }

  ####################################################################
  ## Other Dimensions
  ####################################################################

  dimension_group: rdg_date_analysis {
    description: "date as defined by rdg_date function"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: rdg_date {
    type: date
  }

  ####################################################################
  ## Measures
  ####################################################################

  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
}
