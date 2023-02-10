view: player_daily_summary {
# # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      SELECT

        -- Start with all the rows from player_daily_incremental
        *

        -- Days Since Created
        , DATE_DIFF(DATE(rdg_date), created_date, DAY) AS days_since_created

        -- Date last played
        , LAG(DATE(rdg_date), 1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ) date_last_played

        -- Days Since Last Played
        , DATE_DIFF(
            DATE(rdg_date)
            , LAG(DATE(rdg_date), 1) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                )
            , DAY
            ) days_since_last_played

        -- next_date_played
        , LEAD(DATE(rdg_date), 1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ) next_date_played

        -- days_until_next_played
        , DATE_DIFF(
            LEAD(DATE(rdg_date), 1) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                )
            , DATE(rdg_date)
            , DAY
            ) days_until_next_played

        -- cumulative_mtx_purchase_dollars
        , SUM(mtx_purchase_dollars) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_mtx_purchase_dollars

        -- cumulative_ad_view_dollars
        , SUM(ad_view_dollars) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_ad_view_dollars

        -- combined_dollars
        , IFNULL(mtx_purchase_dollars,0) + IFNULL(ad_view_dollars,0) AS combined_dollars

        -- cumulative_combined_dollars
        , SUM(IFNULL(mtx_purchase_dollars,0) + IFNULL(ad_view_dollars,0)) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_combined_dollars

        -- cumulative_ad_views
        , SUM(ad_views) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_ad_views


        -- Calculate engagement ticks
        -- uses prior row cumulative_engagement_ticks
        , IFNULL(cumulative_engagement_ticks,0) -
            IFNULL(LAG(cumulative_engagement_ticks,0) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                ),0) AS engagement_ticks

        -- time played
        -- This is calculated as engagement ticks / 2
        , IFNULL(cumulative_engagement_ticks,0) -
            IFNULL(LAG(cumulative_engagement_ticks,0) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                ),0) / 2
            AS time_played_minutes

        -- cumulative_time_played_minutes
        , IFNULL(cumulative_engagement_ticks,0) / 2 AS cumulative_time_played_minutes

        -- cumulative_round_start_events
        , SUM(round_start_events) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_start_events

        -- cumulative_round_end_events
        , SUM(round_end_events) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_end_events

        -- Calculate quests_completed
        -- uses prior row cumulative_engagement_ticks
        , IFNULL(highest_quests_completed,0) -
            IFNULL(LAG(highest_quests_completed,0) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                ),0) AS quests_completed

        -- cumulative_gems_spend
        , SUM(gems_spend) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_gems_spend

        -- cumulative_coins_spend
        , SUM(coins_spend) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_coins_spend

        -- cumulative_star_spend
        , SUM(stars_spend) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_star_spend

      FROM
        `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_incremental`
      ;;
    datagroup_trigger: dependent_on_player_daily_incremental
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

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
