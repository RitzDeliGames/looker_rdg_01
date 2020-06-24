view: boost_usage_types {
  derived_table: {
    sql: SELECT *
    FROM ${f_to_f_boost.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${bubble_boost.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${coin_boost.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${score_boost.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${time_boost.SQL_TABLE_NAME}
    UNION ALL SELECT *
    FROM ${xp_boost.SQL_TABLE_NAME}
    ;;
  }



  dimension: value_boost {
    hidden: no
    type: number
  }

  dimension: Boost_Type {
    type: string
  }

  dimension: character {
    hidden: yes
    type: string
    sql:  ${TABLE}.character_used ;;
  }

#   set: detail {
#     fields: [character, Boost_Type, value_boost]
#   }



  measure: 1_min_all_boosts {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Total Skill Used"
#       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#     }
    group_label: "boxplot_boosts"
    type: min
    sql: ${value_boost} ;;
  }

  measure: 5_max_all_boosts {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Total Skill Used"
#       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#     }
    group_label: "boxplot_boosts"
    type: max
    sql: ${value_boost} ;;
  }

  measure: 3_median_all_boosts {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Total Skill Used"
#       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#     }
    group_label: "boxplot_boosts"
    type: median
    sql: ${value_boost} ;;
  }

  measure: 2_25_all_boosts {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Total Skill Used"
#       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#     }
    group_label: "boxplot_boosts"
    type: percentile
    percentile: 25
    sql: ${value_boost} ;;
  }

  measure: 4_75_all_boosts {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Total Skill Used"
#       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#     }
    group_label: "boxplot_boosts"
    type: percentile
    percentile: 75
    sql: ${value_boost} ;;
  }


}


# Bubble Normal Value-Number transformation

view: f_to_f_boost {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.five_to_four_tickets }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.five_to_four_boost_string }
      derived_column: Boost_Type {
        sql: label_boost ;;
      }
    }
  }

  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}



# Bubble Score Value-Number transformation

view: bubble_boost {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.bubble_tickets }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.bubble_boost_string }
      derived_column: Boost_Type {
        sql: label_boost ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


# Bubble Time Value-Number transformation

view: coin_boost {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.coin_tickets }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.coin_boost_string }
      derived_column: Boost_Type {
        sql: label_boost ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}

# Bubble XP Value-Number transformation

view: score_boost {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.score_tickets }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.score_boost_string }
      derived_column: Boost_Type {
        sql: label_boost ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


# Bubble Coinds Value-Number transformation

view: time_boost {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.time_tickets }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.time_boost_string }
      derived_column: Boost_Type {
        sql: label_boost ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}



# Bubble Coinds Value-Number transformation

view: xp_boost {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.exp_tickets }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.exp_boost_string }
      derived_column: Boost_Type {
        sql: label_boost ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}
