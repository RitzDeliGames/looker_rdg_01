view: chain_length {
  dimension: chain_length {
    hidden: yes
    type: number
    group_label: "All Chains Unnested"
    sql: cast(chain_length as int64) ;;
  }

  measure: chain_length_025 {
    group_label: "Chain Length"
    label: "Chain Length - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${chain_length} ;;
  }
  measure: chain_length_25 {
    group_label: "Chain Length"
    label: "Chain Length - 25%"
    type: percentile
    percentile: 25
    sql: ${chain_length} ;;
  }
  measure: chain_length_med {
    group_label: "Chain Length"
    label: "Chain Length - Median"
    type: median
    sql: ${chain_length} ;;
  }
  measure: chain_length_75 {
    group_label: "Chain Length"
    label: "Chain Length - 75%"
    type: percentile
    percentile: 75
    sql: ${chain_length} ;;
  }
  measure: chain_length_975 {
    group_label: "Chain Length"
    label: "Chain Length - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${chain_length} ;;
  }
}
