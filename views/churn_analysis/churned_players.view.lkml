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
      column: consecutive_days {field:events.consecutive_days}
      column: current_card_quest {field:events.current_card_quest}
      column: experiment_names {field: events.experiment_names}
      column: variants {field: events.variants}
      column: 24_hours_since_install {field: events.24_hours_since_install}
      column: 60_mins_since_install {field: events.60_mins_since_install}
    }
  }

  dimension: user_id {}

  measure: player_count {
    type: count_distinct
    sql: ${user_id} ;;
  }

  dimension: created_at {}
  dimension: install_version {}
  dimension: current_card {}
  dimension: event_name {}
  dimension: extra_json {}
  dimension: engagement_ticks {}
  dimension: platform {}
  dimension: experiments {}

  dimension: timestamp {
    type: date_time
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

  dimension: new_ux_group {
    type: string
    sql: JSON_EXTRACT_SCALAR(experiments,"$.newVsOld_20201218");; #HOW DO WE CONFIGURE THIS IN THE VIEW FILE?
  }

  dimension: button_click {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.button_tag");;
  }

  dimension: load_time {
    type: number
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.load_time");;
  }

  dimension: consecutive_days {}

  measure: max_consecutive_days {
    type: max
    sql: ${consecutive_days};;
  }

  dimension: current_card_quest {
    value_format: "####"
  }

  measure: max_current_card_quest {
    type: max
    value_format: "####"
    sql: ${current_card_quest} ;;
    drill_fields: [timestamp, engagement_ticks, 60_mins_since_install, 24_hours_since_install, current_card_quest, quest_complete, event_name, button_click, load_time, extra_json, experiments]
  }

  dimension: experiment_names {}

  dimension: variants {}

  dimension: 24_hours_since_install {}

  dimension: 60_mins_since_install {}
}
