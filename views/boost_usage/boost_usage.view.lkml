include: "/views/**/events.view"


view: boost_usage {

  extends: [events]


  ########################

  dimension: coins_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.coins_earned'),'"','') as NUMERIC) ;;
  }

  dimension: score_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.score_earned'),'"','') as NUMERIC) ;;
  }

  dimension: xp_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.xp_earned'),'"','') as NUMERIC) ;;
  }

  dimension: timestamp_join {
#     convert_tz: no
    sql: ${timestamp_raw} ;;
  }

  dimension: boost_bool {
    type: string
    sql:  CASE
    WHEN REPLACE(JSON_Value(${TABLE}.extra_json,'$.score_boost'),'"','') > "0"
    THEN TRUE
    WHEN REPLACE(JSON_Value(${TABLE}.extra_json,'$.coin_boost'),'"','') > "0"
    THEN TRUE
    WHEN REPLACE(JSON_Value(${TABLE}.extra_json,'$.exp_boost'),'"','') > "0"
    THEN TRUE
    WHEN REPLACE(JSON_Value(${TABLE}.extra_json,'$.time_boost'),'"','') > "0"
    THEN TRUE
    WHEN REPLACE(JSON_Value(${TABLE}.extra_json,'$.bubble_boost'),'"','') > "0"
    THEN TRUE
    WHEN REPLACE(JSON_Value(${TABLE}.extra_json,'$.five_to_four_boost'),'"','') > "0"
    THEN TRUE
    ELSE FALSE
    END
    ;;
  }


  ########################

  dimension: score_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.score_boost'),'"','') > "0", '4. True - Score', '4. False - Score');;
  }

  dimension: coin_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.coin_boost'),'"','') > "0", '3. True - Coin', '3. False - Coin');;
  }

  dimension: exp_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.exp_boost'),'"','') > "0", '6. True - XP', '6. False - XP');;
  }

  dimension: time_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.time_boost'),'"','') > "0", '5. True - Time', '5. False - Time');;
  }

  dimension: bubble_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.bubble_boost'),'"','') > "0", '2. True - Bubble', '2. False - Bubble');;
  }

  dimension: five_to_four_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.five_to_four_boost'),'"','') > "0", '1. True - 5-to-4', '1. False - 5-to-4');;
  }


##########

  dimension: score_boost_bool {
    hidden: yes
    type: number
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.score_boost'),'"','') > "0", 1, 0);;
  }

  dimension: coin_boost_bool {
    hidden: yes
    type: number
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.coin_boost'),'"','') > "0", 1, 0);;
  }

  dimension: exp_boost_bool {
    hidden: yes
    type: number
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.exp_boost'),'"','') > "0", 1, 0);;
  }

  dimension: time_boost_bool {
    hidden: yes
    type: number
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.time_boost'),'"','') > "0", 1, 0);;
  }

  dimension: bubble_boost_bool {
    hidden: yes
    type: number
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.bubble_boost'),'"','') > "0", 1, 0);;
  }

  dimension: five_to_four_boost_bool {
    hidden: yes
    type: number
    sql:IF(REPLACE(JSON_Value(${TABLE}.extra_json,'$.five_to_four_boost'),'"','') > "0", 1, 0);;
  }



############BINGO CARDS EXTENSION############

#   dimension: rounds_nodes {
#     type: number
#     sql: JSON_EXTRACT(${node_data.node_data}, '$.rounds') ;;
#   }
#
#   dimension: node_id {
#     type: number
#     sql: JSON_EXTRACT(${node_data.node_data}, '$.node_id') ;;
#   }



  dimension: character_used {
    type: string
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.team_slot_0'),'"','');;
  }


  ####################


  measure: rounds_test {
    type: sum_distinct
    sql: CAST(JSON_Value(extra_json,'$.rounds') AS NUMERIC) ;;
  }

  measure: round_count {
#     label:
    type: count_distinct
    sql: CAST(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.round_id'),'"','') AS NUMERIC);;
  }


  ####################

#   measure: boosts_sum {
#     group_label: "boxplot_boosts"
#     type: number
#
#     sql: SUM(${boost_usage_types_values.value_boost}) ;;
#   }
#
#
#   measure: 1_min_all_boosts {
# #     drill_fields: [detail*]
# #     link: {
# #       label: "Drill and sort by Total Skill Used"
# #       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
# #     }
#   group_label: "boxplot_boosts"
#   type: min
#   sql: ${boost_usage_types_values.value_boost} ;;
# }
#
# measure: 5_max_all_boosts {
#   #     drill_fields: [detail*]
#   #     link: {
#   #       label: "Drill and sort by Total Skill Used"
#   #       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#   #     }
#   group_label: "boxplot_boosts"
#   type: max
#   sql: ${boost_usage_types_values.value_boost} ;;
# }
#
# measure: 3_median_all_boosts {
#   #     drill_fields: [detail*]
#   #     link: {
#   #       label: "Drill and sort by Total Skill Used"
#   #       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#   #     }
#   group_label: "boxplot_boosts"
#   type: median
#   sql: ${boost_usage_types_values.value_boost} ;;
# }
#
# measure: 2_25_all_boosts {
#   #     drill_fields: [detail*]
#   #     link: {
#   #       label: "Drill and sort by Total Skill Used"
#   #       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#   #     }
#   group_label: "boxplot_boosts"
#   type: percentile
#   percentile: 25
#   sql: ${boost_usage_types_values.value_boost} ;;
# }
#
# measure: 4_75_all_boosts {
#   #     drill_fields: [detail*]
#   #     link: {
#   #       label: "Drill and sort by Total Skill Used"
#   #       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#   #     }
#   group_label: "boxplot_boosts"
#   type: percentile
#   percentile: 75
#   sql: ${boost_usage_types_values.value_boost} ;;
# }


}
