view: skill_used {
  derived_table: {
    explore_source: events {
      column: user_id {field: events.user_id}
      column: extra_json {field: events.extra_json}
      column: install_version {field: events.install_version}
      column: current_card {field: events.current_card}
      column: experiments {field: events.experiments}
      column: event_name {field: events.event_name}
      column: engagement_ticks {field: events.engagement_ticks}
      column: timestamp {field: events.timestamp_raw}
      column: user_first_seen {field: events.user_first_seen_raw}
      column: platform {field: events.device_platform}
      column: consecutive_days {field: events.consecutive_days}
      column: current_card_quest {field: events.current_card_quest}
      column: round_id {field: events.round_id}

      filters: [events.event_name: "round_end"]
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
  dimension: timestamp {
    type: date_time
  }
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

  dimension: engagement_ticks {
    group_label: "Engagement Ticks"
    type: number
  }

  dimension: engagement_ticks_first_120_ticks {
    group_label: "Engagement Ticks"
    label: "First Hour"
    style: integer
    type: tier
    tiers: [0,1,10,20,30,40,50,60,70,80,90,100,110,120]
    sql: ${engagement_ticks} ;;
  }

  dimension: engagement_ticks_first_1400_ticks {
    group_label: "Engagement Ticks"
    label: "First 12 Hours"
    style: integer
    type: tier
    tiers: [0,120,240,360,480,600,720,840,960,1080,1200,1320,1440]
    sql: ${engagement_ticks} ;;
  }

  measure:  max_engagement_ticks {
    type: max
    sql: ${engagement_ticks} ;;
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

  dimension: current_card_quest_str {
    type: string
    sql: ${current_card_quest} ;;
  }

  measure: max_current_card_quest {
    type: max
    value_format: "####"
    sql: ${current_card_quest} ;;
    drill_fields: [timestamp, engagement_ticks, current_card_quest, quest_complete, event_name, experiments, extra_json]
  }

  dimension: round_id {}

  measure: max_round_id {
    type: max
    sql: ${round_id} ;;
  }

  dimension: skill_available {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.skill_available") AS INT64);;
    hidden: yes
  }

  dimension: skill_used {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.skill_used") AS INT64);;
    hidden: yes
  }

  measure:  skill_used_min {
    type: min
    sql: ${skill_used} ;;
  }

  measure:  skill_used_25 {
    type: percentile
    percentile: 25
    sql: ${skill_used} ;;
  }

  measure:  skill_used_med {
    type: median
    sql: ${skill_used} ;;
  }

  measure:  skill_used_75 {
    type: percentile
    percentile: 75
    sql: ${skill_used} ;;
  }

  measure: skill_used_max {
    type: max
    sql: ${skill_used} ;;
    drill_fields: [user_id, extra_json]
  }

  measure:  skill_available_min {
    type: min
    sql: ${skill_available} ;;
  }

  measure:  skill_available_05 {
    type: percentile
    percentile: 5
    sql: ${skill_available} ;;
    drill_fields: [skill_available, engagement_ticks, user_id, round_id, extra_json]
  }

  measure:  skill_available_25 {
    type: percentile
    percentile: 25
    sql: ${skill_available} ;;
    drill_fields: [skill_available, engagement_ticks, user_id, round_id, extra_json]
  }

  measure:  skill_available_med {
    type: median
    sql: ${skill_available} ;;
    drill_fields: [skill_available, engagement_ticks, user_id, round_id, extra_json]
  }

  measure:  skill_available_75 {
    type: percentile
    percentile: 75
    sql: ${skill_available} ;;
    drill_fields: [skill_available, engagement_ticks, user_id, round_id, extra_json]
  }

  measure:  skill_available_95 {
    type: percentile
    percentile: 95
    sql: ${skill_available} ;;
    drill_fields: [skill_available, engagement_ticks, user_id, round_id, extra_json]
  }

  measure: skill_available_max {
    type: max
    sql: ${skill_available} ;;
    drill_fields: [skill_available, engagement_ticks, user_id, round_id, extra_json]
  }

  dimension: character_matches {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.character_007_matched") AS INT64) ;;
  }

  dimension:  character_match_potential {
    type: number
    sql:  FLOOR(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.character_007_matched") AS INT64) / 11);;
    # character_001_matched: 14
    # character_004_matched: 12
    # character_007_matched: 11
  }

  dimension: character_skill_available {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.skill_available") AS INT64) ;;
  }

  dimension: available_to_potential {
    type: number
    sql: IFNULL(SAFE_DIVIDE(${character_skill_available},${character_match_potential}),0) ;;
  }

  dimension: character_skill_used {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.skill_used") AS INT64) ;;
  }

  dimension: used_to_potential {
    type: number
    sql: IFNULL(SAFE_DIVIDE(${character_skill_used},${character_match_potential}),0) ;;
  }

  measure:  used_to_potential_min {
    type: min
    sql: ${used_to_potential} ;;
  }

  measure:  used_to_potential_25th {
    type: percentile
    percentile: 25
    sql: ${used_to_potential} ;;
  }

  measure:  used_to_potential_med {
    type: median
    sql: ${used_to_potential} ;;
  }

  measure:  used_to_potential_75th {
    type: percentile
    percentile: 75
    sql: ${used_to_potential} ;;
  }

  measure:  used_to_potential_max {
    type: max
    sql: ${used_to_potential} ;;
  }

}
