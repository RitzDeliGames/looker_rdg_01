view: rewards {
  derived_table: {
    sql:
      select
        rdg_id
        ,event_name
        ,timestamp
        ,lower(hardware) device_model_number
        ,cast(ltv as int64) / 100 ltv
        ,round(cast(engagement_ticks as int64) / 2) minutes_played
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,json_extract_scalar(extra_json,'$.reward_event') reward_event
        ,json_extract_scalar(extra_json,'$.reward_type') reward_type
        ,json_extract_scalar(extra_json,'$.reward_amount') reward_amount
        ,json_extract_scalar(extra_json,'$.round_id') round_id
      from game_data.events
      where event_name = 'reward'
      and user_type = 'external'
      and country != 'ZZ'
      and install_version != '-1'
    ;;
  }
  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${event_name} || ${reward_raw} ;;
  }
  dimension: rdg_id {
    hidden: yes
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
  dimension: ltv {
    type: number
    sql: ${TABLE}.ltv ;;
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
}
