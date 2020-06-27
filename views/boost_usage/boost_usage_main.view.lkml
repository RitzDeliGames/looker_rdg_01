include: "/views/**/bingo_cards/**/_000_bingo_cards_comp.view"


view: boost_usage_main {

  extends: [_000_bingo_cards_comp]


  ########################

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


  ########################

  dimension: score_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.score_boost'),'"','') = "1", '4. True - Score', '4. False - Score');;
  }

  dimension: coin_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.coin_boost'),'"','') = "1", '3. True - Coin', '3. False - Coin');;
  }

  dimension: exp_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.exp_boost'),'"','') = "1", '6. True - XP', '6. False - XP');;
  }

  dimension: time_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.time_boost'),'"','') = "1", '5. True - Time', '5. False - Time');;
  }

  dimension: bubble_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.bubble_boost'),'"','') = "1", '2. True - Bubble', '2. False - Bubble');;
  }

  dimension: five_to_four_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.five_to_four_boost'),'"','') = "1", '1. True - 5-to-4', '1. False - 5-to-4');;
  }


############BINGO CARDS EXTENSION############

  dimension: rounds_nodes {
    type: number
    sql: JSON_EXTRACT(${node_data.node_data}, '$.rounds') ;;
  }

  dimension: node_id {
    type: number
    sql: JSON_EXTRACT(${node_data.node_data}, '$.node_id') ;;
  }



#########

  measure:  count_labels_test_measure {
    type: count_distinct
    sql:  ${five_to_four_tickets} ;;
  }


#########BOXPLOT PARAMETERS & MEASURES#########

  parameter: boxplot_boosts {
    type: string
    allowed_value: {
      label: "5 to 4"
      value: "5 to 4"
    }
    allowed_value: {
      label: "bubble boost"
      value: "bubble boost"
    }
    allowed_value: {
      label: "coin boost"
      value: "coin boost"
    }
    allowed_value: {
      label: "score boost"
      value: "score boost"
    }
    allowed_value: {
      label: "time boost"
      value: "time boost"
    }
    allowed_value: {
      label: "xp boost"
      value: "xp boost"
    }
  }


  measure: boosts_sum_each {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
    group_label: "Sum of Boosts (one by one)"
    type: count_distinct
    sql: CASE
      WHEN  {% parameter boxplot_boosts %} = '5 to 4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'bubble boost'
      THEN ${bubble_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'coin boost'
      THEN ${coin_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'score boost'
      THEN ${score_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'time boost'
      THEN ${time_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'xp boost'
      THEN ${exp_tickets}
    END  ;;
  }


  measure: 1_min_boxplot {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
    group_label: "BoxPlot Boosts (One by One)"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_boosts %} = '5 to 4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'bubble boost'
      THEN ${bubble_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'coin boost'
      THEN ${coin_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'score boost'
      THEN ${score_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'time boost'
      THEN ${time_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'xp boost'
      THEN ${exp_tickets}
    END  ;;
  }

  measure: 5_max_boxplot {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
    group_label: "BoxPlot Boosts (One by One)"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_boosts %} = '5 to 4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'bubble boost'
      THEN ${bubble_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'coin boost'
      THEN ${coin_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'score boost'
      THEN ${score_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'time boost'
      THEN ${time_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'xp boost'
      THEN ${exp_tickets}
    END  ;;
  }

  measure: 3_median_boxplot {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
    group_label: "BoxPlot Boosts (One by One)"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_boosts %} = '5 to 4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'bubble boost'
      THEN ${bubble_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'coin boost'
      THEN ${coin_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'score boost'
      THEN ${score_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'time boost'
      THEN ${time_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'xp boost'
      THEN ${exp_tickets}
    END  ;;
  }

  measure: 2_25th_boxplot {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
    group_label: "BoxPlot Boosts (One by One)"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_boosts %} = '5 to 4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'bubble boost'
      THEN ${bubble_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'coin boost'
      THEN ${coin_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'score boost'
      THEN ${score_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'time boost'
      THEN ${time_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'xp boost'
      THEN ${exp_tickets}
    END  ;;
  }

  measure: 4_75th_boxplot {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
    group_label: "BoxPlot Boosts (One by One)"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_boosts %} = '5 to 4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'bubble boost'
      THEN ${bubble_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'coin boost'
      THEN ${coin_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'score boost'
      THEN ${score_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'time boost'
      THEN ${time_tickets}
      WHEN  {% parameter boxplot_boosts %} = 'xp boost'
      THEN ${exp_tickets}
    END  ;;
  }

#   set: user_details {
#     fields: [events.character_used, events.five_to_four_tickets]
#   }

}
