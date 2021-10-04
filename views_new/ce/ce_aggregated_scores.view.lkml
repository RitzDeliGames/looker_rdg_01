# If necessary, uncomment the line below to include explore_source.
# include: "ritz_deli_games.model.lkml"

view: ce_aggregated_scores {
  derived_table: {
    explore_source: community_events {
      column: rdg_id {}
      column: score_max {}
      column: event_id {}
      column: event_names {}
      column: event_id {}
    }
  }
  dimension: rdg_id {}
  dimension: event_id {
    label: "Event ID"
  }
  dimension: event_names {
     label: "Event Name"
  }
  dimension: score_max {
    label: "Max Score"
    type: number
  }
  measure: player_count {
    label: "Player Count"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
}
