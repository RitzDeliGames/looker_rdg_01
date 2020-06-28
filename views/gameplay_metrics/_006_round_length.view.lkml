include: "/views/**/events.view"

view: _006_round_length {
  extends: [events]


  measure: count {
    type: count
    drill_fields: [detail*]
  }


#####DIMENSIONS#####

  dimension: round_x_axis {
    type: string
    sql: CASE WHEN ${TABLE}.extra_json IS NOT NULL THEN 'x'
      END ;;
  }

  dimension: character {
#     hidden: yes
    type: string
    sql: REPLACE(JSON_EXTRACT(extra_json,'$.team_slot_0'),'"','') ;;
  }

  dimension: character_skill {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_skill_0') ;;
  }

  dimension: character_level {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_level_0') ;;
  }

  dimension: round_length {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.round_length') AS NUMERIC) ;;
  }

  dimension: round_length_num {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.round_length') AS NUMERIC) / 1000 ;;
  }


#####BOXPLOT ROUND LENGTH#####

  parameter: boxplot_rounds {
    type: string
    allowed_value: {
      label: "round length"
      value: "round length"
    }
  }


  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round Length"
      url: "{{ link }}&sorts=_006_round_length.round_length_num+desc"
    }
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_rounds %} = 'round length'
      THEN ${round_length_num}
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round Length"
      url: "{{ link }}&sorts=_006_round_length.round_length_num+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_rounds %} = 'round length'
      THEN ${round_length_num}
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round Length"
      url: "{{ link }}&sorts=_006_round_length.round_length_num+desc"
    }
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_rounds %} = 'round length'
      THEN ${round_length_num}
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round Length"
      url: "{{ link }}&sorts=_006_round_length.round_length_num+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_rounds %} = 'round length'
      THEN ${round_length_num}
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round Length"
      url: "{{ link }}&sorts=_006_round_length.round_length_num+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_rounds %} = 'round length'
      THEN ${round_length_num}
    END  ;;
  }


# VIEW DETAILS

  set: detail {
    fields: [
      user_type,
      player_xp_level,
      character,
      round_length_num,
      round_length,
      round_id,
      character_skill,
      character_level
    ]
  }
}
