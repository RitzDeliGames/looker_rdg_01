# view: lifetime_spend_basis {
#   derived_table: {
#     explore_source: transactions {
#       column: rdg_id {}
#       column: currency_spent {}
#       column: currency_spent_amount {}
#     }
#   }
#   parameter: spenders_currency_filter {
#     suggest_dimension: currency_spent
#   }
#   dimension: compound_primary_key {
#     primary_key: yes
#     type: string
#     sql: ${rdg_id} || '_' || ${currency_spent} ;;
#   }
#   dimension: rdg_id {}
#   dimension: currency_spent {}
#   dimension: currency_spent_amount {
#     label: "Currency Spent Amount"
#     value_format: "#,###"
#     type: number
#   }
# # Filters currency_spent_amount based on to the selected currency_spent in spenders_currency_filters
#   measure: filtered_lifetime_currency_spent_amount {
#     type: sum
#     sql:
#       CASE
#         WHEN ${currency_spent} = {% parameter spenders_currency_filter %}
#         THEN ${currency_spent_amount}
#         ELSE 0
#       END ;;
#   }
#   # Creates yesno flag to indicate if user ever spent the selected_currency in spenders_currency_filter
#   measure: is_filtered_currency_spender {
#     type: yesno
#     sql: ${filtered_lifetime_currency_spent_amount} > 0 ;;
#   }
# }
