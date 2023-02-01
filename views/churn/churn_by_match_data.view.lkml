## WORK IN PROGRESS

view: churn_by_match_data {
  derived_table: {
    sql: select
          rdg_id
          ,timestamp
          ,last_level_id
          ,cast(last_level_serial as int64) last_level_serial
          --,json_extract_scalar(extra_json,'$.cleared') tiles_cleared
          ,cast(json_extract_scalar(extra_json,'$.moves') as int64) moves_remaining
          ,json_extract_scalar(extra_json,'$.objective_count_total') objective_count_total
          ,json_extract_scalar(extra_json,'$.objective_progress') objective_progress
          ,json_extract_scalar(extra_json,'$.objective_0') objective_0
          ,json_extract_scalar(extra_json,'$.objective_1') objective_1
          ,json_extract_scalar(extra_json,'$.objective_2') objective_2
          ,json_extract_scalar(extra_json,'$.objective_3') objective_3
          ,json_extract_scalar(extra_json,'$.level') level
          ,cast(last_value(last_level_serial)
                  over (
                      partition by rdg_id
                      order by timestamp
                      rows between 1 preceding AND 1 following
                  ) as int64) as greater_last_level_serial --does this need to include the round_end event so we can capture players that win the level?
          ,experiments
        from `eraser-blast.game_data.events`
        where user_type = 'external'
          and event_name = 'match_made'
          and timestamp >= '2022-06-01'
        order by rdg_id, timestamp desc
      ;;
    datagroup_trigger: change_6_hrs}

  dimension: rdg_id {
    type: string
  }
  dimension: timestamp {
    type: date_time
  }
  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${timestamp} ;;
  }
  dimension: level {
    group_label: "Level Dimensions"
    label: "Level - Extracted"
    type: string
  }
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
  }
  dimension: greater_last_level_serial {
    group_label: "Level Dimensions"
    label: "Greater Last Level Completed"
    type: number
  }
  dimension: churn {
    type: string
    sql: if(${last_level_serial} < ${greater_last_level_serial},'advanced_to_next_level','still_on_current_tile') ;;
  }
  dimension: is_churn {
    hidden: no
    type: yesno
    sql:  ${last_level_serial} < ${greater_last_level_serial};;
  }
  dimension: moves_remaining {
    type: number
  }
  dimension: objective_count_total {
    type: string
  }
  dimension:  objective_progress {
    type: number
    value_format: "#%"
  }
  dimension: objective_0 {
    group_label: "Objectives"
    type: number
  }
  dimension:  objective_1 {
    group_label: "Objectives"
    type: number
  }
  dimension:  objective_2 {
    group_label: "Objectives"
    type: number
  }
  dimension:  objective_3 {
    group_label: "Objectives"
    type: number
  }

  dimension: experiments {
    type: string
    sql: ${TABLE}.experiments ;;
    hidden: yes
  }
  dimension: fueLevels_20220815   {
    group_label: "Experiments - Live"
    label: "FUE Revamp - v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.fueLevels_20220815'),'unassigned') ;;
  }
  measure: player_count {
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id,last_level_serial,greater_last_level_serial]
  }
}
