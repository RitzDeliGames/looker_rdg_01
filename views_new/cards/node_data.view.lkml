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
  measure: explicit_attempts_to_complete_025 {
    type: percentile
    percentile: 2.5
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: explicit_attempts_to_complete_25 {
    type: percentile
    percentile: 25
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: explicit_attempts_to_complete_median {
    type: percentile
    percentile: 50
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: explicit_attempts_to_complete_75 {
    type: percentile
    percentile: 75
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
  measure: explicit_attempts_to_complete_975 {
    type: percentile
    percentile: 97.5
    sql: ${node_attempts_explicit} ;;
    filters: [
      cards.card_end_time: "NOT NULL"
    ]
  }
}
