view: round_start {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,session_id
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,cast(json_extract_scalar(extra_json,'$.round_id') as int64) round_id
      from game_data.events
      where event_name = 'round_end'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
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
      ,month
      ,year
    ]
  }
  dimension: session_id {}
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
  dimension: card_id {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card (Coalesced)"
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    label: "Player Current Card (Numbered)"
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: current_quest {
    group_label: "Card Dimensions"
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }
  dimension: quest_complete {
    type: yesno
    sql: ${TABLE}.quest_complete ;;
  }
  measure: round_end_count {
    label: "Rounds Started"
    type: count
  }
  measure: session_count {
    label: "Sessions Played"
    type: count_distinct
    sql: ${TABLE}.session_id ;;
  }

  drill_fields: [rdg_id,current_card_numbered]
}
