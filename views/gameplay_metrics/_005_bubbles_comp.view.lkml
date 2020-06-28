include: "/views/**/events.view"

view: _005_bubbles_comp {
  extends: [events]



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
    type: string
    sql: REPLACE(JSON_EXTRACT(extra_json,'$.team_slot_0'),'"','')  ;;
  }

  dimension: bubbles_x_axis {
    type: string
    sql: CASE WHEN ${TABLE}.extra_json IS NOT NULL THEN 'bubbles'
      END ;;
  }

  ###
  dimension: bubble_normal_array {
    type: string
    sql: JSON_Value(extra_json, '$.bubble_normal') ;;
  }

  dimension: bubble_coins_array {
    type: string
    sql: JSON_Value(extra_json, '$.bubble_coins') ;;
  }

  dimension: bubble_xp_array {
    type: string
    sql: JSON_Value(extra_json, '$.bubble_xp') ;;
  }

  dimension: bubble_time_array {
    type: string
    sql: JSON_Value(extra_json, '$.bubble_time') ;;
  }

  dimension: bubble_score_array {
    type: string
    sql: JSON_Value(extra_json, '$.bubble_score') ;;
  }


#####BUBBLES DROPPED#####

  dimension: bubble_normal {
    hidden: yes
    type: number
    sql: bubble_normal ;;
  }

  dimension: bubble_coins {
    hidden: yes
    type: number
    sql: bubble_coins;;
  }

  dimension: bubble_xp {
    hidden: yes
    type: number
    sql: bubble_xp ;;
  }

  dimension: bubble_time {
    hidden: yes
    type: number
    sql: bubble_time ;;
  }

  dimension: bubble_score {
    hidden: yes
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


#####BUBBLES POPPED#####

  dimension: bubble_normal_popped {
    type: number
    sql: ARRAY_LENGTH(CASE WHEN JSON_Value(extra_json, '$.bubble_normal') = "" THEN NULL
      ELSE SPLIT(JSON_Value(extra_json, '$.bubble_normal'),',') END) ;;
  }

  dimension: bubble_coins_popped {
    type: number
    sql: ARRAY_LENGTH(CASE WHEN JSON_Value(extra_json, '$.bubble_coins') = "" THEN NULL
      ELSE SPLIT(JSON_Value(extra_json, '$.bubble_coins'),',') END) ;;
  }

  dimension: bubble_xp_popped {
    type: number
    sql: ARRAY_LENGTH(CASE WHEN JSON_Value(extra_json, '$.bubble_xp') = "" THEN NULL
      ELSE SPLIT(JSON_Value(extra_json, '$.bubble_xp'),',') END) ;;
  }

  dimension: bubble_time_popped {
    type: number
    sql: ARRAY_LENGTH(CASE WHEN JSON_Value(extra_json, '$.bubble_time') = "" THEN NULL
      ELSE SPLIT(JSON_Value(extra_json, '$.bubble_time'),',') END) ;;
  }

  dimension: bubble_score_popped {
    type: number
    sql: ARRAY_LENGTH(CASE WHEN JSON_Value(extra_json, '$.bubble_score') = "" THEN NULL
      ELSE SPLIT(JSON_Value(extra_json, '$.bubble_score'),',') END) ;;
  }




  measure: count {
    type: count
    drill_fields: [detail*]
  }



  ###################

  parameter: boxplot_ {
    type: string
    allowed_value: {
      label: "bubble normal d"
      value: "bubble normal d"
    }
    allowed_value: {
      label: "bubble coins d"
      value: "bubble coins d"
    }
    allowed_value: {
      label: "bubble xp d"
      value: "bubble xp d"
    }
    allowed_value: {
      label: "bubble time d"
      value: "bubble time d"
    }
    allowed_value: {
      label: "bubble score d"
      value: "bubble score d"
    }
    allowed_value: {
      label: "bubble normal p"
      value: "bubble normal p"
    }
    allowed_value: {
      label: "bubble coins p"
      value: "bubble coins p"
    }
    allowed_value: {
      label: "bubble xp p"
      value: "bubble xp p"
    }
    allowed_value: {
      label: "bubble time p"
      value: "bubble time p"
    }
    allowed_value: {
      label: "bubble score p"
      value: "bubble score p"
    }
    allowed_value: {
      label: "All bubbles p"
      value: "All bubbles p"
    }
  }


#####BOXPLOT BUBBLES MEASURES#####

  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score+desc"
    }

    link: {
      label: "Drill and sort by -bubble normal p-"
      url: "{{ link }}&sorts=_005_bubbles_d_n_p_comp.bubble_normal_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble time p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble score p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score_popped+desc"
    }

    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_comp.total_bubbles+desc"
    }

    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal d'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins d'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp d'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time d'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score d'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)

      WHEN  {% parameter boxplot_ %} = 'bubble normal p'
      THEN ${bubble_normal_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble coins p'
      THEN ${bubble_coins_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble xp p'
      THEN ${bubble_xp_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble time p'
      THEN ${bubble_time_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble score p'
      THEN ${bubble_score_popped}

      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN ${total_bubbles}
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score+desc"
    }

    link: {
      label: "Drill and sort by -bubble normal p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble time p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble score p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score_popped+desc"
    }

    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_comp.total_bubbles+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal d'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins d'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp d'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time d'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score d'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)

      WHEN  {% parameter boxplot_ %} = 'bubble normal p'
      THEN ${bubble_normal_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble coins p'
      THEN ${bubble_coins_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble xp p'
      THEN ${bubble_xp_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble time p'
      THEN ${bubble_time_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble score p'
      THEN ${bubble_score_popped}

      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN ${total_bubbles}
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score+desc"
    }

    link: {
      label: "Drill and sort by -bubble normal p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble time p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble score p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score_popped+desc"
    }

    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_comp.total_bubbles+desc"
    }
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal d'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins d'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp d'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time d'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score d'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)

      WHEN  {% parameter boxplot_ %} = 'bubble normal p'
      THEN ${bubble_normal_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble coins p'
      THEN ${bubble_coins_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble xp p'
      THEN ${bubble_xp_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble time p'
      THEN ${bubble_time_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble score p'
      THEN ${bubble_score_popped}

      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN ${total_bubbles}
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score+desc"
    }

    link: {
      label: "Drill and sort by -bubble normal p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble time p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble score p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score_popped+desc"
    }
    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_comp.total_bubbles+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal d'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins d'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp d'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time d'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score d'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)

      WHEN  {% parameter boxplot_ %} = 'bubble normal p'
      THEN ${bubble_normal_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble coins p'
      THEN ${bubble_coins_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble xp p'
      THEN ${bubble_xp_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble time p'
      THEN ${bubble_time_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble score p'
      THEN ${bubble_score_popped}

      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN ${total_bubbles}
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble normal d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp+desc"
    }
    link: {
      label: "Drill and sort by -bubble time d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time+desc"
    }
    link: {
      label: "Drill and sort by -bubble score d-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score+desc"
    }

    link: {
      label: "Drill and sort by -bubble normal p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_normal_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble coins p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_coins_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble XP p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_xp_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble time p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_time_popped+desc"
    }
    link: {
      label: "Drill and sort by -bubble score p-"
      url: "{{ link }}&sorts=_005_bubbles_comp.bubble_score_popped+desc"
    }

    link: {
      label: "Drill and sort by -Total Bubbles-"
      url: "{{ link }}&sorts=_005_bubbles_comp.total_bubbles+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'bubble normal d'
      THEN CAST(if(${bubble_normal.bubble_normal} = '' , '0', ${bubble_normal.bubble_normal}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble coins d'
      THEN CAST(if(${bubble_coins.bubble_coins} = '' , '0', ${bubble_coins.bubble_coins}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble xp d'
      THEN CAST(if(${bubble_xp.bubble_xp} = '' , '0', ${bubble_xp.bubble_xp}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble time d'
      THEN CAST(if(${bubble_time.bubble_time} = '' , '0', ${bubble_time.bubble_time}) AS NUMERIC)
      WHEN  {% parameter boxplot_ %} = 'bubble score d'
      THEN CAST(if(${bubble_score.bubble_score} = '' , '0', ${bubble_score.bubble_score}) AS NUMERIC)

      WHEN  {% parameter boxplot_ %} = 'bubble normal p'
      THEN ${bubble_normal_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble coins p'
      THEN ${bubble_coins_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble xp p'
      THEN ${bubble_xp_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble time p'
      THEN ${bubble_time_popped}
      WHEN  {% parameter boxplot_ %} = 'bubble score p'
      THEN ${bubble_score_popped}

      WHEN  {% parameter boxplot_ %} = 'All bubbles'
      THEN ${total_bubbles}
    END  ;;
  }


  set: detail {
    fields: [
      character,
      user_type,
      player_xp_level,

      bubble_normal_array,
      bubble_normal.bubble_normal,
      bubble_normal_popped,

      bubble_coins_array,
      bubble_coins.bubble_coins,
      bubble_coins_popped,

      bubble_xp_array,
      bubble_xp.bubble_xp,
      bubble_xp_popped,

      bubble_score_array,
      bubble_score.bubble_score,
      bubble_score_popped,

      bubble_time_array,
      bubble_time.bubble_time,
      bubble_time_popped
      ]
  }
}
