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
          helper_functions.get_rdg_date(timestamp) AS rdg_date
          , rdg_id
          , timestamp
          --, device_id
          --, advertising_id
          --, user_id
          --, platform
          , FIRST_VALUE(country) OVER (
              PARTITION BY rdg_id, helper_functions.get_rdg_date(timestamp)
              ORDER BY timestamp ASC
              ) first_country_by_day
          , ROW_NUMBER() OVER (
              PARTITION BY rdg_id, helper_functions.get_rdg_date(timestamp)
              ORDER BY timestamp ASC
              ) RowNumberByDayAscending
          , SUM(1) OVER (
              PARTITION BY rdg_id, helper_functions.get_rdg_date(timestamp)
              ) CountRowsPerDay
        FROM
          `eraser-blast.game_data.events`
        WHERE
          helper_functions.get_rdg_date(timestamp) >= '2023-01-01'
          AND helper_functions.get_rdg_date(timestamp) <= DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY)
          AND user_type = 'external'
          -- AND country != 'ZZ' I would take this out
      )

      ------------------------------------------------------------------------
      -- Convert to By Date
      ------------------------------------------------------------------------

      SELECT
        rdg_date
        , rdg_id
        , MIN(timestamp) AS first_timestamp_by_day
        , MAX(timestamp) AS last_timestamp_by_day
        , MAX(first_country_by_day) AS first_country_by_day
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
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: player_summary_by_day_test {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
