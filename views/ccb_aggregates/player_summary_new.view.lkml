view: player_summary_new {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

WITH

-----------------------------------------------------------------------
-- Get base data
-----------------------------------------------------------------------

latest_update_table AS (
  SELECT
    MAX(DATE(rdg_date)) AS latest_update

  FROM
    `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`

)


-----------------------------------------------------------------------
-- Get values from player summary
-----------------------------------------------------------------------

, pre_aggregate_calculations_from_base_data AS (

SELECT

    rdg_id

    , latest_update_table.latest_update

    , days_since_created

    , rdg_date

    -- device_id
    , FIRST_VALUE(device_id) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) device_id

    -- advertising_id
    , FIRST_VALUE(advertising_id) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) advertising_id

    -- user_id
    , FIRST_VALUE(user_id) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) user_id

    -- platform
    , FIRST_VALUE(platform) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) platform

    -- country
    , FIRST_VALUE(country) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) country

    -- created_utc
    , FIRST_VALUE(created_utc) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) created_utc

    -- created_date
    , FIRST_VALUE(created_date) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) created_date

    -- experiments
    , FIRST_VALUE(experiments) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) experiments

    -- install_version
    , FIRST_VALUE(install_version) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) install_version

    -- d0_cumulative_mtx_purchase_dollars
    , MAX( CASE
            WHEN DATE_DIFF(latest_update,created_date,DAY) >= 0
            AND days_since_created <= 0
            THEN cumulative_mtx_purchase_dollars
            ELSE NULL END ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS d0_cumulative_mtx_purchase_dollars

    -- d1_cumulative_mtx_purchase_dollars
    , MAX( CASE
            WHEN DATE_DIFF(latest_update,created_date,DAY) >= 1
            AND days_since_created <= 1
            THEN cumulative_mtx_purchase_dollars
            ELSE NULL END ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS d1_cumulative_mtx_purchase_dollars

    -- d7_cumulative_mtx_purchase_dollars
    , MAX( CASE
            WHEN DATE_DIFF(latest_update,created_date,DAY) >= 7
            AND days_since_created <= 7
            THEN cumulative_mtx_purchase_dollars
            ELSE NULL END ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS d7_cumulative_mtx_purchase_dollars

    -- d14_cumulative_mtx_purchase_dollars
    , MAX( CASE
            WHEN DATE_DIFF(latest_update,created_date,DAY) >= 14
            AND days_since_created <= 14
            THEN cumulative_mtx_purchase_dollars
            ELSE NULL END ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS d14_cumulative_mtx_purchase_dollars

    -- d30_cumulative_mtx_purchase_dollars
    , MAX( CASE
            WHEN DATE_DIFF(latest_update,created_date,DAY) >= 30
            AND days_since_created <= 30
            THEN cumulative_mtx_purchase_dollars
            ELSE NULL END ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS d30_cumulative_mtx_purchase_dollars

    -- d60_cumulative_mtx_purchase_dollars
    , MAX( CASE
            WHEN DATE_DIFF(latest_update,created_date,DAY) >= 60
            AND days_since_created <= 60
            THEN cumulative_mtx_purchase_dollars
            ELSE NULL END ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS d60_cumulative_mtx_purchase_dollars

    -- current_cumulative_mtx_purchase_dollars
    , MAX( cumulative_mtx_purchase_dollars ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS current_cumulative_mtx_purchase_dollars

   -- d0_cumulative_ad_view_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 0
           AND days_since_created <= 0
           THEN cumulative_ad_view_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d0_cumulative_ad_view_dollars

   -- d1_cumulative_ad_view_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 1
           AND days_since_created <= 1
           THEN cumulative_ad_view_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d1_cumulative_ad_view_dollars


   -- d7_cumulative_ad_view_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 7
           AND days_since_created <= 7
           THEN cumulative_ad_view_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d7_cumulative_ad_view_dollars


   -- d14_cumulative_ad_view_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 14
           AND days_since_created <= 14
           THEN cumulative_ad_view_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d14_cumulative_ad_view_dollars


   -- d30_cumulative_ad_view_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 30
           AND days_since_created <= 30
           THEN cumulative_ad_view_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d30_cumulative_ad_view_dollars


   -- d60_cumulative_ad_view_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 60
           AND days_since_created <= 60
           THEN cumulative_ad_view_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d60_cumulative_ad_view_dollars


   -- current_cumulative_ad_view_dollars
   , MAX( cumulative_ad_view_dollars ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS current_cumulative_ad_view_dollars

  -- d0_cumulative_combined_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 0
           AND days_since_created <= 0
           THEN cumulative_combined_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d0_cumulative_combined_dollars

   -- d1_cumulative_combined_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 1
           AND days_since_created <= 1
           THEN cumulative_combined_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d1_cumulative_combined_dollars


   -- d7_cumulative_combined_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 7
           AND days_since_created <= 7
           THEN cumulative_combined_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d7_cumulative_combined_dollars


   -- d14_cumulative_combined_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 14
           AND days_since_created <= 14
           THEN cumulative_combined_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d14_cumulative_combined_dollars


   -- d30_cumulative_combined_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 30
           AND days_since_created <= 30
           THEN cumulative_combined_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d30_cumulative_combined_dollars


   -- d60_cumulative_combined_dollars
   , MAX( CASE
           WHEN DATE_DIFF(latest_update,created_date,DAY) >= 60
           AND days_since_created <= 60
           THEN cumulative_combined_dollars
           ELSE NULL END ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS d60_cumulative_combined_dollars


   -- current_cumulative_combined_dollars
   , MAX( cumulative_combined_dollars ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS current_cumulative_combined_dollars

   -- current_cumulative_combined_dollars
   , MAX( mtx_ltv_from_data ) OVER (
       PARTITION BY rdg_id
       ORDER BY rdg_date ASC
       ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS mtx_ltv_from_data


    -- highest level
    , LAST_VALUE(highest_last_level_serial) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) highest_last_level_serial

FROM
  `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`
  , latest_update_table

)

-----------------------------------------------------------------------
-- Summarize Data
-----------------------------------------------------------------------

, summarize_data AS (

  SELECT
      rdg_id
      , MAX(rdg_date) as last_played_date
      , MAX(latest_update) AS latest_update
      , MAX(device_id) AS device_id
      , MAX(advertising_id) AS advertising_id
      , MAX(user_id) AS user_id
      , MAX(platform) AS platform
      , MAX(country) AS country
      , MAX(created_utc) AS created_utc
      , MAX(TIMESTAMP(created_date)) AS created_date
      , MAX(experiments) AS experiments
      , MAX(install_version) AS install_version
      , MAX(d0_cumulative_mtx_purchase_dollars) AS d0_cumulative_mtx_purchase_dollars
      , MAX(d1_cumulative_mtx_purchase_dollars) AS d1_cumulative_mtx_purchase_dollars
      , MAX(d7_cumulative_mtx_purchase_dollars) AS d7_cumulative_mtx_purchase_dollars
      , MAX(d14_cumulative_mtx_purchase_dollars) AS d14_cumulative_mtx_purchase_dollars
      , MAX(d30_cumulative_mtx_purchase_dollars) AS d30_cumulative_mtx_purchase_dollars
      , MAX(d60_cumulative_mtx_purchase_dollars) AS d60_cumulative_mtx_purchase_dollars
      , MAX(current_cumulative_mtx_purchase_dollars) AS current_cumulative_mtx_purchase_dollars
      , MAX(d0_cumulative_ad_view_dollars) AS d0_cumulative_ad_view_dollars
      , MAX(d1_cumulative_ad_view_dollars) AS d1_cumulative_ad_view_dollars
      , MAX(d7_cumulative_ad_view_dollars) AS d7_cumulative_ad_view_dollars
      , MAX(d14_cumulative_ad_view_dollars) AS d14_cumulative_ad_view_dollars
      , MAX(d30_cumulative_ad_view_dollars) AS d30_cumulative_ad_view_dollars
      , MAX(d60_cumulative_ad_view_dollars) AS d60_cumulative_ad_view_dollars
      , MAX(current_cumulative_ad_view_dollars) AS current_cumulative_ad_view_dollars
      , MAX(d0_cumulative_combined_dollars) AS d0_cumulative_combined_dollars
      , MAX(d1_cumulative_combined_dollars) AS d1_cumulative_combined_dollars
      , MAX(d7_cumulative_combined_dollars) AS d7_cumulative_combined_dollars
      , MAX(d14_cumulative_combined_dollars) AS d14_cumulative_combined_dollars
      , MAX(d30_cumulative_combined_dollars) AS d30_cumulative_combined_dollars
      , MAX(d60_cumulative_combined_dollars) AS d60_cumulative_combined_dollars
      , MAX(current_cumulative_combined_dollars) AS current_cumulative_combined_dollars
      , MAX(mtx_ltv_from_data) AS mtx_ltv_from_data
      , MAX(highest_last_level_serial) AS highest_last_level_serial

      -- Calculate Retention Here
      , MAX(CASE WHEN days_since_created = 1 THEN 1 ELSE 0 END ) AS d1_retention
      , MAX(CASE WHEN days_since_created = 7 THEN 1 ELSE 0 END ) AS d7_retention
      , MAX(CASE WHEN days_since_created = 14 THEN 1 ELSE 0 END ) AS d14_retention
      , MAX(CASE WHEN days_since_created = 30 THEN 1 ELSE 0 END ) AS d30_retention
      , MAX(CASE WHEN days_since_created = 60 THEN 1 ELSE 0 END ) AS d60_retention

  FROM
    pre_aggregate_calculations_from_base_data
  GROUP BY
    1

)

-----------------------------------------------------------------------
-- spender percentile
-----------------------------------------------------------------------

, percentile_current_cumulative_mtx_purchase_dollars_table AS (

  SELECT
    rdg_id
    , FLOOR(100*CUME_DIST() OVER (
        ORDER BY current_cumulative_mtx_purchase_dollars
        )) percentile_current_cumulative_mtx_purchase_dollars
  FROM
    summarize_data
  WHERE
    current_cumulative_mtx_purchase_dollars > 0
)

-----------------------------------------------------------------------
-- Select output
-----------------------------------------------------------------------

SELECT
  A.*
  , B.percentile_current_cumulative_mtx_purchase_dollars
FROM
  summarize_data A
  LEFT JOIN percentile_current_cumulative_mtx_purchase_dollars_table B
    ON A.rdg_id = B.rdg_id
            ;;
    datagroup_trigger: dependent_on_player_daily_summary
    publish_as_db_view: yes
    partition_keys: ["created_date"]

  }

################################################################
## Dimensions
################################################################

  dimension_group: created_date_analysis {
    description: "date as defined by rdg_date function"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  dimension: created_date {
    type: date
  }

# MAX(install_version) AS install_version
  dimension: install_version {
    type: string
    sql: ${TABLE}.install_version
      ;;
  }

  dimension: highest_last_level_serial_bucket{
    description: "The highest level a player is currently at"
    type:  tier
    tiers: [0,50,100,150,200,250,300]
    sql:  ${TABLE}.highest_last_level_serial ;;

  }

  dimension: current_cumulative_combined_dollars_bucket{
    description: "The highest level a player is currently at"
    type:  tier
    tiers: [0,1,5,10,20]
    sql:  ${TABLE}.current_cumulative_combined_dollars ;;

  }
  dimension: percentile_current_cumulative_mtx_purchase_dollars {
    type: number
  }

      # , MAX(rdg_date) as last_played_date
      # , MAX(latest_update) AS latest_update
      # , MAX(device_id) AS device_id
      # , MAX(advertising_id) AS advertising_id
      # , MAX(user_id) AS user_id
      # , MAX(platform) AS platform
      # , MAX(country) AS country
      # , MAX(created_utc) AS created_utc
      # , MAX(TIMESTAMP(created_date)) AS created_date

  dimension: days_from_created_to_last_played {
    type:  number
    sql:
      DATE_DIFF(${TABLE}.{last_played_date}, ${TABLE}.{created_date}, DAY)
      ;;

  }

################################################################
## Measures
################################################################

  #####################################
  ## Sum Dollars
  #####################################

  # d0_cumulative_mtx_purchase_dollars
  measure: sum_d0_cumulative_mtx_purchase_dollars {
    description: "Sum of MTX dollars"
    type: sum
    sql: ${TABLE}.sum_d0_cumulative_mtx_purchase_dollars ;;
  }

  # current_cumulative_combined_dollars
  measure: sum_current_cumulative_combined_dollars {
    description: "Sum of MTX dollars"
    type: sum
    sql: ${TABLE}.current_cumulative_combined_dollars ;;
  }

  #####################################
  ## Player Counts
  #####################################

  measure: count_distinct_players {
    description: "Use this for counting unique players"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  #####################################
  ## Retention
  #####################################

  measure: sum_d1_retention {
    type: sum
    sql: ${TABLE}.d1_retention ;;
  }

  measure: d7_retention {
    type: sum
    sql: ${TABLE}.d7_retention ;;
  }

  measure: d14_retention {
    type: sum
    sql: ${TABLE}.d14_retention ;;
  }

  measure: d30_retention {
    type: sum
    sql: ${TABLE}.d30_retention ;;
  }

  measure: d60_retention {
    type: sum
    sql: ${TABLE}.d60_retention ;;
  }

}
