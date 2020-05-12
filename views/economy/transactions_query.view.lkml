include: "/views/**/events.view"

view: transactions_query {
  extends: [events]

  dimension: gems_spent {
    type: number
    label: "gems spent"
    sql: CASE WHEN REPLACE(JSON_EXTRACT(extra_json,"$.transaction_purchase_currency"),'"','') = "CURRENCY_02" THEN CAST(REPLACE(JSON_EXTRACT(extra_json,"$.transaction_purchase_amount"),'"','') as NUMERIC) END;;
  }

  dimension: coins_spent {
    type: number
    label: "coins spent"
    sql: CASE WHEN REPLACE(JSON_EXTRACT(extra_json,"$.transaction_purchase_currency"),'"','') = "CURRENCY_03" THEN CAST(REPLACE(JSON_EXTRACT(extra_json,"$.transaction_purchase_amount"),'"','') as NUMERIC) END;;
  }

  measure: total_coins_spent {
    type:sum
    label: "total coins spent"
    sql: ${coins_spent} ;;
  }

  measure: total_gems_spent {
    type:sum
    label: "total gems spent"
    sql: ${gems_spent} ;;
  }

}
