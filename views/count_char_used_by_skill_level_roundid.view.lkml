view: count_char_used_by_skill_level_roundid {
  derived_table: {
    sql: SELECT
        CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) AS events_round_id,
        CAST(REPLACE(JSON_EXTRACT(events.extra_json,'$.team_slot_skill_0'),'"','') AS NUMERIC) AS events_character_used_skill,
        COUNT(DISTINCT (REPLACE(JSON_EXTRACT(events.extra_json,'$.team_slot_0'),'"','')) ) AS events_count_characters
      FROM `eraser-blast.game_data.events` AS events

      WHERE (((CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) >= 0 AND CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) <= 40))) AND (NOT (CAST(REPLACE(JSON_EXTRACT(events.extra_json,'$.team_slot_skill_0'),'"','') AS NUMERIC) IS NULL OR CAST(REPLACE(JSON_EXTRACT(events.extra_json,'$.team_slot_skill_0'),'"','') AS NUMERIC) IS NULL)) AND (user_type NOT IN ("internal_editor", "unit_test"))
      GROUP BY 1,2
      --ORDER BY 2 ,1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: events_round_id {
    type: number
    sql: ${TABLE}.events_round_id ;;
  }

  dimension: events_character_used_skill {
    type: number
    sql: ${TABLE}.events_character_used_skill ;;
  }

  dimension: events_count_characters {
    type: number
    sql: ${TABLE}.events_count_characters ;;
  }

  measure: 1_min {
    type: min
    sql: ${events_count_characters} ;;
  }

  measure: 3_median {
    type: median
    sql: ${events_count_characters} ;;
  }

  measure: 2_25_th {
    type: percentile
    percentile: 25
    sql: ${events_count_characters} ;;
  }

  measure: 4_75_th {
    type: percentile
    percentile: 75
    sql: ${events_count_characters} ;;
  }

  measure: 5_max {
    type: max
    sql: ${events_count_characters} ;;
  }


  set: detail {
    fields: [events_round_id, events_character_used_skill, events_count_characters]
  }
}
