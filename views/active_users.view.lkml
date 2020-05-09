include: "events.view"

view: dates {
  extends: [events]

  derived_table: {

    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql:
     SELECT cast(date as date) as date
FROM UNNEST(GENERATE_DATE_ARRAY(DATE_SUB(CURRENT_DATE, INTERVAL 5 YEAR), CURRENT_DATE)) date
      ;;
  }
}

view: active_users {
  extends: [events]

  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE();;

    sql: WITH daily_use AS (
      SELECT
        user_id as user_id
        , cast(TIMESTAMP_TRUNC(transactiondate,day) as date) as activity_date
      FROM users
      GROUP BY 1, 2
      )

      SELECT
        daily_use.user_id
       , wd.date as date
       , MIN( DATE_DIFF(wd.date, daily_use.activity_date, day) ) as days_since_last_action
      FROM ${dates.SQL_TABLE_NAME} AS wd
      CROSS JOIN daily_use
        WHERE wd.date BETWEEN daily_use.activity_date AND DATE_ADD(daily_use.activity_date, INTERVAL 30 DAY)
      GROUP BY 1,2
        ;;
  }

  dimension_group: date {
    type: time
    timeframes: [date,month,quarter,quarter_of_year,year,raw]
    sql: CAST( ${TABLE}.date AS TIMESTAMP);;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: days_since_last_action {
    type: number
    sql: ${TABLE}.days_since_last_action ;;
    value_format_name: decimal_0
  }

  dimension: active_this_day {
    type: yesno
    sql: ${days_since_last_action} < 1 ;;
  }

  dimension: active_last_7_days {
    type: yesno
    sql: ${days_since_last_action} < 7 ;;
  }

  measure: user_count_active_30_days {
    label: "Monthly Active Users"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [users.id, users.name]
  }

  measure: user_count_active_this_day {
    label: "Daily Active Users"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [users.id, users.name]

    filters: {
      field: active_this_day
      value: "yes"
    }
  }

  measure: user_count_active_7_days {
    label: "Weekly Active Users"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [users.id, users.name]

    filters: {
      field: active_last_7_days
      value: "yes"
    }
  }
}
