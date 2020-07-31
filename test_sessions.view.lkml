view: test_sessions {
  derived_table: {
    sql: SELECT CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS DATE) AS event,
       user_id, timestamp_insert, session_id, version, extra_json
FROM `eraser-blast.game_data.events`
WHERE (user_type = 'external') AND (user_id = 'facebook-2940294926098277') AND (user_type NOT IN ("internal_editor", "unit_test") AND (event_name = 'cards'))
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event {
    type: date
    sql: ${TABLE}.event ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: timestamp_insert {
    type: time
    sql: ${TABLE}.timestamp_insert ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  set: detail {
    fields: [
      event,
      user_id,
      timestamp_insert_time,
      session_id,
      version,
      extra_json
    ]
  }
}
