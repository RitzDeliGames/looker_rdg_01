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
  dimension: first_country_by_day {
    description: "Ritz Deli Game ID"
    type: string
    sql: ${TABLE}.first_country_by_day ;;
  }
  #
  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
  #
  set: detail {
    fields: [
      first_country_by_day
    ]
  }
}
