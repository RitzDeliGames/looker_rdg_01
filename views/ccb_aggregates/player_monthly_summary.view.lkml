view: player_monthly_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-07-11'

      -- create or replace table tal_scratch.player_monthly_summary as

with

-----------------------------------------------------------
-- pre_aggregate calculations
-----------------------------------------------------------

my_pre_aggregate_calculations as (

  select
    rdg_id
    , rdg_date
    , helper_functions.get_rdg_month(rdg_date) as rdg_month
    , 1 as count_months_played

    , last_value(device_id) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) device_id

    , last_value(advertising_id) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) advertising_id

    , last_value(user_id) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) user_id

    , last_value(display_name) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) display_name

    , last_value(platform) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) platform

    , last_value(country) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) country

    , first_value(created_date) over (
      partition by rdg_id -- first date EVER recorded, not by week
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) created_date

    , last_value(experiments) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) experiments

    , last_value(version) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
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
    , mtx_purchase_dollars_15
    , ad_views
    , case when ad_views > 0 then 1 else 0 end as daily_ad_view_indicator
    , count_sessions

    , last_value(cumulative_session_count) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_session_count

    , last_value(cumulative_engagement_ticks) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
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
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) lowest_last_level_serial

    , last_value(highest_last_level_serial) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) highest_last_level_serial

    , coins_spend
    , stars_spend

    , last_value(ending_coins_balance) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) ending_coins_balance

    , last_value(ending_lives_balance) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) ending_lives_balance

    , last_value(ending_stars_balance) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) ending_stars_balance

    , last_value(hardware) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) hardware

    , last_value(processor_type) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) processor_type

    , last_value(graphics_device_name) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) graphics_device_name

    , last_value(device_model) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) device_model

    , last_value(system_memory_size) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) system_memory_size

    , last_value(graphics_memory_size) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) graphics_memory_size

    , last_value(screen_width) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) screen_width

    , last_value(screen_height) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) screen_height

    , last_value(end_of_content_levels) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) end_of_content_levels

    , last_value(end_of_content_zones) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) end_of_content_zones

    , last_value(current_zone) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) current_zone

    , first_value(created_date_timestamp) over (
      partition by rdg_id -- want first value ever
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) created_date_timestamp

    , first_value( helper_functions.get_rdg_month(created_date_timestamp) ) over (
      partition by rdg_id -- want first value ever
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) created_month

    , new_player_indicator
    , new_player_rdg_id
    , churn_indicator
    , churn_rdg_id

    , last_value(cumulative_mtx_purchase_dollars) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_mtx_purchase_dollars

    , last_value(cumulative_mtx_purchase_dollars_15) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_mtx_purchase_dollars_15

    , last_value(cumulative_ad_view_dollars) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_ad_view_dollars

    , combined_dollars

    , last_value(cumulative_combined_dollars) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_combined_dollars

    , daily_mtx_spend_indicator
    , daily_mtx_spender_rdg_id
    , first_mtx_spend_indicator

    , last_value(lifetime_mtx_spend_indicator) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) lifetime_mtx_spend_indicator

    , last_value(lifetime_mtx_spender_rdg_id) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) lifetime_mtx_spender_rdg_id

    , last_value(cumulative_ad_views) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_ad_views

    , engagement_ticks
    , time_played_minutes

    , last_value(cumulative_time_played_minutes) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_time_played_minutes

    , last_value(cumulative_round_start_events) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_start_events

    , last_value(cumulative_round_end_events) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_end_events

    , last_value(cumulative_round_end_events_campaign) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_end_events_campaign

    , last_value(cumulative_round_end_events_movesmaster) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_end_events_movesmaster

    , last_value(cumulative_round_end_events_puzzle) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_end_events_puzzle

    , last_value(cumulative_round_time_in_minutes) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_time_in_minutes

    , last_value(cumulative_round_time_in_minutes_campaign) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_time_in_minutes_campaign

    , last_value(cumulative_round_time_in_minutes_movesmaster) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_time_in_minutes_movesmaster

    , last_value(cumulative_round_time_in_minutes_puzzle) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_round_time_in_minutes_puzzle

    , count_days_played

    , last_value(cumulative_count_days_played) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_count_days_played


    , levels_progressed

    , last_value(cumulative_coins_spend) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
      order by rdg_date asc
      rows between unbounded preceding and unbounded following
      ) cumulative_coins_spend

    , last_value(cumulative_star_spend) over (
      partition by rdg_id, helper_functions.get_rdg_month(rdg_date)
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
-- monthly aggregate
---------------------------------------------------------------------------

, my_monthly_aggregate as (

  select
    rdg_id
    , rdg_month
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
    , sum(a.mtx_purchase_dollars_15) as mtx_purchase_dollars_15
    , sum(a.ad_view_dollars) as ad_view_dollars
    , sum(a.combined_dollars) as combined_dollars

    , sum(a.daily_mtx_spend_indicator) as sum_daily_mtx_spend_indicator
    , max(a.daily_mtx_spend_indicator) as monthly_mtx_spend_indicator
    , max(a.daily_mtx_spender_rdg_id) as monthly_mtx_spender_rdg_id
    , max(a.first_mtx_spend_indicator) as first_mtx_spend_indicator

    , sum(a.ad_views) as ad_views
    , sum(daily_ad_view_indicator) as sum_daily_ad_view_indicator
    , max(daily_ad_view_indicator) as monthly_ad_view_indicator

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
    , sum(a.coins_spend) as coins_spend
    , sum(a.stars_spend) as stars_spend
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
    , min(a.created_date_timestamp) as created_date_timestamp
    , min(a.created_month) as created_month
    , max(a.new_player_indicator) as new_player_indicator
    , max(a.new_player_rdg_id) as new_player_rdg_id
    , max(a.churn_indicator) as churn_indicator
    , max(a.churn_rdg_id) as churn_rdg_id
    , max(a.cumulative_mtx_purchase_dollars) as cumulative_mtx_purchase_dollars
    , max(a.cumulative_mtx_purchase_dollars_15) as cumulative_mtx_purchase_dollars_15
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
    , sum(a.count_days_played) as count_days_played
    , max(a.count_months_played) as count_months_played
    , max(a.cumulative_count_days_played) as cumulative_count_days_played
    , sum(a.levels_progressed) as levels_progressed
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
-- my_table_calculations_on_monthly_aggregates
---------------------------------------------------------------------------

, my_table_calculations_on_monthly_aggregates as (

  select
    *

    , lag(rdg_month,1) over (
      partition by rdg_id
      order by rdg_month asc
      ) as month_last_played

    , date_diff(
      date(rdg_month)
      , lag(date(rdg_month),1) over (
        partition by rdg_id
        order by rdg_month asc )
      , month
      ) as months_since_last_played

    , date_diff(date(rdg_month), date(created_month), month) as months_since_created_month

    , 1 + date_diff(date(rdg_month), date(created_month), month) as month_number

  from
    my_monthly_aggregate

)

---------------------------------------------------------------------------
-- select * from my_table_calculations_on_monthly_aggregates
-- completed months only
---------------------------------------------------------------------------

select
  *
from
  my_table_calculations_on_monthly_aggregates
where
  rdg_month <= timestamp(date_add(date_trunc(current_date(),month), interval - 1 month))



      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -5 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_month"]

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.rdg_month
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

################################################################
## Dimensions
################################################################

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  # dates
  dimension_group: rdg_rdg_month {
    group_label: "Activity Month"
    label: "Activity Month"
    type: time
    timeframes: [month]
    sql: ${TABLE}.rdg_month ;;
  }
  dimension_group: created_month {
    group_label: "Install Month"
    label: "Installed On"
    type: time
    timeframes: [month]
    sql: ${TABLE}.created_month ;;
  }

  dimension: lowest_last_level_serial_bin {
    type: bin
    bins: [0,50,150,250,400,600,800,1000]
    style: interval
    sql: ${TABLE}.lowest_last_level_serial ;;
  }

  ## player age bins
  dimension: player_month_number_bin {
    type:  tier
    style: integer
    tiers: [0,1,2,4,8,26,52]
    sql: ${TABLE}.week_month ;;
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
  dimension: mtx_purchase_dollars {
    label: "IAP Dollars - 30%"
    type:number}
  dimension: mtx_purchase_dollars_15 {
    label: "IAP Dollars - 15%"
    type:number}
  dimension: ad_view_dollars {
    label: "IAA Dollars"
    type:number}
  dimension: combined_dollars {type:number}
  dimension: sum_daily_mtx_spend_indicator {
    label: "Sum Daily IAP Spend Indicator"
    type:number}
  dimension: monthly_mtx_spend_indicator {
    label: "Monthly IAP Spend Indicator"
    type:number}
  dimension: monthly_mtx_spender_rdg_id {
    label: "Monthly IAP Spender Rdg Id"
    type:string}
  dimension: first_mtx_spend_indicator {
    label: "First IAP Spend Indicator"
    type:number}
  dimension: ad_views {
    label: "IAA Views"
    type:number}
  dimension: sum_daily_ad_view_indicator {
    label: "Sum Daily IAA View Indicator"
    type:number
    }
  dimension: monthly_ad_view_indicator {
    label: "Monthly IAA View Indicator"
    type:number}
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
  dimension: new_player_indicator {type:number}
  dimension: new_player_rdg_id {type:string}
  dimension: churn_indicator {type:number}
  dimension: churn_rdg_id {type:string}
  dimension: cumulative_mtx_purchase_dollars {
    label: "Cumulative IAP Dollars - 30%"
    value_format:"$#.00"
    type:number}
  dimension: cumulative_mtx_purchase_dollars_15 {
    label: "Cumulative IAP Dollars - 15%"
    value_format:"$#.00"
    type:number}
  dimension: cumulative_ad_view_dollars {
    label: "Cumulative IAA Dollars"
    value_format:"$#.00"
    type:number
    }
  dimension: cumulative_combined_dollars {
    label: "Cumulative Combined Dollars"
    value_format:"$#.00"
    type:number}
  dimension: lifetime_mtx_spend_indicator {
    label: "Lifetime IAP Spender Indicator"
    type:number
    }
  dimension: lifetime_mtx_spender_rdg_id {
    label: "Lifetime IAP Spender Rdg Id"
    type:string
    }
  dimension: cumulative_ad_views {
    label: "Cumulative IAA Views"
    type:number
    }
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
  dimension: count_days_played {type:number}
  dimension: count_months_played {type:number}
  dimension: cumulative_count_days_played {type:number}
  dimension: levels_progressed {type:number}
  dimension: cumulative_coins_spend {type:number}
  dimension: cumulative_star_spend {type:number}
  dimension: months_since_last_played {type:number}
  dimension: months_since_created_week {type:number}
  dimension: month_number {type:number}
  dimension: new_returning_winback {
    type: string
    sql:
      case
        when months_since_last_played is null then 'New'
        when months_since_last_played <= 1 then 'Returning'
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
    drill_fields: [display_name,rdg_id,install_version,created_month_month,cumulative_combined_dollars]
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
    label: "Count Distinct Daily IAP Spender Rdg Id"
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: count_distinct_lifetime_mtx_spender_rdg_id {
    label: "Count Distinct Lifetime IAP Spender Rdg Id"
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
        max(
          date_diff(
            date_add(date(${TABLE}.rdg_month), interval +1 month)
            , date(${TABLE}.rdg_month)
            , day)
            )
      )
    ;;
    value_format_name: decimal_0
  }

################################################################
## Other Calculations
################################################################

  measure: average_sessions_per_day {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_sessions)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: decimal_2
  }

  measure: average_minutes_per_session {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.time_played_minutes)
        ,
        sum(${TABLE}.count_sessions)
      )
    ;;
    value_format_name: decimal_0
  }


  measure: average_minutes_per_month {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.time_played_minutes)
        ,
        sum(${TABLE}.count_months_played)
      )
    ;;
    value_format_name: decimal_0
  }

  measure: average_sessions_per_month {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_sessions)
        ,
        sum(${TABLE}.count_months_played)
      )
    ;;
    value_format_name: decimal_1
  }


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
    label: "Average IAP Dollars Per Player - 30%"
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
    label: "Average IAP ARPDAU - 30%"
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
    label: "Average IAA Dollars Per Player"
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
    label: "Average IAA ARPDAU"
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
    label: "Average Combined ARPDAU"
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
    label: "Sum IAP Dollars - 30%"
    group_label: "Revenue Metrics"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }

  measure: sum_mtx_purchase_dollars_15 {
    label: "Sum IAP Dollars - 15%"
    group_label: "Revenue Metrics"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.mtx_purchase_dollars_15 ;;
  }

  measure: sum_ad_view_dollars {
    label: "Sum IAA Dollars"
    group_label: "Revenue Metrics"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: sum_combined_dollars {
    label: "Sum Combined Dollars"
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

}
