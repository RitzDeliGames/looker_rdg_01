include: "/views/**/events.view"


view: player_analysis {
  extends: [events]


# This code lines extract all key-values from extra_json where event_name = 'collection'

#        JSON_EXTRACT(extra_json, '$.character_001.inventory') AS inventory,
#        JSON_EXTRACT(extra_json, '$.character_001.skill_level') AS skill_level,
#        JSON_EXTRACT(extra_json, '$.character_001.collection_date') AS collection_date,
#        JSON_EXTRACT(extra_json, '$.character_001.level_up_date') AS level_up_date,
#        JSON_EXTRACT(extra_json, '$.character_001.skill_up_date') AS skill_up_date,
#        JSON_EXTRACT(extra_json, '$.character_001.collection_round_id') AS collection_round_id,
#        JSON_EXTRACT(extra_json, '$.character_001.level_up_round_id') AS level_up_round_id,
#        JSON_EXTRACT(extra_json, '$.character_001.skilled_up_round_id') AS skilled_up_round_id,
#        JSON_EXTRACT(extra_json, '$.character_001.level_cap') AS level_cap,
#        JSON_EXTRACT(extra_json, '$.character_001.max_level') AS max_level,
#        JSON_EXTRACT(extra_json, '$.character_001.max_skill') AS max_skill,




  parameter: general_balance {
    type: string
    allowed_value: {
      label: "player xp"
      value: "player xp"
    }
    allowed_value: {
      label: "player xp (int)"
      value: "player xp (int)"
    }
  }

  measure: 1_min_general {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST_G"
    type: min
    sql: CASE
      WHEN {% parameter general_balance %} = 'player xp'
      THEN ${player_xp_level}
      WHEN {% parameter general_balance %} = 'player xp (int)'
      THEN ${player_xp_level_int}
    END ;;
  }

  measure: 5_max_general {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST_G"
    type: max
    sql: CASE
      WHEN {% parameter general_balance %} = 'player xp'
      THEN ${player_xp_level}
      WHEN {% parameter general_balance %} = 'player xp (int)'
      THEN ${player_xp_level_int}
    END ;;
  }

  measure: 3_median_general {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST_G"
    type: median
    sql: CASE
      WHEN {% parameter general_balance %} = 'player xp'
      THEN ${player_xp_level}
      WHEN {% parameter general_balance %} = 'player xp (int)'
      THEN ${player_xp_level_int}
    END ;;
  }


  measure: 2_25th_general {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
  group_label: "TEST_G"
  type: percentile
  percentile: 25
  sql: CASE
      WHEN {% parameter general_balance %} = 'player xp'
      THEN ${player_xp_level}
      WHEN {% parameter general_balance %} = 'player xp (int)'
      THEN ${player_xp_level_int}
    END ;;
}


  measure: 4_75th_general {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
  group_label: "TEST_G"
  type: percentile
  percentile: 75
  sql: CASE

      WHEN {% parameter general_balance %} = 'player xp'
      THEN ${player_xp_level}
      WHEN {% parameter general_balance %} = 'player xp (int)'
      THEN ${player_xp_level_int}
    END ;;
}




  parameter: player_inventory {
    type: string
    allowed_value: {
      label: "coins"
      value: "coins"
    }
    allowed_value: {
      label: "gems"
      value: "gems"
    }
    allowed_value: {
      label: "lives"
      value: "lives"
    }
    allowed_value: {
      label: "box 002 tickets"
      value: "box 002 tickets"
    }
    allowed_value: {
      label: "box 007 tickets"
      value: "box 007 tickets"
    }
    allowed_value: {
      label: "score tickets"
      value: "score tickets"
    }
    allowed_value: {
      label: "bubble_tickets"
      value: "bubble_tickets"
    }
    allowed_value: {
      label: "time_tickets"
      value: "time_tickets"
    }
    allowed_value: {
      label: "five_to_four_tickets"
      value: "five_to_four_tickets"
    }
    allowed_value: {
      label: "exp_tickets"
      value: "exp_tickets"
    }
  }



###PLAYER INVENTORY###

##_MEASURES_##


  measure: 1_min_player {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: min
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box 002 tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box 007 tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score tickets'
      THEN ${score_tickets}
      WHEN {% parameter player_inventory %} = 'bubble_tickets'
      THEN ${bubble_tickets}
      WHEN {% parameter player_inventory %} = 'time_tickets'
      THEN ${time_tickets}
      WHEN {% parameter player_inventory %} = 'five_to_four_tickets'
      THEN ${five_to_four_tickets}
      WHEN {% parameter player_inventory %} = 'exp_tickets'
      THEN ${exp_tickets}
    END ;;
  }


  measure: 5_max_player {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: max
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box 002 tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box 007 tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score tickets'
      THEN ${score_tickets}
      WHEN {% parameter player_inventory %} = 'bubble_tickets'
      THEN ${bubble_tickets}
      WHEN {% parameter player_inventory %} = 'time_tickets'
      THEN ${time_tickets}
      WHEN {% parameter player_inventory %} = 'five_to_four_tickets'
      THEN ${five_to_four_tickets}
      WHEN {% parameter player_inventory %} = 'exp_tickets'
      THEN ${exp_tickets}
    END ;;
  }


  measure: 3_median_player {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: median
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box 002 tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box 007 tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score tickets'
      THEN ${score_tickets}
      WHEN {% parameter player_inventory %} = 'bubble_tickets'
      THEN ${bubble_tickets}
      WHEN {% parameter player_inventory %} = 'time_tickets'
      THEN ${time_tickets}
      WHEN {% parameter player_inventory %} = 'five_to_four_tickets'
      THEN ${five_to_four_tickets}
      WHEN {% parameter player_inventory %} = 'exp_tickets'
      THEN ${exp_tickets}
    END ;;
  }


  measure: 2_25th_player {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box 002 tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box 007 tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score tickets'
      THEN ${score_tickets}
      WHEN {% parameter player_inventory %} = 'bubble_tickets'
      THEN ${bubble_tickets}
      WHEN {% parameter player_inventory %} = 'time_tickets'
      THEN ${time_tickets}
      WHEN {% parameter player_inventory %} = 'five_to_four_tickets'
      THEN ${five_to_four_tickets}
      WHEN {% parameter player_inventory %} = 'exp_tickets'
      THEN ${exp_tickets}
    END ;;
  }


  measure: 4_75th_player {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box 002 tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box 007 tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score tickets'
      THEN ${score_tickets}
      WHEN {% parameter player_inventory %} = 'bubble_tickets'
      THEN ${bubble_tickets}
      WHEN {% parameter player_inventory %} = 'time_tickets'
      THEN ${time_tickets}
      WHEN {% parameter player_inventory %} = 'five_to_four_tickets'
      THEN ${five_to_four_tickets}
      WHEN {% parameter player_inventory %} = 'exp_tickets'
      THEN ${exp_tickets}
    END ;;
  }




  set: detail {
    fields: [round_id, coins, gems]
  }
}
