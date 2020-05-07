view: events {
  sql_table_name: `eraser-blast.game_data.events`
    ;;

###ID DIMENSIONS###

  dimension: device_id {
    type: string
    sql: ${TABLE}.device_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: social_id {
    type: string
    sql: ${TABLE}.social_id ;;
  }

  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
  }

###

###DEVICE DIMENSIONS###

  dimension: device_model {
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: device_os_version {
    type: string
    sql: ${TABLE}.platform ;;
  }

  #UPDATE - WHAT DOES THIS REPRESENT? Web vs Mobile? or mobile platforms
  #UPDATE - NEEDS TO BE DERIVED BY THE DB
  dimension: device_platform {
    type: string
    sql: 'iOS' ;;
  }

  #UPDATE - NEEDS TO BE DERIVED BY THE DB
  dimension: device_brand {
    type: string
    sql: 'Apple' ;;
  }

  #UPDATE - NEEDS TO BE DERIVED BY THE DB
  dimension: device_language {
    type: string
    sql: 'English' ;;
  }

  dimension: battery_level {
    type: string
    sql: ${TABLE}.battery_level ;;
  }

###


###GEO DIMENSIONS###

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

###


  dimension: coins {
    type: number
    sql: ${TABLE}.coins ;;
  }

  dimension: consecutive_days {
    type: number
    sql: ${TABLE}.consecutive_days ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: currencies {
    type: string
    sql: ${TABLE}.currencies ;;
  }

  dimension: current_card {
    type: string
    sql: ${TABLE}.current_card ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: extra_json {
    type: string
    hidden: yes
    sql: ${TABLE}.extra_json ;;
  }

  dimension: gems {
    type: number
    sql: ${TABLE}.gems ;;
  }

  dimension_group: last_payment {
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
    sql: ${TABLE}.last_payment ;;
  }

  dimension: lives {
    type: number
    sql: ${TABLE}.lives ;;
  }

  dimension: ltv {
    type: number
    description: "total spend over the player's lifetime at the time of the event"
    label: "lifetime spend"
    sql: ${TABLE}.ltv / 100 ;;
  }

  dimension: ltv_tier {
    type: tier
    tiers: [0,1,10,100]
    style: integer
    label: "lifetime spend tier"
    description: "spender bucket"
    sql: ${ltv} ;;
  }

  dimension: payer {
    type: yesno
    sql: ${TABLE}.payer ;;
  }

  dimension: player_xp_level {
    type: number
    sql: ${TABLE}.player_xp_level ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: tickets {
    type: string
    sql: ${TABLE}.tickets ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.timestamp ;;
  }

  dimension_group: timestamp_insert {
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
    sql: ${TABLE}.timestamp_insert ;;
  }


  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  measure: count {
    type: count
    drill_fields: [event_name]
  }

  measure: max_ltv {
    type: max
    label: "total lifetime spend"
    sql: ${ltv} ;;
    value_format_name: usd
  }
}
