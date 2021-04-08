view: node_data {
  dimension: node_id {
    group_label: "Node Data"
    type: number
    sql: json_extract_scalar(node_data,'$.node_id') ;;
  }
  dimension: rounds {
    group_label: "Node Data"
    type: number
    sql: json_extract_scalar(node_data,'$.rounds') ;;
  }
  dimension: node_attempts_explicit {
    group_label: "Node Data"
    type: number
    sql: json_extract_scalar(node_data,'$.node_attempts_explicit') ;;
  }
  dimension: node_attempts_passive {
    group_label: "Node Data"
    type: number
    sql: json_extract_scalar(node_data,'$.node_attempts_passive') ;;
  }
}
