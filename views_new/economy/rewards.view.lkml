view: rewards {
  derived_table: {
    sql:
      select
        rdg_id
        ,user_id
        ,device_id
        ,advertising_id
        ,timestamp
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,'$.reward_event') reward_event
        ,json_extract_scalar(extra_json,'$.reward_type') reward_type
        ,cast(json_extract_scalar(extra_json,'$.reward_amount') as int64) reward_amount
      from game_data.events
      where event_name = 'reward'
      and date(timestamp) between '2022-06-01' and current_date()
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${reward_raw} ;;
  }
  dimension: rdg_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: device_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.device_id ;;
  }
  dimension: advertising_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.advertising_id ;;
  }
  dimension: user_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.user_id ;;
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
  dimension: last_level_serial {
    group_label: "Last Level"
    type: number
    sql: ${TABLE}.last_level_serial ;;
  }
  dimension: reward_event_raw {
    type: string
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
    drill_fields: [reward_event_raw,reward_amount_sum]
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

  drill_fields: [rdg_id,reward_type,reward_amount_sum]
}
