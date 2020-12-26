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
    }
  }

  dimension: user_id {}
  dimension: created_at {}
  dimension: install_version {}
  dimension: current_card {}
  dimension: event_name {}
  dimension: extra_json {}
  dimension: engagement_ticks {}

  dimension: timestamp {
    type: date_time
  }

  dimension: user_first_seen {
    type: date_time
  }

  dimension: quest {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.current_quest") AS INT64);;
  }

  dimension: new_ux_group {
    type: string
    sql: JSON_EXTRACT_SCALAR(experiments,"$.newVsOld_20201218");; #HOW DO WE CONFIGURE THIS IN THE VIEW FILE?
  }

  dimension: button_click {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.button_tag");;
  }

  measure: max_quest {
    type: max
    sql: ${quest} ;;
    drill_fields: [timestamp, engagement_ticks, quest, event_name, button_click, extra_json]
  }

}
