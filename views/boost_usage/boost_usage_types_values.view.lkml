view: boost_usage_types_values {
  derived_table: {
    sql: SELECT *
          FROM ${coins_earned_boosts.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${score_earned_boosts.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${xp_earned_boosts.SQL_TABLE_NAME}
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

view: coins_earned_boosts {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.coins_earned }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.five_to_four_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Coins Earned") ;;
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

view: score_earned_boosts {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.score_earned }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.five_to_four_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Score Earned") ;;
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


##################

view: xp_earned_boosts {
  derived_table: {
    explore_source: boost_usage_main {
      column: value_boost { field: boost_usage_main.xp_earned }
      column: character_used { field: boost_usage_main.character_used }
      column: label_boost { field: boost_usage_main.five_to_four_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - XP Earned") ;;
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
