include: "events.view"
include: "transactions.view"

view: gaming_block_raw_events {
  extends: [events, transactions]

#UPDATE - COMMENTED OUT B/C EXTENDING EVENTS AND TRANSACTIONS VIEWS
#view: gaming_block_raw_events {
#  sql_table_name: eraser-blast.game_data.events;;

#UPDATE - WHAT DOES THIS REPRESENT?
  dimension: unique_event_id {
    primary_key: yes
    type: string
    sql: 'abcdefg' ;;
  }

#LEAVE HARDCODED TO 0 UNTIL WE HAVE AD REVENUE
  dimension: ad_revenue {
    type: number
    sql: '0.0' ;;
  }

#LEAVE HARDCODED TO 'campaign_1' UNTIL WE HAVE AD ANALYTICS SET UP
  dimension: campaign_name {
    type: string
    sql: 'campaign_1' ;;
  }

#UPDATE - USING EVENTS VIEW
  #dimension: country {
    #type: string
    #map_layer_name: countries
    #sql: 'USA' ;;
    #sql: ${TABLE}.country ;;
  #}

#UPDATE
  dimension: device_brand {
    type: string
    sql: 'Apple' ;;
  }

#UPDATE
  dimension: device_language {
    type: string
    sql: 'English' ;;
  }

#UPDATE - USING EVENTS VIEW
  #dimension: device_model {
    #type: string
    #sql: ${TABLE}.device_model ;;
    #sql: ${TABLE}.hardware ;;
  #}

#UPDATE - USING EVENTS VIEW
  #dimension: device_os_version {
    #type: string
    #sql: ${TABLE}.device_os_version ;;
    #sql: ${TABLE}.platform ;;
  #}

#UPDATE - USING EVENTS VIEW
  #dimension: device_platform {
    #type: string
    #sql: ${TABLE}.device_platform ;;
  #}

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

#UPDATE - MOVED TO THE THE TRANSACTION VIEW
  #dimension: iap_revenue {
  #  type: number
  #  sql: 0.5 ;; #PULL OUT TRANSACTION SQL
  #}

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
