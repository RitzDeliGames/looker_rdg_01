view: churned_players {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: extra_json {field: events.extra_json}
      column: install_version {field: events.install_version}
      column: current_card {field: events.current_card}
      column: experiments {field: events.experiments}
      column: event_name {field: events.event_name}
      column: extra_json {field: events.extra_json}
      column: engagement_ticks {field: events.engagement_ticks}
      column: timestamp {field: events.timestamp_raw}
      column: user_first_seen {field: events.user_first_seen_raw}
      column: platform {field: events.device_platform}
      column: consecutive_days {field: events.consecutive_days}
      column: current_card_quest {field: events.current_card_quest}
      column: round_id {field: events.round_id}
      column: minutes_since_install {field: events.minutes_since_install}
      column: hours_since_install {field: events.hours_since_install}
      column: session_id {field: events.session_id}
    }
  }

  dimension: user_id {}

  measure: player_count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_id]
  }

  dimension: created_at {}
  dimension: current_card {}
  dimension: event_name {}
  dimension: extra_json {}
  dimension: platform {}
  dimension: experiments {}

  dimension: experiment_names {
    type: string
    sql: @{experiment_ids} ;;
  }

  dimension: variants {
    type: string
    sql: REPLACE(@{variant_ids},'"','') ;;
  }

  dimension: install_version {}

  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }

  dimension: engagement_ticks {}

  measure:  engagement_ticks_min {
    type: min
    sql: ${engagement_ticks} ;;
  }

  measure:  engagement_ticks_25th {
    type: percentile
    percentile: 25
    sql: ${engagement_ticks} ;;
  }

  measure:  engagement_ticks_med {
    type: median
    sql: ${engagement_ticks} ;;
  }

  measure:  engagement_ticks_75th {
    type: percentile
    percentile: 75
    sql: ${engagement_ticks} ;;
  }

  measure:  engagement_ticks_max {
    type: max
    sql: ${engagement_ticks} ;;
  }

  dimension: timestamp {
    type: date_time
  }

  dimension: minutes_since_install {
    type: number
  }

  measure: minutes_since_install_min {
    type: min
    sql: ${minutes_since_install} ;;
    drill_fields: [user_id, user_first_seen, timestamp, minutes_since_install, current_card_quest]
  }

  measure: minutes_since_install_25th {
    type: percentile
    percentile: 25
    sql: ${minutes_since_install} ;;
  }

  measure: minutes_since_install_med {
    type: median
    sql: ${minutes_since_install} ;;
  }

  measure: minutes_since_install_75th {
    type: percentile
    percentile: 75
    sql: ${minutes_since_install} ;;
  }

  measure: minutes_since_install_max {
    type: max
    sql: ${minutes_since_install} ;;
    drill_fields: [user_id, user_first_seen, timestamp, minutes_since_install, current_card_quest]
  }

  dimension: hours_since_install {
    type: number
  }

  measure: hours_since_install_min {
    type: min
    sql: ${hours_since_install} ;;
    drill_fields: [user_id, user_first_seen, timestamp, hours_since_install, current_card_quest]
  }

  measure: hours_since_install_25th {
    type: percentile
    percentile: 25
    sql: ${hours_since_install} ;;
  }

  measure: hours_since_install_med {
    type: median
    sql: ${hours_since_install} ;;
  }

  measure: hours_since_install_75th {
    type: percentile
    percentile: 75
    sql: ${hours_since_install} ;;
  }

  measure: hours_since_install_max {
    type: max
    sql: ${hours_since_install} ;;
    drill_fields: [user_id, user_first_seen, timestamp, hours_since_install, current_card_quest]
  }

  measure: event_count {
    type: count_distinct
    sql: ${timestamp} ;;
  }

  dimension: user_first_seen {
    type: date_time
  }

  dimension: quest {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.current_quest") AS INT64);;
  }

  dimension: quest_complete {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.quest_complete");;
  }

  dimension: button_click {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.button_tag");;
  }

  measure: click_count {
    type: number
    sql: COUNT(${button_click}) ;;
  }

  dimension: load_time {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.load_time") AS INT64);;
  }

  measure: cumulative_loading_time {
    type: sum
    sql: ${load_time} ;;
  }

  dimension: consecutive_days {}

  measure: max_consecutive_days {
    type: max
    sql: ${consecutive_days};;
  }

  dimension: current_card_quest {
    type: number
    value_format: "####"
  }

  dimension: current_card_quest_str {
    type: string
    sql: ${current_card_quest} ;;
  }

  measure: max_current_card_quest {
    type: max
    value_format: "####"
    sql: ${current_card_quest} ;;
    drill_fields: [timestamp, minutes_since_install, engagement_ticks, current_card_quest, quest_complete, failed_attempts, event_name, button_click, load_time, extra_json, experiments]
  }

  dimension: round_id {}

  measure: max_round_id {
    type: max
    sql: ${round_id} ;;
  }

  measure: avg_load_time {
    type: average
    value_format: "####"
    sql:  ${load_time} / 1000;;
  }

  measure: max_load_time {
    type: max
    value_format: "####"
    sql:  ${load_time} / 1000;;
  }

  measure: min_load_time {
    type: min
    value_format: "####"
    sql:  ${load_time} / 1000;;
  }

  measure: med_load_time {
    type: median
    value_format: "####"
    sql:  ${load_time} / 1000;;
  }

  measure: quartile_2_load_time {
    type: percentile
    percentile: 25
    value_format: "####"
    sql:  ${load_time} / 1000;;
  }

  measure: quartile_3_load_time {
    type: percentile
    percentile: 75
    value_format: "####"
    sql:  ${load_time} / 1000;;
  }

  dimension: failed_attempts {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.rounds") AS INT64) - CAST(ARRAY_LENGTH(JSON_EXTRACT_ARRAY(extra_json,"$.card_state")) AS INT64) ;;
  }

  measure: max_failed_attempts {
    type: max
    sql: ${failed_attempts} ;;
  }

  dimension: session_id {
    hidden: yes
  }

  measure: session_count {
    type: count_distinct
    sql: ${session_id} ;;
  }
}
