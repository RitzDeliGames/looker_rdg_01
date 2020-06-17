connection: "eraser_blast_gbq"

# include all the views
include: "/views/**/*.view"

# include all the dashboards
include: "/dashboards/**/*.dashboard"


##########MODEL##########
datagroup: rdg_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: rdg_default_datagroup

datagroup: events_raw {
  sql_trigger:  SELECT max(event) FROM `eraser-blast.game_data.events` WHERE DATE(event) = CURRENT_DATE  ;;
}
  named_value_format: large_usd { value_format: "[>=1000000]\"$\"0.00,,\"M\";[>=1000]\"$\"0.00,\"K\";\"$\"0.00" }
  named_value_format: large_number { value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0" }

##########GENERAL EXPLORES##########

explore: events {
  sql_always_where:
    user_type NOT IN ("internal_editor", "unit_test");;
}

explore: fue_funnel {
 sql_always_where:
 user_type NOT IN ("internal_editor", "unit_test","bots","ugs");;
}

explore: bingo_card_funnel {
  sql_always_where:
   user_type NOT IN ("internal_editor", "unit_test","bots","ugs");;
}

##########BINGO CARDS##########

explore: _000_bingo_cards {
  sql_always_where: event_name = "cards"
  AND user_type NOT IN ("internal_editor", "unit_test") ;;
  view_name: _000_bingo_cards_comp
  join: node_data {
    fields: [node_data.node_data]
    relationship: many_to_one
    from: _000_bingo_cards_comp
    sql: CROSS JOIN UNNEST(JSON_EXTRACT_array(extra_json, '$.node_data')) as node_data
    ;;
  }
}

##########GAMEPLAY EXPLORES##########


# COINS, XP & SCORE EARNED EXPLORE:

explore: _001_coins_xp_score {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
}


# SKILL USED EXPLORE:

explore: _002_skill_used {
#   sql_always_where: event_name = "round_end"
#   AND JSON_EXTRACT(extra_json, "$.team_slot_0") IS NOT NULL
#   AND ${character_skill} IS NOT NULL
#   ;;
}


# CHAINS & MATCHES MADE EXPLORE:

explore: _003_chains_matches {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
  view_name: _003_chains_matches_comp
  join: chain_length {
    fields: [chain_length.chain_length]
    relationship: many_to_one
    from: _003_chains_matches_comp
    sql: CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.all_chains'))) as chain_length
      ;;
  }
}


# LARGE DROPPED & POPPED EXPLORE:

explore: _004_large_dropped_and_popped {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
}


# BUBBLES EXPLORE:

explore: _005_bubbles {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
  join: bubble_types {
    relationship: one_to_one
    sql_on: ${_005_bubbles_comp.character} = ${bubble_types.character}  ;;
  }

  view_name: _005_bubbles_comp
  join: bubble_normal {
    fields: [bubble_normal.bubble_normal]
    relationship: one_to_many
    from: _005_bubbles_comp
    sql: CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.bubble_normal'))) AS bubble_normal
      ;;
  }
  join: bubble_coins {
    fields: [bubble_coins.bubble_coins]
    relationship: one_to_many
    from: _005_bubbles_comp
    sql: CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.bubble_coins'))) AS bubble_coins
      ;;
  }
  join: bubble_xp {
    fields: [bubble_xp.bubble_xp]
    relationship: one_to_many
    from: _005_bubbles_comp
    sql: CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.bubble_xp'))) AS bubble_xp
      ;;
  }
  join: bubble_time {
    fields: [bubble_time.bubble_time]
    relationship: one_to_many
    from: _005_bubbles_comp
    sql: CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.bubble_time'))) AS bubble_time
      ;;
  }
  join: bubble_score {
    fields: [bubble_score.bubble_score]
    relationship: one_to_many
    from: _005_bubbles_comp
    sql: CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.bubble_score'))) AS bubble_score
      ;;
  }
}


# ROUND LENGTH EXPLORE:

explore: _006_round_length {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
}


# FEVER COUNT EXPLORE:

explore: _007_fever_count {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
}


# FRAME COUNT HISTOGRAM VALUES:

explore: _008_frame_count_histogram {}



# PLAYER ANALYSIS

explore: player_analysis_view {
  sql_always_where: event_name = "round_end"
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
}



# LOAD TIME:

explore: scene_load_time {
  sql_always_where: event_name = "transition"
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
}




##########IAP EXPLORES####################


explore: iap_query {
  sql_always_where: event_name = "transaction"
    AND JSON_EXTRACT(extra_json,"$.transaction_id") IS NOT NULL
    AND user_type NOT IN ("internal_editor", "unit_test");;
}

explore: transactions_query {
  sql_always_where: event_name = "transaction"
    AND user_type NOT IN ("internal_editor", "unit_test");;
}

##########GAMING BLOCK EXPLORES##########

explore: gaming_block_events {
  persist_with: events_raw

  sql_always_where:
    user_type = "external";;

  #always_filter: {
    #filters: {
      #field: event_date
      #value: "last 7 days"
    #}
  #}

  join: gaming_block_session_facts {
    relationship: many_to_one
    sql_on: ${gaming_block_events.unique_session_id} = ${gaming_block_session_facts.unique_session_id} ;;
  }

  join: gaming_block_user_facts {
    view_label: "User Lifetime Values"
    relationship: many_to_one
    sql_on: ${gaming_block_events.user_id} = ${gaming_block_user_facts.user_id} ;;
  }

  join: gaming_block_user_tiering {
    view_label: "User Lifetime Values"
    relationship: many_to_one
    sql_on: ${gaming_block_events.user_id}  = ${gaming_block_user_tiering.user_id} ;;
  }
}

explore: gaming_block_funnel_explorer {
  description: "Player Session Funnels"
  persist_for: "24 hours"

  sql_always_where:
    user_type = "external";;


  always_filter: {
    filters: {
      field: event_time
      value: "30 days"
    }
    filters: {
      field: game_name
      value: "Eraser Blast"
    }
  }
  join: gaming_block_session_facts {
    sql_on: ${gaming_block_funnel_explorer.unique_session_id} = ${gaming_block_session_facts.unique_session_id} ;;
    relationship: many_to_one
  }

  join: gaming_block_user_facts {
    sql_on: ${gaming_block_funnel_explorer.user_id} = ${gaming_block_user_facts.user_id} ;;
    relationship: many_to_one
  }

  join: gaming_block_user_tiering {
    view_label: "User Facts"
    sql_on: ${gaming_block_funnel_explorer.user_id} = ${gaming_block_user_tiering.user_id} ;;
    relationship: many_to_one
  }
}

explore: gaming_block_session_facts {
  label: "Sessions and Users"
  description: "Use this to look at a compressed view of Users and Sessions (without event level data)"

  sql_always_where:
    user_type NOT IN ("internal_editor", "unit_test","ugs","bot");;


  join: gaming_block_user_facts {
    relationship: many_to_one
    sql_on: ${gaming_block_session_facts.user_id} = ${gaming_block_user_facts.user_id} ;;
  }
  join: gaming_block_user_tiering {
    view_label: "User Facts"
    relationship: many_to_one
    sql_on: ${gaming_block_session_facts.user_id} = ${gaming_block_user_tiering.user_id} ;;
  }
}
