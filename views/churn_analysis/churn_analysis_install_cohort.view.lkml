view: churn_analysis_install_cohort {
  sql_table_name: `eraser-blast.game_data.events`;;

#DIMENSIONS# NOTE: THESE WERE BRUTE-FORCED TO GET STARTED...NEXT STEP IS TO OPTIMIZE / JOIN TO THE EVENT VIEW / TIE TO THE MANIFEST

###PLAYER DIMENSIONS###

  dimension: player_id {
    group_label: "Player ID Dimensions"
    label: "Player ID"
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: user_first_seen {
    type: time
    group_label: "Install Date"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: consecutive_days {
    type: number
    sql: ${TABLE}.consecutive_days ;;
  }

#MEASURES#

  measure: count_unique_person_id {
    label: "Count of Unique Players"
    type: count_distinct
    sql: ${player_id} ;;
  }

}
