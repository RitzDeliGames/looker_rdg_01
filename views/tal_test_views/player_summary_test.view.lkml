view: player_summary_test {
# # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- old version
      -- select sum(1) as count_rows from ${player_summary_by_day_test.SQL_TABLE_NAME}

      WITH

      ------------------------------------------------------------------------
      -- Full Selection w/ Window Calculations
      ------------------------------------------------------------------------

      FullSelectionWithWindowCalculations AS (

      SELECT
        rdg_id
        , LAST_VALUE(device_id) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_device_id
        , LAST_VALUE(advertising_id) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_advertising_id
        , LAST_VALUE(user_id) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_user_id
        , FIRST_VALUE(platform) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS first_platform
        , FIRST_VALUE(country) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS first_country
        , LAST_VALUE(ltv) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS current_ltv
        , FIRST_VALUE(created_at) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS created_at
        , FIRST_VALUE(created_pst) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS created_pst
        , LAST_VALUE(last_session_id) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_session_id
        , LAST_VALUE(lifetime_sessions) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS lifetime_sessions
        , LAST_VALUE(last_timestamp) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_timestamp
        , LAST_VALUE(last_level_serial) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_level_serial
        , LAST_VALUE(engagement_ticks) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS total_engagement_ticks
        , LAST_VALUE(version) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_version
        , FIRST_VALUE(install_version) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS install_version
        , FIRST_VALUE(first_config_timestamp) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS first_config_timestamp
        , LAST_VALUE(days_played_past_week_from_data) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS current_days_played_past_week_from_data
        , LAST_VALUE(daily_median_coin_balance) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_daily_median_coin_balance
        , LAST_VALUE(daily_median_life_balance) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_daily_median_life_balance
        , LAST_VALUE(daily_median_star_balance) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_daily_median_star_balance
        , LAST_VALUE(daily_ending_coin_balance) OVER (PARTITION BY rdg_id ORDER BY rdg_date ASC) AS last_daily_ending_coin_balance
      FROM
        ${player_summary_by_day_test.SQL_TABLE_NAME}
      )

      ------------------------------------------------------------------------
      -- Summarize by Ritz Deli Games ID
      ------------------------------------------------------------------------

      SELECT
        rdg_id
        , MAX(last_device_id) AS last_device_id
        , MAX(last_advertising_id) AS last_advertising_id
        , MAX(last_user_id) AS last_user_id
        , MAX(first_platform) AS first_platform
        , MAX(first_country) AS first_country
        , MAX(current_ltv) AS current_ltv
        , MAX(created_at) AS created_at
        , MAX(created_pst) AS created_pst
        , MAX(last_session_id) AS last_session_id
        , MAX(lifetime_sessions) AS lifetime_sessions
        , MAX(last_timestamp) AS last_timestamp
        , MAX(last_level_serial) AS last_level_serial
        , MAX(total_engagement_ticks) AS total_engagement_ticks
        , MAX(last_version) AS last_version
        , MAX(install_version) AS install_version
        , MAX(first_config_timestamp) AS first_config_timestamp
        , MAX(current_days_played_past_week_from_data) AS current_days_played_past_week_from_data
        , MAX(last_daily_median_coin_balance) AS last_daily_median_coin_balance
        , MAX(last_daily_median_life_balance) AS last_daily_median_life_balance
        , MAX(last_daily_median_star_balance) AS last_daily_median_star_balance
        , MAX(last_daily_ending_coin_balance) AS last_daily_ending_coin_balance
        , MAX(1) as count_rows
      FROM
        FullSelectionWithWindowCalculations
      GROUP BY
        1


          ;;
    datagroup_trigger: dependent_on_player_summary_by_day
    publish_as_db_view: yes

  }
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  measure: my_count_rows {
    description: "Use this for counting lifetime orders across many users"
    type: sum
    sql: ${TABLE}.count_rows  ;;
  }
}
