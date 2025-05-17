view: earnings_reports {
  sql_table_name: `eraser-blast.analytics.earnings_reports` ;;

  dimension: amount_buyer_currency {
    type: number
    sql: ${TABLE}.amount_buyer_currency ;;
  }
  dimension: amount_merchant_currency {
    type: number
    sql: ${TABLE}.amount_merchant_currency ;;
  }
  dimension: base_plan_id {
    type: string
    sql: ${TABLE}.base_plan_id ;;
  }
  dimension: buyer_country {
    type: string
    sql: ${TABLE}.buyer_country ;;
  }
  dimension: buyer_currency {
    type: string
    sql: ${TABLE}.buyer_currency ;;
  }
  dimension: buyer_postal_code {
    type: string
    sql: ${TABLE}.buyer_postal_code ;;
  }
  dimension: buyer_state {
    type: string
    sql: ${TABLE}.buyer_state ;;
  }
  dimension: currency_conversion_rate {
    type: number
    sql: ${TABLE}.currency_conversion_rate ;;
  }
  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
  dimension: fee_description {
    type: string
    sql: ${TABLE}.fee_description ;;
  }
  dimension: first_usd_1m_eligible {
    type: string
    sql: ${TABLE}.first_usd_1m_eligible ;;
  }
  dimension: group_id {
    type: string
    sql: ${TABLE}.group_id ;;
  }
  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
  }
  dimension: merchant_currency {
    type: string
    sql: ${TABLE}.merchant_currency ;;
  }
  dimension: offer_id {
    type: string
    sql: ${TABLE}.offer_id ;;
  }
  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }
  dimension: product_title {
    type: string
    sql: ${TABLE}.product_title ;;
  }
  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
  }
  dimension: promotion_id {
    type: string
    sql: ${TABLE}.promotion_id ;;
  }
  dimension: refund_type {
    type: string
    sql: ${TABLE}.refund_type ;;
  }
  dimension: service_fee_percent {
    type: number
    sql: ${TABLE}.service_fee_percent ;;
  }
  dimension: sku_id {
    type: string
    sql: ${TABLE}.sku_id ;;
  }
  dimension: tax_type {
    type: string
    sql: ${TABLE}.tax_type ;;
  }
  dimension_group: transaction_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.transaction_date ;;
  }
  dimension: transaction_time {
    type: string
    sql: ${TABLE}.transaction_time ;;
  }
  dimension: transaction_type {
    type: string
    sql: ${TABLE}.transaction_type ;;
  }
  measure: count {
    type: count
  }

  measure: amount_merchant_currency_sum {
    description: "Transaction revenue, before taxes and before app store fees"
    label: "Gross Revenue"
    type: sum
    value_format_name: usd_0
    sql: ${TABLE}.amount_merchant_currency ;;
  }
}
