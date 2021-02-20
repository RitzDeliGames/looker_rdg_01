view: ask_for_help {
  derived_table: {
    explore_source: events
    {
      column: user_id {field: events.user_id}
      column: rdg_id {field: events.rdg_id}
      column: timestamp {field: events.timestamp_raw}
      column: country {field: events.country}
      column: install_version {field: events.install_version}
      column: country {field: events.country}
      column: current_card {field: events.current_card}
      column: current_card_quest {field: events.current_card_quest}
      column: extra_json {field: events.extra_json}

      filters: [events.event_name: "afh"]
    }
  }

  dimension: user_id {}
  dimension: timestamp {}
  dimension: country {}
  dimension: extra_json {
    hidden: yes
  }
  dimension: install_version {}
  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }
  dimension: current_card {}
  dimension: current_card_quest {
    type: number
    value_format: "####"
  }
  dimension: rdg_afh_id {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.rdg_afh_id") ;;
  }
  dimension: request_card_id {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.request_card_id") ;;
  }
  dimension: request_tile_id {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.request_tile_id") ;;
  }
  dimension: request_sent_timestamp {
    type: number
    value_format: "####"
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.request_sent_timestamp") AS INT64);;
  }
  dimension: afh_action {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.afh_action") ;;
  }

  measure: requests_count {
    type: count_distinct
    sql: ${rdg_afh_id} ;;
    drill_fields: [request_sent_timestamp, user_id, rdg_afh_id, request_card_id, request_tile_id]
  }
}
#FORMAT_TIMESTAMP("%c",TIMESTAMP_MILLIS(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.request_sent_timestamp") AS INT64)), "UTC") AS request_sent_timestamp,
