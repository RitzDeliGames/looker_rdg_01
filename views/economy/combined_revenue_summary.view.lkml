view: combined_revenue_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-16'

-- create or replace table tal_scratch.combined_revenue_summary as

with

-----------------------------------------------------------------------------
-- mtx data
-----------------------------------------------------------------------------

my_mtx_data as (

  select
    rdg_id
    , rdg_date
    , timestamp_utc
    , created_at
    , version
    , session_id
    , experiments
    , win_streak
    , 'Mtx' as revenue_category
    , 1 as count_revenue_events
    , source_id
    , cast(null as string) as ad_reward_source_id
    , cast(null as string) as ad_network
    , iap_id as mtx_iap_id
    , iap_purchase_item as mtx_iap_purchase_item
    , iap_purchase_qty as mtx_iap_purchase_qty
    , mtx_purchase_dollars as net_dollars
    , round_count
    , level_id as round_level_id
    , level_serial as round_level_serial
    , round_game_mode
    , round_start_timestamp_utc
    , round_end_timestamp_utc
    , round_purchase_type
    , created_date
    , days_since_created
    , day_number
  from
    -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_summary
    ${player_mtx_purchase_summary.SQL_TABLE_NAME}

)


-----------------------------------------------------------------------------
-- ads data
-----------------------------------------------------------------------------

, my_ads_data as (

  select
    rdg_id
    , rdg_date
    , timestamp_utc
    , created_at
    , version
    , session_id
    , experiments
    , win_streak
    , 'Ads' as revenue_category
    , 1 as count_revenue_events
    , source_id
    , ad_reward_source_id
    , ad_network
    , cast(null as string) as mtx_iap_id
    , cast(null as string) as mtx_iap_purchase_item
    , cast(null as int64) as mtx_iap_purchase_qty
    , ad_view_dollars as net_dollars
    , round_count
    , current_level_id as round_level_id
    , current_level_serial as round_level_serial
    , round_game_mode
    , round_start_timestamp_utc
    , round_end_timestamp_utc
    , round_purchase_type
    , created_date
    , days_since_created
    , day_number
  from
    -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary
    ${player_ad_view_summary.SQL_TABLE_NAME}
)

-----------------------------------------------------------------------------
-- combined data
-----------------------------------------------------------------------------

, my_combined_data as (

  select * from my_mtx_data
  union all
  select * from my_ads_data

)

-----------------------------------------------------------------------------
-- summarized data
-----------------------------------------------------------------------------

, my_summarized_data as (

select
  rdg_id
  , rdg_date
  , timestamp_utc
  , revenue_category
  , max(created_at) as created_at
  , max(version) as version
  , max(session_id) as session_id
  , max(experiments) as experiments
  , max(win_streak) as win_streak
  , max(count_revenue_events) as count_revenue_events
  , max(source_id) as source_id
  , max(ad_reward_source_id) as ad_reward_source_id
  , max(ad_network) as ad_network
  , max(mtx_iap_id) as mtx_iap_id
  , max(mtx_iap_purchase_item) as mtx_iap_purchase_item
  , max(mtx_iap_purchase_qty) as mtx_iap_purchase_qty
  , max(net_dollars) as net_dollars
  , max(round_count) as round_count
  , max(round_level_id) as round_level_id
  , max(round_level_serial) as round_level_serial
  , max(round_game_mode) as round_game_mode
  , max(round_start_timestamp_utc) as round_start_timestamp_utc
  , max(round_end_timestamp_utc) as round_end_timestamp_utc
  , max(round_purchase_type) as round_purchase_type
  , max(created_date) as created_date
  , max(days_since_created) as days_since_created
  , max(day_number) as day_number
from
  my_combined_data
group by
  1,2,3,4
)

-----------------------------------------------------------------------------
-- select data
-----------------------------------------------------------------------------

select * from my_summarized_data

-- select sum(1) from my_combined_data
-- union all
-- select sum(1) from my_summarized_data


      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -4 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (4) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.rdg_date
    || '_' || ${TABLE}.timestamp_utc
    || '_' || ${TABLE}.revenue_category
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    group_label: "Activity Dates"
    label: "Activity Date"
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }
  dimension_group: created_date_timestamp {
    group_label: "Installed On Dates"
    label: "Installed On"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  # Strings
  dimension: rdg_id {type:string}
  dimension: revenue_category {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}

  # Round Info
  dimension: round_game_mode {
    group_label: "Round Info"
    type: string}
  dimension: round_purchase_type {
    group_label: "Round Info"
    type: string}
  dimension: round_count {
    group_label: "Round Info"
    type: number}
  dimension_group: round_start_timestamp_utc {
    group_label: "Round Info"
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.round_start_timestamp_utc ;;
  }
  dimension_group: round_end_timestamp_utc {
    group_label: "Round Info"
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.round_end_timestamp_utc ;;
  }
  dimension: round_level_id {
    group_label: "Round Info"
    type: string
    }
  dimension: round_level_serial {
    group_label: "Round Info"
    type: number
    }

  dimension: source_id {
    group_label: "SKU Information"
    type:string}
  dimension: ad_reward_source_id {
    group_label: "SKU Information"
    type:string}
  dimension: ad_network {
    group_label: "SKU Information"
    type:string}



  dimension: iap_purchase_item {
    group_label: "SKU Information"
    type:string}

  dimension: iap_id {
    group_label: "SKU Information"
    type:string}

  dimension: iap_id_strings {
    group_label: "SKU Information"
    label: "IAP Names"
    sql: @{iap_id_strings_new} ;;
  }

  dimension: iap_id_strings_grouped {
    group_label: "SKU Information"
    label: "IAP Names Grouped"
    sql: @{iap_id_strings_grouped_new} ;;
  }

  dimension: iap_purchase_qty {
    group_label: "SKU Information"
    type:number}



  dimension: days_since_created {type:number}
  dimension: day_number {type:number}

################################################################
## Calculated Fields
################################################################




################################################################
## Player Counts
################################################################

###############################################################
## Sums and Percentiles
################################################################


  measure: sum_net_dollars {
    label: "Sum Net Dollars"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.net_dollars ;;

  }


}
