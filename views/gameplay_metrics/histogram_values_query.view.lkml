view: histogram_values_query {
  derived_table: {
    sql: SELECT extra_json,
       user_type,
       platform,
       version
FROM events
WHERE event_name = 'round_end'
AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: extra_json {
    hidden: no
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: version {
    type: string
    sql: ${TABLE}.version ;;
  }

  dimension: team_slot_0 {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_0') ;;
  }

  dimension: team_slot_skill_0 {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_skill_0') ;;
  }

  dimension: team_slot_level_0 {
    type: string
    sql: JSON_Value(extra_json,'$.team_slot_level_0') ;;
  }

  dimension: frame_time_histogram_observations {
    type: string
    sql: frame_time_histogram_observations ;;
  }

  dimension: frame_time_histogram_values {
    type: string
    sql: JSON_Value(extra_json,'$.frame_time_histogram_values') ;;
  }



  set: detail {
    fields: [
      extra_json,
      user_type,
      platform,
      version,
      team_slot_0,
      team_slot_skill_0,
      team_slot_level_0,
      frame_time_histogram_observations,
      frame_time_histogram_values
    ]
  }
}
