include: "/views/**/bingo_cards/**/_000_bingo_cards_comp.view"


view: boost_usage_main {

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
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.score_boost'),'"','') = "1", '4. True - Score', '4. False - Score');;
  }

  dimension: coin_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.coin_boost'),'"','') = "1", '3. True - Coin', '3. False - Coin');;
  }

  dimension: exp_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.exp_boost'),'"','') = "1", '6. True - XP', '6. False - XP');;
  }

  dimension: time_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.time_boost'),'"','') = "1", '5. True - Time', '5. False - Time');;
  }

  dimension: bubble_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.bubble_boost'),'"','') = "1", '2. True - Bubble', '2. False - Bubble');;
  }

  dimension: five_to_four_boost_string {
    hidden: yes
    type: string
    sql:IF(REPLACE(JSON_EXTRACT(${TABLE}.extra_json,'$.five_to_four_boost'),'"','') = "1", '1. True - 5-to-4', '1. False - 5-to-4');;
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



}
