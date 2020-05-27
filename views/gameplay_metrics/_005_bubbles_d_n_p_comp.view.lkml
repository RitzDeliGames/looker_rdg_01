include: "/views/**/events.view"

view: _005_bubbles_d_n_p_comp {
  extends: [events]
  derived_table: {
    sql: SELECT extra_json,
       user_type,
       timestamp_insert
FROM events
WHERE event_name = 'round_end'
AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: primary_key {
    hidden: yes
    type: string
    sql:  CONCAT(${character},${extra_json}) ;;
  }

  dimension_group: timestamp_insert {
    type: time
    hidden: yes
    sql: ${TABLE}.timestamp_insert ;;
  }

  dimension: character {
    hidden: yes
    type: string
    sql: JSON_EXTRACT_SCALAR(${extra_json},'$.team_slot_0') ;;
  }


  dimension: extra_json {
    type: string
    hidden: yes
    suggest_explore: events
    suggest_dimension: events.extra_json
#     sql: ${TABLE}.extra_json ;;
  }

  dimension: bubbles_x_axis {
    type: string
    sql: CASE WHEN ${TABLE}.extra_json IS NOT NULL THEN 'bubbles'
      END ;;
  }

  dimension: user_type {
    type: string
    suggest_explore: events
    suggest_dimension: events.user_type
#     sql: ${TABLE}.user_type ;;
  }


# Bubbles Dimensions:


  dimension: bubble_normal {
    type: number
    sql: bubble_normal ;;
  }

  dimension: bubble_coins {
    type: number
    sql: bubble_coins;;
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

 dimension: total_bubbles {
   type:  number
   sql: (CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)) +
        (CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)) +
        (CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)) +
        (CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)) +
        (CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC))
  ;;
 }



  parameter: boxplot_ {
    type: string
    allowed_value: {
      label: "bubble normal"
      value: "bubble normal"
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
    allowed_value: {
      label: "All bubbles"
      value: "All bubbles"
    }

  }


# Bubbles Boxplots

  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_score+desc"
    }
    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.total_bubbles+desc"
    }
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
      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN  CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC) +
        CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC) +
        CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC) +
        CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC) +
        CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_score+desc"
    }
    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.total_bubbles+desc"
    }
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
      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN  CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC) +
        CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC) +
        CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC) +
        CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC) +
        CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_score+desc"
    }
    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.total_bubbles+desc"
    }
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
      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN  CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC) +
        CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC) +
        CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC) +
        CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC) +
        CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_score+desc"
    }
    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.total_bubbles+desc"
    }
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
      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN  CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC) +
        CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC) +
        CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC) +
        CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC) +
        CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_score+desc"
    }
    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.total_bubbles+desc"
    }
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
      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN  CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC) +
        CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC) +
        CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC) +
        CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC) +
        CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)
    END  ;;
  }


  set: detail {
    fields: [
      character,
      user_type,
      bubble_normal.bubble_normal,
      bubble_coins.bubble_coins,
      bubble_xp.bubble_xp,
      bubble_score.bubble_score,
      bubble_time.bubble_time,
      total_bubbles
      ]
  }
}
