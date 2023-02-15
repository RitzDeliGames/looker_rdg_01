view: player_daily_summary_complete {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

WITH

------------------------------------------------------------------------
-- list of dates
------------------------------------------------------------------------

list_of_dates AS (

SELECT
  CAST(rdg_date_array AS TIMESTAMP) AS rdg_date
FROM
  UNNEST(
    GENERATE_DATE_ARRAY(
      '2019-01-01'
      , DATE_ADD(CURRENT_DATE, INTERVAL -1 DAY))
      ) rdg_date_array )

------------------------------------------------------------------------
-- list_of_players_and_created_dates
------------------------------------------------------------------------

, list_of_players_and_created_dates AS (

  SELECT
    rdg_id,
    MIN(created_date) AS created_date
  FROM
    eraser-blast.looker_scratch.6Y_ritz_deli_games_player_summary_new
  GROUP BY
    1
)

------------------------------------------------------------------------
-- all players and dates
------------------------------------------------------------------------

, all_players_and_dates AS (

  SELECT
    rdg_id
    , rdg_date
    , created_date
  FROM
    list_of_players_and_created_dates
    , list_of_dates
  WHERE
    rdg_date >= created_date
)

------------------------------------------------------------------------
-- left join player summary
------------------------------------------------------------------------

  SELECT
     A.rdg_date
     , A.rdg_id
     , A.created_date
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.rdg_id ELSE NULL END AS active_rdg_id
     , B.device_id
     , B.advertising_id
     , B.user_id
     , B.platform
     , B.country
     , B.created_utc
     , B.experiments
     , B.version
     , B.install_version
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.mtx_purchase_dollars ELSE 0 END AS mtx_purchase_dollars
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.ad_view_dollars ELSE 0 END AS ad_view_dollars
     , B.mtx_ltv_from_data
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.ad_views ELSE 0 END AS ad_views
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.count_sessions ELSE 0 END AS count_sessions
     , B.cumulative_session_count
     , B.cumulative_engagement_ticks
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.round_start_events ELSE 0 END AS round_start_events
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.round_end_events ELSE 0 END AS round_end_events
     , B.lowest_last_level_serial
     , B.highest_last_level_serial
     , B.highest_quests_completed
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.gems_spend ELSE 0 END AS gems_spend
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.coins_spend ELSE 0 END AS coins_spend
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.stars_spend ELSE 0 END AS stars_spend
     , B.ending_gems_balance
     , B.ending_coins_balance
     , B.ending_lives_balance
     , B.ending_stars_balance
     , B.created_date_timestamp
     , DATE_DIFF(DATE(A.rdg_date), B.created_date, DAY) AS days_since_created
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.date_last_played ELSE DATE(B.rdg_date) END AS date_last_played
     , DATE_DIFF(
          DATE(A.rdg_date)
          , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.date_last_played ELSE DATE(B.rdg_date) END
          , DAY) AS days_since_last_played
     , B.next_date_played
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.churn_indicator ELSE 0 END AS churn_indicator
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.churn_rdg_id ELSE NULL END AS churn_rdg_id
     , DATE_DIFF(B.next_date_played, DATE(A.rdg_date), DAY) AS days_until_next_played
     , B.cumulative_mtx_purchase_dollars
     , B.cumulative_ad_view_dollars
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.combined_dollars ELSE 0 END AS combined_dollars
     , B.cumulative_combined_dollars
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.daily_mtx_spend_indicator ELSE 0 END AS daily_mtx_spend_indicator
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.daily_mtx_spender_rdg_id ELSE NULL END AS daily_mtx_spender_rdg_id
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.first_mtx_spend_indicator ELSE 0 END AS first_mtx_spend_indicator
     , B.lifetime_mtx_spend_indicator
     , B.lifetime_mtx_spender_rdg_id
     , B.cumulative_ad_views
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.engagement_ticks ELSE 0 END AS engagement_ticks
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.time_played_minutes ELSE 0 END AS time_played_minutes
     , B.cumulative_time_played_minutes
     , B.cumulative_round_start_events
     , B.cumulative_round_end_events
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.quests_completed ELSE 0 END AS quests_completed
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.count_days_played ELSE 0 END AS count_days_played
     , B.cumulative_count_days_played
     , CASE WHEN DATE(A.rdg_date) = DATE(B.rdg_date) THEN B.levels_progressed ELSE 0 END AS levels_progressed
     , B.cumulative_gems_spend
     , B.cumulative_coins_spend
     , B.cumulative_star_spend
  FROM
     all_players_and_dates A
  LEFT JOIN
     eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary B
     ON A.rdg_id = B.rdg_id
     AND (
          DATE(A.rdg_date) = DATE(B.rdg_date)
          OR (
               DATE(A.rdg_date) > DATE(B.rdg_date)
               AND DATE(A.rdg_date) < DATE(B.next_date_played)
          ))

      ;;
      datagroup_trigger: dependent_on_player_summary
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

################################################################
## Unchanged Column Dimensions
################################################################

  dimension: days_since_created {type: number}
  dimension: created_date_timestamp {type: date}
  dimension: version {type: string}
  dimension: highest_last_level_serial {type: number}
  dimension: rdg_id {type: string}

################################################################
## Calculated Dimensions
################################################################

  dimension_group: rdg_date {
    description: "date as defined by rdg_date function"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: levels_progressed{
    type: tier
    tiers: [0,5,10,20,50,100]
    sql:  ${TABLE}.levels_progressed ;;
  }

  dimension: highest_last_level_serial_tiers {
    type:  tier
    tiers: [0,50,100,150,200,250,300,350,400,450,500,550]
    style: integer
    sql: ${TABLE}.highest_last_level_serial ;;

  }


################################################################
## Measures
################################################################

  #####################################
  ## Dollars
  #####################################

  measure: mtx_purchase_dollars {type: sum}
  measure: ad_view_dollars {type: sum}
  measure: combined_dollars {type: sum}

  #####################################
  ## Player Counts
  #####################################

  measure: count_distinct_active_users {
    description: "Use this for counting unique players"
    type: count_distinct
    sql: ${TABLE}.active_rdg_id ;;
  }

  measure: count_distinct_possible_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }


  measure: count_days_played {type: sum}

  measure: count_distinct_churn_rdg_id {
    description: "count of distinct churned players"
    type: count_distinct
    sql: ${TABLE}.churn_rdg_id ;;
  }

  # Add up days played
  measure: sum_churn_indicator {
    description: "Count of churned players per day "
    type: sum
    sql: ${TABLE}.churn_indicator ;;
  }

  #####################################
  ## Other
  #####################################



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
