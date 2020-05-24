view: events {
  sql_table_name: `eraser-blast.game_data.events`;;

###DIMENSIONS###

###GAME DIMENSIONS###

  dimension: game_name {
    type: string
    hidden: yes
    sql: "ERASER BLAST" ;;
  }

  dimension: game_version {
    type: number
    value_format: "###0"
    sql: CAST(${TABLE}.version AS NUMERIC);;
  }

###

###PLAYER ID DIMENSIONS###

  dimension: device_id {
    group_label: "Player ID Dimensions"
    type: string
    sql: ${TABLE}.device_id ;;
  }

  dimension: player_id {
    group_label: "Player ID Dimensions"
    label: "Player ID"
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_id {
    group_label: "Player ID Dimensions"
    label: "Player Username"
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: tester_name {
    group_label: "Player ID Dimensions"
    label: "Player Real Name"
    type: string
    sql: CASE
          WHEN ${TABLE}.user_id LIKE "anon-431ff9ad-d91c-43e1-9c7d-26a651f686b4" THEN "Robert Einspruch"
        END ;;
  }

  dimension: social_id {
    group_label: "Player ID Dimensions"
    type: string
    sql: ${TABLE}.social_id ;;
  }

  dimension: rdg_id {
    group_label: "Player ID Dimensions"
    type: string
    sql: ${TABLE}.rdg_id ;;
  }

###

###DEVICE DIMENSIONS###

  dimension: device_brand {#SHOULD WEB TRAFFIC GRAB PC OR BROWSER?
    group_label: "device & os dimensions"
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
    group_label: "device & os dimensions"
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: device_os_version {
    group_label: "device & os dimensions"
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
    group_label: "device & os dimensions"
    type: string
    label: "device OS (minor)"
    sql: ${TABLE}.platform ;;
  }

  dimension: device_platform {
    group_label: "device & os dimensions"
    type: string
    sql: CASE
          WHEN ${TABLE}.platform LIKE "%iOS%" THEN "Apple"
          WHEN ${TABLE}.platform LIKE "%Android%" THEN "Google"
          WHEN ${TABLE}.hardware LIKE "%Chrome%" AND ${TABLE}.user_id LIKE "%facebook%" THEN "Facebook"
        END ;;
  }

  #UPDATE - NEEDS TO BE DERIVED BY THE DB
  dimension: device_language {
    group_label: "device & os dimensions"
    type: string
    sql: 'English' ;;
  }

  dimension: battery_level {
    group_label: "device & os dimensions"
    type: number
    sql: ${TABLE}.battery_level ;;
  }

###


###GEO DIMENSIONS###

  dimension: country {
    group_label: "geo dimensions"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: city {
    group_label: "geo dimensions"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: region {
    group_label: "geo dimensions"
    type: string
    sql: ${TABLE}.region ;;
  }

###

###UA DIMENSIONS###

#LEAVE HARDCODED TO 'facebook' UNTIL WE HAVE AD ANALYTICS SET UP
  dimension: install_source {
    label: "install source"
    description: "paid vs organic install source"
    type: string
    sql: 'facebook' ;;
    hidden: yes
  }

#LEAVE HARDCODED TO '0.1' UNTIL WE HAVE AD ANALYTICS SET UP
  dimension: install_cost {
    type: number
    sql: 0.1 ;;
    hidden: yes
  }

#LEAVE HARDCODED TO 'campaign_1' UNTIL WE HAVE AD ANALYTICS SET UP
  dimension: campaign_name {
    type: string
    sql: 'campaign_1' ;;
    hidden: yes
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

  dimension: gems {
    group_label: "currencies"
    label: "gems"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.currencies,'$.CURRENCY_02'),'"','') as NUMERIC);;
  }

  dimension: coins {
    group_label: "currencies"
    label: "coins"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.currencies,'$.CURRENCY_03'),'"','') as NUMERIC);;
  }

  dimension: lives {
    group_label: "currencies"
    label: "lives"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.currencies,'$.CURRENCY_04'),'"','') as NUMERIC);;
  }

  dimension: box_002_tickets {
    group_label: "box tickets"
    label: "super fun box tickets"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.box_002'),'"','') as NUMERIC);;
  }

  dimension: box_007_tickets {
    group_label: "box tickets"
    label: "house pet box tickets"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.box_007'),'"','') as NUMERIC);;
  }

  dimension: score_tickets {
    group_label: "boosts"
    label: "score boosts"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.SCORE'),'"','') as NUMERIC);;
  }

  dimension: bubble_tickets {
    group_label: "boosts"
    label: "bubble boosts"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.BUBBLE'),'"','') as NUMERIC);;
  }

  dimension: time_tickets {
    group_label: "boosts"
    label: "time boosts"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.TIME'),'"','') as NUMERIC);;
  }

  dimension: five_to_four_tickets {
    group_label: "boosts"
    label: "5-to-4 boosts"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.FIVE_TO_FOUR'),'"','') as NUMERIC);;
  }

  dimension: exp_tickets {
    group_label: "boosts"
    label: "xp boosts"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.EXP'),'"','') as NUMERIC);;
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

  measure: min_battery_level  {
    type: min
    label: "min battery level"
    sql: ${battery_level} ;;
  }

  measure: max_battery_level  {
    type: max
    label: "max battery level"
    sql: ${battery_level} ;;
  }

  measure: avg_battery_level  {
    type: average
    label: "avg battery level"
    sql: ${battery_level} ;;
  }

  measure: first_date {
    type:  date
    sql: MIN(${event_raw}) ;;
  }

}
