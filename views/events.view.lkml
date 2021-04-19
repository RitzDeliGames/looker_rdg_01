view: events {
  sql_table_name: `eraser-blast.game_data.events`;;

###DIMENSIONS###

## New Version ##


  dimension: version {
    type: string
    hidden: yes
    sql: ${TABLE}.version ;;
  }
  dimension: derived_install_minor_release_version {
    hidden: yes
    type: string
    sql:
      case
        when ${version} = '1579' then '1.0.100'
        when ${version} = '2047' then '1.1.001'
        when ${version} = '2100' then '1.1.100'
        when ${version} = '3028' then '1.2.028'
        when ${version} = '3043' then '1.2.043'
        when ${version} = '3100' then '1.2.100'
        when ${version} = '4017' then '1.3.017'
        when ${version} = '4100' then '1.3.100'
        else null
      end
    ;;
  }
  dimension: install_minor_release_version {
    hidden: yes
    type: string
    sql:
      case
        when ${install_version} = '1568' then '1.0.001'
        when ${install_version} = '1579' then '1.0.100'
        when ${install_version} = '2047' then '1.1.001'
        when ${install_version} = '2100' then '1.1.100'
        when ${install_version} = '3028' then '1.2.028'
        when ${install_version} = '3043' then '1.2.043'
        when ${install_version} = '3100' then '1.2.100'
        when ${install_version} = '4017' then '1.3.017'
        when ${install_version} = '4100' then '1.3.100'
        when ${install_version} = '5006' then '1.5.006'
        when ${install_version} = '5100' then '1.5.100'
        when ${install_version} = '6100' then '1.6.100'
        when ${install_version} = '6200' then '1.6.200'
        when ${install_version} = '6300' then '1.6.300'
        when ${install_version} = '6400' then '1.6.400'
        when ${install_version} = '7100' then '1.7.100'
        when ${install_version} = '7200' then '1.7.200'
        when ${install_version} = '7300' then '1.7.300'
        when ${install_version} = '7400' then '1.7.400'
        when ${install_version} = '7500' then '1.7.500'
        when ${install_version} = '7600' then '1.7.600'
        when ${install_version} = '8000' then '1.8.000'
        when ${install_version} = '8100' then '1.8.100'
        when ${install_version} = '8200' then '1.8.200'
        else null
      end
    ;;
  }
  dimension: release_version_all {
    group_label: "Versions"
    label: "Release Version"
    type: string
    sql: coalesce(${install_minor_release_version},${derived_install_minor_release_version}) ;;
  }


###GAME DIMENSIONS###

  dimension: game_name {
    type: string
    hidden: yes
    sql: "ERASER BLAST" ;;
  }

  dimension: game_version {
    group_label: "Versions"
    label: "Game Version"
    type: string
    sql:${TABLE}.version;;
  }

  dimension: config_version {
    group_label: "Versions"
    label: "Config Version"
    type: string
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,"$.config_timestamp"),'"','');;
  }

  dimension: release_version {
    group_label: "Versions"
    label: "Major Release Version"
    sql: @{release_version_major};;
  }

  dimension: release_version_minor {
    group_label: "Versions"
    label: "Minor Release Version"
    sql: @{release_version_minor};;
  }

  dimension: install_version {
    group_label: "Versions"
    label: "Install Version"
    type: string
    sql: ${TABLE}.install_version ;;
  }

  dimension: install_release_version {
    group_label: "Versions"
    label: "Install Major Release Version"
    sql: @{install_release_version_major};;
  }

  dimension: install_release_version_minor {
    group_label: "Versions"
    label: "Install Minor Release Version"
    sql: @{install_release_version_minor};;
  }


###

