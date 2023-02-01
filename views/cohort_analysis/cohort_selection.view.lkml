# Purpose: To allow the user to enter criteria to choose the cohort for analysis. These controls should be primarily used for filters

view: cohort_selection {
  derived_table: {
    explore_source: user_retention {
      column: rdg_id {}
      column: install_version {}
      column: country {}
      column: region {}
      column: install_version {}
      column: version {}
      column: currency_spent { field: transactions_new.currency_spent }
      column: total_currency_spent_amount { field: transactions_new.total_currency_spent_amount }
      column: first_created_date {}
    }
    datagroup_trigger: change_6_hrs
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
  dimension: country {
    group_label: "Device & OS Dimensions"
    label: "Device Country"
  }
  dimension: region {
    group_label: "Device & OS Dimensions"
    label: "Device Region"
  }
  dimension: version {
    group_label: "Version Dimensions"
    label: "Release Version"
    value_format: "0"
    type: number
  }
  dimension: install_version {
    group_label: "Version Dimensions"
    label: "Install Version"
    type: number
    value_format: "0"
  }
  measure: count_users {
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id,first_created_date]
  }
  measure: count {
    type: count
    drill_fields: [rdg_id,first_created_date]
  }
  set: cohort_set {
    fields: [
      first_created_date,
      count
    ]
  }
}
