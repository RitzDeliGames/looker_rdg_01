include: "events.view"
include: "transactions.view"

view: gaming_block_raw_events {
  extends: [events, transactions]

#view: gaming_block_raw_events {
#  sql_table_name: eraser-blast.game_data.events;;

#UPDATE - WHAT DOES THIS REPRESENT?
  dimension: unique_event_id {
    primary_key: yes
    type: string
    sql: 'abcdefg' ;;
  }

#DELETE UNTIL WE HAVE AD REVENUE
  dimension: ad_revenue {
    type: number
    sql: '0.0' ;;
  }

#UPDATE
  dimension: campaign_name {
    type: string
    sql: 'campaign_1' ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    #sql: 'USA' ;;
    sql: ${TABLE}.country ;;
  }

#UPDATE
  dimension: device_brand {
    type: string
    sql: ${TABLE}.device_brand ;;
  }
#UPDATE
  dimension: device_language {
    type: string
    sql: ${TABLE}.device_language ;;
  }

  dimension: device_model {
    type: string
    #sql: ${TABLE}.device_model ;;
    sql: ${TABLE}.hardware ;;
  }

  dimension: device_os_version {
    type: string
    #sql: ${TABLE}.device_os_version ;;
    sql: ${TABLE}.platform ;;
  }
#UPDATE - WHAT DOES THIS REPRESENT?
  dimension: device_platform {
    type: string
    sql: ${TABLE}.device_platform ;;
  }

  dimension_group: event {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: CURRENT_TIMESTAMP() ;;
  }

  dimension: event_name {
    type: string
    #sql: 'kill_player' ;;
    sql: ${TABLE}.event_name ;;
  }

  dimension: game_name {
    type: string
    sql: "ERASER BLAST" ;;
  }

  dimension: game_version {
    type: string
    #sql: '11' ;;
    sql: ${TABLE}.version ;;
  }

#UPDATE
  dimension: iap_revenue {
    type: number
    sql: 0.5 ;; #PULL OUT TRANSACTION SQL
  }

#SELECT *,
#CAST(REPLACE(JSON_EXTRACT(extra_json,"$.transaction_purchase_currency"),'"','') AS INT64) AS transaction_currency
#FROM `eraser-blast.game_data.events`
#WHERE event_name = "transaction"
#AND user_type IN ("internal","external")
#AND REPLACE(JSON_EXTRACT(extra_json,"$.transaction_purchase_currency"),'"','') = "CURRENCY_01"
#ORDER BY timestamp DESC

#UPDATE
  dimension: install_cost {
    type: number
    sql: 1.2 ;;
  }

#UPDATE
  dimension: install_source {
    type: string
    sql: 'facebook' ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: user_first_seen {
    #you might need to calculate this!
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    #sql: CURRENT_TIMESTAMP() ;;
    sql:  ${TABLE}.created_at ;;
  }

  measure: count {
    type: count
    drill_fields: [game_name, campaign_name, event_name]
  }
}
