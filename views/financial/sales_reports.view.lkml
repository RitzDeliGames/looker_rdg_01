view: sales_reports {
  sql_table_name: `eraser-blast.analytics.sales_reports` ;;

  dimension: base_plan_id {
    type: string
    sql: ${TABLE}.base_plan_id ;;
  }
  dimension: charged_amount {
    label: "Amount Charged"
    type: number
    sql: ${TABLE}.charged_amount ;;
  }
  dimension: city_of_buyer {
    label: "City"
    type: string
    sql: ${TABLE}.city_of_buyer ;;
  }
  dimension: country_of_buyer {
    label: "Country"
    type: string
    sql: ${TABLE}.country_of_buyer ;;
  }
  dimension: coupon_value {
    type: string
    sql: ${TABLE}.coupon_value ;;
  }
  dimension: currency_of_sale {
    label: "Local Currency"
    type: string
    sql: ${TABLE}.currency_of_sale ;;
  }
  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
  }
  dimension: discount_rate {
    type: number
    sql: ${TABLE}.discount_rate ;;
  }
  dimension: featured_product_id {
    type: string
    sql: ${TABLE}.featured_product_id ;;
  }
  dimension: financial_status {
    type: string
    sql: ${TABLE}.financial_status ;;
  }
  dimension: first_usd_1m_eligible {
    type: string
    sql: ${TABLE}.first_usd_1m_eligible ;;
  }
  dimension: group_id {
    type: string
    sql: ${TABLE}.group_id ;;
  }
  dimension: item_price {
    type: number
    sql: ${TABLE}.item_price ;;
  }
  dimension: offer_id {
    type: string
    sql: ${TABLE}.offer_id ;;
  }
  dimension_group: order_charged {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.order_charged_date ;;
  }
  dimension: order_charged_timestamp {
    type: string
    sql: ${TABLE}.order_charged_timestamp ;;
  }
  dimension: order_number {
    type: string
    sql: ${TABLE}.order_number ;;
  }
  dimension: postal_code_of_buyer {
    type: string
    sql: ${TABLE}.postal_code_of_buyer ;;
  }
  dimension: price_experiment_id {
    type: string
    sql: ${TABLE}.price_experiment_id ;;
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
  dimension: sku_id {
    type: string
    sql: ${TABLE}.sku_id ;;
  }
  dimension: state_of_buyer {
    type: string
    sql: ${TABLE}.state_of_buyer ;;
  }
  dimension: taxes_collected {
    type: number
    sql: ${TABLE}.taxes_collected ;;
  }
  measure: count {
    type: count
  }

  measure: charged_amount_sum {
    label: "Gross Revenue"
    description: "Item price, before taxes and before app store fees"
    type: sum
    value_format_name: usd_0
    sql: ${charged_amount} ;;
  }
}
