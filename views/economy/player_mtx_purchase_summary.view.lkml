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
## Calculated Fields
################################################################

  measure: mean_cost_per_purchase {
    group_label: "Calculated Fields"
    label: "Average Selling Price (ASP)"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        sum(${TABLE}.count_mtx_purchases)
        )
    ;;
    value_format_name: usd
  }

  measure: mtx_dollars_per_spender {
    group_label: "Calculated Fields"
    label: "MTX Dollars Per Spender"
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

  measure: mean_purchases_per_spender {
    group_label: "Calculated Fields"
    label: "Purchases Per Spender"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_mtx_purchases)
        ,
        count(distinct ${TABLE}.rdg_id)
        )
    ;;
    value_format_name: decimal_1
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

  measure: sum_count_mtx_purchases {
    group_label: "Count MTX Purchases"
    label: "Total MTX Purchases"
    type:sum
    sql: ${TABLE}.count_mtx_purchases ;;
  }
  measure: sum_mtx_purchase_dollars {
    group_label: "MTX Purchase Dollars"
    label: "MTX Purchase Dollars"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars {
    group_label: "Cumulative MTX Purchase Dollars"
    label: "Cumulative MTX Purchase Dollars"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }


}
