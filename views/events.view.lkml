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
    sql: ${TABLE}.version;;
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
          WHEN ${TABLE}.user_id LIKE "anon-431ff9ad-d91c-43e1-9c7d-26a651f686b4" THEN "Robert Einspruch iPhone 11"
          WHEN ${TABLE}.user_id LIKE "anon-a92949b7-e902-45b0-9e1d-addb6cc46b80" THEN "Robert Einspruch iPhone 8"
          WHEN ${TABLE}.user_id LIKE "anon-5c17fbfe-414a-4ced-a4af-1387aa5d32f2" THEN "Robert Einspruch iPhone 6"
          WHEN ${TABLE}.user_id LIKE "anon-4DB773A6-FC02-47E3-9454-56653DD6A311" THEN "Robert Einspruch iPhone 6"
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

  dimension: device_brand {#SHOULD WEB TRAFFIC GRAB PC OR BROWSER? sug: "pc_browser"}
    group_label: "device & os dimensions"
    type: string
    description: "the device manufacturer"
    sql:CASE
          WHEN ${TABLE}.hardware LIKE "%iPhone%" THEN "Apple"
          WHEN ${TABLE}.hardware LIKE "%iPad%" THEN "Apple"
          WHEN ${TABLE}.hardware LIKE "%Pixel%" THEN "Google"
          WHEN ${TABLE}.hardware LIKE "%samsung%" THEN "Samsung"
          WHEN ${TABLE}.hardware LIKE "%LG%" THEN "LG"
          WHEN ${TABLE}.hardware LIKE "%moto%" THEN "Motorola"
          WHEN ${TABLE}.hardware LIKE "%Huawei%" THEN "Huawei"
        END ;;
  }

  dimension: device_model {
    group_label: "device & os dimensions"
    type: string
    sql:CASE
          WHEN ${TABLE}.hardware = "iPhone6,2" THEN "iPhone 5s Global"
          WHEN ${TABLE}.hardware = "iPhone7,1" THEN "iPhone 6 Plus"
          WHEN ${TABLE}.hardware = "iPhone7,2" THEN "iPhone 6"
          WHEN ${TABLE}.hardware = "iPhone8,1" THEN "iPhone 6s"
          WHEN ${TABLE}.hardware = "iPhone8,2" THEN "iPhone 6s Plus"
          WHEN ${TABLE}.hardware = "iPhone8,4" THEN "iPhone SE GSM"
          WHEN ${TABLE}.hardware = "iPhone9,1" THEN "iPhone 7"
          WHEN ${TABLE}.hardware = "iPhone9,2" THEN "iPhone 7 Plus"
          WHEN ${TABLE}.hardware = "iPhone9,3" THEN "iPhone 7"
          WHEN ${TABLE}.hardware = "iPhone9,4" THEN "iPhone 7 Plus"
          WHEN ${TABLE}.hardware = "iPhone10,1" THEN "iPhone 8"
          WHEN ${TABLE}.hardware = "iPhone10,2" THEN "iPhone 8 Plus"
          WHEN ${TABLE}.hardware = "iPhone10,3" THEN "iPhone X Global"
          WHEN ${TABLE}.hardware = "iPhone10,4" THEN "iPhone 8"
          WHEN ${TABLE}.hardware = "iPhone10,5" THEN "iPhone 8 Plus"
          WHEN ${TABLE}.hardware = "iPhone10,6" THEN "iPhone X GSM"
          WHEN ${TABLE}.hardware = "iPhone11,2" THEN "iPhone XS"
          WHEN ${TABLE}.hardware = "iPhone11,4" THEN "iPhone XS Max"
          WHEN ${TABLE}.hardware = "iPhone11,6" THEN "iPhone XS Max Global"
          WHEN ${TABLE}.hardware = "iPhone11,8" THEN "iPhone XR"
          WHEN ${TABLE}.hardware = "iPhone12,1" THEN "iPhone 11"
          WHEN ${TABLE}.hardware = "iPhone12,3" THEN "iPhone 11 Pro"
          WHEN ${TABLE}.hardware = "iPhone12,5" THEN "iPhone 11 Pro Max"
          WHEN ${TABLE}.hardware = "iPhone12,8" THEN "iPhone SE - 2nd Gen"
          WHEN ${TABLE}.hardware = "iPad4,1" THEN "iPad Air - 1st Gen"
          WHEN ${TABLE}.hardware = "iPad5,3" THEN "iPad Air - 2nd Gen"
          WHEN ${TABLE}.hardware = "iPad6,3" THEN "iPad Pro - 9.7"
          WHEN ${TABLE}.hardware = "iPad6,7" THEN "iPad Pro - 12.9"
          WHEN ${TABLE}.hardware = "iPad7,5" THEN "iPad - 6th Gen"
          WHEN ${TABLE}.hardware = "iPad7,11" THEN "iPad - 7th Gen - 10.2"
          WHEN ${TABLE}.hardware = "iPad8,11" THEN "iPad Pro - 4th Gen - 12.9"
          WHEN ${TABLE}.hardware = "iPad11,3" THEN "iPad Air - 3rd Gen"
          WHEN ${TABLE}.hardware = "samsung SM-J327V" THEN "Samsung Galaxy J3"
          WHEN ${TABLE}.hardware = "samsung SM-J400M" THEN "Samsung Galaxy J4"
          WHEN ${TABLE}.hardware = "samsung SM-M305F" THEN "Samsung Galaxy M30"
          WHEN ${TABLE}.hardware = "samsung SM-G950F" THEN "Samsung Galaxy S8"
          WHEN ${TABLE}.hardware = "samsung SM-G950U" THEN "Samsung Galaxy S8"
          WHEN ${TABLE}.hardware = "samsung SM-G955U" THEN "Samsung Galaxy S8+"
          WHEN ${TABLE}.hardware = "samsung SM-G960U1" THEN "Samsung Galaxy S9"
          WHEN ${TABLE}.hardware = "samsung SM-G960U" THEN "Samsung Galaxy S9"
          WHEN ${TABLE}.hardware = "samsung SM-G965U" THEN "Samsung Galaxy S9+"
          WHEN ${TABLE}.hardware = "samsung SM-G973U" THEN "Samsung Galaxy S10"
          WHEN ${TABLE}.hardware = "samsung SM-G970U" THEN "Samsung Galaxy S10"
          WHEN ${TABLE}.hardware = "samsung SM-G970F" THEN "Samsung Galaxy S10"
          WHEN ${TABLE}.hardware = "samsung SM-G986U" THEN "Samsung Galaxy S20+"
          WHEN ${TABLE}.hardware = "samsung SM-N975U" THEN "Samsung Galaxy Note10+"
          WHEN ${TABLE}.hardware = "samsung SM-N975U1" THEN "Samsung Galaxy Note10+"
          WHEN ${TABLE}.hardware = "samsung SM-T560NU" THEN "Samsung Galaxy Tab 9.6"
          WHEN ${TABLE}.hardware = "motorola Moto G (5) Plus" THEN "Motorola Moto G5 Plus"
          ELSE ${TABLE}.hardware
        END ;;
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
    sql: REPLACE(JSON_EXTRACT(${TABLE}.language, "$.SystemLanguage"),'"','') ;;
  }

  dimension: battery_level {
    group_label: "device & os dimensions"
    type: number
    sql: ${TABLE}.battery_level ;;
  }

