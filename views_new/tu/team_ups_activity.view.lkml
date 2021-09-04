view: team_ups_activity {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,json_extract_scalar(extra_json,"$.event_id") event_id
        ,json_extract_scalar(extra_json,"$.team_id") team_id
        ,cast(json_extract_scalar(extra_json,"$.difficulty_level") as int64) difficulty_level
        ,extra_json
      from game_data.events
      where event_name = 'team_ups_join'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
      group by 1,2,3,4,5,6
    ;;
    datagroup_trigger: change_3_hrs
  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_id} ||timestamp;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: event_id {
    label: "Event ID"
    sql: ${TABLE}.event_id ;;
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
  dimension: team_id {
    label: "Team ID"
    sql: ${TABLE}.team_id ;;
  }
  measure: team_count {
    label: "Team Count"
    type: count_distinct
    sql: ${team_id} ;;
  }
  dimension: difficulty_level {
    label: "Difficulty Level"
    type: number
    sql: ${TABLE}.difficulty_level ;;
  }
  measure: player_count {
    label: "Player Count"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  dimension: extra_json {
    hidden: yes
    sql: ${TABLE}.extra_json ;;
  }
}
