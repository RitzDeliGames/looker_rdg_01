view: _008_frame_count_histogram {
  derived_table: {
    sql: SELECT
        SUM(cast(frame_time_histogram AS INT64)) AS frame_count,
        OFFSET AS ms_per_frame
      FROM
        `eraser-blast.game_data.events`
      CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json,'$.frame_time_histogram_values'))) AS frame_time_histogram WITH OFFSET
      WHERE
        event_name = 'round_end'
        AND user_type = 'internal'
      GROUP BY ms_per_frame
      ORDER BY ms_per_frame ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: frame_count {
    type: number
    sql: ${TABLE}.frame_count ;;
  }

  dimension: ms_per_frame {
    type: number
    sql: ${TABLE}.ms_per_frame ;;
  }


  set: detail {
    fields: [frame_count, ms_per_frame]
  }
}
