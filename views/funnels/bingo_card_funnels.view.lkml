view: bingo_card_funnels {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: extra_json {field: events.extra_json}
      column: install_version {field: events.install_version}
      column: current_card {field: events.current_card}
      column: current_card_quest {field: events.current_card_quest}
      column: experiments {field: events.experiments}
      column: event_name {field: events.event_name}
      column: extra_json {field: events.extra_json}
      column: timestamp {field: events.timestamp_raw}
      column: user_first_seen {field: events.user_first_seen_raw}
      column: platform {field: events.device_platform}
      column: consecutive_days {field: events.consecutive_days}
      column: round_id {field: events.round_id}
      column: engagement_ticks {field: events.engagement_ticks}

      filters: [events.event_name: "round_end"]
    }
  }

  dimension: user_id {}

  measure: player_count {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_id, install_release_version_minor, user_first_seen]
  }

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

  dimension: install_version {
    hidden: yes
  }

  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }

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

  dimension: consecutive_days {}

  measure: max_consecutive_days {
    type: max
    sql: ${consecutive_days};;
  }

  dimension: current_card_quest {
    type: number
    value_format: "####"
  }

  dimension: engagement_ticks {
    group_label: "Engagement Ticks"
    type: number
  }

  dimension: engagement_ticks_first_20_ticks {
    group_label: "Engagement Ticks"
    label: "First 10 Minutes"
    style: integer
    type: tier
    tiers: [0,4,8,12,16,20]
    sql: ${engagement_ticks} ;;
  }


  dimension: engagement_ticks_first_60_ticks {
    group_label: "Engagement Ticks"
    label: "First 30 Minutes"
    style: integer
    type: tier
    tiers: [0,4,8,12,16,20,24,28,32,36,40,44,48,52,56,60]
    sql: ${engagement_ticks} ;;
  }

  dimension: engagement_ticks_first_120_ticks {
    group_label: "Engagement Ticks"
    label: "First Hour"
    style: integer
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90,100,110,120]
    sql: ${engagement_ticks} ;;
  }

  dimension: round_id {}

  measure: round_id_min {
    type: min
    sql: ${round_id} ;;
  }

  measure: round_id_25th {
    type: percentile
    percentile: 25
    sql: ${round_id} ;;
  }

  measure: round_id_med {
    type: median
    sql: ${round_id} ;;
  }

  measure: round_id_75th {
    type: percentile
    percentile: 75
    sql: ${round_id} ;;
  }

  measure: round_id_max {
    type: max
    sql: ${round_id} ;;
  }

}
