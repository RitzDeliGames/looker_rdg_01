view: sessions_per_day_per_player {
  derived_table: {
    explore_source: gameplay {
      column: event_date {}
      column: session_count {}
      column: rdg_id { field: user_fact.rdg_id }
    }
  }
  dimension: event_date {
    #hidden: yes
    type: date
  }
  dimension: session_count {
    hidden: yes
    type: number
  }
  dimension: rdg_id {
    #hidden: yes
  }

  measure: total_session_count {
    type: sum
    sql: ${session_count} ;;
  }

  measure: sessions_per_day_025 {
    group_label: "Sessions per Day"
    label: "Sessions per Day - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${session_count} ;;
  }
  measure: sessions_per_day_25 {
    group_label: "Sessions per Day"
    label: "Sessions per Day - 25%"
    type: percentile
    percentile: 25
    sql: ${session_count} ;;
  }
  measure: sessions_per_day_med {
    group_label: "Sessions per Day"
    label: "Sessions per Day - Median"
    type: percentile
    percentile: 50
    sql: ${session_count} ;;
  }
  measure: sessions_per_day_75 {
    group_label: "Sessions per Day"
    label: "Sessions per Day - 75%"
    type: percentile
    percentile: 75
    sql: ${session_count} ;;
  }
  measure: sessions_per_day_975 {
    group_label: "Sessions per Day"
    label: "Sessions per Day - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${session_count} ;;
  }
}
