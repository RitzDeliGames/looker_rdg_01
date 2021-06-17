view: test_round_end_count_by_user {
    derived_table: {
      explore_source: gameplay {
        column: event_date {}
        column: round_end_count {}
        column: user_id { field: user_fact.user_id }
        filters: { ## not needed as it's based on a PDT and that should already be performing
          field: gameplay.event_date
          value: "30 days"
        }
      }
    }
    dimension: event_date {
      type: date
    }
    dimension: round_end_count {
      type: number
    }
    dimension: user_id {
    }
    measure: test_percentile {
      type: percentile
      group_label: "Round End Count By User"
      sql: ${round_end_count} ;;
      percentile: 50
    }
  }
