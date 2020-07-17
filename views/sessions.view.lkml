
view: sessions {

  derived_table: {
    sql:  SELECT CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS DATE) AS date,
                 user_id,
                 COUNT(DISTINCT session_id) AS sessions
          FROM `eraser-blast.game_data.events`
          WHERE user_id <>  "user_id_not_set"
          GROUP BY date, user_id
          ORDER BY date DESC
       ;;
  }



  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date {
    datatype: date
    type: date
    sql: ${TABLE}.date ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }

  dimension: rounds {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.rounds') AS NUMERIC) ;;
  }


  set: detail {
    fields: [date, user_id, sessions]
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
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=sessions.rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${rounds}
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions+desc"
    }
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=sessions.rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${rounds}
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions+desc"
    }
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=sessions.rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${rounds}
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions+desc"
    }
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=sessions.rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${rounds}
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Sessions"
      url: "{{ link }}&sorts=sessions.sessions+desc"
    }
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=sessions.rounds+desc"
    }
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Sessions per Date'
      THEN ${sessions}
      WHEN  {% parameter boxplot_type %} = 'Rounds per Session'
      THEN ${rounds}
    END  ;;
  }


}
