include: "/views/**/events.view"


view: test_player {
  extends: [events]


#   derived_table: {
#     sql: SELECT --JSON_EXTRACT(extra_json, '$.characters') AS json_char,
#       JSON_EXTRACT(characters, '$.character_id') AS character,
#       JSON_EXTRACT(characters, '$.inventory') AS inventory,
#       JSON_EXTRACT(characters, '$.xp_level') AS xp_level,
#       JSON_EXTRACT(characters, '$.skill_level') AS skill_level,
#       JSON_EXTRACT(characters, '$.collection_date') AS collection_date,
#       JSON_EXTRACT(characters, '$.level_up_date') AS level_up_date,
#       JSON_EXTRACT(characters, '$.skill_up_date') AS skill_up_date,
#       JSON_EXTRACT(characters, '$.collection_round_id') AS collection_round_id,
#       JSON_EXTRACT(characters, '$.level_up_round_id') AS level_up_round_id,
#       JSON_EXTRACT(characters, '$.skilled_up_round_id') AS skilled_up_round_id,
#       JSON_EXTRACT(characters, '$.level_cap') AS level_cap,
#       JSON_EXTRACT(characters, '$.max_level') AS max_level,
#       JSON_EXTRACT(characters, '$.max_skill') AS max_skill,
#
#       FROM events
#       CROSS JOIN UNNEST(JSON_EXTRACT_array(extra_json, '$.characters')) as characters
#       WHERE event_name = "collection"
#        ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }


  dimension: characters {
    type: string
    sql: characters ;;
  }

  dimension: character {
    type: string
    sql: JSON_EXTRACT(characters, '$.character_id') ;;
  }

  dimension: inventory {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.inventory') ;;
  }

  dimension: xp_level {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.xp_level') ;;
  }

  dimension: skill_level {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.skill_level') ;;
  }

  dimension: collection_date {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.collection_date') ;;
  }

   dimension: level_up_date {
     type: number
     sql: CAST(REPLACE(JSON_EXTRACT(${characters.characters}, '$.level_up_date'), '"', '') AS INT64) ;;
   }


#   dimension_group: level_up_date_group {
#     type: time
#     timeframes: [
#       raw,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     datatype: epoch
#     sql: ${level_up_date} ;;
#     #sql: CAST(JSON_EXTRACT(${characters.characters}, '$.level_up_date') AS INT64) ;;
#   }


  dimension: skill_up_date {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.skill_up_date') ;;
  }

  dimension: collection_round_id {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.collection_round_id') ;;
  }

  dimension: level_up_round_id {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.level_up_round_id') ;;
  }

  dimension: skilled_up_round_id {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.skilled_up_round_id') ;;
  }

  dimension: level_cap {
    type: string
    sql: JSON_EXTRACT(${characters.characters}, '$.level_cap') ;;
  }

  dimension: max_level {
    type: string
    sql: JSON_EXTRACT(${characters.characters}, '$.max_level') ;;
  }

  dimension: max_skill {
    type: string
    sql: JSON_EXTRACT(${characters.characters}, '$.max_skill') ;;
  }

  set: detail {
    fields: [
      character,
      inventory,
      xp_level,
      skill_level,
      collection_round_id,
      level_up_round_id,
      skilled_up_round_id,
      level_cap,
      max_level,
      max_skill
    ]
  }
}
