view: bingo_card_attempts_aggregated {
  derived_table: {
    sql: WITH bingo_card_attempts AS (SELECT
        events.user_id  AS user_id,
        events.timestamp  AS timestamp,
        events.install_version  AS install_version,
        events.current_card  AS current_card,
        events.experiments AS experiments,
        (CASE
                    WHEN events.current_card = 'card_001_a' THEN 100
                    WHEN events.current_card = 'card_001_untimed' THEN 100
                    WHEN events.current_card = 'card_002_a' THEN 200
                    WHEN events.current_card = 'card_002_untimed' THEN 200
                    WHEN events.current_card = 'card_003_a' THEN 300
                    WHEN events.current_card = 'card_003_untimed' THEN 300
                    WHEN events.current_card = 'card_002' THEN 400
                    WHEN events.current_card = 'card_002_inverted' THEN 400
                    WHEN events.current_card = 'card_039' THEN 400
                    WHEN events.current_card = 'card_004_untimed' THEN 400
                    WHEN events.current_card = 'card_003' THEN 500
                    WHEN events.current_card = 'card_040' THEN 500
                    WHEN events.current_card = 'card_005_untimed' THEN 500
                    WHEN events.current_card = 'card_004' THEN 600
                    WHEN events.current_card = 'card_041' THEN 600
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
                END) + (CAST(REPLACE(JSON_VALUE(events.extra_json,'$.current_quest'),'"','') AS NUMERIC)) AS current_card_quest,
        events.extra_json  AS extra_json
      FROM `eraser-blast.game_data.events` AS events

      WHERE (events.event_name = 'cards') AND (created_at  >= TIMESTAMP('2020-07-06 00:00:00')
          AND user_type = "external"
          AND events.user_id NOT IN ("anon-c39ef24b-bb78-4339-9e42-befd5532a5d4"))
      GROUP BY 1,2,3,4,5,6,7)
      SELECT
        bingo_card_attempts.user_id AS bingo_card_attempts_user_id,
        bingo_card_attempts.current_card AS bingo_card_attempts_current_card,
        bingo_card_attempts.install_version AS bingo_card_attempts_install_version,
        CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64) AS bingo_card_attempts_current_quest,
        bingo_card_attempts.current_card_quest AS bingo_card_attempts_current_card_quest,
        bingo_card_attempts.experiments AS bingo_card_attempts_experiments,
        COUNT(CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.node_attempts_explicit") AS INT64)) AS bingo_card_attempts_attempts_count,
        MAX(CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.node_attempts_explicit") AS INT64)) AS bingo_card_attempts_explicit_attempts,
        MAX(CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.node_attempts_passive") AS INT64)) AS bingo_card_attempts_passive_attempts,
        MAX(CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.rounds") AS INT64)) AS bingo_card_attempts_rounds
      FROM bingo_card_attempts
      WHERE ((CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64) >= 1))
      GROUP BY 1,2,3,4,5,6
      ORDER BY 1 ,2 DESC,4
       ;;
  }

  dimension: install_version {
    type: string
    sql: ${TABLE}.bingo_card_attempts_install_version ;;
  }

  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }

  dimension: bingo_card_attempts_user_id {
    type: string
    sql: ${TABLE}.bingo_card_attempts_user_id ;;
  }

  measure:  bingo_card_attempts_player_count {
    type: count_distinct
    sql: ${TABLE}.bingo_card_attempts_user_id ;;
  }

  dimension: bingo_card_attempts_current_card {
    type: string
    sql: ${TABLE}.bingo_card_attempts_current_card ;;
  }

  dimension: bingo_card_attempts_current_card_no {
    type: number
    sql: @{current_card_numbered} ;;
  }

  dimension: bingo_card_attempts_current_quest {
    type: number
    sql: ${TABLE}.bingo_card_attempts_current_quest ;;
  }

  dimension: bingo_card_attempts_current_card_quest {
    type: number
    sql: ${TABLE}.bingo_card_attempts_current_card_quest ;;
  }

  dimension: bingo_card_attempts_current_card_quest_str {
    type: string
    value_format: "*00#"
    sql: ${TABLE}.bingo_card_attempts_current_card_quest ;;
  }

  dimension: bingo_card_attempts_attempts_count {
    type: number
    sql: ${TABLE}.bingo_card_attempts_attempts_count ;;
  }

  dimension: experiments {
    type: string
    sql: ${TABLE}.bingo_card_attempts_experiments ;;
  }

  dimension: experiment_names {
    type: string
    sql: @{experiment_ids} ;;
  }

  dimension: variant_ids {
    sql: @{variant_ids} ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: attempts_sum {
    type: sum
    sql:  ${TABLE}.bingo_card_attempts_attempts_count ;;
  }

  measure: attempts_min {
    type: min
    sql:  ${TABLE}.bingo_card_attempts_attempts_count ;;
  }

  measure: attempts_25th {
    type: percentile
    percentile: 25
    sql:  ${TABLE}.bingo_card_attempts_attempts_count ;;
  }

  measure: attempts_med {
    type: median
    sql:  ${TABLE}.bingo_card_attempts_attempts_count ;;
  }

  measure: attempts_75th {
    type: percentile
    percentile: 75
    sql:  ${TABLE}.bingo_card_attempts_attempts_count ;;
  }

  measure: attempts_max {
    type: max
    sql:  ${TABLE}.bingo_card_attempts_attempts_count ;;
  }

  dimension: bingo_card_attempts_explicit_attempts {
    label: "Explicit Attempts - Max"
    type: number
    sql: ${TABLE}.bingo_card_attempts_explicit_attempts ;;
  }

  measure:  bingo_card_attempts_explicit_attempts_max {
    label: "Explicit Attempts - Max"
    type: max
    sql: ${bingo_card_attempts_explicit_attempts} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_explicit_attempts_975 {
    label: "Explicit Attempts - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${bingo_card_attempts_explicit_attempts} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_explicit_attempts_75 {
    label: "Explicit Attempts - 75%"
    type: percentile
    percentile: 75
    sql: ${bingo_card_attempts_explicit_attempts} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_explicit_attempts_med {
    label: "Explicit Attempts - Median"
    type: median
    sql: ${bingo_card_attempts_explicit_attempts} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_explicit_attempts_25 {
    label: "Explicit Attempts - 25%"
    type: percentile
    percentile: 25
    sql: ${bingo_card_attempts_explicit_attempts} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_explicit_attempts_025 {
    label: "Explicit Attempts - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${bingo_card_attempts_explicit_attempts} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_explicit_attempts_min {
    label: "Explicit Attempts - Min"
    type: min
    sql: ${bingo_card_attempts_explicit_attempts} ;;
    drill_fields: [detail*]
  }

  dimension: bingo_card_attempts_total_rounds {
    label: "Total Rounds - Max"
    type: number
    sql: ${TABLE}.bingo_card_attempts_rounds ;;
  }

  measure:  bingo_card_attempts_total_rounds_max {
    label: "Total Rounds - Max"
    type: max
    sql: ${bingo_card_attempts_total_rounds} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_total_rounds_975 {
    label: "Total Rounds - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${bingo_card_attempts_total_rounds} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_total_rounds_75 {
    label: "Total Rounds - 75%"
    type: percentile
    percentile: 75
    sql: ${bingo_card_attempts_total_rounds} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_total_rounds_med {
    label: "Total Rounds - Median"
    type: median
    sql: ${bingo_card_attempts_total_rounds} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_total_rounds_25 {
    label: "Total Rounds - 25%"
    type: percentile
    percentile: 25
    sql: ${bingo_card_attempts_total_rounds} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_total_rounds_025 {
    label: "Total Rounds - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${bingo_card_attempts_total_rounds} ;;
    drill_fields: [detail*]
  }

  measure:  bingo_card_attempts_total_rounds_min {
    label: "Total Rounds - Min"
    type: min
    sql: ${bingo_card_attempts_total_rounds} ;;
    drill_fields: [detail*]
  }

  set: detail {
    fields: [bingo_card_attempts_user_id, bingo_card_attempts_current_card, bingo_card_attempts_current_quest, bingo_card_attempts_current_card_quest, bingo_card_attempts_attempts_count]
  }
}
