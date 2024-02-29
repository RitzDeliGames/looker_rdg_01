view: player_summary_new {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-22'

      -- create or replace table `tal_scratch.player_summary_new` AS

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
      , cumulative_round_end_events_puzzle
      , cumulative_round_end_events_gofish

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

      -- cumulative ad views
      , max( case when day_number <= 1 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d1
      , max( case when day_number <= 2 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d2
      , max( case when day_number <= 7 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d7
      , max( case when day_number <= 14 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d14
      , max( case when day_number <= 30 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d30
      , max( case when day_number <= 60 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d60
      , max( case when day_number <= 90 then cumulative_ad_views else 0 end ) as cumulative_ad_views_d90
      , max(cumulative_ad_views) as cumulative_ad_views_current

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
      , max( case when day_number = 46 then 1 else 0 end ) as retention_d46
      , max( case when day_number = 60 then 1 else 0 end ) as retention_d60
      , max( case when day_number = 61 then 1 else 0 end ) as retention_d61
      , max( case when day_number = 90 then 1 else 0 end ) as retention_d90
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

      -- cumulative go fish rounds
      , max( cumulative_round_end_events_gofish ) as gofish_rounds_played_total

      FROM
      pre_aggregate_calculations_from_base_data
      GROUP BY
      1

      )

      -----------------------------------------------------------------------
      -- calculate spender percentile
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
      -- firebase player summary
      -----------------------------------------------------------------------

      , firebase_player_summary as (

      select
      firebase_user_id
      , max(last_played_date) as last_played_date
      , max(latest_table_update) as latest_table_update
      , max(firebase_advertising_id) as firebase_advertising_id
      , max(firebase_platform) as firebase_platform
      , max(firebase_created_date) as firebase_created_date

      FROM
      -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_summary`
      ${firebase_player_summary.SQL_TABLE_NAME}
      GROUP BY
      1

      )

      -----------------------------------------------------------------------
      -- singular_player_summary pre aggregate
      -----------------------------------------------------------------------

      , singular_player_summary_pre_aggregate as (

      select
      device_id as singular_device_id

      -- campaign_id
      , first_value(campaign_id) over (
      partition by  device_id
      order by event_timestamp ASC
      rows between unbounded preceding and unbounded following
      ) singular_campaign_id

      -- singular_partner_name
      , first_value(singular_partner_name) over (
      partition by  device_id
      order by event_timestamp ASC
      rows between unbounded preceding and unbounded following
      ) singular_partner_name

      , creative_id
      , creative_name

      from
      `eraser-blast.singular.user_level_attributions`
      where
      -- date(event_timestamp) between '2022-05-01' and current_date()
      -- date(etl_record_processing_hour_utc) between '2022-06-01' and current_date()
      -- campaign_id <> '' -- We want to include Unattibuted
      (
      is_reengagement is null
      or is_reengagement = false )


      )

      -----------------------------------------------------------------------
      -- singular_player_summary
      -----------------------------------------------------------------------

      , singular_player_summary as (

      select
      singular_device_id
      , max(singular_campaign_id) as singular_campaign_id
      , max(singular_partner_name) as singular_partner_name
      , max(creative_id) as singular_creative_id
      , max(creative_name) as full_ad_name
      from
      singular_player_summary_pre_aggregate
      group by
      1
      )

      -----------------------------------------------------------------------
      -- add on singular data
      -----------------------------------------------------------------------

      , add_on_mtx_percentile_and_singular_data as (

      select
      a.*
      , b.cumulative_mtx_purchase_dollars_current_percentile
      , c.firebase_advertising_id
      , d.singular_device_id
      , d.singular_campaign_id
      , d.singular_partner_name
      , d.singular_creative_id
      , d.full_ad_name

      from
      summarize_data A
      left join percentile_current_cumulative_mtx_purchase_dollars_table B
      on A.rdg_id = B.rdg_id
      left join firebase_player_summary c
      on a.user_id = c.firebase_user_id
      left join singular_player_summary d
      on c.firebase_advertising_id = d.singular_device_id

      )

      -----------------------------------------------------------------------
      -- prepare supported_devices table
      -----------------------------------------------------------------------

      , supported_devices_table as (

      select
      retail_name || ' ' || model_name as device_model
      , max(retail_name) as retail_name
      , max(marketing_name) as marketing_name
      , max(device_name) as device_name
      , max(model_name) as model_name
      from
      `eraser-blast.game_data.supported_devices`
      where
      retail_name != "Retail Branding"
      group by
      1
      )

      -----------------------------------------------------------------------
      -- add on supported_devices
      -----------------------------------------------------------------------

      select
      a.*
      , b.retail_name as supported_devices_retail_name
      , b.marketing_name as supported_devices_marketing_name
      , b.device_name as supported_devices_device_name
      , b.model_name as supported_devices_model_name
      from
      add_on_mtx_percentile_and_singular_data a
      left join supported_devices_table b
      on a.device_model = b.device_model

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

################################################################
## Dimensions
################################################################

  # strings
  dimension: rdg_id {group_label:"Player IDs" type: string}
  dimension: device_id {group_label:"Player IDs" type: string}
  dimension: display_name {group_label:"Player IDs" type: string}
  dimension: advertising_id {group_label:"Player IDs" type: string}
  dimension: user_id {group_label:"Player IDs" type: string}
  dimension: firebase_advertising_id {group_label:"Player IDs" type:string}
  dimension: experiments {type: string}
  dimension: version_at_install {group_label:"Versions" label: "Install Version" type: string}
  dimension: version_d2 {group_label:"Versions" type: string}
  dimension: version_d7 {group_label:"Versions" type: string}
  dimension: version_d14 {group_label:"Versions" type: string}
  dimension: version_d30 {group_label:"Versions" type: string}
  dimension: version_d60 {group_label:"Versions" type: string}
  dimension: version_d90 {group_label:"Versions" type: string}
  dimension: version_current {group_label:"Versions" label: "Current Version" type: string}
  dimension: platform {type: string}
  dimension: country {type: string}
  dimension: region {type:string sql:@{country_region};;}
  dimension: cumulative_time_played_minutes {label:"Minutes Played" value_format:"#,##0" type: number}


  ## minutes played in first x days
  dimension: minutes_played_in_first_1_days {type: number}
  dimension: minutes_played_in_first_2_days {type: number}
  dimension: minutes_played_in_first_7_days {type: number}
  dimension: minutes_played_in_first_14_days {type: number}
  dimension: minutes_played_in_first_21_days {type: number}
  dimension: minutes_played_in_first_30_days {type: number}


  dimension: gofish_rounds_played_total {
    group_label: "Go Fish Rounds"
    label: "GoFish Rounds Played"
    type: number
  }

  dimension: gofish_rounds_played_tiers {
    group_label: "Go Fish Rounds"
    label: "GoFish Rounds Played (Bins)"
    type: tier
    style: integer
    tiers: [0,1,4,7,10,13,16]
    sql: ${TABLE}.gofish_rounds_played_total  ;;
  }

  # dates
  dimension_group: last_played_date {
    label: "Last Played"
    type: time
    timeframes: [date, week, month, year]
  }

  # date_of_first_end_of_content_levels
  dimension_group: date_of_first_end_of_content_levels {
    group_label: "First End of Content Levels"
    type: time
    timeframes: [date, week, month, year]
  }

  dimension: created_date {type: date}
  dimension_group: created_date {
    group_label: "Install Date"
    label: "Installed On"
    type: time
    timeframes: [date, week, month, year]
  }

  dimension_group: singular_campaign_min_date {
    type: time
    timeframes: [date, week, month, year]
  }

  dimension: highest_played_day_number  {
    type:  number
    sql: DATE_DIFF( DATE(${TABLE}.last_played_date) , DATE( ${TABLE}.created_date ), DAY) + 1 ;;
  }

  # numbers
  dimension: max_available_day_number {type: number}
  dimension: cumulative_mtx_purchase_dollars_d1 {label: "Cumulative IAP: D1" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d2 {label: "Cumulative IAP: D2" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d3 {label: "Cumulative IAP: D3" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d4 {label: "Cumulative IAP: D4" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d5 {label: "Cumulative IAP: D5" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d6 {label: "Cumulative IAP: D6" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d7 {label: "Cumulative IAP: D7" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d8 {label: "Cumulative IAP: D8" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d14 {label: "Cumulative IAP: D14" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d15 {label: "Cumulative IAP: D15" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d21 {label: "Cumulative IAP: D21" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d30 {label: "Cumulative IAP: D30" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d31 {label: "Cumulative IAP: D31" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d46 {label: "Cumulative IAP: D46" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d60 {label: "Cumulative IAP: D60" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d61 {label: "Cumulative IAP: D61" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d90 {label: "Cumulative IAP: D90" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d120 {label: "Cumulative IAP: D120" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d180 {label: "Cumulative IAP: D180" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d270 {label: "Cumulative IAP: D270" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d360 {label: "Cumulative IAP: D360" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_current {label: "Cumulative IAP: Current" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_current_percentile {label: "Cumulative IAP: Current Percentile" group_label:"LTV - IAP" type: number}

  dimension: cumulative_count_mtx_purchases_d1 {label: "Cumulative IAP Purchases: D1" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d2 {label: "Cumulative IAP Purchases: D2" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d7 {label: "Cumulative IAP Purchases: D7" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d8 {label: "Cumulative IAP Purchases: D8" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d14 {label: "Cumulative IAP Purchases: D14" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d30 {label: "Cumulative IAP Purchases: D30" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d60 {label: "Cumulative IAP Purchases: D60" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_current {label: "Cumulative IAP Purchases: Current" group_label:"Cumulative IAP Purchases" type:number}

  dimension: mtx_ltv_from_data {type: number}
  dimension: cumulative_ad_view_dollars_d1 {label: "Cumulative IAA: D1" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d2 {label: "Cumulative IAA: D2" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d3 {label: "Cumulative IAA: D3" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d4 {label: "Cumulative IAA: D4" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d5 {label: "Cumulative IAA: D5" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d6 {label: "Cumulative IAA: D6" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d7 {label: "Cumulative IAA: D7" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d8 {label: "Cumulative IAA: D8" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d14 {label: "Cumulative IAA: D14" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d15 {label: "Cumulative IAA: D15" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d21 {label: "Cumulative IAA: D21" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d30 {label: "Cumulative IAA: D30" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d31 {label: "Cumulative IAA: D31" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d46 {label: "Cumulative IAA: D46" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d60 {label: "Cumulative IAA: D60" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d61 {label: "Cumulative IAA: D61" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d90 {label: "Cumulative IAA: D90" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d120 {label: "Cumulative IAA: D120" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d180 {label: "Cumulative IAA: D180" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d270 {label: "Cumulative IAA: D270" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d360 {label: "Cumulative IAA: D360" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_current {label: "Cumulative IAA: Current" group_label:"LTV - IAA" value_format:"$0.00" type: number}

  dimension: cumulative_combined_dollars_d1 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D1" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d2 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D2" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d3 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D3" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d4 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D4" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d5 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D5" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d6 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D6" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d7 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D7" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d8 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D8" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d14 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D14" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d15 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D15" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d21 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D21" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d30 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D30" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d31 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D31" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d46 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D46" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d60 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D60" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d61 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D61" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d90 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D90" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d120 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D120" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d180 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D180" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d270 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D270" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d360 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D360" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_current {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: Current" value_format:"$0.00" type: number}

  dimension: cumulative_gross_combined_dollars_d1 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D1" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d1}/0.70 + ${cumulative_ad_view_dollars_d1} ;;}
  dimension: cumulative_gross_combined_dollars_d2 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D2" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d2}/0.70 + ${cumulative_ad_view_dollars_d2} ;;}
  dimension: cumulative_gross_combined_dollars_d7 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D7" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d7}/0.70 + ${cumulative_ad_view_dollars_d7} ;;}
  dimension: cumulative_gross_combined_dollars_d8 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D8" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d8}/0.70 + ${cumulative_ad_view_dollars_d8} ;;}
  dimension: cumulative_gross_combined_dollars_d14 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D14" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d14}/0.70 + ${cumulative_ad_view_dollars_d14} ;;}
  dimension: cumulative_gross_combined_dollars_d15 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D15" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d15}/0.70 + ${cumulative_ad_view_dollars_d15} ;;}
  dimension: cumulative_gross_combined_dollars_d21 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D21" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d21}/0.70 + ${cumulative_ad_view_dollars_d21} ;;}
  dimension: cumulative_gross_combined_dollars_d30 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D30" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d30}/0.70 + ${cumulative_ad_view_dollars_d30} ;;}
  dimension: cumulative_gross_combined_dollars_d31 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D31" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d31}/0.70 + ${cumulative_ad_view_dollars_d31} ;;}
  dimension: cumulative_gross_combined_dollars_d46 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D46" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d46}/0.70 + ${cumulative_ad_view_dollars_d46} ;;}
  dimension: cumulative_gross_combined_dollars_d60 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D60" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d60}/0.70 + ${cumulative_ad_view_dollars_d60} ;;}
  dimension: cumulative_gross_combined_dollars_d61 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D61" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d61}/0.70 + ${cumulative_ad_view_dollars_d61} ;;}
  dimension: cumulative_gross_combined_dollars_d90 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D90" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d90}/0.70 + ${cumulative_ad_view_dollars_d90} ;;}
  dimension: cumulative_gross_combined_dollars_d120 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D120" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d120}/0.70 + ${cumulative_ad_view_dollars_d120} ;;}
  dimension: cumulative_gross_combined_dollars_d180 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D180" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d180}/0.70 + ${cumulative_ad_view_dollars_d180} ;;}
  dimension: cumulative_gross_combined_dollars_d270 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D270" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d270}/0.70 + ${cumulative_ad_view_dollars_d270} ;;}
  dimension: cumulative_gross_combined_dollars_d360 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D360" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d360}/0.70 + ${cumulative_ad_view_dollars_d360} ;;}

  dimension: highest_last_level_serial_d1 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d2 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d7 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d14 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d30 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d60 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d90 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_current {group_label:"Highest Level" label:"Highest Level" type: number}

  dimension: retention_d2 {group_label:"Retention" type: number}
  dimension: retention_d7 {group_label:"Retention" type: number}
  dimension: retention_d8 {group_label:"Retention" type: number}
  dimension: retention_d9 {group_label:"Retention" type: number}
  dimension: retention_d10 {group_label:"Retention" type: number}
  dimension: retention_d11 {group_label:"Retention" type: number}
  dimension: retention_d12 {group_label:"Retention" type: number}
  dimension: retention_d13 {group_label:"Retention" type: number}
  dimension: retention_d14 {group_label:"Retention" type: number}
  dimension: retention_d21 {group_label:"Retention" type: number}
  dimension: retention_d30 {group_label:"Retention" type: number}
  dimension: retention_d60 {group_label:"Retention" type: number}
  dimension: retention_d90 {group_label:"Retention" type: number}

  dimension: cumulative_star_spend_d1 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d2 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d7 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d14 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d30 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d60 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d90 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_current {group_label:"Cumulative Stars Spent" type: number}

  dimension: cumulative_ad_views_d1 {label: "Cumulative IAA Views: D1" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d2 {label: "Cumulative IAA Views: D2" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d7 {label: "Cumulative IAA Views: D7" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d14 {label: "Cumulative IAA Views: D14" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d30 {label: "Cumulative IAA Views: D30" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d60 {label: "Cumulative IAA Views: D60" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d90 {label: "Cumulative IAA Views: D90" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_current {label: "Cumulative IAA Views: Current" group_label:"Cumulative IAA Views" type: number}

  dimension: cumulative_coins_spend_d1 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d2 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d7 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d14 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d30 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d60 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d90 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_current {group_label:"Cumulative Coin Spend" type: number}


  ################################################################################################
  ## sessions per day
  ################################################################################################

  dimension: sessions_per_day_7 {
    group_label: "Sessions Per Day"
    label: "Average Sessions Per Day in First 7 Days"
    type: number
    value_format_name: decimal_0
    sql:
      round(
        safe_divide(
          ${TABLE}.sessions_played_in_first_7_days
          , ${TABLE}.days_played_in_first_7_days
        )
        , 0
      )
    ;;

  }

  ################################################################################################
  ## minutes per day
  ################################################################################################

  dimension: minutes_per_day_7 {
    group_label: "Minutes Per Day"
    label: "Average Minutes Per Day in First 7 Days"
    type: number
    value_format_name: decimal_0
    sql:
      round(
        safe_divide(
          ${TABLE}.minutes_played_in_first_7_days
          , ${TABLE}.days_played_in_first_7_days
        )
        , 0
      )
    ;;

    }


  ################################################################################################
  ## end of content
  ################################################################################################

  dimension: day_number_of_first_end_of_content_levels {type:number}
  dimension: day_group_for_end_of_content_levels {
    type: string
    sql:
      case
        when ${TABLE}.day_number_of_first_end_of_content_levels is null then 'Not Reached End of Content'
        when ${TABLE}.day_number_of_first_end_of_content_levels <= 7 then 'End of Content By D07'
        when ${TABLE}.day_number_of_first_end_of_content_levels <= 30 then 'End of Content By D30'
        when ${TABLE}.day_number_of_first_end_of_content_levels <= 60 then 'End of Content By D60'
        when ${TABLE}.day_number_of_first_end_of_content_levels is not null then 'End of Content By D61+'
        else 'Other'
        end
    ;;

  }
  measure: end_of_content_by_day_7 {
    group_label: "End of Content Groups"
    label: "End of Content by D7"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels <= 7 then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  measure: end_of_content_by_day_14 {
    group_label: "End of Content Groups"
    label: "End of Content by D14"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels <= 14 then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  measure: end_of_content_by_day_30 {
    group_label: "End of Content Groups"
    label: "End of Content by D30"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels <= 30 then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  measure: end_of_content_by_day_60 {
    group_label: "End of Content Groups"
    label: "End of Content by D60"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels <= 60 then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  measure: end_of_content_by_day_61_plus {
    group_label: "End of Content Groups"
    label: "End of Content by D61+"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels is not null then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  ## system_info
  dimension: hardware {
    group_label: "System Info"
    type: string
  }
  dimension: processor_type {
    group_label: "System Info"
    type: string
  }
  dimension: graphics_device_name {
    group_label: "System Info"
    type: string
  }
  dimension: device_model {
    group_label: "System Info"
    type: string
  }
  dimension: system_memory_size {
    group_label: "System Info"
    type: number
  }
  dimension: graphics_memory_size {
    group_label: "System Info"
    type: number
  }
  dimension: screen_width {
    group_label: "System Info"
    type: number
  }
  dimension: screen_height {
    group_label: "System Info"
    type: number
  }
  dimension: screen_dimensions {
    group_label: "System Info"
    type: string
    sql:
      safe_cast(${TABLE}.screen_width as string)
      || ' x '
      || safe_cast(${TABLE}.screen_height as string) ;;
  }

  dimension: aspect_ratio_9 {
    group_label: "System Info"
    type: string
    sql:
      cast( round(9 * safe_divide( ${TABLE}.screen_height , ${TABLE}.screen_width ),0) as string )
      || ':9'
    ;;

  }


  dimension: device_platform_mapping {
    group_label: "System Info"
    type: string
    sql: @{device_platform_mapping} ;;
  }

  dimension: device_platform_mapping_os {
    group_label: "System Info"
    type: string
    sql: @{device_platform_mapping_os} ;;
  }


  dimension: supported_devices_retail_name {
    group_label: "System Info"
    type: string
  }
  dimension: supported_devices_marketing_name {
    group_label: "System Info"
    type: string
  }
  dimension: supported_devices_device_name {
    group_label: "System Info"
    type: string
  }
  dimension: supported_devices_model_name {
    group_label: "System Info"
    type: string
  }


######################################################################
## Singular Campaign Mapping
######################################################################

  dimension: singular_device_id {
    group_label: "Singular Campaign Mapping"
    type:string}

  dimension: singular_partner_name {
    group_label: "Singular Campaign Mapping"
    type:string}

  dimension: singular_campaign_id {
    group_label: "Singular Campaign Mapping"
    type:string}

  dimension: singular_campaign_id_override {
    group_label: "Singular Campaign Mapping"
    type: string
    sql: @{singular_campaign_id_override} ;;
  }

  dimension: singular_created_date_override {
    group_label: "Singular Campaign Mapping"
    type: date
    sql: @{singular_created_date_override};;
  }

  dimension: singular_campaign_blended_window_override {
    group_label: "Singular Campaign Mapping"
    type: string
    sql: @{singular_campaign_blended_window_override} ;;
  }

  dimension: campaign_with_organics_estimate {
    group_label: "Singular Campaign Mapping"
    label: "Campaign with Organics (Estimate)"
    type: string
    sql: @{campaign_with_organics_estimate} ;;
  }

######################################################################
## Singular Creative Mapping
######################################################################

  dimension: singular_full_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
    sql: @{singular_full_ad_name} ;;
  }

  dimension: singular_creative_id {
    group_label: "Singular Creative Mapping"
    type: string
  }

  dimension: singular_grouped_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
    sql: @{singular_grouped_ad_name} ;;
  }

  dimension: singular_simple_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
    sql: @{singular_simple_ad_name} ;;
  }


######################################################################
## Expirements
######################################################################

  parameter: selected_experiment {
    type: string
    suggestions:  [
      "$.No_AB_Test_Split"

      , "$.swapTeamp2_20240209"
      , "$.goFishAds_20240208"
      , "$.dailyPopups_20240207"

      , "$.ExtraMoves1k_20240130"
      , "$.loAdMax_20240131"
      , "$.extendedQPO_20240131"

      , "$.blockColor_20240119"
      , "$.propBehavior_20240118"
      , "$.lv400500MovesTest_20240116"
      , "$.lv200300MovesTest_20240116"
      , "$.extraMovesOffering_20240111"

      ,"$.lv650800Moves_20240105"
      ,"$.lv100200Movesp2_20240103"
      ,"$.fueLevelsV3p2_20240102"
      ,"$.showLockedCharacters_20231215"
      ,"$.scrollableTT_20231213"
      ,"$.coinMultiplier_20231208"

      ,"$.lv100200Moves_20231207"
      ,"$.fueLevelsV3_20231207"
      ,"$.hapticv3_20231207"
      ,"$.swapTeam_20231206"
      ,"$.colorBoost_20231205"
      ,"$.lv300400MovesTest_20231207"

      ,"$.hudSquirrel_20231128"
      ,"$.blockSize_11152023"
      ,"$.lockedEvents_20231107"

      ,"$.coinPayout_20231108"

      ,"$.askForHelp_20231023"

      ,"$.coinPayout_20230824"

      ,"$.mustardPretzel_09262023"
      ,"$.chumPrompt_09262023"
      ,"$.dynamicRewardsRatio_20230922"
      ,"$.reducedMoves_20230919"
      ,"$.autoRestore_20230912"

      ,"$.goFish_20230915"

      ,"$.extraMoves_20230908"
      ,"$.spreadsheetMove_20230829"

      ,"$.steakSwap_20230823"
      ,"$.gravityTest_20230821"
      ,"$.colorballBehavior_20230828"

      ,"$.colorballBehavior_20230817"
      ,"$.askForHelp_20230816"
      ,"$.minigameGo_20230814"
      ,"$.puzzleLives_20230814"
      ,"$.propBehavior_20230814"
      ,"$.flourFrenzyRepeat_20230807"

      ,"$.dynamicDropBiasv4_20230802"
      ,"$.zonePayout_20230728"
      ,"$.propBehavior_20230726"

      ,"$.propBehavior_20230717"
      ,"$.zoneDrops_20230718"
      ,"$.zoneDrops_20230712"
      ,"$.hotdogContest_20230713"
      ,"$.fue1213_20230713"
      ,"$.magnifierRegen_20230711"
      ,"$.mMTiers_20230712"
      ,"$.dynamicDropBiasv3_20230627"
      ,"$.popupPri_20230628"
      ,"$.reactivationIAM_20230622"
      ,"$.playNext_20230612"
      ,"$.playNext_20230607"
      ,"$.playNext_20230503"
      ,"$.restoreBehavior_20230601"
      ,"$.moveTrim_20230601"
      ,"$.askForHelp_20230531"
      ,"$.hapticv2_20230524"
      ,"$.finalMoveAnim"
      ,"$.popUpManager_20230502"
      ,"$.fueSkip_20230425"
      ,"$.autoRestore_20230502"
      ,"$.playNext_20230503"
      ,"$.dynamicDropBiasv2_20230423"
      ,"$.puzzleEventv2_20230421"
      ,"$.bigBombs_20230410"
      ,"$.boardClear_20230410"
      ,"$.iceCreamOrder_20230419"
      ,"$.diceGame_20230419"
      ,"$.fueUnlocks_20230419"
      ,"$.haptic_20230326"
      ,"$.dynamicDropBias_20230329"
      ,"$.moldBehavior_20230329"
      ,"$.strawSkills_20230331"
      ,"$.mustardSingleClear_20230329"
      ,"$.puzzleEvent_20230318"
      ,"$.extraMoves_20230313"
      ,"$.fastLifeTimer_20230313"
      ,"$.frameRate_20230302"
      ,"$.navBar_20230228"
      ,"$.altFUE2_20221011"
      ,"$.altFUE2v2_20221024"
      ,"$.altFUE2v3_20221031"
      ,"$.autoPurchase_20221017"
      ,"$.blockSymbols_20221017"
      ,"$.blockSymbolFrames_20221027"
      ,"$.blockSymbolFrames2_20221109"
      ,"$.boardColor_01122023"
      ,"$.collection_01192023"
      ,"$.difficultyStars_09202022"
      ,"$.dynamicRewards_20221018"
      ,"$.extraMovesCurrency_20221017"
      ,"$.flourFrenzy_20221215"
      ,"$.fueDismiss_20221010"
      ,"$.fue00_v3_01182023"
      ,"$.gridGravity_20221003"
      ,"$.gridGravity2_20221012"
      ,"$.livesTimer_01092023"
      ,"$.MMads_01052023"
      ,"$.mMStreaks_09302022"
      ,"$.mMStreaksv2_20221031"
      ,"$.newLevelPass_20220926"
      ,"$.pizzaTime_01192023"
      ,"$.seedTest_20221028"
      ,"$.storeUnlock_20221102"
      ,"$.treasureTrove_20221114"
      ,"$.u2aFUE20221115"
      ,"$.u2ap2_FUE20221209"
      ,"$.vfxReduce_20221017"
      ,"$.vfxReduce_2_20221024"
      ,"$.zoneOrder2_09302022"
      ,"$.zoneStarCosts_09222022"]
  }

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  dimension: latest_experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.latest_experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  parameter: experiment_variant_1 {
    type: string
    suggestions:  [
      "control"
      ,"variant_a"
      ,"variant_b"
      ,"variant_c"
      ,"variant_d"]
  }

  dimension: experiment_variant_1_check {
    type: yesno
    sql:
      ${experiment_variant} = {% parameter experiment_variant_1 %}
      ;;
  }

  parameter: experiment_variant_2 {
    type: string
    suggestions:  [
      "control"
      ,"variant_a"
      ,"variant_b"
      ,"variant_c"
      ,"variant_c"]
  }

  dimension: experiment_variant_2_check {
    type: yesno
    sql:
      ${experiment_variant} = {% parameter experiment_variant_2 %}
      ;;
  }


  parameter: selected_significance_level {
    type: number
  }

  dimension: significance_level {
    type: number
    sql:
      {% parameter selected_significance_level %}
      ;;
  }

################################################################
## Available Total Revenue
################################################################

  measure: available_combined_dollars_d1 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_combined_dollars_d1
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d2 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_combined_dollars_d2
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d7 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_combined_dollars_d7
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d8 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_combined_dollars_d8
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d14 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.cumulative_combined_dollars_d14
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d21 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.cumulative_combined_dollars_d21
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d30 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.cumulative_combined_dollars_d30
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d60 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.cumulative_combined_dollars_d60
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d90 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.cumulative_combined_dollars_d90
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d120 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.cumulative_combined_dollars_d120
          else 0
          end )
    ;;
    value_format_name: usd

  }

################################################################
## Installs At Day X
################################################################

  measure: installs_at_d2 {
    group_label: "Installs At Day"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: installs_at_d7 {
    group_label: "Installs At Day"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: installs_at_d14 {
    group_label: "Installs At Day"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: installs_at_d30 {
    group_label: "Installs At Day"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }



################################################################
## Revenue Per Install
################################################################

  measure: revenue_per_install_d1 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_combined_dollars_d1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d2 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_combined_dollars_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d7 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_combined_dollars_d7
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d8 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_combined_dollars_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d14 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.cumulative_combined_dollars_d14
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d15 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.cumulative_combined_dollars_d15
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d21 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.cumulative_combined_dollars_d21
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d30 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.cumulative_combined_dollars_d30
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d31 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 31
          then ${TABLE}.cumulative_combined_dollars_d31
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 31
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }


  measure: revenue_per_install_d60 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.cumulative_combined_dollars_d60
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d61 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 61
          then ${TABLE}.cumulative_combined_dollars_d61
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 61
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d90 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.cumulative_combined_dollars_d90
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d120 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.cumulative_combined_dollars_d120
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

################################################################
## Cumulative Conversion
################################################################

  measure: cumulative_mtx_payers_current {
    label: "Sum IAP Spenders"
    group_label: "Cumulative Conversion"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.cumulative_mtx_purchase_dollars_current > 0
          then 1
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: cumulative_mtx_conversion_d1 {
    label: "Cumulative IAP Conversion: D1"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          and ${TABLE}.cumulative_mtx_purchase_dollars_d1 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d2 {
    label: "Cumulative IAP Conversion: D2"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          and ${TABLE}.cumulative_mtx_purchase_dollars_d2 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }


  measure: cumulative_mtx_conversion_d7 {
    label: "Cumulative IAP Conversion: D7"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          and ${TABLE}.cumulative_mtx_purchase_dollars_d7 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d8 {
    label: "Cumulative IAP Conversion: D8"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          and ${TABLE}.cumulative_mtx_purchase_dollars_d8 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d14 {
    label: "Cumulative IAP Conversion: D14"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          and ${TABLE}.cumulative_mtx_purchase_dollars_d14 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d30 {
    label: "Cumulative IAP Conversion: D30"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          and ${TABLE}.cumulative_mtx_purchase_dollars_d30 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d60 {
    label: "Cumulative IAP Conversion: D60"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          and ${TABLE}.cumulative_mtx_purchase_dollars_d60 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d90 {
    label: "Cumulative IAP Conversion: D90"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          and ${TABLE}.cumulative_mtx_purchase_dollars_d90 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }


################################################################
## Transactions Per Payer
################################################################

  measure: transactions_per_payer_d1 {
    label: "IAP Transactions Per Payer: D1"
    group_label: "IAP Transactions Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_count_mtx_purchases_d1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          and ${TABLE}.cumulative_count_mtx_purchases_d1 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: decimal_1

  }

  measure: transactions_per_payer_d2 {
    label: "IAP Transactions Per Payer: D2"
    group_label: "IAP Transactions Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_count_mtx_purchases_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          and ${TABLE}.cumulative_count_mtx_purchases_d2 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: decimal_1

  }

  measure: transactions_per_payer_d7 {
    label: "IAP Transactions Per Payer: D7"
    group_label: "IAP Transactions Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_count_mtx_purchases_d7
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          and ${TABLE}.cumulative_count_mtx_purchases_d7 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: decimal_1

  }

  measure: transactions_per_payer_d8 {
    label: "IAP Transactions Per Payer: D8"
    group_label: "IAP Transactions Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_count_mtx_purchases_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          and ${TABLE}.cumulative_count_mtx_purchases_d8 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: decimal_1

  }

################################################################
## Average Revenue Per Transaction
################################################################

  measure: average_revenue_per_transaction_d1 {
    label: "IAP Revenue Per Transaction: D1"
    group_label: "IAP Revenue Per Transaction"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_mtx_purchase_dollars_d1
          else 0
          end )
      ,
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_count_mtx_purchases_d1
          else 0
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_revenue_per_transaction_d2 {
    label: "IAP Revenue Per Transaction: D2"
    group_label: "IAP Revenue Per Transaction"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_mtx_purchase_dollars_d2
          else 0
          end )
      ,
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_count_mtx_purchases_d2
          else 0
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_revenue_per_transaction_d7 {
    label: "IAP Revenue Per Transaction: D7"
    group_label: "IAP Revenue Per Transaction"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_mtx_purchase_dollars_d7
          else 0
          end )
      ,
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_count_mtx_purchases_d7
          else 0
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_revenue_per_transaction_d8 {
    label: "IAP Revenue Per Transaction: D8"
    group_label: "IAP Revenue Per Transaction"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_mtx_purchase_dollars_d8
          else 0
          end )
      ,
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_count_mtx_purchases_d8
          else 0
          end )
    )
    ;;
    value_format_name: usd

  }

################################################################
## Average Mtx Revenue Per Paying User
################################################################

  measure: average_mtx_revenue_per_paying_user_d1 {
    label: "IAP Revenue Per Payer: D1"
    group_label: "Average IAP Revenue Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_mtx_purchase_dollars_d1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          and ${TABLE}.cumulative_count_mtx_purchases_d1 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_mtx_revenue_per_paying_user_d2 {
    label: "IAP Revenue Per Payer: D2"
    group_label: "Average IAP Revenue Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_mtx_purchase_dollars_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          and ${TABLE}.cumulative_count_mtx_purchases_d2 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_mtx_revenue_per_paying_user_d7 {
    label: "IAP Revenue Per Payer: D7"
    group_label: "Average IAP Revenue Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_mtx_purchase_dollars_d7
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          and ${TABLE}.cumulative_count_mtx_purchases_d7 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_mtx_revenue_per_paying_user_d8 {
    label: "IAP Revenue Per Payer: D8"
    group_label: "Average IAP Revenue Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_mtx_purchase_dollars_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          and ${TABLE}.cumulative_count_mtx_purchases_d8 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

################################################################
## Retention
################################################################

  measure: average_retention_d2 {
    group_label: "Average Retention"
    label: "D2"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.retention_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d2,available_player_count_d2]
  }

  measure: average_retention_d3 {
    group_label: "Average Retention"
    label: "D3"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 3
          then ${TABLE}.retention_d3
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 3
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d3,available_player_count_d3]
  }

  measure: average_retention_d4 {
    group_label: "Average Retention"
    label: "D4"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 4
          then ${TABLE}.retention_d4
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 4
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d4,available_player_count_d4]
  }

  measure: average_retention_d5 {
    group_label: "Average Retention"
    label: "D5"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 5
          then ${TABLE}.retention_d5
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 5
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d5,available_player_count_d5]
  }

  measure: average_retention_d6 {
    group_label: "Average Retention"
    label: "D6"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 6
          then ${TABLE}.retention_d6
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 6
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d6,available_player_count_d6]
  }

  measure: average_retention_d7 {
    group_label: "Average Retention"
    label: "D7"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.retention_d7
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d7,available_player_count_d7]
  }

  measure: average_retention_d8 {
    group_label: "Average Retention"
    label: "D8"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.retention_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d8,available_player_count_d8]
  }

  measure: average_retention_d9 {
    group_label: "Average Retention"
    label: "D9"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 9
          then ${TABLE}.retention_d9
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 9
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d9,available_player_count_d9]
  }

  measure: average_retention_d10 {
    group_label: "Average Retention"
    label: "D10"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 10
          then ${TABLE}.retention_d10
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 10
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d10,available_player_count_d10]
  }

  measure: average_retention_d11 {
    group_label: "Average Retention"
    label: "D11"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 11
          then ${TABLE}.retention_d11
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 11
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d11,available_player_count_d11]
  }

  measure: average_retention_d12 {
    group_label: "Average Retention"
    label: "D12"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 12
          then ${TABLE}.retention_d12
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 12
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d12,available_player_count_d12]
  }

  measure: average_retention_d13 {
    group_label: "Average Retention"
    label: "D13"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 13
          then ${TABLE}.retention_d13
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 13
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d13,available_player_count_d13]
  }

  measure: average_retention_d14 {
    group_label: "Average Retention"
    label: "D14"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.retention_d14
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d14,available_player_count_d14]
  }

  measure: average_retention_d21 {
    group_label: "Average Retention"
    label: "D21"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.retention_d21
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d21,available_player_count_d21]
  }

  measure: average_retention_d28 {
    group_label: "Average Retention"
    label: "D28"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 28
          then ${TABLE}.retention_d28
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 28
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d21,available_player_count_d21]
  }

  measure: average_retention_d30 {
    group_label: "Average Retention"
    label: "D30"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.retention_d30
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d30,available_player_count_d30]
  }

  measure: average_retention_d60 {
    group_label: "Average Retention"
    label: "D60"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.retention_d60
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d60,available_player_count_d60]
  }

  measure: average_retention_d90 {
    group_label: "Average Retention"
    label: "D90"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.retention_d90
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d90,available_player_count_d90]
  }

  measure: average_retention_d120 {
    group_label: "Average Retention"
    label: "D120"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.retention_d120
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: average_retention_d180 {
    group_label: "Average Retention"
    label: "D180"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 180
          then ${TABLE}.retention_d180
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 180
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: average_retention_d360 {
    group_label: "Average Retention"
    label: "D360"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 360
          then ${TABLE}.retention_d360
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 360
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: average_retention_d365 {
    group_label: "Average Retention"
    label: "D365"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 365
          then ${TABLE}.retention_d365
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 365
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

################################################################
## Big Fish Retention
################################################################

  measure: big_fish_retention_d1 {
    group_label: "Big Fish Retention"
    label: "Big Fish D1"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.retention_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d7 {
    group_label: "Big Fish Retention"
    label: "Big Fish D7"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.retention_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d14 {
    group_label: "Big Fish Retention"
    label: "Big Fish D14"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.retention_d15
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d30 {
    group_label: "Big Fish Retention"
    label: "Big Fish D30"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 31
          then ${TABLE}.retention_d31
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 31
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d45 {
    group_label: "Big Fish Retention"
    label: "Big Fish D45"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 46
          then ${TABLE}.retention_d46
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 46
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d60 {
    group_label: "Big Fish Retention"
    label: "Big Fish D60"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 61
          then ${TABLE}.retention_d61
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 61
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

################################################################
## Big Fish Combined Dollars
################################################################

  measure: big_fish_net_combined_dollars_d7 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D7"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d8;;
  }

  measure: big_fish_net_combined_dollars_d14 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D14"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d15;;
  }

  measure: big_fish_net_combined_dollars_d30 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D30"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d31;;
  }

  measure: big_fish_net_combined_dollars_d45 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D45"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d46;;
  }

  measure: big_fish_net_combined_dollars_d60 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D60"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d61;;
  }

################################################################
## Big Fish Net Mtx Dollars
################################################################

  measure: big_fish_net_mtx_dollars_d7 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D7"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d8;;
  }

  measure: big_fish_net_mtx_dollars_d14 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D14"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d15;;
  }

  measure: big_fish_net_mtx_dollars_d30 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D30"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d31;;
  }

  measure: big_fish_net_mtx_dollars_d45 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D45"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d46;;
  }

  measure: big_fish_net_mtx_dollars_d60 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D60"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d61;;
  }


################################################################
## Unique Player
################################################################

  measure: count_distinct_players {
    group_label: "Unique Player Counts"
    label: "Count Distinct Players"
    type: number
    sql:
    count( distinct ${TABLE}.rdg_id )
  ;;
    value_format_name: decimal_0

  }

################################################################
## Player Count By Day
################################################################

  measure: available_player_count_d1 {
    group_label: "Average Retention"
    label: "Total Installs"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d2 {
    group_label: "Average Retention"
    label: "Retention Denominator D2"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: available_player_count_d3 {
    group_label: "Average Retention"
    label: "Retention Denominator D3"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 3
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }
  measure: available_player_count_d4 {
    group_label: "Average Retention"
    label: "Retention Denominator D4"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 4
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }
  measure: available_player_count_d5 {
    group_label: "Average Retention"
    label: "Retention Denominator D5"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 5
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }
  measure: available_player_count_d6 {
    group_label: "Average Retention"
    label: "Retention Denominator D6"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 6
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }
  measure: available_player_count_d7 {
    group_label: "Average Retention"
    label: "Retention Denominator D7"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }
  measure: available_player_count_d8 {
    group_label: "Average Retention"
    label: "Retention Denominator D8"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }
  measure: available_player_count_d14 {
    group_label: "Average Retention"
    label: "Retention Denominator D14"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d21 {
    group_label: "Average Retention"
    label: "Retention Denominator D21"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d30 {
    group_label: "Average Retention"
    label: "Retention Denominator D30"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d60 {
    group_label: "Average Retention"
    label: "Retention Denominator D60"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d90 {
    group_label: "Average Retention"
    label: "Retention Denominator D90"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d120 {
    group_label: "Average Retention"
    label: "Retention Denominator D120"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

################################################################
## Engagement Milestones
################################################################

  measure: engagement_milestone_5_minutes {
    label: "5+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 5
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_15_minutes {
    label: "15+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 15
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_30_minutes {
    label: "30+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 30
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_60_minutes {
    label: "60+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 60
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_120_minutes {
    label: "120+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 120
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_360_minutes {
    label: "360+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 360
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

################################################################
## Engagement Milestones Numerator
################################################################

  measure: numerator_engagement_milestone_5_minutes {
    label: "5+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 5
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_15_minutes {
    label: "15+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 15
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_30_minutes {
    label: "30+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_60_minutes {
    label: "60+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_120_minutes {
    label: "120+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 120
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_360_minutes {
    label: "360+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 360
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

################################################################
## Retention Numerator
################################################################

  measure: numerator_retention_d2 {
    group_label: "Average Retention"
    label: "Retention Numerator D2"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.retention_d2
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d3 {
    group_label: "Average Retention"
    label: "Retention Numerator D3"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 3
          then ${TABLE}.retention_d3
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d4 {
    group_label: "Average Retention"
    label: "Retention Numerator D4"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 4
          then ${TABLE}.retention_d4
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d5 {
    group_label: "Average Retention"
    label: "Retention Numerator D5"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 5
          then ${TABLE}.retention_d5
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d6 {
    group_label: "Average Retention"
    label: "Retention Numerator D6"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 6
          then ${TABLE}.retention_d6
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d7 {
    group_label: "Average Retention"
    label: "Retention Numerator D7"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.retention_d7
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d8 {
    group_label: "Average Retention"
    label: "Retention Numerator D7"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.retention_d8
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d14 {
    group_label: "Average Retention"
    label: "Retention Numerator D14"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.retention_d14
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d21 {
    group_label: "Average Retention"
    label: "Retention Numerator D21"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.retention_d21
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d30 {
    group_label: "Average Retention"
    label: "Retention Numerator D30"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.retention_d30
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d60 {
    group_label: "Average Retention"
    label: "Retention Numerator D60"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.retention_d60
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d90 {
    group_label: "Average Retention"
    label: "Retention Numerator D90"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.retention_d90
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d120 {
    group_label: "Average Retention"
    label: "Retention Numerator D120"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.retention_d120
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }


  measure: average_total_campaigin_round_time_in_minutes_to_first_end_of_content_levels {
    group_label: "First End of Content Levels"
    label: "Average Campaign Minutes to First End of Content"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.total_campaigin_round_time_in_minutes_to_first_end_of_content_levels)
        ,
        count( distinct
          case
            when ${TABLE}.total_campaigin_round_time_in_minutes_to_first_end_of_content_levels is not null
            then ${TABLE}.rdg_id
            else null
            end
            )
      )
    ;;
    value_format_name: decimal_0
  }

  measure: count_players_to_ever_reach_end_of_content {
    group_label: "First End of Content Levels"
    label: "Count Players to Ever Reach End of Content"
    type: number
    sql:
      count( distinct
          case
            when ${TABLE}.total_campaigin_round_time_in_minutes_to_first_end_of_content_levels is not null
            then ${TABLE}.rdg_id
            else null
            end
            )
    ;;
    value_format_name: decimal_0
  }


  measure: count_players_to_have_not_played_in_at_least_14_days {
    group_label: "Churn"
    label: "Count Players to Have Not Played In 14+ Days "
    type: number
    sql:
      count( distinct
          case
            when date_diff(date(${TABLE}.latest_table_update),date(${TABLE}.last_played_date), day ) >= 14
            then ${TABLE}.rdg_id
            else null
            end
            )
    ;;
    value_format_name: decimal_0
  }

  measure: average_time_played_until_not_played_in_at_least_14_days {
    group_label: "Churn"
    label: "Average Minutes Played Until Churned for 14+ Days"
    type: number
    sql:
      safe_divide(
        sum(
          case
            when date_diff(date(${TABLE}.latest_table_update),date(${TABLE}.last_played_date), day ) >= 14
            then ${TABLE}.cumulative_time_played_minutes
            else null
            end
            )
        ,
        count( distinct
          case
            when date_diff(date(${TABLE}.latest_table_update),date(${TABLE}.last_played_date), day ) >= 14
            then ${TABLE}.rdg_id
            else null
            end
            )
        )

      ;;
    value_format_name: decimal_0
  }







}
