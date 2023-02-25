view: ads {
  derived_table: {
    sql:
      select
        rdg_id
        ,user_id
        ,device_id
        ,advertising_id
        ,timestamp
        ,created_at created
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,"$.transaction_currency") transaction_currency
        ,json_extract_scalar(extra_json,"$.ad_network") ad_network
        ,json_extract_scalar(extra_json,"$.placement") placement
        ,json_extract_scalar(extra_json,"$.auction_id") auction_id
        ,cast(json_extract_scalar(extra_json,"$.ad_value") as numeric) ad_value
        ,json_extract_scalar(extra_json,"$.ad_source_name") ad_source_name --old Unity mediation parameter...eventually can be deprecated
        ,json_extract_scalar(extra_json,"$.ad_unit_name") ad_unit_name --old Unity mediation parameter...eventually can be deprecated
        ,json_extract_scalar(extra_json,"$.impression_id") impression_id
        ,json_extract_scalar(extra_json,"$.line_item_id") line_item_id
        ,cast(json_extract_scalar(extra_json,"$.publisher_revenue_per_impression") as numeric) publisher_revenue_per_impression --old Unity mediation parameter...eventually can be deprecated
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
  dimension_group: since_created {
    type: duration
    sql_start: ${created_date} ;;
    sql_end: ${ad_event_date} ;;
  }
  dimension: ad_network {
    group_label: "Networks"
    type: string
    sql: ${TABLE}.ad_network  ;;
  }
  dimension: ad_source_name {
    group_label: "Networks"
    type: string
    sql: ${TABLE}.ad_source_name  ;;
  }
  dimension: network_name {
    group_label: "Networks"
    label: "Network"
    type: string
    sql: coalesce(${ad_source_name},${ad_network}) ;;
  }
  dimension: ad_unit_name {
    group_label: "Placements"
    label: "Ad Unit"
    type: string
    sql: ${TABLE}.ad_unit_name  ;;
  }
  dimension: placement {
    group_label: "Placements"
    label: "Ad Placement"
    type: string
    sql: ${TABLE}.placement  ;;
  }
  dimension: ad_placement {
    group_label: "Placements"
    label: "Placement"
    type: string
    sql: coalesce(${ad_unit_name},${placement}) ;;
  }
  dimension: impression_id {
    type: string
    sql: ${TABLE}.impression_id  ;;
  }
  measure: impression_id_count {
    group_label: "Impression Counts"
    label: "Impression Id Count"
    type: count_distinct
    sql: ${impression_id} ;;
  }
  dimension: auction_id {
    type: string
    sql: ${TABLE}.auction_id  ;;
  }
  measure: auction_id_count {
    group_label: "Impression Counts"
    label: "Auction Id Count"
    type: count_distinct
    sql: ${auction_id} ;;
  }
  measure: impression_count {
    group_label: "Impression Counts"
    label: "Total Impression Count"
    type: count_distinct
    sql: coalesce(${impression_id},${auction_id});;
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
    group_label: "Ad Revenue per Impression"
    label: "Publisher Revenue per Impression"
    type: number
    value_format: "$#,##0.00"
    sql: ${TABLE}.publisher_revenue_per_impression ;;
  }
  measure: publisher_revenue_sum {
    group_label: "Revenue"
    label: "Total Publisher Revenue"
    type: sum
    value_format: "$#,##0.0000"
    sql: ${publisher_revenue_per_impression} ;;
  }
  dimension: ad_value {
    group_label: "Ad Revenue per Impression"
    label: "Ad Value"
    type: number
    value_format: "$#,##0.00"
    sql: if(date(${TABLE}.timestamp) > '2023-02-22',${TABLE}.ad_value,0) ;;
  }
  measure: ad_value_sum {
    group_label: "Revenue"
    label: "Total Ad Value"
    type: sum
    value_format: "$#,##0.0000"
    sql: ${ad_value} ;;
  }
  dimension: revenue {
    group_label: "Ad Revenue per Impression"
    label: "Revenue"
    type: number
    value_format: "$#,##0.00"
    sql: ${publisher_revenue_per_impression} + ${ad_value} ;;
  }
  measure: revenue_sum {
    group_label: "Revenue"
    label: "Total Revenue"
    type: sum
    value_format: "$#,##0.00"
    sql: ${revenue} ;;
  }
  measure: player_count {
    label: "Unique Ad Viewing Players"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: revenue_per_impression {
    label: "Ad Revenue per Impression"
    type: number
    value_format: "$#,##0.0000"
    sql: ${revenue_sum} / nullif(${impression_count},0) ;;
  }
  measure: revenue_per_ad_viewing_player {
    label: "Ad Revenue per Viewing Player"
    type: number
    value_format: "$#,##0.0000"
    sql: ${revenue_sum} / nullif(${player_count},0) ;;
  }
  measure: impressions_per_ad_viewing_player {
    label: "Impressions per Viewing Player"
    type: number
    value_format: "#,##0.00"
    sql: ${impression_count} / nullif(${player_count},0) ;;
  }
  drill_fields: [rdg_id,ad_event_time,last_level_serial,publisher_revenue_per_impression]
}
