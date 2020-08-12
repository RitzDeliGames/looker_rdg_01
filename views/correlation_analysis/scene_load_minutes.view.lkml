view: scene_load_minutes {
    derived_table: {
      sql: SELECT
               session_id,
               user_id,
               TIMESTAMP_DIFF(MAX(timestamp), min(timestamp), MINUTE) AS minutes,
               ROUND(AVG(CAST(JSON_EXTRACT(extra_json, '$.load_time') AS NUMERIC) / 1000), 0) AS avg_load_time_rd_0,

        FROM events
        WHERE event_name IN ('transition') AND user_id <> 'user_id_not_set'
          -- AND user_id IN ('anon-4f450865-8145-4ec0-a2ec-904e4ccb2690')
          -- AND session_id = 'f3faa887-0b40-4eb7-a868-06a50d124275-07/08/2020 11:34:14'
        GROUP BY session_id, user_id
        ORDER BY avg_load_time_rd_0 ASC
         ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: session_id {
      type: string
      sql: ${TABLE}.session_id ;;
    }

    dimension: user_id {
      type: string
      sql: ${TABLE}.user_id ;;
    }

    dimension: minutes {
      type: number
      sql: ${TABLE}.minutes ;;
    }

    dimension: avg_load_time_rd_0 {
      type: number
      sql: ${TABLE}.avg_load_time_rd_0 ;;
    }

    set: detail {
      fields: [session_id, user_id, minutes, avg_load_time_rd_0]
    }
  }
