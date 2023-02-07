view: player_summary_test {
# # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      select
        sum(1) as count_rows
      from
        ${player_summary_by_day_test.SQL_TABLE_NAME}

          ;;
    datagroup_trigger: dependent_on_player_summary_by_day
    publish_as_db_view: yes

  }
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  measure: my_count_rows {
    description: "Use this for counting lifetime orders across many users"
    type: sum
    sql: ${TABLE}.count_rows  ;;
  }
}
