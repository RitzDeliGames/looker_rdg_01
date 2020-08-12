
view: sessions {

  derived_table: {
    sql:  SELECT CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS DATE) AS event,
                 CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', created_at , 'America/Los_Angeles')) AS DATE) AS signup_day,
                 user_id,
                 COUNT(DISTINCT session_id) AS sessions,
                 COUNT(session_id) AS sessions_rounds,
                 (COUNT(session_id) / COUNT(DISTINCT session_id)) AS ratio,

          FROM `eraser-blast.game_data.events`
          WHERE (user_type = 'external') AND (user_type NOT IN ("internal_editor", "unit_test") AND (event_name = 'cards'))
          AND user_id <>  "user_id_not_set"
          --WHERE user_id <>  "user_id_not_set" AND event_name = 'cards'
          GROUP BY user_id, event, signup_day
       ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

#   dimension: date {
#     datatype: date
#     type: date
#     sql: ${TABLE}.date ;;
#   }

  dimension_group: signup_day {
    type: time
    sql: cast(${TABLE}.signup_day as timestamp)  ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: ratio {
    type: number
    sql: ${TABLE}.ratio ;;
  }

#   dimension: user_type {
#     type: string
#     sql: ${TABLE}.user_type ;;
#   }


  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }


#   dimension: session_id {
#     type: number
#     sql: ${TABLE}.session_id ;;
#   }

#   dimension: event_name {
#     hidden: yes
#     type: number
#     sql: ${TABLE}.event_name ;;
#   }

  dimension: sessions_rounds {
    type: number
    sql: ${TABLE}.sessions_rounds ;;
  }

#   dimension: rounds {
#     type: number
#     sql: ${TABLE}.rounds ;;
#   }


  dimension_group: event {
    type: time
    sql: cast(${TABLE}.event  as timestamp) ;;
  }

  dimension_group: diff  {
    type: duration
    sql_start: cast(${signup_day_raw} as timestamp) ;;
    sql_end: cast(${event_raw} as timestamp) ;;
  }


  set: detail {
    fields: [event_date, user_id, sessions, sessions_rounds]  #, events.session_id]
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
    END  ;;
  }

}
