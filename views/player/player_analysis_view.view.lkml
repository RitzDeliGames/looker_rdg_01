include: "/views/**/events.view"


view: player_analysis_view {
   extends: [events]



  dimension: characters {
    type: string
    sql: characters ;;
  }

  dimension: character {
    type: string
    sql: JSON_EXTRACT(${characters.characters}, '$.character_id') ;;
  }

  dimension: inventory {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.inventory') ;;
  }

  dimension: xp_level {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.xp_level') ;;
  }

  dimension: skill_level {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.skill_level') ;;
  }

  dimension: collection_date {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.collection_date') ;;
  }

  dimension: level_up_date {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${characters.characters}, '$.level_up_date'), '"', '') AS INT64) ;;
  }


#   dimension_group: level_up_date_group {
#     type: time
#     timeframes: [
#       raw,
#       date,
#       week,
#       month,
#       quarter,
#       year
#     ]
#     datatype: epoch
#     sql: ${level_up_date} ;;
#     #sql: CAST(JSON_EXTRACT(${characters.characters}, '$.level_up_date') AS INT64) ;;
#   }


  dimension: skill_up_date {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.skill_up_date') ;;
  }

  dimension: collection_round_id {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.collection_round_id') ;;
  }

  dimension: level_up_round_id {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.level_up_round_id') ;;
  }

  dimension: skilled_up_round_id {
    type: number
    sql: JSON_EXTRACT(${characters.characters}, '$.skilled_up_round_id') ;;
  }

  dimension: level_cap {
    type: string
    sql: JSON_EXTRACT(${characters.characters}, '$.level_cap') ;;
  }

  dimension: max_level {
    type: string
    sql: JSON_EXTRACT(${characters.characters}, '$.max_level') ;;
  }

  dimension: max_skill {
    type: string
    sql: JSON_EXTRACT(${characters.characters}, '$.max_skill') ;;
  }



  #####################

#   dimension: round_id {
#     type: number
#     sql: ${TABLE}.round_id ;;
#   }
#   dimension: player_xp {
#     type: number
#     sql: ${TABLE}.player_xp ;;
#   }
#   dimension: xp_player {
#     type: number
#     sql: ${TABLE}.xp_player ;;
#   }




  parameter: characters_dimensions {
    type: string
    allowed_value: {
      label: "Characters Analysis"
      value: "Characters Analysis"
    }
    allowed_value: {
      label: "inventory"
      value: "inventory"
    }
#     allowed_value: {
#       label: "xp_level"
#       value: "xp_level"
#     }
#     allowed_value: {
#       label: "skill_level"
#       value: "skill_level"
#     }
#     allowed_value: {
#       label: "level_cap"
#       value: "level_cap"
#     }
#     allowed_value: {
#       label: "max_level"
#       value: "max_level"
#     }
#     allowed_value: {
#       label: "max_skill"
#       value: "max_skill"
#     }
  }


  measure: count_of_unique_characters {
    group_label: "3. Character count"
    type: count_distinct
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'Characters Analysis'
      THEN ${character}
    END ;;
  }



#   measure: xp_level_measure {
#     type: number
#     sql: CAST(${xp_level} AS NUMERIC) ;;
#   }
#
#   measure: depth_over_char_collected {
#     type: number
#     sql: ${count_of_characters} / ${xp_level_measure} ;;
#   }



  measure: 1_min_char_dim {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by characters Inventory"
      url: "{{ link }}&sorts=characters_dimensions.inventory+desc"
    }
#     link: {
#       label: "Drill and sort by characters xp level"
#       url: "{{ link }}&sorts=characters_dimensions.xp_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters skill level"
#       url: "{{ link }}&sorts=characters_dimensions.skill_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters level cap"
#       url: "{{ link }}&sorts=characters_dimensions.level_cap+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max level"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max skill"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
    group_label: "1. character dimension"
    type: min
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      --WHEN {% parameter characters_dimensions %} = 'xp_level'
      --THEN ${xp_level}
      --WHEN {% parameter characters_dimensions %} = 'skill_level'
      --THEN ${skill_level}
      --WHEN {% parameter characters_dimensions %} = 'level_cap'
      --THEN ${level_cap}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_level}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_skill}
    END ;;
  }


  measure: 5_max_char_dim {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by characters Inventory"
      url: "{{ link }}&sorts=characters_dimensions.inventory+desc"
    }
