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

  dimension: user_id {}

  measure: earned_player_count {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: earned_count {
    type: count_distinct
    sql: ${timestamp} ;;
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
    tiers: [0,20,40,60,80,100,120]
    sql: ${engagement_ticks} ;;
  }

  dimension: engagement_ticks_first_1440_ticks {
    group_label: "Engagement Ticks"
    label: "First 12 Hours"
    style: integer
    type: tier
    tiers: [0,120,240,360,480,600,720,840,960,1080,1200,1320,1440]
    sql: ${engagement_ticks} ;;
  }

  dimension: engagement_ticks_first_2880_ticks {
    group_label: "Engagement Ticks"
    label: "First 24 Hours"
    style: integer
    type: tier
    tiers: [0,240,480,720,960,1200,1440,1680,1920,2160,2400]
    sql: ${engagement_ticks} ;;
  }

  measure:  max_engagement_ticks {
    type: max
    sql: ${engagement_ticks} ;;
  }

  dimension: timestamp {}

  dimension_group: transaction_date {
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

  #dimension: earned_type {
  #  type: string
  #  sql:  earned_type = "CURRENCY_03" ;;
  #}

  dimension: resources_earned {
    hidden: yes
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.coins_earned") AS INT64);;
    value_format: "#,###"
  }

  measure: resources_earned_min {
    type: min
    sql: ${resources_earned} ;;
  }

  measure: resources_earned_25th {
    type: percentile
    percentile: 25
    sql: ${resources_earned} ;;
  }

  measure: resources_earned_median {
    type: median
    sql: ${resources_earned} ;;
  }

  measure: resources_earned_75th {
    type: percentile
    percentile: 75
    sql: ${resources_earned} ;;
  }

  measure: resources_earned_max {
    type: max
    sql: ${resources_earned} ;;
  }

  measure: resources_earned_sum {
    type: sum
    sql: ${resources_earned} ;;
  }

  measure: resources_rewarded_sum_per_rewarded_player {
    type: number
    value_format: "#,###"
    sql: ${resources_earned_sum} / ${resources_earned} ;;
  }

}
