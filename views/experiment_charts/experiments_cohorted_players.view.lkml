view: experiments_cohorted_players {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: experiments {field: events.experiments}
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

  dimension: user_id {
    hidden: yes
  }

  measure: cohort_size {
    type: count_distinct
    sql: ${user_id} ;;
  }

}
