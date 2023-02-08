view: player_summary_by_day_test {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

        WITH

        ------------------------------------------------------------------------
        -- Full Selection w/ Window Calculations
        ------------------------------------------------------------------------

        FullSelectionWithWindowCalculations AS (

          SELECT
            TIMESTAMP(DATE(timestamp)) AS rdg_date
            , rdg_id
            , timestamp
            , FIRST_VALUE(device_id) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) device_id
            , FIRST_VALUE(advertising_id) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) advertising_id
            , FIRST_VALUE(user_id) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) user_id
            , FIRST_VALUE(platform) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) platform
            , FIRST_VALUE(country) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) country
            , LAST_VALUE(ltv) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) ltv
            , FIRST_VALUE(created_at) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) created_at
            , LAST_VALUE(session_id) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) last_session_id
            , LAST_VALUE(session_count) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) lifetime_sessions
            , LAST_VALUE(timestamp) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) last_timestamp
            , MIN(CAST(last_level_serial AS INT64)) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) first_level_serial
            , MAX(CAST(last_level_serial AS INT64)) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) last_level_serial
            , LAST_VALUE(CAST(engagement_ticks AS INT64)) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) engagement_ticks
            , LAST_VALUE(version) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) version
            , FIRST_VALUE(install_version) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) install_version
            , LAST_VALUE(
              CAST(JSON_EXTRACT_SCALAR(extra_json,"$.config_timestamp") AS NUMERIC))
              OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC)
              AS last_config_timestamp
            , FIRST_VALUE(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.config_timestamp") AS NUMERIC))
              OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC)
              AS first_config_timestamp
            , LAST_VALUE(days_played_past_week) OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC) days_played_past_week
            , PERCENTILE_CONT(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_03") AS NUMERIC), 0.5)
                OVER (PARTITION BY rdg_id, DATE(timestamp))
                AS daily_median_coin_balance
            , PERCENTILE_CONT(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_04") AS NUMERIC), 0.5)
                OVER (PARTITION BY rdg_id, DATE(timestamp))
                AS daily_median_life_balance
            , PERCENTILE_CONT(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_07") AS NUMERIC), 0.5)
                OVER (PARTITION BY rdg_id, DATE(timestamp))
                AS daily_median_star_balance
            , LAST_VALUE(CAST(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_03") AS NUMERIC))
                OVER (PARTITION BY rdg_id, DATE(timestamp) ORDER BY timestamp ASC)
                AS daily_ending_coin_balance
          FROM
            `eraser-blast.game_data.events`
          WHERE
            DATE(timestamp) >=
              CASE
                WHEN DATE(CURRENT_DATE()) <= '2023-02-08' -- Last Full Update
                THEN '2023-01-01'
                ELSE DATE_ADD(CURRENT_DATE(), INTERVAL -9 DAY)
                END
            AND DATE(timestamp) <= DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY)
            AND user_type = 'external'
        )

        ------------------------------------------------------------------------
        -- Convert to By Date
        ------------------------------------------------------------------------

        SELECT
          rdg_date
          , rdg_id
          , MAX(device_id) AS device_id
          , MAX(advertising_id) AS advertising_id
          , MAX(user_id) AS user_id
          , MAX(platform) AS platform
          , MAX(country) AS country
          , MAX(ltv) AS ltv
          , MAX(created_at) AS created_at
          , MAX(datetime(created_at,'US/Pacific')) AS created_pst
          , MAX(last_session_id) AS last_session_id
          , MAX(lifetime_sessions) AS lifetime_sessions
          , MAX(last_timestamp) AS last_timestamp
          , MAX(first_level_serial) AS first_level_serial
          , MAX(last_level_serial) AS last_level_serial
          , MAX(engagement_ticks) AS engagement_ticks
          , MAX(version) AS version
          , MAX(install_version) AS install_version
          , MAX(first_config_timestamp) AS first_config_timestamp
          , MAX(days_played_past_week) AS days_played_past_week_from_data
          , MAX(daily_median_coin_balance) AS daily_median_coin_balance
          , MAX(daily_median_life_balance) AS daily_median_life_balance
          , MAX(daily_median_star_balance) AS daily_median_star_balance
          , MAX(daily_ending_coin_balance) AS daily_ending_coin_balance

        FROM
          FullSelectionWithWindowCalculations
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

  #
  dimension: rdg_id {
    description: "Ritz Deli Game ID"
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  #
  dimension: country {
    description: "Ritz Deli Game ID"
    type: string
    sql: ${TABLE}.country ;;
  }
  #
  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
  #
  # set: detail {
  #   fields: [
  #     first_country_by_day
  #   ]
  # }
}
