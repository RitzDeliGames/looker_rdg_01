include: "/views/**/bingo_cards/**/_000_bingo_cards_comp.view"


view: boost_usage {

  extends: [_000_bingo_cards_comp]


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

  dimension: score_boost_num {
    group_label: "Boosts Num"
    label: "Score Boost"
    hidden: no
    type: number
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.score_boost'),'"','');;
  }

  dimension: coin_boost_num {
    group_label: "Boosts Num"
    label: "Coin Boost"
    hidden: no
    type: number
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.coin_boost'),'"','') ;;
  }

  dimension: exp_boost_num {
    group_label: "Boosts Num"
    label: "XP Boost"
    hidden: no
    type: number
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.exp_boost'),'"','') ;;
  }

  dimension: time_boost_num {
    group_label: "Boosts Num"
    label: "Time Boost"
    hidden: no
    type: number
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.time_boost'),'"','') ;;
  }

  dimension: bubble_boost_num {
    group_label: "Boosts Num"
    label: "Bubble Boost"
    hidden: no
    type: number
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.bubble_boost'),'"','') ;;
  }

  dimension: five_to_four_boost_num {
    group_label: "Boosts Num"
    label: "5-to-4 Boost"
    hidden: no
    type: number
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.five_to_four_boost'),'"','') ;;
  }




############BINGO CARDS EXTENSION############

  dimension: rounds_nodes {
    type: number
    sql: JSON_EXTRACT(${node_data.node_data}, '$.rounds') ;;
  }

  dimension: node_id {
    type: number
    sql: JSON_EXTRACT(${node_data.node_data}, '$.node_id') ;;
  }



  dimension: character_used {
    type: string
    sql: REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.team_slot_0'),'"','');;
  }



###


  measure: boosts_sum {
    group_label: "boxplot_boosts"
    type: number

    sql: SUM(${boost_usage_types_values.value_boost}) ;;
  }


  measure: 1_min_all_boosts {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by Total Skill Used"
#       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
#     }
  group_label: "boxplot_boosts"
  type: min
  sql: ${boost_usage_types_values.value_boost} ;;
}

measure: 5_max_all_boosts {
  #     drill_fields: [detail*]
  #     link: {
  #       label: "Drill and sort by Total Skill Used"
  #       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
  #     }
  group_label: "boxplot_boosts"
  type: max
  sql: ${boost_usage_types_values.value_boost} ;;
}

measure: 3_median_all_boosts {
  #     drill_fields: [detail*]
  #     link: {
  #       label: "Drill and sort by Total Skill Used"
  #       url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
  #     }
  group_label: "boxplot_boosts"
  type: median
  sql: ${boost_usage_types_values.value_boost} ;;
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
  sql: ${boost_usage_types_values.value_boost} ;;
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
  sql: ${boost_usage_types_values.value_boost} ;;
}


}
