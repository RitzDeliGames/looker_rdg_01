include: "/views/**/events.view"


view: _008_frame_count_histogram {
  extends: [events]
  derived_table: {
    sql: SELECT extra_json,
                user_type,
                hardware,
                platform,
                version,
                install_version,
                SUM(CAST(frame_time_histogram AS INT64)) AS frame_count,
                OFFSET AS ms_per_frame
         FROM
            `eraser-blast.game_data.events`
         CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json,'$.frame_time_histogram_values'))) AS frame_time_histogram WITH OFFSET
         WHERE
            event_name = 'round_end'
         GROUP BY ms_per_frame, user_type, hardware, platform, version, install_version, extra_json
         ORDER BY ms_per_frame ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


#####DIMENSIONS#####

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

  dimension: character_used {
    type: string
    suggest_explore: events
    suggest_dimension: events.character_used
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

  dimension: under_22_ms_per_frame {
    type: string
    sql: CASE
          WHEN ${ms_per_frame} <= 22
          THEN 'under_22'
          ELSE 'over_22'
         END;;
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

  dimension: install_version {
    group_label: "Versions"
    label: "Install Version"
    type: string
    sql: ${TABLE}.install_version ;;
  }

  dimension: install_release_version {
    group_label: "Versions"
    label: "Install Major Release Version"
    sql: @{install_release_version_major};;
  }

  dimension: install_release_version_minor {
    group_label: "Versions"
    label: "Install Minor Release Version"
    sql: @{install_release_version_minor};;
  }



# VIEW DETAILS

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
