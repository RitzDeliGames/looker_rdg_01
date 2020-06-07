explore: retention_example {}
view: retention_example {
  derived_table: {
    sql:
SELECT events.user_id AS user_id ,
       DATETIME_TRUNC(CAST(created_at AS DATETIME), HOUR) AS signup_hour ,
       day_list.activity_hour AS activity_hour ,
       data.event_hour AS activity ,
       data.unique_events AS EVENTS
FROM `eraser-blast.game_data.events` EVENTS
CROSS JOIN
  (SELECT DISTINCT(DATETIME_TRUNC(CAST(TIMESTAMP AS DATETIME), HOUR)) AS activity_hour
   FROM `eraser-blast.game_data.events`) AS day_list
LEFT JOIN
  (SELECT user_id event_user_id ,
          DATETIME_TRUNC(CAST(TIMESTAMP AS DATETIME), HOUR) event_hour,
          COUNT(event_name) AS unique_events
   FROM `eraser-blast.game_data.events`
   GROUP BY 1,
            2) AS DATA ON data.event_hour = day_list.activity_hour
AND data.event_user_id = events.user_id
WHERE activity_hour >= DATETIME_TRUNC(CAST(created_at AS DATETIME), HOUR)
 ;;
  }

  measure: count {
    type: count
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: signup_hour {
    type: date_raw
    sql: timestamp(${TABLE}.signup_hour) ;;
  }

  dimension: activity {
    type: date_raw
    sql: timestamp(${TABLE}.activity) ;;
  }

  dimension: events {
    type: number
    sql: ${TABLE}.events ;;
  }

  dimension: days_since_signup {
    type: number
   sql: timestamp_DIFF(${activity}, ${signup_hour}, hour) ;;
  }

  measure: total_users {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [users.id, users.age, users.name, user_order_facts.lifetime_orders]
  }

  measure: total_active_users {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [users.id, users.age, users.name, user_order_facts.lifetime_orders]

    filters: {
      field: events
      value: ">0"
    }
  }

  measure: percent_of_cohort_active {
    type: number
    value_format_name: percent_1
    sql: 1.0 * ${total_active_users} / nullif(${total_users},0) ;;
  }
}
