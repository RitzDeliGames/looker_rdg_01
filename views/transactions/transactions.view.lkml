view: transactions {
  derived_table: {
    explore_source: events {
      column: rdg_id {field: events.rdg_id}
      column: user_id {field: events.user_id}
      column: created_at {field: events.user_first_seen_date}
      column: device_model_number {field: events.device_model_number}
      column: extra_json {field: events.extra_json}
      column: country {field: events.country}
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

  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: user_id {}

  measure: spender_count {
    type: count_distinct
    sql: ${user_id} ;;
  }
  dimension: device_model_number {}
  dimension: created_at {}

  dimension_group: created_at_date {
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
    sql: ${created_at} ;;
  }

  dimension: install_release_version_minor {}
  dimension: current_card {}
  dimension: current_card_no {
    type: number
    sql: @{current_card_numbered} ;;
  }
  dimension: event_name {}
  dimension: country {}
  dimension: extra_json {}
  dimension: platform {}
  dimension: experiments {}
  dimension: experiment_names {}
  dimension: variants {}


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

  dimension: sheet_raw {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.sheet_id") ;;
  }

  dimension: sheet {
    type: string
    sql: @{purchase_iap_strings} ;;
  }

  dimension: source_raw {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json,"$.source_id") ;;
  }

  dimension: source {
    type: string
    sql: @{purchase_source} ;;
  }

  dimension:  currency_spent {
    type: string
    sql: JSON_EXTRACT_SCALAR(transactions.extra_json,"$.transaction_purchase_currency") ;;
  }

  dimension:  currency_spent_amount {
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(transactions.extra_json,"$.transaction_purchase_amount") AS INT64);;
  }

  measure: currency_spent_amount_sum {
    type: sum
    value_format: "#,###"
    sql: ${currency_spent_amount} ;;
    drill_fields: [user_id, source, sheet, currency_spent_amount, currency_spent, iap_purchase_item, iap_purchase_qty]
  }

  measure: currency_spent_amount_sum_per_spender {
    type: number
    value_format: "#,###"
    sql: ${currency_spent_amount_sum} / ${spender_count} ;;
    drill_fields: [user_id, source, sheet, currency_spent_amount, currency_spent, iap_purchase_item, iap_purchase_qty]
  }

  measure: currency_spent_amount_min {
    type: min
    sql: ${currency_spent_amount} ;;
  }

  measure: currency_spent_amount_25th {
    type: percentile
    percentile: 25
    sql: ${currency_spent_amount} ;;
  }

  measure: currency_spent_amount_med {
    type: median
    sql: ${currency_spent_amount} ;;
  }

  measure: currency_spent_amount_75th {
    type: percentile
    percentile: 75
    sql: ${currency_spent_amount} ;;
  }

  measure: currency_spent_amount_max {
    type: max
    sql: ${currency_spent_amount} ;;
  }

  dimension:  iap_id {
    type: string
    sql:  JSON_EXTRACT_SCALAR(transactions.extra_json,"$.iap_id");;
  }

  dimension: iap_purchase_item {
    type: string
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.iap_purchase_item");;
  }

  dimension: iap_purchase_qty {
    type: number
    sql:  JSON_EXTRACT_SCALAR(extra_json,"$.iap_purchase_qty");;
  }

  dimension: transaction_id {
    type: string
    sql: JSON_EXTRACT_SCALAR(extra_json, "$.transaction_id") ;;
  }
}
