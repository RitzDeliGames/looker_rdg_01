view: player_daily_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


SELECT

  -- Start with all the rows from player_daily_incremental
  *

  , TIMESTAMP(created_date) as created_date_timestamp

  -- Days Since Created
  , DATE_DIFF(DATE(rdg_date), created_date, DAY) AS days_since_created

  -- Player Day Number
  , 1 + DATE_DIFF(DATE(rdg_date), created_date, DAY) AS day_number

  -- new_player_indicator
  , CASE WHEN DATE_DIFF(DATE(rdg_date), created_date, DAY) = 0 THEN 1 ELSE 0 END AS new_player_indicator

   -- new_player_rdg_id
  , CASE WHEN DATE_DIFF(DATE(rdg_date), created_date, DAY) = 0 THEN rdg_id ELSE NULL END AS new_player_rdg_id

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

  -- churn_indicator
  , CASE
      WHEN
        LEAD(DATE(rdg_date), 1) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ) IS NULL
      THEN 1
      ELSE 0
      END AS churn_indicator

  -- churn_rdg_id
  , CASE
      WHEN
        LEAD(DATE(rdg_date), 1) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ) IS NULL
      THEN rdg_id
      ELSE NULL
      END AS churn_rdg_id

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
  -- Includes adjustment for App Store %
  , SUM( ifnull( mtx_purchase_dollars, 0 ) ) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) cumulative_mtx_purchase_dollars

  -- cumulative_ad_view_dollars
  , SUM(IFNULL(ad_view_dollars,0)) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) cumulative_ad_view_dollars

  -- combined_dollars
  -- Includes adjustment for App Store %
  , ifnull( mtx_purchase_dollars, 0 ) + IFNULL(ad_view_dollars,0) AS combined_dollars

  -- cumulative_combined_dollars
  -- Includes adjustment for App Store %
  , SUM(ifnull( mtx_purchase_dollars, 0 ) + IFNULL(ad_view_dollars,0)) OVER (
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

where
    -- select date_add( current_date(), interval -1 day )
    rdg_date <= timestamp(date_add( current_date(), interval -1 day ))

      ;;
    datagroup_trigger: dependent_on_player_daily_incremental
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }
  dimension_group: created_date_timestamp {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  # strings
  dimension: rdg_id {type:string}
  dimension: new_player_rdg_id {type:string}
  dimension: lifetime_mtx_spender_rdg_id {type:string}
  dimension: churn_rdg_id {type:string}
  dimension: device_id {type:string}
  dimension: advertising_id {type:string}
  dimension: user_id {type:string}
  dimension: platform {type:string}
  dimension: country {type:string}
  dimension: experiments {type:string}
  dimension: version {type:string}
  dimension: install_version {type:string}

  # numbers
  dimension: mtx_purchase_dollars {type:number}
  dimension: ad_view_dollars {type:number}
  dimension: mtx_ltv_from_data {type:number}
  dimension: ad_views {type:number}
  dimension: count_sessions {type:number}
  dimension: cumulative_session_count {type:number}
  dimension: cumulative_engagement_ticks {type:number}
  dimension: round_start_events {type:number}
  dimension: round_end_events {type:number}
  dimension: lowest_last_level_serial {type:number}
  dimension: highest_last_level_serial {type:number}
  dimension: highest_quests_completed {type:number}
  dimension: gems_spend {type:number}
  dimension: coins_spend {type:number}
  dimension: stars_spend {type:number}
  dimension: ending_gems_balance {type:number}
  dimension: ending_coins_balance {type:number}
  dimension: ending_lives_balance {type:number}
  dimension: ending_stars_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: new_player_indicator {type:number}
  dimension: date_last_played {type:number}
  dimension: days_since_last_played {type:number}
  dimension: next_date_played {type:number}
  dimension: churn_indicator {type:number}
  dimension: days_until_next_played {type:number}
  dimension: cumulative_mtx_purchase_dollars {type:number}
  dimension: cumulative_ad_view_dollars {type:number}
  dimension: combined_dollars {type:number}
  dimension: cumulative_combined_dollars {type:number}
  dimension: daily_mtx_spend_indicator {type:number}
  dimension: daily_mtx_spender_rdg_id {type:number}
  dimension: first_mtx_spend_indicator {type:number}
  dimension: lifetime_mtx_spend_indicator {type:number}
  dimension: cumulative_ad_views {type:number}
  dimension: engagement_ticks {type:number}
  dimension: time_played_minutes {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: cumulative_round_start_events {type:number}
  dimension: cumulative_round_end_events {type:number}
  dimension: quests_completed {type:number}
  dimension: count_days_played {type:number}
  dimension: cumulative_count_days_played {type:number}
  dimension: levels_progressed {type:number}
  dimension: cumulative_gems_spend {type:number}
  dimension: cumulative_coins_spend {type:number}
  dimension: cumulative_star_spend {type:number}

################################################################
## Measures
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
  measure: count_distinct_new_player_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.new_player_rdg_id ;;
  }
  measure: count_distinct_churn_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.churn_rdg_id ;;
  }
  measure: count_distinct_daily_mtx_spender_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: count_distinct_lifetime_mtx_spender_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.lifetime_mtx_spender_rdg_id ;;
  }

