include: "/views/**/events.view"


view: _008_frame_count_histogram {
  extends: [events]
  derived_table: {
    sql: SELECT user_type,
                hardware,
                platform,
                version,
                SUM(CAST(frame_time_histogram AS INT64)) AS frame_count,
                OFFSET AS ms_per_frame
         FROM
            `eraser-blast.game_data.events`
         CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json,'$.frame_time_histogram_values'))) AS frame_time_histogram WITH OFFSET
         WHERE
            event_name = 'round_end'
         GROUP BY ms_per_frame, user_type, hardware, platform, version
         ORDER BY ms_per_frame ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: frame_count {
    type: number
    sql: ${TABLE}.frame_count ;;
  }


  dimension: ms_per_frame {
    type: number
    sql: ${TABLE}.ms_per_frame ;;
  }

  measure: frame_count_sum {
    type: sum
    sql: ${frame_count} ;;
  }

  dimension: device_brand {
    type: string
    suggest_explore: events
    suggest_dimension: events.device_brand
  }

  dimension: device_model {
    type: string
    suggest_explore: events
    suggest_dimension: events.device_model
  }

  dimension: device_os_version {
    type: string
    suggest_explore: events
    suggest_dimension: events.device_os_version
  }


  drill_fields: [detail*]

  set: detail {
    fields: [user_type,
             device_brand,
             device_model,
             device_os_version,
             hardware, version,
             frame_count,
             ms_per_frame]
  }
}
