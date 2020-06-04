view: _004_large_d_n_p_comp {
  derived_table: {
    sql: SELECT user_type,
      extra_json,
      hardware,
      platform,
      JSON_Value(extra_json,'$.total_large_popped') AS total_large_popped,
      JSON_Value(extra_json,'$.total_large_dropped') AS total_large_dropped
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
    sql:  CONCAT(${character_},${extra_json}) ;;
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
    hidden: yes
    type: string
    sql: large ;;
  }

  dimension: large_popped {
    hidden: yes
    type: string
    sql: large_popped ;;
  }

  dimension: total_large_dropped {
    type: string
    sql: ${TABLE}.total_large_dropped ;;
#     sql: JSON_Value(${extra_json},'$.total_large_dropped') ;;
  }

  dimension: total_large_popped {
    type: string
    sql: ${TABLE}.total_large_popped ;;
#     sql: JSON_Value(${extra_json},'$.total_large_popped') ;;
  }

  dimension: character_ {
    type: string
    sql: JSON_EXTRACT(${extra_json},'$.team_slot_0') ;;
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
    suggest_explore: events
    suggest_dimension: events.character
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
    allowed_value: {
      label: "total_large_dropped"
      value: "total_large_dropped"
    }
    allowed_value: {
      label: "total_large_popped"
      value: "total_large_popped"
    }
  }


  # BOXPLOTS

  measure: 1_min_boxplot {
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = '_large'
      THEN CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = '_large_popped'
      THEN CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
  }



  measure: 5_max_boxplot {
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = '_large'
      THEN CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = '_large_popped'
      THEN CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
  }

  measure: 3_median_boxplot {
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = '_large'
      THEN CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = '_large_popped'
      THEN CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
  }

  measure: 2_25th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = '_large'
      THEN CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = '_large_popped'
      THEN CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
  }

  measure: 4_75th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = '_large'
      THEN CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = '_large_popped'
      THEN CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
  }

  measure: sum {
    group_label: "BoxPlot"
    type: sum
    sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = '_large'
      THEN CAST(if(${large.large} = '' , '0', ${large.large}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = '_large_popped'
      THEN CAST(if(${large_popped.large_popped} = '' , '0', ${large_popped.large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
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
      total_large_dropped,
      total_large_popped
    ]
  }
}
