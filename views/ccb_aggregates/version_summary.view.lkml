view: version_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-09-27'

      select
        version
        , max(highest_last_level_serial) as max_highest_last_level_serial
        , max(cumulative_star_spend) as max_cumulative_star_spend
        , count(distinct rdg_id) as count_distinct_players
      from
        -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`
        ${player_daily_summary.SQL_TABLE_NAME}
      group by
        1
      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -6 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (6) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
  }


####################################################################
## Primary Key
####################################################################

dimension: primary_key {
  type: string
  sql:
    ${TABLE}.version
    ;;
  primary_key: yes
  hidden: yes
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

  dimension: max_highest_last_level_serial_override_string {
    type: string
    sql:  cast(@{max_highest_last_level_serial_override} as string) ;;
  }

  dimension: max_cumulative_star_spend_override {
    type: number
    sql: @{max_cumulative_star_spend_override} ;;
  }

  dimension: max_cumulative_star_spend_override_string {
    type: string
    sql:  cast(@{max_cumulative_star_spend_override} as string) ;;
  }

}
