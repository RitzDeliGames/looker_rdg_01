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

  dimension: coins {
    group_label: "Currency Balances"
    label: "Coins"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.currencies,'$.CURRENCY_03'),'"','') as NUMERIC);;
  }

  dimension: lives {
    group_label: "Currency Balances"
    label: "Lives"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.currencies,'$.CURRENCY_04'),'"','') as NUMERIC);;
  }

  dimension: box_001_tickets {
    group_label: "Capsule Tickets"
    label: "box 001 tickets"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.box_001'),'"','') as NUMERIC);;
  }

  dimension: box_002_tickets {
    group_label: "Capsule Tickets"
    label: "box 002 tickets"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.box_002'),'"','') as NUMERIC);;
  }

  dimension: box_003_tickets {
    group_label: "Capsule Tickets"
    label: "box 003 tickets"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.box_003'),'"','') as NUMERIC);;
  }

  dimension: box_006_tickets {
    group_label: "Capsule Tickets"
    label: "box 006 tickets"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.box_006'),'"','') as NUMERIC);;
  }

  dimension: box_007_tickets {
    group_label: "Capsule Tickets"
    label: "box 007 tickets"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.box_007'),'"','') as NUMERIC);;
  }

  dimension: score_tickets {
    group_label: "Boost Inventory"
    label: "Score Boost"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.SCORE'),'"','') as NUMERIC);;
  }

  dimension: bubble_tickets {
    group_label: "Boost Inventory"
    label: "Bubble Boost"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.BUBBLE'),'"','') as NUMERIC);;
  }

  dimension: time_tickets {
    group_label: "Boost Inventory"
    label: "Time Boost"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.TIME'),'"','') as NUMERIC);;
  }

  dimension: five_to_four_tickets {
    group_label: "Boost Inventory"
    label: "5-to-4 Boost"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.FIVE_TO_FOUR'),'"','') as NUMERIC);;
  }

  dimension: exp_tickets {
    group_label: "Boost Inventory"
    label: "XP Boost"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.EXP'),'"','') as NUMERIC);;
  }

  dimension: coin_tickets {
    group_label: "Boost Inventory"
    label: "Coin Boost"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.tickets,'$.Coin'),'"','') as NUMERIC);;
  }

  dimension: skill {
    group_label: "missing"
    label: "Skill"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(tickets,'$.SKILL'),'"','') as NUMERIC) ;;
  }

  dimension: level {
    group_label: "missing"
    label: "Level"
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(tickets,'$.LEVEL'),'"','') as NUMERIC) ;;
  }

  dimension: engagement_ticks {
    # group_label: "missing"
    label: "Engagement Ticks"
    type: number
    sql: ${TABLE}.engagement_ticks ;;
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
    sql: CAST(REPLACE(JSON_VALUE(${TABLE}.extra_json,'$.current_quest'),'"','') AS NUMERIC);;
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
    label: "Score Boost Used"
    type: number
    sql: CAST(JSON_Value(${extra_json},'$.round_length') AS NUMERIC) / 1000  ;;
  }

###BOOST USED DIMENSIONS###

  dimension: score_boost {
    group_label: "Boosts Used"
    label: "Score Boost"
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.score_boost'),'"','') >= "1", TRUE, FALSE);;
  }

  dimension: coin_boost {
    group_label: "Boosts Used"
    label: "Coin Boost"
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.coin_boost'),'"','') >= "1", TRUE, FALSE);;
  }

  dimension: exp_boost {
    group_label: "Boosts Used"
    label: "XP Boost"
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.exp_boost'),'"','') >= "1", TRUE, FALSE);;
  }

  dimension: time_boost {
    group_label: "Boosts Used"
    label: "Time Boost"
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.time_boost'),'"','') >= "1", TRUE, FALSE);;
  }

  dimension: bubble_boost {
    group_label: "Boosts Used"
    label: "Bubble Boost"
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.bubble_boost'),'"','') >= "1", TRUE, FALSE);;
  }

  dimension: five_to_four_boost {
    group_label: "Boosts Used"
    label: "5-to-4 Boost"
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.five_to_four_boost'),'"','') >= "1", TRUE, FALSE);;
  }


###


###MEASURES###


  measure: avg_round_count {
    label: "Avg. Round Count"
    type: average
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
