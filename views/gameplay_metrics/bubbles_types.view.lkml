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
  }
  dimension: value {
    type: number
  }
  dimension: label {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

  set: details {
    fields: [character]
  }
}


# Bubble Coinds Value-Number transformation

view: bubble_coins {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_coins.bubble_coins }
      column: character { field: _005_bubbles_comp.character }
      derived_column: label {
        sql: 'bubble_coins' ;;
      }
    }
  }
  dimension: value{
    type: number
  }
  dimension: character {}
  dimension: label {}
}

# Bubble Normal Value-Number transformation

view: bubble_normal {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_normal.bubble_normal }
      column: character { field: _005_bubbles_comp.character }
      derived_column: label {
        sql: 'bubble_normal' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: label {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
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
      column: character { field: _005_bubbles_comp.character }
      derived_column: label {
        sql: 'bubble_score' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: label {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
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
      column: character { field: _005_bubbles_comp.character }
      derived_column: label {
        sql: 'bubble_time' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: label {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
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
      column: character { field: _005_bubbles_comp.character }
      derived_column: label {
        sql: 'bubble_xp' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: label {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }
  set: details {
    fields: [character]
  }
}
