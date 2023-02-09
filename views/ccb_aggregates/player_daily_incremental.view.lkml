view: player_daily_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

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
              WHEN DATE(CURRENT_DATE()) <= '2023-02-09' -- Last Full Update
              THEN '2023-01-01'
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
              THEN IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS NUMERIC) / 100,0) -- purchase amount
              ELSE 0
              END AS NUMERIC) AS mtx_purchase_dollars

          -- ad view dollars
          , CAST(CASE
              WHEN event_name = 'ad'
              THEN IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.publisher_revenue_per_impression") AS NUMERIC),0) -- revenue per impression
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

          -- round end events
          , CAST(CASE
              WHEN event_name = 'round_end'
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events

          -- Lowest Last level serial recorded
          , MIN(CAST(last_level_serial AS INT64)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              )
              AS lowest_last_level_serial

          -- Highest Last level serial recorded
          , MAX(CAST(last_level_serial AS INT64)) OVER (
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
          , LAST_VALUE(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_02") AS NUMERIC)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_gems_balance

          -- ending_coins_balance
          , LAST_VALUE(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_03") AS NUMERIC)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_coins_balance

          -- ending_lives_balance
          , LAST_VALUE(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_04") AS NUMERIC)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_lives_balance

          -- ending_stars_balance
          , LAST_VALUE(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_07") AS NUMERIC)) OVER (
              PARTITION BY rdg_id, DATE(timestamp_utc)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_stars_balance

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
        , MAX(platform) AS platform
        , MAX(country) AS country
        , MAX(created_utc) AS created_utc
        , MAX(created_date) AS created_date
        , MAX(experiments) AS experiments
        , MAX(version) AS version
        , MAX(install_version) AS install_version
        , SUM(mtx_purchase_dollars) AS mtx_purchase_dollars
        , SUM(ad_view_dollars) AS ad_view_dollars
        , MAX(CAST(mtx_ltv_from_data_in_cents/100 AS NUMERIC)) AS ltv_data
        , SUM(ad_view_indicator) AS ad_views
        , MAX(cumulative_session_count) AS cumulative_session_count
        , MAX(cumulative_engagement_ticks) AS cumulative_engagement_ticks
        , SUM(round_start_events) AS round_start_events
        , SUM(round_end_events) AS round_end_events
        , MAX(lowest_last_level_serial) AS lowest_last_level_serial
        , MAX(highest_last_level_serial) AS highest_last_level_serial
        , MAX(highest_quests_completed) AS highest_quests_completed
        , SUM(gems_spend) AS gems_spend
        , SUM(coins_spend) AS coins_spend
        --, SUM(lives_spend) AS lives_spend
        , SUM(stars_spend) AS stars_spend
        , MAX(ending_gems_balance) AS ending_gems_balance
        , MAX(ending_coins_balance) AS ending_coins_balance
        , MAX(ending_lives_balance) AS ending_lives_balance
        , MAX(ending_stars_balance) AS ending_stars_balance
      FROM
        pre_aggregate_calculations_from_base_data
      GROUP BY
        1,2

      ;;
    datagroup_trigger: incremental_daily_group
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
    increment_key: "rdg_date"
    increment_offset: 7

  }
  #
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
