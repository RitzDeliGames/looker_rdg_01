view: fever_count_query {
  derived_table: {
    sql: SELECT extra_json,
      FROM events
      WHERE event_name = 'round_end'
      AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
       ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: extra_json {
    hidden: yes
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: team_slot_skill_0 {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_skill_0') ;;
  }

  dimension: team_slot_level_0 {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_level_0') ;;
  }

  dimension: fever_count {
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
      label: "Fever"
      value: "Fever"
    }
  }


  measure: 1_min_boxplot {
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  measure: 5_max_boxplot {
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  measure: 3_median_boxplot {
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  measure: 2_25th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  measure: 4_75th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_fever %} = 'Fever'
      THEN ${fever_count}
    END  ;;
  }

  set: detail {
    fields: [extra_json,
      team_slot_skill_0,
      team_slot_level_0,
      fever_count,
      character]
  }
}
