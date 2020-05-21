include: "/views/**/events.view"

view: fue_funnel {
  extends: [events]


  parameter: FUE_step_ID {
    allowed_value: {
      label: "FIRST_PLAY"
      value: "FIRST_PLAY"
    }

    allowed_value: {
      label: "BINGO_CARD_INTRO"
      value: "BINGO_CARD_INTRO"
    }
  }

  dimension: FUE_step {
    type: string
    sql: REPLACE(JSON_EXTRACT(extra_json,"$.current_FueStep"),'"','') = {% parameter FUE_step_ID %} ;;
  }

}
