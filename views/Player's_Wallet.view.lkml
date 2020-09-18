include: "/views/**/events.view"

view: player_s_wallet {

  extends: [events]



  dimension: coins_econ_in_out {
    type: number
    sql: CASE
      WHEN ${event_name} = 'transaction'
      THEN ${coins} * (-1)
      WHEN ${event_name} = 'reward'
      THEN ${coins}
      END;;
  }

  dimension: gems_econ_in_out {
    type: number
    sql: CASE
      WHEN ${event_name} = 'transaction'
      THEN ${gems} * (-1)
      WHEN ${event_name} = 'reward'
      THEN ${gems}
      END;;
  }

  dimension: lives_econ_in_out {
    type: number
    sql: CASE
      WHEN ${event_name} = 'transaction'
      THEN ${lives} * (-1)
      WHEN ${event_name} = 'reward'
      THEN ${lives}
      END;;
  }

  ###############

  dimension: coins_econ_in_out_positive {
    type: number
    hidden: yes
    sql: CASE
      WHEN ${event_name} = 'reward'
      THEN ${coins}
      END;;
  }

  dimension: coins_econ_in_out_negative {
    type: number
    hidden: yes
    sql: CASE
      WHEN ${event_name} = 'transaction'
      THEN ${coins} * (-1)
      END;;
  }

  measure: coins_earned {
    type: max
    sql: ${coins_econ_in_out_positive} ;;
  }

  measure: coins_spent {
    type: min
    sql: ${coins_econ_in_out_negative} ;;
  }

  measure: coins_net {
    type: number
    sql: MAX(${coins_econ_in_out_positive}) + MIN(${coins_econ_in_out_negative})  ;;
  }



  ###################CURRENCY BALANCES MEASURES###################

  parameter: 1_currency_type {
    type: string
    allowed_value: {
      label: "Gems"
      value: "Gems"
    }
    allowed_value: {
      label: "Coins"
      value: "Coins"
    }
    allowed_value: {
      label: "Lives"
      value: "Lives"
    }
  }

  measure: sum_currencies {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
    group_label: "1. Player's Wallet - Currency Balances: Gems, Coins & Lives"
    type: sum
    sql: CASE
      WHEN  {% parameter 1_currency_type %} = 'Gems'
      THEN ${gems_econ_in_out}
      WHEN  {% parameter 1_currency_type %} = 'Coins'
      THEN ${coins_econ_in_out}
      WHEN  {% parameter 1_currency_type %} = 'Lives'
      THEN ${lives_econ_in_out}
    END  ;;
  }

  measure: median {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
  group_label: "1. Player's Wallet - Currency Balances: Gems, Coins & Lives"
  type: median
  sql: CASE
      WHEN  {% parameter 1_currency_type %} = 'Gems'
      THEN ${gems}
      WHEN  {% parameter 1_currency_type %} = 'Coins'
      THEN ${coins}
      WHEN  {% parameter 1_currency_type %} = 'Lives'
      THEN ${lives}
    END  ;;
}

measure: 25th_quartile {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "1. Player's Wallet - Currency Balances: Gems, Coins & Lives"
type: percentile
percentile: 25
sql: CASE
      WHEN  {% parameter 1_currency_type %} = 'Gems'
      THEN ${gems}
      WHEN  {% parameter 1_currency_type %} = 'Coins'
      THEN ${coins}
      WHEN  {% parameter 1_currency_type %} = 'Lives'
      THEN ${lives}
    END  ;;
}

measure: 75th_quartile {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "1. Player's Wallet - Currency Balances: Gems, Coins & Lives"
type: percentile
percentile: 75
sql: CASE
      WHEN  {% parameter 1_currency_type %} = 'Gems'
      THEN ${gems}
      WHEN  {% parameter 1_currency_type %} = 'Coins'
      THEN ${coins}
      WHEN  {% parameter 1_currency_type %} = 'Lives'
      THEN ${lives}
    END  ;;
}


########################TICKETS MEASURES########################

####CAPSULE####

parameter: 2_capsule_type {
  type: string
  allowed_value: {
    label: "box_001"
    value: "box_001"
  }
  allowed_value: {
    label: "box_002"
    value: "box_002"
  }
  allowed_value: {
    label: "box_003"
    value: "box_003"
  }
  allowed_value: {
    label: "box_006"
    value: "box_006"
  }
  allowed_value: {
    label: "box_007"
    value: "box_007"
  }
}

measure: median_cap {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "2. Player's Wallet - Capsules: Boxes 1, 2, 3, 6 & 7"
type: median
sql: CASE
      WHEN  {% parameter 2_capsule_type %} = 'box_001'
      THEN ${box_001_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_002'
      THEN ${box_002_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_003'
      THEN ${box_003_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_006'
      THEN ${box_006_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_007'
      THEN ${box_007_tickets}
    END  ;;
}

measure: 25th_quartile_cap {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "2. Player's Wallet - Capsules: Boxes 1, 2, 3, 6 & 7"
type: percentile
percentile: 25
sql: CASE
      WHEN  {% parameter 2_capsule_type %} = 'box_001'
      THEN ${box_001_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_002'
      THEN ${box_002_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_003'
      THEN ${box_003_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_006'
      THEN ${box_006_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_007'
      THEN ${box_007_tickets}
    END  ;;
}

measure: 75th_quartile_cap {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "2. Player's Wallet - Capsules: Boxes 1, 2, 3, 6 & 7"
type: percentile
percentile: 75
sql: CASE
      WHEN  {% parameter 2_capsule_type %} = 'box_001'
      THEN ${box_001_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_002'
      THEN ${box_002_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_003'
      THEN ${box_003_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_006'
      THEN ${box_006_tickets}
      WHEN  {% parameter 2_capsule_type %} = 'box_007'
      THEN ${box_007_tickets}
    END  ;;
}


####BOOST INVENTORY####

parameter: 3_boost_type {
  type: string
  allowed_value: {
    label: "Score"
    value: "Score"
  }
  allowed_value: {
    label: "Bubble"
    value: "Bubble"
  }
  allowed_value: {
    label: "Time"
    value: "Time"
  }
  allowed_value: {
    label: "5-to-4"
    value: "5-to-4"
  }
  allowed_value: {
    label: "XP"
    value: "XP"
  }
  allowed_value: {
    label: "Coin"
    value: "Coin"
  }
}

measure: median_boosts {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "3. Player's Wallet - Boosts: Score, Bubble, Time, 5-to-4, XP & Coins"
type: median
sql: CASE
      WHEN  {% parameter 3_boost_type %} = 'Score'
      THEN ${score_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Bubble'
      THEN ${bubble_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Time'
      THEN ${time_tickets}
      WHEN  {% parameter 3_boost_type %} = '5-to-4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter 3_boost_type %} = 'XP'
      THEN ${exp_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Coin'
      THEN ${coin_tickets}
    END  ;;
}

measure: 25th_quartile_boosts {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "3. Player's Wallet - Boosts: Score, Bubble, Time, 5-to-4, XP & Coins"
type: percentile
percentile: 25
sql: CASE
      WHEN  {% parameter 3_boost_type %} = 'Score'
      THEN ${score_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Bubble'
      THEN ${bubble_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Time'
      THEN ${time_tickets}
      WHEN  {% parameter 3_boost_type %} = '5-to-4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter 3_boost_type %} = 'XP'
      THEN ${exp_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Coin'
      THEN ${coin_tickets}
    END  ;;
}

measure: 75th_quartile_boosts {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "3. Player's Wallet - Boosts: Score, Bubble, Time, 5-to-4, XP & Coins"
type: percentile
percentile: 75
sql: CASE
      WHEN  {% parameter 3_boost_type %} = 'Score'
      THEN ${score_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Bubble'
      THEN ${bubble_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Time'
      THEN ${time_tickets}
      WHEN  {% parameter 3_boost_type %} = '5-to-4'
      THEN ${five_to_four_tickets}
      WHEN  {% parameter 3_boost_type %} = 'XP'
      THEN ${exp_tickets}
      WHEN  {% parameter 3_boost_type %} = 'Coin'
      THEN ${coin_tickets}
    END  ;;
}


####SKILL & LEVEL####

parameter: 4_skill_n_level_type {
  type: string
  allowed_value: {
    label: "Skill"
    value: "Skill"
  }
  allowed_value: {
    label: "Level"
    value: "Level"
  }
}

measure: median_s_n_l {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "4. Player's Wallet - Skill & Level"
type: median
sql: CASE
      WHEN  {% parameter 4_skill_n_level_type %} = 'Skill'
      THEN ${skill}
      WHEN  {% parameter 4_skill_n_level_type %} = 'Level'
      THEN ${level}
    END ;;
}

measure: 25th_quartile_s_n_l {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "4. Player's Wallet - Skill & Level"
type: percentile
percentile: 25
sql: CASE
      WHEN  {% parameter 4_skill_n_level_type %} = 'Skill'
      THEN ${skill}
      WHEN  {% parameter 4_skill_n_level_type %} = 'Level'
      THEN ${level}
    END ;;
}

measure: 75th_quartile_s_n_l {
#     drill_fields: [user_details*]
#     link: {
#       label: "Drill and sort by coins earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.coins_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by XP earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.xp_earned+desc"
#     }
#     link: {
#       label: "Drill and sort by score earned"
#       url: "{{ link }}&sorts=_001_coins_xp_score.score_earned+desc"
#     }
group_label: "4. Player's Wallet - Skill & Level"
type: percentile
percentile: 75
sql: CASE
      WHEN  {% parameter 4_skill_n_level_type %} = 'Skill'
      THEN ${skill}
      WHEN  {% parameter 4_skill_n_level_type %} = 'Level'
      THEN ${level}
    END ;;
}


}
