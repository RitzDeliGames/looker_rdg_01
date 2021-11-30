view: cohort_analysis_mixed_fields {
  dimension: cohort_analysis_pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${transactions_new.primary_key} ;;
  }
  measure: gem_spend_per_user {
    label: "Cohorted Gem Spend per Player"
    type: number
    sql: ${transactions_new.gem_spent_amount_sum} / NULLIF(${cohort_analysis.count},0) ;;
    value_format_name: decimal_2
    drill_fields: [transactions_new.rdg_id, transactions_new.transaction_date, transactions_new.transaction_count, transactions_new.iap_id, transactions_new.iap_purchase_item, transactions_new.currency_spent, transactions_new.currency_spent_amount]
  }
  measure: cumulative_gem_spend_per_user {
    type: running_total
    sql: ${gem_spend_per_user} ;;
    value_format_name: decimal_2
    drill_fields: [transactions_new.rdg_id, transactions_new.transaction_date, transactions_new.transaction_count, transactions_new.iap_id, transactions_new.iap_purchase_item, transactions_new.currency_spent, transactions_new.currency_spent_amount]
  }
  measure: coin_spend_per_user {
    label: "Cohorted Coin Spend per Player"
    type: number
    sql: ${transactions_new.coin_spent_amount_sum} / NULLIF(${cohort_analysis.count},0) ;;
    value_format_name: decimal_2
    drill_fields: [transactions_new.rdg_id, transactions_new.transaction_date, transactions_new.transaction_count, transactions_new.iap_id, transactions_new.iap_purchase_item, transactions_new.currency_spent, transactions_new.currency_spent_amount]
  }
  measure: cumulative_coin_spend_per_user {
    type: running_total
    sql: ${coin_spend_per_user} ;;
    value_format_name: decimal_2
    drill_fields: [transactions_new.rdg_id, transactions_new.transaction_date, transactions_new.transaction_count, transactions_new.iap_id, transactions_new.iap_purchase_item, transactions_new.currency_spent, transactions_new.currency_spent_amount]
  }
  measure: dollar_spend_per_user {
    label: "Cohorted Dollar Spend per Player"
    type: number
    sql: ${transactions_new.dollars_spent_amount_sum} / NULLIF(${cohort_analysis.count},0) ;;
    value_format: "$0.0000"
    drill_fields: [detail*]
  }
  measure: cumulative_dollar_spend_per_user {
    type: running_total
    sql: ${dollar_spend_per_user} ;;
    value_format: "$0.0000"
    drill_fields: [detail*]
  }
  measure: currency_spend_per_user {
    type: number
    sql: ${transactions_new.total_currency_spent_amount} / NULLIF(${cohort_analysis.count},0) ;;
    drill_fields: [detail*]
  }
  set: detail {
    fields: [
    transactions_new.transaction_date,
    transactions_new.days_since_created,
    transactions_new.weeks_since_created,
    transactions_new.minutes_played,
    transactions_new.rdg_id,
    transactions_new.transaction_count,
    transactions_new.iap_id,
    transactions_new.iap_purchase_item,
    transactions_new.currency_spent,
    transactions_new.currency_spent_amount,
    transactions_new.total_currency_spent_amount,
    transactions_new.extra_json
    ]
  }
}
