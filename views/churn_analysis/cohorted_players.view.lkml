view: cohorted_players {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: current_card {field: events.current_card}
      column: timestamp {field: events.timestamp_raw}
      column: install_version {field: events.install_version}
      column: experiments {field: events.experiments}
    }
  }

  dimension: user_id {}
  measure: cohort_size {
    type: count_distinct
    sql: ${user_id} ;;
  }
  dimension: timestamp {}
  dimension_group: event_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${timestamp} ;;
  }
  dimension: install_version {}
  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }
  dimension: experiments {}
  dimension: experiment_names {
    type: string
    sql: @{experiment_ids} ;;
  }
  dimension: variant_ids {
    sql: @{variant_ids} ;;
  }
  dimension: current_card {}
  dimension: current_card_no {
    type: number
    sql: @{current_card_numbered} ;;
  }
}
