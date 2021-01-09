view: resources_earned {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: extra_json {field: events.extra_json}
      column: install_release_version_minor {field: events.install_release_version_minor}
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
      column: 7_days_since_install {field: events.7_days_since_install}
      column: 14_days_since_install {field: events.14_days_since_install}
      column: 28_days_since_install {field: events.28_days_since_install}
      column: round_id {field: events.round_id}

      filters: [events.event_name: "round_end"]
    }
  }

  dimension: created_at {}
  dimension: install_release_version_minor {}
  dimension: current_card {}
  dimension: event_name {}
  dimension: extra_json {}
  dimension: platform {}
  dimension: experiments {}
  dimension: experiment_names {}
  dimension: variants {}
  dimension: 24_hours_since_install {}
  dimension: 60_mins_since_install {}
  dimension: 7_days_since_install {}
  dimension: 14_days_since_install {}
  dimension: 28_days_since_install {}

  dimension: user_id {}

  measure: player_count {
    type: count_distinct
    sql: ${user_id} ;;
  }

  dimension: engagement_ticks {}

  measure:  max_engagement_ticks {
    type: max
    sql: ${engagement_ticks} ;;
  }

  dimension: timestamp {}

  measure: earned_count {
    type: count_distinct
    sql: ${timestamp} ;;
  }

  dimension_group: earned_date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${timestamp} ;;
  }

  dimension: user_first_seen {
    type: date_time
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
  }

  dimension:  resource_earned_event {
    type: string
    sql: "round_end" ;;
  }

  dimension:  resource_earned_type {
    type: string
    sql: "CURRENCY_03" ;;
  }

  dimension:  resource_earned_qty {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.coins_earned") AS INT64);;
  }

  measure: resource_earned_sum {
    type: sum
    sql: ${resource_earned_qty} ;;
  }

  measure: resource_earned_per_reward {
    type: number
    value_format: "#,###"
    sql: ${resource_earned_sum} / ${earned_count} ;;
  }

  measure: resource_earned_per_rewarded_player {
    type: number
    value_format: "#,###"
    sql:  ${resource_earned_sum} / ${player_count} ;;
  }
}
