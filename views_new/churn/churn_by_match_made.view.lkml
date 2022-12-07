view: churn_by_match_made {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,session_id
        ,json_extract_scalar(extra_json,'$.cleared') tiles_cleared
        ,json_extract_scalar(extra_json,'$.level') level_name
        ,json_extract_scalar(extra_json,'$.objective_count_total') objective_count_total
        ,json_extract_scalar(extra_json,'$.objective_progress') objective_progress
        ,json_extract_scalar(extra_json,'$.objective_0') objective_0
        ,json_extract_scalar(extra_json,'$.objective_1') objective_1
        ,json_extract_scalar(extra_json,'$.objective_2') objective_2
        ,json_extract_scalar(extra_json,'$.objective_3') objective_3
        ,json_extract_scalar(extra_json,'$.moves') moves_remaining
      from game_data.events
      where event_name = 'match_made'
      and timestamp >= '2022-06-01'
      and user_type = 'external'
      and country != 'ZZ'
    ;;
    datagroup_trigger: change_6_hrs
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
  dimension: objective_0 {
    group_label: "Objectives"
    type: number
    sql: ${TABLE}.objective_0 ;;
  }
  dimension:  objective_1 {
    group_label: "Objectives"
    type: number
    sql: ${TABLE}.objective_1 ;;
  }
  dimension:  objective_2 {
    group_label: "Objectives"
    type: number
    sql: ${TABLE}.objective_2 ;;
  }
  dimension:  objective_3 {
    group_label: "Objectives"
    type: number
    sql: ${TABLE}.objective_3 ;;
  }
  dimension: moves {
    type: number
    sql: ${TABLE}.moves ;;
  }
}
