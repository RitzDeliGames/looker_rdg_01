view: bubble_types {
  derived_table: {
    sql: SELECT *
    FROM ${bubble_coins.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${bubble_normal.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${bubble_score.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${bubble_time.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${bubble_xp.SQL_TABLE_NAME}
    ;;
#     extra_json,
#     JSON_EXTRACT(extra_json, '$.team_slot_0') AS character
#     FROM events
#     ;;
  }
  dimension: label {}

  dimension: value {}

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
    }

  dimension: primary_key {
    type: string
    sql:  CONCAT(${character},${extra_json}) ;;
  }

  set: details {
    fields: [character]
  }
}


# Bubble Coinds Value-Number transformation

explore: bubble_coins {}

view: bubble_coins {
    derived_table: {
      explore_source: _005_bubbles {
        column: value { field: bubble_coins.bubble_coins }
#         column: extra_json {
#           field: bubble_types.extra_json
#         }
        derived_column: label {
          sql: 'bubble_coins' ;;
        }
      }
    }
    dimension: value {
      type: number
    }
    dimension: label {}

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

    dimension: primary_key {
      type: string
      sql:  CONCAT(${character},${extra_json}) ;;
    }

    set: details {
      fields: [character]
    }
  }



# Bubble Normal Value-Number transformation

view: bubble_normal {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_normal.bubble_normal }
      derived_column: label {
        sql: 'bubble_normal' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: label {}

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

  dimension: primary_key {
    type: string
    sql:  CONCAT(${character},${extra_json}) ;;
  }

  set: details {
    fields: [character]
  }
}


# Bubble Score Value-Number transformation

view: bubble_score {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_score.bubble_score }
      derived_column: label {
        sql: 'bubble_score' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: label {}

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

  dimension: primary_key {
    type: string
    sql:  CONCAT(${character},${extra_json}) ;;
  }

  set: details {
    fields: [character]
  }
}


# Bubble Time Value-Number transformation

view: bubble_time {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_time.bubble_time }
      derived_column: label {
        sql: 'bubble_time' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: label {}

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

  dimension: primary_key {
    type: string
    sql:  CONCAT(${character},${extra_json}) ;;
  }

  set: details {
    fields: [character]
  }
}


# Bubble XP Value-Number transformation

view: bubble_xp {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_xp.bubble_xp }
      derived_column: label {
        sql: 'bubble_xp' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: label {}

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

  dimension: primary_key {
    type: string
    sql:  CONCAT(${character},${extra_json}) ;;
  }

  set: details {
    fields: [character]
  }
}
