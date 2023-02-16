view: version_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:
      select
        version
        , max(highest_last_level_serial) as max_highest_last_level_serial
        , max(cumulative_star_spend) as max_cumulative_star_spend
        , count(distinct rdg_id) as count_distinct_players
      from
        `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`
      group by
        1
      ;;
    datagroup_trigger: dependent_on_player_daily_summary
    publish_as_db_view: yes
    partition_keys: ["version"]

  }

################################################################
## Unchanged Column Dimensions
################################################################

  dimension: version {type: string}
  dimension: max_highest_last_level_serial {type: number}
  dimension: max_cumulative_star_spend {type: number}
  dimension: count_distinct_players {type: number}

################################################################
## Calculated Dimensions
################################################################

  dimension: max_highest_last_level_serial_override {
    type: number
    sql: @{max_highest_last_level_serial_override} ;;
  }

  dimension: max_cumulative_star_spend_override {
    type: number
    sql: @{max_cumulative_star_spend_override} ;;
  }

}
