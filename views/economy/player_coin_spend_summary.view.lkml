view: player_coin_spend_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-30'

      -- create or replace table tal_scratch.player_coin_spend_summary as

      select

        -- All columns from player_coin_spend_incremental
        *

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

        -- Cumulative fields
        , sum(ifnull(count_coin_spend_events,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_count_coin_spend_events

        , sum(ifnull(coin_spend,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_coin_spend

      from
        -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_spend_incremental`
        ${player_coin_spend_incremental.SQL_TABLE_NAME}


      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (2) + 2 )*( -10 ) minute)) ;;
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
    || '_' || ${TABLE}.store_session_id
    || '_' || ${TABLE}.source_id
    ;;
  primary_key: yes
  hidden: yes
}

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    label: "Spend Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }
  dimension_group: created_date_timestamp {
    label: "Created"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  # Strings
  dimension: rdg_id {type:string}
  dimension: store_session_id {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}

  dimension: transaction_id {type:string}
  dimension: level_id {type:string}

  # Numbers
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: count_coin_spend_events {type:number}
  dimension: iap_purchase_qty {type:number}
  dimension: level_serial {type:number}
  dimension: coin_spend {type:number}
  dimension: coins_balance {type:number}
  dimension: lives_balance {type:number}
  dimension: stars_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: cumulative_count_coin_spend_events {type:number}
  dimension: cumulative_coin_spend {type:number}
  dimension: 30_day_month_number {
    type: number
    label: "30 Day Month Number"
    value_format_name: decimal_0
    sql: safe_cast(ceiling(${TABLE}.day_number/30) as int64) ;;
  }

################################################################
## Coin Spend Naming
################################################################

  dimension: iap_id {
    group_label: "Coin Sinks"
    label: "Coin Sink: Starting IAP ID"
    type:string
  }

  dimension: source_id {
    group_label: "Coin Sinks"
    label: "Coin Sink: Starting Source ID"
    type:string
  }

  dimension: iap_purchase_item {
    group_label: "Coin Sinks"
    label: "Coin Sink: Starting IAP Purchase Item"
    type:string
  }

  dimension: coin_spend_name {
    group_label: "Coin Sinks"
    label: "Coin Sink: Name"
    type:string
    sql:  @{coin_spend_name} ;;
  }

  dimension: coin_spend_name_group {
    group_label: "Coin Sinks"
    label: "Coin Sink: Group"
    type:string
    sql:  @{coin_spend_name_group} ;;
  }

  parameter: selected_coin_spend_parameter {
    group_label: "Coin Sinks"
    label: "Selected Coin Sink: Parameter"
    type: string
    suggestions:  [
      ,"Coin Sink: Group"
      ,"Coin Sink: Name"

      ,"Coin Sink: Starting Source ID"
      ,"Coin Sink: Starting IAP ID"
      ,"Coin Sink: Starting IAP Purchase Item"
    ]
  }

  dimension: selected_coin_spend_dimension {
    group_label: "Coin Sinks"
    label: "Selected Coin Sink: Dimension"
    type:string
    sql:
      case
        when {% parameter selected_coin_spend_parameter %} = 'Coin Sink: Group' then @{coin_spend_name_group}
        when {% parameter selected_coin_spend_parameter %} = 'Coin Sink: Name' then @{coin_spend_name}

        when {% parameter selected_coin_spend_parameter %} = 'Coin Sink: Starting Source ID' then ${TABLE}.source_id
        when {% parameter selected_coin_spend_parameter %} = 'Coin Sink: Starting IAP ID' then ${TABLE}.iap_id
        when {% parameter selected_coin_spend_parameter %} = 'Coin Sink: Starting IAP Purchase Item' then ${TABLE}.iap_purchase_item
        else 'Error'
        end
    ;;
  }


################################################################
## Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

################################################################
## Sums and Percentiles
################################################################

  measure: sum_win_streak {
    group_label: "Win Streak"
    type:sum
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_10 {
    group_label: "Win Streak"
    type: percentile
    percentile: 10
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_25 {
    group_label: "Win Streak"
    type: percentile
    percentile: 25
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_50 {
    group_label: "Win Streak"
    type: percentile
    percentile: 50
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_75 {
    group_label: "Win Streak"
    type: percentile
    percentile: 75
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_95 {
    group_label: "Win Streak"
    type: percentile
    percentile: 95
    sql: ${TABLE}.win_streak ;;
  }
  measure: sum_count_coin_spend_events {
    group_label: "Count Coin Spend Events"
    type:sum
    sql: ${TABLE}.count_coin_spend_events ;;
  }
  measure: count_coin_spend_events_10 {
    group_label: "Count Coin Spend Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_coin_spend_events ;;
  }
  measure: count_coin_spend_events_25 {
    group_label: "Count Coin Spend Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_coin_spend_events ;;
  }
  measure: count_coin_spend_events_50 {
    group_label: "Count Coin Spend Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_coin_spend_events ;;
  }
  measure: count_coin_spend_events_75 {
    group_label: "Count Coin Spend Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_coin_spend_events ;;
  }
  measure: count_coin_spend_events_95 {
    group_label: "Count Coin Spend Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_coin_spend_events ;;
  }
  measure: sum_iap_purchase_qty {
    group_label: "Iap Purchase Qty"
    type:sum
    sql: ${TABLE}.iap_purchase_qty ;;
  }
  measure: iap_purchase_qty_10 {
    group_label: "Iap Purchase Qty"
    type: percentile
    percentile: 10
    sql: ${TABLE}.iap_purchase_qty ;;
  }
  measure: iap_purchase_qty_25 {
    group_label: "Iap Purchase Qty"
    type: percentile
    percentile: 25
    sql: ${TABLE}.iap_purchase_qty ;;
  }
  measure: iap_purchase_qty_50 {
    group_label: "Iap Purchase Qty"
    type: percentile
    percentile: 50
    sql: ${TABLE}.iap_purchase_qty ;;
  }
  measure: iap_purchase_qty_75 {
    group_label: "Iap Purchase Qty"
    type: percentile
    percentile: 75
    sql: ${TABLE}.iap_purchase_qty ;;
  }
  measure: iap_purchase_qty_95 {
    group_label: "Iap Purchase Qty"
    type: percentile
    percentile: 95
    sql: ${TABLE}.iap_purchase_qty ;;
  }
  measure: sum_coin_spend {
    group_label: "Coin Spend"
    type:sum
    sql: ${TABLE}.coin_spend ;;
  }
  measure: coin_spend_10 {
    group_label: "Coin Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coin_spend ;;
  }
  measure: coin_spend_25 {
    group_label: "Coin Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coin_spend ;;
  }
  measure: coin_spend_50 {
    group_label: "Coin Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coin_spend ;;
  }
  measure: coin_spend_75 {
    group_label: "Coin Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coin_spend ;;
  }
  measure: coin_spend_95 {
    group_label: "Coin Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coin_spend ;;
  }
  measure: sum_coins_balance {
    group_label: "Coins Balance"
    type:sum
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_10 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_25 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_50 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_75 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_95 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coins_balance ;;
  }
  measure: sum_lives_balance {
    group_label: "Lives Balance"
    type:sum
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_10 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_25 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_50 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_75 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_95 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.lives_balance ;;
  }
  measure: sum_stars_balance {
    group_label: "Stars Balance"
    type:sum
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_10 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_25 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_50 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_75 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_95 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.stars_balance ;;
  }
  measure: sum_cumulative_count_coin_spend_events {
    group_label: "Cumulative Count Coin Spend Events"
    type:sum
    sql: ${TABLE}.cumulative_count_coin_spend_events ;;
  }
  measure: cumulative_count_coin_spend_events_10 {
    group_label: "Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_coin_spend_events ;;
  }
  measure: cumulative_count_coin_spend_events_25 {
    group_label: "Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_coin_spend_events ;;
  }
  measure: cumulative_count_coin_spend_events_50 {
    group_label: "Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_coin_spend_events ;;
  }
  measure: cumulative_count_coin_spend_events_75 {
    group_label: "Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_coin_spend_events ;;
  }
  measure: cumulative_count_coin_spend_events_95 {
    group_label: "Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_coin_spend_events ;;
  }
  measure: sum_cumulative_coin_spend {
    group_label: "Cumulative Coin Spend"
    type:sum
    sql: ${TABLE}.cumulative_coin_spend ;;
  }
  measure: cumulative_coin_spend_10 {
    group_label: "Cumulative Coin Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_coin_spend ;;
  }
  measure: cumulative_coin_spend_25 {
    group_label: "Cumulative Coin Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_coin_spend ;;
  }
  measure: cumulative_coin_spend_50 {
    group_label: "Cumulative Coin Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_coin_spend ;;
  }
  measure: cumulative_coin_spend_75 {
    group_label: "Cumulative Coin Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_coin_spend ;;
  }
  measure: cumulative_coin_spend_95 {
    group_label: "Cumulative Coin Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_coin_spend ;;
  }


}
