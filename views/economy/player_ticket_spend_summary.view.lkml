view: player_ticket_spend_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-05-15'

      -- create or replace table tal_scratch.player_coin_spend_summary as

      select

        -- All columns from player_coin_spend_incremental
        *
        , @{ad_placements_for_tickets_spend} as ad_placement

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

        -- Cumulative fields
        , sum(ifnull(count_events,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_count_events

        , sum(ifnull(tickets_spend,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_tickets_spend

      from
        -- eraser-blast.looker_scratch.LR_6YVUR1715794041578_player_ticket_spend_incremental
        ${player_ticket_spend_incremental.SQL_TABLE_NAME}


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
      || '_' || ${TABLE}.source_id
      || '_' || ${TABLE}.iap_id
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
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
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
    group_label: "Ticket Sinks"
    label: "Ticket Sink: Starting IAP ID"
    type:string
  }

  dimension: source_id {
    group_label: "Ticket Sinks"
    label: "Ticket Sink: Starting Source ID"
    type:string
  }

  dimension: ticket_placement {
    group_label: "Ticket Sinks"
    label: "Ticket Placement"
    type: string
    sql:
     ${TABLE}.ad_placement
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

  ## Count Ticket Spend Events
  measure: sum_ticket_spend_events {
    group_label: "Count Ticket Spend Events"
    type:sum
    sql: ${TABLE}.count_events ;;
  }
  measure: count_ticket_spend_events_10 {
    group_label: "Count Ticket Spend Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_events ;;
  }
  measure: count_ticket_spend_events_25 {
    group_label: "Count Ticket Spend Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_events ;;
  }
  measure: count_ticket_spend_events_50 {
    group_label: "Count Ticket Spend Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_events ;;
  }
  measure: count_ticket_spend_events_75 {
    group_label: "Count Ticket Spend Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_events ;;
  }
  measure: count_ticket_spend_events_95 {
    group_label: "Count Ticket Spend Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_events ;;
  }

  ## Tickets Spend
  measure: sum_tickets_spend {
    group_label: "Tickets Spend"
    type:sum
    sql: ${TABLE}.tickets_spend ;;
  }
  measure: tickets_spend_10 {
    group_label: "Tickets Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.tickets_spend ;;
  }
  measure: tickets_spend_25 {
    group_label: "Tickets Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.tickets_spend ;;
  }
  measure: tickets_spend_50 {
    group_label: "Tickets Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.tickets_spend ;;
  }
  measure: tickets_spend_75 {
    group_label: "Tickets Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.tickets_spend ;;
  }
  measure: tickets_spend_95 {
    group_label: "Tickets Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.tickets_spend ;;
  }

  ## Tickets Balance
  measure: sum_tickets_balance {
    group_label: "Tickets Balance"
    type:sum
    sql: ${TABLE}.tickets_balance ;;
  }
  measure: tickets_balance_10 {
    group_label: "Tickets Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.tickets_balance ;;
  }
  measure: tickets_balance_25 {
    group_label: "Tickets Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.tickets_balance ;;
  }
  measure: tickets_balance_50 {
    group_label: "Tickets Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.tickets_balance ;;
  }
  measure: tickets_balance_75 {
    group_label: "Tickets Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.tickets_balance ;;
  }
  measure: tickets_balance_95 {
    group_label: "Tickets Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.tickets_balance ;;
  }

  ## Coins Balance
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

  ## Lives Balance
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

  ## Stars Balance
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

}
