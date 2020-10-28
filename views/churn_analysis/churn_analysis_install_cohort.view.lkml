include: "/views/**/events.view"

view: churn_analysis_install_cohort {
  extends: [events]
#   sql_table_name: `eraser-blast.game_data.events`;;

  measure: count_unique_person_id_one_day {
    label: "Player Count 1 day"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_id, max_card_quest]
    filters: [consecutive_days: ">=1"]
  }

  measure: one_day_churn {
    label: "D2 Retention"
    type: number
    value_format_name: percent_2
    sql: (1.0*${count_unique_person_id_one_day} / NULLIF(${count_unique_person_id},0)) ;;
  }

  measure: max_card_quest {
    label: "Max Card + Quest"
    type: max
    value_format: "####"
    sql: ${current_card_quest} ;;
  }

  dimension: consecutive_days {
    type: number
    sql: ${TABLE}.consecutive_days ;;
  }
}
