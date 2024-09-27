view: player_battle_pass_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-09-27'

-- create or replace table tal_scratch.player_battle_pass_incremental as

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
                when date(current_date()) <= '2024-09-27' -- Last Full Update
                then '2023-08-01' -- Battle Pass Start
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

        and event_name = 'reward'
        and safe_cast(json_extract_scalar( extra_json , "$.reward_event") as string) = 'battle_pass'

        ------------------------------------------------------------------------
        -- check my data
        -- this is adhoc if I want to check a query with my own data
        ------------------------------------------------------------------------

        -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba' -- me
        -- and rdg_id = '8ee87da9-7cf2-4e6b-930e-801cc291bb34'
        -- and date(timestamp) between '2023-06-01' and '2023-06-06'

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
        , 1 as count_reward_events

        , extra_json
        , safe_cast(json_extract_scalar( extra_json , "$.reward_type") as string) as reward_type
        , safe_cast(json_extract_scalar( extra_json , "$.reward_amount") as string) as reward_amount
        , safe_cast(json_extract_scalar( extra_json , "$.battle_pass_reward_type") as string) as battle_pass_reward_type
        , safe_cast(json_extract_scalar( extra_json , "$.battle_pass_level") as int64) as battle_pass_level

    from
        base_data

)

------------------------------------------------------------------------
-- output for view
------------------------------------------------------------------------

select
    rdg_id
    , rdg_date
    , timestamp_utc
    , reward_type
    , reward_amount
    , battle_pass_reward_type
    , battle_pass_level

    -- side info
    , max(created_at) as created_at
    , max(version) as version
    , max(session_id) as session_id
    , max(experiments) as experiments
    , max(win_streak) as win_streak
    , max(last_level_serial) as last_level_serial
    , max(cumulative_time_played_minutes) as cumulative_time_played_minutes
    , max(count_reward_events) as count_reward_events

from
    get_data_from_extra_json
group by
    1,2,3,4,5,6,7

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
      || '_' || ${TABLE}.reward_type
      || '_' || ${TABLE}.reward_amount
      || '_' || ${TABLE}.battle_pass_reward_type
      || '_' || ${TABLE}.battle_pass_level

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
