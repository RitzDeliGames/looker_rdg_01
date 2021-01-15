view: experiments_cohorted_players {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: experiments {field: events.experiments}
      column: install_version {field: events.install_version}
    }
  }

  dimension: experiments {}

  dimension: experiment_names {
    type: string
    sql: @{experiment_ids} ;;
  }

  dimension: variants {
    type: string
    sql: REPLACE(@{variant_ids},'"','') ;;
  }

  dimension: install_version {}

  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }

  dimension: user_id {
    hidden: yes
  }

  measure: cohort_size {
    type: count_distinct
    sql: ${user_id} ;;
  }

}
