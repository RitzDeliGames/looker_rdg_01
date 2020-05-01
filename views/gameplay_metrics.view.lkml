include: "events.view"

view: gameplay_metrics {
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

  dimension: ltv {
    hidden: yes
  }

  dimension: event_name {
    hidden: yes
  }

  ##### MEASURES #####

  measure: total_coins_earned {
    type: sum
    label: "total coins earned"
    description: "sum of coins earned in a single round"
    sql: ${coins_earned} ;;
  }

  measure: 1_min_boxplot {
    group_label: "bloxplot"
    label: "min"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_type %} = "coins earned"
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = "points scored"
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = "xp earned"
      THEN ${xp_earned}
    END  ;;
  }

  measure: 5_max_boxplot {
    group_label: "bloxplot"
    label: "max"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_type %} = "coins earned"
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = "points scored"
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = "xp earned"
      THEN ${xp_earned}
    END  ;;
  }

  measure: 3_median_boxplot {
    group_label: "bloxplot"
    label: "median"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_type %} = "coins earned"
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = "points scored"
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = "xp earned"
      THEN ${xp_earned}
    END  ;;
  }

  measure: 2_25th_boxplot {
    group_label: "bloxplot"
    label: "inner quartile"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_type %} = "coins earned"
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = "points scored"
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = "xp earned"
      THEN ${xp_earned}
    END  ;;
  }

  measure: 4_75th_boxplot {
    group_label: "bloxplot"
    label: "outer quartile"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_type %} = "coins earned"
      THEN ${coins_earned}
      WHEN  {% parameter boxplot_type %} = "points scored"
      THEN ${score_earned}
      WHEN  {% parameter boxplot_type %} = "xp earned"
      THEN ${xp_earned}
    END  ;;
  }

  ##### PARAMETERS #####

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
