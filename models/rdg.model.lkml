connection: "eraser_blast_gbq"

# include all the views
# include: "/views/**/*.view"
include: "/**/*.view"

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

datagroup: change_3_hrs {
  sql_trigger: select floor((timestamp_diff(current_timestamp(),'2021-01-01 00:00:00',second)) / (3*60*60)) ;;
  max_cache_age: "2 hours"
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
    created_at  >= TIMESTAMP('2020-07-06 00:00:00')
    AND user_type = "external"
    AND ${user_id} NOT IN ("anon-c39ef24b-bb78-4339-9e42-befd5532a5d4", "anon-efe60f6f-f82f-4ef9-8edc-daa931b5fdea","anon-57642d8c-c48f-485c-9b85-4421586a9836");;
    join: retention {
      sql_on: ${events.player_id} = ${retention.user_id}
                and ${events.user_first_seen_date} = ${retention.signup_day_date};;
      relationship: many_to_one
    }
    join: derived_install_version_players {
      sql_on: ${events.player_id} = ${derived_install_version_players.user_id}
                and ${events.user_first_seen_date} = ${derived_install_version_players.user_first_seen_date};;
      relationship: many_to_many
    }
    join: created_at_max {
      sql_on: ${events.user_id} = ${created_at_max.user_id}
              ;;
      relationship: one_to_one
    }

    join: supported_devices {
      sql_on: ${events.device_model_number} = ${supported_devices.retail_model} ;;
      type: left_outer
      relationship: many_to_one
    }

    join: facebook_daily_export {
      sql_on: ${events.user_first_seen_date} = ${facebook_daily_export.date}
      AND ${events.country} = ${facebook_daily_export.country};;
      relationship: many_to_one
    }
}

explore: churned_players {}

explore: churned_players_aggregated {
  join: experiments_cohorted_players {
    sql_on: ${churned_players_aggregated.experiment_names} = ${experiments_cohorted_players.experiment_names}
      AND ${churned_players_aggregated.variants} = ${experiments_cohorted_players.variants}
      AND ${churned_players_aggregated.install_version} = ${experiments_cohorted_players.install_version};;
    relationship: one_to_one
  }

  join: cohorted_players {
    sql_on:  ${churned_players_aggregated.install_version} = ${cohorted_players.install_version};;
    relationship: one_to_one
  }
}

explore: non_churned_players_aggregated {}

explore: bingo_card_funnels {}

explore: experiments_cohorted_players {}

explore: cohorted_players {}

explore: skill_used {}

explore: derived_install_version_players {}

explore: supported_devices {}

explore: facebook_daily_export {}

###############

explore: sessions_per_player {}

# explore: z_churn_analysis_install_cohort {
#   description: "deprecated"
#   sql_always_where:
#     churn_analysis_install_cohort.created_at  >= TIMESTAMP('2020-07-06 00:00:00')
#     AND churn_analysis_install_cohort.user_type = "external";;
# }

explore: player_s_wallet {}

explore: created_at_max {}

explore: starts_ends_awake_ratios {}

explore: experiments_charts {}

explore: retention_cohort_dimensionalize_20days {}

explore: churn_per_of_previous {
  join: events {
    sql_on: ${churn_per_of_previous.events_experiment_names} = ${events.experiment_names}
          AND ${churn_per_of_previous.events_round_id} = ${events.round_id}
            ;;
    relationship: many_to_many
  }
}


explore: count_quests_attempts {
  description: "refactor"
}


explore: characters_collection_iii {
  description: "ok to deprecate"
  join: events {
    sql_on: ${characters_collection_iii.user_id} = ${events.user_id}
          AND ${characters_collection_iii.session_id} = ${events.session_id}
          AND ${characters_collection_iii.event_date} = ${events.event_date}
          AND ${characters_collection_iii.user_first_seen_date} = ${events.user_first_seen_date}
            ;;
    relationship: one_to_one
  }
}


explore: time_no_play {
  join: events {
    sql_on: ${time_no_play.user_id} = ${events.user_id}
            AND ${time_no_play.event_date} = ${events.event_date}
            ;;
    relationship: one_to_one
  }
}


explore: z_sessions {
  description: "ok to deprecate"
    join: events {
    sql_on: ${z_sessions.user_id} = ${events.user_id}
        AND ${z_sessions.event_date} = ${events.event_date}
        AND ${z_sessions.current_card} = ${events.current_card}
        ;;
    relationship: one_to_one
  }
}



explore: fue_funnel {
 sql_always_where:
 user_type = "external";;
}

explore: z_bingo_card_funnel {
  description: "ok to deprecate"
  sql_always_where:
   user_type = "external";;
}



##########GAMEPLAY EXPLORES##########


# COINS, XP & SCORE EARNED EXPLORE:

explore: _001_coins_xp_score {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type = "external"
  ;;
}


# SKILL USED EXPLORE:

explore: _002_skill_used {}


# CHAINS & MATCHES MADE EXPLORE:

explore: _003_chains_matches {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type = "external"
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
  AND user_type = "external"
  ;;
}


# BUBBLES EXPLORE:

explore: _005_bubbles {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type = "external"
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



# FEVER COUNT EXPLORE:

explore: _007_fever_count {
  sql_always_where: event_name = "round_end"
  AND JSON_EXTRACT(extra_json,"$.team_slot_0") IS NOT NULL
  AND user_type = "external"
  ;;
}


# FRAME COUNT HISTOGRAM VALUES:

explore: _008_frame_count_histogram {}


######PLAYER ANALYSIS######

explore: player_analysis_view {
   sql_always_where: user_type = "external"
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



######LOAD TIME######

explore: scene_load_time {
  sql_always_where: event_name = "transition"
  AND user_type = "external"
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
    AND user_type = "external";;
}


# week_start_day: sunday ## remove me
# explore: test_retention {}
# explore: firebase_events {
#   always_filter: {
#     filters: [current_period_filter: "1 days ago for 1 day"]
#   }
# }
# explore: user_fact {}
# explore: user_retention {
#   from: user_fact
#   join: user_activity {
#     type: left_outer
#     sql_on: ${user_retention.user_id} = ${user_activity.user_id} ;;
#     relationship: one_to_many
#   }
# }

explore: players_n_churn {}
