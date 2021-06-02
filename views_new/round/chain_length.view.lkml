view: chain_length {
  dimension: chain_length {
    hidden: yes
    type: number
    group_label: "All Chains Unnested"
    sql: cast(chain_length as int64) ;;
  }

  measure: chain_length_025 {
    type: percentile
    percentile: 2.5
    sql: ${chain_length} ;;
  }
  measure: chain_length_25 {
    type: percentile
    percentile: 25
    sql: ${chain_length} ;;
  }
  measure: chain_length_med {
    type: median
    sql: ${chain_length} ;;
  }
  measure: chain_length_75 {
    type: percentile
    percentile: 75
    sql: ${chain_length} ;;
  }
  measure: chain_length_975 {
    type: percentile
    percentile: 97.5
    sql: ${chain_length} ;;
  }
}
