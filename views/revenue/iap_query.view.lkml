include: "/views/**/events.view"

view: iap_query {
  extends: [events]

  dimension: iap_revenue {
    type: number
    label: "iap revenue"
    description: "the price of the IAP"
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$.transaction_purchase_amount'),'"','') as NUMERIC);;
  }

}
