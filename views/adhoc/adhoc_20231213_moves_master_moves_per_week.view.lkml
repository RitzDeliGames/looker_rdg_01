view: adhoc_20231213_moves_master_moves_per_week {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      select
        rdg_id
        , helper_functions.get_rdg_week(rdg_date) as rdg_week
        , sum(moves_remaining) as total_weekly_moves_remaining_before_ads
      from
        ${player_round_summary.SQL_TABLE_NAME}
        -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary`

      where
        game_mode = 'movesMaster'
        and count_wins = 1

      group by
        1,2

      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.rdg_week
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Dimensions
####################################################################

  # dates
  dimension_group: rdg_week {
    group_label: "Activity Weeks"
    label: "Activity Week"
    type: time
    timeframes: [week]
    sql: ${TABLE}.rdg_week ;;
  }

  dimension: rdg_id {type:string}

####################################################################
## Measures
####################################################################

  measure: total_weekly_moves_remaining_before_ads_10 {
    group_label: "Weekly Moves Remaining"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.total_weekly_moves_remaining_before_ads ;;
  }
  measure: total_weekly_moves_remaining_before_ads_25 {
    group_label: "Weekly Moves Remaining"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.total_weekly_moves_remaining_before_ads ;;
  }
  measure: total_weekly_moves_remaining_before_ads_50 {
    group_label: "Weekly Moves Remaining"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.total_weekly_moves_remaining_before_ads ;;
  }
  measure: total_weekly_moves_remaining_before_ads_75 {
    group_label: "Weekly Moves Remaining"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.total_weekly_moves_remaining_before_ads ;;
  }
  measure: total_weekly_moves_remaining_before_ads_95 {
    group_label: "Weekly Moves Remaining"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.total_weekly_moves_remaining_before_ads ;;
  }



}
