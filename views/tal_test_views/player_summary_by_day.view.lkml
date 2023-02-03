view: player_summary_by_day {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql: select * from eraser-blast.game_data_aggregate.player_summary_by_day ;;
    datagroup_trigger: change_24_hrs
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
    }
  #
  # # Define your dimensions and measures here, like this:
  dimension_group: rdg_date {
     description: "date as defined by rdg_date function"
     type: time
     timeframes: [date, week, month, year]
     sql: ${TABLE}.rdg_date ;;
   }
  #
  dimension: rdg_id {
    description: "Ritz Deli Game ID"
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  #
  dimension: first_country_by_day {
    description: "Ritz Deli Game ID"
    type: string
    sql: ${TABLE}.first_country_by_day ;;
  }
  #
  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
  #
  set: detail {
    fields: [
      first_country_by_day
    ]
  }
}
