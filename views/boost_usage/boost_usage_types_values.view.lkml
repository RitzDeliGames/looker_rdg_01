view: boost_usage_types_values {
  derived_table: {
#     datagroup_trigger:
    sql: SELECT *
          FROM ${coins_earned_5_to_4.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${score_earned_5_to_4.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${xp_earned_5_to_4.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${coins_earned_bubble.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${score_earned_bubble.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${xp_earned_bubble.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${coins_earned_time.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${score_earned_time.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${xp_earned_time.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${coins_earned_exp.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${score_earned_exp.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${xp_earned_exp.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${coins_earned_coins.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${score_earned_coins.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${xp_earned_coins.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${coins_earned_score.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${score_earned_score.SQL_TABLE_NAME}
          UNION ALL SELECT *
          FROM ${xp_earned_score.SQL_TABLE_NAME}
          ;;
  }


  dimension: value_boost {
    hidden: no
    type: number
  }

  dimension: Boost_Type {
    type: string
  }

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    hidden: yes
    type: string
    sql:  ${TABLE}.character_used ;;
  }



#   set: detail {
#     fields: [character, Boost_Type, value_boost]
#   }



  measure: boosts_sum {
    group_label: "boxplot_boosts"
    type: number

    sql: SUM(${value_boost}) ;;
  }


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




### 5_to_4 Boost ###

view: coins_earned_5_to_4 {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.coins_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.five_to_four_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Coins Earned") ;;
      }
      derived_column: label_measure {
        sql: "coins" ;;
      }
      derived_column: label_type_boost {
        sql: "5_to_4" ;;
      }
    }
  }

  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: score_earned_5_to_4 {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.score_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.five_to_four_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Score Earned") ;;
      }
      derived_column: label_measure {
        sql: "score" ;;
      }
      derived_column: label_type_boost {
        sql: "5_to_4" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: xp_earned_5_to_4 {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.xp_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.five_to_four_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - XP Earned") ;;
      }
      derived_column: label_measure {
        sql: "xp" ;;
      }
      derived_column: label_type_boost {
        sql: "5_to_4" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }
}


### bubble_boost_string ###

view: coins_earned_bubble {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.coins_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.bubble_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Coins Earned") ;;
      }
      derived_column: label_measure {
        sql: "coins" ;;
      }
      derived_column: label_type_boost {
        sql: "bubble" ;;
      }
    }
  }

  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: score_earned_bubble {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.score_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.bubble_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Score Earned") ;;
      }
      derived_column: label_measure {
        sql: "score" ;;
      }
      derived_column: label_type_boost {
        sql: "bubble" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: xp_earned_bubble {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.xp_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.bubble_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - XP Earned") ;;
      }
      derived_column: label_measure {
        sql: "xp" ;;
      }
      derived_column: label_type_boost {
        sql: "bubble" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }
}


### time_boost_string ###

view: coins_earned_time {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.coins_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.time_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Coins Earned") ;;
      }
      derived_column: label_measure {
        sql: "coins" ;;
      }
      derived_column: label_type_boost {
        sql: "time" ;;
      }
    }
  }

  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: score_earned_time {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.score_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.time_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Score Earned") ;;
      }
      derived_column: label_measure {
        sql: "score" ;;
      }
      derived_column: label_type_boost {
        sql: "time" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: xp_earned_time {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.xp_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.time_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - XP Earned") ;;
      }
      derived_column: label_measure {
        sql: "xp" ;;
      }
      derived_column: label_type_boost {
        sql: "time" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }
}


### exp_boost_string ###

view: coins_earned_exp {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.coins_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.exp_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Coins Earned") ;;
      }
      derived_column: label_measure {
        sql: "coins" ;;
      }
      derived_column: label_type_boost {
        sql: "exp" ;;
      }
    }
  }

  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: score_earned_exp {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.score_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.exp_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Score Earned") ;;
      }
      derived_column: label_measure {
        sql: "score" ;;
      }
      derived_column: label_type_boost {
        sql: "exp" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: xp_earned_exp {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.xp_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.exp_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - XP Earned") ;;
      }
      derived_column: label_measure {
        sql: "xp" ;;
      }
      derived_column: label_type_boost {
        sql: "exp" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }
}


### coin_boost_string ###

view: coins_earned_coins {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.coins_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.coin_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Coins Earned") ;;
      }
      derived_column: label_measure {
        sql: "coins" ;;
      }
      derived_column: label_type_boost {
        sql: "coins" ;;
      }
    }
  }

  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: score_earned_coins {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.score_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.coin_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Score Earned") ;;
      }
      derived_column: label_measure {
        sql: "score" ;;
      }
      derived_column: label_type_boost {
        sql: "coins" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: xp_earned_coins {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.xp_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.coin_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - XP Earned") ;;
      }
      derived_column: label_measure {
        sql: "xp" ;;
      }
      derived_column: label_type_boost {
        sql: "coins" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }
}


### score_boost_string ###

view: coins_earned_score {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.coins_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.score_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Coins Earned") ;;
      }
      derived_column: label_measure {
        sql: "coins" ;;
      }
      derived_column: label_type_boost {
        sql: "score" ;;
      }
    }
  }

  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: score_earned_score {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.score_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.score_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - Score Earned") ;;
      }
      derived_column: label_measure {
        sql: "score" ;;
      }
      derived_column: label_type_boost {
        sql: "score" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }

}


view: xp_earned_score {
  derived_table: {
    explore_source: boost_usage {
      column: value_boost { field: boost_usage.xp_earned }
      column: character_used { field: boost_usage.character_used }
      column: label_boost { field: boost_usage.score_boost_string }
      derived_column: Boost_Type {
        sql: CONCAT(label_boost, " - XP Earned") ;;
      }
      derived_column: label_measure {
        sql: "xp" ;;
      }
      derived_column: label_type_boost {
        sql: "score" ;;
      }
    }
  }
  dimension: value_boost {
    type: number
  }

  dimension: Boost_Type {}

  dimension:  label_measure {}

  dimension:  label_type_boost {}

  dimension: character {
    type: string
    sql:  ${TABLE}.character ;;
  }
}
