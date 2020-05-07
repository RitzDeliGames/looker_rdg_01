include: "events.view"

view: transaction {
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

}
