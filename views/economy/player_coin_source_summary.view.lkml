view: player_coin_source_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-07-03'

      -- create or replace table tal_scratch.player_coin_source_summary as

select

  -- All columns from player_coin_spend_incremental
  *

  -- Player Age Information
  , timestamp(date(created_at)) as created_date -- Created Date
  , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
  , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

from
  `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_source_incremental`

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
    || '_' || ${TABLE}.coin_source_type
    || '_' || ${TABLE}.coin_source_iap_item

    ;;
  primary_key: yes
  hidden: yes
}

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    label: "Source Time"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

  dimension_group: created_date_timestamp {
    label: "Created"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  dimension: rdg_id {type:string}

  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: count_coin_source_events {type:number}
  dimension: level_serial {type:number}
  dimension: level_id {type:string}


  dimension: currency_03_balance {type:number}
  dimension: currency_04_balance {type:number}
  dimension: currency_07_balance {type:number}

################################################################
## Coin Source Naming
################################################################

  dimension: coin_source_type {
    group_label: "Coin Sources"
    label: "Coin Source: Type"
    type:string
    }
  dimension: coin_source_iap_item {
    group_label: "Coin Sources"
    label: "Coin Source: Starting Name"
    type:string
  }

  dimension: coin_source {
    group_label: "Coin Sources"
    label: "Coin Source: Starting Source"
    type:string
  }

  dimension: coin_source_amount_pre_override {
    group_label: "Coin Sources"
    label: "Coin Source: Starting Amount"
    type:number
    sql: ${TABLE}.coin_source_amount;;
  }

  dimension: coin_source_name {
    group_label: "Coin Sources"
    label: "Coin Source: Name"
    type:string
    sql:  @{coin_source_name} ;;
  }

  dimension: coin_source_name_group {
    group_label: "Coin Sources"
    label: "Coin Source: Group"
    type:string
    sql:  @{coin_source_name_group} ;;
  }

################################################################
## Measures
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: coin_source_amount {
    label: "Coin Source Amount"
    value_format_name: decimal_0
    type: number
    sql:
      sum(ifnull(safe_cast( @{coin_source_amount_override} as int64 ),0) )
    ;;
  }



}
