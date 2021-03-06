include: "/views/**/events.view"


view: count_quests_attempts {
  extends: [events]

  derived_table: {
    sql: SELECT
        MAX(timestamp) AS max_timestamp,
        created_at AS user_first_seen,
        user_id,
        user_type AS user_type_quest,
        CAST((CASE
                    WHEN events.current_card = 'card_001_a' THEN 100
                    WHEN events.current_card = 'card_001_untimed' THEN 100
                    WHEN events.current_card = 'card_002_a' THEN 200
                    WHEN events.current_card = 'card_002_untimed' THEN 200
                    WHEN events.current_card = 'card_003_a' THEN 300
                    WHEN events.current_card = 'card_003_untimed' THEN 300
                    WHEN events.current_card = 'card_002' THEN 400
                    WHEN events.current_card = 'card_004_untimed' THEN 400
                    WHEN events.current_card = 'card_003' THEN 500
                    WHEN events.current_card = 'card_005_untimed' THEN 500
                    WHEN events.current_card = 'card_004' THEN 600
                    WHEN events.current_card = 'card_006_untimed' THEN 600
                    WHEN events.current_card = 'card_005' THEN 700
                    WHEN events.current_card = 'card_006' THEN 800
                    WHEN events.current_card = 'card_007' THEN 900
                    WHEN events.current_card = 'card_008' THEN 1000
                    WHEN events.current_card = 'card_009' THEN 1100
                    WHEN events.current_card = 'card_010' THEN 1200
                    WHEN events.current_card = 'card_011' THEN 1300
                    WHEN events.current_card = 'card_012' THEN 1400
                    WHEN events.current_card = 'card_013' THEN 1500
                    WHEN events.current_card = 'card_014' THEN 1600
                    WHEN events.current_card = 'card_015' THEN 1700
                    WHEN events.current_card = 'card_016' THEN 1800
                    WHEN events.current_card = 'card_017' THEN 1900
                    WHEN events.current_card = 'card_018' THEN 2000
                END) + (CAST(REPLACE(JSON_VALUE(extra_json,'$.current_quest'),'"','') AS NUMERIC)) AS INT64) AS current_card_quest,
          (CASE
                    WHEN events.current_card = 'card_001_a' THEN '100'
                    WHEN events.current_card = 'card_001_untimed' THEN '100'
                    WHEN events.current_card = 'card_002_a' THEN '200'
                    WHEN events.current_card = 'card_002_untimed' THEN '200'
                    WHEN events.current_card = 'card_003_a' THEN '300'
                    WHEN events.current_card = 'card_003_untimed' THEN '300'
                    WHEN events.current_card = 'card_002' THEN '400'
                    WHEN events.current_card = 'card_004_untimed' THEN '400'
                    WHEN events.current_card = 'card_003' THEN '500'
                    WHEN events.current_card = 'card_005_untimed' THEN '500'
                    WHEN events.current_card = 'card_004' THEN '600'
                    WHEN events.current_card = 'card_006_untimed' THEN '600'
                    WHEN events.current_card = 'card_005' THEN '700'
                    WHEN events.current_card = 'card_006' THEN '800'
                    WHEN events.current_card = 'card_007' THEN '900'
                    WHEN events.current_card = 'card_008' THEN '1000'
                    WHEN events.current_card = 'card_009' THEN '1100'
                    WHEN events.current_card = 'card_010' THEN '1200'
                    WHEN events.current_card = 'card_011' THEN '1300'
                    WHEN events.current_card = 'card_012' THEN '1400'
                    WHEN events.current_card = 'card_013' THEN '1500'
                    WHEN events.current_card = 'card_014' THEN '1600'
                    WHEN events.current_card = 'card_015' THEN '1700'
                    WHEN events.current_card = 'card_016' THEN '1800'
                    WHEN events.current_card = 'card_017' THEN '1900'
                    WHEN events.current_card = 'card_018' THEN '2000'
                END) AS current_card,
        CAST(REPLACE(JSON_VALUE(extra_json,'$.current_quest'),'"','') AS NUMERIC) AS current_quest,
        experiments,
        version,
        install_version,
        REPLACE(JSON_EXTRACT(extra_json,"$.config_timestamp"),'"','') AS config_version,
        platform,
        hardware,
        COUNT(CAST(REPLACE(JSON_VALUE(extra_json,'$.current_quest'),'"','') AS NUMERIC)) AS count_attempts,
        MAX(JSON_VALUE(events.extra_json,'$.quest_complete'))  AS quest_complete_true,

      FROM `eraser-blast.game_data.events` AS events

      WHERE (NOT (CAST(REPLACE(JSON_VALUE(extra_json,'$.current_quest'),'"','') AS NUMERIC) IS NULL))
          AND (created_at  >= TIMESTAMP('2020-07-06 00:00:00')
          AND user_type = "external")

      GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13
       ;;
  }


  dimension_group: quest_event {
    # group_label: "Quests Attempts Dimensions"
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
    sql: ${TABLE}.max_timestamp ;;
  }

  dimension_group: quest_user_first_seen {
    # group_label: "Quests Attempts Dimensions"
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
    sql: ${TABLE}.user_first_seen ;;
  }

  dimension: user_id {
    group_label: "Quests Attempts Dimensions"
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_type {
    group_label: "Quests Attempts Dimensions"
    type: string
    sql: ${TABLE}.user_type_quest ;;
  }

  dimension: current_card_quest {
    group_label: "Quests Attempts Dimensions"
    type: string
    sql: ${TABLE}.current_card_quest ;;
  }

  dimension: current_card {
    group_label: "Quests Attempts Dimensions"
    type: string
    sql: ${TABLE}.current_card ;;
  }

  dimension: current_quest {
    group_label: "Quests Attempts Dimensions"
    type: number
    sql: ${TABLE}.current_quest ;;
  }

  dimension: count_attempts {
    group_label: "Quests Attempts Dimensions"
    type: number
    sql: ${TABLE}.count_attempts ;;
  }

  dimension: quest_complete_true {
    group_label: "Quests Attempts Dimensions"
    hidden: yes
    type: string
    sql: ${TABLE}.quest_complete_true ;;
  }

  dimension: experiment_names {
    group_label: "Quests Attempts Dimensions"
    type: string
    sql: @{experiment_ids} ;;
  }

  dimension: variants {
    group_label: "Quests Attempts Dimensions"
    type: string
    sql: REPLACE(@{variant_ids},'"','') ;;
  }

  dimension: version {
    # group_label: "Quests Attempts Dimensions"
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: install_version {
    # group_label: "Quests Attempts Dimensions"
    type: string
    sql: ${TABLE}.install_version ;;
  }

  dimension: config_version {
    # group_label: "Quests Attempts Dimensions"
    type: string
    sql: ${TABLE}.install_version ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
  }



  measure: 1_min {
    group_label: "quest_attempts_measures"
    type: min
    sql: ${count_attempts} ;;
  }

  measure: 2_25th {
    group_label: "quest_attempts_measures"
    type: percentile
    percentile: 25
    sql: ${count_attempts} ;;
  }

  measure: 3_median {
    group_label: "quest_attempts_measures"
    type: median
    sql: ${count_attempts} ;;
  }

  measure: 4_75th {
    group_label: "quest_attempts_measures"
    type: percentile
    percentile: 75
    sql: ${count_attempts} ;;
  }

  measure: 5_max {
    group_label: "quest_attempts_measures"
    type: max
    sql: ${count_attempts} ;;
  }

  set: detail {
    fields: [
      timestamp_time,
      user_id,
      user_type,
      current_card_quest,
      current_card,
      current_quest,
      count_attempts,
      experiments
    ]
  }
}
