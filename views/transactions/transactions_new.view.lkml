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
        ,country --can remove once Will makes user_first_event table
        ,platform --can remove once Will makes user_first_event table
        ,lower(hardware) device_model_number
        ,round(cast(engagement_ticks as int64) / 2) minutes_played
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,json_extract_scalar(extra_json,'$.sheet_id') sheet_raw
        ,json_extract_scalar(extra_json,'$.source_id') soure_raw
        ,json_extract_scalar(extra_json,'$.transaction_purchase_currency') currency_spent
        ,cast(json_extract_scalar(extra_json,'$.transaction_purchase_amount') as int64) currency_spent_amount
        ,json_extract_scalar(extra_json,'$.iap_id') iap_id
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
        and coalesce(install_version,'null') <> '-1'
        and rdg_id not in ('7721b79b-d8c6-4f6a-9ebb-d6afa43daed7','7acaf400-0343-4cb8-be6c-8707dd8d1efa','daf7c573-13dc-41b8-a173-915faf888c71','891b3c15-9451-45d0-a7b8-1459e4252f6c','9a804252-3902-43fb-8cab-9f1876420b5a','8824596a-5182-4287-bcd9-9154c1c70514','891b3c15-9451-45d0-a7b8-1459e4252f6c','ce4e1795-6a2b-4642-94f2-36acc148853e','1c54bae7-da32-4e68-b510-ef6e8c459ac8','c0e75463-850c-4a25-829e-6c6324178622','3f2eddee-3070-4966-8d51-495605ec2352','e4590cf5-244c-425d-bf7e-4ebf0416e9c5','c83b1dc7-24cd-40b8-931f-d73c69c949a9','39786fde-b372-4814-a488-bfb1bf89af8a','7f98585f-34ca-4322-beda-fa4ff51a8721','e699b639-924f-4854-8856-54f3019ecca1','397322b8-1459-4da7-a807-bc0d0404990d')
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
    sql: ${rdg_id} || ${event_name} || ${transaction_raw} ;;
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
  dimension: device_model_number {
    hidden: yes
  }
  ##REMOVE ONCE WILL ADDS USER_FIRST_EVENT TABLE
  dimension: platform {
    hidden: no
    group_label: "Device & OS Dimensions"
    label: "Device Platform"
    type: string
    sql: @{device_platform_mapping} ;;
  }
  dimension: country {
    group_label: "Device & OS Dimensions"
    label: "Device Country"
    type: string
  }
  dimension: region {
    group_label: "Device & OS Dimensions"
    label: "Device Region"
    type: string
    sql: @{country_region} ;;
  }
  ##REMOVE ONCE WILL ADDS USER_FIRST_EVENT TABLE
  dimension: event_name {
    hidden: yes
    type: string
    sql: ${TABLE}.event_name ;;
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
