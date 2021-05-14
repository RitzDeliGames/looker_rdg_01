view: rewards {
  derived_table: {
    sql:
      select
        rdg_id
        ,event_name
        ,timestamp
        ,lower(hardware) device_model_number
        ,round(cast(engagement_ticks as int64) / 2) minutes_played
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,json_extract_scalar(extra_json,'$.reward_event') reward_event
        ,json_extract_scalar(extra_json,'$.reward_type') reward_type
        ,cast(json_extract_scalar(extra_json,'$.reward_amount') as int64) reward_amount
        ,cast(json_extract_scalar(extra_json,'$.round_id') as int64) round_id
      from game_data.events
      where event_name = 'reward'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
    ;;
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${event_name} || ${reward_raw} ;;
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
  dimension_group: reward {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,year
    ]
  }
  dimension: device_model_number {
    type: string
    sql: ${TABLE}.device_model_number ;;
  }
  dimension: minutes_played {
    type: number
    sql: ${TABLE}.minutes_played ;;
  }
  dimension: current_card {
    hidden: yes
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    hidden: yes
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: current_quest {
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: reward_event {
    type: string
    sql: ${TABLE}.reward_event ;;
  }
  dimension: reward_type {
    type: string
    sql: ${TABLE}.reward_type ;;
  }
  dimension: reward_amount {
    type: number
    sql: ${TABLE}.reward_amount ;;
  }
  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
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
  measure: rewards_count {
    type: count
  }
  measure: currency_rewarded_amount_sum {
    label: "Total Currency Rewarded"
    type: sum
    value_format: "#,###"
    sql: ${reward_amount} ;;
    drill_fields: [rdg_id, reward_date, reward_count, reward_event, reward_amount]
  }
  measure: player_count {
    label: "Unique Players"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id]
  }
  measure: currency_rewarded_amount_sum_per_player {
    label: "Avg. Amount Earned per Player"
    type: number
    value_format: "#,###"
    sql: ${currency_rewarded_amount_sum} / ${player_count} ;;
  }
  measure: reward_count {
    label: "Reward Count"
    type: count_distinct
    sql:  ${reward_raw};;
  }
  measure: rewards_per_player {
    label: "Rewards per Player"
    type: number
    sql: ${reward_count} / ${player_count} ;;
  }
  measure: currency_rewarded_amount_025 {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${reward_amount} ;;
  }
  measure: currency_rewarded_amount_25th {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 25%"
    type: percentile
    percentile: 25
    sql: ${reward_amount} ;;
  }
  measure: currency_rewarded_amount_med {
    group_label: "Currency Rewards"
    label: "Currency Rewards - Median"
    type: median
    sql: ${reward_amount} ;;
  }
  measure: currency_rewarded_amount_75th {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 75%"
    type: percentile
    percentile: 75
    sql: ${reward_amount} ;;
  }
  measure: currency_rewarded_amount_max {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${reward_amount} ;;
  }
}
