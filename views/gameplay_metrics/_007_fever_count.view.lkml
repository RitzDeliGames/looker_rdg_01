include: "/views/**/events.view"

view: _007_fever_count {
  extends: [events]

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: character_skill {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_skill_0') ;;
  }

  dimension: character_level {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_level_0') ;;
  }

  dimension: fever_count {
    hidden: yes
    type: number
    sql: CAST(JSON_Value(extra_json,'$.fever_count') AS NUMERIC) ;;
  }

  dimension: character {
    type: string
    sql: JSON_EXTRACT(${extra_json},'$.team_slot_0');;
  }



# FEVER COUNT BOXPLOT

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

  set: detail {
    fields: [user_type,
      character,
      fever_count,
      character_skill,
      character_level
      ]
  }
}
