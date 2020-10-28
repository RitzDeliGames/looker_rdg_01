view: characters_collection_iii {
  derived_table: {
    sql: SELECT
          user_id
          , session_id
          , timestamp AS event
          , created_at AS user_first_seen
          , COUNT(DISTINCT JSON_EXTRACT(characters_coll, '$.character_id')) AS char_id_count

      FROM `eraser-blast.game_data.events` AS events
      CROSS JOIN UNNEST(JSON_EXTRACT_ARRAY(extra_json, '$.characters')) AS characters_coll
      WHERE event_name IN ('collection')
      GROUP BY 1,2,3,4
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

  dimension_group: event {
    type: time
    sql: ${TABLE}.event ;;
  }

  dimension_group: user_first_seen {
    type: time
    sql: ${TABLE}.user_first_seen ;;
  }

  dimension: char_id_count {
    type: number
    sql: ${TABLE}.char_id_count ;;
  }

  ###MEASURES###

  measure: average_chars {
    group_label: "1. Character Collection"
    type: average
    sql: ${char_id_count} ;;
  }

  measure: median_chars {
    group_label: "1. Character Collection"
    type: median
    sql: ${char_id_count} ;;
  }

  measure: 25th_quartile {
    group_label: "1. Character Collection"
    type: percentile
    percentile: 25
    sql: ${char_id_count} ;;
  }

  measure: 75th_quartile {
    group_label: "1. Character Collection"
    type: percentile
    percentile: 75
    sql: ${char_id_count} ;;
  }

  set: detail {
    fields: [user_id, session_id, event_time, user_first_seen_time, char_id_count]
  }

}
