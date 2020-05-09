include: "events.view"

view: transactions {
  extends: [events]

  dimension: transaction_currency {
    type: string
    label: "transaction currency"
    description: "currency the IAP is priced in"
    sql: REPLACE(JSON_EXTRACT(${extra_json},'$.transaction_purchase_currency'),'"','') ;;
  }

  dimension: transaction_price {
    type: number
    label: "transaction price"
    description: "the price of the IAP"
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$."transaction_purchase_amount"'),'"','') as NUMERIC);;
  }

  dimension: iap_revenue {
    type: number
    label: "iap revenue"
    description: "real money transactions as reported by Big Query"
    #sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$."transaction_purchase_amount"'),'"','') as NUMERIC) WHERE REPLACE(JSON_EXTRACT(extra_json,"$.transaction_purchase_currency"),'"','') = "CURRENCY_01";;
    sql: CASE WHEN REPLACE(JSON_EXTRACT(${extra_json},"$.transaction_purchase_currency"),'"','') = "CURRENCY_01" THEN CAST(REPLACE(TRIM(JSON_EXTRACT(extra_json,"$.transaction_purchase_amount"),'"'),'.','') as NUMERIC) END AS gaming_block_events_iap_revenue ;;
  }

}
