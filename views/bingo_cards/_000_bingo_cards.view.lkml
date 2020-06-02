view: _000_bingo_cards {
  derived_table: {
    sql: SELECT extra_json,
                user_type,
                hardware,
                platform,
                version,
                user_id,
                current_card,
                node_data,
                JSON_EXTRACT(node_data, '$.rounds') AS rounds_nodes,
                JSON_EXTRACT(node_data, '$.node_id') AS node_id,
                JSON_EXTRACT_ARRAY(extra_json, '$.card_state_completed') AS card_state_completed,
                JSON_EXTRACT_ARRAY(extra_json, '$.card_state_progress') AS card_state_progress,
                JSON_EXTRACT_ARRAY(extra_json, '$.card_state') AS card_state
      FROM events
      CROSS JOIN UNNEST(JSON_EXTRACT_array(extra_json, '$.node_data')) as node_data
      WHERE event_name = 'cards'
       ;;
  }


  #_DIMENSIONS_MANY_TYPES_#####################################

  dimension: extra_json {
    type: string
    hidden: no
    suggest_explore: events
    suggest_dimension: events.extra_json
#     sql: ${TABLE}.extra_json ;;
  }

  dimension: primary_key {
    type: string
    sql:  CONCAT(${card_id},${extra_json}) ;;
  }


  dimension: user_type {
    type: string
    suggest_explore: events
    suggest_dimension: events.user_type
#     sql: ${TABLE}.user_type ;;
  }

  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: platform_type {
    type: string
    sql: CASE
      WHEN ${TABLE}.platform LIKE '%Android%' THEN 'mobile'
      WHEN ${TABLE}.platform LIKE '%iOS%' THEN 'mobile'
      ELSE 'desktop (web)'
      END ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: current_card {
    type: string
    sql: ${TABLE}.current_card ;;
  }

  dimension: card_id {
    type: string
    sql: JSON_Value(extra_json, '$.card_id');;
  }

#   dimension: node_data {
#      type: string
#     sql: JSON_EXTRACT(extra_json, '$.node_data');;
#   }

  dimension: round_id {
    type: string
    sql: JSON_Value(extra_json, '$.round_id');;
  }

  dimension: rounds {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.rounds') AS NUMERIC) ;;
  }

  dimension: card_end_time {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.card_end_time') ;;
  }

  dimension: sessions {
    type: string
    sql: JSON_Value(extra_json, '$.sessions');;
  }

  dimension: player_bingo_card_walk {
    type: string
    sql: CASE
          WHEN  ${card_state_str} IN ('[7, 12, 16]', '[8, 17]', '[9, 13, 18]',
          '[1, 6, 11, 15, 20]', '[2, 7, 12, 16, 21]', '[3, 8, 17, 22]', '[4, 9, 13, 18, 23]', '[5, 10, 14, 19, 24]')
          THEN 'column'
          WHEN ${card_state_str} IN ('[7, 8, 9]', '[12, 13]', '[16, 17, 18]',
          '[1, 2, 3, 4, 5]', '[6, 7, 8, 9, 10]', '[11, 12, 13, 14]', '[15, 16, 17, 18, 19]', '[20, 21, 22, 23, 24]')
          THEN 'row'
          WHEN ${card_state_str} IN ('[7, 18]', '[9, 16]', '[1, 7, 18, 24]', '[5, 9, 16, 20]')
          THEN 'diagonal'
          ELSE 'random walk'
        END
        ;;
  }

  dimension: test_card_progress {
    type: string
    sql: CASE
          WHEN  ${card_state_progress_str} IN ('[7, 12, 16]', '[8, 17]', '[9, 13, 18]',
          '[1, 6, 11, 15, 20]', '[2, 7, 12, 16, 21]', '[3, 8, 17, 22]', '[4, 9, 13, 18, 23]', '[5, 10, 14, 19, 24]')
          THEN 'column'
          WHEN ${card_state_progress_str} IN ('[7, 8, 9]', '[12, 13]', '[16, 17, 18]',
          '[1, 2, 3, 4, 5]', '[6, 7, 8, 9, 10]', '[11, 12, 13, 14]', '[15, 16, 17, 18, 19]', '[20, 21, 22, 23, 24]')
          THEN 'row'
          WHEN ${card_state_progress_str} IN ('[7, 18]', '[9, 16]', '[1, 7, 18, 24]', '[5, 9, 16, 20]')
          THEN 'diagonal'
          ELSE 'random walk'
          END
          ;;
  }

  dimension: test_card_completed {
    type: string
    sql: CASE
          WHEN  ${card_state_completed_str} IN ('[7, 12, 16]', '[8, 17]', '[9, 13, 18]',
          '[1, 6, 11, 15, 20]', '[2, 7, 12, 16, 21]', '[3, 8, 17, 22]', '[4, 9, 13, 18, 23]', '[5, 10, 14, 19, 24]')
          THEN 'column'
          WHEN ${card_state_completed_str} IN ('[7, 8, 9]', '[12, 13]', '[16, 17, 18]',
          '[1, 2, 3, 4, 5]', '[6, 7, 8, 9, 10]', '[11, 12, 13, 14]', '[15, 16, 17, 18, 19]', '[20, 21, 22, 23, 24]')
          THEN 'row'
          WHEN ${card_state_completed_str} IN ('[7, 18]', '[9, 16]', '[1, 7, 18, 24]', '[5, 9, 16, 20]')
          THEN 'diagonal'
          ELSE 'random walk'
          END
          ;;
  }



  #_CARD_STATE_###############################################

  dimension: card_state {
    type: string
    sql: ${TABLE}.card_state;;
  }

  dimension: card_state_str {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.card_state') ;;
  }

  dimension: length_card_state {
    type: number
    sql:  ARRAY_LENGTH(${card_state}) ;;
  }


  #_CARD_STATE_PROGRESS_######################################

  dimension: card_state_progress {
    type: string
    sql: ${TABLE}.card_state_progress ;;
  }

  dimension: card_state_progress_str {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.card_state_progress') ;;
  }

  dimension: length_progress {
    type: number
    sql:  ARRAY_LENGTH(${card_state_progress}) ;;
  }


  #_CARD_STATE_COMPLETED_######################################

  dimension: card_state_completed {
    type: string
    sql: ${TABLE}.card_state_completed ;;
  }

  dimension: card_state_completed_str {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.card_state_completed') ;;
  }

  dimension: length_completed {
    type: number
    sql: ARRAY_LENGTH(${card_state_completed}) ;;
  }

  #############################################################


  dimension: node_data {
    type: string
    sql: ${TABLE}.node_data ;;
  }

  dimension: is_node_ended {
    type: yesno
    sql:  ${node_data} LIKE '%"node\\_end\\_time"%' ;;
  }

  dimension: rounds_nodes {
    type: number
    sql: ${TABLE}.rounds_nodes ;;
  }

  dimension: node_id {
    type: number
    sql: ${TABLE}.node_id ;;
  }



  #########################################################


#   dimension: len {
#     type: string
#     sql: len
#     ;;
#   }

#   dimension: test {
#     type: number
#     sql:  1 = 1 ;;
#     html: {% assign the_array = card_state_completed._value | split: "," %} {{ the_array.size }} ;;
#   }

#   measure: test_sql {
#     type: sum
#     sql: ${test} ;;
#   }


  #_MEASURES_############################################

  measure: length_avg_pro {
    type: average
    sql: ${length_progress} ;;
  }

  measure: length_avg_com {
    type: average
    sql: ${length_completed} ;;
  }

  measure: length_avg_state {
    type: average
    sql: ${length_card_state} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }



  #########################_BOXPLOT_#########################


  parameter: boxplot_bc {
    type: string
    allowed_value: {
      label: "rounds"
      value: "rounds"
    }

    allowed_value: {
      label: "rounds per node completed"
      value: "rounds per node completed"
    }
  }

  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_bc %} = 'rounds'
      THEN ${rounds}
      WHEN  {% parameter boxplot_bc %} = 'rounds per node completed'
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
    END  ;;
  }



  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_bc %} = 'rounds'
      THEN ${rounds}
      WHEN  {% parameter boxplot_bc %} = 'rounds per node completed'
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_bc %} = 'rounds'
      THEN ${rounds}
      WHEN  {% parameter boxplot_bc %} = 'rounds per node completed'
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_bc %} = 'rounds'
      THEN ${rounds}
      WHEN  {% parameter boxplot_bc %} = 'rounds per node completed'
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Round"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_bc %} = 'rounds'
      THEN ${rounds}
      WHEN  {% parameter boxplot_bc %} = 'rounds per node completed'
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
    END  ;;
  }


  set: detail {
    fields: [user_type,
             hardware,
             platform,
             version,
             user_id,
             current_card,
             card_id,
             round_id,
             rounds,
             sessions,

             length_completed,
             card_state_completed_str,

             length_progress,
             card_state_progress_str,

             platform_type,
             card_end_time,

             node_data,
             rounds_nodes,
             node_id,
             player_bingo_card_walk
            ]
  }
}
