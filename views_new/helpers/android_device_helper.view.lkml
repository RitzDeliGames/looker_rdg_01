view: android_device_helper {
  derived_table: {
    sql:  select *
          from `eraser-blast.game_data.supported_devices`
          where retail_name != "Retail Branding"
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: retail_name {
    type: string
    sql: ${TABLE}.retail_name ;;
  }

  dimension: marketing_name {
    type: string
    sql: ${TABLE}.marketing_name ;;
  }

  dimension: device_name {
    type: string
    sql: ${TABLE}.device_name ;;
  }

  dimension: model_name {
    type: string
    sql: ${TABLE}.model_name ;;
  }

  dimension: retail_model {
    type: string
    sql: LOWER(CONCAT(${retail_name}," ",${model_name})) ;;
  }

  set: detail {
    fields: [retail_name, marketing_name, device_name, model_name]
  }
}
