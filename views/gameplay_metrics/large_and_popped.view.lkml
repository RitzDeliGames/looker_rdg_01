view: large_and_popped {
  derived_table: {
    sql: SELECT user_type,
      extra_json,
      hardware,
      platform,
      large,
      large_popped,
      JSON_Value(extra_json,'$.team_slot_0') AS eraser,
      --JSON_Value(extra_json, '$.{% parameter character %}_large') AS large,
      --JSON_Value(extra_json, '$.{% parameter character %}_large_popped') AS large_popped,
FROM events
CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.{% parameter character %}_large'))) AS large
CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.{% parameter character %}_large_popped'))) AS large_popped
WHERE event_name = 'round_end'
AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
;;
  }

# CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.{% parameter character %}_large_popped'))) AS large_popped


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: round_x_axis {
    type: string
    sql: CASE WHEN ${TABLE}.extra_json IS NOT NULL THEN 'x'
      END ;;
  }

  dimension: eraser {
    type: string
    sql: ${TABLE}.eraser ;;
  }

  dimension: primary_key {
    type: string
    sql:  CONCAT(${eraser},${extra_json}) ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension: extra_json {
    hidden: yes
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: hardware {
    hidden: yes
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: platform {
    hidden: yes
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: large {
    type: string
    sql: CAST(${TABLE}.large AS NUMERIC) ;;
  }

  dimension: large_popped {
    type: string
    sql: CAST(${TABLE}.large_popped AS NUMERIC) ;;
  }

#   dimension: eraser {
#     type: string
#     sql: JSON_EXTRACT(${extra_json},'$.team_slot_0');;
#   }

  parameter: character {
    type: unquoted
    default_value: "character_001"
    suggest_explore: events
    suggest_dimension: events.eraser
  }


  dimension: platform_type {
    type: string
    sql: CASE
      WHEN ${TABLE}.platform LIKE '%Android%' THEN 'mobile'
      WHEN ${TABLE}.platform LIKE '%iOS%' THEN 'mobile'
      ELSE 'desktop (web)'
      END ;;
  }



  #

  parameter: boxplot_large_n_p {
    type: string
    allowed_value: {
      label: "Large Dropped"
      value: "Large Dropped"
    }
    allowed_value: {
      label: "Large Popped"
      value: "Large Popped"
    }
  }


  # BOXPLOTS MEASURES

  measure: 1_min_boxplot {
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Dropped'
      THEN ${large}
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Popped'
      THEN ${large_popped}
    END  ;;
  }

  measure: 5_max_boxplot {
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Dropped'
      THEN ${large}
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Popped'
      THEN ${large_popped}
    END  ;;
  }

  measure: 3_median_boxplot {
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Dropped'
      THEN ${large}
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Popped'
      THEN ${large_popped}
    END  ;;
  }

  measure: 2_25th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Dropped'
      THEN ${large}
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Popped'
      THEN ${large_popped}
    END  ;;
  }

  measure: 4_75th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Dropped'
      THEN ${large}
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Popped'
      THEN ${large_popped}
    END  ;;
  }

  measure: sum {
    group_label: "BoxPlot"
    type: sum
    sql: CASE
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Dropped'
      THEN ${large}
      WHEN  {% parameter boxplot_large_n_p %} = 'Large Popped'
      THEN ${large_popped}
    END  ;;
  }


# VIEW DETAILS

  set: detail {
    fields: [
      user_type,
      extra_json,
      hardware,
      platform,
      character,
      large,
      large_popped,
      platform_type,
      round_x_axis,
    ]
  }
}
