include: "/views/**/events.view"


view: _004_large_dropped_and_popped {
  extends: [events]

  dimension: round_x_axis {
    type: string
    sql: CASE WHEN ${TABLE}.extra_json IS NOT NULL THEN 'x'
      END ;;
  }

  dimension: large_dropped {
    type: string
  sql: JSON_EXTRACT(extra_json, '$.{% parameter character %}_large') ;;
}

  dimension: large_popped {
      type: string
  sql: JSON_EXTRACT(extra_json, '$.{% parameter character %}_large_popped') ;;
  }

  dimension: total_large_dropped {
    type: string
    sql:  JSON_EXTRACT(extra_json,'$.total_large_dropped') ;;
  }

  dimension: total_large_popped {
    type: string
    sql: JSON_EXTRACT(extra_json,'$.total_large_popped') ;;
  }

  parameter: character {
    type: unquoted
    default_value: "character_01"
    suggest_explore: _004_large_dropped_and_popped
    suggest_dimension: _004_large_dropped_and_popped.events.character_used
    }

  parameter: boxplot_large_n_p {
    type: string
    allowed_value: {
      label: "large_dropped"
      value: "large_dropped"
    }
    allowed_value: {
      label: "large_popped"
      value: "large_popped"
    }
    allowed_value: {
      label: "total_large_dropped"
      value: "total_large_dropped"
    }
    allowed_value: {
      label: "total_large_popped"
      value: "total_large_popped"
    }
  }

###MEASURES###
  measure: count {
    type: count
    drill_fields: [detail*]
  }

###BOXPLOTS###


measure: 1_min_boxplot {
  drill_fields: [detail*]
  link: {
    label: "Drill and sort by Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_popped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_popped+desc"
  }
  group_label: "BoxPlot"
  type: min
  sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = 'large_dropped'
      THEN CAST(if(${large_dropped} = '' , '0', ${large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'large_popped'
      THEN CAST(if(${large_popped} = '' , '0', ${large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
}

measure: 5_max_boxplot {
  drill_fields: [detail*]
  link: {
    label: "Drill and sort by Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_popped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_popped+desc"
  }
  group_label: "BoxPlot"
  type: max
  sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = 'large_dropped'
      THEN CAST(if(${large_dropped} = '' , '0', ${large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'large_popped'
      THEN CAST(if(${large_popped} = '' , '0', ${large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
}

measure: 3_median_boxplot {
  drill_fields: [detail*]
  link: {
    label: "Drill and sort by Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_popped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_popped+desc"
  }
  group_label: "BoxPlot"
  type: median
  sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = 'large_dropped'
      THEN CAST(if(${large_dropped} = '' , '0', ${large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'large_popped'
      THEN CAST(if(${large_popped} = '' , '0', ${large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
}

measure: 2_25th_boxplot {
  drill_fields: [detail*]
  link: {
    label: "Drill and sort by Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_popped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_popped+desc"
  }
  group_label: "BoxPlot"
  type: percentile
  percentile: 25
  sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = 'large_dropped'
      THEN CAST(if(${large_dropped} = '' , '0', ${large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'large_popped'
      THEN CAST(if(${large_popped} = '' , '0', ${large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
}

measure: 4_75th_boxplot {
  drill_fields: [detail*]
  link: {
    label: "Drill and sort by Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.large_popped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Dropped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_dropped+desc"
  }
  link: {
    label: "Drill and sort by Total Large Popped"
    url: "{{ link }}&sorts=_004_large_dropped_and_popped.total_large_popped+desc"
  }
  group_label: "BoxPlot"
  type: percentile
  percentile: 75
  sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = 'large_dropped'
      THEN CAST(if(${large_dropped} = '' , '0', ${large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'large_popped'
      THEN CAST(if(${large_popped} = '' , '0', ${large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
}


measure: sum {
  group_label: "BoxPlot"
  type: sum
  sql: CASE
      WHEN {% parameter boxplot_large_n_p %} = 'large_dropped'
      THEN CAST(if(${large_dropped} = '' , '0', ${large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'large_popped'
      THEN CAST(if(${large_popped} = '' , '0', ${large_popped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_dropped'
      THEN CAST(if(${total_large_dropped} = '' , '0', ${total_large_dropped}) AS NUMERIC)
      WHEN {% parameter boxplot_large_n_p %} = 'total_large_popped'
      THEN CAST(if(${total_large_popped} = '' , '0', ${total_large_popped}) AS NUMERIC)
    END ;;
}


# VIEW DETAILS

set: detail {
  fields: [
    events.user_type,
    events.player_level_xp_int,
    events.hardware,
    events.platform,
    events.platform_type,
    round_x_axis,
    large_dropped,
    large_popped,
    total_large_dropped,
    total_large_popped
  ]
}
}
