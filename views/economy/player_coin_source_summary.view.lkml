view: player_coin_source_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-30'

      -- create or replace table tal_scratch.player_coin_source_summary as

select

  -- All columns from player_coin_spend_incremental
  *

  -- Player Age Information
  , timestamp(date(created_at)) as created_date -- Created Date
  , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
  , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

from
  -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_source_incremental`
  ${player_coin_source_incremental.SQL_TABLE_NAME}

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
    label: "Source Date"
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
  dimension: day_number {type:number}
  dimension: 30_day_month_number {
    type: number
    label: "30 Day Month Number"
    value_format_name: decimal_0
    sql: safe_cast(ceiling(${TABLE}.day_number/30) as int64) ;;
  }



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

  parameter: selected_coin_source_parameter {
    group_label: "Coin Sources"
    label: "Selected Coin Source: Parameter"
    type: string
    suggestions:  [
      "Coin Source: Type"
      ,"Coin Source: Group"
      ,"Coin Source: Name"
      ,"Coin Source: Starting Name"
      ,"Coin Source: Starting Source"
      ]
  }

  dimension: selected_coin_source_dimension {
    group_label: "Coin Sources"
    label: "Selected Coin Source: Dimension"
    type:string
    sql:
      case
        when {% parameter selected_coin_source_parameter %} = 'Coin Source: Type' then ${TABLE}.coin_source_type
        when {% parameter selected_coin_source_parameter %} = 'Coin Source: Group' then @{coin_source_name_group}
        when {% parameter selected_coin_source_parameter %} = 'Coin Source: Name' then @{coin_source_name}
        when {% parameter selected_coin_source_parameter %} = 'Coin Source: Starting Name' then ${TABLE}.coin_source_iap_item
        when {% parameter selected_coin_source_parameter %} = 'Coin Source: Starting Source' then ${TABLE}.coin_source
        else 'Error'
        end
    ;;
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
