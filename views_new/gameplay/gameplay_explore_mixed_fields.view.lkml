view: gameplay_explore_mixed_fields {
  measure: players_requesting_of_all_players {
    label: "Players Requesting % of All Players"
    type: number
    sql: ${new_afh.requesting_player_distinct_count} / ${gameplay.player_count} ;;
    value_format_name: percent_1
  }
  measure: players_providing_of_all_players {
    label: "Players Helping % of All Players"
    type: number
    sql: ${new_afh.providing_player_distinct_count} / ${gameplay.player_count} ;;
    value_format_name: percent_1
  }
}