###EXPERIMENT DIMENSIONS

  dimension: experiments {
    group_label: "Experiments"
    label: "Experiment IDs"
    type: string
    sql: ${TABLE}.experiments ;;
  }

  dimension: experiment_names {
    group_label: "Experiments"
    label: "Experiment Names"
    type: string
    sql: @{experiment_ids} ;;
  }

  dimension: variants {
    group_label: "Experiments"
    label: "Variants"
    type: string
    sql: REPLACE(@{variant_ids},'"','') ;;
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
    sql:@{device_internal_tester_mapping};;
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

  dimension: paused {
    type: string
    sql: JSON_Value(extra_json, '$.paused') ;;
  }

###

###DEVICE DIMENSIONS###

  dimension: device_brand {#SHOULD WEB TRAFFIC GRAB PC OR BROWSER? sug: "pc_browser"}
    group_label: "Device & OS Dimensions"
    label: "Device Manufacturer"
    sql:@{device_manufacturer_mapping} ;;
  }

  dimension: device_model_number {
    group_label: "Device & OS Dimensions"
    label:  "Device Model (Ungrouped)"
    sql:LOWER(${TABLE}.hardware) ;;
  }

  dimension: device_model {
    group_label: "Device & OS Dimensions"
    label: "Device Model (Grouped)"
    sql:@{device_model_mapping} ;;
  }

  dimension: device_os_version {
    group_label: "Device & OS Dimensions"
    label: "Device OS (major)"
    sql:@{device_os_version_mapping} ;;
  }

  dimension: device_os_version_minor {
    group_label: "Device & OS Dimensions"
    label: "Device OS (minor)"
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: device_platform {
    group_label: "Device & OS Dimensions"
    label: "Device Platform"
    sql: @{device_platform_mapping} ;;
  }

  #UPDATE - NEEDS TO BE DERIVED BY THE DB
  dimension: device_language {
    group_label: "Device & OS Dimensions"
    type: string
    sql: REPLACE(JSON_EXTRACT(${TABLE}.language, "$.SystemLanguage"),'"','') ;;
  }

  dimension: battery_level {
    group_label: "Device & OS Dimensions"
    type: number
    sql: ${TABLE}.battery_level ;;
  }

  dimension: country {
    group_label: "Device & OS Dimensions"
    label: "Device Country"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: region {
    group_label: "Device & OS Dimensions"
    label: "Device Region"
    type: string
    sql: @{country_region};;
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
    group_label: "Install Date"
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

  dimension_group: since_install {
    type: duration
    sql_start: ${user_first_seen_raw} ;;
    sql_end: ${timestamp_raw}  ;;
  }

  dimension: 30_mins_since_install {
    group_label: "Install Date"
    label: "First 30 Minutes of Play"
    style: integer
    type: tier
    tiers: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
    sql: ${minutes_since_install} ;;
  }

  dimension: 60_mins_since_install {
    group_label: "Install Date"
    label: "First 60 Minutes of Play"
    style: integer
    type: tier
    tiers: [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60]
    sql: ${minutes_since_install} ;;
  }

  dimension: 24_hours_since_install {
    group_label: "Install Date"
    label: "First 24 Hours of Play"
    style: integer
    type: tier
    tiers: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    sql: ${hours_since_install} ;;
  }

  dimension: 7_days_since_install {
    group_label: "Install Date"
    label: "First 7 Days of Play"
    style: integer
    type: tier
    tiers: [0,1,2,3,4,5,6,7]
    sql: ${days_since_install} ;;
  }

  dimension: 14_days_since_install {
    group_label: "Install Date"
    label: "First 14 Days of Play"
    style: integer
    type: tier
    tiers: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
    sql: ${days_since_install} ;;
  }

  dimension: 28_days_since_install {
    group_label: "Install Date"
    label: "First 28 Days of Play"
    style: integer
    type: tier
    tiers: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28]
    sql: ${days_since_install} ;;
  }

  dimension: payer {
    type: yesno
    sql: ${TABLE}.payer ;;
  }

  dimension: consecutive_days {
    type: number
    sql: ${TABLE}.consecutive_days ;;
  }

  measure: consecutive_days_played_min {
    type: min
    sql: ${consecutive_days} ;;
  }

  measure: consecutive_days_played_max {
    type: max
    sql: ${consecutive_days} ;;
  }

  dimension: everyday_players {
    label: "Everyday Players"
    style: integer
    type: tier
    tiers: [0,1,2,6]
    sql: ${TABLE}.consecutive_days ;;
  }

  dimension: player_xp_level {
    group_label: "Player XP Levels"
    type: number
    sql: ${TABLE}.player_level_xp ;;
  }

  dimension: player_xp_level_rd_1 {
    group_label: "Player XP Levels"
    type: number
    sql: CAST(ROUND((${TABLE}.player_level_xp),1) AS FLOAT64) ;;
  }

  dimension: player_xp_level_int {
    group_label: "Player XP Levels"
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
    group_label: "Currency Balances"
    label: "Gems"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.currencies,'$.CURRENCY_02'),'"','') as NUMERIC) ;;
  }
  measure:  gems_025th {
    group_label: "Currency Percentiles"
    label: "Gems - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${gems} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  gems_25th {
    group_label: "Currency Percentiles"
    label: "Gems - 25%"
    percentile: 25
    type: percentile
    sql: ${gems} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  gems_50th {
    group_label: "Currency Percentiles"
    label: "Gems - Median"
    type: median
    sql: ${gems} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  gems_75th {
    group_label: "Currency Percentiles"
    label: "Gems - 75%"
    percentile: 75
    type: percentile
    sql: ${gems} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  gems_975th {
    group_label: "Currency Percentiles"
    label: "Gems - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${gems} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: coins {
    group_label: "Currency Balances"
    label: "Coins"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.currencies,'$.CURRENCY_03'),'"','') as NUMERIC);;
  }
  measure:  coins_025th {
    group_label: "Currency Percentiles"
    label: "Coins - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${coins} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  coins_25th {
    group_label: "Currency Percentiles"
    label: "Coins - 25%"
    percentile: 25
    type: percentile
    sql: ${coins} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  coins_50th {
    group_label: "Currency Percentiles"
    label: "Coins - Median"
    type: median
    sql: ${coins} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  coins_75th {
    group_label: "Currency Percentiles"
    label: "Coins - 75%"
    percentile: 75
    type: percentile
    sql: ${coins} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  coins_975th {
    group_label: "Currency Percentiles"
    label: "Coins - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${coins} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: lives {
    group_label: "Currency Balances"
    label: "Lives"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.currencies,'$.CURRENCY_04'),'"','') as NUMERIC);;
  }
  measure:  lives_025th {
    group_label: "Currency Percentiles"
    label: "Lives - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${lives} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  lives_25th {
    group_label: "Currency Percentiles"
    label: "Lives - 25%"
    percentile: 25
    type: percentile
    sql: ${lives} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  lives_50th {
    group_label: "Currency Percentiles"
    label: "Lives - Median"
    type: median
    sql: ${lives} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  lives_75th {
    group_label: "Currency Percentiles"
    label: "Lives - 75%"
    percentile: 75
    type: percentile
    sql: ${lives} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  lives_975th {
    group_label: "Currency Percentiles"
    label: "Lives - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${lives} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: collection_size {
    type: number
    sql: ARRAY_LENGTH(JSON_EXTRACT_ARRAY(extra_json,"$.characters")) ;;
  }
  measure:  collection_size_025 {
    group_label: "Collection Percentiles"
    label: "Collection - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${collection_size} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  collection_size_25 {
    group_label: "Collection Percentiles"
    label: "Collection - 25%"
    type: percentile
    percentile: 25
    sql: ${collection_size};;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  collection_size_med {
    group_label: "Collection Percentiles"
    label: "Collection - Median"
    type: median
    sql: ${collection_size};;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  collection_size_75 {
    group_label: "Collection Percentiles"
    label: "Collection - 75%"
    type: percentile
    percentile: 75
    sql: ${collection_size};;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  collection_size_975 {
    group_label: "Collection Percentiles"
    label: "Collection - 97.5% Percentile"
    type: percentile
    percentile: 97.5
    sql: ${collection_size};;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: box_001_tickets {
    group_label: "Capsule Tickets"
    label: "Fun Capsule Tickets"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.box_001') as NUMERIC);;
  }
  measure:  box_001_tickets_025th {
    group_label: "Ticket Percentiles"
    label: "Fun Capsule - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${box_001_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  box_001_tickets_25th {
    group_label: "Ticket Percentiles"
    label: "Fun Capsule - 25%"
    percentile: 25
    type: percentile
    sql: ${box_001_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  box_001_tickets_50th {
    group_label: "Ticket Percentiles"
    label: "Fun Capsule - Median"
    type: median
    sql: ${box_001_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  box_001_tickets_75th {
    group_label: "Ticket Percentiles"
    label: "Fun Capsule - 75%"
    percentile: 75
    type: percentile
    sql: ${box_001_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  box_001_tickets_975th {
    group_label: "Ticket Percentiles"
    label: "Fun Capsule - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${box_001_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: box_002_tickets {
    group_label: "Capsule Tickets"
    label: "Super Fun Tickets"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.box_002') as NUMERIC);;
  }
  measure:  box_002_tickets_025th {
    group_label: "Ticket Percentiles"
    label: "Super Fun Capsule - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${box_002_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  box_002_tickets_25th {
    group_label: "Ticket Percentiles"
    label: "Super Fun Capsule - 25%"
    percentile: 25
    type: percentile
    sql: ${box_002_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  box_002_tickets_50th {
    group_label: "Ticket Percentiles"
    label: "Super Fun Capsule - Median"
    type: median
    sql: ${box_002_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  box_002_tickets_75th {
    group_label: "Ticket Percentiles"
    label: "Super Fun Capsule - 75%"
    percentile: 75
    type: percentile
    sql: ${box_002_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  box_002_tickets_975th {
    group_label: "Ticket Percentiles"
    label: "Super Fun Capsule - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${box_002_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: box_003_tickets {
    group_label: "Capsule Tickets"
    label: "box 003 tickets"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.box_003') as NUMERIC);;
  }

  dimension: box_006_tickets {
    group_label: "Capsule Tickets"
    label: "box 006 tickets"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.box_006') as NUMERIC);;
  }

  dimension: box_007_tickets {
    group_label: "Capsule Tickets"
    label: "box 007 tickets"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.box_007') as NUMERIC);;
  }

  dimension: score_tickets {
    group_label: "Boost/Ticket Inventory"
    label: "Score Boost"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.SCORE') as NUMERIC);;
  }
  measure:  score_tickets_025th {
    group_label: "Boost Inventory Percentiles - Score"
    label: "Score Boost - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${score_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  score_tickets_25th {
    group_label: "Boost Inventory Percentiles - Score"
    label: "Score Boost - 25%"
    percentile: 25
    type: percentile
    sql: ${score_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  score_tickets_50th {
    group_label: "Boost Inventory Percentiles - Score"
    label: "Score Boost - Median"
    type: median
    sql: ${score_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  score_tickets_75th {
    group_label: "Boost Inventory Percentiles - Score"
    label: "Score Boost - 75%"
    percentile: 75
    type: percentile
    sql: ${score_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  score_tickets_975th {
    group_label: "Boost Inventory Percentiles - Score"
    label: "Score Boost - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${score_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: bubble_tickets {
    group_label: "Boost/Ticket Inventory"
    label: "Bubble Boost"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.BUBBLE') as NUMERIC);;
  }
  measure:  bubble_tickets_tickets_025th {
    group_label: "Boost Inventory Percentiles - Bubble"
    label: "Bubble Boost - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${bubble_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  bubble_tickets_tickets_25th {
    group_label: "Boost Inventory Percentiles - Bubble"
    label: "Bubble Boost - 25%"
    percentile: 25
    type: percentile
    sql: ${bubble_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  bubble_tickets_tickets_50th {
    group_label: "Boost Inventory Percentiles - Bubble"
    label: "Bubble Boost - Median"
    type: median
    sql: ${bubble_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  bubble_tickets_tickets_75th {
    group_label: "Boost Inventory Percentiles - Bubble"
    label: "Bubble Boost - 75%"
    percentile: 75
    type: percentile
    sql: ${bubble_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  bubble_tickets_tickets_975th {
    group_label: "Boost Inventory Percentiles - Bubble"
    label: "Bubble Boost - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${bubble_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: time_tickets {
    group_label: "Boost/Ticket Inventory"
    label: "Time Boost"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.TIME') as NUMERIC);;
  }
  measure:  time_tickets_tickets_025th {
    group_label: "Boost Inventory Percentiles - Time"
    label: "Time Boost - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${time_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  time_tickets_tickets_25th {
    group_label: "Boost Inventory Percentiles - Time"
    label: "Time Boost - 25%"
    percentile: 25
    type: percentile
    sql: ${time_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  time_tickets_tickets_50th {
    group_label: "Boost Inventory Percentiles - Time"
    label: "Time Boost - Median"
    type: median
    sql: ${time_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  time_tickets_tickets_75th {
    group_label: "Boost Inventory Percentiles - Time"
    label: "Time Boost - 75%"
    percentile: 75
    type: percentile
    sql: ${time_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  time_tickets_tickets_975th {
    group_label: "Boost Inventory Percentiles - Time"
    label: "Time Boost - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${time_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: five_to_four_tickets {
    group_label: "Boost/Ticket Inventory"
    label: "5-to-4 Boost"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.FIVE_TO_FOUR') as NUMERIC);;
  }
  measure:  five_to_four_tickets_025th {
    group_label: "Boost Inventory Percentiles - 5-to-4"
    label: "5-to-4 Boost - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${five_to_four_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  five_to_four_tickets_25th {
    group_label: "Boost Inventory Percentiles - 5-to-4"
    label: "5-to-4 Boost - 25%"
    percentile: 25
    type: percentile
    sql: ${five_to_four_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  five_to_four_tickets_50th {
    group_label: "Boost Inventory Percentiles - 5-to-4"
    label: "5-to-4 Boost - Median"
    type: median
    sql: ${five_to_four_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  five_to_four_tickets_75th {
    group_label: "Boost Inventory Percentiles - 5-to-4"
    label: "5-to-4 Boost - 75%"
    percentile: 75
    type: percentile
    sql: ${five_to_four_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  five_to_four_tickets_975th {
    group_label: "Boost Inventory Percentiles - 5-to-4"
    label: "5-to-4 Boost - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${five_to_four_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: exp_tickets {
    group_label: "Boost/Ticket Inventory"
    label: "XP Boost"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.EXP') as NUMERIC);;
  }
  measure:  exp_tickets_025th {
    group_label: "Boost Inventory Percentiles - XP"
    label: "XP Boost - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${exp_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  exp_tickets_25th {
    group_label: "Boost Inventory Percentiles - XP"
    label: "XP Boost - 25%"
    percentile: 25
    type: percentile
    sql: ${exp_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  exp_tickets_50th {
    group_label: "Boost Inventory Percentiles - XP"
    label: "XP Boost - Median"
    type: median
    sql: ${exp_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  exp_tickets_75th {
    group_label: "Boost Inventory Percentiles - XP"
    label: "XP Boost - 75%"
    percentile: 75
    type: percentile
    sql: ${exp_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  exp_tickets_975th {
    group_label: "Boost Inventory Percentiles - XP"
    label: "XP Boost - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${exp_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: coin_tickets {
    group_label: "Boost/Ticket Inventory"
    label: "Coin Boost"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.COIN') as NUMERIC);;
  }
  measure:  coin_tickets_025th {
    group_label: "Boost Inventory Percentiles - Coin"
    label: "Coin Boost - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${coin_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  coin_tickets_25th {
    group_label: "Boost Inventory Percentiles - Coin"
    label: "Coin Boost - 25%"
    percentile: 25
    type: percentile
    sql: ${coin_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  coin_tickets_50th {
    group_label: "Boost Inventory Percentiles - Coin"
    label: "Coin Boost - Median"
    type: median
    sql: ${coin_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  coin_tickets_75th {
    group_label: "Boost Inventory Percentiles - Coin"
    label: "Coin Boost - 75%"
    percentile: 75
    type: percentile
    sql: ${coin_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  coin_tickets_975th {
    group_label: "Boost Inventory Percentiles - Coin"
    label: "Coin Boost - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${coin_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: skill_tickets {
    group_label: "Boost/Ticket Inventory"
    label: "Skill Ticket"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.SKILL') as NUMERIC);;
  }
  measure:  skill_tickets_025th {
    group_label: "Boost Inventory Percentiles - Skill"
    label: "Skill Tickets - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${skill_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  skill_tickets_25th {
    group_label: "Boost Inventory Percentiles - Skill"
    label: "Skill Tickets - 25%"
    percentile: 25
    type: percentile
    sql: ${skill_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  skill_tickets_50th {
    group_label: "Boost Inventory Percentiles - Skill"
    label: "Skill Tickets - Median"
    type: median
    sql: ${skill_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  skill_tickets_75th {
    group_label: "Boost Inventory Percentiles - Skill"
    label: "Skill Tickets - 75%"
    percentile: 75
    type: percentile
    sql: ${skill_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  skill_tickets_975th {
    group_label: "Boost Inventory Percentiles - Skill"
    label: "Skill Tickets - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${skill_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: level_tickets {
    group_label: "Boost/Ticket Inventory"
    label: "Level Ticket"
    type: number
    sql: CAST(JSON_EXTRACT_SCALAR(${TABLE}.tickets,'$.LEVEL') as NUMERIC);;
  }
  measure:  level_tickets_025th {
    group_label: "Boost Inventory Percentiles - Level"
    label: "Level Tickets - 2.5%"
    percentile: 2.5
    type: percentile
    sql: ${level_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  level_tickets_25th {
    group_label: "Boost Inventory Percentiles - Level"
    label: "Level Tickets - 25%"
    percentile: 25
    type: percentile
    sql: ${level_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  level_tickets_50th {
    group_label: "Boost Inventory Percentiles - Level"
    label: "Level Tickets - Median"
    type: median
    sql: ${level_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  level_tickets_75th {
    group_label: "Boost Inventory Percentiles - Level"
    label: "Level Tickets - 75%"
    percentile: 75
    type: percentile
    sql: ${level_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  measure:  level_tickets_975th {
    group_label: "Boost Inventory Percentiles - Level"
    label: "Level Tickets - 97.5%"
    percentile: 97.5
    type: percentile
    sql: ${level_tickets} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }

  dimension: engagement_ticks {
    # group_label: "missing"
    label: "Engagement Ticks"
    type: number
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure:  engagement_tick_025th {
    group_label: "Engagment Ticks"
    label: "Engagement Ticks - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${engagement_ticks} ;;
  }
  measure:  engagement_tick_25th {
    group_label: "Engagment Ticks"
    label: "Engagement Ticks - 25%"
    type: percentile
    percentile: 25
    sql: ${engagement_ticks} ;;
  }
  measure:  engagement_tick_med {
    group_label: "Engagment Ticks"
    label: "Engagement Ticks - Median"
    type: median
    sql: ${engagement_ticks} ;;
  }
  measure:  engagement_tick_75th {
    group_label: "Engagment Ticks"
    label: "Engagement Ticks - 75%"
    type: percentile
    percentile: 75
    sql: ${engagement_ticks} ;;
  }
  measure:  engagement_tick_975th {
    group_label: "Engagment Ticks"
    label: "Engagement Ticks - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${engagement_ticks} ;;
  }

  dimension: quests_completed {
    label: "Quests Completed"
    type: number
    sql: ${TABLE}.quests_completed ;;
  }



###

  dimension: amount_spent {
    group_label: "Currency Transactions"
    label: "transaction purchase amount"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.transaction_purchase_amount'),'"','') as NUMERIC);;
  }

  dimension: currencies_spent {
    group_label: "Currency Transactions"
    label: "transaction purchase currency"
    type: string
    sql: JSON_EXTRACT(${TABLE}.extra_json,'$.transaction_purchase_currency');;
  }


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

  dimension: clock_hacker {
    type: yesno
    sql: (${timestamp_raw} > ${timestamp_insert_raw}) ;;
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
      hour,
      hour_of_day,
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
    group_label: "Current Card"
    label: "Current Card ID"
    type: string
    sql: ${TABLE}.current_card ;;
  }

  dimension: last_unlocked_card {
    group_label: "Current Card"
    label: "Last Unlocked Card ID"
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }

  dimension: current_card_no {
    group_label: "Current Card"
    label: "Current Card Numbered"
    type: number
    value_format: "####"
    sql: @{current_card_numbered} ;;
  }

  dimension: current_quest {
    group_label: "Current Card"
    label: "Current Quest"
    type: number
    sql: IFNULL(${TABLE}.current_quest, CAST(REPLACE(JSON_VALUE(${TABLE}.extra_json,'$.current_quest'),'"','') AS NUMERIC));;
  }

  dimension: current_card_quest {
    group_label: "Current Card"
    label: "Current Card + Quest"
    type: number
    value_format: "####"
    sql: ${current_card_no} + ${current_quest};;
  }

  dimension: quest_complete {
    group_label: "Current Card"
    label: "Quest Complete"
    type: string
    sql: JSON_VALUE(${TABLE}.extra_json,'$.quest_complete') ;;
  }


###

###ROUND START / END DIMENSIONS###

  dimension: round_id {
    group_label: "Round Start/End"
    label: "Round ID"
    type: number
    sql: CAST(REPLACE(JSON_VALUE(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  dimension: character_used {
    group_label: "Round Start/End"
    label: "Character Used"
    type: string
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.team_slot_0'),'"','');;
  }

  dimension: character_used_skill {
    group_label: "Round Start/End"
    label: "Character Skill Level"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.team_slot_skill_0'),'"','') AS NUMERIC);;
  }

  dimension: character_used_xp {
    group_label: "Round Start/End"
    label: "Character XP Level"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.team_slot_level_0'),'"','') AS NUMERIC);;
  }

  dimension: round_length {
    group_label: "Round Start/End"
    label: "Round Length"
    type: number
    sql: CAST(JSON_Value(${extra_json},'$.round_length') AS NUMERIC) / 1000  ;;
  }

###BOOST USED DIMENSIONS - OLD###

  dimension: score_boost {
    group_label: "Boosts Used - Old"
    label: "Score Boost"
    type: string
    sql:IF(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.score_boost') >= "1", TRUE, FALSE);;
  }
  dimension: coin_boost {
    group_label: "Boosts Used - Old"
    label: "Coin Boost"
    type: string
    sql:IF(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.coin_boost') >= "1", TRUE, FALSE);;
  }

  dimension: exp_boost {
    group_label: "Boosts Used - Old"
    label: "XP Boost"
    type: string
    sql:IF(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.exp_boost') >= "1", TRUE, FALSE);;
  }

  dimension: time_boost {
    group_label: "Boosts Used - Old"
    label: "Time Boost"
    type: string
    sql:IF(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.time_boost') >= "1", TRUE, FALSE);;
  }

  dimension: bubble_boost {
    group_label: "Boosts Used - Old"
    label: "Bubble Boost"
    type: string
    sql:IF(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.bubble_boost') >= "1", TRUE, FALSE);;
  }

  dimension: five_to_four_boost {
    group_label: "Boosts Used - Old"
    label: "5-to-4 Boost"
    type: string
    sql:IF(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.five_to_four_boost') >= "1", TRUE, FALSE);;
  }

###BOOST USED DIMENSIONS###
  dimension: score_boost_used {
    group_label: "Boosts Used"
    label: "Score Boost"
    type: number
    sql:CAST(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.score_boost') AS NUMERIC);;
  }
  measure:  score_boost_used_count {
    group_label: "Boosts Used"
    label: "Score Boost"
    type: count_distinct
    sql: ${score_boost_used} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: coin_boost_used {
    group_label: "Boosts Used"
    label: "Coin Boost"
    type: number
    sql:CAST(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.coin_boost') AS NUMERIC);;
  }
  measure:  coin_boost_used_count {
    group_label: "Boosts Used"
    label: "Coin Boost"
    type: count_distinct
    sql: ${coin_boost_used} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: exp_boost_used {
    group_label: "Boosts Used"
    label: "XP Boost"
    type: number
    sql:CAST(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.exp_boost') AS NUMERIC);;
  }
  measure:  exp_boost_used_count {
    group_label: "Boosts Used"
    label: "XP Boost"
    type: count_distinct
    sql: ${exp_boost_used} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: time_boost_used {
    group_label: "Boosts Used"
    label: "Time Boost"
    type: number
    sql:CAST(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.time_boost') AS NUMERIC);;
  }
  measure:  time_boost_used_count {
    group_label: "Boosts Used"
    label: "Time Boost"
    type: count_distinct
    sql: ${time_boost_used} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: bubble_boost_used {
    group_label: "Boosts Used"
    label: "Bubble Boost"
    type: number
    sql:CAST(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.bubble_boost') AS NUMERIC);;
  }
  measure:  bubble_boost_used_count {
    group_label: "Boosts Used"
    label: "Bubble Boost"
    type: count_distinct
    sql: ${bubble_boost_used} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
  dimension: five_to_four_boost_used {
    group_label: "Boosts Used"
    label: "5-to-4 Boost"
    type: number
    sql:CAST(JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.five_to_four_boost') AS NUMERIC);;
  }
  measure:  five_to_four_boost_used_count {
    group_label: "Boosts Used"
    label: "5-to-4 Boost"
    type: count_distinct
    sql: ${five_to_four_boost_used} ;;
    drill_fields: [user_id, user_first_seen_date, gems, coins, round_id, current_card_quest]
  }
###


###MEASURES###


  measure: avg_round_count {
    label: "Avg. Round Count"
    type: average
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  measure: round_count_025 {
    group_label: "Round Percentiles"
    label: "Rounds Played - 2.5%"
    type: percentile
    percentile: 2.5
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  measure: round_count_25 {
    group_label: "Round Percentiles"
    label: "Rounds Played - 25%"
    type: percentile
    percentile: 25
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  measure: round_count_med {
    group_label: "Round Percentiles"
    label: "Rounds Played - Median"
    type: median
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  measure: round_count_75 {
    group_label: "Round Percentiles"
    label: "Rounds Played - 75%"
    type: percentile
    percentile: 75
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  measure: round_count_975 {
    group_label: "Round Percentiles"
    label: "Rounds Played - 97.5%"
    type: percentile
    percentile: 97.5
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  #######

  measure: max_round_count {
    label: "Max Round Count"
    type: max
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }

  dimension: rounds {
    type: number
    sql: CAST(REPLACE(JSON_VALUE(${TABLE}.extra_json,'$.rounds'),'"','') AS NUMERIC) ;;
  }

  ########

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

  measure: tenure_days {
    group_label: "Tenure"
    type: number
    sql: TIMESTAMP_DIFF(MAX(${timestamp_raw}), min(${timestamp_raw}), DAY)
      ;;
  }

  measure: tenure_hours {
    group_label: "Tenure"
    type: number
    sql: TIMESTAMP_DIFF(MAX(${timestamp_raw}), min(${timestamp_raw}), HOUR)
    ;;
  }

  measure: tenure_minutes {
    group_label: "Tenure"
    type: number
    sql: TIMESTAMP_DIFF(MAX(${timestamp_raw}), min(${timestamp_raw}), MINUTE)
      ;;
  }

  measure: count_unique_person_id {
    label: "Player Count"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_id, user_first_seen_date, current_card_quest, device_model, device_model_number]
  }


  measure: count_unique_rdg_id {
    label: "RDG Player Count"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [user_id, user_first_seen_date, current_card_quest]
  }

  measure: count_unique_events {
    type: count_distinct
    sql: ${event_raw} ;;
  }

  ###################CHARACTER USED SKILL MEASURES###################

  measure: character_used_skill_sum {
    group_label: "character_used_skill_measures"
    type: sum
    sql: ${character_used_skill} ;;
  }

  measure: character_used_skill_avg {
    group_label: "character_used_skill_measures"
    type: average
    sql: ${character_used_skill} ;;
  }

  measure: 1_min_character_used_skill {
    group_label: "character_used_skill_measures"
    type: min
    sql: ${character_used_skill} ;;
  }

  measure: 2_25th_character_used_skill {
    group_label: "character_used_skill_measures"
    type: percentile
    percentile: 25
    sql: ${character_used_skill} ;;
  }

  measure: 3_median_character_used_skill {
    group_label: "character_used_skill_measures"
    type: median
    sql: ${character_used_skill} ;;
  }

  measure: 4_75th_character_used_skill {
    group_label: "character_used_skill_measures"
    type: percentile
    percentile: 75
    sql: ${character_used_skill} ;;
  }

  measure: 5_max_character_used_skill {
    group_label: "character_used_skill_measures"
    type: max
    sql: ${character_used_skill} ;;
  }

  ###############################################

  measure: churn_measure {
    type: percent_of_previous
    sql: COUNT(DISTINCT ${user_id}) ;;
  }

  measure: churn_decimal {
    type: number
    # sql: (((COUNT(DISTINCT ${user_id})) / (LAG(COUNT(DISTINCT ${user_id})) OVER(PARTITION BY MAX(${experiment_names}) ORDER BY MAX(${round_id})))) - 1) * 100 ;;
    sql: ((LAG(COUNT(DISTINCT ${user_id})) OVER(PARTITION BY MAX(${experiment_names}) ORDER BY MAX(${round_id}))) / (COUNT(DISTINCT ${user_id}))) - 1 ;;
  }

  # THIS IS HELPFUL - PLEASE DON'T ERASE. TO BE CLEANED
  # measure: churn_int_minutes {
  #   type: number
  #   # sql: ROUND(100 * (1 - ((LAG(COUNT(DISTINCT ${player_id})) OVER(ORDER BY MAX(${round_id}), MAX(CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp, 'America/Los_Angeles')) AS DATE)))) / COUNT(DISTINCT ${player_id}))), 0) ;;
  #   sql: ROUND(100 * (1-((LAG(COUNT(DISTINCT ${user_id})) OVER(ORDER BY COUNT(DISTINCT ${user_id}))) / COUNT(DISTINCT ${user_id}))), 0) ;;
  #   # sql: ROUND(100 * (1 - ((LAG(COUNT(DISTINCT ${user_id})) OVER(PARTITION BY MAX(${round_id}) ORDER BY MAX(${user_id}))) / COUNT(DISTINCT ${user_id}))), 0) ;;
  # }

  # measure: churn_decimal_minutes {
  #   type: number
  #   # sql: CASE
  #   #   WHEN MAX(${60_mins_since_install}) IN ("Below 2", "60 or Above")
  #   #   THEN 0
  #   #   ELSE (1 - ((LAG(COUNT(DISTINCT ${user_id})) OVER(ORDER BY COUNT(DISTINCT ${user_id}))) / COUNT(DISTINCT ${user_id})))
  #   #   END ;;
  #   sql:  (1 - ((LAG(COUNT(DISTINCT ${user_id})) OVER(ORDER BY COUNT(DISTINCT ${user_id}))) / COUNT(DISTINCT ${user_id})))  ;;
  # }


  ###################CURRENCY BALANCES MEASURES###################

  #PLAYER XP LEVEL (INTEGER)
  measure: 25th_player_xp_level {
    group_label: "player_xp_level_measures"
    type: percentile
    percentile: 25
    sql: ${player_xp_level_int} ;;
  }

  measure: median_player_xp_level {
    group_label: "player_xp_level_measures"
    type: median
    sql: ${player_xp_level_int} ;;
  }

  measure: 75th_player_xp_level {
    group_label: "player_xp_level_measures"
    type: percentile
    percentile: 75
    sql: ${player_xp_level_int} ;;
  }

  #PLAYER XP LEVEL (FLOAT)
  measure: 25th_player_xp_level_float {
    group_label: "player_xp_level_granular_measures"
    type: percentile
    percentile: 25
    sql: ${player_xp_level_rd_1} ;;
  }

  measure: median_player_xp_level_float {
    group_label: "player_xp_level_granular_measures"
    type: median
    sql: ${player_xp_level_rd_1} ;;
  }

  measure: 75th_player_xp_level_float {
    group_label: "player_xp_level_granular_measures"
    type: percentile
    percentile: 75
    sql: ${player_xp_level_rd_1} ;;
  }

  measure: count_characters {
    type: count_distinct
    # drill_fields: [character_used]
    sql: ${character_used} ;;
  }


  #############

  dimension: fb_users {
    type: string
    sql: CASE
        WHEN ${player_id} LIKE '%facebook%' THEN 'fb'
        ELSE 'out'
        END ;;
  }



}
