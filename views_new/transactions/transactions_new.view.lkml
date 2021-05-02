view: transactions_new {
  derived_table: {
    sql:
      select
        rdg_id
        ,event_name
        ,timestamp
        ,lower(hardware) device_model_number
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
        and install_version != '-1'
        and rdg_id not in ('daf7c573-13dc-41b8-a173-915faf888c71','891b3c15-9451-45d0-a7b8-1459e4252f6c','9a804252-3902-43fb-8cab-9f1876420b5a','8824596a-5182-4287-bcd9-9154c1c70514','891b3c15-9451-45d0-a7b8-1459e4252f6c','ce4e1795-6a2b-4642-94f2-36acc148853e','1c54bae7-da32-4e68-b510-ef6e8c459ac8','c0e75463-850c-4a25-829e-6c6324178622','3f2eddee-3070-4966-8d51-495605ec2352','e4590cf5-244c-425d-bf7e-4ebf0416e9c5','c83b1dc7-24cd-40b8-931f-d73c69c949a9','39786fde-b372-4814-a488-bfb1bf89af8a','7f98585f-34ca-4322-beda-fa4ff51a8721')
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
  dimension: device_model_number {
    hidden: yes
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
  dimension: current_card_numbered {
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: current_quest {}
  measure: spender_count {
    label: "Unique Spenders"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id, timestamp, iap_id, iap_purchase_item]
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
    drill_fields: [rdg_id, transaction_date_date]
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
