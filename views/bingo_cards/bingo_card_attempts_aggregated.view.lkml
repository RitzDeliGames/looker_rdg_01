view: bingo_card_attempts_aggregated {
  derived_table: {
    sql: WITH bingo_card_attempts AS (SELECT
        events.user_id  AS user_id,
        events.timestamp  AS timestamp,
        events.install_version  AS install_version,
        events.current_card  AS current_card,
        (CASE
                    WHEN events.current_card = 'card_001_a' THEN 100
                    WHEN events.current_card = 'card_001_untimed' THEN 100
                    WHEN events.current_card = 'card_002_a' THEN 200
                    WHEN events.current_card = 'card_002_untimed' THEN 200
                    WHEN events.current_card = 'card_003_a' THEN 300
                    WHEN events.current_card = 'card_003_untimed' THEN 300
                    WHEN events.current_card = 'card_002' THEN 400
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
      GROUP BY 1,2,3,4,5,6)
      SELECT
        bingo_card_attempts.user_id AS bingo_card_attempts_user_id,
        bingo_card_attempts.current_card AS bingo_card_attempts_current_card,
        CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64) AS bingo_card_attempts_current_quest,
        bingo_card_attempts.current_card_quest AS bingo_card_attempts_current_card_quest,
        COUNT(DISTINCT (CAST(JSON_EXTRACT(JSON_EXTRACT_ARRAY(extra_json, "$.node_data")[ORDINAL(CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64))],"$.rounds") AS INT64)) ) AS bingo_card_attempts_attempts_count
      FROM bingo_card_attempts

      WHERE (((CASE
                  WHEN bingo_card_attempts.install_version LIKE '1568' THEN 'Release 1.0.001'
                  WHEN bingo_card_attempts.install_version LIKE '1579' THEN 'Release 1.0.100'
                  WHEN bingo_card_attempts.install_version LIKE '2047' THEN 'Release 1.1.001'
                  WHEN bingo_card_attempts.install_version LIKE '2100' THEN 'Release 1.1.100'
                  WHEN bingo_card_attempts.install_version LIKE '3028' THEN 'Release 1.2.028'
                  WHEN bingo_card_attempts.install_version LIKE '3043' THEN 'Release 1.2.043'
                  WHEN bingo_card_attempts.install_version LIKE '3100' THEN 'Release 1.2.100'
                  WHEN bingo_card_attempts.install_version LIKE '4017' THEN 'Release 1.3.017'
                  WHEN bingo_card_attempts.install_version LIKE '4100' THEN 'Release 1.3.100'
                  WHEN bingo_card_attempts.install_version LIKE '5006' THEN 'Release 1.5.006'
                  WHEN bingo_card_attempts.install_version LIKE '5100' THEN 'Release 1.5.100'
                  WHEN bingo_card_attempts.install_version LIKE '6001' THEN 'Release 1.6.001'
                  WHEN bingo_card_attempts.install_version LIKE '6100' THEN 'Release 1.6.100'
                  WHEN bingo_card_attempts.install_version LIKE '6200' THEN 'Release 1.6.200'
                  WHEN bingo_card_attempts.install_version LIKE '6300' THEN 'Release 1.6.300'
                  WHEN bingo_card_attempts.install_version LIKE '6400' THEN 'Release 1.6.400'
                  WHEN bingo_card_attempts.install_version LIKE '7100' THEN 'Release 1.7.100'
                  WHEN bingo_card_attempts.install_version LIKE '7200' THEN 'Release 1.7.200'
                  WHEN bingo_card_attempts.install_version LIKE '7300' THEN 'Release 1.7.300'
                  WHEN bingo_card_attempts.install_version LIKE '7400' THEN 'Release 1.7.400'
                  WHEN bingo_card_attempts.install_version LIKE '7500' THEN 'Release 1.7.500'
                END) = 'Release 1.7.500')) AND ((bingo_card_attempts.current_card IN ('card_001_a', 'card_002_a', 'card_003_a', 'card_002'))) AND ((CAST(JSON_EXTRACT(extra_json,"$.current_quest") AS INT64) >= 1))
      GROUP BY 1,2,3,4
      ORDER BY 1 ,2 DESC,4
      LIMIT 500
       ;;
  }

  dimension: bingo_card_attempts_user_id {
    type: string
    sql: ${TABLE}.bingo_card_attempts_user_id ;;
  }

  dimension: bingo_card_attempts_current_card {
    type: string
    sql: ${TABLE}.bingo_card_attempts_current_card ;;
  }

  dimension: bingo_card_attempts_current_quest {
    type: number
    sql: ${TABLE}.bingo_card_attempts_current_quest ;;
  }

  dimension: bingo_card_attempts_current_card_quest {
    type: number
    sql: ${TABLE}.bingo_card_attempts_current_card_quest ;;
  }

  dimension: bingo_card_attempts_attempts_count {
    type: number
    sql: ${TABLE}.bingo_card_attempts_attempts_count ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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


  set: detail {
    fields: [bingo_card_attempts_user_id, bingo_card_attempts_current_card, bingo_card_attempts_current_quest, bingo_card_attempts_current_card_quest, bingo_card_attempts_attempts_count]
  }
}
