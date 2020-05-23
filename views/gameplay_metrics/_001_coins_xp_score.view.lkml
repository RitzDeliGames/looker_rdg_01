include: "/views/**/events.view"

view: _001_coins_xp_score {
  extends: [events]

  sql_table_name: eraser-blast.game_data.events ;;


  # Dimensions

  dimension: battery_level {
    type: string
    sql: ${TABLE}.battery_level ;;
  }

  dimension: primary_key {
    type: string
    sql:  CONCAT(${eraser},${extra_json}) ;;
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

  # dimension: all_chains {
  #   sql: JSON_Value(extra_json,'$.all_chains') ;;
  # }

# Time at level
#   dimension_group: time_at_level {
#     type: duration
#     sql_start:  ;;
#   }


  dimension: days_from_install {
    type: number
    sql: DATE_DIFF(${timestamp_date},${created_date}, day) ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }


  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

#Remove ""
  dimension: eraser {
    type: string
    sql: JSON_EXTRACT_SCALAR(${extra_json},'$.team_slot_0') ;;
  }

  dimension: eraser_skill_level {
    type: string
    sql: REPLACE(JSON_EXTRACT(${extra_json},
      '$.team_slot_skill_0'),'"','') ;;
  }

  dimension: eraser_xp_level {
    type: number
    sql: REPLACE(JSON_EXTRACT(${extra_json},
      '$.team_slot_level_0'),'"','') ;;
  }

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

  dimension: payer_status {
    type: yesno
    sql: ${TABLE}.payer ;;
  }

  dimension: lifetime_spend {
    type: number
    sql: ${TABLE}.ltv ;;
  }

  dimension: coin_balance {
    type: number
    sql: ${TABLE}.coins  ;;
  }

  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: platform {
    type: string
    sql: CASE WHEN ${TABLE}.platform LIKE '%Android%' THEN 'mobile'
          WHEN ${TABLE}.platform LIKE '%iOS%' THEN 'mobile'
          ELSE 'Desktop (Web)'
          END ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
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

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    drill_fields: [user_details*]
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension: version {
    type: string
    sql:${TABLE}.version ;;
  }

  dimension: player_xp {
    type: number
    sql: ${TABLE}.player_xp_level ;;
  }



# MEASURES

  measure: total_coins_earned {
    type: sum
    sql: ${coins_earned} ;;
  }
  measure: max_coin_balance {
    type: max
    sql: ${coin_balance} ;;
  }

  measure: average_coin_balance {
    type: average
    sql: ${coin_balance} ;;
    value_format_name: decimal_2
  }

  measure: top_5 {
    type: percentile
    percentile: 95
    sql: ${coin_balance} ;;
  }

  measure: count {
    type: count
    drill_fields: [event_name]
  }

  measure: number_of_unique_users {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_details*]
  }

# measure: last_updated_date {
#   type: date
#   sql: MAX(${created_raw}) ;;
#   }


# Boxplots COINS, SCORE & XP_EARNED #

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
    drill_fields: [eraser, coins_earned, xp_earned, score_earned, player_xp, eraser_skill_level, user_details*]
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
    drill_fields: [eraser, coins_earned, xp_earned, score_earned, player_xp, eraser_skill_level, user_details*]
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
    drill_fields: [eraser, coins_earned, xp_earned, score_earned, player_xp, eraser_skill_level, user_details*]
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
    drill_fields: [eraser, coins_earned, xp_earned, score_earned, player_xp, eraser_skill_level, user_details*]
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
    drill_fields: [eraser, coins_earned, xp_earned, score_earned, player_xp, eraser_skill_level, user_details*]
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




################################
# EXAMPLE # (ERASE WHEN DONE)

  # measure: min_coins_earned {
  #   group_label: "BoxPlot Coins"
  #   type: min
  #   sql: ${coins_earned} ;;
  # }

  # measure: max_coins_earned {
  #   group_label: "BoxPlot Coins"
  #   type: max
  #   sql: ${coins_earned} ;;
  # }

  # measure: median_coins_earned {
  #   group_label: "BoxPlot Coins"
  #   type: median
  #   sql: ${coins_earned} ;;
  # }

  # measure: 25th_coins_earned {
  #   group_label: "BoxPlot Coins"
  #   type: percentile
  #   percentile: 25
  #   sql: ${coins_earned} ;;
  # }

  # measure: 75th_coins_earned {
  # group_label: "BoxPlot Coins"
  # type: percentile
  #   percentile: 75
  #   sql: ${coins_earned} ;;
  # }

####################################

  set: user_details {
    fields: [user_id,
      platform,
      user_type,
      version
    ]
  }
}
