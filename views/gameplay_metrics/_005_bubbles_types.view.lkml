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
    hidden: yes
    type: number
  }

  dimension: Bubble_Type {}

  dimension: character {
    hidden: yes
    type: string
    sql:  ${TABLE}.character ;;
  }


  # TEST BOXPLOT

  measure: 1_min_bubble_types{
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: min
    sql: CAST(if(${value} = '' , '0', ${value}) AS NUMERIC) ;;
  }

  measure: 5_max_bubble_types {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: max
    sql: CAST(if(${value} = '' , '0', ${value}) AS NUMERIC) ;;
  }

  measure: 3_median_bubble_types {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: median
    sql: CAST(if(${value} = '' , '0', ${value}) AS NUMERIC) ;;
  }

  measure: 2_25th_bubble_types {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: percentile
    percentile: 25
    sql: CAST(if(${value} = '' , '0', ${value}) AS NUMERIC) ;;
  }

  measure: 4_75th_bubble_types {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: percentile
      percentile: 75
      sql: CAST(if(${value} = '' , '0', ${value}) AS NUMERIC) ;;
    }

    set: detail {
      fields: [character, Bubble_Type, value]
    }
}



# Bubble Coinds Value-Number transformation

view: bubble_coins {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_coins.bubble_coins }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_coins' ;;
      }
    }
  }
  dimension: value{
    type: number
  }
  dimension: character {}
  dimension: Bubble_Type {}
}


# Bubble Normal Value-Number transformation

view: bubble_normal {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_normal.bubble_normal }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_normal' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: Bubble_Type {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}

# Bubble Score Value-Number transformation

view: bubble_score {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_score.bubble_score }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_score' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: Bubble_Type {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}

# Bubble Time Value-Number transformation

view: bubble_time {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_time.bubble_time }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_time' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: Bubble_Type {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}

# Bubble XP Value-Number transformation

view: bubble_xp {
  derived_table: {
    explore_source: _005_bubbles {
      column: value { field: bubble_xp.bubble_xp }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_xp' ;;
      }
    }
  }
  dimension: value {
    type: number
  }
  dimension: Bubble_Type {}
  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}
