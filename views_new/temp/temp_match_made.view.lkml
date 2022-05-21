view: temp_match_made {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,session_id
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,cast(quests_completed as int64) quests_completed
        ,json_extract_scalar(extra_json,'$.cleared') tiles_cleared
        ,json_extract_scalar(extra_json,'$.level') level_name
        ,json_extract_scalar(extra_json,'$.objective_count_total') objective_count_total
        ,json_extract_scalar(extra_json,'$.objective_progress') objective_progress
        ,json_extract_scalar(extra_json,'$.objective_Balloon_value') objective_Balloon_value
        ,json_extract_scalar(extra_json,'$.moves') moves_remaining
      from game_data.events
      where event_name = 'match_made'
      and timestamp >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
    ;;
    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
  }

  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || '_' || ${event_time} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    # hidden: yes
  }
  measure: player_count {
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]
  }
  dimension: current_card {
    group_label: "Card Dimensions"
    label: "Player Current Card"
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card"
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: last_unlocked_card_numbered {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card (Numbered)"
    type: number
    value_format: "####"
    sql: @{last_unlocked_card_numbered} ;;
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    label: "Player Current Card (Numbered)"
    type: number
    value_format: "####"
    sql: @{current_card_numbered} ;;
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
  dimension: tiles_cleared {
    type: string
    sql: ${TABLE}.tiles_cleared ;;
  }
  dimension: level {
    type: string
    sql: ${TABLE}.level ;;
  }
  dimension: objective_count_total {
    type: number
    sql: ${TABLE}.objective_count_total ;;
  }
  dimension: objective_progress {
    type: number
    sql: ${TABLE}.objective_progress ;;
  }
  dimension: moves {
    type: number
    sql: ${TABLE}.moves ;;
  }
}
