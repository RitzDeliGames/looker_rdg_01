view: max_rounds_for_card_finished {
  derived_table: {
    sql: SELECT
      user_id,
      session_id,
      version,
      user_type,
      timestamp,
      CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS DATE) AS event_date,
      JSON_Value(extra_json, '$.card_id') AS card_id,
      JSON_EXTRACT(extra_json, '$.card_end_time') AS card_end_time,
      MAX(CAST(JSON_Value(extra_json,'$.rounds') AS NUMERIC)) AS round_max
FROM events
WHERE event_name = 'cards'
  AND ((JSON_EXTRACT(extra_json, '$.card_end_time')) IS NOT NULL)
GROUP BY user_id, event_date, card_id, card_end_time, session_id, version, user_type, timestamp
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

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
  }

  dimension: event_date {
    type: date
    sql: CAST(${TABLE}.event_date AS TIMESTAMP) ;;
  }

  dimension: card_id {
    type: string
    sql: ${TABLE}.card_id ;;
  }

  dimension: card_end_time {
    type: string
    sql: ${TABLE}.card_end_time ;;
  }

  dimension: round_max {
    type: number
    sql: ${TABLE}.round_max ;;
  }


  ### MEASURES ###

  measure: 1_min_ {
    group_label: "descriptive Statistics Measures"
    type: min
    sql: ${round_max} ;;
  }

  measure: 5_max_ {
    group_label: "descriptive Statistics Measures"
    type: max
    sql: ${round_max} ;;
  }

  measure: 3_median_ {
    group_label: "descriptive Statistics Measures"
    type: median
    sql: ${round_max} ;;

  }

  measure: 2_25th_ {
    group_label: "descriptive Statistics Measures"
    type: percentile
    percentile: 25
    sql: ${round_max} ;;

  }

  measure: 4_75th_ {
    group_label: "descriptive Statistics Measures"
    type: percentile
    percentile: 75
    sql: ${round_max} ;;
  }


  set: detail {
    fields: [
      user_id,
      session_id,
      version,
      user_type,
      timestamp_time,
      event_date,
      card_id,
      card_end_time,
      round_max
    ]
  }
}
