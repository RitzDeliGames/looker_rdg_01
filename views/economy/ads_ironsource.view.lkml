view: ads_ironsource {
  derived_table: {
    sql:
      select
        event_timestamp ad_event
        ,advertising_id
        ,advertising_vendor_id
        ,user_id
        ,ad_unit
        ,ad_network
        ,instance_name
        ,country
        ,placement
        ,segment
        ,AB_Testing
        ,cast(revenue as numeric) revenue
      from ironsource.ironsource_daily_impressions_export
    ;;
    datagroup_trigger: change_at_midnight
    publish_as_db_view: yes
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${user_id} || ${ad_event_raw} ;;
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
    sql: ${TABLE}.ad_event  ;;
  }
  dimension: ad_network {
    type: string
    sql: ${TABLE}.ad_network  ;;
  }
  dimension: ad_unit {
    type: string
    sql: ${TABLE}.ad_unit  ;;
  }
  dimension: placement {
    type: string
    sql: ${TABLE}.placement  ;;
  }
  measure: impression_count {
    label: "Total Impressions"
    type: count_distinct
    sql: ${ad_event_raw} ;;
  }
  dimension: revenue {
    type: number
    value_format: "$#,##0.0000"
    sql: ${TABLE}.revenue ;;
  }
  measure: revenue_sum {
    label: "Total Revenue"
    type: sum
    value_format: "$#,##0.0000"
    sql: ${revenue} ;;
  }
  measure: player_count {
    label: "Unique Ad Viewing Players"
    type: count_distinct
    sql: ${user_id} ;;
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
}
