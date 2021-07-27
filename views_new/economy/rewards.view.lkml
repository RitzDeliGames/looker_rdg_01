view: rewards {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,current_card
        ,last_unlocked_card
        ,current_quest
        ,json_extract_scalar(extra_json,'$.reward_event') reward_event
        ,json_extract_scalar(extra_json,'$.reward_type') reward_type
        ,cast(json_extract_scalar(extra_json,'$.reward_amount') as int64) reward_amount
      from game_data.events
      where event_name = 'reward'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
      and current_card = last_unlocked_card
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${reward_raw} ;;
  }
  dimension: rdg_id {
    hidden: no
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension_group: reward {
    type: time
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,quarter
      ,year
    ]
    sql: ${TABLE}.timestamp  ;;
  }
  dimension: current_card {
    group_label: "Card Dimensions"
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: last_unlocked_card {
    group_label: "Card Dimensions"
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: last_unlocked_card_numbered {
    group_label: "Card Dimensions"
    type: number
    sql: @{last_unlocked_card_numbered} ;;
    value_format: "####"
  }
  dimension: card_id {
    group_label: "Card Dimensions"
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_quest {
    group_label: "Card Dimensions"
    hidden: yes
    type: string
    sql: ${TABLE}.current_quest ;;
  }
  dimension: reward_event {
    type: string
    hidden: yes
    sql: ${TABLE}.reward_event ;;
  }
  dimension: reward_event_clean {
    label: "Reward Event"
    type: string
    sql: @{reward_events} ;;
  }
  dimension: reward_type {
    type: string
    hidden: yes
    sql: ${TABLE}.reward_type ;;
  }
  dimension: reward_type_clean {
    label: "Reward Type"
    type: string
    sql: @{reward_types} ;;
  }
  measure: player_count {
    label: "Unique Players"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: reward_count {
    type: count
  }
  dimension: reward_amount {
    type: number
    sql: ${TABLE}.reward_amount ;;
  }
  measure: reward_amount_sum {
    label: "Total Currency Rewarded"
    type: sum
    value_format: "#,###"
    sql: ${reward_amount} ;;
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
  measure: currency_rewarded_amount_975th {
    group_label: "Currency Rewards"
    label: "Currency Rewards - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${reward_amount} ;;
  }

  drill_fields: [rdg_id,reward_type,reward_amount_sum, current_card, last_unlocked_card, current_card_numbered]
}
