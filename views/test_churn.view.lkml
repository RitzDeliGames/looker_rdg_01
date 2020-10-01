view: test_churn {
  derived_table: {
    sql: SELECT
      user_id,
      JSON_EXTRACT(extra_json,'$.card_state') AS completed_tiles,
      JSON_EXTRACT(extra_json,'$.card_state_progress') AS current_tile,
      COUNT(timestamp) AS attempts

FROM `eraser-blast.game_data.events`
WHERE event_name = 'cards'
  AND current_card = 'card_001_a'
  AND JSON_EXTRACT(experiments,'$.earlyExitContent_20200909') = '"variant_a"'
  -- AND JSON_EXTRACT(extra_json,'$.card_state_progress') = '[9]'
  -- AND JSON_EXTRACT(extra_json, '$.card_state') = '[7]'
  -- AND user_id = 'anon-2bdeb1fa-dac9-4080-94cb-49a47a03fa75'
GROUP BY 1, 2, 3
ORDER BY 3 DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: completed_tiles {
    type: string
    sql: ${TABLE}.completed_tiles ;;
  }

  dimension: current_tile {
    type: string
    sql: ${TABLE}.current_tile ;;
  }

  dimension: attempts {
    type: number
    sql: ${TABLE}.attempts ;;
  }

  dimension: x_axis {
    type: string
    sql: 1=1 ;;
  }

  measure: attempts_measure {
    type: sum
    sql: ${attempts} ;;
  }

  set: detail {
    fields: [user_id, completed_tiles, current_tile, attempts]
  }
}