#     link: {
#       label: "Drill and sort by characters xp level"
#       url: "{{ link }}&sorts=characters_dimensions.xp_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters skill level"
#       url: "{{ link }}&sorts=characters_dimensions.skill_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters level cap"
#       url: "{{ link }}&sorts=characters_dimensions.level_cap+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max level"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max skill"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
    group_label: "1. character dimension"
    type: max
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      --WHEN {% parameter characters_dimensions %} = 'xp_level'
      --THEN ${xp_level}
      --WHEN {% parameter characters_dimensions %} = 'skill_level'
      --THEN ${skill_level}
      --WHEN {% parameter characters_dimensions %} = 'level_cap'
      --THEN ${level_cap}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_level}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_skill}
    END ;;
}


  measure: 3_median_char_dim {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by characters Inventory"
      url: "{{ link }}&sorts=characters_dimensions.inventory+desc"
    }
#     link: {
#       label: "Drill and sort by characters xp level"
#       url: "{{ link }}&sorts=characters_dimensions.xp_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters skill level"
#       url: "{{ link }}&sorts=characters_dimensions.skill_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters level cap"
#       url: "{{ link }}&sorts=characters_dimensions.level_cap+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max level"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max skill"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
    group_label: "1. character dimension"
    type: median
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      --WHEN {% parameter characters_dimensions %} = 'xp_level'
      --THEN ${xp_level}
      --WHEN {% parameter characters_dimensions %} = 'skill_level'
      --THEN ${skill_level}
      --WHEN {% parameter characters_dimensions %} = 'level_cap'
      --THEN ${level_cap}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_level}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_skill}
    END ;;
  }


  measure: 2_25th_char_dim {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by characters Inventory"
      url: "{{ link }}&sorts=characters_dimensions.inventory+desc"
    }
#     link: {
#       label: "Drill and sort by characters xp level"
#       url: "{{ link }}&sorts=characters_dimensions.xp_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters skill level"
#       url: "{{ link }}&sorts=characters_dimensions.skill_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters level cap"
#       url: "{{ link }}&sorts=characters_dimensions.level_cap+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max level"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max skill"
#       url: "{{ link }}&sorts=characters_dimensions.max_skill+desc"
#     }
    group_label: "1. character dimension"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      --WHEN {% parameter characters_dimensions %} = 'xp_level'
      --THEN ${xp_level}
      --WHEN {% parameter characters_dimensions %} = 'skill_level'
      --THEN ${skill_level}
      --WHEN {% parameter characters_dimensions %} = 'level_cap'
      --THEN ${level_cap}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_level}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_skill}
    END ;;
  }


  measure: 4_75th_char_dim {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by characters Inventory"
      url: "{{ link }}&sorts=characters_dimensions.inventory+desc"
    }
