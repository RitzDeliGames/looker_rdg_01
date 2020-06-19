include: "/views/**/events.view"


view: player_analysis_view {
   extends: [events]

#   derived_table: {
#     sql: SELECT CAST(JSON_VALUE(extra_json, '$.round_id') AS NUMERIC) as round_id,
#           coins,
#           gems,
#           player_level_xp AS player_xp,
#           player_xp_level AS xp_player,
#       FROM
#       events
#       WHERE event_name = 'round_end'
#       AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
#        ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }
#

  dimension: characters {
    type: string
    sql: characters ;;
  }

  dimension: character {
    type: string
    sql: JSON_EXTRACT(characters, '$.character_id') ;;
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

  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }



#   dimension: player_xp {
#     type: number
#     sql: ${TABLE}.player_xp ;;
#   }
#
#   dimension: xp_player {
#     type: number
#     sql: ${TABLE}.xp_player ;;
#   }



  parameter: characters_dimensions {
    type: string
    allowed_value: {
      label: "Characters per round"
      value: "Characters per round"
    }
    allowed_value: {
      label: "inventory"
      value: "inventory"
    }
    allowed_value: {
      label: "xp_level"
      value: "xp_level"
    }
    allowed_value: {
      label: "skill_level"
      value: "skill_level"
    }
    allowed_value: {
      label: "level_cap"
      value: "level_cap"
    }
    allowed_value: {
      label: "max_level"
      value: "max_level"
    }
    allowed_value: {
      label: "max_skill"
      value: "max_skill"
    }
  }


  measure: number_of_characters_per_round {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "Character count"
    type: count_distinct
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'Characters per round'
      THEN ${character}
    END ;;
  }


  measure: 1_min_char_dim {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "1. character dimension"
    type: min
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      WHEN {% parameter characters_dimensions %} = 'xp_level'
      THEN ${xp_level}
      WHEN {% parameter characters_dimensions %} = 'skill_level'
      THEN ${skill_level}
      WHEN {% parameter characters_dimensions %} = 'level_cap'
      THEN ${level_cap}
      WHEN {% parameter characters_dimensions %} = 'max_level'
      THEN ${max_level}
      WHEN {% parameter characters_dimensions %} = 'max_skill'
      THEN ${max_skill}
    END ;;
  }


  measure: 5_max_char_dim {
  #     drill_fields: [detail*]
  #     link: {
  #       label: "Drill and sort by COINS balance"
  #       url: "{{ link }}&sorts=player_analysis.coins+desc"
  #     }
  #     link: {
  #       label: "Drill and sort by XP PLAYER balance"
  #       url: "{{ link }}&sorts=player_analysis.gems+desc"
  #     }
    group_label: "1. character dimension"
    type: max
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      WHEN {% parameter characters_dimensions %} = 'xp_level'
      THEN ${xp_level}
      WHEN {% parameter characters_dimensions %} = 'skill_level'
      THEN ${skill_level}
      WHEN {% parameter characters_dimensions %} = 'level_cap'
      THEN ${level_cap}
      WHEN {% parameter characters_dimensions %} = 'max_level'
      THEN ${max_level}
      WHEN {% parameter characters_dimensions %} = 'max_skill'
      THEN ${max_skill}
    END ;;
}


  measure: 3_median_char_dim {
    #     drill_fields: [detail*]
    #     link: {
    #       label: "Drill and sort by COINS balance"
    #       url: "{{ link }}&sorts=player_analysis.coins+desc"
    #     }
    #     link: {
    #       label: "Drill and sort by XP PLAYER balance"
    #       url: "{{ link }}&sorts=player_analysis.gems+desc"
    #     }
    group_label: "1. character dimension"
    type: median
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      WHEN {% parameter characters_dimensions %} = 'xp_level'
      THEN ${xp_level}
      WHEN {% parameter characters_dimensions %} = 'skill_level'
      THEN ${skill_level}
      WHEN {% parameter characters_dimensions %} = 'level_cap'
      THEN ${level_cap}
      WHEN {% parameter characters_dimensions %} = 'max_level'
      THEN ${max_level}
      WHEN {% parameter characters_dimensions %} = 'max_skill'
      THEN ${max_skill}
    END ;;
  }


  measure: 2_25th_char_dim {
    #     drill_fields: [detail*]
    #     link: {
    #       label: "Drill and sort by COINS balance"
    #       url: "{{ link }}&sorts=player_analysis.coins+desc"
    #     }
    #     link: {
    #       label: "Drill and sort by XP PLAYER balance"
    #       url: "{{ link }}&sorts=player_analysis.gems+desc"
    #     }
    group_label: "1. character dimension"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      WHEN {% parameter characters_dimensions %} = 'xp_level'
      THEN ${xp_level}
      WHEN {% parameter characters_dimensions %} = 'skill_level'
      THEN ${skill_level}
      WHEN {% parameter characters_dimensions %} = 'level_cap'
      THEN ${level_cap}
      WHEN {% parameter characters_dimensions %} = 'max_level'
      THEN ${max_level}
      WHEN {% parameter characters_dimensions %} = 'max_skill'
      THEN ${max_skill}
    END ;;
  }


  measure: 4_75th_char_dim {
    #     drill_fields: [detail*]
    #     link: {
    #       label: "Drill and sort by COINS balance"
    #       url: "{{ link }}&sorts=player_analysis.coins+desc"
    #     }
    #     link: {
    #       label: "Drill and sort by XP PLAYER balance"
    #       url: "{{ link }}&sorts=player_analysis.gems+desc"
    #     }
    group_label: "1. character dimension"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN {% parameter characters_dimensions %} = 'inventory'
      THEN ${inventory}
      WHEN {% parameter characters_dimensions %} = 'xp_level'
      THEN ${xp_level}
      WHEN {% parameter characters_dimensions %} = 'skill_level'
      THEN ${skill_level}
      WHEN {% parameter characters_dimensions %} = 'level_cap'
      THEN ${level_cap}
      WHEN {% parameter characters_dimensions %} = 'max_level'
      THEN ${max_level}
      WHEN {% parameter characters_dimensions %} = 'max_skill'
      THEN ${max_skill}
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



###_LINE_CHARTS_###

##_MEASURES_##


  measure: 1_min_ {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
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
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
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
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
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
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
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
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
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
    fields: [round_id, coins, gems]
  }
}
