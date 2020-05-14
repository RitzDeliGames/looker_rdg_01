view: test_large_n_dropped_query {
  derived_table: {
    sql: SELECT *
      FROM
      `eraser-blast.team_slot_0_dataset.dropped_n_popped`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: num_large_dropped {
    type: number
    sql: ${TABLE}.num_large_dropped ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
  }

  dimension: hw_plat_type {
    type: string
    sql: ${TABLE}.hw_plat_type ;;
  }

  dimension: num_large_popped {
    type: number
    sql: ${TABLE}.num_large_popped ;;
  }



  # BOXPLOT

  parameter: boxplot_ {
    type: string
    allowed_value: {
      label: "Large Dropped"
      value: "Large Dropped"
    }
    allowed_value: {
      label: "Large Popped"
      value: "Large Popped"
    }
  }

  measure: 1_min_boxplot {
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'Large Dropped'
      THEN ${num_large_dropped}
      WHEN  {% parameter boxplot_ %} = 'Large Popped'
      THEN ${num_large_popped}
    END  ;;
  }

  measure: 5_max_boxplot {
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'Large Dropped'
      THEN ${num_large_dropped}
      WHEN  {% parameter boxplot_ %} = 'Large Popped'
      THEN ${num_large_popped}
    END  ;;
  }

  measure: 3_median_boxplot {
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'Large Dropped'
      THEN ${num_large_dropped}
      WHEN  {% parameter boxplot_ %} = 'Large Popped'
      THEN ${num_large_popped}
    END  ;;
  }

  measure: 2_25th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'Large Dropped'
      THEN ${num_large_dropped}
      WHEN  {% parameter boxplot_ %} = 'Large Popped'
      THEN ${num_large_popped}
    END  ;;
  }

  measure: 4_75th_boxplot {
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'Large Dropped'
      THEN ${num_large_dropped}
      WHEN  {% parameter boxplot_ %} = 'Large Popped'
      THEN ${num_large_popped}
    END  ;;
  }

  set: detail {
    fields: [num_large_dropped, user_type, hw_plat_type, num_large_popped]
  }
}
