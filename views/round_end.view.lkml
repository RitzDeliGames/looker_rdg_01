include: "events.view"

view: round_end {
  extends: [events]

  measure: max_ltv_2 {
    type: max
    label: "test total lifetime spend"
    sql: ${ltv} ;;
    value_format_name: usd
  }

}
