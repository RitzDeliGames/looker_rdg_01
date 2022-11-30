view: transactions_new {
  label: "Transactions"
  derived_table: {
    sql:
      select
        rdg_id
        ,advertising_id
        ,created_at created
        ,datetime(created_at,'US/Pacific') created_pst
        ,event_name
        ,timestamp
        ,engagement_ticks
        ,round(cast(engagement_ticks as int64) / 2) minutes_played
        ,last_level_id
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,'$.sheet_id') sheet_raw
        ,json_extract_scalar(extra_json,'$.source_id') source_raw
        ,if(json_extract_scalar(extra_json,'$.transaction_purchase_currency') like 'more_time_%', 'CURRENCY_02', json_extract_scalar(extra_json,'$.transaction_purchase_currency')) currency_spent --this is a workaround because More Time is not reported correctly
        ,cast(if(json_extract_scalar(extra_json,'$.transaction_purchase_currency') like 'more_time_%','10',json_extract_scalar(extra_json,"$.transaction_purchase_amount")) as int64) currency_spent_amount --see above
        ,if(json_extract_scalar(extra_json,'$.transaction_purchase_currency') like 'more_time_%','item_029',json_extract_scalar(extra_json,'$.iap_id')) iap_id --see above
        ,json_extract_scalar(extra_json,'$.iap_purchase_item') iap_purchase_item
        ,cast(json_extract_scalar(extra_json,'$.iap_purchase_qty') as int64) iap_purchase_qty
        ,json_extract_scalar(extra_json,'$.transaction_id') transaction_id
        ,case
            when extra_json like '%GPA%' then false
            when extra_json like '%AppleAppStore%' then false
          else true end fraud
        ,extra_json
      from game_data.events
      where event_name = 'transaction'
        and user_type = 'external'
        and country != 'ZZ'
        and date(timestamp) between '2022-06-01' and current_date()
        --and coalesce(install_version,'null') <> '-1'
      order by timestamp
    ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
  }
  parameter: spenders_currency_filter {
    suggest_dimension: currency_spent
  }

  dimension: primary_key {
    hidden: no
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${transaction_raw} || ${extra_json} ;;
  }
  dimension: rdg_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: advertising_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.advertising_id ;;
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

  dimension_group: since_created {
    type: duration
    sql_start: ${created_date} ;;
    sql_end: ${transaction_date} ;;
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
  dimension: engagement_ticks {
    hidden: yes
  }
  dimension: minutes_played {
    type: number
  }
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
    sql: ${TABLE}.last_level_id ;;
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
    sql: ${TABLE}.last_level_serial ;;
  }
  dimension: last_level_serial_offset {
    group_label: "Level Dimensions"
    label: "Current Level"
    type: number
    sql: ${last_level_serial} + 1 ;;
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
  dimension:  currency_spent {
    type: string
  }
  dimension:  currency_spent_amount {
    type: number
  }
  measure: dollars_spent_amount_sum { #can this one be deleted?
    label: "Net Revenue"
    type: sum
    value_format: "$#.00"
    sql: if(${currency_spent} = 'CURRENCY_01',(${currency_spent_amount}/100 * .85), 0) ;;
    drill_fields: [rdg_id, transaction_date, transaction_count, iap_id, iap_purchase_item, currency_spent, currency_spent_amount]
  }
  measure: cumulative_dollars_spent {
    group_label: "Cumulative Spend"
    type: running_total
    sql: ${dollars_spent_amount_sum} ;;
    value_format_name: usd
  }
  measure: gem_spent_amount_sum {
    group_label: "Total Spend"
    label: "Total Gems Spent"
    type: sum
    value_format: "#,###"
    sql: if(${currency_spent} = 'CURRENCY_02',${currency_spent_amount}, 0) ;;
    drill_fields: [rdg_id, transaction_date, transaction_count, iap_id, iap_purchase_item, currency_spent, currency_spent_amount]
  }
  measure: cumulative_gems_spent {
    group_label: "Cumulative Spend"
    type: running_total
    sql: ${gem_spent_amount_sum} ;;
    value_format: "#,###"
  }
  measure: coin_spent_amount_sum {
    group_label: "Total Spend"
    label: "Total Coins Spent"
    type: sum
    value_format: "#,###"
    sql: if(${currency_spent} = 'CURRENCY_03',${currency_spent_amount}, 0) ;;
    drill_fields: [rdg_id, transaction_date, transaction_count, iap_id, iap_purchase_item, currency_spent, currency_spent_amount]
  }
  measure: cumulative_coins_spent {
    group_label: "Cumulative Spend"
    type: running_total
    sql: ${coin_spent_amount_sum} ;;
    value_format: "#,###"
  }
  measure: afh_token_spent_amount_sum {
    group_label: "Total Spend"
    label: "Total AFH Spent"
    type: sum
    value_format: "#,###"
    sql: if(${currency_spent} = 'CURRENCY_05',${currency_spent_amount}, 0) ;;
    drill_fields: [rdg_id, transaction_date, transaction_count, iap_id, iap_purchase_item, currency_spent, currency_spent_amount]
  }
  measure: cumulative_afh_token_spent {
    group_label: "Cumulative Spend"
    type: running_total
    sql: ${afh_token_spent_amount_sum} ;;
    value_format: "#,###"
  }
  measure: star_spent_amount_sum {
    group_label: "Total Spend"
    label: "Total Stars Spent"
    type: sum
    value_format: "#,###"
    sql: if(${currency_spent} = 'CURRENCY_07',${currency_spent_amount}, 0) ;;
    drill_fields: [rdg_id, transaction_date, transaction_count, iap_id, iap_purchase_item, currency_spent, currency_spent_amount]
  }
  measure: cumulative_stars_spent {
    group_label: "Cumulative Spend"
    type: running_total
    sql: ${star_spent_amount_sum} ;;
    value_format: "#,###"
  }
  measure: currency_spent_amount_sum {
    group_label: "Total Spend"
    label: "Total Net Dollars Spent"
    type: sum
    value_format: "$#,###"
    sql: if(${currency_spent} = 'CURRENCY_01',(${currency_spent_amount}/100 * .85), 0) ;;
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
    drill_fields: [rdg_id,currency_spent,currency_spent_amount,transaction_date]
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
  dimension: iap_id_strings_grouped {
    label: "IAP Names (Grouped)"
    sql: @{iap_id_strings_grouped} ;;
  }
  dimension: iap_purchase_item {}
  dimension: iap_purchase_qty {
    type: number
  }
  dimension: transaction_id {}
  dimension: extra_json {
    type: string
  }
  dimension: fraud {
    type: yesno
    sql: ${TABLE}.fraud ;;
  }
  measure: total_minutes_played {
    type: sum
    sql: ${minutes_played} ;;
  }
  measure: cumulative_minutes_played {
    type: running_total
    sql: ${total_minutes_played} ;;
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
    drill_fields: [rdg_id,created_date,created_pst_date,iap_id_strings]
  }
  measure: total_currency_spent_amount {
    label: "Sum of All Currencies Spent - Use Only with Currency_Spent filtered"
    type: sum
    sql: ${currency_spent_amount} ;;
    drill_fields: [rdg_id,currency_spent,currency_spent_amount,transaction_date]
  }
  measure: cumulative_total_currency_spent_amount {
    type: running_total
    sql: ${total_currency_spent_amount} ;;
  }

  set: cohort_set {
    fields: [
    transaction_date,
    days_since_created,
    weeks_since_created,
    minutes_played,
    rdg_id,
    transaction_count,
    iap_id,
    iap_purchase_item,
    currency_spent,
    currency_spent_amount,
    total_currency_spent_amount,
    extra_json
    ]
  }

}
