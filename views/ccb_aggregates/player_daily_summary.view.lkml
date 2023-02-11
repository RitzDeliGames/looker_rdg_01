view: player_daily_summary {

################################################################
## View SQL
################################################################

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

        -- daily_mtx_spend_indicator
        , CASE WHEN IFNULL(mtx_purchase_dollars,0) > 0 THEN 1 ELSE 0 END AS daily_mtx_spend_indicator

        -- daily_mtx_spender_rdg_id
        , CASE WHEN IFNULL(mtx_purchase_dollars,0) > 0 THEN rdg_id ELSE NULL END AS daily_mtx_spender_rdg_id

        -- first_mtx_spend_indicator
        , CASE
            WHEN IFNULL(mtx_purchase_dollars,0) > 0
            AND
              SUM(mtx_purchase_dollars) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING )
              = 0
            THEN 1
            ELSE 0
            END AS first_mtx_spend_indicator

        -- lifetime_mtx_spend_indicator
        , CASE
            WHEN
              SUM(mtx_purchase_dollars) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
              > 0
            THEN 1
            ELSE 0
            END AS lifetime_mtx_spend_indicator

        -- lifetime_mtx_spender_rdg_id
        , CASE
            WHEN
              SUM(mtx_purchase_dollars) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
              > 0
            THEN rdg_id
            ELSE NULL
            END AS lifetime_mtx_spender_rdg_id

        -- cumulative_ad_views
        , SUM(ad_views) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_ad_views


        -- Calculate engagement ticks
        -- uses prior row cumulative_engagement_ticks
        , IFNULL(cumulative_engagement_ticks,0) -
            IFNULL(LAG(cumulative_engagement_ticks,1) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                ),0) AS engagement_ticks

        -- time played
        -- This is calculated as engagement ticks / 2
        , 0.5 * (
            IFNULL(cumulative_engagement_ticks,0) -
            IFNULL(LAG(cumulative_engagement_ticks,1) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ),0))
            AS time_played_minutes

        -- cumulative_time_played_minutes
        , 0.5 * ( IFNULL(cumulative_engagement_ticks,0) ) AS cumulative_time_played_minutes

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
        -- uses prior row highest_quests_completed
        , IFNULL(highest_quests_completed,0) -
            IFNULL(LAG(highest_quests_completed,1) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ),0) AS quests_completed

        -- count_days_played
        -- this is just always 1
        , 1 as count_days_played

        -- cumulative_count_days_played
        , SUM(1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_count_days_played

        -- Calculate levels_progressed
        -- uses prior row highest_last_level_serial
        , IFNULL(highest_last_level_serial,0) -
            IFNULL(LAG(highest_last_level_serial,1) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ),0) AS levels_progressed

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

################################################################
## Dimensions
################################################################

  dimension_group: rdg_date_analysis {
    description: "date as defined by rdg_date function"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: rdg_date {
    type: date
  }

  dimension: days_since_created {
    type: number
  }

  dimension: created_date {
    type: date
  }

################################################################
## Measures
################################################################

  #####################################
  ## Sum Dollars
  #####################################

  # Sum up MTX purchase dollars
  measure: sum_mtx_purchase_dollars {
    description: "Sum of MTX dollars"
    type: sum
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }

  # Sum up Ad Views purchase dollars
  measure: sum_ad_view_dollars {
    description: "Sum of dollars from Ad Views"
    type: sum
    sql: ${TABLE}.ad_view_dollars ;;
  }

  # Sum up combined dollars
  measure: sum_combined_dollars {
    description: "Sum of MTX + Ad dollars"
    type: sum
    sql: ${TABLE}.combined_dollars ;;
  }

  #####################################
  ## Other
  #####################################

  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }



  # Add up days played
  measure: sum_count_days_played {
    description: "Count of days played, each player per day = 1 "
    type: sum
    sql: ${TABLE}.count_days_played ;;
  }

  # Add up daily spend days
  measure: sum_daily_mtx_spend_indicator {
    description: "Count of mtx spend days played, each spend day per player = 1 "
    type: sum
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }

  # count unique daily spenders
  measure: count_distinct_daily_mtx_spender_rdg_id {
    description: "Count of Distinct Daily Spenders, Player must spend on day to be counted "
    type: count_distinct
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }

  # count unique lifetime spenders
  measure: count_distinct_lifetime_mtx_spender_rdg_id {
    description: "Count of Distinct Lifetime Spenders, Players who have EVER spent on MTX are counted"
    type: count_distinct
    sql: ${TABLE}.lifetime_mtx_spender_rdg_id ;;
  }

  # Add up daily first spends
  measure: sum_first_mtx_spend_indicator {
    description: "Count of FIRST mtx spend days played, each FIRST spend day per player = 1 "
    type: sum
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }

}
