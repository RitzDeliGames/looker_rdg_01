include: "events.view"

view: round_end {
  extends: [events]

  dimension: eraser {
    type: string
    label: "eraser"
    description: "eraser equipped in the first team slot"
    sql: JSON_EXTRACT(${extra_json},'$.team_slot_0') ;;
  }

  dimension: eraser_skill_level {
    type: number
    label: "eraser skill"
    description: "eraser skill level"
    sql: REPLACE(JSON_EXTRACT(${extra_json},'$.team_slot_skill_0'),'"','') ;;
  }

  dimension: eraser_xp_level {
    type: number
    label: "eraser xp"
    description: "eraser xp level"
    sql: REPLACE(JSON_EXTRACT(${extra_json},'$.team_slot_level_0'),'"','') ;;
  }

  dimension: coins_earned {
    type: number
    label: "coins earned"
    description: "amount coins earned per round"
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$.coins_earned'),'"','') as NUMERIC) ;;
  }

  dimension: score_earned {
    type: number
    label: "score"
    description: "amount points earned per round"
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$.score_earned'),'"','') as NUMERIC) ;;
  }

  dimension: xp_earned {
    type: number
    label: "player xp earned"
    description: "amount player xp earned per round"
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},'$.xp_earned'),'"','') as NUMERIC) ;;
  }

  measure: total_coins_earned {
    type: sum
    label: "total coins earned"
    description: "sum of coins earned in a single round"
    sql: ${coins_earned} ;;
  }

  parameter: boxplot_type {
    type: string
    allowed_value: {
      label: "coins earned"
      value: "coins earned"
    }
    allowed_value: {
      label: "points scored"
      value: "points scored"
    }
    allowed_value: {
      label: "xp earned"
      value: "xp earned"
    }
  }

}
