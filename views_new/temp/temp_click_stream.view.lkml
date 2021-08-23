view: temp_click_stream {
  derived_table: {
    sql:
      select
        rdg_id
        ,install_version
        ,timestamp
        ,event_name
        ,engagement_ticks
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,cast(quests_completed as int64) quests_completed
        ,json_extract_scalar(extra_json,"$.button_tag") button_tag
        ,extra_json
        ,lag(timestamp)
            over (partition by rdg_id order by timestamp desc) greater_quests_completed
      from `eraser-blast.game_data.events`
      where
        event_name = 'ButtonClicked'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
      group by 1,2,3,4,5,6,7,8,9,10,11
      ;;
    datagroup_trigger: change_3_hrs
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
    hidden: no
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
  dimension: greater_quests_completed {}#RENAME!!!
  dimension: is_churned {
    type: yesno
    sql: ${greater_quests_completed} is null ;;
  }
  dimension: install_version {}
  dimension: event_name {}
  dimension: engagement_ticks {
    type: number
    sql: ${TABLE}.engagement_ticks ;;
  }
  dimension: engagement_minutes {
    type: number
    sql: ${TABLE}.engagement_ticks / 2 ;;
  }
  measure: engagement_minutes_med {
    label: "Engagement Minutes - Median"
    type: median
    sql:  ${engagement_minutes};;
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
  # dimension: card_id {
  #   group_label: "Card Dimensions"
  #   type: string
  #   sql: coalesce(${last_unlocked_card},${current_card}) ;;
  # }
  dimension: current_card_quest {
    group_label: "Card Dimensions"
    label: "Current Card + Quest"
    type: number
    sql: ${current_card_numbered} + ${current_quest};;
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
  dimension: current_quest {
    group_label: "Card Dimensions"
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: quests_completed {
    type: number
    sql: ${TABLE}.quests_completed ;;
  }
  dimension: extra_json {
    hidden: yes
  }
  dimension: button_tag_raw {
    sql: ${TABLE}.button_tag ;;
  }
  dimension: button_tag {
    sql: @{button_tags} ;;
  }
  measure: player_count {
    label: "Count of Players"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [last_unlocked_card, rdg_id]
  }
  dimension: click_count {}
  measure: button_clicks {
    label: "Count of Clicks"
    type: count
  }
}
