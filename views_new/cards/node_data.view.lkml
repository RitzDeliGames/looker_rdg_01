view: node_data {
  dimension: node_id {
    group_label: "Node Data"
    type: number
    sql: cast(json_extract_scalar(node_data,'$.node_id') as int64) ;;
  }
  dimension: rounds {
    group_label: "Node Data"
    type: number
    sql: cast(json_extract_scalar(node_data,'$.rounds') as int64) ;;
  }
  dimension: node_attempts_explicit {
    group_label: "Node Data"
    type: number
    sql: cast(json_extract_scalar(node_data,'$.node_attempts_explicit') as int64) ;;
  }
  dimension: node_attempts_passive {
    group_label: "Node Data"
    type: number
    sql: cast(json_extract_scalar(node_data,'$.node_attempts_passive') as int64) ;;
  }
  dimension: node_last_update_tick {
    group_label: "Node Data"
    type: number
    sql: cast(json_extract_scalar(node_data,'$.node_last_update_tick') as int64) ;;
  }
  measure: explicit_attempts_to_complete_025 {
    group_label: "Explicit Attempts"
    label: "Explicit Attempts - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: explicit_attempts_to_complete_25 {
    group_label: "Explicit Attempts"
    label: "Explicit Attempts - 25%"
    type: percentile
    percentile: 25
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: explicit_attempts_to_complete_median {
    group_label: "Explicit Attempts"
    label: "Explicit Attempts - Median"
    type: percentile
    percentile: 50
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: explicit_attempts_to_complete_75 {
    group_label: "Explicit Attempts"
    type: percentile
    label: "Explicit Attempts - 75%"
    percentile: 75
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: explicit_attempts_to_complete_975 {
    group_label: "Explicit Attempts"
    label: "Explicit Attempts - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: total_attempts_to_complete_025 {
    group_label: "Total Attempts"
    label: "Total Attempts - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${node_attempts_explicit} + ${node_attempts_passive} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: total_attempts_to_complete_25 {
    group_label: "Total Attempts"
    label: "Total Attempts - 25%"
    type: percentile
    percentile: 25
    sql: ${node_attempts_explicit} + ${node_attempts_passive} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: total_attempts_to_complete_median {
    group_label: "Total Attempts"
    label: "Total Attempts - Median"
    type: percentile
    percentile: 50
    sql: ${node_attempts_explicit} + ${node_attempts_passive} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: total_attempts_to_complete_75 {
    group_label: "Total Attempts"
    type: percentile
    label: "Total Attempts - 75%"
    percentile: 75
    sql: ${node_attempts_explicit} + ${node_attempts_passive} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: total_attempts_to_complete_975 {
    group_label: "Total Attempts"
    label: "Total Attempts - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${node_attempts_explicit} + ${node_attempts_passive} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: node_last_update_tick_025 {
    group_label: "Minutes to Complete"
    label: "Minutes to Complete - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${node_last_update_tick} / 2 ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: node_last_update_tick_25 {
    group_label: "Minutes to Complete"
    label: "Minutes to Complete - 25%"
    type: percentile
    percentile: 25
    sql: ${node_last_update_tick} / 2 ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: node_last_update_tick_median {
    group_label: "Minutes to Complete"
    label: "Minutes to Complete - Median"
    type: percentile
    percentile: 50
    sql: ${node_last_update_tick} / 2 ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: node_last_update_tick_75 {
    group_label: "Minutes to Complete"
    label: "Minutes to Complete - 75%"
    type: percentile
    percentile: 75
    sql: ${node_last_update_tick} / 2 ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: node_last_update_tick_975 {
    group_label: "Minutes to Complete"
    label: "Minutes to Complete - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${node_last_update_tick} / 2 ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
}
