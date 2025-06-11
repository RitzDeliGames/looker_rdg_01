view: player_daily_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2025-01-27'

      -- create or replace table tal_scratch.player_daily_incremental_test as

      with

      ------------------------------------------------------------------------
      -- player_daily_incremental
      ------------------------------------------------------------------------
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
          , bfg_uid
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
          , tickets

          --------------------------------------------------------------
          -- fields for possible crash tracking
          --------------------------------------------------------------

          , lag(session_id,1) over (partition by rdg_id order by timestamp) as last_sesison_id_1
          , lag(session_id,2) over (partition by rdg_id order by timestamp) as last_sesison_id_2
          , lag(session_id,3) over (partition by rdg_id order by timestamp) as last_sesison_id_3
          , lag(timestamp,1) over (partition by rdg_id order by timestamp) as last_timestamp_1
          , lag(timestamp,2) over (partition by rdg_id order by timestamp) as last_timestamp_2
          , lag(timestamp,3) over (partition by rdg_id order by timestamp) as last_timestamp_3


        from
          `eraser-blast.game_data.events` a
        where

          ------------------------------------------------------------------------
          -- Date selection
          -- We use this because the FIRST time we run this query we want all the data going back
          -- but future runs we only want the last 9 days
          ------------------------------------------------------------------------

          date(timestamp) >= --'2022-06-01'
              case
                  -- select date(current_date())
                  when date(current_date()) <= '2025-06-11' -- Last Full Update
                  then '2022-06-01'
                  else date_add(current_date(), interval -14 day)
              end
          and date(timestamp) <= date_add(current_date(), interval -1 DAY)

          ------------------------------------------------------------------------
          -- user type selection
          -- We only want users that are marked as "external"
          -- This removes any bots or internal QA accounts
          ------------------------------------------------------------------------

          and user_type = 'external'

          ------------------------------------------------------------------------
          -- check my data
          -- this is adhoc if I want to check a query with my own data
          ------------------------------------------------------------------------

          -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'
          -- and date(timestamp) = '2024-08-13'

      )

      -----------------------------------------------------------------------
      -- frame rate histogram breakout
      ------------------------------------------------------------------------

      , frame_rate_histogram_breakout as (
          select
              a.rdg_id
              , a.timestamp_utc
              , a.session_id
              , a.event_name
              , a.extra_json
              , offset as ms_per_frame
              , sum(safe_cast(frame_time_histogram as int64)) as frame_count
          from
              base_data a
              cross join unnest(split(json_extract_scalar(extra_json,'$.frame_time_histogram_values'))) as frame_time_histogram with offset
          group by
              1,2,3,4,5,6
      )

      -----------------------------------------------------------------------
      -- frame rate histogram collapse
      ------------------------------------------------------------------------

      , frame_rate_histogram_collapse as (
          select
              rdg_id
              , timestamp(date( timestamp_utc )) as rdg_date

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
          group by
              1,2
      )

      -----------------------------------------------------------------------
      -- average asset load times
      ------------------------------------------------------------------------

      , average_asset_load_times as (

        select
          rdg_id
          , timestamp(date(timestamp_utc)) as rdg_date
          , avg(safe_divide(safe_cast(json_extract_scalar(profiler_milestone_unnest, "$.dt") as numeric),1000)) as average_asset_load_time

        from
          base_data a
          cross join unnest(json_query_array( extra_json, "$.data.milestones" ) ) as profiler_milestone_unnest
        where
          event_name = 'profiler'
          and safe_cast(json_extract_scalar(extra_json, "$.type") as string) = "loading"
          and safe_cast(json_extract_scalar(profiler_milestone_unnest, "$.step") as string) = 'title_complete'
          and safe_divide(safe_cast(json_extract_scalar(profiler_milestone_unnest, "$.dt") as numeric),1000) is not null
        group by
          1,2

      )

      ------------------------------------------------------------------------
      -- pre aggregate calculations from base data
      ------------------------------------------------------------------------

      , pre_aggregate_calculations_from_base_data AS (

        SELECT
          -------------------------------------------------
          -- Unique Fields
          -------------------------------------------------

          timestamp(date(timestamp_utc)) AS rdg_date
          , rdg_id

          -------------------------------------------------
          -- General player info
          -------------------------------------------------

          , event_name
          , device_id
          , advertising_id
          , user_id
          , bfg_uid
          , platform
          , country
          , created_at as created_utc
          , date(created_at) as created_date
          , case when experiments = '{}' then null else experiments end as experiments
          , display_name
          , version
          , install_version

          -------------------------------------------------
          -- Dollar Events
          -------------------------------------------------

          -- mtx purchase dollars
          , safe_cast(case
              when event_name = 'transaction'
              and json_extract_scalar(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_01' -- real dollars
              and (
                (
                    platform like '%Android%'
                    and json_extract_scalar(extra_json,"$.rvs_id") LIKE '%GPA%' -- check for valid transactions on Google Play
                  )
                OR (
                    platform like '%iOS%'
                    and length(json_extract_scalar(extra_json,"$.rvs_id")) > 2 -- check for valid transactions on Apple
                  )
                )
              then ifnull(safe_cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") AS numeric) * 0.01 * 0.70 ,0) -- purchase amount + app store cut
              else 0
              end as numeric) AS mtx_purchase_dollars

          , safe_cast(case
              when event_name = 'transaction'
              and json_extract_scalar(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_01' -- real dollars
              and (
                (
                    platform like '%Android%'
                    and json_extract_scalar(extra_json,"$.rvs_id") LIKE '%GPA%' -- check for valid transactions on Google Play
                  )
                OR (
                    platform like '%iOS%'
                    and length(json_extract_scalar(extra_json,"$.rvs_id")) > 2 -- check for valid transactions on Apple
                  )
                )
              then ifnull(safe_cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") AS numeric) * 0.01 * 0.85 ,0) -- purchase amount + app store cut
              else 0
              end as numeric) AS mtx_purchase_dollars_15

          -- ad view dollars
          , safe_cast(case
              when event_name = 'ad'
              then
                ifnull(safe_cast(json_extract_scalar(extra_json,"$.publisher_revenue_per_impression") AS numeric),0) -- revenue per impression
                + ifnull(safe_cast(json_extract_scalar(extra_json,"$.revenue") AS numeric),0) -- revenue per impression
              else 0
              end as numeric) AS ad_view_dollars

          , ltv as mtx_ltv_from_data_in_cents

          -------------------------------------------------
          -- additional ads information
          -------------------------------------------------

          -- ad views
          , safe_cast(case
              when event_name = 'ad'
              then 1
              else 0
              end as int64) as ad_view_indicator

          -------------------------------------------------
          -- session/play info
          -------------------------------------------------

          , session_id
          , session_count
          , engagement_ticks

          -- round start events
          , safe_cast(case
              when event_name = 'round_start'
              then 1 -- count events
              else 0
              end as int64) as round_start_events

          -- round end events
          , safe_cast(case
              when event_name = 'round_end'
              then 1 -- count events
              else 0
              end as int64) as round_end_events

          -- round end events - campaign
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'CAMPAIGN', 'campaign'
                )
              then 1 -- count events
              else 0
              end as int64) as round_end_events_campaign

        -- round end events - campaign
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'movesMaster'
                )
              then 1 -- count events
              else 0
              end as int64) as round_end_events_movesmaster

        -- round end events - puzzle
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'puzzle'
                )
              then 1 -- count events
              else 0
              end as int64) as round_end_events_puzzle

        -- round end events - gemQuest
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'gemQuest'
                )
              then 1 -- count events
              else 0
              end as int64) as round_end_events_gemquest

        -- round end events - gemQuest
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) = 'gemQuest'
                and safe_cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true
              then 1 -- count events
              else 0
              end as int64) as round_win_events_gemquest

        -- round end events - ask for help
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'helpRequest'
                )
              then 1 -- count events
              else 0
              end as int64) as round_end_events_askforhelp

        -- round end events - go Fish
          , safe_cast(CASE
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'goFish'
                )
              then 1 -- count events
              else 0
              end as int64) as round_end_events_gofish

        -- go Fish - Full Matches Completed
          , safe_cast( case
              when
                event_name = 'GoFish'
              then 1 -- count events
              else 0
              end as int64) as gofish_full_matches_completed

        -- go Fish - Full Matches Won
          , safe_cast( case
              when
                event_name = 'GoFish'
                and ifnull(safe_cast(json_extract_scalar(extra_json,"$.total_rank_points_earned") as numeric),0) > 0
              then 1 -- count events
              else 0
              end as int64) as gofish_full_matches_won

        --------------------------------------------------------------
        -- round time events
        --------------------------------------------------------------

          -- round end events
          , safe_cast(case
              when event_name = 'round_end'
              then ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              else 0
              end as int64) as round_time_in_minutes

          -- round end events - campaign
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'CAMPAIGN', 'campaign'
                )
              then ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              else 0
              end as int64) as round_time_in_minutes_campaign

        -- round end events - campaign
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'movesMaster'
                )
              then ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              else 0
              end as int64) as round_time_in_minutes_movesmaster

        -- round end events - puzzle
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'puzzle'
                )
              then ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              else 0
              end as int64) as round_time_in_minutes_puzzle

        -- round end events - askforhelp
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'helpRequest'
                )
              then ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              else 0
              end as int64) as round_time_in_minutes_askforhelp

        -- round end events - gofish
          , safe_cast(case
              when
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'goFish'
                )
              then ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              else 0
              end as int64) as round_time_in_minutes_gofish


          , last_level_serial

         -- gofish_rank
          , case
              when event_name = 'GoFish'
              or (
                safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) = 'goFish'
                and event_name = 'round_end' )
              then
                safe_cast( substr( safe_cast(json_extract_scalar(extra_json, "$.player_rank") as string) , 6,10) as int64 )
              else null end as gofish_rank

          -------------------------------------------------
          -- currency spend info
          -------------------------------------------------

          -- coins spend
          , safe_cast(case
              when event_name = 'transaction'
              and json_extract_scalar(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_03' -- coins currency
              then ifnull(safe_cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") as int64),0) -- purchase amount
              else 0
              end as int64 ) as coins_spend

          -- coins from rewards
          , safe_cast( case
            when event_name = 'reward'
            and json_extract_scalar(extra_json,"$.reward_type") = 'CURRENCY_03'
            then ifnull(safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric),0)
            else 0
            end as int64 ) as coins_sourced_from_rewards

          -- star spend
          , safe_cast(case
              when event_name = 'transaction'
              and json_extract_scalar(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_07' -- star currency
              then ifnull(safe_cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") as int64),0) -- purchase amount
              else 0
              end as int64) as stars_spend

          -------------------------------------------------
          -- ending currency balances
          -------------------------------------------------

          , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_03") AS NUMERIC) as coins_balance
          , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_04") AS NUMERIC) as lives_balance
          , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_07") AS NUMERIC) as stars_balance
          , safe_cast(json_extract_scalar(currencies,"$.DICE") AS NUMERIC) as dice_balance
          , safe_cast(json_extract_scalar(currencies,"$.TICKET") AS NUMERIC) as ticket_balance
          , safe_cast(json_extract_scalar(safe_cast(json_extract(extra_json,"$.achievements") as string),"$.secret_eggs") as numeric) as secret_eggs

          -------------------------------------------------
          -- system info
          -------------------------------------------------

          , safe_cast(case
              when event_name = 'system_info'
              then hardware
              else null
              end as string) as hardware

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.processorType")
              else null
              end as string) as processor_type

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.graphicsDeviceName")
              else null
              end as string) as graphics_device_name

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.deviceModel")
              else null
              end as string) as device_model

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.systemMemorySize")
              else null
              end as int64) as system_memory_size

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.graphicsMemorySize")
              else null
              end as int64) as graphics_memory_size

          , (select
                string_agg(
                    safe_cast(json_extract_scalar(device_array, '$.screenWidth') as string)
                    , ' ,' )
                from
                    unnest(json_extract_array(devices)) device_array
                ) screen_width

          , (select
                string_agg(
                    safe_cast(json_extract_scalar(device_array, '$.screenHeight') as string)
                    , ' ,' )
                from
                    unnest(json_extract_array(devices)) device_array
                ) screen_height

        -------------------------------------------------
        -- other progression info
        -------------------------------------------------

        , end_of_content_levels
        , end_of_content_zones
        , current_zone
        , current_zone_progress

        -------------------------------------------------
        -- Feature Participation
        -------------------------------------------------

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%DailyReward%'
            then 1
            else 0
            end as int64) as feature_participation_daily_reward

        , safe_cast(case
            when
              event_name = 'reward'
              and safe_cast(json_extract_scalar(extra_json, "$.reward_event") as string) = 'daily_reward'
              and safe_cast(json_extract_scalar(extra_json, "$.day") as numeric) = 7
            then 1
            else 0
            end as int64) as feature_participation_daily_reward_day_7_completed

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%PizzaTime%'
            then 1
            else 0
            end as int64) as feature_participation_pizza_time

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%FlourFrenzy%'
            then 1
            else 0
            end as int64) as feature_participation_flour_frenzy

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%LuckyDice%'
            then 1
            else 0
            end as int64) as feature_participation_lucky_dice

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%TreasureTrove%'
            then 1
            else 0
            end as int64) as feature_participation_treasure_trove

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%HotdogContest%'
            then 1
            else 0
            end as int64) as feature_participation_hot_dog_contest

        , safe_cast(case
            when
              event_name = 'reward'
              and safe_cast(json_extract_scalar(extra_json, "$.reward_event") as string) like '%battle_pass%'
            then 1
            else 0
            end as int64) as feature_participation_battle_pass

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%CastleClimb%'
            then 1
            else 0
            end as int64) as feature_participation_castle_climb

        , safe_cast(case
            when
              event_name = 'SimpleEventJoin'
              and safe_cast(json_extract_scalar(extra_json, "$.event_id") as string) like '%ds_event%'
            then 1
            else 0
            end as int64) as feature_participation_donut_sprint

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%FoodTruck%'
            then 1
            else 0
            end as int64) as feature_participation_food_truck

        -------------------------------------------------
        -- Feature Completion
        -------------------------------------------------

        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%CastleClimb%'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%Chest%'
            then 1
            else 0
            end as int64) as feature_completion_castle_climb

        , safe_cast(case
            when
              event_name = 'GemQuestComplete'
            then 1
            else 0
            end as int64) as feature_completion_gem_quest

        -- Sheet_Puzzle.Claim
        , safe_cast(case
            when
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%Sheet_Puzzle.Claim%'
            then 1
            else 0
            end as int64) as feature_completion_puzzle

        -------------------------------------------------
        -- Errors
        -------------------------------------------------

          , safe_cast(case
                  when
                    event_name = 'transition'
                  then ifnull(safe_cast(json_extract(extra_json,'$.low_memory_warnings') as numeric),0)
                  else 0
                  end as int64)
              +
                safe_cast(case
                  when
                    event_name = 'errors'
                    and safe_cast(json_extract(extra_json,'$.logs') as string) like '%low memory warning%'
                  then 1
                  else 0
                  end as int64)
              as errors_low_memory_warning

          , safe_cast(case
              when
                event_name = 'errors'
                and safe_cast(json_extract(extra_json,'$.logs') as string) like '%NullReferenceException%'
              then 1
              else 0
              end as int64) as errors_null_reference_exception

        -------------------------------------------------
        -- average loading times
        -------------------------------------------------

        , safe_cast(case
              when event_name = 'transition'
              then json_extract_scalar(extra_json, "$.load_time")
              else null
              end as int64) as load_time_all

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract_scalar(extra_json, "$.load_time") as int64) is not null
              then 1
              else 0
              end as int64) as load_time_count_all

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%TitleScene%'
              then json_extract_scalar(extra_json, "$.load_time")
              else null
              end as int64) as load_time_from_title_scene

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract_scalar(extra_json, "$.load_time") as int64) is not null
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%TitleScene%'
              then 1
              else 0
              end as int64) as load_time_count_from_title_scene

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%MetaScene%'
              then json_extract_scalar(extra_json, "$.load_time")
              else null
              end as int64) as load_time_from_meta_scene

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract_scalar(extra_json, "$.load_time") as int64) is not null
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%MetaScene%'
              then 1
              else 0
              end as int64) as load_time_count_from_meta_scene

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%GameScene%'
              then json_extract_scalar(extra_json, "$.load_time")
              else null
              end as int64) as load_time_from_game_scene

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract_scalar(extra_json, "$.load_time") as int64) is not null
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%GameScene%'
              then 1
              else 0
              end as int64) as load_time_count_from_game_scene

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%AppStart%'
              then json_extract_scalar(extra_json, "$.load_time")
              else null
              end as int64) as load_time_from_app_start

        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract_scalar(extra_json, "$.load_time") as int64) is not null
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%AppStart%'
              then 1
              else 0
              end as int64) as load_time_count_from_app_start

        -- {"transition_from":"AppStart","transition_to":"FirstInteraction","load_time":13238,"
        , safe_cast(case
              when
                event_name = 'transition'
                and safe_cast(json_extract(extra_json,'$.transition_from') as string) like '%AppStart%'
                and safe_cast(json_extract(extra_json,'$.transition_to') as string) like '%FirstInteraction%'
              then json_extract_scalar(extra_json, "$.load_time")
              else null
              end as int64) as load_time_from_first_app_start_to_first_interaction

        -------------------------------------------------
        -- Low Render Perf Count
        -------------------------------------------------

        , safe_cast(json_extract_scalar( extra_json , "$.low_render_perf_count") as numeric) as low_render_perf_count

        -------------------------------------------------
        -- Ask for Help Participation
        -------------------------------------------------

        , safe_cast(case
              when
                event_name = 'afh'
                and safe_cast(json_extract_scalar(extra_json, "$.afh_action") as string) = 'request'
              then 1
              else 0
              end as int64) as feature_participation_ask_for_help_request

        , safe_cast(case
              when
                event_name = 'afh'
                and safe_cast(json_extract_scalar(extra_json, "$.afh_action") as string) = 'completed'
              then 1
              else 0
              end as int64) as feature_participation_ask_for_help_completed

        , safe_cast(case
              when
                event_name = 'afh'
                and safe_cast(json_extract_scalar(extra_json, "$.afh_action") as string) = 'high_five'
              then 1
              else 0
              end as int64) as feature_participation_ask_for_help_high_five

        , safe_cast(case
              when
                event_name = 'afh'
                and safe_cast(json_extract_scalar(extra_json, "$.afh_action") as string) = 'high_five_return'
              then 1
              else 0
              end as int64) as feature_participation_ask_for_help_high_five_return

        --------------------------------------------------------------
        -- check for possible crashes from screen title awake
        --------------------------------------------------------------

        , case
            when event_name = 'TitleScreenAwake'
            and ( session_id <> last_sesison_id_1 and timestamp_diff(timestamp_utc, last_timestamp_1, minute) <= 1
                  or session_id <> last_sesison_id_2 and timestamp_diff(timestamp_utc, last_timestamp_2, minute) <= 1
                  or session_id <> last_sesison_id_3 and timestamp_diff(timestamp_utc, last_timestamp_3, minute) <= 1
              )
            then 1
            else 0
            end as count_possible_crashes_from_fast_title_screen_awake

        -------------------------------------------------
        -- ending boost balances
        -------------------------------------------------

        , safe_cast(json_extract_scalar(tickets,"$.ROCKET") as numeric) as balance_rocket
        , safe_cast(json_extract_scalar(tickets,"$.BOMB") as numeric) as balance_bomb
        , safe_cast(json_extract_scalar(tickets,"$.COLOR_BALL") as numeric) as balance_color_ball

        -- chums
        , safe_cast(json_extract_scalar(tickets,"$.clear_cell") as numeric) as balance_clear_cell
        , safe_cast(json_extract_scalar(tickets,"$.clear_horizontal") as numeric) as balance_clear_horizontal
        , safe_cast(json_extract_scalar(tickets,"$.clear_vertical") as numeric) as balance_clear_vertical
        , safe_cast(json_extract_scalar(tickets,"$.shuffle") as numeric) as balance_shuffle
        , safe_cast(json_extract_scalar(tickets,"$.chopsticks") as numeric) as balance_chopsticks
        , safe_cast(json_extract_scalar(tickets,"$.skillet") as numeric) as balance_skillet
        , safe_cast(json_extract_scalar(tickets,"$.moves") as numeric) as balance_moves
        , safe_cast(json_extract_scalar(tickets,"$.disco") as numeric) as balance_disco

        -------------------------------------------------
        -- Chum Skills
        -------------------------------------------------

        , case
            when event_name = 'round_end'
            then case
              when safe_cast(version as numeric) < 13294
              then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_hammer") as numeric),0)
              else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_clear_cell") as numeric),0)
              end
            else 0
            end as powerup_hammer
        , case
            when event_name = 'round_end'
            then case
              when safe_cast(version as numeric) < 13294
              then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_rolling_pin") as numeric),0)
              else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_clear_vertical") as numeric),0)
              end
            else 0
            end as powerup_rolling_pin
        , case
            when event_name = 'round_end'
            then case
              when safe_cast(version as numeric) < 13294
              then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_piping_bag") as numeric),0)
              else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_clear_horizontal") as numeric),0)
              end
            else 0
            end as powerup_piping_bag
        , case
            when event_name = 'round_end'
            then case
              when safe_cast(version as numeric) < 13294
              then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_shuffle") as numeric),0)
              else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_shuffle") as numeric),0)
              end
            else 0
            end as powerup_shuffle
        , case
            when event_name = 'round_end'
            then case
              when safe_cast(version as numeric) < 13294
              then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_chopsticks") as numeric),0)
              else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_chopsticks") as numeric),0)
              end
            else 0
            end as powerup_chopsticks
        , case
            when event_name = 'round_end'
            then case
              when safe_cast(version as numeric) < 13294
              then ifnull(safe_cast(json_extract_scalar(extra_json, "$.powerup_skillet") as numeric),0)
              else ifnull(safe_cast(json_extract_scalar(extra_json, "$.skill_skillet") as numeric),0)
              end
            else 0
            end as powerup_skillet

        -------------------------------------------------
        -- Pre-Game Boosts
        -------------------------------------------------

        , case
            when event_name = 'round_start'
            then
              case
                when json_extract_scalar(extra_json,"$.boosts") like '%ROCKET%'
                then 1
                else 0
                end
            else 0
            end as pregame_boost_rocket

        , case
            when event_name = 'round_start'
            then
              case
                when json_extract_scalar(extra_json,"$.boosts") like '%BOMB%'
                then 1
                else 0
                end
            else 0
            end as pregame_boost_bomb

        , case
            when event_name = 'round_start'
            then
              case
                when json_extract_scalar(extra_json,"$.boosts") like '%COLOR_BALL%'
                then 1
                else 0
                end
            else 0
            end as pregame_boost_colorball

        , case
            when event_name = 'round_start'
            then
              case
                when json_extract_scalar(extra_json,"$.boosts") like '%EXTRA_MOVES%'
                then 1
                else 0
                end
            else 0
            end as pregame_boost_extramoves

        -------------------------------------------------
        -- Daily Popup (step_1)
        -------------------------------------------------

        -- safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string)

        , case
            when
              event_name = 'ButtonClicked' -- on button click
              and safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_PM_%' -- daily popups are prefaced with Sheet_PM
            then
              substring(
                safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string)
                , length('Sheet_PM_') + 1
                , strpos(safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string),'.') -length('Sheet_PM_')-1
                )
            else null
            end as daily_popup_category

        , case
            when
              event_name = 'ButtonClicked' -- on button click
              and safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_PM_%' -- daily popups are prefaced with Sheet_PM
            then
              substring(
              safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string)
              , strpos(safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string),'.') + 1
              )
            else null
            end as daily_popup_action

        -------------------------------------------------
        -- Estimate Ad Placements
        -------------------------------------------------

        -- Moves Master
        , case
          when event_name = 'round_end'
          and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) = 'movesMaster'
          and safe_cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true
          then 1 else 0 end as estimate_ad_placements_movesmaster

        -- Battle Pass
        , case
          when event_name = 'reward'
          and safe_cast(json_extract_scalar( extra_json , "$.reward_event") as string) = 'battle_pass'
          and safe_cast(json_extract_scalar( extra_json , "$.battle_pass_reward_type") as string) = 'free'
          then 1 else 0 end as estimate_ad_placements_battlepass

        -- Go Fish
        , case
          when event_name = 'round_end'
          and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) = 'goFish'
          and safe_cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true
          then 1 else 0 end as estimate_ad_placements_gofish

        -- Puzzle
        , case
          when event_name = 'round_end'
          and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) = 'puzzle'
          and safe_cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true
          then 1 else 0 end as estimate_ad_placements_puzzle

        -- Out of Lives
        , case
          when event_name = 'ButtonClicked'
          and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%.NoPlay'
          and safe_cast( json_extract_scalar( currencies , "$.CURRENCY_04") as numeric) = 0
          then 1 else 0 end as estimate_ad_placements_lives

        -- Pizza
        -- can just say cap at 1 per day, only if pizza was collected
        , case
          when event_name = 'ButtonClicked'
          and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%Sheet_PizzaTime%'
          then 1 else 0 end as estimate_ad_placements_pizzatime


        -- Lukcy Dice
      , case
          when event_name = 'ButtonClicked'
          and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%Panel_ZoneHome.LuckyDice%'
          and safe_cast( json_extract_scalar( currencies , "$.DICE") as numeric) = 0
          then 1 else 0 end
        + case
          when event_name = 'ButtonClicked'
          and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) = 'Sheet_LuckyDice.Roll'
          and safe_cast( json_extract_scalar( currencies , "$.DICE") as numeric) = 0
          then 1 else 0 end

           as estimate_ad_placements_luckydice

        -- Treasure Trove
        -- Ads Treasure Trove

        -- Rocket
        , case
          when event_name = 'ButtonClicked'
          and
            ( safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%.Play'
              or safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%.PlayFromFeature'
              or safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%.PlayFromQuest'
            )
          and safe_cast(json_extract_scalar(extra_json, "$.path") as string) not like '%Start Round'
          and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) not like '%PreGame%'
          and safe_cast( json_extract_scalar( tickets , "$.ROCKET") as numeric) = 0
          then 1 else 0 end as estimate_ad_placements_rocket

        -- Daily Reward (We're not going to do this one)

        from
            base_data
    )

      ------------------------------------------------------------------------
      -- Summary by date
      ------------------------------------------------------------------------

    , summarized_by_date as (

      SELECT
        rdg_date
        , rdg_id
        , max(device_id) as device_id
        , max(advertising_id) as advertising_id
        , max(user_id) as user_id
        , max(bfg_uid) as bfg_uid
        , max(display_name) as display_name
        , max(platform) as platform
        , max(country) as country
        , max(created_utc) as created_utc
        , max(created_date) as created_date
        , max(experiments) as experiments
        , max(version) as version
        , max(install_version) as install_version
        , sum(mtx_purchase_dollars) as mtx_purchase_dollars
        , sum(mtx_purchase_dollars_15) as mtx_purchase_dollars_15
        , sum(ad_view_dollars) as ad_view_dollars
        , max(safe_cast( ( mtx_ltv_from_data_in_cents * 0.01 * 0.70 ) as numeric)) as mtx_ltv_from_data -- Includes app store adjustment
        , sum(ad_view_indicator) as ad_views
        , count(distinct session_id) as count_sessions
        , max(engagement_ticks) as cumulative_engagement_ticks
        , sum(round_start_events) as round_start_events

        , sum(round_end_events) as round_end_events
        , sum(round_end_events_campaign) as round_end_events_campaign
        , sum(round_end_events_movesmaster) as round_end_events_movesmaster
        , sum(round_end_events_puzzle) as round_end_events_puzzle
        , sum(round_end_events_gemquest) as round_end_events_gemquest
        , sum(round_win_events_gemquest) as round_win_events_gemquest
        , sum(round_end_events_askforhelp) as round_end_events_askforhelp
        , sum(round_end_events_gofish) as round_end_events_gofish
        , sum(gofish_full_matches_completed) as gofish_full_matches_completed
        , sum(gofish_full_matches_won) as gofish_full_matches_won

        , sum(round_time_in_minutes) as round_time_in_minutes
        , sum(round_time_in_minutes_campaign) as round_time_in_minutes_campaign
        , sum(round_time_in_minutes_movesmaster) as round_time_in_minutes_movesmaster
        , sum(round_time_in_minutes_puzzle) as round_time_in_minutes_puzzle
        , sum(round_time_in_minutes_askforhelp) as round_time_in_minutes_askforhelp
        , sum(round_time_in_minutes_gofish) as round_time_in_minutes_gofish

        , min(last_level_serial) as lowest_last_level_serial
        , max(last_level_serial) as highest_last_level_serial
        , max(gofish_rank) as max_gofish_rank

        , sum(coins_spend) as coins_spend
        , sum(coins_sourced_from_rewards) as coins_sourced_from_rewards
        , sum(stars_spend) as stars_spend

        , round(avg(coins_balance),0) as ending_coins_balance
        , round(avg(lives_balance),0) as ending_lives_balance
        , round(avg(stars_balance),0) as ending_stars_balance
        , round(avg(dice_balance),0) as dice_balance
        , round(avg(ticket_balance),0) as ticket_balance
        , max(secret_eggs) as secret_eggs

        -- system_info
        , max( hardware ) as hardware
        , max( processor_type ) as processor_type
        , max( graphics_device_name ) as graphics_device_name
        , max( device_model ) as device_model
        , max( system_memory_size ) as system_memory_size
        , max( graphics_memory_size ) as graphics_memory_size
        , max( screen_width ) as screen_width
        , max( screen_height ) as screen_height

        -- other progression info
        , max( end_of_content_levels ) as end_of_content_levels
        , max( end_of_content_zones ) as end_of_content_zones
        , max( current_zone ) as current_zone

        -- feature participation
        , max( feature_participation_daily_reward ) as feature_participation_daily_reward
        , max( feature_participation_daily_reward_day_7_completed ) as feature_participation_daily_reward_day_7_completed
        , max( feature_participation_pizza_time ) as feature_participation_pizza_time
        , max( feature_participation_flour_frenzy ) as feature_participation_flour_frenzy
        , max( feature_participation_lucky_dice ) as feature_participation_lucky_dice
        , max( feature_participation_treasure_trove ) as feature_participation_treasure_trove
        , max( feature_participation_battle_pass ) as feature_participation_battle_pass
        , max( feature_participation_ask_for_help_request ) as feature_participation_ask_for_help_request
        , max( feature_participation_ask_for_help_completed ) as feature_participation_ask_for_help_completed
        , max( feature_participation_ask_for_help_high_five ) as feature_participation_ask_for_help_high_five
        , max( feature_participation_ask_for_help_high_five_return ) as feature_participation_ask_for_help_high_five_return
        , max( feature_participation_hot_dog_contest ) as feature_participation_hot_dog_contest
        , max( feature_participation_castle_climb ) as feature_participation_castle_climb
        , max( feature_participation_donut_sprint ) as feature_participation_donut_sprint
        , max( feature_participation_food_truck ) as feature_participation_food_truck

        -- feature completion
        , max( feature_completion_castle_climb ) as feature_completion_castle_climb
        , max( feature_completion_gem_quest ) as feature_completion_gem_quest
        , max( feature_completion_puzzle ) as feature_completion_puzzle

        -- ask for help counts
        , sum( feature_participation_ask_for_help_request ) as count_ask_for_help_request
        , sum( feature_participation_ask_for_help_completed ) as count_ask_for_help_completed
        , sum( feature_participation_ask_for_help_high_five ) as count_ask_for_help_high_five
        , sum( feature_participation_ask_for_help_high_five_return ) as count_ask_for_help_high_five_return

        -- errors
        , sum(errors_low_memory_warning) as errors_low_memory_warning
        , sum(errors_null_reference_exception) as errors_null_reference_exception

        -- average load times
        , safe_cast( round( safe_divide( sum( load_time_all ) , sum( load_time_count_all ) ) , 0 ) as int64 ) as average_load_time_all
        , safe_cast( round( safe_divide( sum( load_time_from_title_scene ) , sum( load_time_count_from_title_scene ) ) , 0 ) as int64 )  as average_load_time_from_title_scene
        , safe_cast( round( safe_divide( sum( load_time_from_meta_scene ) , sum( load_time_count_from_meta_scene ) ) , 0 ) as int64 )  as average_load_time_from_meta_scene
        , safe_cast( round( safe_divide( sum( load_time_from_game_scene ) , sum( load_time_count_from_game_scene ) ) , 0 ) as int64 )  as average_load_time_from_game_scene
        , safe_cast( round( safe_divide( sum( load_time_from_app_start ) , sum( load_time_count_from_app_start ) ) , 0 ) as int64 )  as average_load_time_from_app_start
        , max( low_render_perf_count ) as low_render_perf_count

        -- possible crashes from fast screen title awakes
        , sum( count_possible_crashes_from_fast_title_screen_awake ) as count_possible_crashes_from_fast_title_screen_awake

        -- ending boost balances
        , round(max(balance_rocket),0) as ending_balance_rocket
        , round(max(balance_bomb),0) as ending_balance_bomb
        , round(max(balance_color_ball),0) as ending_balance_color_ball
        , round(max(balance_clear_cell),0) as ending_balance_clear_cell
        , round(max(balance_clear_horizontal),0) as ending_balance_clear_horizontal
        , round(max(balance_clear_vertical),0) as ending_balance_clear_vertical
        , round(max(balance_shuffle),0) as ending_balance_shuffle
        , round(max(balance_chopsticks),0) as ending_balance_chopsticks
        , round(max(balance_skillet),0) as ending_balance_skillet
        , round(max(balance_moves),0) as ending_balance_moves
        , round(max(balance_disco),0) as ending_balance_disco

        -------------------------------------------------
        -- Chum Skills Used
        -------------------------------------------------

        , sum(powerup_hammer) as powerup_hammer
        , sum(powerup_rolling_pin) as powerup_rolling_pin
        , sum(powerup_piping_bag) as powerup_piping_bag
        , sum(powerup_shuffle) as powerup_shuffle
        , sum(powerup_chopsticks) as powerup_chopsticks
        , sum(powerup_skillet) as powerup_skillet
        , sum(
            powerup_hammer
            + powerup_rolling_pin
            + powerup_piping_bag
            + powerup_shuffle
            + powerup_chopsticks
            + powerup_skillet
            ) as total_chum_powerups_used

        -------------------------------------------------
        -- Pre Game Boosts
        -------------------------------------------------

        , sum( pregame_boost_rocket ) as pregame_boost_rocket
        , sum( pregame_boost_bomb ) as pregame_boost_bomb
        , sum( pregame_boost_colorball ) as pregame_boost_colorball
        , sum( pregame_boost_extramoves ) as pregame_boost_extramoves

        -------------------------------------------------
        -- Daily Popup (step 2)
        -------------------------------------------------

        , max( case when daily_popup_category = 'BattlePass' then daily_popup_action else null end ) as daily_popup_BattlePass
        , max( case when daily_popup_category = 'DailyReward' then daily_popup_action else null end ) as daily_popup_DailyReward
        , max( case when daily_popup_category = 'FlourFrenzy' then daily_popup_action else null end ) as daily_popup_FlourFrenzy
        , max( case when daily_popup_category = 'GoFish' then daily_popup_action else null end ) as daily_popup_GoFish
        , max( case when daily_popup_category = 'HotdogContest' then daily_popup_action else null end ) as daily_popup_HotdogContest
        , max( case when daily_popup_category = 'LuckyDice' then daily_popup_action else null end ) as daily_popup_LuckyDice
        , max( case when daily_popup_category = 'MovesMaster' then daily_popup_action else null end ) as daily_popup_MovesMaster
        , max( case when daily_popup_category = 'PizzaTime' then daily_popup_action else null end ) as daily_popup_PizzaTime
        , max( case when daily_popup_category = 'Puzzle' then daily_popup_action else null end ) as daily_popup_Puzzle
        , max( case when daily_popup_category = 'TreasureTrove' then daily_popup_action else null end ) as daily_popup_TreasureTrove
        , max( case when daily_popup_category = 'UpdateApp' then daily_popup_action else null end ) as daily_popup_UpdateApp
        , max( case when daily_popup_category = 'CastleClimb' then daily_popup_action else null end ) as daily_popup_CastleClimb
        , max( case when daily_popup_category = 'GemQuest' then daily_popup_action else null end ) as daily_popup_GemQuest
        , max( case when daily_popup_category = 'DonutSprint' then daily_popup_action else null end ) as daily_popup_DonutSprint

        -- Estimate Ad Placements
        , sum( estimate_ad_placements_movesmaster ) as estimate_ad_placements_movesmaster
        , sum( estimate_ad_placements_battlepass ) as estimate_ad_placements_battlepass
        , sum( estimate_ad_placements_gofish ) as estimate_ad_placements_gofish
        , sum( estimate_ad_placements_puzzle ) as estimate_ad_placements_puzzle
        , sum( estimate_ad_placements_lives ) as estimate_ad_placements_lives
        , max( estimate_ad_placements_pizzatime ) as estimate_ad_placements_pizzatime -- NOTE: capping at 1 for this one
        , sum( estimate_ad_placements_luckydice ) as estimate_ad_placements_luckydice
        , sum( estimate_ad_placements_rocket ) as estimate_ad_placements_rocket

      from
        pre_aggregate_calculations_from_base_data
      group by
        1,2

    )

    ------------------------------------------------------------------------
    -- Add on histogram
    ------------------------------------------------------------------------

    , add_on_histogram_table as (

    select
        a.*
        , b.percent_frames_below_22
        , b.percent_frames_between_23_and_40
        , b.percent_frames_above_40
        , c.average_asset_load_time
    from
        summarized_by_date a
        left join frame_rate_histogram_collapse b
            on a.rdg_id = b.rdg_id
            and a.rdg_date = b.rdg_date
        left join average_asset_load_times c
            on a.rdg_id = c.rdg_id
            and a.rdg_date = c.rdg_date

    )

    ------------------------------------------------------------------------
    -- summary
    ------------------------------------------------------------------------

    select * from add_on_histogram_table

    -- select
    --    date(rdg_date) as rdg_date
    --     , sum( feature_participation_daily_reward_day_7_completed ) as feature_participation_daily_reward_day_7_completed


    -- from
    --   add_on_histogram_table
    -- group by
    --   1
    -- order by
    --   1

      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -120 minute)) ;;

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
    ;;
  primary_key: yes
  hidden: yes
}



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
