view: player_round_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update on '2023-05-19'

      -- create or replace table tal_scratch.player_round_incremental as

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
                      when date(current_date()) <= '2023-05-19' -- Last Full Update
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
              and event_name in ('round_start', 'round_end')
          )

      -- SELECT * FROM base_data

      ------------------------------------------------------------------------
      -- get round_start timestamp
      ------------------------------------------------------------------------

      , get_round_start_timestamp as (

          select
              *
              , lag(timestamp_utc) over ( partition by rdg_id order by timestamp_utc) as round_start_timestamp_utc
              , lag(event_name) over ( partition by rdg_id order by timestamp_utc) as round_start_event_name
              , timestamp_utc as round_end_timestamp_utc
          from
              base_data
      )

      ------------------------------------------------------------------------
      -- round end events only
      ------------------------------------------------------------------------

      , get_round_ends_events_only as (

          select
              rdg_id
              , timestamp(date(timestamp_utc)) as rdg_date
              , round_start_timestamp_utc
              , round_end_timestamp_utc
              , created_at
              , version
              , session_id
              , experiments
              , win_streak
              , 1 as count_rounds
              , safe_cast(json_extract_scalar( extra_json , "$.lives") as numeric) as lives
              , ifnull( cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 ) as round_length_minutes
              , safe_cast(json_extract_scalar( extra_json , "$.quest_complete") as boolean) as quest_complete
              , case when safe_cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true then 1 else 0 end as count_wins
              , case when safe_cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true then 0 else 1 end as count_losses
              , safe_cast(json_extract_scalar( extra_json , "$.game_mode") as string) as game_mode
              , safe_cast(json_extract_scalar( extra_json , "$.moves_remaining") as numeric) as moves_remaining
              , safe_cast(json_extract_scalar( extra_json , "$.moves_added") as boolean) as moves_added
              , case when safe_cast( json_extract_scalar( extra_json , "$.moves_added") as boolean) = true then 1 else 0 end as count_rounds_with_moved_added
              , safe_cast(json_extract_scalar( extra_json , "$.coins_earned") as numeric) as coins_earned
              , safe_cast(json_extract_scalar( extra_json , "$.objective_count_total") as numeric) as objective_count_total
              , safe_cast(json_extract_scalar( extra_json , "$.objective_progress") as numeric) as objective_progress
              , safe_cast(json_extract_scalar( extra_json , "$.moves") as numeric) as moves
              , safe_cast(json_extract_scalar( extra_json , "$.level_serial") as numeric) as level_serial
              , safe_cast(json_extract_scalar( extra_json , "$.level_id") as string) as level_id
              , safe_cast(last_level_serial as int64) last_level_serial
              , safe_cast(json_extract_scalar(extra_json,'$.team_slot_0') as string) primary_team_slot
              , safe_cast(json_extract_scalar(extra_json,'$.team_slot_skill_0') as string) primary_team_slot_skill
              , safe_cast(json_extract_scalar(extra_json,'$.team_slot_level_0') as int64) primary_team_slot_level
              , safe_cast(replace(json_extract_scalar(extra_json,'$.proximity_to_completion'),',','') as float64) proximity_to_completion
              , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
              , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
              , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric) currency_07_balance

              , safe_cast(json_extract_scalar( extra_json , "$.objective_0") as numeric) as objective_0
              , safe_cast(json_extract_scalar( extra_json , "$.objective_1") as numeric) as objective_1
              , safe_cast(json_extract_scalar( extra_json , "$.objective_2") as numeric) as objective_2
              , safe_cast(json_extract_scalar( extra_json , "$.objective_3") as numeric) as objective_3
              , safe_cast(json_extract_scalar( extra_json , "$.objective_4") as numeric) as objective_4
              , safe_cast(json_extract_scalar( extra_json , "$.objective_5") as numeric) as objective_5

              , safe_cast(json_extract_scalar( extra_json , "$.config_timestamp") as numeric) as config_timestamp


          from
              get_round_start_timestamp
          where
              event_name = 'round_end'
              and round_start_event_name = 'round_start'

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      -- select * from `eraser-blast`.tal_scratch.INFORMATION_SCHEMA.COLUMNS where table_name = 'player_round_incremental'

      select
          rdg_id
          , rdg_date
          , game_mode
          , level_serial
          , max(round_start_timestamp_utc) as round_start_timestamp_utc
          , round_end_timestamp_utc
          , max(created_at) as created_at
          , max(version) as version
          , max(session_id) as session_id
          , max(experiments) as experiments
          , max(win_streak) as win_streak
          , max(count_rounds) as count_rounds
          , max(lives) as lives
          , max(round_length_minutes) as round_length_minutes
          , max(quest_complete) as quest_complete
          , max(count_wins) as count_wins
          , max(count_losses) as count_losses
          , max(moves_remaining) as moves_remaining
          , max(moves_added) as moves_added
          , max(coins_earned) as coins_earned
          , max(objective_count_total) as objective_count_total
          , max(objective_progress) as objective_progress
          , max(moves) as moves
          , max(level_id) as level_id
          , max(last_level_serial) as last_level_serial
          , max(primary_team_slot) as primary_team_slot
          , max(primary_team_slot_skill) as primary_team_slot_skill
          , max(primary_team_slot_level) as primary_team_slot_level
          , max(proximity_to_completion) as proximity_to_completion
          , max(currency_03_balance) as coins_balance
          , max(currency_04_balance) as lives_balance
          , max(currency_07_balance) as stars_balance
          , max(objective_0) as objective_0
          , max(objective_1) as objective_1
          , max(objective_2) as objective_2
          , max(objective_3) as objective_3
          , max(objective_4) as objective_4
          , max(objective_5) as objective_5
          , max(config_timestamp) as config_timestamp


      from
          get_round_ends_events_only
      group by
          rdg_id
          , rdg_date
          , game_mode
          , level_serial
          , round_end_timestamp_utc



      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
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
      || '_' || ${TABLE}.game_mode
      || '_' || ${TABLE}.level_serial
      || '_' || ${TABLE}.round_end_timestamp_utc
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
