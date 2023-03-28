view: bot_round_end_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update on '2023-03-28'

      -- create or replace table tal_scratch.bot_round_end_incremental as

      select
          rdg_id
          , event_name
          , timestamp(date(timestamp)) as rdg_date
          , timestamp as round_end_timestamp_utc
          , created_at
          , version
          , session_id
          , experiments
          , win_streak
          , 1 as count_rounds
          , cast(json_extract_scalar( extra_json , "$.lives") as numeric) as lives
          , ifnull( cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 ) as round_length_minutes
          , cast(json_extract_scalar( extra_json , "$.quest_complete") as boolean) as quest_complete
          , case when cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true then 1 else 0 end as count_wins
          , case when cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true then 0 else 1 end as count_losses
          , cast(json_extract_scalar( extra_json , "$.game_mode") as string) as game_mode
          , cast(json_extract_scalar( extra_json , "$.moves_remaining") as numeric) as moves_remaining
          , cast(json_extract_scalar( extra_json , "$.moves_added") as boolean) as moves_added
          , cast(json_extract_scalar(extra_json, "$.moves_made") as int64) as moves_made
          , case when cast( json_extract_scalar( extra_json , "$.moves_added") as boolean) = true then 1 else 0 end as count_rounds_with_moved_added
          , cast(json_extract_scalar( extra_json , "$.coins_earned") as numeric) as coins_earned
          , cast(json_extract_scalar( extra_json , "$.objective_count_total") as numeric) as objective_count_total
          , cast(json_extract_scalar( extra_json , "$.objective_progress") as numeric) as objective_progress
          , cast(json_extract_scalar( extra_json , "$.moves") as numeric) as moves
          , cast(json_extract_scalar( extra_json , "$.level_serial") as numeric) as level_serial
          , cast(json_extract_scalar( extra_json , "$.level_id") as string) as level_id
          , cast(last_level_serial as int64) last_level_serial
          , cast(json_extract_scalar(extra_json,'$.team_slot_0') as string) primary_team_slot
          , cast(json_extract_scalar(extra_json,'$.team_slot_skill_0') as string) primary_team_slot_skill
          , cast(json_extract_scalar(extra_json,'$.team_slot_level_0') as int64) primary_team_slot_level
          , cast(replace(json_extract_scalar(extra_json,'$.proximity_to_completion'),',','') as float64) proximity_to_completion
          , cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
          , cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
          , cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric) currency_07_balance

          , safe_cast(json_extract_scalar( extra_json , "$.objective_0") as numeric) as objective_0
          , safe_cast(json_extract_scalar( extra_json , "$.objective_1") as numeric) as objective_1
          , safe_cast(json_extract_scalar( extra_json , "$.objective_2") as numeric) as objective_2
          , safe_cast(json_extract_scalar( extra_json , "$.objective_3") as numeric) as objective_3
          , safe_cast(json_extract_scalar( extra_json , "$.objective_4") as numeric) as objective_4
          , safe_cast(json_extract_scalar( extra_json , "$.objective_5") as numeric) as objective_5

          , cast(json_extract_scalar( extra_json , "$.config_timestamp") as numeric) as config_timestamp


      from `eraser-blast-staging.game_data.events`
      where
        ------------------------------------------------------------------------
        -- Date selection
        -- We use this because the FIRST time we run this query we want all the data going back
        -- but future runs we only want the last 9 days
        ------------------------------------------------------------------------

        date(timestamp) >=
          case
              -- select date(current_date())
              when date(current_date()) <= '2023-03-13' -- Last Full Update
              then "2023-03-20" -- Only data from June 2022 Onward
              else date_add(current_date(), interval -9 day)
              end
        and date(timestamp) <= date_add(current_date(), interval -1 DAY)

        ------------------------------------------------------------------------
        -- other filters
        ------------------------------------------------------------------------
        and event_name = "round_end_bot"




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
