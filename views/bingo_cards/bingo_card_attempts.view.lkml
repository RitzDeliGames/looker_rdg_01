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
  #TO BE DEPRECATED
   type: number
    sql:  CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.rounds") AS INT64);;
  }

  measure: attempts_count {
    type: count_distinct
    sql: ${attempts} ;;
    drill_fields: [user_id, timestamp, current_card_quest, current_card, current_quest, attempts, extra_json]
  }

  dimension: attempts_explicit {
    type: number
    sql: CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.node_attempts_explicit") AS INT64) ;;
  }

  measure: attempts_explicit_max {
    label: "Explicit Attempts - Max"
    type: max
    sql: ${attempts_explicit} ;;
  }

  dimension: attempts_passive {
    type: number
    sql: CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.node_attempts_passive") AS INT64) ;;
  }

  measure: attempts_passive_max {
    label: "Passive Attempts - Max"
    type: max
    sql: ${attempts_passive} ;;
  }

  dimension: rounds {
    label: "Rounds to Complete"
    type: number
    sql:  CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.rounds") AS INT64) ;;
  }

  measure: round_count {
    label: "Rounds to Complete - Max"
    type: max
    sql: ${rounds} ;;
  }

  dimension: node_end_tick {
    label: "Engagement Ticks to Complete"
    type: number
    sql:  CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.node_end_tick") AS INT64) ;;
  }

}
