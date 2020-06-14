
include: "/views/**/events.view"

view: bingo_card_funnel {
  extends: [events]

  measure: count_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  dimension: current_card {
    type: string
    sql: REPLACE(JSON_EXTRACT(extra_json,"$.card_id"),'"','') ;;
  }

  dimension: card_step_hierarchy {
    type: string
    sql:
    CASE WHEN ${current_card} = "card_001" THEN "card_001"
         WHEN ${current_card} = "card_002" THEN "card_002"
         WHEN ${current_card} = "card_003" THEN "card_003"
         WHEN ${current_card} = "card_004" THEN "card_004"
         WHEN ${current_card} = "card_005" THEN "card_005"
         WHEN ${current_card} = "card_006" THEN "card_006"
         WHEN ${current_card} = "card_007" THEN "card_007"
         WHEN ${current_card} = "card_008" THEN "card_008"
         WHEN ${current_card} = "card_009" THEN "card_009"
        ELSE ${current_card}
        END
        ;;
  }

  dimension: card_state {
    type: number
    sql: CAST(ARRAY_LENGTH(REGEXP_EXTRACT_ALL(JSON_EXTRACT(extra_json, "$.card_state"), ",")) AS INT64) + 1;;
  }
}

view: card_steps {
  derived_table: {
    sql:
    SELECT * FROM ${card_step001.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step002.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step003.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step004.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step005.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step006.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step007.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step008.SQL_TABLE_NAME}
      union all SELECT * FROM ${card_step009.SQL_TABLE_NAME} ;;
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

view: card_step001 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "1. TitleScreenAwake" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "1. TitleScreenAwake"
      }
    }
  }
}

view: card_step002 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "2. FIRST PLAY" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "2. FIRST PLAY"
      }
    }
  }
}

view: card_step003 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "3. BINGO_CARD_INTRO" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "3. BINGO_CARD_INTRO"
      }
    }
  }
}

view: card_step004 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "4. BINGO_CARD_FIRST_NODE_COMPLETE" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "4. BINGO_CARD_FIRST_NODE_COMPLETE"
      }
    }
  }
}

view: card_step005 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "5. BINGO_CARD_KEEP_PLAYING" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "5. BINGO_CARD_KEEP_PLAYING"
      }
    }
  }
}

view: card_step006 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "6. BINGO_CARD_FIRST_REWARD" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "6. BINGO_CARD_FIRST_REWARD"
      }
    }
  }
}

view: card_step007 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "7. BINGO_CARD_FUE_END" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "7. BINGO_CARD_FUE_END"
      }
    }
  }
}

view: card_step008 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "8. STORE_UNLOCK" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "8. STORE_UNLOCK"
      }
    }
  }
}

view: card_step009 {
  derived_table: {
    explore_source: bingo_card_funnel {
      derived_column: step {
        sql: "9. USE_BOOSTS" ;;
      }
      column: player_id {}
      column: ChoreographyStepId {}
      column: first_time {}
      filters: {
        field: bingo_card_funnel.card_step_hierarchy
        value: "9. USE_BOOSTS"
      }
    }
  }
}
