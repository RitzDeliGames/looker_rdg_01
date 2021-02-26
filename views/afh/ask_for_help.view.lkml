view: ask_for_help {
  derived_table: {
    explore_source: events
    {
      column: user_id {field: events.user_id}
      column: rdg_id {field: events.rdg_id}
      column: timestamp {field: events.timestamp_raw}
      column: country {field: events.country}
      column: region {field: events.region}
      column: install_version {field: events.install_version}
      column: country {field: events.country}
      column: experiments {field: events.experiments}
      column: quests_completed {field: events.quests_completed}
      column: extra_json_afh {field: events.extra_json}

      filters: [events.event_name: "afh"]
    }
  }

  dimension: user_id {}
  dimension: quests_completed {
    type: number
  }
  dimension: timestamp {}
  dimension_group: event_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      hour,
      hour_of_day,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${timestamp} ;;
  }
  dimension: country {}
  dimension: region {}
  dimension: extra_json_afh {
    hidden: yes
  }
  dimension: install_version {}
  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }
  dimension: rdg_afh_id {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json_afh,"$.rdg_afh_id") ;;
  }
  dimension: is_fake {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json_afh,"$.is_fake") ;;
  }
  dimension: request_card_id {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json_afh,"$.request_card_id") ;;
  }
  dimension: request_tile_id {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json_afh,"$.request_tile_id") AS INT64);;
  }
  dimension: current_card_no {
    label: "Request Card Numbered"
    type: number
    value_format: "####"
    sql: @{request_card_numbered} ;;
  }
  dimension: request_card_quest {
    label: "Request Card + Quest"
    type: number
    value_format: "####"
    sql: ${current_card_no} + ${request_tile_id};;
  }
  dimension: request_sent_timestamp {
    type: number
    value_format: "####"
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json_afh,"$.request_sent_timestamp") AS INT64);;
  }
  dimension: afh_action {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json_afh,"$.afh_action") ;;
  }
  dimension: requesting_player_id {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json_afh,"$.requesting_player_id") ;;
  }
  measure:  requesting_player_distinct_count {
    label: "Unique Requesting Player Count"
    type: count_distinct
    sql: ${requesting_player_id} ;;
  }
  dimension: providing_player_id {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json_afh,"$.providing_player_id") ;;
  }
  measure:  providing_player_distinct_count {
    label: "Unique Providing Player Count"
    type: count_distinct
    sql:  JSON_EXTRACT_SCALAR(extra_json_afh,"$.providing_player_id") ;;
  }
  measure: requests_count {
    type: count_distinct
    sql: ${rdg_afh_id} ;;
    drill_fields: [request_sent_timestamp, user_id, rdg_afh_id, request_card_id, request_tile_id]
  }
  measure: max_current_card_quest {
    type: max
    sql: ${request_card_quest} ;;
    drill_fields: [user_id, request_card_quest]
  }
  dimension: experiments {}
}
