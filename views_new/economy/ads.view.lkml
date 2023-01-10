view: ads {
  derived_table: {
    sql:
      select
        rdg_id
        ,user_id
        ,device_id
        ,advertising_id
        ,timestamp
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,"$.impression_id") impression_id
        ,json_extract_scalar(extra_json,"$.line_item_id") line_item_id
        ,json_extract_scalar(extra_json,"$.transaction_currency") transaction_currency
        ,cast(json_extract_scalar(extra_json,"$.publisher_revenue_per_impression") as numeric) publisher_revenue_per_impression
      from game_data.events
      where event_name = 'ad'
      and date(timestamp) between '2023-01-01' and current_date()
      and user_type = 'external'
      and country != 'ZZ'
    ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${ad_event_raw} ;;
  }
  dimension: rdg_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: device_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.device_id ;;
  }
  dimension: advertising_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.advertising_id ;;
  }
  dimension: user_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.user_id ;;
  }
  dimension_group: ad_event {
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
  dimension: impression_id {
    type: string
    sql: ${TABLE}.impression_id  ;;
  }
  measure: impression_count {
    label: "Impression Count"
    type: count_distinct
    sql: ${impression_id} ;;
  }
  dimension: line_item_id {
    type: string
    sql: ${TABLE}.line_item_id  ;;
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
  dimension: publisher_revenue_per_impression {
    label: "Ad Revenue per Impression"
    type: number
    value_format: "$#,##0.00"
    sql: ${TABLE}.publisher_revenue_per_impression ;;
  }
  measure: player_count {
    label: "Unique Players"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: publisher_revenue_sum {
    label: "Total Ad Revenue per Impression"
    type: sum
    value_format: "$#,##0.0000"
    sql: ${publisher_revenue_per_impression} ;;
    #drill_fields: [reward_event_raw,reward_amount_sum]
  }
  measure: revenue_per_impression {
    label: "Ad Revenue per Impression"
    type: number
    value_format: "$#,##0.0000"
    sql: ${publisher_revenue_sum} / ${impression_count} ;;
  }
  measure: revenue_per_ad_viewing_player {
    label: "Ad Revenue per Viewing Player"
    type: number
    value_format: "$#,##0.0000"
    sql: ${publisher_revenue_sum} / ${player_count} ;;
  }
  measure: impressions_per_ad_viewing_player {
    label: "Impressions per Viewing Player"
    type: number
    value_format: "#,##0"
    sql: ${impression_count} / ${player_count} ;;
  }
  # measure: currency_rewarded_amount_025 {
  #   group_label: "Currency Rewards"
  #   label: "Currency Rewards - 2.5%"
  #   type: percentile
  #   percentile: 2.5
  #   sql: ${reward_amount} ;;
  # }
  # measure: currency_rewarded_amount_25th {
  #   group_label: "Currency Rewards"
  #   label: "Currency Rewards - 25%"
  #   type: percentile
  #   percentile: 25
  #   sql: ${reward_amount} ;;
  # }
  # measure: currency_rewarded_amount_med {
  #   group_label: "Currency Rewards"
  #   label: "Currency Rewards - Median"
  #   type: median
  #   sql: ${reward_amount} ;;
  # }
  # measure: currency_rewarded_amount_75th {
  #   group_label: "Currency Rewards"
  #   label: "Currency Rewards - 75%"
  #   type: percentile
  #   percentile: 75
  #   sql: ${reward_amount} ;;
  # }
  # measure: currency_rewarded_amount_975th {
  #   group_label: "Currency Rewards"
  #   label: "Currency Rewards - 97.5%"
  #   type: percentile
  #   percentile: 97.5
  #   sql: ${reward_amount} ;;
  # }
  drill_fields: [rdg_id,ad_event_time,last_level_serial,publisher_revenue_per_impression]
}
