view: resources_spent {
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

      filters: [events.event_name: "transaction"]
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

  measure: spender_count {
    type: count_distinct
    sql: ${user_id} ;;
  }

  dimension: timestamp_transaction {
    type: string
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.timestamp_transaction");;
  }

  measure: transaction_count {
    type: count_distinct
    sql: ${timestamp_transaction} ;;
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

  dimension: quest {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.current_quest") AS INT64);;
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

  dimension: round_id {}

  measure: max_round_id {
    type: max
    sql: ${round_id} ;;
  }

  dimension: sheet {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.sheet_id") ;;
  }

  dimension: source {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.source_id") ;;
  }

  dimension:  currency_spent {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") ;;
  }

  dimension:  resources_spent {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64);;
  }

  measure: sum_currency_spent_amount {
    type: sum
    sql: ${resources_spent} ;;
  drill_fields: [user_id, resources_spent, sheet, iap_id, iap_purchase_item, iap_purchase_qty, extra_json]
  }

  measure: sum_currency_spent_amount_per_spender {
    type: number
    value_format: "####"
    sql: ${sum_currency_spent_amount} / ${spender_count} ;;
    drill_fields: [user_id, resources_spent, sheet, iap_id, iap_purchase_item, iap_purchase_qty, extra_json]
  }

  measure: resources_spent_min {
    type: min
    sql: ${resources_spent} ;;
    drill_fields: [user_id, resources_spent, sheet, iap_id, iap_purchase_item, iap_purchase_qty, extra_json]
  }

  measure: resources_spent_25th {
    type: percentile
    percentile: 25
    sql: ${resources_spent} ;;
    drill_fields: [user_id, resources_spent, sheet, iap_id, iap_purchase_item, iap_purchase_qty, extra_json]
  }

  measure: resources_spent_med {
    type: median
    sql: ${resources_spent} ;;
    drill_fields: [user_id, resources_spent, sheet, iap_id, iap_purchase_item, iap_purchase_qty, extra_json]
  }

  measure: resources_spent_75th {
    type: percentile
    percentile: 75
    sql: ${resources_spent} ;;
    drill_fields: [user_id, resources_spent, sheet, iap_id, iap_purchase_item, iap_purchase_qty, extra_json]
  }

  measure: resources_spent_max {
    type: max
    sql: ${resources_spent} ;;
    drill_fields: [user_id, resources_spent, sheet, iap_id, iap_purchase_item, iap_purchase_qty, extra_json]
  }

  dimension:  iap_id {
    type: string
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.iap_id");;
  }

  dimension: iap_purchase_item {
    type: string
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.iap_purchase_item");;
  }

  dimension: iap_purchase_qty {
    type: number
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.iap_purchase_qty");;
  }
}
