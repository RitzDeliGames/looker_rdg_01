view: player_summary_staging {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-22'

     -- create or replace table `tal_scratch.player_summary_new_test` AS

      with

      -----------------------------------------------------------------------
      -- Get base data
      -----------------------------------------------------------------------

      latest_update_table AS (
      SELECT
      MAX(DATE(rdg_date)) AS latest_update

      FROM
      -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`
      ${player_daily_summary.SQL_TABLE_NAME}
      --`tal_scratch.player_daily_summary_test`


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
      , cumulative_ad_views
      , cumulative_ad_views_non_banner
      , mtx_ltv_from_data
      , highest_last_level_serial
      , cumulative_star_spend
      , cumulative_time_played_minutes
      , cumulative_session_count
      , cumulative_count_mtx_purchases
      , cumulative_coins_spend
      , cumulative_total_chum_powerups_used

      , end_of_content_levels
      , cumulative_round_time_in_minutes_campaign
      , cumulative_round_end_events_campaign
      , cumulative_round_end_events_puzzle
      , cumulative_round_end_events_gofish
      , cumulative_round_end_events_movesmaster
      , cumulative_round_end_events_gemquest

      -- device_id
      , last_value(device_id) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) device_id

      -- advertising_id
      , last_value(advertising_id) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) advertising_id

      -- user_id
      , first_value(user_id) over (
      partition by  rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) user_id

      -- latest_user_id
      , last_value(user_id) over (
      partition by  rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) latest_user_id

      -- bfg_uid
      , bfg_uid

      -- display_name
      , last_value(display_name) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) display_name

      -- platform
      , last_value(platform) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) platform

      -- country
      , last_value(country) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) country

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

      -- latest experiments
      , LAST_VALUE(experiments) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) latest_experiments

      -- install_version
      , FIRST_VALUE(install_version) OVER (
      PARTITION BY rdg_id
      ORDER BY rdg_date ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) install_version

      -------------------------------------------------------------------
      -- system info
      -------------------------------------------------------------------

      , last_value(hardware) over (
      partition by rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) hardware

      , last_value(processor_type) over (
      partition by rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) processor_type

      , last_value(graphics_device_name) over (
      partition by rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) graphics_device_name

      , last_value(device_model) over (
      partition by rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) device_model

      , last_value(system_memory_size) over (
      partition by rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) system_memory_size

      , last_value(graphics_memory_size) over (
      partition by rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) graphics_memory_size

      , last_value(screen_width) over (
      partition by rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) screen_width

      , last_value(screen_height) over (
      partition by rdg_id
      order by rdg_date ASC
      rows between unbounded preceding and unbounded following
      ) screen_height


      FROM
      -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`
      ${player_daily_summary.SQL_TABLE_NAME}
      --`tal_scratch.player_daily_summary_test`
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
        , max(latest_user_id) as latest_user_id
        , max(bfg_uid) as bfg_uid
        , max(display_name) as display_name
        , max(platform) as platform
        , max(country) as country
        , max(timestamp(created_date)) as created_date
        , max(date_diff(latest_update,created_date,DAY) + 1) as max_available_day_number
        , max(experiments) AS experiments
        , max(latest_experiments) as latest_experiments
        , max(cumulative_time_played_minutes) as cumulative_time_played_minutes

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
        , max( case when day_number <= 3 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d3
        , max( case when day_number <= 4 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d4
        , max( case when day_number <= 5 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d5
        , max( case when day_number <= 6 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d6
        , max( case when day_number <= 7 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d7
        , max( case when day_number <= 8 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d8
        , max( case when day_number <= 14 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d14
        , max( case when day_number <= 15 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d15
        , max( case when day_number <= 21 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d21
        , max( case when day_number <= 30 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d30
        , max( case when day_number <= 31 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d31
        , max( case when day_number <= 45 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d45
        , max( case when day_number <= 46 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d46
        , max( case when day_number <= 60 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d60
        , max( case when day_number <= 61 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d61
        , max( case when day_number <= 90 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d90
        , max( case when day_number <= 120 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d120
        , max( case when day_number <= 180 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d180
        , max( case when day_number <= 270 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d270
        , max( case when day_number <= 360 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d360
        , max( cumulative_mtx_purchase_dollars ) as cumulative_mtx_purchase_dollars_current
        , max(mtx_ltv_from_data) as mtx_ltv_from_data

        -- mtx purchases
        , max( case when day_number <= 1 then cumulative_count_mtx_purchases else 0 end ) as cumulative_count_mtx_purchases_d1
        , max( case when day_number <= 2 then cumulative_count_mtx_purchases else 0 end ) as cumulative_count_mtx_purchases_d2
        , max( case when day_number <= 7 then cumulative_count_mtx_purchases else 0 end ) as cumulative_count_mtx_purchases_d7
        , max( case when day_number <= 8 then cumulative_count_mtx_purchases else 0 end ) as cumulative_count_mtx_purchases_d8
        , max( case when day_number <= 14 then cumulative_count_mtx_purchases else 0 end ) as cumulative_count_mtx_purchases_d14
        , max( case when day_number <= 30 then cumulative_count_mtx_purchases else 0 end ) as cumulative_count_mtx_purchases_d30
        , max( case when day_number <= 60 then cumulative_count_mtx_purchases else 0 end ) as cumulative_count_mtx_purchases_d60
        , max( case when day_number <= 90 then cumulative_count_mtx_purchases else 0 end ) as cumulative_count_mtx_purchases_d90
        , max( cumulative_count_mtx_purchases ) as cumulative_count_mtx_purchases_current

        -- ad view dollars
        , max( case when day_number <= 1 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d1
        , max( case when day_number <= 2 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d2
        , max( case when day_number <= 3 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d3
        , max( case when day_number <= 4 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d4
        , max( case when day_number <= 5 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d5
        , max( case when day_number <= 6 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d6
        , max( case when day_number <= 7 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d7
        , max( case when day_number <= 8 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d8
        , max( case when day_number <= 14 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d14
        , max( case when day_number <= 15 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d15
        , max( case when day_number <= 21 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d21
        , max( case when day_number <= 30 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d30
        , max( case when day_number <= 31 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d31
        , max( case when day_number <= 46 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d46
        , max( case when day_number <= 60 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d60
        , max( case when day_number <= 90 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d90
        , max( case when day_number <= 120 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d120
        , max( case when day_number <= 180 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d180
        , max( case when day_number <= 270 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d270
        , max( case when day_number <= 360 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d360
        , max( cumulative_ad_view_dollars ) as cumulative_ad_view_dollars_current

        -- ad view dollars non-banner
      -- , max( case when day_number <= 1 then cumulative_ad_dollars_non_banner else 0 end ) as cumulative_ad_dollars_non_banner_d1_non_banner
      -- , max( case when day_number <= 2 then cumulative_ad_dollars_non_banner else 0 end ) as cumulative_ad_dollars_non_banner_d2_non_banner
      -- , max( case when day_number <= 7 then cumulative_ad_dollars_non_banner else 0 end ) as cumulative_ad_dollars_non_banner_d7_non_banner
      -- , max( case when day_number <= 14 then cumulative_ad_dollars_non_banner else 0 end ) as cumulative_ad_dollars_non_banner_d14_non_banner
      -- , max( case when day_number <= 30 then cumulative_ad_dollars_non_banner else 0 end ) as cumulative_ad_dollars_non_banner_d30_non_banner
      -- , max( case when day_number <= 60 then cumulative_ad_dollars_non_banner else 0 end ) as cumulative_ad_dollars_non_banner_d60_non_banner
      -- , max( case when day_number <= 90 then cumulative_ad_dollars_non_banner else 0 end ) as cumulative_ad_dollars_non_banner_d90_non_banner
      -- , max( cumulative_ad_dollars_non_banner ) as cumulative_ad_dollars_non_banner

        -- cumulative ad views
        , max( case when day_number <= 1 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d1
        , max( case when day_number <= 2 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d2
        , max( case when day_number <= 4 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d4
        , max( case when day_number <= 7 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d7
        , max( case when day_number <= 8 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d8
        , max( case when day_number <= 14 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d14
        , max( case when day_number <= 15 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d15
        , max( case when day_number <= 30 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d30
        , max( case when day_number <= 31 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d31
        , max( case when day_number <= 60 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d60
        , max( case when day_number <= 90 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d90
        , max(cumulative_ad_views) as cumulative_ad_views_current

        -- cumulative ad views non-banner
        , max( case when day_number <= 1 then cumulative_ad_views_non_banner else 0 end ) as cumulative_ad_views_d1_non_banner
        , max( case when day_number <= 2 then cumulative_ad_views_non_banner else 0 end ) as cumulative_ad_views_d2_non_banner
        , max( case when day_number <= 7 then cumulative_ad_views_non_banner else 0 end ) as cumulative_ad_views_d7_non_banner
        , max( case when day_number <= 14 then cumulative_ad_views_non_banner else 0 end ) as cumulative_ad_views_d14_non_banner
        , max( case when day_number <= 30 then cumulative_ad_views_non_banner else 0 end ) as cumulative_ad_views_d30_non_banner
        , max( case when day_number <= 60 then cumulative_ad_views_non_banner else 0 end ) as cumulative_ad_views_d60_non_banner
        , max( case when day_number <= 90 then cumulative_ad_views_non_banner else 0 end ) as cumulative_ad_views_d90_non_banner
        , max(cumulative_ad_views_non_banner) as cumulative_ad_views_current_non_banner

        -- combined dollars
        , max( case when day_number <= 1 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d1
        , max( case when day_number <= 2 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d2
        , max( case when day_number <= 3 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d3
        , max( case when day_number <= 4 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d4
        , max( case when day_number <= 5 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d5
        , max( case when day_number <= 6 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d6
        , max( case when day_number <= 7 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d7
        , max( case when day_number <= 8 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d8
        , max( case when day_number <= 14 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d14
        , max( case when day_number <= 15 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d15
        , max( case when day_number <= 21 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d21
        , max( case when day_number <= 30 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d30
        , max( case when day_number <= 31 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d31
        , max( case when day_number <= 45 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d45
        , max( case when day_number <= 46 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d46
        , max( case when day_number <= 60 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d60
        , max( case when day_number <= 61 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d61
        , max( case when day_number <= 90 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d90
        , max( case when day_number <= 120 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d120
        , max( case when day_number <= 180 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d180
        , max( case when day_number <= 270 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d270
        , max( case when day_number <= 360 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d360


        , max( cumulative_combined_dollars ) as cumulative_combined_dollars_current

        -- highest last level serial
        , max( case when day_number <= 1 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d1
        , max( case when day_number <= 2 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d2
        , max( case when day_number <= 7 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d7
        , max( case when day_number <= 14 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d14
        , max( case when day_number <= 30 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d30
        , max( case when day_number <= 60 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d60
        , max( case when day_number <= 90 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d90
        , max( highest_last_level_serial ) as highest_last_level_serial_current

        -- retention
        , max( case when day_number = 2 then 1 else 0 end ) as retention_d2
        , max( case when day_number = 3 then 1 else 0 end ) as retention_d3
        , max( case when day_number = 4 then 1 else 0 end ) as retention_d4
        , max( case when day_number = 5 then 1 else 0 end ) as retention_d5
        , max( case when day_number = 6 then 1 else 0 end ) as retention_d6
        , max( case when day_number = 7 then 1 else 0 end ) as retention_d7
        , max( case when day_number = 8 then 1 else 0 end ) as retention_d8
        , max( case when day_number = 9 then 1 else 0 end ) as retention_d9
        , max( case when day_number = 10 then 1 else 0 end ) as retention_d10
        , max( case when day_number = 11 then 1 else 0 end ) as retention_d11
        , max( case when day_number = 12 then 1 else 0 end ) as retention_d12
        , max( case when day_number = 13 then 1 else 0 end ) as retention_d13
        , max( case when day_number = 14 then 1 else 0 end ) as retention_d14
        , max( case when day_number = 15 then 1 else 0 end ) as retention_d15
        , max( case when day_number = 21 then 1 else 0 end ) as retention_d21
        , max( case when day_number = 28 then 1 else 0 end ) as retention_d28
        , max( case when day_number = 30 then 1 else 0 end ) as retention_d30
        , max( case when day_number = 31 then 1 else 0 end ) as retention_d31
        , max( case when day_number = 45 then 1 else 0 end ) as retention_d45
        , max( case when day_number = 46 then 1 else 0 end ) as retention_d46
        , max( case when day_number = 60 then 1 else 0 end ) as retention_d60
        , max( case when day_number = 61 then 1 else 0 end ) as retention_d61
        , max( case when day_number = 90 then 1 else 0 end ) as retention_d90
        , max( case when day_number = 91 then 1 else 0 end ) as retention_d91
        , max( case when day_number = 120 then 1 else 0 end ) as retention_d120
        , max( case when day_number = 180 then 1 else 0 end ) as retention_d180
        , max( case when day_number = 360 then 1 else 0 end ) as retention_d360
        , max( case when day_number = 365 then 1 else 0 end ) as retention_d365



        -- cumulative star spend
        , max( case when day_number <= 1 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d1
        , max( case when day_number <= 2 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d2
        , max( case when day_number <= 7 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d7
        , max( case when day_number <= 14 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d14
        , max( case when day_number <= 30 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d30
        , max( case when day_number <= 60 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d60
        , max( cumulative_star_spend ) as cumulative_star_spend_current

        -- cumulative coins spend
        , max( case when day_number <= 1 then cumulative_coins_spend else 0 end ) as cumulative_coins_spend_d1
        , max( case when day_number <= 2 then cumulative_coins_spend else 0 end ) as cumulative_coins_spend_d2
        , max( case when day_number <= 7 then cumulative_coins_spend else 0 end ) as cumulative_coins_spend_d7
        , max( case when day_number <= 14 then cumulative_coins_spend else 0 end ) as cumulative_coins_spend_d14
        , max( case when day_number <= 30 then cumulative_coins_spend else 0 end ) as cumulative_coins_spend_d30
        , max( case when day_number <= 60 then cumulative_coins_spend else 0 end ) as cumulative_coins_spend_d60
        , max( case when day_number <= 90 then cumulative_coins_spend else 0 end ) as cumulative_coins_spend_d90
        , max( cumulative_coins_spend ) as cumulative_coins_spend_current

        -- cumulative_total_chum_powerups_used
        , max( case when day_number <= 1 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d1
        , max( case when day_number <= 2 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d2
        , max( case when day_number <= 7 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d7
        , max( case when day_number <= 8 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d8
        , max( case when day_number <= 14 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d14
        , max( case when day_number <= 15 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d15
        , max( case when day_number <= 21 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d21
        , max( case when day_number <= 30 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d30
        , max( case when day_number <= 31 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d31
        , max( case when day_number <= 46 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d46
        , max( case when day_number <= 60 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d60
        , max( case when day_number <= 61 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d61
        , max( case when day_number <= 90 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d90
        , max( case when day_number <= 120 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d120
        , max( case when day_number <= 180 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d180
        , max( case when day_number <= 270 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d270
        , max( case when day_number <= 360 then cumulative_total_chum_powerups_used else 0 end ) as cumulative_total_chum_powerups_used_d360
        , max( cumulative_total_chum_powerups_used ) as cumulative_total_chum_powerups_current


        -- system_info
        , max( hardware ) as hardware
        , max( processor_type ) as processor_type
        , max( graphics_device_name ) as graphics_device_name
        , max( device_model ) as device_model
        , max( system_memory_size ) as system_memory_size
        , max( graphics_memory_size ) as graphics_memory_size
        , max( screen_width ) as screen_width
        , max( screen_height ) as screen_height

        -- time to complete campaign
        , min(
        case
        when end_of_content_levels = true
        then cumulative_round_time_in_minutes_campaign
        else null
        end
        ) as total_campaigin_round_time_in_minutes_to_first_end_of_content_levels
        , min(
        case
        when end_of_content_levels = true
        then rdg_date
        else null
        end
        ) as date_of_first_end_of_content_levels
        , min(
        case
        when end_of_content_levels = true
        then day_number
        else null
        end
        ) as day_number_of_first_end_of_content_levels

        -- days played in first x days
        , count( distinct case when day_number <= 7 then rdg_date else null end ) as days_played_in_first_7_days
        , count( distinct case when day_number <= 14 then rdg_date else null end ) as days_played_in_first_14_days
        , count( distinct case when day_number <= 21 then rdg_date else null end ) as days_played_in_first_21_days
        , count( distinct case when day_number <= 30 then rdg_date else null end ) as days_played_in_first_30_days

        -- sessions
        , max( case when day_number <= 7 then cumulative_session_count else 0 end ) as sessions_played_in_first_7_days
        , max( case when day_number <= 14 then cumulative_session_count else 0 end ) as sessions_played_in_first_14_days
        , max( case when day_number <= 21 then cumulative_session_count else 0 end ) as sessions_played_in_first_21_days
        , max( case when day_number <= 30 then cumulative_session_count else 0 end ) as sessions_played_in_first_30_days
        , max( case when day_number <= 31 then cumulative_session_count else 0 end ) as sessions_played_in_first_31_days

        -- minutes played in first x days
        , max( case when day_number <= 1 then cumulative_time_played_minutes else 0 end ) as minutes_played_in_first_1_days
        , max( case when day_number <= 2 then cumulative_time_played_minutes else 0 end ) as minutes_played_in_first_2_days
        , max( case when day_number <= 7 then cumulative_time_played_minutes else 0 end ) as minutes_played_in_first_7_days
        , max( case when day_number <= 14 then cumulative_time_played_minutes else 0 end ) as minutes_played_in_first_14_days
        , max( case when day_number <= 21 then cumulative_time_played_minutes else 0 end ) as minutes_played_in_first_21_days
        , max( case when day_number <= 30 then cumulative_time_played_minutes else 0 end ) as minutes_played_in_first_30_days

        -- rounds played in puzzle first x days
        , max( case when day_number <= 1 then cumulative_round_end_events_puzzle else 0 end ) as puzzle_rounds_played_in_first_1_days
        , max( case when day_number <= 2 then cumulative_round_end_events_puzzle else 0 end ) as puzzle_rounds_played_in_first_2_days
        , max( case when day_number <= 7 then cumulative_round_end_events_puzzle else 0 end ) as puzzle_rounds_played_in_first_7_days
        , max( case when day_number <= 14 then cumulative_round_end_events_puzzle else 0 end ) as puzzle_rounds_played_in_first_14_days
        , max( case when day_number <= 21 then cumulative_round_end_events_puzzle else 0 end ) as puzzle_rounds_played_in_first_21_days
        , max( case when day_number <= 30 then cumulative_round_end_events_puzzle else 0 end ) as puzzle_rounds_played_in_first_30_days

        -- cumulative rounds
        , max( cumulative_round_end_events_gofish ) as gofish_rounds_played_total
        , max( cumulative_round_end_events_puzzle ) as puzzle_rounds_played_total
        , max( cumulative_round_end_events_movesmaster ) as movesmaster_rounds_played_total
        , max( cumulative_round_end_events_gemquest ) as gemquest_rounds_played_total
        , max( cumulative_round_end_events_campaign ) as campaign_rounds_played_total

      from
        pre_aggregate_calculations_from_base_data
      group by
        1

      )

      -------------------------------------------------------------------------------------
      -- summary
      -------------------------------------------------------------------------------------

      select * from summarize_data

      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -5 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["created_date"]

  }


####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Dimension
####################################################################

  dimension_group: created_date {
    group_label: "Install Date"
    label: "Installed On"
    type: time
    timeframes: [date, week, month, year]
  }

####################################################################
## Measures
####################################################################

  measure: count_distinct_players {
    group_label: "Unique Player Counts"
    label: "Count Distinct Players"
    type: number
    sql:
    count( distinct ${TABLE}.rdg_id )
  ;;
    value_format_name: decimal_0

  }

}
