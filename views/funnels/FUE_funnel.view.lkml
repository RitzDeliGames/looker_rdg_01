#
# include: "/views/**/events.view"
#
# view: fue_funnel {
#   extends: [events]
#
#   measure: count_users {
#     type: count_distinct
#     sql: ${user_id} ;;
#   }
# #   parameter: FUE_step_ID {
# #     allowed_value: {
# #       label: "FIRST_PLAY"
# #       value: "FIRST_PLAY"
# #     }
# #
# #     allowed_value: {
# #       label: "BINGO_CARD_INTRO"
# #       value: "BINGO_CARD_INTRO"
# #     }
# #   }
#
#   dimension: fue_step {
#     type: string
#     sql: REPLACE(JSON_EXTRACT(extra_json,"$.current_FueStep"),'"','') ;;
#   }
#
#   dimension: fue_step_hierarchy {
#     type: string
#     sql:
#     CASE WHEN ${event_name} = "TitleScreenAwake" THEN "1. TitleScreenAwake"
#          WHEN ${fue_step} = "FIRST_PLAY" THEN "2. FIRST PLAY"
#          WHEN ${fue_step} = "BINGO_CARD_INTRO" THEN "3. BINGO_CARD_INTRO"
#          WHEN ${fue_step} = "BINGO_CARD_FIRST_NODE_COMPLETE" THEN "4. BINGO_CARD_FIRST_NODE_COMPLETE"
#          WHEN ${fue_step} = "BINGO_CARD_KEEP_PLAYING" THEN "5. BINGO_CARD_KEEP_PLAYING"
#          WHEN ${fue_step} = "BINGO_CARD_FIRST_REWARD" THEN "6. BINGO_CARD_FIRST_REWARD"
#          WHEN ${fue_step} = "BINGO_CARD_FUE_END" THEN "7. BINGO_CARD_FUE_END"
#          WHEN ${fue_step} = "STORE_UNLOCK" THEN "8. STORE_UNLOCK"
#          WHEN ${fue_step} = "USE_BOOSTS" THEN "9. USE_BOOSTS"
#         ELSE ${fue_step}
#         END
#         ;;
#   }
#
#   dimension: ChoreographyStepId {
#     type: number
#     sql: REPLACE(JSON_EXTRACT(extra_json,"$.current_ChoreographyStepId"),'"','') ;;
#   }
# }
#
# # explore: fue_step001 {
# #   view_label: "TitleScreenAwake"
# #   join: fue_step002 {
# #     view_label: "FIRST_PLAY"
# #     sql_on: ${fue_step001.player_id} = ${fue_step002.player_id} ;;
# #   }
# #   join: fue_step003 {
# #     view_label: "BINGO_CARD_INTRO"
# #     sql_on: ${fue_step001.player_id} = ${fue_step003.player_id} ;;
# #   }
# #   join: fue_step004 {
# #     view_label: "BINGO_CARD_FIRST_NODE_COMPLETE"
# #     sql_on: ${fue_step001.player_id} = ${fue_step004.player_id} ;;
# #   }
# #   join: fue_step005 {
# #     view_label: "BINGO_CARD_KEEP_PLAYING"
# #     sql_on: ${fue_step001.player_id} = ${fue_step005.player_id} ;;
# #   }
# #   join: fue_step006 {
# #     view_label: "BINGO_CARD_FIRST_REWARD"
# #     sql_on: ${fue_step001.player_id} = ${fue_step006.player_id} ;;
# #   }
# #   join: fue_step007 {
# #     view_label: "BINGO_CARD_FUE_END"
# #     sql_on: ${fue_step001.player_id} = ${fue_step007.player_id} ;;
# #   }
# #   join: fue_step008 {
# #     view_label: "STORE_UNLOCK"
# #     sql_on: ${fue_step001.player_id} = ${fue_step008.player_id} ;;
# #   }
# #   join: fue_step009 {
# #     view_label: "USE_BOOSTS"
# #     sql_on: ${fue_step001.player_id} = ${fue_step009.player_id} ;;
# #   }
# #
# # }
# explore: funnel_steps {}
# view: funnel_steps {
#   derived_table: {
#     sql:
#     SELECT * FROM ${fue_step001.SQL_TABLE_NAME}
#       union all SELECT * FROM ${fue_step002.SQL_TABLE_NAME}
#       union all SELECT * FROM ${fue_step003.SQL_TABLE_NAME}
#       union all SELECT * FROM ${fue_step004.SQL_TABLE_NAME}
#       union all SELECT * FROM ${fue_step005.SQL_TABLE_NAME}
#       union all SELECT * FROM ${fue_step006.SQL_TABLE_NAME}
#       union all SELECT * FROM ${fue_step007.SQL_TABLE_NAME}
#       union all SELECT * FROM ${fue_step008.SQL_TABLE_NAME}
#       union all SELECT * FROM ${fue_step009.SQL_TABLE_NAME} ;;
#   }
#   dimension: step {}
#   measure: count_players {
#     type: count_distinct
#     sql: ${TABLE}.player_id ;;
#   }
#   dimension: ChoreographyStepId {
#     type: number
#   }
# }
#
# view: fue_step001 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "1. TitleScreenAwake" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "1. TitleScreenAwake"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: TitleScreenAwake_unique_players {
# #     type: count
# #     sql: ${player_id} ;;
# # }
# }
# view: fue_step002 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "2. FIRST PLAY" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "2. FIRST PLAY"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: FIRST_PLAY_unique_players {
# #     type: count
# #     sql: ${player_id} ;;
# #   }
# }
# view: fue_step003 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "3. BINGO_CARD_INTRO" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "3. BINGO_CARD_INTRO"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: BINGO_CARD_INTRO_unique_players {
# #     type: count
# #     sql: ${player_id} ;;
# #   }
# }
#
# view: fue_step004 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "4. BINGO_CARD_FIRST_NODE_COMPLETE" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "4. BINGO_CARD_FIRST_NODE_COMPLETE"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: BINGO_CARD_FIRST_NODE_COMPLETE_unique_players {
# #     type: count
# #     sql: ${player_id} ;;
# #   }
# }
#
# view: fue_step005 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "5. BINGO_CARD_KEEP_PLAYING" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "5. BINGO_CARD_KEEP_PLAYING"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: BINGO_CARD_KEEP_PLAYING_unique_players {
# #     type: count
# #     sql: ${player_id} ;;
# #   }
# }
#
# view: fue_step006 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "6. BINGO_CARD_FIRST_REWARD" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "6. BINGO_CARD_FIRST_REWARD"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: count_players {
# #     type: count
# #     sql: ${player_id} ;;
# #   }
# }
#
# view: fue_step007 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "7. BINGO_CARD_FUE_END" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "7. BINGO_CARD_FUE_END"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: count_players {
# #     type: count
# #     sql: ${player_id} ;;
# #   }
# }
#
# view: fue_step008 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "8. STORE_UNLOCK" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "8. STORE_UNLOCK"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: count_players {
# #     type: count
# #     sql: ${player_id} ;;
# #   }
# }
#
# view: fue_step009 {
#   derived_table: {
#     explore_source: fue_funnel {
#       derived_column: step {
#         sql: "9. USE_BOOSTS" ;;
#       }
#       column: player_id {}
#       column: ChoreographyStepId {}
#       column: first_time {}
#       filters: {
#         field: fue_funnel.fue_step_hierarchy
#         value: "9. USE_BOOSTS"
#       }
#     }
#   }
# #   dimension: player_id {
# #     primary_key: yes
# #   }
# #   dimension: first_time {
# #     type: number
# #   }
# #   dimension: step {}
# #   measure: count_players {
# #     type: count
# #     sql: ${player_id} ;;
# #   }
# }
