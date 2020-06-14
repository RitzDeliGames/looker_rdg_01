view: scene_load_time {
  derived_table: {
    sql: SELECT extra_json,
       JSON_EXTRACT(extra_json, '$.load_time') AS load_time,
       JSON_EXTRACT(extra_json, '$.transition_from') AS transition_from,
       JSON_EXTRACT(extra_json, '$.transition_to') AS transition_to

FROM events
WHERE event_name = "transition"
AND user_type NOT IN ("internal_editor", "unit_test")
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: load_time {
    type: string
    sql: ${TABLE}.load_time ;;
  }

  dimension: transition_from {
    type: string
    sql: ${TABLE}.transition_from ;;
  }

  dimension: transition_to {
    type: string
    sql: ${TABLE}.transition_to ;;
  }

  measure: load_time_num {
    type: sum
    sql: CAST(${load_time} AS NUMERIC) ;;
  }



  set: detail {
    fields: [extra_json, load_time, transition_from, transition_to]
  }
}
