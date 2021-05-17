view: date_dimension {
  label: "Date Dimension"
  derived_table: {
    sql:
      select day as date_day
      from unnest(generate_date_array(date('2019-01-01'),current_date(),interval 1 day)) as day -- start of dataset
    ;;
    datagroup_trigger: change_at_midnight
    publish_as_db_view: yes
  }
  dimension_group: dimension {
    type: time
    sql: timestamp(${TABLE}.date_day) ;;
    timeframes: [
      date
    ]
  }
}
