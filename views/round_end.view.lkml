include: "events.view"

view: round_end {
  extends: [events]

  dimension: eraser {
    type: string
    sql: JSON_EXTRACT_SCALAR(${extra_json},'$.team_slot_0') ;;
  }

  dimension: eraser_skill_level {
    type: number
    sql: REPLACE(JSON_EXTRACT(${extra_json},'$.team_slot_skill_0'),'"','') ;;
  }

  dimension: eraser_xp_level {
    type: number
    sql: REPLACE(JSON_EXTRACT(${extra_json},'$.team_slot_level_0'),'"','') ;;
  }

  dimension: coins_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$.coins_earned'),'"','') as NUMERIC) ;;
  }

  dimension: score_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$.score_earned'),'"','') as NUMERIC) ;;
  }

  dimension: xp_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$.xp_earned'),'"','') as NUMERIC) ;;
  }

  measure: total_coins_earned {
    type: sum
    label: "total coins earned"
    description: "sum of coins earned in a single round"
    sql: ${coins_earned} ;;
  }

}
