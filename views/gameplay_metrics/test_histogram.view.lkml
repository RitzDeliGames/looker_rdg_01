view: test_histogram {
  derived_table: {
    sql: SELECT
          extra_json
      FROM
        events
      WHERE
        event_name = 'round_end'
        AND user_type = 'internal'
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: extra_json {
    type: number
    sql: ${TABLE}.extra_json ;;
  }

  dimension: frame_count {
    type: number
    sql: frame_count ;;
  }

  dimension: frame_time_histogram {
    type: number
    sql: CAST(frame_time_histogram AS INT64) ;;
  }

  dimension: ms_per_frame {
    type: number
    sql: ms_per_frame
      ;;
  }


  set: detail {
    fields: [extra_json, frame_time_histogram, ms_per_frame, frame_count]
  }
}
