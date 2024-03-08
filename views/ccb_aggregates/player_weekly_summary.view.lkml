view: player_weekly_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-05-15'

      -- create or replace table tal_scratch.player_weekly_summary as

      with

      -----------------------------------------------------------
      -- pre_aggregate calculations
      -----------------------------------------------------------

      my_pre_aggregate_calculations as (

        select
          rdg_id
          , rdg_date
          , helper_functions.get_rdg_week(rdg_date) as rdg_week
          , 1 as count_weeks_played

          , last_value(device_id) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) device_id

          , last_value(advertising_id) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) advertising_id

          , last_value(user_id) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) user_id

          , last_value(display_name) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) display_name

          , last_value(platform) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) platform

          , last_value(country) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) country

          , first_value(created_date) over (
            partition by rdg_id -- first date EVER recorded, not by week
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) created_date

          , last_value(experiments) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) experiments

          , last_value(version) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) version

          , first_value(install_version) over (
            partition by rdg_id -- first date EVER recorded, not by week
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) install_version

          , ad_view_dollars
          , mtx_purchase_dollars
          , ad_views
          , case when ad_views > 0 then 1 else 0 end as daily_ad_view_indicator

          , ad_views_daily_rewards
          , ad_views_moves_master
          , ad_views_pizza
          , ad_views_lucky_dice
          , ad_views_ask_for_help
          , ad_views_battle_pass
          , ad_views_puzzles
          , ad_views_go_fish
          , ad_views_rocket
          , ad_views_lives
          , ad_views_magnifiers
          , ad_views_treasure_trove

          , ad_dollars_daily_rewards
          , ad_dollars_moves_master
          , ad_dollars_pizza
          , ad_dollars_lucky_dice
          , ad_dollars_ask_for_help
          , ad_dollars_battle_pass
          , ad_dollars_puzzles
          , ad_dollars_go_fish
          , ad_dollars_rocket
          , ad_dollars_lives
          , ad_dollars_magnifiers
          , ad_dollars_treasure_trove

          , count_sessions

          , last_value(cumulative_session_count) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_session_count

          , last_value(cumulative_engagement_ticks) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_engagement_ticks

          , round_start_events
          , round_end_events
          , round_end_events_campaign
          , round_end_events_movesmaster
          , round_end_events_puzzle
          , round_time_in_minutes
          , round_time_in_minutes_campaign
          , round_time_in_minutes_movesmaster
          , round_time_in_minutes_puzzle

          , first_value(lowest_last_level_serial) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) lowest_last_level_serial

          , last_value(highest_last_level_serial) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) highest_last_level_serial

          , last_value(highest_quests_completed) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) highest_quests_completed

          , gems_spend
          , coins_spend
          , stars_spend

          , last_value(ending_gems_balance) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) ending_gems_balance

          , last_value(ending_coins_balance) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) ending_coins_balance

          , last_value(ending_lives_balance) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) ending_lives_balance

          , last_value(ending_stars_balance) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) ending_stars_balance

          , last_value(hardware) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) hardware

          , last_value(processor_type) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) processor_type

          , last_value(graphics_device_name) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) graphics_device_name

          , last_value(device_model) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) device_model

          , last_value(system_memory_size) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) system_memory_size

          , last_value(graphics_memory_size) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) graphics_memory_size

          , last_value(screen_width) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) screen_width

          , last_value(screen_height) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) screen_height

          , last_value(end_of_content_levels) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) end_of_content_levels

          , last_value(end_of_content_zones) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) end_of_content_zones

          , last_value(current_zone) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) current_zone

          , last_value(current_zone_progress) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) current_zone_progress

          , first_value(created_date_timestamp) over (
            partition by rdg_id -- want first value ever
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) created_date_timestamp

          , first_value( helper_functions.get_rdg_week(created_date_timestamp) ) over (
            partition by rdg_id -- want first value ever
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) created_week

          , new_player_indicator
          , new_player_rdg_id
          , churn_indicator
          , churn_rdg_id

          , last_value(cumulative_mtx_purchase_dollars) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_mtx_purchase_dollars

          , last_value(cumulative_ad_view_dollars) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_ad_view_dollars

          , combined_dollars

          , last_value(cumulative_combined_dollars) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_combined_dollars

          , daily_mtx_spend_indicator
          , daily_mtx_spender_rdg_id
          , first_mtx_spend_indicator

          , last_value(lifetime_mtx_spend_indicator) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) lifetime_mtx_spend_indicator

          , last_value(lifetime_mtx_spender_rdg_id) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) lifetime_mtx_spender_rdg_id

          , last_value(cumulative_ad_views) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_ad_views

          , engagement_ticks
          , time_played_minutes

          , last_value(cumulative_time_played_minutes) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_time_played_minutes

          , last_value(cumulative_round_start_events) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_start_events

          , last_value(cumulative_round_end_events) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_end_events

          , last_value(cumulative_round_end_events_campaign) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_end_events_campaign

          , last_value(cumulative_round_end_events_movesmaster) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_end_events_movesmaster

          , last_value(cumulative_round_end_events_puzzle) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_end_events_puzzle

          , last_value(cumulative_round_time_in_minutes) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_time_in_minutes

          , last_value(cumulative_round_time_in_minutes_campaign) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_time_in_minutes_campaign

          , last_value(cumulative_round_time_in_minutes_movesmaster) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_time_in_minutes_movesmaster

          , last_value(cumulative_round_time_in_minutes_puzzle) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_round_time_in_minutes_puzzle

          , quests_completed
          , count_days_played

          , last_value(cumulative_count_days_played) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_count_days_played


          , levels_progressed

          , last_value(cumulative_gems_spend) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_gems_spend

          , last_value(cumulative_coins_spend) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_coins_spend

          , last_value(cumulative_star_spend) over (
            partition by rdg_id, helper_functions.get_rdg_week(rdg_date)
            order by rdg_date asc
            rows between unbounded preceding and unbounded following
            ) cumulative_star_spend

          -- feature participation
          , feature_participation_daily_reward
          , feature_participation_pizza_time
          , feature_participation_flour_frenzy
          , feature_participation_lucky_dice
          , feature_participation_treasure_trove


        from
          -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`
          ${player_daily_summary.SQL_TABLE_NAME}

      )

      ---------------------------------------------------------------------------
      -- weekly aggregate
      ---------------------------------------------------------------------------

      , my_weekly_aggregate as (

        select
          rdg_id
          , rdg_week
          , max(a.device_id) as device_id
          , max(a.advertising_id) as advertising_id
          , max(a.user_id) as user_id
          , max(a.display_name) as display_name
          , max(a.platform) as platform
          , max(a.country) as country
          , max(a.created_date) as created_date
          , max(a.experiments) as experiments
          , max(a.version) as version
          , max(a.install_version) as install_version

          , sum(a.mtx_purchase_dollars) as mtx_purchase_dollars
          , sum(a.ad_view_dollars) as ad_view_dollars
          , sum(a.combined_dollars) as combined_dollars

          , sum(a.daily_mtx_spend_indicator) as sum_daily_mtx_spend_indicator
          , max(a.daily_mtx_spend_indicator) as weekly_mtx_spend_indicator
          , max(a.daily_mtx_spender_rdg_id) as weekly_mtx_spender_rdg_id
          , max(a.first_mtx_spend_indicator) as first_mtx_spend_indicator

          , sum(a.ad_views) as ad_views
          , sum(daily_ad_view_indicator) as sum_daily_ad_view_indicator
          , max(daily_ad_view_indicator) as weekly_ad_view_indicator

          , sum( a.ad_views_daily_rewards) as ad_views_daily_rewards
          , sum( a.ad_views_moves_master) as ad_views_moves_master
          , sum( a.ad_views_pizza) as ad_views_pizza
          , sum( a.ad_views_lucky_dice) as ad_views_lucky_dice
          , sum( a.ad_views_ask_for_help) as ad_views_ask_for_help
          , sum( a.ad_views_battle_pass) as ad_views_battle_pass
          , sum( a.ad_views_puzzles) as ad_views_puzzles
          , sum( a.ad_views_go_fish) as ad_views_go_fish
          , sum( a.ad_views_rocket) as ad_views_rocket
          , sum( a.ad_views_lives) as ad_views_lives
          , sum( a.ad_views_magnifiers) as ad_views_magnifiers
          , sum( a.ad_views_treasure_trove) as ad_views_treasure_trove

          , sum( a.ad_dollars_daily_rewards) as ad_dollars_daily_rewards
          , sum( a.ad_dollars_moves_master) as ad_dollars_moves_master
          , sum( a.ad_dollars_pizza) as ad_dollars_pizza
          , sum( a.ad_dollars_lucky_dice) as ad_dollars_lucky_dice
          , sum( a.ad_dollars_ask_for_help) as ad_dollars_ask_for_help
          , sum( a.ad_dollars_battle_pass) as ad_dollars_battle_pass
          , sum( a.ad_dollars_puzzles) as ad_dollars_puzzles
          , sum( a.ad_dollars_go_fish) as ad_dollars_go_fish
          , sum( a.ad_dollars_rocket) as ad_dollars_rocket
          , sum( a.ad_dollars_lives) as ad_dollars_lives
          , sum( a.ad_dollars_magnifiers) as ad_dollars_magnifiers
          , sum( a.ad_dollars_treasure_trove) as ad_dollars_treasure_trove

          , sum(a.count_sessions) as count_sessions
          , max(a.cumulative_session_count) as cumulative_session_count
          , max(a.cumulative_engagement_ticks) as cumulative_engagement_ticks
          , sum(a.round_start_events) as round_start_events
          , sum(a.round_end_events) as round_end_events
          , sum(a.round_end_events_campaign) as round_end_events_campaign
          , sum(a.round_end_events_movesmaster) as round_end_events_movesmaster
          , sum(a.round_end_events_puzzle) as round_end_events_puzzle
          , sum(a.round_time_in_minutes) as round_time_in_minutes
          , sum(a.round_time_in_minutes_campaign) as round_time_in_minutes_campaign
          , sum(a.round_time_in_minutes_movesmaster) as round_time_in_minutes_movesmaster
          , sum(a.round_time_in_minutes_puzzle) as round_time_in_minutes_puzzle
          , min(a.lowest_last_level_serial) as lowest_last_level_serial
          , max(a.highest_last_level_serial) as highest_last_level_serial
          , max(a.highest_quests_completed) as highest_quests_completed
          , sum(a.gems_spend) as gems_spend
          , sum(a.coins_spend) as coins_spend
          , sum(a.stars_spend) as stars_spend
          , max(a.ending_gems_balance) as ending_gems_balance
          , max(a.ending_coins_balance) as ending_coins_balance
          , max(a.ending_lives_balance) as ending_lives_balance
          , max(a.ending_stars_balance) as ending_stars_balance
          , max(a.hardware) as hardware
          , max(a.processor_type) as processor_type
          , max(a.graphics_device_name) as graphics_device_name
          , max(a.device_model) as device_model
          , max(a.system_memory_size) as system_memory_size
          , max(a.graphics_memory_size) as graphics_memory_size
          , max(a.screen_width) as screen_width
          , max(a.screen_height) as screen_height
          , max(a.end_of_content_levels) as end_of_content_levels
          , max(a.end_of_content_zones) as end_of_content_zones
          , max(a.current_zone) as current_zone
          , max(a.current_zone_progress) as current_zone_progress
          , min(a.created_date_timestamp) as created_date_timestamp
          , min(a.created_week) as created_week
          , max(a.new_player_indicator) as new_player_indicator
          , max(a.new_player_rdg_id) as new_player_rdg_id
          , max(a.churn_indicator) as churn_indicator
          , max(a.churn_rdg_id) as churn_rdg_id
          , max(a.cumulative_mtx_purchase_dollars) as cumulative_mtx_purchase_dollars
          , max(a.cumulative_ad_view_dollars) as cumulative_ad_view_dollars

          , max(a.cumulative_combined_dollars) as cumulative_combined_dollars

          , max(a.lifetime_mtx_spend_indicator) as lifetime_mtx_spend_indicator
          , max(a.lifetime_mtx_spender_rdg_id) as lifetime_mtx_spender_rdg_id
          , max(a.cumulative_ad_views) as cumulative_ad_views
          , sum(a.engagement_ticks) as engagement_ticks
          , sum(a.time_played_minutes) as time_played_minutes
          , max(a.cumulative_time_played_minutes) as cumulative_time_played_minutes
          , max(a.cumulative_round_start_events) as cumulative_round_start_events
          , max(a.cumulative_round_end_events) as cumulative_round_end_events
          , max(a.cumulative_round_end_events_campaign) as cumulative_round_end_events_campaign
          , max(a.cumulative_round_end_events_movesmaster) as cumulative_round_end_events_movesmaster
          , max(a.cumulative_round_end_events_puzzle) as cumulative_round_end_events_puzzle
          , max(a.cumulative_round_time_in_minutes) as cumulative_round_time_in_minutes
          , max(a.cumulative_round_time_in_minutes_campaign) as cumulative_round_time_in_minutes_campaign
          , max(a.cumulative_round_time_in_minutes_movesmaster) as cumulative_round_time_in_minutes_movesmaster
          , max(a.cumulative_round_time_in_minutes_puzzle) as cumulative_round_time_in_minutes_puzzle
          , sum(a.quests_completed) as quests_completed
          , sum(a.count_days_played) as count_days_played
          , max(a.count_weeks_played) as count_weeks_played
          , max(a.cumulative_count_days_played) as cumulative_count_days_played
          , sum(a.levels_progressed) as levels_progressed
          , max(a.cumulative_gems_spend) as cumulative_gems_spend
          , max(a.cumulative_coins_spend) as cumulative_coins_spend
          , max(a.cumulative_star_spend) as cumulative_star_spend

          -- feature participation
          , max( a.feature_participation_daily_reward ) as feature_participation_daily_reward
          , max( a.feature_participation_pizza_time ) as feature_participation_pizza_time
          , max( a.feature_participation_flour_frenzy ) as feature_participation_flour_frenzy
          , max( a.feature_participation_lucky_dice ) as feature_participation_lucky_dice
          , max( a.feature_participation_treasure_trove ) as feature_participation_treasure_trove

        from
          my_pre_aggregate_calculations a
        group by
          1,2
      )

      ---------------------------------------------------------------------------
      -- my_table_calculations_on_weekly_aggregates
      ---------------------------------------------------------------------------

      -- remember for post aggregate calculation

      -- new/returning/winback



      , my_table_calculations_on_weekly_aggregates as (

        select
          *

          , lag(rdg_week,1) over (
            partition by rdg_id
            order by rdg_week asc
            ) as week_last_played

          , date_diff(
            date(rdg_week)
            , lag(date(rdg_week),1) over (
              partition by rdg_id
              order by rdg_week asc )
            , week
            ) as weeks_since_last_played

          , date_diff(date(rdg_week), date(created_week), week(monday)) as weeks_since_created_week

          , 1 + date_diff(date(rdg_week), date(created_week), week(monday)) as week_number

        from
          my_weekly_aggregate

      )

      ---------------------------------------------------------------------------
      -- select * from my_table_calculations_on_weekly_aggregates
      -- completed weeks only
      ---------------------------------------------------------------------------

      select
        *
      from
        my_table_calculations_on_weekly_aggregates
      where
        rdg_week <= timestamp(date_add(date_trunc(current_date(),week(monday)), interval - 1 week))



      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -5 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_week"]

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.rdg_week
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Custom Dimensions
################################################################

  # dates
  dimension_group: rdg_week {
    group_label: "Activity Weeks"
    label: "Activity Week"
    type: time
    timeframes: [week]
    sql: ${TABLE}.rdg_week ;;
  }
  dimension_group: created_week {
    group_label: "Install Week"
    label: "Installed On"
    type: time
    timeframes: [week]
    sql: ${TABLE}.created_week ;;
  }

  dimension: lowest_last_level_serial_bin {
    type: bin
    bins: [0,50,150,250,400,600,800,1000]
    style: interval
    sql: ${TABLE}.lowest_last_level_serial ;;
  }

  ## player age bins
  dimension: player_week_number_bin {
    type:  tier
    style: integer
    tiers: [0,1,2,4,8,26,52]
    sql: ${TABLE}.week_number ;;
  }

################################################################
## Generic Dimensions
################################################################

  dimension: rdg_id {type:string}
  dimension: device_id {type:string}
  dimension: advertising_id {type:string}
  dimension: user_id {type:string}
  dimension: display_name {type:string}
  dimension: platform {type:string}
  dimension: country {type:string}
  dimension: experiments {type:string}
  dimension: version {type:string}
  dimension: install_version {type:string}
  dimension: mtx_purchase_dollars {type:number label: "IAP Dollars"}
  dimension: ad_view_dollars {type:number label: "IAA Dollars"}
  dimension: combined_dollars {type:number}
  dimension: sum_daily_mtx_spend_indicator {type:number label: "Sum Daily IAP Spend Indicator"}
  dimension: weekly_mtx_spend_indicator {type:number label: "Weekly IAP Spend Indicator"}
  dimension: weekly_mtx_spender_rdg_id {type:string label: "Weekly IAP Spend Rdg Id"}
  dimension: first_mtx_spend_indicator {type:number label: "First IAP Spend Indicator"}
  dimension: ad_views {type:number label: "IAA Views"}
  dimension: sum_daily_ad_view_indicator {type:number label: "Sum Daily IAA View Indicator"}
  dimension: weekly_ad_view_indicator {type:number label: "Weekly IAA View Indicator"}
  dimension: count_sessions {type:number}
  dimension: cumulative_session_count {type:number}
  dimension: cumulative_engagement_ticks {type:number}
  dimension: round_start_events {type:number}
  dimension: round_end_events {type:number}
  dimension: round_end_events_campaign {type:number}
  dimension: round_end_events_movesmaster {type:number}
  dimension: round_end_events_puzzle {type:number}
  dimension: round_time_in_minutes {type:number}
  dimension: round_time_in_minutes_campaign {type:number}
  dimension: round_time_in_minutes_movesmaster {type:number}
  dimension: round_time_in_minutes_puzzle {type:number}
  dimension: lowest_last_level_serial {type:number}
  dimension: highest_last_level_serial {type:number}
  dimension: highest_quests_completed {type:number}
  dimension: coins_spend {type:number}
  dimension: stars_spend {type:number}
  dimension: ending_coins_balance {type:number}
  dimension: ending_lives_balance {type:number}
  dimension: ending_stars_balance {type:number}
  dimension: hardware {type:string}
  dimension: processor_type {type:string}
  dimension: graphics_device_name {type:string}
  dimension: device_model {type:string}
  dimension: system_memory_size {type:number}
  dimension: graphics_memory_size {type:number}
  dimension: screen_width {type:string}
  dimension: screen_height {type:string}
  dimension: end_of_content_levels {type:yesno}
  dimension: end_of_content_zones {type:yesno}
  dimension: current_zone {type:number}
  dimension: current_zone_progress {type:number}
  dimension: new_player_indicator {type:number}
  dimension: new_player_rdg_id {type:string}
  dimension: churn_indicator {type:number}
  dimension: churn_rdg_id {type:string}
  dimension: cumulative_mtx_purchase_dollars {type:number label: "LTV - IAP"}
  dimension: cumulative_ad_view_dollars {type:number label: "LTV - IAA"}
  dimension: cumulative_combined_dollars {value_format:"$#.00" type:number label: "LTV - Combined"}
  dimension: lifetime_mtx_spend_indicator {type:number label: "Lifetime IAP Spend Indicator"}
  dimension: lifetime_mtx_spender_rdg_id {type:string label: "Lifetime IAP Spend Rdg Id"}
  dimension: cumulative_ad_views {type:number label: "Cumulative IAA Views"}
  dimension: engagement_ticks {type:number}
  dimension: time_played_minutes {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: cumulative_round_start_events {type:number}
  dimension: cumulative_round_end_events {type:number}
  dimension: cumulative_round_end_events_campaign {type:number}
  dimension: cumulative_round_end_events_movesmaster {type:number}
  dimension: cumulative_round_end_events_puzzle {type:number}
  dimension: cumulative_round_time_in_minutes {type:number}
  dimension: cumulative_round_time_in_minutes_campaign {type:number}
  dimension: cumulative_round_time_in_minutes_movesmaster {type:number}
  dimension: cumulative_round_time_in_minutes_puzzle {type:number}
  dimension: quests_completed {type:number}
  dimension: count_days_played {type:number}
  dimension: count_weeks_played {type:number}
  dimension: cumulative_count_days_played {type:number}
  dimension: levels_progressed {type:number}
  dimension: cumulative_gems_spend {type:number}
  dimension: cumulative_coins_spend {type:number}
  dimension: cumulative_star_spend {type:number}
  dimension: weeks_since_last_played {type:number}
  dimension: weeks_since_created_week {type:number}
  dimension: week_number {type:number}
  dimension: new_returning_winback {
    type: string
    sql:
      case
        when weeks_since_last_played is null then 'New'
        when weeks_since_last_played <= 1 then 'Returning'
        else 'Winback'
        end
    ;;
  }

################################################################
## Unique Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
    drill_fields: [display_name,rdg_id,install_version,created_week_week,cumulative_combined_dollars]
  }
  measure: count_distinct_new_player_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    value_format: "#,###"
    sql: ${TABLE}.new_player_rdg_id ;;
  }
  measure: count_distinct_churn_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.churn_rdg_id ;;
  }
  measure: count_distinct_daily_mtx_spender_rdg_id {
    label: "Count Distinct IAP Spenders"
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: count_distinct_lifetime_mtx_spender_rdg_id {
    label: "Count Distinct Lifetime IAP Spenders"
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.lifetime_mtx_spender_rdg_id ;;
  }

################################################################
## Average Daily Numbers
################################################################

  measure: average_daily_active_users {
    group_label: "Average Daily Numbers"
    label: "Average Daily Active Users (DAU)"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_days_played)
        ,
        sum(${TABLE}.count_weeks_played)
      )
    ;;
    value_format_name: decimal_0
  }

################################################################
## Other Calculations
################################################################

  measure: percent_players_playing_rounds {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_campaign {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_campaign > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }
  measure: percent_players_playing_movesmaster {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_movesmaster > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_puzzle {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_puzzle > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: churn_rate {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct ${TABLE}.churn_rdg_id )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

################################################################
## Revenue Metrics
################################################################

  measure: average_mtx_purchase_revenue_per_player{
    label: "Average IAP Revenue Per Player"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }

  measure: average_mtx_purchase_revenue_per_player_per_day{
    label: "Average IAP Revenue Per DAU"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: usd
  }

  measure: average_daily_mtx_conversion {
    label: "Average Daily IAP Conversion"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.daily_mtx_spend_indicator)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: percent_1
  }

  measure: average_ad_revenue_per_player{
    label: "Average IAA Revenue Per Player"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_view_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }

  measure: average_ad_revenue_per_player_per_day{
    label: "Average IAA Revenue Per DAU"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_view_dollars)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: usd
  }

  measure: average_daily_ads_conversion {
    label: "Average Daily IAA Conversion"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.sum_daily_ad_view_indicator )
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: percent_1
  }

  measure: average_combined_revenue_per_player{
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.combined_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }

  measure: average_combined_revenue_per_player_per_day{
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.combined_dollars)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: usd
  }

  measure: sum_mtx_purchase_dollars {
    label: "Sum IAP Dollars"
    group_label: "Revenue Metrics"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: sum_ad_view_dollars {
    label: "Sum IAA Dollars"
    group_label: "Revenue Metrics"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: sum_combined_dollars {
    group_label: "Revenue Metrics"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.combined_dollars ;;
  }

  measure: percent_players_engaged_with_treasure_trove {
    group_label: "Daily Feature Participation"
    label: "Treasure Trove"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_treasure_trove > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_lucky_dice {
    group_label: "Daily Feature Participation"
    label: "Lucky Dice"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_lucky_dice > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_flour_frenzy {
    group_label: "Daily Feature Participation"
    label: "Flour Frenzy"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_flour_frenzy > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_pizza_time {
    group_label: "Daily Feature Participation"
    label: "Pizza Time"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_pizza_time > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_daily_reward {
    group_label: "Daily Feature Participation"
    label: "Daily Reward"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_daily_reward > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
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

################################################################
## Coin Spend Per Round
################################################################

  measure: coin_spend_per_round_10 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 10
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: coin_spend_per_round_25 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 25
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: coin_spend_per_round_50 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 50
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: coin_spend_per_round_75 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 75
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: coin_spend_per_round_95 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 95
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

################################################################
## Round End Events
################################################################

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

  measure: sum_round_end_events_campaign {
  group_label: "Round End Events Campaign"
  type:sum
  sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_10 {
  group_label: "Round End Events Campaign"
  type: percentile
  percentile: 10
  sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_25 {
  group_label: "Round End Events Campaign"
  type: percentile
  percentile: 25
  sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_50 {
  group_label: "Round End Events Campaign"
  type: percentile
  percentile: 50
  sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_75 {
  group_label: "Round End Events Campaign"
  type: percentile
  percentile: 75
  sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_95 {
  group_label: "Round End Events Campaign"
  type: percentile
  percentile: 95
  sql: ${TABLE}.round_end_events_campaign ;;
  }

################################################################
## Ending Coins Balance
################################################################

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

################################################################
## MTX Spend Distribution
################################################################

  measure: mtx_purchase_dollars_10 {
    label: "10th Percentile"
    group_label: "Weekly IAP Dollars Distribution"
    type: percentile
    percentile: 10
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_25 {
    label: "25th Percentile"
    group_label: "Weekly IAP Dollars Distribution"
    type: percentile
    percentile: 25
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_50 {
    label: "50th Percentile"
    group_label: "Weekly IAP Dollars Distribution"
    type: percentile
    percentile: 50
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_75 {
    label: "75th Percentile"
    group_label: "Weekly IAP Dollars Distribution"
    type: percentile
    percentile: 75
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_95 {
    label: "95th Percentile"
    group_label: "Weekly IAP Dollars Distribution"
    type: percentile
    percentile: 95
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }

################################################################
## Ad Dollars Distribution
################################################################

  measure: ad_view_dollars_10 {
    label: "10th Percentile"
    group_label: "Weekly IAA Dollars Distribution"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_25 {
    label: "25th Percentile"
    group_label: "Weekly IAA Dollars Distribution"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_50 {
    label: "Median"
    group_label: "Weekly IAA Dollars Distribution"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_75 {
    label: "75th Percentile"
    group_label: "Weekly IAA Dollars Distribution"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_95 {
    label: "95th Percentile"
    group_label: "Weekly IAA Dollars Distribution"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_view_dollars ;;
  }

################################################################
## Ad View Distribution
################################################################

  measure: ad_views_10 {
    label: "10th Percentile"
    group_label: "Weekly IAA Views Distribution"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_25 {
    label: "25th Percentile"
    group_label: "Weekly IAA Views Distribution"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_50 {
    label: "Median"
    group_label: "Weekly IAA Views Distribution"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_75 {
    label: "75th Percentile"
    group_label: "Weekly IAA Views Distribution"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_95 {
    label: "95th Percentile"
    group_label: "Weekly IAA Views Distribution"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_views ;;
  }

################################################################
## Ad Views By Placement
################################################################

  dimension: ad_views_daily_rewards {
    group_label: "IAA Views By Placement"
    label: "Daily Rewards"
    value_format_name: decimal_0
  }

  dimension: ad_views_moves_master {
    group_label: "IAA Views By Placement"
    label: "Moves Master"
    value_format_name: decimal_0
  }

  dimension: ad_views_pizza {
    group_label: "IAA Views By Placement"
    label: "Pizza Time"
    value_format_name: decimal_0
  }

  dimension: ad_views_lucky_dice {
    group_label: "IAA Views By Placement"
    label: "Lucky Dice"
    value_format_name: decimal_0
  }

  dimension: ad_views_ask_for_help {
    group_label: "IAA Views By Placement"
    label: "Ask For Help"
    value_format_name: decimal_0
  }

  dimension: ad_views_battle_pass {
    group_label: "IAA Views By Placement"
    label: "Battle Pass"
    value_format_name: decimal_0
  }

  dimension: ad_views_puzzles {
    group_label: "IAA Views By Placement"
    label: "Puzzles"
    value_format_name: decimal_0
  }

  dimension: ad_views_go_fish {
    group_label: "IAA Views By Placement"
    label: "Go Fish"
    value_format_name: decimal_0
  }

  dimension: ad_views_rocket {
    group_label: "IAA Views By Placement"
    label: "Rocket"
    value_format_name: decimal_0
  }

  dimension: ad_views_lives {
    group_label: "Ad View By Placement"
    label: "Lives"
    value_format_name: decimal_0
  }

  dimension: ad_views_magnifiers {
    group_label: "IAA Views By Placement"
    label: "Magnifiers"
    value_format_name: decimal_0
  }

  dimension: ad_views_treasure_trove {
    group_label: "IAA Views By Placement"
    label: "Treasure Trove"
    value_format_name: decimal_0
  }

################################################################
## Ad Dollars By Placement
################################################################

  dimension: ad_dollars_daily_rewards {
    group_label: "IAA Dollars By Placement"
    label: "Daily Rewards IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_moves_master {
    group_label: "IAA Dollars By Placement"
    label: "Moves Master IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_pizza {
    group_label: "IAA Dollars By Placement"
    label: "Pizza IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_lucky_dice {
    group_label: "IAA Dollars By Placement"
    label: "Lucky Dice IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_ask_for_help {
    group_label: "IAA Dollars By Placement"
    label: "Ask For Help IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_battle_pass {
    group_label: "IAA Dollars By Placement"
    label: "Battle Pass IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_puzzles {
   group_label: "IAA Dollars By Placement"
    label: "Puzzles IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_go_fish {
    group_label: "IAA Dollars By Placement"
    label: "Go Fish IAA Dollars"
    value_format_name: decimal_0
  }

  dimension: ad_dollars_rocket {
    group_label: "IAA Dollars By Placement"
    label: "Rocket IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_lives {
    group_label: "IAA Dollars By Placement"
    label: "Lives IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_magnifiers {
    group_label: "IAA Dollars By Placement"
    label: "Magnifiers IAA Dollars"
    value_format_name: decimal_4
  }

  dimension: ad_dollars_treasure_trove {
    group_label: "IAA Dollars By Placement"
    label: "Treasure Trove IAA Dollars"
    value_format_name: decimal_4
  }











}
