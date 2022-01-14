# Purpose: To allow the user to enter criteria to choose the cohort for analysis. These controls should be primarily used for filters

view: cohort_selection {
  derived_table: {
    explore_source: user_retention {
      column: rdg_id {}
      column: currency_spent { field: transactions_new.currency_spent }
      column: total_currency_spent_amount { field: transactions_new.total_currency_spent_amount }
      column: first_created_date {}
    }
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
  }
  dimension: rdg_id {
    primary_key: yes
    label: "Users Rdg ID"
  }
  dimension: currency_spent {
    label: "Transactions Currency Spent"
  }
  dimension: total_currency_spent_amount {
    label: "Transactions Sum of All Currencies Spent - Use Only with Currency_Spent filtered"
    type: number
  }
  dimension: first_created_date {
    label: "Users Created Date"
    type: date
  }
  measure: count_users {
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: count {
    type: count
  }
  set: cohort_set {
    fields: [
      first_created_date,
      count
    ]
  }
}
