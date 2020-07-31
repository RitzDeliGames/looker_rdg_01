view: sessions_alt {
  derived_table: {
    sql: SELECT CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS DATE) AS event,
       user_id, session_id, JSON_EXTRACT(extra_json, '$.rounds') AS rounds, JSON_EXTRACT(extra_json, '$.sessions') AS sessions,
       ((CAST(JSON_EXTRACT(extra_json, '$.rounds') AS NUMERIC)) / (CAST(JSON_EXTRACT(extra_json, '$.sessions') AS NUMERIC))) AS ratio,
FROM `eraser-blast.game_data.events`
WHERE (user_type = 'external') AND (user_type NOT IN ("internal_editor", "unit_test") AND (event_name = 'cards'))
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: event {
    type: time
    sql: cast(${TABLE}.event  as timestamp) ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: rounds {
    type: string
    sql: ${TABLE}.rounds ;;
  }

  dimension: sessions {
    type: string
    sql: ${TABLE}.sessions ;;
  }

  dimension: ratio {
    type: number
    sql: ${TABLE}.ratio ;;
  }

  set: detail {
    fields: [
      event_date,
      user_id,
      session_id,
      rounds,
      sessions,
      ratio
    ]
  }

  parameter: boxplot_type {
    type: string
    allowed_value: {
      label: "Sessions per Date"
      value: "Sessions per Date"
    }
    allowed_value: {
      label: "Rounds per Session"
      value: "Rounds per Session"
    }
  }

  measure: 1_min_boxplot {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Sessions"
#       url: "{{ link }}&sorts=sessions.sessions+desc"
#     }
#     link: {
#       label: "Drill and sort by Rounds per Session"
#       url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
#     }
    group_label: "BoxPlot Measures"
    type: min
    sql: CASE
      --WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      --THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
    END  ;;
  }

  measure: 5_max_boxplot {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Sessions"
#       url: "{{ link }}&sorts=sessions.sessions+desc"
#     }
#     link: {
#       label: "Drill and sort by Rounds per Session"
#       url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
#     }
    group_label: "BoxPlot Measures"
    type: max
    sql: CASE
      --WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      --THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
    END  ;;
  }

  measure: 3_median_boxplot {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Sessions"
#       url: "{{ link }}&sorts=sessions.sessions+desc"
#     }
#     link: {
#       label: "Drill and sort by Rounds per Session"
#       url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
#     }
    group_label: "BoxPlot Measures"
    type: median
    sql: CASE
      --WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      --THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
    END  ;;
  }

  measure: 2_25th_boxplot {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Sessions"
#       url: "{{ link }}&sorts=sessions.sessions+desc"
#     }
#     link: {
#       label: "Drill and sort by Rounds per Session"
#       url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
#     }
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 25
    sql: CASE
      --WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      --THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
    END  ;;
  }

  measure: 4_75th_boxplot {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Sessions"
#       url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
#     }
#     link: {
#       label: "Drill and sort by Rounds per Session"
#       url: "{{ link }}&sorts=sessions.rounds+desc"
#     }
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 75
    sql: CASE
      --WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      --THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
    END  ;;
  }
}
