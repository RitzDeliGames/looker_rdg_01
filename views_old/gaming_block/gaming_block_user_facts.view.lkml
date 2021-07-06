#This is a native derived table created using this query:

view: gaming_block_user_facts {
  derived_table: {
    explore_source: gaming_block_events {
      column: user_id {}
      column: total_d1_revenue {}
      column: total_d7_revenue {}
      column: total_d14_revenue {}
      column: total_d30_revenue {}
      column: total_revenue {}
      column: total_iap_revenue {}
      column: total_revenue_after_UA {}
      column: number_of_sessions { field: gaming_block_session_facts.number_of_sessions }
      column: cost_per_install {}
      column: d1_retained_users {}
      column: d7_retained_users {}
      column: d14_retained_users {}
      column: d30_retained_users {}
      column: player_first_seen {}
      column: player_last_seen {}
      filters: {
        field: gaming_block_events.event_date
        value: ""
      }
    }
    datagroup_trigger: events_raw
    partition_keys: ["player_first_seen"]
  }
  dimension: user_id {
    primary_key: yes
  }
  dimension: total_d1_revenue {
    group_label: "LTV"
    label: "D1_LTV"
    description: "Revenue (ads + IAP) on day 1"
    value_format_name: usd
    type: number
  }
  dimension: total_d7_revenue {
    group_label: "LTV"
    label: "D7_LTV"
    description: "Revenue (ads + IAP) on day 7"
    value_format_name: usd
    type: number
  }
  dimension: total_d14_revenue {
    group_label: "LTV"
    label: "D14_LTV"
    description: "Revenue (ads + IAP) on day 14"
    value_format_name: usd
    type: number
  }
  dimension: total_d30_revenue {
    group_label: "LTV"
    label: "D30_LTV"
    description: "Revenue (ads + IAP) on day 30"
    value_format_name: usd
    type: number
  }
  dimension: total_revenue {
    group_label: "LTV"
    label: "total_ltv"
    description: "IAP + Ad Revenue"
    value_format_name: usd
    type: number
  }
  dimension: total_iap_revenue {
    group_label: "LTV"
    label: "Total IAP Revenue"
    description: "Total Revenue from In-App Purchases"
    value_format_name: usd
    type: number
  }
  dimension: total_revenue_after_UA {
    group_label: "LTV"
    label: "LTV Revenue After UA"
    description: "Revenue - Marketing Spend"
    value_format_name: usd
    type: number
  }
  dimension: number_of_sessions {
    label: "Lifetime Sessions"
    type: number
  }
  dimension: cost_per_install {
    value_format_name: usd
    type: number
  }
  dimension: d1_retained_users {
    group_label: "Retention"
    label: "D1 Retained"
    type: yesno
    description: "Number of players that came back to play on day 1"
    sql: CAST(${TABLE}.d1_retained_users as bool) ;;
  }
  dimension: d7_retained_users {
    group_label: "Retention"
    label: "D7 Retained"
    description: "Number of players that came back to play on day 7"
    type: yesno
    sql: CAST(${TABLE}.d7_retained_users as bool) ;;
  }
  dimension: d14_retained_users {
    group_label: "Retention"
    label: "D14 Retained"
    description: "Number of players that came back to play on day 14"
    type: yesno
    sql: CAST(${TABLE}.d14_retained_users as bool) ;;
  }
  dimension: d30_retained_users {
    group_label: "Retention"
    label: "D30 Retained"
    description: "Number of players that came back to play on day 30"
    type: yesno
    sql: CAST(${TABLE}.d30_retained_users as bool) ;;
  }
  dimension: player_first_seen {
    description: "Not for direct use, use for NDT"
    type: date_time
  }
  dimension: player_last_seen {
    description: "Not for direct use, use for NDT"
    type: date_time
  }

  dimension_group: since_last_seen {
    intervals: [day,hour,week,month]
    type: duration
    sql_start: ${player_last_seen} ;;
    sql_end: CURRENT_TIMESTAMP ;;
  }
  dimension_group: since_first_seen {
    type: duration
    intervals: [day,hour,week,month]
    sql_start: ${player_first_seen} ;;
    sql_end: CURRENT_TIMESTAMP ;;
  }

  measure: number_of_users {
    type: count
  }
}
