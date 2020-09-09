view: sessions {
  derived_table: {
    sql: SELECT CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS DATE) AS event_date,
       CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', created_at , 'America/Los_Angeles')) AS DATE) AS signup_day,
       --session_id,
       current_card,
       user_id,
       JSON_Value(extra_json, '$.card_id') AS card_id,
       COUNT(DISTINCT timestamp) AS rounds_played,
       COUNT(DISTINCT session_id) AS sessions,
       (COUNT(DISTINCT timestamp) / COUNT(DISTINCT session_id)) AS ratio,

FROM `eraser-blast.game_data.events` AS events
WHERE (user_type = 'external') AND (user_type NOT IN ("internal_editor", "unit_test") AND (event_name = 'cards'))
  AND user_id <>  "user_id_not_set"
GROUP BY event_date, signup_day, user_id, round_id, card_id, current_card--, session_id
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_date {
    type: date
    sql: CAST(${TABLE}.event_date AS TIMESTAMP) ;;
  }

  dimension: signup_day {
    type: date
    sql: ${TABLE}.signup_day ;;
  }

#   dimension: session_id {
#     type: string
#     sql: ${TABLE}.session_id ;;
#   }

  dimension: current_card {
    type: string
    sql: ${TABLE}.current_card ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: card_id {
    type: string
    sql: ${TABLE}.card_id ;;
  }

  dimension: rounds_played {
    type: number
    sql: ${TABLE}.rounds_played ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: ratio {
    type: number
    sql: ${TABLE}.ratio ;;
  }

  set: detail {
    fields: [
      event_date,
      signup_day,

      user_id,
      card_id,
      rounds_played,
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
    allowed_value: {
      label: "Rounds Played"
      value: "Rounds Played"
    }
  }

  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Session"
      url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
      WHEN  {% parameter boxplot_type %} = 'Rounds Played'
      THEN ${rounds_played}
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Session"
      url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
      WHEN  {% parameter boxplot_type %} = 'Rounds Played'
      THEN ${rounds_played}

    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Session"
      url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
      WHEN  {% parameter boxplot_type %} = 'Rounds Played'
      THEN ${rounds_played}
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Session"
      url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
      WHEN  {% parameter boxplot_type %} = 'Rounds Played'
      THEN ${rounds_played}
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions_rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Session"
      url: "{{ link }}&sorts=sessions.rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${ratio}
      WHEN  {% parameter boxplot_type %} = 'Rounds Played'
      THEN ${rounds_played}
    END  ;;
  }

}
