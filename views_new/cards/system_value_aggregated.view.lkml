# If necessary, uncomment the line below to include explore_source.
# include: "ritz_deli_games.model.lkml"

view: system_value_aggregated {
  derived_table: {
    explore_source: system_value {
      column: rdg_id {}
      column: system_value_sum {}
      column: current_card {}
    }
  }
  dimension: rdg_id {
    hidden: yes
  }
  dimension: current_card {}
  dimension: system_value_sum {
    hidden: yes
    type: number
  }
  measure:  system_value_025 {
    group_label: "System Value"
    label: "System Value - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${system_value_sum} ;;
  }
  measure:  system_value_25 {
    group_label: "System Value"
    label: "System Value - 25%"
    type: percentile
    percentile: 25
    sql: ${system_value_sum} ;;
  }
  measure:  system_value_med {
    group_label: "System Value"
    label: "System Value - Median"
    type: median
    sql: ${system_value_sum} ;;
  }
  measure:  system_value_75 {
    group_label: "System Value"
    label: "System Value - 75%"
    type: percentile
    percentile: 75
    sql: ${system_value_sum} ;;
  }
  measure:  system_value_975 {
    group_label: "System Value"
    label: "System Value - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${system_value_sum} ;;
  }
  set: detail {
    fields: [rdg_id, current_card, system_value_sum]
  }
}
