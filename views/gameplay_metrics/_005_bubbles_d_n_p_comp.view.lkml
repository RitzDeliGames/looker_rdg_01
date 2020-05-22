view: _005_bubbles_d_n_p_comp {
  derived_table: {
    sql: SELECT extra_json,
       user_type
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

  dimension: bubbles_x_axis {
    type: string
    sql: CASE WHEN ${TABLE}.extra_json IS NOT NULL THEN 'bubbles'
      END ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }


# Bubbles Dimensions:

  dimension: bubble_normal {
    type: number
    sql: bubble_normal ;;
  }

  dimension: bubble_boost {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.bubble_boost') AS NUMERIC)  ;;
  }

  dimension: bubble_coins {
    type: number
    sql: bubble_coins ;;
  }

  dimension: bubble_xp {
    type: number
    sql: bubble_xp ;;
  }

  dimension: bubble_time {
    type: number
    sql: bubble_time ;;
  }

  dimension: bubble_score {
    type: number
    sql: bubble_score ;;
  }


  parameter: boxplot_ {
    type: string
    allowed_value: {
      label: "bubble normal"
      value: "bubble normal"
    }
    allowed_value: {
      label: "bubble boost"
      value: "bubble boost"
    }
    allowed_value: {
      label: "bubble coins"
      value: "bubble coins"
    }
    allowed_value: {
      label: "bubble xp"
      value: "bubble xp"
    }
    allowed_value: {
      label: "bubble time"
      value: "bubble time"
    }
    allowed_value: {
      label: "bubble score"
      value: "bubble score"
    }
  }


# Bubbles Boxplots

  measure: 1_min_boxplot {
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble boost'
      THEN ${bubble_boost}
    END  ;;
  }

  measure: 5_max_boxplot {
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble boost'
      THEN ${bubble_boost}
    END  ;;
  }

  measure: 3_median_boxplot {
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble boost'
      THEN ${bubble_boost}
    END  ;;
  }

  measure: 2_25th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble boost'
      THEN ${bubble_boost}
    END  ;;
  }

  measure: 4_75th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble boost'
      THEN ${bubble_boost}
    END  ;;
  }


  set: detail {
    fields: [
      extra_json,
      user_type,
      bubbles_x_axis,
      bubble_boost
    ]
  }
}
