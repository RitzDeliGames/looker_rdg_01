include: "/views/**/events.view"

view: scene_load_time {
  extends: [events]


  measure: count {
    type: count
    drill_fields: [detail*]
  }


#####DIMENSIONS#####

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

  dimension: transition_from_to_place {
    type: number
    sql: CASE
      WHEN ${transition_from_to} = '"UpdateCheck" - "TitleScene"'
      THEN 1
      WHEN ${transition_from_to} = '"TitleScene" - "MetaScene"'
      THEN 2
      WHEN ${transition_from_to} = '"MetaScene" - "Balls"'
      THEN 3
      WHEN ${transition_from_to} = '"Balls" - "MetaScene"'
      THEN 4
    END
    ;;
  }

  dimension: transition_from_to_place_str {
    type: string
    sql: CASE
      WHEN ${transition_from_to} = '"UpdateCheck" - "TitleScene"'
      THEN '1. UpdateCheck - TitleScene'
      WHEN ${transition_from_to} = '"TitleScene" - "MetaScene"'
      THEN '2. TitleScene - MetaScene'
      WHEN ${transition_from_to} = '"MetaScene" - "Balls"'
      THEN '3. MetaScene - Balls'
      WHEN ${transition_from_to} = '"Balls" - "MetaScene"'
      THEN '4. Balls - MetaScene'
    END
    ;;
  }

  dimension: load_time_sec {
    type: number
    sql: CAST((${load_time} / 1000) AS NUMERIC) ;;
  }

  dimension: load_time_sec_rd_1 {
    type: number
    sql: ROUND(CAST((${load_time} / 1000) AS NUMERIC), 1) ;;
  }

  dimension: load_time_sec_rd_0 {
    type: number
    sql: ROUND(CAST((${load_time} / 1000) AS NUMERIC), 0) ;;
  }


  ####################


  dimension: user_id_load {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: timestamp_load {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp ;;
  }

  dimension: session_id_load {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: extra_json {
    type: string
    hidden: yes
    sql: ${TABLE}.extra_json ;;
  }

  ####################



#####BOXPLOT SCENE LOAD TIME#####

  measure: 1_min_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time_sec+desc"
    }
    group_label: "boxplot"
    type: min
    sql: CAST(${load_time_sec} AS NUMERIC) ;;
  }

  measure: 5_max_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time_sec+desc"
    }
    group_label: "boxplot"
    type: max
    sql: CAST(${load_time_sec} AS NUMERIC) ;;
  }

  measure: 3_median_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time_sec+desc"
    }
    group_label: "boxplot"
    type: median
    sql: CAST(${load_time_sec} AS NUMERIC) ;;
  }

  measure: 2_25_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time_sec+desc"
    }
    group_label: "boxplot"
    type: percentile
    percentile: 25
    sql: CAST(${load_time_sec} AS NUMERIC) ;;
  }

  measure: 4_75_transition {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by load_time"
      url: "{{ link }}&sorts=scene_load_time.load_time_sec+desc"
    }
    group_label: "boxplot"
    type: percentile
    percentile: 75
    sql: CAST(${load_time_sec} AS NUMERIC) ;;
  }


# VIEW DETAILS

  set: detail {
    fields: [
             user_type,
             device_brand,
             game_version,
             transition_from_to,
             load_time]
  }
}
