view: player_round_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update on '2024-07-22'

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
              , case
                  when event_name = 'round_end'
                  then safe_cast(json_extract_scalar(extra_json,"$.round_count") as int64)-1
                  else safe_cast(json_extract_scalar(extra_json,"$.round_count") as int64)
                  end as round_count
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
                      when date(current_date()) <= '2024-07-22' -- Last Full Update
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
              and event_name in ('round_start', 'round_end', 'round_quit')

            ------------------------------------------------------------------------
            -- check my data
            -- this is adhoc if I want to check a query with my own data
            ------------------------------------------------------------------------

            -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'
            -- and date(timestamp) = '2023-09-28'



          )

      -- SELECT * FROM base_data

      -----------------------------------------------------------------------
      -- frame rate histogram breakout
      ------------------------------------------------------------------------

      , frame_rate_histogram_breakout as (
          select
              a.rdg_id
              , timestamp(date( a.timestamp_utc )) as rdg_date
              , safe_cast(json_extract_scalar( a.extra_json , "$.game_mode") as string) as game_mode
              , safe_cast(json_extract_scalar( a.extra_json , "$.level_serial") as numeric) as level_serial
              , a.event_name
              , a.timestamp_utc as round_end_timestamp_utc
              , offset as ms_per_frame
              , sum(safe_cast(frame_time_histogram as int64)) as frame_count
          from
              base_data a
              cross join unnest(split(json_extract_scalar(extra_json,'$.frame_time_histogram_values'))) as frame_time_histogram with offset
          group by
              1,2,3,4,5,6,7
      )

      -----------------------------------------------------------------------
      -- frame rate histogram collapse
      ------------------------------------------------------------------------

      , frame_rate_histogram_collapse as (
          select
              rdg_id
              , rdg_date
              , game_mode
              , level_serial
              , event_name
              , round_end_timestamp_utc

              -- frame rate percentages
              , safe_divide(
                  sum( case when ms_per_frame <= 22 then frame_count else 0 end )
                  , sum( frame_count )
                  ) as percent_frames_below_22

              , safe_divide(
                  sum( case when ms_per_frame > 22 and ms_per_frame <= 40 then frame_count else 0 end )
                  , sum( frame_count )
                  ) as percent_frames_between_23_and_40

              , safe_divide(
                  sum( case when ms_per_frame > 40 then frame_count else 0 end )
                  , sum( frame_count )
                  ) as percent_frames_above_40
          from
              frame_rate_histogram_breakout a
          where
             event_name = 'round_end'
          group by
              1,2,3,4,5,6
      )


      ------------------------------------------------------------------------
      -- get round_start timestamp
      ------------------------------------------------------------------------

      , get_round_start_timestamp as (

          select
              *
              , lag(timestamp_utc) over ( partition by rdg_id order by timestamp_utc) as round_start_timestamp_utc
              , lag(event_name) over ( partition by rdg_id order by timestamp_utc) as round_start_event_name
              , timestamp_utc as round_end_timestamp_utc

              -------------------------------------------------
              -- Pre-Game Boosts
              -------------------------------------------------

              , lag(case
                  when event_name = 'round_start'
                  then
                    case
                      when json_extract_scalar(extra_json,"$.boosts") like '%ROCKET%'
                      then 1
                      else 0
                      end
                  else 0
                  end) over ( partition by rdg_id order by timestamp_utc) as pregame_boost_rocket

              , lag(case
                  when event_name = 'round_start'
                  then
                    case
                      when json_extract_scalar(extra_json,"$.boosts") like '%BOMB%'
                      then 1
                      else 0
                      end
                  else 0
                  end) over ( partition by rdg_id order by timestamp_utc) as pregame_boost_bomb

              , lag(case
                  when event_name = 'round_start'
                  then
                    case
                      when json_extract_scalar(extra_json,"$.boosts") like '%COLOR_BALL%'
                      then 1
                      else 0
                      end
                  else 0
                  end) over ( partition by rdg_id order by timestamp_utc) as pregame_boost_colorball

              , lag(case
                  when event_name = 'round_start'
                  then
                    case
                      when json_extract_scalar(extra_json,"$.boosts") like '%EXTRA_MOVES%'
                      then 1
                      else 0
                      end
                  else 0
                  end) over ( partition by rdg_id order by timestamp_utc) as pregame_boost_extramoves
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
              , round_count
              , event_name
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
              , safe_cast(json_extract_scalar( extra_json, "$.objectives" ) as string) as objectives
              , safe_cast(json_extract_scalar( extra_json , "$.moves") as numeric) as moves
              , safe_cast(json_extract_scalar( extra_json , "$.level_serial") as numeric) as level_serial
              , safe_cast(json_extract_scalar( extra_json , "$.level_id") as string) as level_id
              , safe_cast(json_extract_scalar( extra_json , "$.level_difficuly") as string) as level_difficuly
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

              -- go fish specific fields
              , safe_cast(json_extract_scalar(extra_json, "$.opponent_display_name") as string) as gofish_opponent_display_name
              , safe_cast(json_extract_scalar(extra_json , "$.opponent_moves_remaining") as numeric) as gofish_opponent_moves_remaining
              , safe_cast(json_extract_scalar(extra_json, "$.round_number") as numeric) as gofish_round_number
              , safe_cast(json_extract_scalar(extra_json, "$.player_rank") as numeric) as gofish_player_rank

              -- chum chum boosts used
              , case
                    when safe_cast(version as numeric) < 13294
                    then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_hammer") as numeric),0)
                    else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_clear_cell") as numeric),0)
                    end as powerup_hammer
              , case
                    when safe_cast(version as numeric) < 13294
                    then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_rolling_pin") as numeric),0)
                    else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_clear_vertical") as numeric),0)
                    end as powerup_rolling_pin
              , case
                    when safe_cast(version as numeric) < 13294
                    then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_piping_bag") as numeric),0)
                    else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_clear_horizontal") as numeric),0)
                    end as powerup_piping_bag
              , case
                    when safe_cast(version as numeric) < 13294
                    then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_shuffle") as numeric),0)
                    else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_shuffle") as numeric),0)
                    end as powerup_shuffle
              , case
                    when safe_cast(version as numeric) < 13294
                    then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_chopsticks") as numeric),0)
                    else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_chopsticks") as numeric),0)
                    end as powerup_chopsticks
              , case
                    when safe_cast(version as numeric) < 13294
                    then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_skillet") as numeric),0)
                    else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_skillet") as numeric),0)
                    end as powerup_skillet

              -- technical stats tracking
              , safe_cast(json_extract_scalar(extra_json, "$.used_memory_bytes") as numeric) as used_memory_bytes

              -- moves_master_tier
              , safe_cast(json_extract_scalar(extra_json, "$.moves_master_tier") as numeric) as moves_master_tier

              -- pre game boosts
              , pregame_boost_rocket
              , pregame_boost_bomb
              , pregame_boost_colorball
              , pregame_boost_extramoves

          from
              get_round_start_timestamp
          where
              event_name in ( 'round_end', 'round_quit' )
              and round_start_event_name = 'round_start'

      )

      ------------------------------------------------------------------------
      -- summarize for for view
      ------------------------------------------------------------------------

      , summarize_for_view as (

      select
          rdg_id
          , rdg_date
          , game_mode
          , level_serial
          , event_name
          , round_end_timestamp_utc
          , max(round_start_timestamp_utc) as round_start_timestamp_utc
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
          , max(objectives) as objectives
          , max(moves) as moves
          , max(level_id) as level_id
          , max(level_difficuly) as level_difficuly
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
          , max(round_count) as round_count

          -- go fish specific fields
          , max(gofish_opponent_display_name) as gofish_opponent_display_name
          , max(gofish_opponent_moves_remaining) as gofish_opponent_moves_remaining
          , max(gofish_round_number) as gofish_round_number
          , max(gofish_player_rank) as gofish_player_rank

        -- chum chum boosts used
        , max(powerup_hammer) as powerup_hammer
        , max(powerup_rolling_pin) as powerup_rolling_pin
        , max(powerup_piping_bag) as powerup_piping_bag
        , max(powerup_shuffle) as powerup_shuffle
        , max(powerup_chopsticks) as powerup_chopsticks
        , max(powerup_skillet) as powerup_skillet
        , max(
            powerup_hammer
            + powerup_rolling_pin
            + powerup_piping_bag
            + powerup_shuffle
            + powerup_chopsticks
            + powerup_skillet
            ) as total_chum_powerups_used

        -- pre game boosts
        , max( pregame_boost_rocket ) as pregame_boost_rocket
        , max( pregame_boost_bomb ) as pregame_boost_bomb
        , max( pregame_boost_colorball ) as pregame_boost_colorball
        , max( pregame_boost_extramoves ) as pregame_boost_extramoves
        , max(
            ifnull(pregame_boost_rocket,0)
            + ifnull(pregame_boost_bomb,0)
            + ifnull(pregame_boost_colorball,0)
            + ifnull(pregame_boost_extramoves,0)
            ) as pregame_boost_total

        -- technical stats tracking
        , max(used_memory_bytes) as used_memory_bytes

        -- moves_master_tier
        , max(moves_master_tier) as moves_master_tier

     from
          get_round_ends_events_only
      group by
          1,2,3,4,5,6

      )


    ------------------------------------------------------------------------
    -- Add on histogram
    ------------------------------------------------------------------------

    select
        a.*
        , b.percent_frames_below_22
        , b.percent_frames_between_23_and_40
        , b.percent_frames_above_40
    from
        summarize_for_view a
        left join frame_rate_histogram_collapse b
          on a.rdg_id = b.rdg_id
          and a.rdg_date = b.rdg_date
          and a.game_mode = b.game_mode
          and a.level_serial = b.level_serial
          and a.event_name = b.event_name
          and a.round_end_timestamp_utc = b.round_end_timestamp_utc





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
