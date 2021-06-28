view: rounds_per_session_per_player {
  derived_table: {
    explore_source: gameplay {
      column: session_id {}
      column: event_date {}
      column: round_end_count {}
      column: rdg_id { field: user_fact.rdg_id }
    }
  }
  dimension: session_id {
    hidden: yes
    type: string
  }
  dimension: event_date {
    hidden: yes
    type: date
  }
  dimension: round_end_count {
    hidden: yes
    type: number
  }
  dimension: rdg_id {
    hidden: yes
  }
  measure: rounds_per_session_025 {
    group_label: "Rounds per Session"
    label: "Rounds per Session - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${round_end_count} ;;
  }
  measure: rounds_per_session_25 {
    group_label: "Rounds per Session"
    label: "Rounds per Session - 25%"
    type: percentile
    percentile: 25
    sql: ${round_end_count} ;;
  }
    measure: rounds_per_session_med {
      group_label: "Rounds per Session"
      label: "Rounds per Session - Median"
      type: percentile
      percentile: 50
      sql: ${round_end_count} ;;
    }
  measure: rounds_per_session_75 {
    group_label: "Rounds per Session"
    label: "Rounds per Session - 75%"
    type: percentile
    percentile: 75
    sql: ${round_end_count} ;;
  }
  measure: rounds_per_session_975 {
    group_label: "Rounds per Session"
    label: "Rounds per Session - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${round_end_count} ;;
  }
}
