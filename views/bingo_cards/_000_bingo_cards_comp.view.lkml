include: "/views/**/events.view"


view: _000_bingo_cards_comp {
  extends: [events]

  #_DIMENSIONS_MANY_TYPES_#####################################

  dimension: primary_key {
    type: string
    sql:  CONCAT(${card_id},${extra_json}) ;;
  }

  dimension: game_version {
    label: "Game Version"
    type: string
    sql:${TABLE}.version;;
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

  dimension: round_id {
    type: number
    sql: CAST(JSON_Value(extra_json, '$.round_id') AS NUMERIC) ;;
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

  dimension: card_id_complete {
    sql: card_id ;;
  }
  dimension: row_1_search {
    type: string
    sql:
    CASE WHEN ${card_state_str} LIKE '%1%,%5%'
              OR ${card_state_str} LIKE '%1%,%2%,%3%,%4%,%5%'
              THEN 'row_01' END ;;
  }

  dimension: row_2_search {
    type: string
    sql:
    CASE WHEN ${card_state_str} LIKE '%7%,%8%,%9%'
              OR ${card_state_str} LIKE '%6%,%7%,%8%,%9%,1%0'
              OR ${card_state_str} LIKE '%7%,%9%'
              THEN 'row_02' END ;;
  }

  dimension: row_3_search {
    type: string
    sql:
    CASE WHEN ${card_state_str} LIKE '%1%2%,%1%3%'
              OR ${card_state_str} LIKE '%1%1%,%1%2%,%1%3%,%1%4%'
              THEN 'row_03' END ;;
        }

  dimension: row_4_search {
    type: string
    sql:
        CASE WHEN ${card_state_str} LIKE '%1%6%,%1%7%,%1%8%'
              OR ${card_state_str} LIKE '%1%5%,%1%6%,%1%7%,%1%8%,%1%9%'
              OR ${card_state_str} LIKE '%1%6%,%1%8%'
              THEN 'row_04' END ;;
        }

  dimension: row_5_search {
    type: string
    sql:
    CASE WHEN ${card_state_str} LIKE '%2%0%,%2%4%'
              OR ${card_state_str} LIKE '%2%0%,%2%1%,%2%2%,%2%3%,%2%4%'
              THEN 'row_05' END ;;
  }

  dimension: column_1_search {
    type: string
    sql:
        CASE WHEN ${card_state_str} LIKE '%1%,%6%,%1%1%,%1%5%,%2%0%'
              OR ${card_state_str} LIKE '%1%,%2%0%'
              THEN 'column_1' END ;;
  }

  dimension: column_2_search {
    type: string
    sql:
       CASE WHEN ${card_state_str} LIKE '%7%,%1%2%,%1%6%'
              OR ${card_state_str} LIKE '%2%,%7%,%1%2%,%1%6%,%2%1%'
              OR ${card_state_str} LIKE '%7%,%1%6%'
              THEN 'column_2' END ;;
      }

  dimension: column_3_search {
    type: string
    sql:
       CASE WHEN ${card_state_str} LIKE '%3%,%8%,%1%7%,%2%2%'
              OR ${card_state_str} LIKE '%8%,%1%7%'
              THEN 'column_3' END ;;
  }

  dimension: column_4_search {
    type: string
    sql:
       CASE WHEN ${card_state_str} LIKE '%9%,%1%3%,%1%8%'
              OR ${card_state_str} LIKE '%1%5%,%1%6%,%1%7%,%1%8%,%1%9%'
              OR ${card_state_str} LIKE '%9%,%1%8%'
              THEN 'column_4' END ;;
  }

  dimension: column_5_search {
    type: string
    sql:
       CASE WHEN ${card_state_str} LIKE '%5%,%2%4%'
              OR ${card_state_str} LIKE '%5%,%1%0%,%1%4%,%1%9%,%2%4%'
              THEN 'column_5' END ;;
    }

  dimension: diagonal_01_search {
    type: string
    sql:
       CASE WHEN ${card_state_str} LIKE '%7%,%1%8%'
              OR ${card_state_str} LIKE '%1%,%7%,%1%8%,%2%4%'
              OR ${card_state_str} LIKE '%1%,%7%,%1%8%,%2%4%'
              THEN 'diagonal_01' END ;;
  }

  dimension: diagonal_02_search {
    type: string
    sql:
       CASE WHEN ${card_state_str} LIKE '%5%,%9%,%1%6%,%2%0%'
              OR ${card_state_str} LIKE '%9%,%1%6%'
              THEN 'diagonal_02' END ;;
  }

  dimension: rcd_mapping {
    type: string
    sql: CASE
          WHEN ${card_id} = 'card_001'
            THEN @{bingo_card_mapping_3x3}
          WHEN ${card_id} = 'card_002'
            THEN @{bingo_card_mapping_3x3}
          WHEN ${card_id} = 'card_003'
            THEN @{bingo_card_mapping_5x5_X}
          WHEN ${card_id} = 'card_004'
            THEN @{bingo_card_mapping_5x5_X}
          WHEN ${card_id} = 'card_005'
            THEN @{bingo_card_mapping_5x5_X}
          WHEN ${card_id} = 'card_006'
            THEN @{bingo_card_mapping_5x5_X}
          WHEN ${card_id} = 'card_007'
            THEN @{bingo_card_mapping_5x5_X}
          WHEN ${card_id} = 'card_008'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_009'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_010'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_011'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_012'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_013'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_014'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_015'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_016'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_017'
            THEN @{bingo_card_mapping_5x5}
          WHEN ${card_id} = 'card_018'
            THEN @{bingo_card_mapping_5x5}
        ELSE 'other'
        END;;
  }


  ###CARD_STATE###

  dimension: card_state {
    hidden: yes
    type: string
    sql: JSON_EXTRACT_ARRAY(extra_json, '$.card_state') ;;
  }

  dimension: card_state_str {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.card_state') ;;
  }

  dimension: length_card_state {
    type: number
    sql:  ARRAY_LENGTH(${card_state}) ;;
  }



  ###CARD_STATE_PROGRESS###

  dimension: card_state_progress {
    hidden: yes
    type: string
    sql: JSON_EXTRACT_ARRAY(extra_json, '$.card_state_progress')  ;;
  }

  dimension: card_state_progress_str {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.card_state_progress') ;;
  }

  dimension: length_progress {
    type: number
    sql:  ARRAY_LENGTH(${card_state_progress}) ;;
  }


  ###CARD_STATE_COMPLETED###

  dimension: card_state_completed {
    hidden: yes
    type: string
    sql: JSON_EXTRACT_ARRAY(extra_json, '$.card_state_completed') ;;
  }

  dimension: card_state_completed_str {
    type: string
    sql: JSON_EXTRACT(extra_json, '$.card_state_completed') ;;
  }

  dimension: length_completed {
    type: number
    sql: ARRAY_LENGTH(${card_state_completed}) ;;
  }

  dimension: node_data {
    type: string
    sql: node_data ;;
  }

  dimension: is_node_ended {
    type: yesno
    sql:  ${node_data} LIKE '%"node\\_end\\_time"%' ;;
  }

  dimension: rounds_nodes {
    type: number
    sql: JSON_EXTRACT(${node_data.node_data}, '$.rounds') ;;
  }

  dimension: node_id {
    type: number
    sql: JSON_EXTRACT(${node_data.node_data}, '$.node_id') ;;
  }


  dimension: node_end_time {
    type: number
    sql: CAST(JSON_EXTRACT(${node_data.node_data}, '$.node_end_time') AS NUMERIC) ;;
  }

  dimension: node_last_update_time {
    type: number
    sql: CAST(JSON_EXTRACT(${node_data.node_data}, '$.node_last_update_time') AS NUMERIC) ;;
  }

  dimension: card_start_time {
    type: number
    sql:  CAST(JSON_EXTRACT(extra_json, '$.card_start_time') AS NUMERIC) ;;
  }

  dimension: card_update_time {
    type: number
    sql:  CAST(JSON_EXTRACT(extra_json, '$.card_update_time') AS NUMERIC) ;;
  }

  dimension: time_node_length {
    type: number
    sql: CASE
          WHEN ${node_last_update_time} > 0
           THEN ${node_end_time} - ${node_last_update_time}
          ELSE ${node_end_time} - ${card_start_time}
         END ;;
  }

  #_MEASURES_############################################


  measure: min_rounds_to_complete {
    type: min
    sql: ${rounds} ;;
  }

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


  ############################

  dimension_group: timestamp_distinct {
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
    sql: DISTINCT ${TABLE}.timestamp ;;
  }

  dimension: round_length_num {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.round_length') AS NUMERIC) / 1000 ;;
  }


  #########################FOR DESCRIPTIVE STATISTICS VISUALIZATION#########################


  parameter: descriptive_stats_bc {
    type: string
    allowed_value: {
      label: "rounds"
      value: "rounds"
    }
    allowed_value: {
      label: "rounds per node id"
      value: "rounds per node id"
    }
    allowed_value: {
      label: "round length"
      value: "round length"
    }
  }



  measure: 1_min_ {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "descriptive Statistics Measures"
    type: min
    sql: CASE
      WHEN  {% parameter descriptive_stats_bc %} = "rounds"
      THEN ${rounds}
      WHEN  {% parameter descriptive_stats_bc %} = "rounds per node id"
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
      WHEN  {% parameter descriptive_stats_bc %} = 'round length'
      THEN CAST(${round_length} AS NUMERIC)
    END  ;;
  }



  measure: 5_max_ {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "descriptive Statistics Measures"
    type: max
    sql: CASE
      WHEN  {% parameter descriptive_stats_bc %} = "rounds"
      THEN ${rounds}
      WHEN  {% parameter descriptive_stats_bc %} = "rounds per node id"
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
      WHEN  {% parameter descriptive_stats_bc %} = 'round length'
      THEN CAST(${round_length} AS NUMERIC)
    END  ;;
  }

  measure: 3_median_ {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "descriptive Statistics Measures"
    type: median
    sql: CASE
      WHEN  {% parameter descriptive_stats_bc %} = "rounds"
      THEN ${rounds}
      WHEN  {% parameter descriptive_stats_bc %} = "rounds per node id"
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
      WHEN  {% parameter descriptive_stats_bc %} = 'round length'
      THEN CAST(${round_length} AS NUMERIC)
    END  ;;
  }

  measure: 2_25th_ {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "descriptive Statistics Measures"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter descriptive_stats_bc %} = "rounds"
      THEN ${rounds}
      WHEN  {% parameter descriptive_stats_bc %} = "rounds per node id"
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
      WHEN  {% parameter descriptive_stats_bc %} = 'round length'
      THEN CAST(${round_length} AS NUMERIC)
    END  ;;
  }

  measure: 4_75th_ {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Rounds"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds+desc"
    }
    link: {
      label: "Drill and sort by Rounds per Node"
      url: "{{ link }}&sorts=_000_bingo_cards.rounds_nodes+desc"
    }
    group_label: "descriptive Statistics Measures"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter descriptive_stats_bc %} = "rounds"
      THEN ${rounds}
      WHEN  {% parameter descriptive_stats_bc %} = "rounds per node id"
      THEN CAST(if(${rounds_nodes} = '' , '0', ${rounds_nodes}) AS NUMERIC)
      WHEN  {% parameter descriptive_stats_bc %} = 'round length'
      THEN CAST(${round_length} AS NUMERIC)
    END  ;;
  }



  set: detail {
    fields: [user_type,
             events.hardware,
             events.platform,
             game_version,
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
             events.platform_type,
             card_end_time,
             node_data.node_data,
             rounds_nodes,
             node_id,
            ]
  }
}
