view: iam {
  derived_table: {
    explore_source: events
    {
      column: user_id {field: events.user_id}
      column: timestamp {field: events.timestamp_raw}
      column: install_version {field: events.install_version}
      column: current_card {field: events.current_card}
      column: current_card_quest {field: events.current_card_quest}
      column: extra_json {field: events.extra_json}

      filters: [events.event_name: "InAppMessaging"]
    }
  }

  dimension: user_id {}
  dimension: timestamp {
    type: date_time
  }
  dimension: install_version {}
  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }
  dimension: campaign_id  {
    type: string
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.campaign_id");;
  }
  dimension: campaign_name  {
    type: string
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.campaign_name");;
  }
  dimension: template_id  {
    type: string
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.template_id");;
  }
  dimension: ui_action  {
    type: string
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.ui_action");;
  }
  dimension: iam_ui_actions {
    sql: @{iam_ui_actions} ;;
  }
  measure: players {
    type: count_distinct
    sql: ${user_id} ;;
  }
  measure: views {
    type: count_distinct
    sql: ${timestamp} ;;
  }
  dimension: current_card {}
  dimension: current_card_quest {
    type: number
    value_format: "####"
  }
  dimension: current_card_no {
    type: number
    sql: @{current_card_numbered} ;;
  }
}
