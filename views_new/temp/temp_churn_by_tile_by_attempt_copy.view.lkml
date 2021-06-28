## WORK IN PROGRESS

# If necessary, uncomment the line below to include explore_source.
# include: "ritz_deli_games.model.lkml"

view: temp_churn_by_tile_by_attempt_copy {
  derived_table: {
    explore_source: temp_card_data {
      column: node_data_1 {}
      column: node_data_2 {}
      column: node_data_3 {}
      column: rdg_id {}
      column: timestamp {}
      column: card_id {}
      derived_column: node_attempts_explicit {
      sql: cast(json_extract({% parameter node_selector %}, "$.node_attempts_explicit") as int64) ;;
      }
    }
  }
  dimension: node_data_1 {
    type: string
  }

  dimension: node_data_2 {
    type: string
  }

  dimension: node_data_3 {
    type: string
  }

  dimension: rdg_id {}

  dimension: timestamp {
    type: date_time
  }

  dimension:node_attempts_explicit {
    type: number
  }

  parameter: node_selector {
    type: string
    allowed_value: {
      label: "Node 1"
      value: "node_data_1"
    }
    allowed_value: {
      label: "Node 2"
      value: "node_data_2"
    }
    allowed_value: {
      label: "Node 3"
      value: "node_data_3"
    }
  }
}
