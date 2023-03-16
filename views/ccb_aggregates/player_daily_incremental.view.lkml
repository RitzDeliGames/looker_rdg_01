view: player_daily_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-03-16'

--create or replace table tal_scratch.player_daily_incremental as

      WITH

      ------------------------------------------------------------------------
      -- player_daily_incremental
      ------------------------------------------------------------------------
      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      base_data AS (

        SELECT
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
        FROM
          `eraser-blast.game_data.events` a
        WHERE
          ------------------------------------------------------------------------
          -- Date selection
          -- We use this because the FIRST time we run this query we want all the data going back
          -- but future runs we only want the last 9 days
          ------------------------------------------------------------------------
          DATE(timestamp) >=
            CASE
              -- SELECT DATE(CURRENT_DATE())
              WHEN DATE(CURRENT_DATE()) <= '2023-03-16' -- Last Full Update
              THEN '2022-06-01'
              ELSE DATE_ADD(CURRENT_DATE(), INTERVAL -9 DAY)
              END
          AND DATE(timestamp) <= DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY)

          ------------------------------------------------------------------------
          -- user type selection
          -- We only want users that are marked as "external"
          -- This removes any bots or internal QA accounts
          ------------------------------------------------------------------------
          AND user_type = 'external'
      )

      -- SELECT * FROM base_data

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
          , FIRST_VALUE(install_version) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) install_version

          -------------------------------------------------
          -- Dollar Events
          -------------------------------------------------

          -- mtx purchase dollars
          , CAST(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_01' -- real dollars
              AND (
                JSON_EXTRACT_SCALAR(extra_json,"$.rvs_id") LIKE '%GPA%' -- check for valid transactions on Google Play
                OR JSON_EXTRACT_SCALAR(extra_json,"$.rvs_id") LIKE '%AppleAppStore%' -- check for valid transactions on Apple
                )
              THEN IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS NUMERIC) * 0.01 * 0.70 ,0) -- purchase amount + app store cut
              ELSE 0
              END AS NUMERIC) AS mtx_purchase_dollars

          -- ad view dollars
          , CAST(CASE
              WHEN event_name = 'ad'
              THEN
                IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.publisher_revenue_per_impression") AS NUMERIC),0) -- revenue per impression
                + IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.revenue") AS NUMERIC),0) -- revenue per impression
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
          , CAST(CASE
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
          , CAST(CASE
              WHEN event_name = 'round_start'
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_start_events

        --------------------------------------------------------------
        -- round end events
        --------------------------------------------------------------

          -- round end events
          , CAST(CASE
              WHEN event_name = 'round_end'
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events

          -- round end events - campaign
          , CAST(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'CAMPAIGN', 'campaign'
                )
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events_campaign

        -- round end events - campaign
          , CAST(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'movesMaster'
                )
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events_movesmaster

        -- round end events - puzzle
          , CAST(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'puzzle'
                )
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events_puzzle

        --------------------------------------------------------------
        -- round time events
        --------------------------------------------------------------

          -- round end events
          , CAST(CASE
              WHEN event_name = 'round_end'
              THEN ifnull( cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes

          -- round end events - campaign
          , CAST(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'CAMPAIGN', 'campaign'
                )
              THEN ifnull( cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes_campaign

        -- round end events - campaign
          , CAST(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'movesMaster'
                )
              THEN ifnull( cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes_movesmaster

        -- round end events - puzzle
          , CAST(CASE
              WHEN
                event_name = 'round_end'
                and safe_cast(json_extract_scalar(extra_json, "$.game_mode") as string) IN (
                    'puzzle'
                )
              THEN ifnull( cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 )
              ELSE 0
              END AS INT64) AS round_time_in_minutes_puzzle

          -- Lowest Last level serial recorded
          , MIN(IFNULL(CAST(last_level_serial AS INT64),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              )
              AS lowest_last_level_serial

          -- Highest Last level serial recorded
          , MAX(IFNULL(CAST(last_level_serial AS INT64),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS highest_last_level_serial

          -- Highest quests completed recorded
          , MAX(CAST(quests_completed AS INT64)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS highest_quests_completed

          -------------------------------------------------
          -- currency spend info
          -------------------------------------------------

          -- gems_spend
          , CAST(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_02' -- gems
              THEN IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS gems_spend

          -- coins spend
          , CAST(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_03' -- coins currency
              THEN IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS coins_spend

          -- lives spend
          -- NOTE: I'm currently just estimating this using a round end at a loss
          -- This may be incorrect if the round end does not cost a life
          -- , CAST(CASE
          --     WHEN event_name = 'round_end'
          --     AND IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.proximity_to_completion") AS NUMERIC),1) < 1 -- Incomplete Round
          --     THEN 1
          --     ELSE 0
          --     END AS INT64) AS lives_spend

          -- star spend
          , CAST(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_07' -- star currency
              THEN IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS stars_spend

          -------------------------------------------------
          -- ending currency balances
          -------------------------------------------------

          -- ending_gems_balance
          , LAST_VALUE(IFNULL(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_02") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_gems_balance

          -- ending_coins_balance
          , LAST_VALUE(IFNULL(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_03") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_coins_balance

          -- ending_lives_balance
          , LAST_VALUE(IFNULL(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_04") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_lives_balance

          -- ending_stars_balance
          , LAST_VALUE(IFNULL(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_07") AS NUMERIC),0)) OVER (
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

        FROM
            base_data
    )

      ------------------------------------------------------------------------
      -- Summary
      ------------------------------------------------------------------------

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
        , MAX(CAST( ( mtx_ltv_from_data_in_cents * 0.01 * 0.70 )  AS NUMERIC)) AS mtx_ltv_from_data -- Includes app store adjustment
        , SUM(ad_view_indicator) AS ad_views
        , COUNT(DISTINCT session_id) AS count_sessions
        , MAX(cumulative_session_count) AS cumulative_session_count
        , MAX(cumulative_engagement_ticks) AS cumulative_engagement_ticks
        , SUM(round_start_events) AS round_start_events

        , SUM(round_end_events) AS round_end_events
        , SUM(round_end_events_campaign) AS round_end_events_campaign
        , SUM(round_end_events_movesmaster) AS round_end_events_movesmaster
        , SUM(round_end_events_puzzle) AS round_end_events_puzzle
        , SUM(round_time_in_minutes) AS round_time_in_minutes
        , SUM(round_time_in_minutes_campaign) AS round_time_in_minutes_campaign
        , SUM(round_time_in_minutes_movesmaster) AS round_time_in_minutes_movesmaster
        , SUM(round_time_in_minutes_puzzle) AS round_time_in_minutes_puzzle

        , MAX(lowest_last_level_serial) AS lowest_last_level_serial
        , MAX(highest_last_level_serial) AS highest_last_level_serial
        , MAX(highest_quests_completed) AS highest_quests_completed
        , SUM(gems_spend) AS gems_spend
        , SUM(coins_spend) AS coins_spend
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

      from
        pre_aggregate_calculations_from_base_data
      group by
        1,2


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
