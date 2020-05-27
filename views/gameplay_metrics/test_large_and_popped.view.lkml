view: test_large_and_popped {
  derived_table: {
    sql: SELECT user_type,
      extra_json,
      hardware,
      platform
FROM events
WHERE event_name = 'round_end'
AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: round_x_axis {
    type: string
    sql: CASE WHEN ${TABLE}.extra_json IS NOT NULL THEN 'x'
      END ;;
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
    type: string
    hidden: yes
    suggest_explore: events
    suggest_dimension: events.extra_json
#     sql: ${TABLE}.extra_json ;;
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
    sql: large ;;
  }

  dimension: large_popped {
    type: string
    sql: large_popped ;;
  }

  dimension: eraser {
    type: string
    sql: JSON_EXTRACT(${extra_json},'$.team_slot_0');;
  }


  dimension: test {
#     sql: concat(character._parameter_value, boxplot_large_n_p._parameter_value) ;;
    sql: {{ character._parameter_value | append: boxplot_large_n_p._parameter_value }} ;;
  }


  parameter: character {
#     allowed_value: {
#       label: "character_01"
#       value: "${character_01}_large}"
#    }
#     allowed_value: {
#       label: "character_01"
#       value: "${character_01}_large_popped}"
#     }
    type: unquoted
    default_value: "character_01"
    suggest_explore: _001_coins_xp_score
    suggest_dimension: _001_coins_xp_score.character
  }


  dimension: platform_type {
    type: string
    sql: CASE
      WHEN ${TABLE}.platform LIKE '%Android%' THEN 'mobile'
      WHEN ${TABLE}.platform LIKE '%iOS%' THEN 'mobile'
      ELSE 'desktop (web)'
      END ;;
  }


  parameter: boxplot_large_n_p {
    type: unquoted
    allowed_value: {
      label: "_large"
      value: "_large"
    }
    allowed_value: {
      label: "_large_popped"
      value: "_large_popped"
    }
  }


  # BOXPLOTS

#       WHEN  {%  parameter boxplot_large_n_p %} = _large
#       THEN CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
#       WHEN  {% parameter boxplot_large_n_p %} = _large_popped
#       THEN CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)


  measure: 1_min_boxplot {
    group_label: "BoxPlot"
    type: min
    sql:
      {% if boxplot_large_n_p._parameter_value == '_large' %}
      CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      {% elsif boxplot_large_n_p._parameter_value == '_large_popped' %}
      CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      {% endif %}
      ;;
  }

  measure: 5_max_boxplot {
    group_label: "BoxPlot"
    type: max
    sql:
      {% if boxplot_large_n_p._parameter_value == '_large' %}
      CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      {% elsif boxplot_large_n_p._parameter_value == '_large_popped' %}
      CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      {% endif %}
      ;;
  }

  measure: 3_median_boxplot {
    group_label: "BoxPlot"
    type: median
    sql:
      {% if boxplot_large_n_p._parameter_value == '_large' %}
      CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      {% elsif boxplot_large_n_p._parameter_value == '_large_popped' %}
      CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      {% endif %}
      ;;
  }

  measure: 2_25th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql:
      {% if boxplot_large_n_p._parameter_value == '_large' %}
      CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      {% elsif boxplot_large_n_p._parameter_value == '_large_popped' %}
      CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      {% endif %}
      ;;
  }

  measure: 4_75th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql:
      {% if boxplot_large_n_p._parameter_value == '_large' %}
      CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      {% elsif boxplot_large_n_p._parameter_value == '_large_popped' %}
      CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      {% endif %}
      ;;
  }

  measure: sum {
    group_label: "BoxPlot"
    type: sum
    sql:
      {% if boxplot_large_n_p._parameter_value == '_large' %}
      CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      {% elsif boxplot_large_n_p._parameter_value == '_large_popped' %}
      CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      {% endif %}
      ;;
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
      test
    ]
  }
}
