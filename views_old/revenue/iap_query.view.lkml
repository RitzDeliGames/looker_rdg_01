include: "/views/**/events.view"

view: iap_query {
  extends: [events]

  dimension: is_real_money {
    type: yesno
    sql:JSON_EXTRACT(extra_json,"$.transaction_id") IS NOT NULL  ;;
  }

  dimension: iap_transaction_id {
    type: string
    label: "iap transaction id"
    description: "id for real money transactions as reported by Big Query"
    sql: CASE WHEN ${is_real_money} THEN REPLACE(JSON_EXTRACT(gaming_block_events.extra_json,"$.transaction_id"),'"','') END;;
  }

  dimension: iap_revenue {
    type: number
    value_format_name: usd
    label: "iap revenue"
    description: "real money transactions as reported by Big Query"
    sql: CASE WHEN ${is_real_money} THEN CAST(REPLACE(JSON_EXTRACT(gaming_block_events.extra_json,"$.transaction_purchase_amount"),'"','') as NUMERIC) / 100 END;;
  }

  measure: sum_of_iap_revenue {
    type: sum
    label: "total iap revenue"
    description: "sum of iap revenue"
    sql: ${iap_revenue} ;;
  }

}
