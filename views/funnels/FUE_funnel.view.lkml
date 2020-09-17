
include: "/views/**/events.view"
include: "/views/**/scene_load_time/**/scene_load_time.view"

view: fue_funnel {
  extends: [events]
  extends: [scene_load_time]


  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  dimension: fue_step {
    type: string
    sql: REPLACE(JSON_EXTRACT(extra_json,"$.current_FueStep"),'"','') ;;
  }

  dimension: fue_step_hierarchy {
    type: string
    sql:
    CASE WHEN ${event_name} = "TitleScreenAwake" THEN "01. TitleScreenAwake"
         WHEN ${fue_step} = "FIRST_PLAY" THEN "02. FIRST PLAY"
         WHEN ${fue_step} = "BINGO_CARD_INTRO_LINEAR" THEN "03. BINGO_CARD_INTRO_LINEAR"
         WHEN ${fue_step} = "BINGO_CARD_FIRST_NODE_COMPLETE_LINEAR" THEN "04. BINGO_CARD_FIRST_NODE_COMPLETE_LINEAR"
         WHEN ${fue_step} = "BINGO_CARD_FIRST_NODE_FAILED_LINEAR" THEN "05. BINGO_CARD_FIRST_NODE_FAILED_LINEAR"
         WHEN ${fue_step} = "BINGO_CARD_FIRST_REWARD_LINEAR" THEN "06. BINGO_CARD_FIRST_REWARD_LINEAR"
         WHEN ${fue_step} = "NEW_CHARACTER_CONGRATS_FIRST" THEN "07. NEW_CHARACTER_CONGRATS_FIRST"
         WHEN ${fue_step} = "NEW_CHARACTER_CONGRATS_SECOND" THEN "08. NEW_CHARACTER_CONGRATS_SECOND"
         WHEN ${fue_step} = "BINGO_CARD_FUE_END" THEN "09. BINGO_CARD_FUE_END"
         WHEN ${fue_step} = "BINGO_CARD_FIRST_NONLINEAR" THEN "10. BINGO_CARD_FIRST_NONLINEAR"
         WHEN ${fue_step} = "STORE_UNLOCK" THEN "11. STORE_UNLOCK"
         WHEN ${fue_step} = "USE_BOOSTS" THEN "12. USE_BOOSTS"
         WHEN ${fue_step} = "LEADERBOARD_UNLOCK" THEN "13. LEADERBOARD_UNLOCK"
         WHEN ${fue_step} = "FIRST_DUPLICATE" THEN "14. FIRST_DUPLICATE"
         WHEN ${fue_step} = "ERASER_LEVEL_CAP" THEN "15. ERASER_LEVEL_CAP"
        ELSE ${fue_step}
        END
        ;;
  }

  dimension: ChoreographyStepId {
    type: number
    sql: REPLACE(JSON_EXTRACT(extra_json,"$.current_ChoreographyStepId"),'"','') ;;
  }
}

view: funnel_steps {
  derived_table: {
    sql:
    SELECT * FROM ${fue_step001.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step002.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step003.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step004.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step005.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step006.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step007.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step008.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step009.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step010.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step011.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step012.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step013.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step014.SQL_TABLE_NAME}
      union all SELECT * FROM ${fue_step015.SQL_TABLE_NAME} ;;
  }
  dimension: step {}
  measure: count_players {
    type: count_distinct
    sql: ${TABLE}.player_id ;;
  }
  dimension: ChoreographyStepId {
    type: number
  }
}

view: fue_step001 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "01. TitleScreenAwake" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "01. TitleScreenAwake"
      }
    }
  }
}

view: fue_step002 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "02. FIRST PLAY" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "02. FIRST PLAY"
      }
    }
  }
}

view: fue_step003 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "03. BINGO_CARD_INTRO_LINEAR" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "03. BINGO_CARD_INTRO_LINEAR"
      }
    }
  }
}


view: fue_step004 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "04. BINGO_CARD_FIRST_NODE_COMPLETE_LINEAR" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "04. BINGO_CARD_FIRST_NODE_COMPLETE_LINEAR"
      }
    }
  }
}

view: fue_step005 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "05. BINGO_CARD_FIRST_NODE_FAILED_LINEAR" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "05. BINGO_CARD_FIRST_NODE_FAILED_LINEAR"
      }
    }
  }
}

view: fue_step006 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "06. BINGO_CARD_FIRST_REWARD_LINEAR" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "06. BINGO_CARD_FIRST_REWARD_LINEAR"
      }
    }
  }
}

view: fue_step007 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "07. NEW_CHARACTER_CONGRATS_FIRST" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "07. NEW_CHARACTER_CONGRATS_FIRST"
      }
    }
  }
}

view: fue_step008 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "08. NEW_CHARACTER_CONGRATS_SECOND" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "08. NEW_CHARACTER_CONGRATS_SECOND"
      }
    }
  }
}

view: fue_step009 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "09. BINGO_CARD_FUE_END" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "09. BINGO_CARD_FUE_END"
      }
    }
  }
}

view: fue_step010 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "10. BINGO_CARD_FIRST_NONLINEAR" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "10. BINGO_CARD_FIRST_NONLINEAR"
      }
    }
  }
}

view: fue_step011 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "11. STORE_UNLOCK" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "11. STORE_UNLOCK"
      }
    }
  }
}

view: fue_step012 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "12. USE_BOOSTS" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "12. USE_BOOSTS"
      }
    }
  }
}

view: fue_step013 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "13. LEADERBOARD_UNLOCK" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "13. LEADERBOARD_UNLOCK"
      }
    }
  }
}

view: fue_step014 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "14. FIRST_DUPLICATE" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "14. FIRST_DUPLICATE"
      }
    }
  }
}

view: fue_step015 {
  derived_table: {
    explore_source: fue_funnel {
      derived_column: step {
        sql: "15. ERASER_LEVEL_CAP" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: fue_funnel.fue_step_hierarchy
        value: "15. ERASER_LEVEL_CAP"
      }
    }
  }
}
