view: player_mtx_purchase_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-30'

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

        , @{iap_id_strings_new} as iap_id_strings
        , @{iap_id_strings_grouped_new} as iap_id_strings_grouped

      from
        -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_incremental` a
        ${player_mtx_purchase_incremental.SQL_TABLE_NAME} a

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
    || '_' || ${TABLE}.transaction_id
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

  # rdg_date for join
  dimension: join_rdg_date {
    type: date
    sql: date(${TABLE}.rdg_date) ;;
    }

  # dates
  dimension_group: rdg_date {
    group_label: "Activity Dates"
    label: "Activity Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  # dates
  dimension_group: timestamp_utc {
    group_label: "Activity Dates"
    label: "Activity Time"
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
  }

  dimension: iap_id_strings_grouped {
    group_label: "SKU Information"
    label: "IAP Names Grouped"
  }

  dimension: iap_purchase_qty {
    group_label: "SKU Information"
    type:number}


  # Numbers
  dimension: last_level_serial {type:number}
  dimension: count_mtx_purchases {type:number}

  dimension: mtx_purchase_dollars {type:number label: "IAP Dollars"}
  dimension: coins_balance {type:number}
  dimension: lives_balance {type:number}
  dimension: stars_balance {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: cumulative_mtx_purchase_dollars {
    label: "LTV - IAP"
    type: number
    value_format_name: usd
  }
  dimension: cumulative_count_mtx_purchases {
    label: "Cumulative Count IAP"
    type: number
    value_format_name: decimal_0
  }

  dimension: treasure_trove_week_start_date {
    label: "Treasure Trove Week Start"
    type: date
    sql:
      date_add(
        date(${TABLE}.rdg_date)
        , interval
          (-1)*(extract( dayofweek from date(${TABLE}.rdg_date)) - 1)
          day
        )
    ;;
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
    label: "IAP Dollars Per Spender"
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
  measure: mtx_dollars_per_unique_day {
    group_label: "Calculated Fields"
    label: "IAP Dollars Per Day"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        count(distinct ${TABLE}.rdg_date)
        )
    ;;
    value_format_name: usd_0
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

  measure: new_spender_count {
    group_label: "Unique Player Counts"
    label: "New Spender Count"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_count_mtx_purchases = 1
          then ${TABLE}.rdg_id
          else null
          end
        )
    ;;
    value_format_name: decimal_0
  }

################################################################
## Sums and Percentiles
################################################################

  measure: sum_count_mtx_purchases {
    group_label: "Sum Count IAPs"
    type:sum
    sql: ${TABLE}.count_mtx_purchases ;;
  }
  measure: sum_mtx_purchase_dollars {
    label: "Sum IAP Dollars"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.mtx_purchase_dollars ;;
    drill_fields: [timestamp_utc_time,rdg_id,iap_id,iap_id_strings,mtx_purchase_dollars]
  }
  measure: sum_cumulative_mtx_purchase_dollars {
    label: "Sum LTV - IAP"
    type:sum
    value_format: "$#.00"
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }


}
