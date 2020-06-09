include: "/views/**/events.view"

view: _001_coins_xp_score {
  extends: [events]

  sql_table_name: eraser-blast.game_data.events ;;


  # Dimensions

  dimension: primary_key {
    type: string
    sql:  CONCAT(${character_used} ,${extra_json}) ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }



  dimension: days_from_install {
    type: number
    sql: DATE_DIFF(${timestamp_date},${created_date}, day) ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }



#Remove ""

  dimension: coins_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.coins_earned'),'"','') as NUMERIC) ;;
  }

  dimension: score_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.score_earned'),'"','') as NUMERIC) ;;
  }

  dimension: xp_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.xp_earned'),'"','') as NUMERIC) ;;
  }

  dimension: round_id {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.round_id'),'"','') as NUMERIC) ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [
      raw,
      hour,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp ;;
  }

  dimension_group: timestamp_insert {
    type: time
    timeframes: [
      raw,
      hour,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp_insert ;;
  }


###MEASURES###
  measure: count {
    type: count
    drill_fields: [event_name]
  }

###BOXPLOT MEASURES###

  parameter: boxplot_type {
    type: string
    allowed_value: {
      label: "Coins"
      value: "Coins"
    }
    allowed_value: {
      label: "Score Earned"
      value: "Score Earned"
    }
    allowed_value: {
      label: "XP Earned"
      value: "XP Earned"
    }
  }

  measure: 1_min_boxplot {
    drill_fields: [user_details*]
    link: {
      label: "Drill and sort by coins earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
    }
    link: {
      label: "Drill and sort by XP earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
    }
    link: {
      label: "Drill and sort by score earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
    }
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Coins'
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = 'Score Earned'
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = 'XP Earned'
      THEN ${xp_earned}

    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [user_details*]
    link: {
      label: "Drill and sort by coins earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
    }
    link: {
      label: "Drill and sort by XP earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
    }
    link: {
      label: "Drill and sort by score earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Coins'
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = 'Score Earned'
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = 'XP Earned'
      THEN ${xp_earned}
    END  ;;
  }

  measure: 3_median_boxplot {
   drill_fields: [user_details*]
    link: {
      label: "Drill and sort by coins earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
    }
    link: {
      label: "Drill and sort by XP earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
    }
    link: {
      label: "Drill and sort by score earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
    }
    group_label: "BoxPlot Measures"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Coins'
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = 'Score Earned'
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = 'XP Earned'
      THEN ${xp_earned}
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [user_details*]
    link: {
      label: "Drill and sort by coins earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
    }
    link: {
      label: "Drill and sort by XP earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
    }
    link: {
      label: "Drill and sort by score earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
    }
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Coins'
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = 'Score Earned'
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = 'XP Earned'
      THEN ${xp_earned}
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [user_details*]
    link: {
      label: "Drill and sort by coins earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
    }
    link: {
      label: "Drill and sort by XP earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
    }
    link: {
      label: "Drill and sort by score earned"
      url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
    }
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_type %} = 'Coins'
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = 'Score Earned'
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = 'XP Earned'
      THEN ${xp_earned}
    END  ;;
  }

  set: user_details {
    fields: [user_id]
  }
}
