view: player_daily_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-08-29'

-- create or replace table tal_scratch.player_daily_incremental as

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

        date(timestamp) >=
            case
                -- select date(current_date())
                when date(current_date()) <= '2023-08-29' -- Last Full Update
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
        -- check my data
        -- this is adhoc if I want to check a query with my own data
        ------------------------------------------------------------------------

        -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'
        -- and date(timestamp) = '2023-08-14'

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

          TIMESTAMP(DATE(timestamp_utc)) AS rdg_date
          , rdg_id

          -------------------------------------------------
          -- General player info
          -------------------------------------------------

          , event_name

          -- device_id
          , FIRST_VALUE(device_id) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) device_id

          -- advertising_id
          , FIRST_VALUE(advertising_id) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) advertising_id

          -- user_id
          , FIRST_VALUE(user_id) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) user_id

          -- platform
          , FIRST_VALUE(platform) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) platform

          -- country
          , FIRST_VALUE(country) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) country

          -- created_utc
          , FIRST_VALUE(created_at) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) created_utc

          -- created_date
          , FIRST_VALUE(DATE(created_at)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) created_date

          -- experiements
          -- uses LAST value rather than first value
          , LAST_VALUE(experiments) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) experiments

          -- display_name
          -- uses LAST value rather than first value
          , LAST_VALUE(display_name) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) display_name

          -- version
          -- uses LAST value rather than first value
          , LAST_VALUE(version) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) version

          -- install_version
          , LAST_VALUE(install_version) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) install_version

          -------------------------------------------------
          -- Dollar Events
          -------------------------------------------------

          -- mtx purchase dollars
          , safe_cast(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_01' -- real dollars
              AND (
                JSON_EXTRACT_SCALAR(extra_json,"$.rvs_id") LIKE '%GPA%' -- check for valid transactions on Google Play
                OR JSON_EXTRACT_SCALAR(extra_json,"$.rvs_id") LIKE '%AppleAppStore%' -- check for valid transactions on Apple
                )
              THEN IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS NUMERIC) * 0.01 * 0.70 ,0) -- purchase amount + app store cut
              ELSE 0
              END AS NUMERIC) AS mtx_purchase_dollars

          -- ad view dollars
          , safe_cast(CASE
              WHEN event_name = 'ad'
              THEN
                IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.publisher_revenue_per_impression") AS NUMERIC),0) -- revenue per impression
                + IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.revenue") AS NUMERIC),0) -- revenue per impression
              ELSE 0
              END AS NUMERIC) AS ad_view_dollars

          -- ltv from data (for checking)
          , LAST_VALUE(ltv) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) mtx_ltv_from_data_in_cents

          -------------------------------------------------
          -- additional ads information
          -------------------------------------------------

          -- ad views
          , safe_cast(CASE
              WHEN event_name = 'ad'
              THEN 1 -- revenue per impression
              ELSE 0
              END AS INT64) AS ad_view_indicator

          -------------------------------------------------
          -- session/play info
          -------------------------------------------------

          -- session_id (for count distinct sessions played)
          , session_id

          -- cumulative session count
          , LAST_VALUE(session_count) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) cumulative_session_count

          -- cumulative engagement ticks
          , LAST_VALUE(engagement_ticks) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) cumulative_engagement_ticks

          -- round start events
          , safe_cast(CASE
              WHEN event_name = 'round_start'
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_start_events

        --------------------------------------------------------------
        -- round end events
        --------------------------------------------------------------

          -- round end events
          , safe_cast(CASE
              WHEN event_name = 'round_end'
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events

          -- round end events - campaign
          , safe_cast(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'CAMPAIGN', 'campaign'
                )
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events_campaign

        -- round end events - campaign
          , safe_cast(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'movesMaster'
                )
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events_movesmaster

        -- round end events - puzzle
          , safe_cast(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'puzzle'
                )
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events_puzzle

        -- round end events - ask for help
          , safe_cast(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'helpRequest'
                )
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events_askforhelp


        --------------------------------------------------------------
        -- round time events
        --------------------------------------------------------------

          -- round end events
          , safe_cast(CASE
              WHEN event_name = 'round_end'
              THEN ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes

          -- round end events - campaign
          , safe_cast(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'CAMPAIGN', 'campaign'
                )
              THEN ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes_campaign

        -- round end events - campaign
          , safe_cast(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'movesMaster'
                )
              THEN ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes_movesmaster

        -- round end events - puzzle
          , safe_cast(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'puzzle'
                )
              THEN ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes_puzzle

        -- round end events - askforhelp
          , safe_cast(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'helpRequest'
                )
              THEN ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes_askforhelp


          -- Lowest Last level serial recorded
          , MIN(IFNULL(safe_cast(last_level_serial AS INT64),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              )
              AS lowest_last_level_serial

          -- Highest Last level serial recorded
          , MAX(IFNULL(safe_cast(last_level_serial AS INT64),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS highest_last_level_serial

          -- Highest quests completed recorded
          , MAX(safe_cast(quests_completed AS INT64)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS highest_quests_completed

          -------------------------------------------------
          -- currency spend info
          -------------------------------------------------

          -- gems_spend
          , safe_cast(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_02' -- gems
              THEN IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS gems_spend

          -- coins spend
          , safe_cast(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_03' -- coins currency
              THEN IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS coins_spend

          -- coins from rewards
          , safe_cast( case
            when event_name = 'reward'
            and json_extract_scalar(extra_json,"$.reward_type") = 'CURRENCY_03'
            then ifnull(safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric),0)
            else 0
            end as int64 ) as coins_sourced_from_rewards

          -- star spend
          , safe_cast(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_07' -- star currency
              THEN IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS stars_spend

          -------------------------------------------------
          -- ending currency balances
          -------------------------------------------------

          -- ending_gems_balance
          , LAST_VALUE(IFNULL(safe_cast(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_02") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_gems_balance

          -- ending_coins_balance
          , LAST_VALUE(IFNULL(safe_cast(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_03") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_coins_balance

          -- ending_lives_balance
          , LAST_VALUE(IFNULL(safe_cast(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_04") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_lives_balance

          -- ending_stars_balance
          , LAST_VALUE(IFNULL(safe_cast(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_07") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_stars_balance

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

        , last_value(end_of_content_levels) over (
            partition by rdg_id, date(timestamp_utc)
            order by timestamp_utc asc
            rows between unbounded preceding and unbounded following
            ) end_of_content_levels

        , last_value(end_of_content_zones) over (
            partition by rdg_id, date(timestamp_utc)
            order by timestamp_utc asc
            rows between unbounded preceding and unbounded following
            ) end_of_content_zones

        , last_value(current_zone) over (
            partition by rdg_id, date(timestamp_utc)
            order by timestamp_utc asc
            rows between unbounded preceding and unbounded following
            ) current_zone

        , last_value(current_zone_progress) over (
            partition by rdg_id, date(timestamp_utc)
            order by timestamp_utc asc
            rows between unbounded preceding and unbounded following
            ) current_zone_progress

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


        -------------------------------------------------
        -- Errors
        -------------------------------------------------

          , safe_cast(case
              when
                event_name = 'errors'
                and safe_cast(json_extract(extra_json,'$.logs') as string) like '%low memory warning%'
              then 1
              else 0
              end as int64) as errors_low_memory_warning

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

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.ROCKET") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_rocket

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.BOMB") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_bomb

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.COLOR_BALL") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_color_ball

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.clear_cell") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_clear_cell

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.clear_horizontal") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_clear_horizontal

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.clear_vertical") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_clear_vertical

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.shuffle") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_shuffle

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.chopsticks") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_chopsticks

        , last_value(ifnull(safe_cast(json_extract_scalar(tickets,"$.skillet") as numeric),0)) over (
        partition by rdg_id, date(timestamp_utc)
        order by timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) as ending_balance_skillet

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
        , MAX(device_id) AS device_id
        , MAX(advertising_id) AS advertising_id
        , MAX(user_id) AS user_id
        , max(display_name) as display_name
        , MAX(platform) AS platform
        , MAX(country) AS country
        , MAX(created_utc) AS created_utc
        , MAX(created_date) AS created_date
        , MAX(experiments) AS experiments
        , MAX(version) AS version
        , MAX(install_version) AS install_version
        , SUM(mtx_purchase_dollars) AS mtx_purchase_dollars
        , SUM(ad_view_dollars) AS ad_view_dollars
        , MAX(safe_cast( ( mtx_ltv_from_data_in_cents * 0.01 * 0.70 )  AS NUMERIC)) AS mtx_ltv_from_data -- Includes app store adjustment
        , SUM(ad_view_indicator) AS ad_views
        , COUNT(DISTINCT session_id) AS count_sessions
        , MAX(cumulative_session_count) AS cumulative_session_count
        , MAX(cumulative_engagement_ticks) AS cumulative_engagement_ticks
        , SUM(round_start_events) AS round_start_events

        , SUM(round_end_events) AS round_end_events
        , SUM(round_end_events_campaign) AS round_end_events_campaign
        , SUM(round_end_events_movesmaster) AS round_end_events_movesmaster
        , SUM(round_end_events_puzzle) AS round_end_events_puzzle
        , SUM(round_end_events_askforhelp) AS round_end_events_askforhelp

        , SUM(round_time_in_minutes) AS round_time_in_minutes
        , SUM(round_time_in_minutes_campaign) AS round_time_in_minutes_campaign
        , SUM(round_time_in_minutes_movesmaster) AS round_time_in_minutes_movesmaster
        , SUM(round_time_in_minutes_puzzle) AS round_time_in_minutes_puzzle
        , SUM(round_time_in_minutes_askforhelp) AS round_time_in_minutes_askforhelp

        , MAX(lowest_last_level_serial) AS lowest_last_level_serial
        , MAX(highest_last_level_serial) AS highest_last_level_serial
        , MAX(highest_quests_completed) AS highest_quests_completed
        , SUM(gems_spend) AS gems_spend
        , SUM(coins_spend) AS coins_spend
        , sum(coins_sourced_from_rewards) as coins_sourced_from_rewards
        , SUM(stars_spend) AS stars_spend
        , MAX(ending_gems_balance) AS ending_gems_balance
        , MAX(ending_coins_balance) AS ending_coins_balance
        , MAX(ending_lives_balance) AS ending_lives_balance
        , MAX(ending_stars_balance) AS ending_stars_balance

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
        , max( current_zone_progress ) as current_zone_progress

        -- feature participation
        , max( feature_participation_daily_reward ) as feature_participation_daily_reward
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

        -- possible crashes from fast screen title awakes
        , sum( count_possible_crashes_from_fast_title_screen_awake ) as count_possible_crashes_from_fast_title_screen_awake

        -- ending boost balances
        , max( ending_balance_rocket ) as ending_balance_rocket
        , max( ending_balance_bomb ) as ending_balance_bomb
        , max( ending_balance_color_ball ) as ending_balance_color_ball
        , max( ending_balance_clear_cell ) as ending_balance_clear_cell
        , max( ending_balance_clear_horizontal ) as ending_balance_clear_horizontal
        , max( ending_balance_clear_vertical ) as ending_balance_clear_vertical
        , max( ending_balance_shuffle ) as ending_balance_shuffle
        , max( ending_balance_chopsticks ) as ending_balance_chopsticks
        , max( ending_balance_skillet ) as ending_balance_skillet

      from
        pre_aggregate_calculations_from_base_data
      group by
        1,2

    )

    ------------------------------------------------------------------------
    -- Add on histogram
    ------------------------------------------------------------------------

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
