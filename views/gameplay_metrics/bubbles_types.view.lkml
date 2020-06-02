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
    FROM ${bubble_xp.SQL_TABLE_NAME};;
  }
  dimension: label {}
  dimension: value {}
}

view: bubble_coins {
    derived_table: {
      explore_source: _005_bubbles {
        column: value { field: bubble_coins.bubble_coins }
        derived_column: label {
          sql: 'bubble_coins' ;;
        }
      }
    }
    dimension: value {
      type: number
    }
    dimension: label {}

    dimension: join_key {

    }
  }

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
}

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
}

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
}

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
}
