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
    , day_number
    , rdg_date
    , version
    , cumulative_mtx_purchase_dollars
    , cumulative_ad_view_dollars
    , cumulative_combined_dollars
    , mtx_ltv_from_data
    , highest_last_level_serial
    , cumulative_star_spend

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

FROM
  `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`
  , latest_update_table

)

-----------------------------------------------------------------------
-- Summarize Data
-----------------------------------------------------------------------

, summarize_data AS (

  select
      rdg_id
      , max(rdg_date) as last_played_date
      , max(latest_update) as latest_table_update
      , max(device_id) as device_id
      , max(advertising_id) as advertising_id
      , max(user_id) as user_id
      , max(platform) as platform
      , max(country) as country
      , max(created_utc) as created_utc
      , max(timestamp(created_date)) as created_date
      , max(date_diff(latest_update,created_date,DAY) + 1) as max_available_day_number
      , max(experiments) AS experiments

      -- versions
      , max(install_version) AS version_at_install
      , max( case when day_number <= 2 then version else null end ) as version_d2
      , max( case when day_number <= 7 then version else null end ) as version_d7
      , max( case when day_number <= 14 then version else null end ) as version_d14
      , max( case when day_number <= 30 then version else null end ) as version_d30
      , max( case when day_number <= 60 then version else null end ) as version_d60
      , max( version ) as version_current

     -- mtx dollars
     , max( case when day_number <= 1 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d1
     , max( case when day_number <= 2 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d2
     , max( case when day_number <= 7 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d7
     , max( case when day_number <= 14 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d14
     , max( case when day_number <= 30 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d30
     , max( case when day_number <= 60 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d60
     , max( cumulative_mtx_purchase_dollars ) as cumulative_mtx_purchase_dollars_current
     , max(mtx_ltv_from_data) as mtx_ltv_from_data

     -- ad view dollars
     , max( case when day_number <= 1 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d1
     , max( case when day_number <= 2 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d2
     , max( case when day_number <= 7 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d7
     , max( case when day_number <= 14 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d14
     , max( case when day_number <= 30 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d30
     , max( case when day_number <= 60 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d60
     , max( cumulative_ad_view_dollars ) as cumulative_ad_view_dollars_current

     -- combined dollars
     , max( case when day_number <= 1 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d1
     , max( case when day_number <= 2 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d2
     , max( case when day_number <= 7 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d7
     , max( case when day_number <= 14 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d14
     , max( case when day_number <= 30 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d30
     , max( case when day_number <= 60 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d60
     , max( cumulative_combined_dollars ) as cumulative_combined_dollars_current

     -- highest last level serial
     , max( case when day_number <= 1 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d1
     , max( case when day_number <= 2 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d2
     , max( case when day_number <= 7 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d7
     , max( case when day_number <= 14 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d14
     , max( case when day_number <= 30 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d30
     , max( case when day_number <= 60 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d60
     , max( highest_last_level_serial ) as highest_last_level_serial_current

    -- retention
    , max( case when day_number = 2 then 1 else 0 end ) as retention_d2
    , max( case when day_number = 7 then 1 else 0 end ) as retention_d7
    , max( case when day_number = 14 then 1 else 0 end ) as retention_d14
    , max( case when day_number = 30 then 1 else 0 end ) as retention_d30
    , max( case when day_number = 60 then 1 else 0 end ) as retention_d60

    -- cumulative star spend
    , max( case when day_number <= 1 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d1
    , max( case when day_number <= 2 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d2
    , max( case when day_number <= 7 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d7
    , max( case when day_number <= 14 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d14
    , max( case when day_number <= 30 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d30
    , max( case when day_number <= 60 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d60
    , max( cumulative_star_spend ) as cumulative_star_spend_current

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
        ORDER BY cumulative_mtx_purchase_dollars_current
        )) cumulative_mtx_purchase_dollars_current_percentile
  FROM
    summarize_data
  WHERE
    cumulative_mtx_purchase_dollars_current > 0
)

-----------------------------------------------------------------------
-- Select output
-----------------------------------------------------------------------

SELECT
  A.*
  , B.cumulative_mtx_purchase_dollars_current_percentile
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

  # strings
  dimension: rdg_id {type: string}
  dimension: experiments {type: string}
  dimension: version_at_install {type: string}
  dimension: version_d2 {type: string}
  dimension: version_d7 {type: string}
  dimension: version_d14 {type: string}
  dimension: version_d30 {type: string}
  dimension: version_d60 {type: string}
  dimension: version_current {type: string}
  dimension: device_id {type: string}
  dimension: advertising_id {type: string}
  dimension: user_id {type: string}
  dimension: platform {type: string}
  dimension: country {type: string}

  # dates
  dimension_group: last_played_date {
    type: time
    timeframes: [date, week, month, year]
  }
  dimension_group: created_date {
    type: time
    timeframes: [date, week, month, year]
  }

  # numbers
  dimension: max_available_day_number {type: number}
  dimension: cumulative_mtx_purchase_dollars_d1 {type: number}
  dimension: cumulative_mtx_purchase_dollars_d2 {type: number}
  dimension: cumulative_mtx_purchase_dollars_d7 {type: number}
  dimension: cumulative_mtx_purchase_dollars_d14 {type: number}
  dimension: cumulative_mtx_purchase_dollars_d30 {type: number}
  dimension: cumulative_mtx_purchase_dollars_d60 {type: number}
  dimension: cumulative_mtx_purchase_dollars_current {type: number}
  dimension: mtx_ltv_from_data {type: number}
  dimension: cumulative_ad_view_dollars_d1 {type: number}
  dimension: cumulative_ad_view_dollars_d2 {type: number}
  dimension: cumulative_ad_view_dollars_d7 {type: number}
  dimension: cumulative_ad_view_dollars_d14 {type: number}
  dimension: cumulative_ad_view_dollars_d60 {type: number}
  dimension: cumulative_ad_view_dollars_current {type: number}
  dimension: cumulative_combined_dollars_d1 {type: number}
  dimension: cumulative_combined_dollars_d2 {type: number}
  dimension: cumulative_combined_dollars_d7 {type: number}
  dimension: cumulative_combined_dollars_d14 {type: number}
  dimension: cumulative_combined_dollars_d30 {type: number}
  dimension: cumulative_combined_dollars_d60 {type: number}
  dimension: cumulative_combined_dollars_current {type: number}
  dimension: highest_last_level_serial_d1 {type: number}
  dimension: highest_last_level_serial_d2 {type: number}
  dimension: highest_last_level_serial_d7 {type: number}
  dimension: highest_last_level_serial_d14 {type: number}
  dimension: highest_last_level_serial_d30 {type: number}
  dimension: highest_last_level_serial_d60 {type: number}
  dimension: highest_last_level_serial_current {type: number}
  dimension: retention_d2 {type: number}
  dimension: retention_d7 {type: number}
  dimension: retention_d14 {type: number}
  dimension: retention_d30 {type: number}
  dimension: retention_d60 {type: number}
  dimension: cumulative_star_spend_d1 {type: number}
  dimension: cumulative_star_spend_d2 {type: number}
  dimension: cumulative_star_spend_d7 {type: number}
  dimension: cumulative_star_spend_d14 {type: number}
  dimension: cumulative_star_spend_d30 {type: number}
  dimension: cumulative_star_spend_d60 {type: number}
  dimension: cumulative_star_spend_current {type: number}
  dimension: cumulative_mtx_purchase_dollars_current_percentile {type: number}



################################################################
## Measures
################################################################

  # Player Count
  measure: count_distinct_players {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  # Sums
  measure: sum_cumulative_mtx_purchase_dollars_d1 {
    type: sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d1 ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars_d2 {
    type: sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d2 ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars_d7 {
    type: sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d7 ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars_d14 {
    type: sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d14 ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars_d30 {
    type: sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d30 ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars_d60 {
    type: sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d60 ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars_current {
    type: sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_current ;;
  }
  measure: sum_mtx_ltv_from_data {
    type: sum
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: sum_cumulative_ad_view_dollars_d1 {
    type: sum
    sql: ${TABLE}.cumulative_ad_view_dollars_d1 ;;
  }
  measure: sum_cumulative_ad_view_dollars_d2 {
    type: sum
    sql: ${TABLE}.cumulative_ad_view_dollars_d2 ;;
  }
  measure: sum_cumulative_ad_view_dollars_d7 {
    type: sum
    sql: ${TABLE}.cumulative_ad_view_dollars_d7 ;;
  }
  measure: sum_cumulative_ad_view_dollars_d14 {
    type: sum
    sql: ${TABLE}.cumulative_ad_view_dollars_d14 ;;
  }
  measure: sum_cumulative_ad_view_dollars_d60 {
    type: sum
    sql: ${TABLE}.cumulative_ad_view_dollars_d60 ;;
  }
  measure: sum_cumulative_ad_view_dollars_current {
    type: sum
    sql: ${TABLE}.cumulative_ad_view_dollars_current ;;
  }
  measure: sum_cumulative_combined_dollars_d1 {
    type: sum
    sql: ${TABLE}.cumulative_combined_dollars_d1 ;;
  }
  measure: sum_cumulative_combined_dollars_d2 {
    type: sum
    sql: ${TABLE}.cumulative_combined_dollars_d2 ;;
  }
  measure: sum_cumulative_combined_dollars_d7 {
    type: sum
    sql: ${TABLE}.cumulative_combined_dollars_d7 ;;
  }
  measure: sum_cumulative_combined_dollars_d14 {
    type: sum
    sql: ${TABLE}.cumulative_combined_dollars_d14 ;;
  }
  measure: sum_cumulative_combined_dollars_d30 {
    type: sum
    sql: ${TABLE}.cumulative_combined_dollars_d30 ;;
  }
  measure: sum_cumulative_combined_dollars_d60 {
    type: sum
    sql: ${TABLE}.cumulative_combined_dollars_d60 ;;
  }
  measure: sum_cumulative_combined_dollars_current {
    type: sum
    sql: ${TABLE}.cumulative_combined_dollars_current ;;
  }
  measure: sum_retention_d2 {
    type: sum
    sql: ${TABLE}.retention_d2 ;;
  }
  measure: sum_retention_d7 {
    type: sum
    sql: ${TABLE}.retention_d7 ;;
  }
  measure: sum_retention_d14 {
    type: sum
    sql: ${TABLE}.retention_d14 ;;
  }
  measure: sum_retention_d30 {
    type: sum
    sql: ${TABLE}.retention_d30 ;;
  }
  measure: sum_retention_d60 {
    type: sum
    sql: ${TABLE}.retention_d60 ;;
  }
  measure: sum_cumulative_star_spend_d1 {
    type: sum
    sql: ${TABLE}.cumulative_star_spend_d1 ;;
  }
  measure: sum_cumulative_star_spend_d2 {
    type: sum
    sql: ${TABLE}.cumulative_star_spend_d2 ;;
  }
  measure: sum_cumulative_star_spend_d7 {
    type: sum
    sql: ${TABLE}.cumulative_star_spend_d7 ;;
  }
  measure: sum_cumulative_star_spend_d14 {
    type: sum
    sql: ${TABLE}.cumulative_star_spend_d14 ;;
  }
  measure: sum_cumulative_star_spend_d30 {
    type: sum
    sql: ${TABLE}.cumulative_star_spend_d30 ;;
  }
  measure: sum_cumulative_star_spend_d60{
    type: sum
    sql: ${TABLE}.cumulative_star_spend_d60 ;;
  }
  measure: sum_cumulative_star_spend_current {
    type: sum
    sql: ${TABLE}.cumulative_star_spend_current ;;
  }





}
