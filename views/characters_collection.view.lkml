view: characters_collection {
  derived_table: {
    sql: SELECT
          user_id
        , timestamp_insert
        , timestamp
        , created_at
        , session_id
        , event_name
        , hardware
        , current_card
        , install_version
        , characters_coll
        , JSON_EXTRACT(characters_coll, '$.character_id') AS char_id
        , JSON_EXTRACT(characters_coll, '$.inventory')  AS inventory
        , JSON_EXTRACT(characters_coll, '$.xp_level')  AS xp_level
        , JSON_EXTRACT(characters_coll, '$.skill_level')  AS skill_level

      FROM `eraser-blast.game_data.events` AS events
      CROSS JOIN UNNEST(JSON_EXTRACT_ARRAY(extra_json, '$.characters')) AS characters_coll
      WHERE event_name = 'collection'
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

  dimension_group: timestamp_insert {
    type: time
    sql: ${TABLE}.timestamp_insert ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: current_card {
    type: string
    sql: ${TABLE}.current_card ;;
  }

  dimension: install_version {
    type: string
    sql: ${TABLE}.install_version ;;
  }

  dimension: characters_coll {
    type: string
    sql: ${TABLE}.characters_coll ;;
  }

  dimension: char_id {
    type: string
    sql: ${TABLE}.char_id ;;
  }

  dimension: inventory {
    type: string
    sql: ${TABLE}.inventory ;;
  }

  dimension: xp_level {
    type: string
    sql: ${TABLE}.xp_level ;;
  }

  dimension: skill_level {
    type: string
    sql: ${TABLE}.skill_level ;;
  }

  set: detail {
    fields: [
      user_id,
      timestamp_insert_time,
      timestamp_time,
      created_at_time,
      session_id,
      event_name,
      hardware,
      current_card,
      install_version,
      characters_coll,
      char_id,
      inventory,
      xp_level,
      skill_level
    ]
  }
}
