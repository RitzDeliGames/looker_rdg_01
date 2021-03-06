include: "/views/**/events.view"

view: _007_fever_count {
  extends: [events]


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fever_count {
    hidden: yes
    type: number
    sql: CAST(JSON_Value(extra_json,'$.fever_count') AS NUMERIC) ;;
  }


#####BOXPLOT FEVER COUNT#####

  parameter: boxplot_fever {
    type: string
    allowed_value: {
      label: "Fever Count"
      value: "Fever"
    }
  }


  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Fever Count"
      url: "{{ link }}&sorts=_007_fever_count.fever_count+desc"
    }
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Fever Count"
      url: "{{ link }}&sorts=_007_fever_count.fever_count+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Fever Count"
      url: "{{ link }}&sorts=_007_fever_count.fever_count+desc"
    }
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Fever Count"
      url: "{{ link }}&sorts=_007_fever_count.fever_count+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Fever Count"
      url: "{{ link }}&sorts=_007_fever_count.fever_count+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }


# VIEW DETAILS

  set: detail {
    fields: [user_type,
             player_xp_level,
             events.character_used,
             fever_count,
             events.character_used_skill,
             events.character_used_xp
            ]
  }
}
