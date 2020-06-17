view: test_player_analysis {
  derived_table: {
    sql: SELECT CAST(JSON_VALUE(extra_json, '$.round_id') AS NUMERIC) as round_id,
          coins,
          gems,
          player_level_xp AS player_xp,
FROM
events
WHERE event_name = 'round_end'
AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }

  dimension: coins {
    type: number
    sql: ${TABLE}.coins ;;
  }

  dimension: gems {
    type: number
    sql: ${TABLE}.gems ;;
  }

  dimension: player_xp {
    type: number
    sql: ${TABLE}.player_xp ;;
  }

  set: detail {
    fields: [round_id, coins, gems, player_xp]
  }
}
