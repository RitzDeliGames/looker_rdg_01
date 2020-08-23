view: created_at_max {
  derived_table: {
    sql: SELECT
        MAX(CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', created_at , 'America/Los_Angeles')) AS DATE)) AS max_first_seen_date,
        --CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', created_at , 'America/Los_Angeles')) AS DATE) AS first_seen_date,
        CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS DATE) AS event_date,
        user_id,
        --COUNT(DISTINCT user_id) AS test,
        event_name

      FROM `eraser-blast.game_data.events` AS events
      WHERE (events.user_type = 'external') AND (user_type NOT IN ("internal_editor", "unit_test")) --AND event_name = 'round_end'
        AND user_id <> 'user_id_not_set'
      GROUP BY event_date, user_id, event_name--, first_seen_date
      ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: max_first_seen_date {
    type: date
    sql: CAST(${TABLE}.max_first_seen_date AS TIMESTAMP) ;;
  }

#   dimension: first_seen_date {
#     type: date
#     sql: CAST(${TABLE}.first_seen_date AS TIMESTAMP) ;;
#   }

  dimension: event_date {
    type: date
    sql: CAST(${TABLE}.event_date AS TIMESTAMP) ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  measure: unique_person_id {
    type:  count_distinct
    sql: ${user_id} ;;
  }

  set: detail {
    fields: [max_first_seen_date, event_date]
  }

}