#     link: {
#       label: "Drill and sort by characters xp level"
#       url: "{{ link }}&sorts=characters_dimensions.xp_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters skill level"
#       url: "{{ link }}&sorts=characters_dimensions.skill_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters level cap"
#       url: "{{ link }}&sorts=characters_dimensions.level_cap+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max level"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
#     link: {
#       label: "Drill and sort by characters max skill"
#       url: "{{ link }}&sorts=characters_dimensions.max_level+desc"
#     }
    group_label: "1. character dimension"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      --WHEN {% parameter characters_dimensions %} = 'xp_level'
      --THEN ${xp_level}
      --WHEN {% parameter characters_dimensions %} = 'skill_level'
      --THEN ${skill_level}
      --WHEN {% parameter characters_dimensions %} = 'level_cap'
      --THEN ${level_cap}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_level}
      --WHEN {% parameter characters_dimensions %} = 'max_level'
      --THEN ${max_skill}
    END ;;
  }



  #############################

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
      label: "box_002_tickets"
      value: "box_002_tickets"
    }
    allowed_value: {
      label: "box_007_tickets"
      value: "box_007_tickets"
    }
    allowed_value: {
      label: "score_tickets"
      value: "score_tickets"
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




  measure: 1_min_ {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by coins"
      url: "{{ link }}&sorts=player_inventory.coins+desc"
    }
    link: {
      label: "Drill and sort by gems"
      url: "{{ link }}&sorts=player_inventory.gems+desc"
    }
    link: {
      label: "Drill and sort by lives"
      url: "{{ link }}&sorts=player_inventory.lives+desc"
    }
    link: {
      label: "Drill and sort by box_002_tickets"
      url: "{{ link }}&sorts=player_inventory.box_002_tickets+desc"
    }
    link: {
      label: "Drill and sort by box_007_tickets"
      url: "{{ link }}&sorts=player_inventory.box_007_tickets+desc"
    }
    link: {
      label: "Drill and sort by score_tickets"
      url: "{{ link }}&sorts=player_inventory.score_tickets+desc"
    }
    link: {
      label: "Drill and sort by bubble_tickets"
      url: "{{ link }}&sorts=player_inventory.bubble_tickets+desc"
    }
    link: {
      label: "Drill and sort by time_tickets"
      url: "{{ link }}&sorts=player_inventory.time_tickets+desc"
    }
    link: {
      label: "Drill and sort by five_to_four_tickets"
      url: "{{ link }}&sorts=player_inventory.five_to_four_tickets+desc"
    }
    link: {
      label: "Drill and sort by exp_tickets"
      url: "{{ link }}&sorts=player_inventory.exp_tickets+desc"
    }
    group_label: "2. player inventory"
    type: min
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins balance'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box_002_tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box_007_tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score_tickets'
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


  measure: 5_max_ {
    link: {
      label: "Drill and sort by coins"
      url: "{{ link }}&sorts=player_inventory.coins+desc"
    }
    link: {
      label: "Drill and sort by gems"
      url: "{{ link }}&sorts=player_inventory.gems+desc"
    }
    link: {
      label: "Drill and sort by lives"
      url: "{{ link }}&sorts=player_inventory.lives+desc"
    }
    link: {
      label: "Drill and sort by box_002_tickets"
      url: "{{ link }}&sorts=player_inventory.box_002_tickets+desc"
    }
    link: {
      label: "Drill and sort by box_007_tickets"
      url: "{{ link }}&sorts=player_inventory.box_007_tickets+desc"
    }
    link: {
      label: "Drill and sort by score_tickets"
      url: "{{ link }}&sorts=player_inventory.score_tickets+desc"
    }
    link: {
      label: "Drill and sort by bubble_tickets"
      url: "{{ link }}&sorts=player_inventory.bubble_tickets+desc"
    }
    link: {
      label: "Drill and sort by time_tickets"
      url: "{{ link }}&sorts=player_inventory.time_tickets+desc"
    }
    link: {
      label: "Drill and sort by five_to_four_tickets"
      url: "{{ link }}&sorts=player_inventory.five_to_four_tickets+desc"
    }
    link: {
      label: "Drill and sort by exp_tickets"
      url: "{{ link }}&sorts=player_inventory.exp_tickets+desc"
    }
    group_label: "2. player inventory"
    type: max
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins balance'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box_002_tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box_007_tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score_tickets'
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


  measure: 3_median_ {
    link: {
      label: "Drill and sort by coins"
      url: "{{ link }}&sorts=player_inventory.coins+desc"
    }
    link: {
      label: "Drill and sort by gems"
      url: "{{ link }}&sorts=player_inventory.gems+desc"
    }
    link: {
      label: "Drill and sort by lives"
      url: "{{ link }}&sorts=player_inventory.lives+desc"
    }
    link: {
      label: "Drill and sort by box_002_tickets"
      url: "{{ link }}&sorts=player_inventory.box_002_tickets+desc"
    }
    link: {
      label: "Drill and sort by box_007_tickets"
      url: "{{ link }}&sorts=player_inventory.box_007_tickets+desc"
    }
    link: {
      label: "Drill and sort by score_tickets"
      url: "{{ link }}&sorts=player_inventory.score_tickets+desc"
    }
    link: {
      label: "Drill and sort by bubble_tickets"
      url: "{{ link }}&sorts=player_inventory.bubble_tickets+desc"
    }
    link: {
      label: "Drill and sort by time_tickets"
      url: "{{ link }}&sorts=player_inventory.time_tickets+desc"
    }
    link: {
      label: "Drill and sort by five_to_four_tickets"
      url: "{{ link }}&sorts=player_inventory.five_to_four_tickets+desc"
    }
    link: {
      label: "Drill and sort by exp_tickets"
      url: "{{ link }}&sorts=player_inventory.exp_tickets+desc"
    }
    group_label: "2. player inventory"
    type: median
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins balance'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box_002_tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box_007_tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score_tickets'
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


  measure: 2_25th_ {
    link: {
      label: "Drill and sort by coins"
      url: "{{ link }}&sorts=player_inventory.coins+desc"
    }
    link: {
      label: "Drill and sort by gems"
      url: "{{ link }}&sorts=player_inventory.gems+desc"
    }
    link: {
      label: "Drill and sort by lives"
      url: "{{ link }}&sorts=player_inventory.lives+desc"
    }
    link: {
      label: "Drill and sort by box_002_tickets"
      url: "{{ link }}&sorts=player_inventory.box_002_tickets+desc"
    }
    link: {
      label: "Drill and sort by box_007_tickets"
      url: "{{ link }}&sorts=player_inventory.box_007_tickets+desc"
    }
    link: {
      label: "Drill and sort by score_tickets"
      url: "{{ link }}&sorts=player_inventory.score_tickets+desc"
    }
    link: {
      label: "Drill and sort by bubble_tickets"
      url: "{{ link }}&sorts=player_inventory.bubble_tickets+desc"
    }
    link: {
      label: "Drill and sort by time_tickets"
      url: "{{ link }}&sorts=player_inventory.time_tickets+desc"
    }
    link: {
      label: "Drill and sort by five_to_four_tickets"
      url: "{{ link }}&sorts=player_inventory.five_to_four_tickets+desc"
    }
    link: {
      label: "Drill and sort by exp_tickets"
      url: "{{ link }}&sorts=player_inventory.exp_tickets+desc"
    }
    group_label: "2. player inventory"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins balance'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box_002_tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box_007_tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score_tickets'
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


  measure: 4_75th_ {
    link: {
      label: "Drill and sort by coins"
      url: "{{ link }}&sorts=player_inventory.coins+desc"
    }
    link: {
      label: "Drill and sort by gems"
      url: "{{ link }}&sorts=player_inventory.gems+desc"
    }
    link: {
      label: "Drill and sort by lives"
      url: "{{ link }}&sorts=player_inventory.lives+desc"
    }
    link: {
      label: "Drill and sort by box_002_tickets"
      url: "{{ link }}&sorts=player_inventory.box_002_tickets+desc"
    }
    link: {
      label: "Drill and sort by box_007_tickets"
      url: "{{ link }}&sorts=player_inventory.box_007_tickets+desc"
    }
    link: {
      label: "Drill and sort by score_tickets"
      url: "{{ link }}&sorts=player_inventory.score_tickets+desc"
    }
    link: {
      label: "Drill and sort by bubble_tickets"
      url: "{{ link }}&sorts=player_inventory.bubble_tickets+desc"
    }
    link: {
      label: "Drill and sort by time_tickets"
      url: "{{ link }}&sorts=player_inventory.time_tickets+desc"
    }
    link: {
      label: "Drill and sort by five_to_four_tickets"
      url: "{{ link }}&sorts=player_inventory.five_to_four_tickets+desc"
    }
    link: {
      label: "Drill and sort by exp_tickets"
      url: "{{ link }}&sorts=player_inventory.exp_tickets+desc"
    }
    group_label: "2. player inventory"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN {% parameter player_inventory %} = 'coins balance'
      THEN ${coins}
      WHEN {% parameter player_inventory %} = 'gems'
      THEN ${gems}
      WHEN {% parameter player_inventory %} = 'lives'
      THEN ${lives}
      WHEN {% parameter player_inventory %} = 'box_002_tickets'
      THEN ${box_002_tickets}
      WHEN {% parameter player_inventory %} = 'box_007_tickets'
      THEN ${box_007_tickets}
      WHEN {% parameter player_inventory %} = 'score_tickets'
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
    fields: [events.round_id,
             coins,
             gems,
             lives,
             box_002_tickets,
             box_007_tickets,
             score_tickets,
             bubble_tickets,
             time_tickets,
             five_to_four_tickets,
             exp_tickets,
             inventory,
             xp_level,
             skill_level,
             level_cap,
             max_level,
             max_skill]
  }
}
