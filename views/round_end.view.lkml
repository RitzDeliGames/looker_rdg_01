include: "events.view"

view: round_end {
  extends: [events]

  dimension: eraser {
    type: string
    sql: JSON_EXTRACT_SCALAR(${extra_json},'$.team_slot_0') ;;
  }

  measure: max_ltv_2 {
    type: max
    label: "test total lifetime spend"
    sql: ${ltv} ;;
    value_format_name: usd
  }

}
