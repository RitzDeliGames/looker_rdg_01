view: new_iam {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,json_extract_scalar(extra_json,'$.campaign_id') campaign_id
        ,json_extract_scalar(extra_json,'$.campaign_name') campaign_name
        ,json_extract_scalar(extra_json,'$.template_id') template_id
        ,json_extract_scalar(extra_json,'$.ui_action') ui_action
        ,extra_json
      from game_data.events
      where event_name = 'InAppMessaging'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_8_hrs
  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_raw} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    hidden: yes
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
  dimension: extra_json {
    hidden: yes
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
    label: "Current Card (Parsed Card ID)"
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: current_quest {
    group_label: "Card Dimensions"
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: campaign_id {}
  dimension: campaign_name {}
  dimension: ui_action {
    hidden: no
  }
  dimension: iam_ui_actions {
    label: "IAM Actions"
    sql: @{iam_ui_actions} ;;
  }
  measure: players {
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: views {
    type: count_distinct
    sql: ${event_raw} ;;
  }

}
