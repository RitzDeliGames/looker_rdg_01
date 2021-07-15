view: system_value {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,current_card
        ,last_unlocked_card
        ,json_extract_scalar(extra_json,'$.reward_event') reward_event
        ,json_extract_scalar(extra_json,'$.reward_type') reward_type
        ,cast(json_extract_scalar(extra_json,'$.reward_amount') as int64) reward_amount
      from game_data.events
      where event_name = 'reward'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
      --and current_card = last_unlocked_card do we still need this condition???
      and (json_extract_scalar(extra_json,'$.reward_event') like '%bingo%' or json_extract_scalar(extra_json,'$.reward_event') like '%round%')--or json_extract_scalar(extra_json,'$.reward_event') like '%level_up%'
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${event_raw} ;;
  }
  dimension: rdg_id {
    hidden: no
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension_group: event {
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
  dimension: current_card {
    group_label: "Card Dimensions"
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    group_label: "Card Dimensions"
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: card_id {
    group_label: "Card Dimensions"
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: reward_event {
    type: string
    sql: ${TABLE}.reward_event ;;
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
  dimension: reward_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.reward_amount ;;
  }
  dimension: system_value {
    type: number
    sql: cast(@{system_value_conversion} as int64) * ${TABLE}.reward_amount;;
  }
  measure: reward_amount_sum {
    type: sum
    sql: ${reward_amount} ;;
  }
  measure: system_value_sum {
    type: sum
    sql: ${system_value} ;;
  }
}
