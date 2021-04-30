view: transactions_new {
  derived_table: {
    sql:
      select
        rdg_id
        ,event_name
        ,timestamp
        ,cast(ltv as int64) / 100 ltv
        ,round(cast(engagement_ticks as int64) / 2) minutes_played
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,json_extract_scalar(extra_json,'$.sheet_id') sheet_raw
        ,json_extract_scalar(extra_json,'$.source_id') soure_raw
        ,json_extract_scalar(extra_json,'$.transaction_purchase_currency') currency_spent
        ,cast(json_extract_scalar(extra_json,'$.transaction_purchase_amount') as int64) currency_spent_amount
        ,json_extract_scalar(extra_json,'$.iap_id') iap_id
        ,json_extract_scalar(extra_json,'$.iap_purchase_item') iap_purchase_item
        ,cast(json_extract_scalar(extra_json,'$.iap_purchase_qty') as int64) iap_purchase_qty
        ,json_extract_scalar(extra_json,'$.transaction_id') transaction_id
        ,extra_json
      from game_data.events
      where event_name = 'transaction'
        and user_type = 'external'
        and country != 'ZZ'
    ;;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${event_name} || ${timestamp} ;;
  }
  dimension: rdg_id {
    hidden: no
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: event_name {
    hidden: yes
    type: string
    sql: ${TABLE}.event_name ;;
  }
  dimension: timestamp {
    hidden: yes
    type: date_time
    sql: ${TABLE}.timestamp ;;
  }
  dimension_group: transaction_date {
    type: time
    timeframes: [
      date,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp  ;;
  }
  dimension: minutes_played {
    type: number
  }
  dimension: current_card {
    hidden: yes
  }
  dimension: last_unlocked_card {
    hidden: yes
  }
  dimension: card_id {
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_quest {}
  measure: spender_count {
    label: "Unique Spenders"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  dimension: sheet_raw {}
  dimension: sheet {
    type: string
    sql: @{purchase_iap_strings} ;;
  }
  dimension: source_raw {}
  dimension: source {
    type: string
    sql: @{purchase_source} ;;
  }
  dimension:  currency_spent {}
  dimension:  currency_spent_amount {
    type: number
  }
  measure: currency_spent_amount_sum {
    label: "Currency Spent - Sum"
    type: sum
    value_format: "#,###"
    sql: if(${currency_spent} = 'CURRENCY_01', ${currency_spent_amount}/100, ${currency_spent_amount}) ;;
  }
  measure: currency_spent_amount_sum_per_spender {
    label: "Currency Spent - Transaction Amount"
    type: number
    value_format: "#,###"
    sql: ${currency_spent_amount_sum} / ${spender_count} ;;
  }
  measure: currency_spent_amount_025 {
    group_label: "Currency Spent"
    label: "Currency Spent - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_spent_amount} ;;
  }
  measure: currency_spent_amount_25th {
    group_label: "Currency Spent"
    label: "Currency Spent - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_spent_amount} ;;
  }
  measure: currency_spent_amount_med {
    group_label: "Currency Spent"
    label: "Currency Spent - Median"
    type: median
    sql: ${currency_spent_amount} ;;
  }
  measure: currency_spent_amount_75th {
    group_label: "Currency Spent"
    label: "Currency Spent - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_spent_amount} ;;
  }
  measure: currency_spent_amount_max {
    group_label: "Currency Spent"
    label: "Currency Spent - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_spent_amount} ;;
  }
  dimension:  iap_id {}
  dimension: iap_purchase_item {}
  dimension: iap_purchase_qty {
    type: number
  }
  dimension: transaction_id {}
  dimension: extra_json {}
  dimension: fraud {
    type: string
    sql: if(${extra_json} like '%GPA%','no','yes');;
  }
  dimension: ltv {}
  measure: ltv_sum {
    label: "LTV"
    type: max
    sql: ${ltv} ;;
  }
}
