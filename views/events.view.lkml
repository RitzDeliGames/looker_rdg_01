view: events {
  sql_table_name: `eraser-blast.game_data.events`;;

###DIMENSIONS###

###GAME DIMENSIONS###

  dimension: game_name {
    type: string
    sql: "ERASER BLAST" ;;
  }

  dimension: game_version {
    type: string
    sql: ${TABLE}.version ;;
  }

###

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

  dimension: device_brand {
    type: string
    description: "the device manufacturer"
    sql:CASE
          WHEN ${TABLE}.hardware LIKE "%iPhone%" THEN "Apple"
          WHEN ${TABLE}.hardware LIKE "%iPad%" THEN "Apple"
          WHEN ${TABLE}.hardware LIKE "%Pixel%" THEN "Google"
          WHEN ${TABLE}.hardware LIKE "%samsung%" THEN "Samsung"
          WHEN ${TABLE}.hardware LIKE "%LGE%" THEN "LGE"
          WHEN ${TABLE}.hardware LIKE "%moto%" THEN "Motorola"
          WHEN ${TABLE}.hardware LIKE "%Huawei%" THEN "Huawei"
        END ;;
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: device_os_version {
    type: string
    label: "device OS (major)"
    sql:CASE
          WHEN ${TABLE}.platform LIKE "%iOS 13%" THEN "iOS 13"
          WHEN ${TABLE}.platform LIKE "%iOS 12%" THEN "iOS 12"
          WHEN ${TABLE}.platform LIKE "%iOS 11%" THEN "iOS 11"
          WHEN ${TABLE}.platform LIKE "%iOS 10%" THEN "iOS 10"
          WHEN ${TABLE}.platform LIKE "%iOS 10%" THEN "iOS 10"
          WHEN ${TABLE}.platform LIKE "%Android OS 10%" THEN "Android 10"
          WHEN ${TABLE}.platform LIKE "%Android OS 9%" THEN "Android 9"
          WHEN ${TABLE}.platform LIKE "%Android OS 8%" THEN "Android 8"
          WHEN ${TABLE}.platform LIKE "%Android OS 7%" THEN "Android 7"
        END ;;
  }

  dimension: device_os_version_minor {
    type: string
    label: "device OS (minor)"
    sql: ${TABLE}.platform ;;
  }

  dimension: device_platform {
    type: string
    sql: CASE
          WHEN ${TABLE}.platform LIKE "%iOS%" THEN "Apple"
          WHEN ${TABLE}.platform LIKE "%Android%" THEN "Google"
          WHEN ${TABLE}.hardware LIKE "%Chrome%" AND ${TABLE}.user_id LIKE "%facebook%" THEN "Facebook"
        END ;;
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

###PLAYER DIMENSIONS###

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension_group: user_first_seen {
    type: time
    group_label: "install date"
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

  dimension: payer {
    type: yesno
    sql: ${TABLE}.payer ;;
  }

  dimension: consecutive_days {
    type: number
    sql: ${TABLE}.consecutive_days ;;
  }

  dimension: player_xp_level {
    type: number
    sql: ${TABLE}.player_xp_level ;;
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

###

###PLAYER INVENTORY DIMENSIONS###

  dimension: lives {
    type: number
    sql: ${TABLE}.lives ;;
  }

  dimension: coins { #we can probably drop this if everything is packed into currencies
    type: number
    sql: ${TABLE}.coins ;;
  }

  dimension: gems {#we can probably drop this if everything is packed into currencies
    type: number
    sql: ${TABLE}.gems ;;
  }

  dimension: tickets {
    type: string
    sql: ${TABLE}.tickets ;;
  }

  dimension: currencies {#this requires unpacking
    type: string
    sql: ${TABLE}.currencies ;;
  }

###

###SCHEMA DIMENSIONS###

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: extra_json {
    type: string
    hidden: yes
    sql: ${TABLE}.extra_json ;;
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

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: unique_event_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.timestamp_insert ;;
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
    sql: ${TABLE}.timestamp ;;
  }

###

###BINGO CARD DIMENSIONS###

  dimension: current_card {
    type: string
    sql: ${TABLE}.current_card ;;
  }

###


###MEASURES###
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
