  view: scene_load_times {
    derived_table: {
      sql: SELECT
              timestamp,
              user_id,
              session_id,
              CONCAT(JSON_EXTRACT(extra_json, '$.transition_from'), " - ", JSON_EXTRACT(extra_json, '$.transition_to')) AS transition_from_to,
              -- TIMESTAMP_DIFF(MAX(timestamp), min(timestamp), MINUTE) AS minutes,
              ROUND(CAST(JSON_EXTRACT(extra_json, '$.load_time') AS NUMERIC) / 1000, 0) AS load_time_secs

        FROM events
        WHERE event_name IN ('transition')
          -- AND user_id = 'anon-4f450865-8145-4ec0-a2ec-904e4ccb2690'
          -- AND session_id IN ('f3faa887-0b40-4eb7-a868-06a50d124275-07/08/2020 11:34:14', '520394d9-6aad-4ce4-a2d2-438f21b65027-07/10/2020 01:48:20')
        GROUP BY user_id, load_time_secs, session_id, timestamp, transition_from_to
         ;;
    }

    measure: load_time_measure {
      type: number
      sql: ${load_time_secs} ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension_group: timestamp {
      type: time
      sql: ${TABLE}.timestamp ;;
    }

    dimension: user_id {
      type: string
      sql: ${TABLE}.user_id ;;
    }

    dimension: session_id {
      type: string
      sql: ${TABLE}.session_id ;;
    }

    dimension: transition_from_to {
      type: string
      sql: ${TABLE}.transition_from_to ;;
    }

    dimension: load_time_secs {
      type: number
      sql: ${TABLE}.load_time_secs ;;
    }

    set: detail {
      fields: [timestamp_time, user_id, session_id, transition_from_to, load_time_secs]
    }
  }
