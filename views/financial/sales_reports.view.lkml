view: sales_reports {
  derived_table: {
    sql:
      with sales_data as (
        select
          *
        from `eraser-blast.analytics.sales_reports`
      ),

      currency_exchange_data as (
        select
          date as rdg_date
          ,currency_exchange as country_currency_code
          ,safe_divide(1, max(exchange_rate)) as exchange_rate
        from
          `eraser-blast.analytics.currency_exchange`
        where
          currency_exchange is not null
        group by 1,2
      )

      select
        sales_data.*
        ,currency_exchange_data.country_currency_code
        ,currency_exchange_data.exchange_rate
        ,(currency_exchange_data.exchange_rate * sales_data.charged_amount) charged_amount_usd
      from sales_data
      left join currency_exchange_data
        on currency_exchange_data.country_currency_code = sales_data.currency_of_sale
        and currency_exchange_data.rdg_date = sales_data.order_charged_date
    ;;
  }

  dimension: base_plan_id {
    type: string
    sql: ${TABLE}.base_plan_id ;;
  }
  dimension: charged_amount {
    label: "Amount Charged (Local)"
    type: number
    sql: ${TABLE}.charged_amount ;;
  }
  dimension: charged_amount_usd {
    label: "Amount Charged (USD)"
    type: number
    sql: ${TABLE}.charged_amount_usd;;
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
  dimension: country_currency_code {
    label: "Currency Code"
    type: string
    sql: ${TABLE}.country_currency_code ;;
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
  dimension: exchange_rate {
    type: number
    sql: ${TABLE}.exchange_rate ;;
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
    value_format:"$#,###"
    sql: ${charged_amount_usd} ;;
  }

  measure: charged_amount_sum_net {
    label: "Estimate Net Revenue - 30%"
    description: "Estimated Net Revenue based on 30% commission"
    type: sum
    value_format:"$#,###"
    sql: ${charged_amount_usd} * 0.70;;
  }

  measure: charged_amount_sum_net_15 {
    label: "Estimate Net Revenue - 15%"
    description: "Estimated Net Revenue based on 30% commission"
    type: sum
    value_format:"$#,###"
    sql: ${charged_amount_usd} * 0.85;;
  }
}