## Sums / Percentiles

  measure: sum_mtx_purchase_dollars {
    group_label: "MTX Purchase Dollars"
    type:sum
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_10 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_25 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_50 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_75 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_95 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: sum_ad_view_dollars {
    group_label: "Ad View Dollars"
    type:sum
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_10 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_25 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_50 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_75 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_95 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: sum_mtx_ltv_from_data {
    group_label: "MTX LTV From Data"
    type:sum
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_10 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 10
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_25 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 25
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_50 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 50
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_75 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 75
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_95 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 95
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: sum_ad_views {
    group_label: "Ad Views"
    type:sum
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_10 {
    group_label: "Ad Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_25 {
    group_label: "Ad Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_50 {
    group_label: "Ad Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_75 {
    group_label: "Ad Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_95 {
    group_label: "Ad Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_views ;;
  }
  measure: sum_count_sessions {
    group_label: "Count Sessions"
    type:sum
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_10 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_25 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_50 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_75 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_95 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_sessions ;;
  }
  measure: sum_cumulative_session_count {
    group_label: "Cumulative Session Count"
    type:sum
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_10 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_25 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_50 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_75 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_95 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: sum_cumulative_engagement_ticks {
    group_label: "Cumulative Engagement Ticks"
    type:sum
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_10 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_25 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_50 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_75 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_95 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: sum_round_start_events {
    group_label: "Round Start Events"
    type:sum
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_10 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_25 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_50 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_75 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_95 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_start_events ;;
  }
  measure: sum_round_end_events {
    group_label: "Round End Events"
    type:sum
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_10 {
    group_label: "Round End Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_25 {
    group_label: "Round End Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_50 {
    group_label: "Round End Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_75 {
    group_label: "Round End Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_95 {
    group_label: "Round End Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events ;;
  }
  measure: sum_lowest_last_level_serial {
    group_label: "Lowest Last Level Serial"
    type:sum
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_10 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 10
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_25 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 25
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_50 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 50
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_75 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 75
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_95 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 95
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: sum_highest_last_level_serial {
    group_label: "Highest Last Level Serial"
    type:sum
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_10 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 10
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_25 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 25
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_50 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 50
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_75 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 75
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_95 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 95
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: sum_highest_quests_completed {
    group_label: "Highest Quests Completed"
    type:sum
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_10 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 10
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_25 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 25
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_50 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 50
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_75 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 75
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_95 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 95
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: sum_gems_spend {
    group_label: "Gems Spend"
    type:sum
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_10 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_25 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_50 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_75 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_95 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.gems_spend ;;
  }
  measure: sum_coins_spend {
    group_label: "Coins Spend"
    type:sum
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_10 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_25 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_50 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_75 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_95 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coins_spend ;;
  }
  measure: sum_stars_spend {
    group_label: "Stars Spend"
    type:sum
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_10 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_25 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_50 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_75 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_95 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.stars_spend ;;
  }
  measure: sum_ending_gems_balance {
    group_label: "Ending Gems Balance"
    type:sum
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_10 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_25 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_50 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_75 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_95 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: sum_ending_coins_balance {
    group_label: "Ending Coins Balance"
    type:sum
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_10 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_25 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_50 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_75 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_95 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: sum_ending_lives_balance {
    group_label: "Ending Lives Balance"
    type:sum
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_10 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_25 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_50 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_75 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_95 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: sum_ending_stars_balance {
    group_label: "Ending Stars Balance"
    type:sum
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_10 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_25 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_50 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_75 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_95 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: sum_days_since_created {
    group_label: "Days Since Created"
    type:sum
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_10 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 10
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_25 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 25
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_50 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 50
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_75 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 75
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_95 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 95
    sql: ${TABLE}.days_since_created ;;
  }
  measure: sum_day_number {
    group_label: "Day Number"
    type:sum
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_10 {
    group_label: "Day Number"
    type: percentile
    percentile: 10
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_25 {
    group_label: "Day Number"
    type: percentile
    percentile: 25
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_50 {
    group_label: "Day Number"
    type: percentile
    percentile: 50
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_75 {
    group_label: "Day Number"
    type: percentile
    percentile: 75
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_95 {
    group_label: "Day Number"
    type: percentile
    percentile: 95
    sql: ${TABLE}.day_number ;;
  }
  measure: sum_new_player_indicator {
    group_label: "New Player Indicator"
    type:sum
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_10 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_25 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_50 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_75 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_95 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: sum_churn_indicator {
    group_label: "Churn Indicator"
    type:sum
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_10 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_25 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_50 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_75 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_95 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars {
    group_label: "Cumulative MTX Purchase Dollars"
    type:sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_10 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_25 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_50 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_75 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_95 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: sum_cumulative_ad_view_dollars {
    group_label: "Cumulative Ad View Dollars"
    type:sum
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_10 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_25 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_50 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_75 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_95 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: sum_combined_dollars {
    group_label: "Combined Dollars"
    type:sum
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_10 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_25 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_50 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_75 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_95 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: sum_cumulative_combined_dollars {
    group_label: "Cumulative Combined Dollars"
    type:sum
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_10 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_25 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_50 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_75 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_95 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: sum_daily_mtx_spend_indicator {
    group_label: "Daily MTX Spend Indicator"
    type:sum
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_10 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_25 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_50 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_75 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_95 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: sum_daily_mtx_spender_rdg_id {
    group_label: "Daily MTX Spender Rdg Id"
    type:sum
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_10 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 10
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_25 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 25
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_50 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 50
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_75 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 75
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_95 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 95
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: sum_first_mtx_spend_indicator {
    group_label: "First MTX Spend Indicator"
    type:sum
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_10 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_25 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_50 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_75 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_95 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: sum_lifetime_mtx_spend_indicator {
    group_label: "Lifetime MTX Spend Indicator"
    type:sum
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_10 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_25 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_50 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_75 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_95 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: sum_cumulative_ad_views {
    group_label: "Cumulative Ad Views"
    type:sum
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_10 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_25 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_50 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_75 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_95 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: sum_engagement_ticks {
    group_label: "Engagement Ticks"
    type:sum
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_10 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 10
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_25 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 25
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_50 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 50
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_75 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 75
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_95 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 95
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: sum_time_played_minutes {
    group_label: "Time Played Minutes"
    type:sum
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_10 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_25 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_50 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_75 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_95 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: sum_cumulative_time_played_minutes {
    group_label: "Cumulative Time Played Minutes"
    type:sum
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_10 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_25 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_50 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_75 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_95 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: sum_cumulative_round_start_events {
    group_label: "Cumulative Round Start Events"
    type:sum
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_10 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_25 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_50 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_75 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_95 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: sum_cumulative_round_end_events {
    group_label: "Cumulative Round End Events"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_10 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_25 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_50 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_75 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_95 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: sum_quests_completed {
    group_label: "Quests Completed"
    type:sum
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_10 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 10
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_25 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 25
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_50 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 50
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_75 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 75
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_95 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 95
    sql: ${TABLE}.quests_completed ;;
  }
  measure: sum_count_days_played {
    group_label: "Count Days Played"
    type:sum
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_10 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_25 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_50 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_75 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_95 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_days_played ;;
  }
  measure: sum_cumulative_count_days_played {
    group_label: "Cumulative Count Days Played"
    type:sum
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_10 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_25 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_50 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_75 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_95 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: sum_levels_progressed {
    group_label: "Levels Progressed"
    type:sum
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_10 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 10
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_25 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 25
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_50 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 50
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_75 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 75
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_95 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 95
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: sum_cumulative_gems_spend {
    group_label: "Cumulative Gems Spend"
    type:sum
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_10 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_25 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_50 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_75 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_95 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: sum_cumulative_coins_spend {
    group_label: "Cumulative Coins Spend"
    type:sum
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_10 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_25 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_50 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_75 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_95 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: sum_cumulative_star_spend {
    group_label: "Cumulative Star Spend"
    type:sum
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_10 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_25 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_50 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_75 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_95 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_star_spend ;;
  }

}
