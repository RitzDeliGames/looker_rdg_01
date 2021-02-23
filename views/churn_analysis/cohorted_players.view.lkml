view: cohorted_players {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: timestamp {field: events.timestamp_raw}
      column: install_version {field: events.install_version}
    }
  }

  dimension: install_version {}
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
  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }

  dimension: user_id {
    hidden: no
  }

  measure: cohort_size {
    type: count_distinct
    sql: ${user_id} ;;
  }

}
