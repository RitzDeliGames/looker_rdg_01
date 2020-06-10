explore: retention_example {}
view: retention_example {
  derived_table: {
    sql: with cohort as (
      SELECT
          events.user_id AS user_id ,
          DATETIME_TRUNC(CAST(created_at AS DATETIME), HOUR) AS signup_hour
      FROM `eraser-blast.game_data.events` EVENTS
      WHERE 1=1
      and REPLACE(JSON_EXTRACT(extra_json,"$.current_FueStep"),'"','') = "FIRST_PLAY"),

      data as (
      SELECT user_id,
            DATETIME_TRUNC(CAST(TIMESTAMP AS DATETIME), HOUR) event_hour,
            COUNT( distinct event_name) AS unique_events
        FROM `eraser-blast.game_data.events`
        GROUP BY 1,2
      ),

      day_list as (
      SELECT DISTINCT(DATETIME_TRUNC(CAST(TIMESTAMP AS DATETIME), HOUR)) AS activity_hour

          FROM `eraser-blast.game_data.events`
      )

      select
      cohort.user_id
      , cohort.signup_hour
      , data.event_hour
      , day_list.activity_hour
      , data.unique_events
      from
      cohort
      cross join day_list
      left join data on data.user_id = cohort.user_id
                and day_list.activity_hour = data.event_hour



      WHERE 1=1
      and activity_hour >= signup_hour
       ;;
  }

  measure: count {
    type: count
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: signup_hour {
    type: time
    sql: cast(${TABLE}.signup_hour as timestamp)  ;;
  }

  dimension_group: event_hour {
    type: time
    sql: cast(${TABLE}.event_hour  as timestamp) ;;
  }

  dimension_group: diff  {
    type: duration
    sql_start: cast(${signup_hour_raw} as timestamp) ;;
    sql_end: cast(${activity_hour_raw} as timestamp) ;;
  }

  dimension_group: activity_hour {
    type: time
    sql: ${TABLE}.activity_hour ;;
  }

  dimension: unique_events {
    type: number
    sql: ${TABLE}.unique_events ;;
  }

  measure: total_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: total_active_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [unique_events: ">0"]
  }

  measure: percent_of_cohort_active {
    type: number
    value_format_name: percent_1
    sql: 1.0 * ${total_active_users} / nullif(${total_users},0) ;;
  }
}
