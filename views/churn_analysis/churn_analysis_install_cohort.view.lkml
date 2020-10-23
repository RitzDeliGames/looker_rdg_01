include: "/views/**/events.view"

view: churn_analysis_install_cohort {
  extends: [events]
#   sql_table_name: `eraser-blast.game_data.events`;;

  measure: count_unique_person_id_one_day {
    label: "Player Count 1 day"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [consecutive_days: ">=1"]
  }

  measure: one_day_churn {
    label: "1 day churn"
    type: number
    value_format_name: percent_2
    sql: 1-(1.0*${count_unique_person_id_one_day} / NULLIF(${count_unique_person_id},0)) ;;
  }


  dimension: consecutive_days {
    type: number
    sql: ${TABLE}.consecutive_days ;;
  }
}
