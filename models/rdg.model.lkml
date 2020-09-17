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

datagroup: change_at_midnight {
  sql_trigger:  SELECT CURRENT_DATE  ;;
  max_cache_age: "24 hours"
}

datagroup: events_raw {
  sql_trigger:  SELECT max(event) FROM `eraser-blast.game_data.events` WHERE DATE(event) = CURRENT_DATE  ;;
}

datagroup: events_boost {
  sql_trigger:  SELECT CURRENT_DATE  ;;
}

  named_value_format: large_usd { value_format: "[>=1000000]\"$\"0.00,,\"M\";[>=1000]\"$\"0.00,\"K\";\"$\"0.00" }
  named_value_format: large_number { value_format: "[>=1000000]0.00,,\"M\";[>=1000]0.00,\"K\";0" }

##########GENERAL EXPLORES##########

explore: events {
  sql_always_where:
    user_type NOT IN ("internal_editor", "unit_test") ;;
    join: retention {
      sql_on: ${events.player_id} = ${retention.user_id}
                and ${events.user_first_seen_date} = ${retention.signup_day_date};;
      relationship: many_to_one
      }
    join: created_at_max {
      sql_on: ${events.user_id} = ${created_at_max.user_id}
              ;;
      relationship: one_to_one
      }

}

explore: player_s_wallet {}

explore: created_at_max {}


explore: sessions {
    join: events {
    sql_on: ${sessions.user_id} = ${events.user_id}
        AND ${sessions.event_date} = ${events.event_date}
        AND ${sessions.current_card} = ${events.current_card}
        ;;
    relationship: one_to_one
  }
}


# explore: sessions_alt {}


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
  always_join: [card_mapping]
  sql_always_where: _000_bingo_cards_comp.event_name = "cards"
  AND _000_bingo_cards_comp.user_type NOT IN ("internal_editor", "unit_test") ;;
  view_name: _000_bingo_cards_comp
  join: node_data {
    fields: [node_data.node_data]
    relationship: one_to_many
    from: _000_bingo_cards_comp
    sql: CROSS JOIN UNNEST(JSON_EXTRACT_array(extra_json, '$.node_data')) as node_data ;;
    }
  join: card_mapping {
    from: _000_bingo_cards_comp
#     sql: CROSS JOIN card_mapping, UNNEST([
#        row_1_search
#       , row_2_search
#       , row_3_search
#       , row_4_search
#       , row_5_search
#       , column_1_search
#       , column_2_search
#       , column_3_search
#       , column_4_search
#       , column_5_search
#       , diagonal_01_search
#       , diagonal_02_search
#   ]) as card_id ;;

    sql: CROSS JOIN UNNEST([
      ${card_mapping.row_1_search}
      , ${card_mapping.row_2_search}
      , ${card_mapping.row_3_search}
      , ${card_mapping.row_4_search}
      , ${card_mapping.row_5_search}
      , ${card_mapping.column_1_search}
      , ${card_mapping.column_2_search}
      , ${card_mapping.column_3_search}
      , ${card_mapping.column_4_search}
      , ${card_mapping.column_5_search}
      , ${card_mapping.diagonal_01_search}
      , ${card_mapping.diagonal_02_search}
      ]) as card_id ;;
    relationship: many_to_one

#       , ${bing_cards.row_2_search}, ${bing_cards.row_3_search}, ${bing_cards.row_4_search}, ${bing_cards.row_5_search}, ${bing_cards.column_1_search}, ${bing_cards.column_2_search}, ${bing_cards.column_3_search}, ${bing_cards.column_4_search}, ${bing_cards.column_5_search}, ${bing_cards.diagonal_01_search}, ${bing_cards.diagonal_02_search}]) card_id ;;
  }
  join: max_rounds_for_card_finished {
    relationship: many_to_one
    sql_on: ${_000_bingo_cards_comp.player_id} = ${max_rounds_for_card_finished.user_id}
      AND ${_000_bingo_cards_comp.session_id} = ${max_rounds_for_card_finished.session_id}
      AND ${_000_bingo_cards_comp.game_version} = ${max_rounds_for_card_finished.version} ;;
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

explore: _002_skill_used {}


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


######PLAYER ANALYSIS######

explore: player_analysis_view {
   sql_always_where: user_type NOT IN ("internal_editor", "unit_test")
  ;;
#   event_name = "collection"
#   AND event_name = "round_end"
#   AND user_type NOT IN ("internal_editor", "unit_test")
#   ;;
  view_name: player_analysis_view
  join: characters {
    fields: [characters.characters]
    relationship: one_to_many
    from: player_analysis_view
    sql: CROSS JOIN UNNEST(JSON_EXTRACT_array(extra_json, '$.characters')) as characters
  ;;
  }
}


################

explore: boost_usage {
  sql_always_where: user_type NOT IN ("internal_editor", "unit_test")
  ;;
  join: boost_usage_types_values {
    relationship: many_to_many
    sql_on: ${boost_usage.character_used} = ${boost_usage_types_values.character}
          AND ${boost_usage.timestamp_join} = ${boost_usage_types_values.timestamp_date} ;;
  }
#   join: _000_bingo_cards_comp {
#     relationship: many_to_many
#     sql_on: ${boost_usage.character_used} = ${_000_bingo_cards_comp.character_used}  ;;
#   }
#   join: node_data {
#     fields: [node_data.node_data]
#     relationship: one_to_many
#     from: _000_bingo_cards_comp
#     sql: CROSS JOIN UNNEST(JSON_EXTRACT_array(extra_json, '$.node_data')) as node_data ;;
#   }
}



#########################



######LOAD TIME######

explore: scene_load_time {
  sql_always_where: event_name = "transition"
  AND user_type NOT IN ("internal_editor", "unit_test")
  ;;
  join: events {
    sql_on: ${scene_load_time.user_id_load} = ${events.user_id}
      AND ${scene_load_time.session_id_load} = ${events.session_id} ;;
    relationship: one_to_one
  }
}

explore: test_load_times_rounds {}


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
