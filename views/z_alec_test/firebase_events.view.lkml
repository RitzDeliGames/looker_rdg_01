view: firebase_events {
  sql_table_name:`eraser-blast.analytics_215101505.events_*` ;;

  filter: current_period_filter {
    type: date_time
    description: "Use this filter to define the current and previous period for analysis"
    sql: (_Table_Suffix BETWEEN REPLACE(SUBSTR(STRING({% date_start current_period_filter %}),0,10),"-","")
                AND REPLACE(SUBSTR(STRING({% date_end current_period_filter %} ),0,10),"-",""))
                and timestamp(parse_date("%Y%m%d",event_date)) BETWEEN {% date_start current_period_filter %} AND  {% date_end current_period_filter %}
                ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: event_date {
    type: string
    sql: ${TABLE}.event_date ;;
  }

  dimension: event_timestamp {
    type: number
    sql: ${TABLE}.event_timestamp ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: event_params {
    type: string
    sql: ${TABLE}.event_params ;;
  }

  dimension: event_previous_timestamp {
    type: number
    sql: ${TABLE}.event_previous_timestamp ;;
  }

  dimension: event_value_in_usd {
    type: number
    sql: ${TABLE}.event_value_in_usd ;;
  }

  dimension: event_bundle_sequence_id {
    type: number
    sql: ${TABLE}.event_bundle_sequence_id ;;
  }

  dimension: event_server_timestamp_offset {
    type: number
    sql: ${TABLE}.event_server_timestamp_offset ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_pseudo_id {
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
  }

  dimension: user_properties {
    type: string
    sql: ${TABLE}.user_properties ;;
  }

  dimension: user_first_touch_timestamp {
    type: number
    sql: ${TABLE}.user_first_touch_timestamp ;;
  }

  dimension: user_ltv {
    type: string
    sql: ${TABLE}.user_ltv ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: geo {
    type: string
    sql: ${TABLE}.geo ;;
  }

  dimension: app_info {
    type: string
    sql: ${TABLE}.app_info ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: stream_id {
    type: string
    sql: ${TABLE}.stream_id ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: event_dimensions {
    type: string
    sql: ${TABLE}.event_dimensions ;;
  }

  dimension: ecommerce {
    type: string
    sql: ${TABLE}.ecommerce ;;
  }

  dimension: items {
    type: string
    sql: ${TABLE}.items ;;
  }

  set: detail {
    fields: [
      event_date,
      event_timestamp,
      event_name,
      event_params,
      event_previous_timestamp,
      event_value_in_usd,
      event_bundle_sequence_id,
      event_server_timestamp_offset,
      user_id,
      user_pseudo_id,
      user_properties,
      user_first_touch_timestamp,
      user_ltv,
      device,
      geo,
      app_info,
      traffic_source,
      stream_id,
      platform,
      event_dimensions,
      ecommerce,
      items
    ]
  }
}
