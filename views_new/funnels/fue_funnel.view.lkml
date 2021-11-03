view: fue_funnels {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,json_extract_scalar(extra_json,"$.current_FueStep") fue_step
        ,json_extract_scalar(extra_json,"$.current_ChoreographyStepId") fue_step_choreography
        ,extra_json
      from `eraser-blast.game_data.events`
      where
        event_name = 'FUE'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1';;
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
  dimension: last_unlocked_card_numbered {
    type: number
    sql: @{last_unlocked_card_numbered} ;;
    value_format: "####"
  }
  dimension: current_quest {
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: fue_step {}
  dimension: fue_step_choreography {}
  measure: player_count {
    label: "Count of Players"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
}
