view: player_mtx_purchase_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-03-08'

      -- create or replace table tal_scratch.player_mtx_purchase_summary as

      select

        -- All columns from player_mtx_purchase_incremental
        *

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

        -- Cumulative fields
        , sum(ifnull(mtx_purchase_dollars,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_mtx_purchase_dollars

        , sum(ifnull(count_mtx_purchases,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_count_mtx_purchases

      from
        `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_incremental`

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
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
    || '_' || ${TABLE}.transaction_id
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
  dimension: transaction_id {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: store_session_id {type:string}


  dimension: source_id {
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


  # Numbers
  dimension: last_level_serial {type:number}
  dimension: count_mtx_purchases {type:number}

  dimension: mtx_purchase_dollars {type:number}
  dimension: coins_balance {type:number}
  dimension: lives_balance {type:number}
  dimension: stars_balance {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: cumulative_mtx_purchase_dollars {
    type: number
    value_format_name: usd
  }
  dimension: cumulative_count_mtx_purchases {
    type: number
    value_format_name: decimal_0
  }



################################################################
## Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    label: "Count Distinct Spenders"
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
  measure: sum_count_mtx_purchases {
    group_label: "Count MTX Purchases"
    type:sum
    sql: ${TABLE}.count_mtx_purchases ;;
  }
  measure: count_mtx_purchases_10 {
    group_label: "Count MTX Purchases"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_mtx_purchases ;;
  }
  measure: count_mtx_purchases_25 {
    group_label: "Count MTX Purchases"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_mtx_purchases ;;
  }
  measure: count_mtx_purchases_50 {
    group_label: "Count MTX Purchases"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_mtx_purchases ;;
  }
  measure: count_mtx_purchases_75 {
    group_label: "Count MTX Purchases"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_mtx_purchases ;;
  }
  measure: count_mtx_purchases_95 {
    group_label: "Count MTX Purchases"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_mtx_purchases ;;
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
  measure: sum_mtx_purchase_dollars {
    group_label: "MTX Purchase Dollars"
    label: "MTX Purchase Dollars"
    type:sum
    value_format: "$#.00"
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
  measure: sum_cumulative_mtx_purchase_dollars {
    group_label: "Cumulative MTX Purchase Dollars"
    label: "Cumulative MTX Purchase Dollars"
    type:sum
    value_format: "$#.00"
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
  measure: sum_cumulative_count_mtx_purchases {
    group_label: "Cumulative Count MTX Purchases"
    type:sum
    sql: ${TABLE}.cumulative_count_mtx_purchases ;;
  }
  measure: cumulative_count_mtx_purchases_10 {
    group_label: "Cumulative Count MTX Purchases"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_mtx_purchases ;;
  }
  measure: cumulative_count_mtx_purchases_25 {
    group_label: "Cumulative Count MTX Purchases"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_mtx_purchases ;;
  }
  measure: cumulative_count_mtx_purchases_50 {
    group_label: "Cumulative Count MTX Purchases"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_mtx_purchases ;;
  }
  measure: cumulative_count_mtx_purchases_75 {
    group_label: "Cumulative Count MTX Purchases"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_mtx_purchases ;;
  }
  measure: cumulative_count_mtx_purchases_95 {
    group_label: "Cumulative Count MTX Purchases"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_mtx_purchases ;;
  }


}
