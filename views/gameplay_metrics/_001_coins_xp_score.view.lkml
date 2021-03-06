include: "/views/**/events.view"


view: _001_coins_xp_score {
  extends: [events]

  sql_table_name: eraser-blast.game_data.events ;;


#####DIMENSIONS#####

  dimension: coins_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json}, '$.coins_earned'),'"','') as NUMERIC) ;;
  }

  dimension: score_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json}, '$.score_earned'),'"','') as NUMERIC) ;;
  }

  dimension: xp_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json}, '$.xp_earned'),'"','') as NUMERIC) ;;
  }


#####MEASURES#####

  measure: count {
    type: count
    drill_fields: [event_name]
  }


#####BOXPLOT MEASURES#####

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
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 2.5
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
    group_label: "BoxPlot Measures"
    type: percentile
    percentile: 97.5
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


# VIEW DETAILS

  set: user_details {
    fields: [user_id,
             user_type,
             character_used,
             coins_earned,
             score_earned,
             xp_earned]
  }
}
