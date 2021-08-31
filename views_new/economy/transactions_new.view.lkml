view: transactions_new {
  label: "Transactions"
  derived_table: {
    sql:
      select
        rdg_id
        ,created_at created
        ,datetime(created_at,'US/Pacific') created_pst
        ,event_name
        ,timestamp
        ,round(cast(engagement_ticks as int64) / 2) minutes_played
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,json_extract_scalar(extra_json,'$.sheet_id') sheet_raw
        ,json_extract_scalar(extra_json,'$.source_id') source_raw
        ,if(json_extract_scalar(extra_json,'$.transaction_purchase_currency') like 'more_time_%', 'CURRENCY_02', json_extract_scalar(extra_json,'$.transaction_purchase_currency')) currency_spent --this is a workaround because More Time is not reported correctly
        ,cast(if(json_extract_scalar(extra_json,'$.transaction_purchase_currency') like 'more_time_%','10',json_extract_scalar(extra_json,"$.transaction_purchase_amount")) as int64) currency_spent_amount --see above
        ,if(json_extract_scalar(extra_json,'$.transaction_purchase_currency') like 'more_time_%','item_029',json_extract_scalar(extra_json,'$.iap_id')) iap_id --see above
        ,json_extract_scalar(extra_json,'$.iap_purchase_item') iap_purchase_item
        ,cast(json_extract_scalar(extra_json,'$.iap_purchase_qty') as int64) iap_purchase_qty
        ,json_extract_scalar(extra_json,'$.transaction_id') transaction_id
        ,case when extra_json like '%GPA%' then false else true end fraud
        ,extra_json
      from game_data.events
      where event_name = 'transaction'
        and user_type = 'external'
        and country != 'ZZ'
        and timestamp >= '2019-01-01'
        --and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
  }
  filter: spenders_currency_filter {
    suggest_dimension: currency_spent
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${transaction_raw} ;;
  }
  dimension: rdg_id {
    hidden: no
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [
      time,
      hour_of_day,
      date,
      month,
      year
    ]
  }
  dimension_group: created_pst {
    group_label: "Created Date - PST"
    datatype: datetime
    type: time
    timeframes: [
      time
      ,date
      ,month
      ,year
    ]
  }
  dimension_group: transaction {
    type: time
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,quarter
      ,year
    ]
    sql: ${TABLE}.timestamp  ;;
  }
  dimension_group: transaction_pst {
    type: time
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,quarter
      ,year
    ]
    sql: datetime(${TABLE}.timestamp,'US/Pacific') ;;
  }
  dimension: minutes_played {
    type: number
  }
  dimension: current_card {
    group_label: "Card Dimensions"
    label: "Player Current Card"
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    label: "Player Current Card (Numbered)"
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: last_unlocked_card {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card"
  }
  dimension: last_unlocked_card_numbered {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card (Numbered)"
    type: number
    sql: @{last_unlocked_card_numbered} ;;
    value_format: "####"
  }
  dimension: card_id { #change this dimension name but check for dependencies first!
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card (Coalesced)"
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_quest {
    group_label: "Card Dimensions"
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: sheet_raw {}
  dimension: sheet {
    type: string
    sql: @{purchase_iap_strings} ;;
  }
  dimension: source_raw {}
  dimension: source {
    type: string
    sql: @{purchase_source} ;;
  }
  dimension:  currency_spent {}
  dimension:  currency_spent_amount {
    type: number
  }
  measure: dollars_spent_amount_sum {
    label: "Net Revenue"
    type: sum
    value_format: "$#.00"
    sql: if(${currency_spent} = 'CURRENCY_01',(${currency_spent_amount}/100 * .85), 0) ;;
    drill_fields: [rdg_id, transaction_date, transaction_count, iap_id, iap_purchase_item, currency_spent, currency_spent_amount]
  }
  measure: currency_spent_amount_sum {
    label: "Total Currency Spent"
    type: sum
    value_format: "#,###"
    sql: if(${currency_spent} = 'CURRENCY_01',0,${currency_spent_amount}) ;;
    drill_fields: [rdg_id, transaction_date, transaction_count, iap_id, iap_purchase_item, currency_spent, currency_spent_amount]
  }
  measure: spender_count {
    label: "Unique Spenders"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id, transaction_date, iap_id, iap_purchase_item, iap_id]
  }
  measure: currency_spent_amount_sum_per_spender {
    label: "Avg. Transaction Size"
    type: number
    value_format: "#,###"
    sql: ${currency_spent_amount_sum} / ${spender_count} ;;
  }
  ## don't need count distinct here, the count will do that with the primary key and aggregate awareness
  measure: transaction_count {
    type: count
  }
  measure: transactions_per_spender {
    label: "Transactions per Spender"
    type: number
    sql: ${transaction_count} / ${spender_count} ;;
  }
  measure: currency_spent_amount_025 {
    group_label: "Currency Spent"
    label: "Currency Spent - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_spent_amount} ;;
  }
  measure: currency_spent_amount_25th {
    group_label: "Currency Spent"
    label: "Currency Spent - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_spent_amount} ;;
  }
  measure: currency_spent_amount_med {
    group_label: "Currency Spent"
    label: "Currency Spent - Median"
    type: median
    sql: ${currency_spent_amount} ;;
  }
  measure: currency_spent_amount_75th {
    group_label: "Currency Spent"
    label: "Currency Spent - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_spent_amount} ;;
  }
  measure: currency_spent_amount_max {
    group_label: "Currency Spent"
    label: "Currency Spent - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_spent_amount} ;;
  }
  dimension:  iap_id {}
  dimension: iap_id_strings {
    label: "IAP Names"
    sql: @{iap_id_strings} ;;
  }
  dimension: iap_purchase_item {}
  dimension: iap_purchase_qty {
    type: number
  }
  dimension: transaction_id {}
  dimension: extra_json {}
  dimension: fraud {
    type: yesno
    sql: ${TABLE}.fraud ;;
  }
  measure: spenders {
    type: count_distinct
    sql:
      case
        when
          {% condition spenders_currency_filter %} ${currency_spent} {% endcondition %}
        then ${rdg_id}
      end
    ;;
    drill_fields: [rdg_id, created_date, created_pst_date]
  }
}
