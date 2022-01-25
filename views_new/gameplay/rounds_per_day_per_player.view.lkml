view: rounds_per_day_per_player {
  derived_table: {
    explore_source: gameplay {
      column: event_date {}
      column: round_end_count {}
      column: created_date { field: user_fact.created_date }
      column: rdg_id { field: user_fact.rdg_id }
    }
    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
    partition_keys: ["event_date"]
  }
  dimension: compound_pk {
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${event_date} ;;
  }
  dimension: created_date {
    label: "Users Created Date"
    type: date
  }
  dimension_group: created {
    type: duration
    intervals: [day]
    sql_start: ${created_date} ;;
    sql_end: ${event_date} ;;
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
  measure: rounds_per_day_025 {
    group_label: "Rounds per Day"
    label: "Rounds per Day - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${round_end_count} ;;
  }
  measure: rounds_per_day_25 {
    group_label: "Rounds per Day"
    label: "Rounds per Day - 25%"
    type: percentile
    percentile: 25
    sql: ${round_end_count} ;;
  }
  measure: rounds_per_day_med {
    group_label: "Rounds per Day"
    label: "Rounds per Day - Median"
    type: percentile
    percentile: 50
    sql: ${round_end_count} ;;
  }
  measure: rounds_per_day_75 {
    group_label: "Rounds per Day"
    label: "Rounds per Day - 75%"
    type: percentile
    percentile: 75
    sql: ${round_end_count} ;;
  }
  measure: rounds_per_day_975 {
    group_label: "Rounds per Day"
    label: "Rounds per Day - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${round_end_count} ;;
  }

  measure: cumulative_rounds {
    type: running_total
    sql: ${total_round_count} ;;
  }

  measure: total_round_count {
    type: sum
    sql: ${round_end_count} ;;
  }
}
