view: sessions_per_day_per_player {
  derived_table: {
    explore_source: gameplay {
      column: event_date {}
      column: session_count {}
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
    #hidden: yes
    type: date
  }
  dimension: session_count {
    #hidden: yes
    type: number
  }
  dimension: rdg_id {
    #hidden: yes
  }

  measure: cumulative_sessions {
    type: running_total
    sql: ${total_session_count} ;;
    direction: "column"
  }

  measure: total_session_count {
    type: sum
    sql: ${session_count} ;;
    drill_fields: [rdg_id,created_date,event_date]
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
