view: cohorted_players {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: install_version {field: events.install_version}
    }
  }

  dimension: install_version {}

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
