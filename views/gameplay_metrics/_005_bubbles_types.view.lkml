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

  dimension: value_d {
    hidden: yes
    type: number
  }

  dimension: value_p {
    hidden: yes
    type: string
  }

  dimension: Bubble_Type {}

  dimension: character {
    hidden: yes
    type: string
    sql:  ${TABLE}.character ;;
  }


  parameter: boxplot_dropped_or_popped {
    type: string
    allowed_value: {
      label: "Bubbles Dropped"
      value: "Bubbles Dropped"
    }
    allowed_value: {
      label: "Bubbles Popped"
      value: "Bubbles Popped"
    }
  }




  measure: 1_min_bubble_types{
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -Bubble Dropped-"
      url: "{{ link }}&sorts=bubble_types.value_d+desc"
    }
    link: {
      label: "Drill and sort by -Bubble Popped-"
      url: "{{ link }}&sorts=bubble_types.value_p+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Dropped'
      THEN CAST(if(${value_d} = '' , '0', ${value_d}) AS NUMERIC)
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Popped'
      THEN ${value_p}
      END ;;
  }

  measure: 5_max_bubble_types {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value_d+desc"
    }
    link: {
      label: "Drill and sort by -Bubble Popped-"
      url: "{{ link }}&sorts=bubble_types.value_p+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Dropped'
      THEN CAST(if(${value_d} = '' , '0', ${value_d}) AS NUMERIC)
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Popped'
      THEN ${value_p}
      END ;;
  }

  measure: 3_median_bubble_types {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value_d+desc"
    }
    link: {
      label: "Drill and sort by -Bubble Popped-"
      url: "{{ link }}&sorts=bubble_types.value_p+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Dropped'
      THEN CAST(if(${value_d} = '' , '0', ${value_d}) AS NUMERIC)
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Popped'
      THEN ${value_p}
      END ;;
  }

  measure: 2_25th_bubble_types {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value_d+desc"
    }
    link: {
      label: "Drill and sort by -Bubble Popped-"
      url: "{{ link }}&sorts=bubble_types.value_p+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Dropped'
      THEN CAST(if(${value_d} = '' , '0', ${value_d}) AS NUMERIC)
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Popped'
      THEN ${value_p}
      END ;;
  }

  measure: 4_75th_bubble_types {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by -bubble type-"
      url: "{{ link }}&sorts=bubble_types.value_d+desc"
    }
    link: {
      label: "Drill and sort by -Bubble Popped-"
      url: "{{ link }}&sorts=bubble_types.value_p+desc"
    }
    group_label: "BoxPlot All Bubble Types"
    type: percentile
      percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Dropped'
      THEN CAST(if(${value_d} = '' , '0', ${value_d}) AS NUMERIC)
      WHEN  {% parameter boxplot_dropped_or_popped %} = 'Bubbles Popped'
      THEN ${value_p}
      END ;;
  }


    set: detail {
      fields: [character, Bubble_Type, value_d]
    }
}



# Bubble Coinds Value-Number transformation

view: bubble_coins {
  derived_table: {
    explore_source: _005_bubbles {
      column: value_d { field: bubble_coins.bubble_coins }
      column: value_p { field: _005_bubbles_comp.bubble_coins_popped }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_coins' ;;
      }
    }
  }

  dimension: value_d {
    type: number
  }

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

  dimension: Bubble_Type {}

}


# Bubble Normal Value-Number transformation

view: bubble_normal {
  derived_table: {
    explore_source: _005_bubbles {
      column: value_d { field: bubble_normal.bubble_normal }
      column: value_p { field: _005_bubbles_comp.bubble_normal_popped }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_normal' ;;
      }
    }
  }
  dimension: value_d {
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
      column: value_d { field: bubble_score.bubble_score }
      column: value_p { field: _005_bubbles_comp.bubble_score_popped }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_score' ;;
      }
    }
  }
  dimension: value_d {
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
      column: value_d { field: bubble_time.bubble_time }
      column: value_p { field: _005_bubbles_comp.bubble_time_popped }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_time' ;;
      }
    }
  }

  dimension: value_d {
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
      column: value_d { field: bubble_xp.bubble_xp }
      column: value_p { field: _005_bubbles_comp.bubble_xp_popped }
      column: character { field: _005_bubbles_comp.character }
      derived_column: Bubble_Type {
        sql: 'bubble_xp' ;;
      }
    }
  }

  dimension: value_d {
    type: number
  }

  dimension: Bubble_Type {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}