###


###GEO DIMENSIONS###

  dimension: country {
    group_label: "Geo Dimensions"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: city {
    group_label: "Geo Dimensions"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: region {
    group_label: "Geo Dimensions"
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
    hidden: no
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
    sql: ${TABLE}.player_level_xp ;;
  }

  dimension: player_xp_level_int {
    type: number
    sql: CAST(FLOOR(${TABLE}.player_level_xp) AS INT64);;
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

###ROUND START / END DIMENSIONS###

  dimension: round_id {
    group_label: "Round Start/End"
    label: "Round ID"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  dimension: character_used {
    group_label: "Round Start/End"
    label: "Character Used"
    type: string
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.team_slot_0'),'"','');;
  }

  dimension: character_used_skill {
    group_label: "Round Start/End"
    label: "Character XP Level"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.team_slot_skill_0'),'"','') AS NUMERIC);;
  }

  dimension: character_used_xp {
    group_label: "Round Start/End"
    label: "Character Skill Level"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.team_slot_level_0'),'"','') AS NUMERIC);;
  }
###

# Please, allocate this dimension at will:

  dimension: round_length {
    type: number
    sql: CAST(JSON_Value(${extra_json},'$.round_length') AS NUMERIC) / 1000  ;;
  }


###MEASURES###
  measure: count {
    type: count
    drill_fields: [event_name]
  }

  measure: avg_round_count {
    label: "Avg. Round Count"
    type: average
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  measure: max_ltv {
    type: max
    label: "total lifetime spend"
    sql: ${ltv} ;;
    value_format_name: usd
  }

  measure: min_battery_level  {
    type: min
    hidden: yes
    label: "min battery level"
    sql: ${battery_level} ;;
  }

  measure: max_battery_level  {
    type: max
    hidden: yes
    label: "max battery level"
    sql: ${battery_level} ;;
  }

  measure: avg_battery_level  {
    type: average
    hidden: yes
    label: "avg battery level"
    sql: ${battery_level} ;;
  }

  measure: first_time {
    type: date_time
    sql: min(${timestamp_raw}) ;;
  }

  measure: last_time {
    type: date_time
    sql: MAX(${timestamp_raw}) ;;
  }

  measure: tenure {
    type: number
    sql: TIMESTAMP_DIFF(MAX(${timestamp_raw}), min(${timestamp_raw}), HOUR)
 ;;
  }

  measure: count_unique_person_id {
    type: count_distinct
    sql: ${player_id} ;;
  }

}
