include: "/views/**/events.view"

view: scene_load_time {
  extends: [events]


# view: scene_load_time {
#   derived_table: {
#     sql: SELECT extra_json,
#        JSON_EXTRACT(extra_json, '$.load_time') AS load_time,
#        JSON_EXTRACT(extra_json, '$.transition_from') AS transition_from,
#        JSON_EXTRACT(extra_json, '$.transition_to') AS transition_to
#
# FROM events
# WHERE event_name = "transition"
# AND user_type NOT IN ("internal_editor", "unit_test")
#  ;;
#   }




  measure: count {
    type: count
    drill_fields: [detail*]
  }

#   dimension: extra_json {
#     type: string
#     sql: ${TABLE}.extra_json ;;
#   }

  dimension: load_time {
    type: string
    sql: CAST(JSON_EXTRACT(extra_json, '$.load_time') AS NUMERIC) ;;
#     sql: ${TABLE}.load_time ;;
  }

  dimension: transition_from {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.transition_from') ;;
#     sql: ${TABLE}.transition_from ;;
  }

  dimension: transition_to {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.transition_to') ;;
#     sql: ${TABLE}.transition_to ;;
  }

  dimension: transition_from_to {
    type: string
    sql: CONCAT(${transition_from}, " - ", ${transition_to}) ;;
  }

  measure: load_time_num {
    type: sum
    sql: CAST(${load_time} AS NUMERIC) ;;
  }



########BOX_PLOT########


  measure: 1_min_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time+desc"
    }
    group_label: "boxplot"
    type: min
    sql: CAST(${load_time} AS NUMERIC) ;;
  }

  measure: 5_max_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time+desc"
    }
    group_label: "boxplot"
    type: max
    sql: CAST(${load_time} AS NUMERIC) ;;
  }

  measure: 3_median_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time+desc"
    }
    group_label: "boxplot"
    type: median
    sql: CAST(${load_time} AS NUMERIC) ;;
  }

  measure: 2_25_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time+desc"
    }
    group_label: "boxplot"
    type: percentile
    percentile: 25
    sql: CAST(${load_time} AS NUMERIC) ;;
  }

  measure: 4_75_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time+desc"
    }
    group_label: "boxplot"
    type: percentile
    percentile: 75
    sql: CAST(${load_time} AS NUMERIC) ;;
  }



  set: detail {
    fields: [
             user_type,
             device_brand,
             game_version_str,
             transition_from_to,
             load_time]
  }
}
