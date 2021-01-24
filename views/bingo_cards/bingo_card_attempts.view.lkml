view: bingo_card_attempts {
  derived_table: {
    explore_source: events
    {
      column: user_id {field: events.user_id}
      column: timestamp {field: events.timestamp_raw}
      column: install_version {field: events.install_version}
      column: current_card {field: events.current_card}
      column: current_card_quest {field: events.current_card_quest}
      column: extra_json {field: events.extra_json}

      filters: [events.event_name: "cards"]
    }
  }

  dimension: user_id {}

  dimension: timestamp {}

  dimension: extra_json {
    hidden: yes
  }

  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }

  dimension: current_card {}

  dimension: current_card_quest {
    type: number
    value_format: "####"
  }

  dimension: current_card_quest_str {
    sql: ${current_card_quest} ;;
  }

  dimension:  current_quest {
    type: number
    sql:  CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64);;
  }

  dimension:  attempts {
    type: number
    sql:  CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.rounds") AS INT64);;
  }

  measure: attempts_count {
    type: count_distinct
    sql: ${attempts} ;;
    drill_fields: [user_id, timestamp, current_card_quest, current_card, current_quest, attempts, extra_json]
  }

  # measure: attempts_min {
  #   type: min
  #   sql: ${attempts} ;;
  #   drill_fields: [user_id, current_card_quest, current_card, current_quest, attempts]
  # }

  # measure: attempts_25th {
  #   type: percentile
  #   percentile: 25
  #   sql: ${attempts} ;;
  #   drill_fields: [user_id, current_card_quest, current_card, current_quest, attempts]
  # }

  # measure: attempts_med {
  #   type: median
  #   sql: ${attempts} ;;
  #   drill_fields: [user_id, current_card_quest, current_card, current_quest, attempts]
  # }

  # measure: attempts_75th {
  #   type: percentile
  #   percentile: 75
  #   sql: ${attempts} ;;
  #   drill_fields: [user_id, current_card_quest, current_card, current_quest, attempts]
  # }

  # measure: attempts_max {
  #   type: max
  #   sql: ${attempts} ;;
  #   drill_fields: [user_id, current_card_quest, current_card, current_quest, attempts]
  # }
}
