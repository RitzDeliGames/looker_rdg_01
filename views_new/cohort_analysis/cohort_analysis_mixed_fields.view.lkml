view: cohort_analysis_mixed_fields {
  dimension: cohort_analysis_pk {
    type: string
    primary_key: yes
    sql: ${transactions_new.primary_key} ;;
  }
  measure: gem_spend_per_user {
    type: number
    sql: ${transactions_new.gem_spent_amount_sum} / NULLIF(${cohort_analysis.count},0) ;;
    value_format_name: decimal_2
  }
  measure: cumulative_gem_spend_per_user {
    type: running_total
    sql: ${gem_spend_per_user} ;;
    value_format_name: decimal_2
  }
  measure: coin_spend_per_user {
    type: number
    sql: ${transactions_new.coin_spent_amount_sum} / NULLIF(${cohort_analysis.count},0) ;;
    value_format_name: decimal_2
  }
  measure: cumulative_coin_spend_per_user {
    type: running_total
    sql: ${coin_spend_per_user} ;;
    value_format_name: decimal_2
  }
  measure: dollar_spend_per_user {
    type: number
    sql: ${transactions_new.dollars_spent_amount_sum} / NULLIF(${cohort_analysis.count},0) ;;
    value_format_name: usd
  }
  measure: cumulative_dollar_spend_per_user {
    type: running_total
    sql: ${dollar_spend_per_user} ;;
    value_format_name: usd
  }
}
