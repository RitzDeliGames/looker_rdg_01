view: rewards_bingo_cards_and_gameplay {
  derived_table: {
    sql:
      select
        rdg_id
        ,event_name
        ,current_card
        ,last_unlocked_card
        ,json_extract_scalar(extra_json,'$.reward_type') reward_type
        ,sum(cast(json_extract_scalar(extra_json,'$.reward_amount') as int64)) reward_amount_sum
        ,sum(if(json_extract_scalar(extra_json,'$.reward_type') = 'CURRENCY_03',cast(json_extract_scalar(extra_json,'$.reward_amount') as int64),cast(json_extract_scalar(extra_json,'$.reward_amount') as int64) * 600)) system_value_sum
      from game_data.events
      where event_name = 'reward'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
      and current_card = last_unlocked_card
      and (json_extract_scalar(extra_json,'$.reward_event') like '%bingo%' or json_extract_scalar(extra_json,'$.reward_event') like '%round%')
      group by 1,2,3,4--,5
    ;;
    datagroup_trigger: change_at_midnight
    publish_as_db_view: yes
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${event_name} || ${current_card} ;;
  }
  dimension: rdg_id {
    hidden: no
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: event_name {
    hidden: yes
    type: string
    sql: ${TABLE}.event_name ;;
  }
  dimension: current_card {
    hidden: yes
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    hidden: no
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: card_id {
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_numbered {
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: reward_type {
    type: string
    sql: ${TABLE}.reward_type ;;
  }
  measure: player_count {
    label: "Unique Players"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: reward_count {
    type: count
  }
  measure: currency_rewarded_amount_sum {
    label: "Total Currency Rewarded"
    type: sum
    value_format: "#,###"
    sql: ${reward_amount_sum} ;;
  }
  measure: currency_rewarded_amount_sum_per_player {
    label: "Avg. Amount Earned per Player"
    type: number
    value_format: "#,###"
    sql: ${currency_rewarded_amount_sum} / ${player_count} ;;
  }
  measure: rewards_per_player {
    label: "Rewards per Player"
    type: number
    sql: ${reward_count} / ${player_count} ;;
  }
  dimension: reward_amount_sum {
    type: number
    sql: ${TABLE}.reward_amount_sum ;;
  }
  measure: currency_rewarded_amount_025 {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${reward_amount_sum} ;;
  }
  measure: currency_rewarded_amount_25th {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 25%"
    type: percentile
    percentile: 25
    sql: ${reward_amount_sum} ;;
  }
  measure: currency_rewarded_amount_med {
    group_label: "Currency Rewards"
    label: "Currency Rewards - Median"
    type: median
    sql: ${reward_amount_sum} ;;
  }
  measure: currency_rewarded_amount_75th {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 75%"
    type: percentile
    percentile: 75
    sql: ${reward_amount_sum} ;;
  }
  measure: currency_rewarded_amount_975x {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${reward_amount_sum} ;;
  }
  dimension: system_value_sum {
    type: number
    sql:  ${TABLE}.system_value_sum ;;
  }
  measure:  system_value_amount_sum{
    label: "Total System Value Rewarded"
    type: sum
    sql: ${system_value_sum} ;;
  }
  measure: system_value_rewarded_amount_025 {
    group_label: "System Value Rewards"
    label: "System Value Rewards - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${system_value_sum} ;;
  }
  measure: system_value_rewarded_amount_25th {
    group_label: "System Value Rewards"
    label: "System Value Rewards - 25%"
    type: percentile
    percentile: 25
    sql: ${system_value_sum} ;;
  }
  measure: system_value_rewarded_amount_med {
    group_label: "System Value Rewards"
    label: "System Value Rewards - Median"
    type: median
    sql: ${system_value_sum} ;;
  }
  measure: system_value_rewarded_amount_75th {
    group_label: "System Value Rewards"
    label: "System Value Rewards - 75%"
    type: percentile
    percentile: 75
    sql: ${system_value_sum} ;;
  }
  measure: system_value_rewarded_amount_max {
    group_label: "System Value Rewards"
    label: "System Value Rewards - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${system_value_sum} ;;
  }

  drill_fields: [rdg_id,reward_type,reward_amount_sum]
}
