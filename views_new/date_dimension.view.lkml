view: date_dimension {
  derived_table: {
    sql:
      select day as date_day
      from unnest(generate_date_array(date('2019-01-01'),current_date(),interval 1 day)) as day -- start of dataset
    ;;
  }
  dimension: date_day {
    type: date_time
    sql: ${TABLE}.date_day ;;
  }
}
