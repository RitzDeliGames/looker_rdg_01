
label: "1 Ritz Deli Games"
connection: "eraser_blast_gbq"

# include all the views
# include: "/views/**/*.view"
include: "/**/*.view"

# include all the dashboards
# include: "/dashboards/**/*.dashboard"

datagroup: default_datagroup {
  #sql_trigger: select floor((timestamp_diff(CURRENT_TIMESTAMP(),'2021-01-01 00:00:00',SECOND)) / (3*60*60)) ;;
  max_cache_age: "1 hour"
}

datagroup: change_3_hrs {
  # sql_trigger: select current_date() ;;
  # max_cache_age: "23 hours"
  sql_trigger: select floor((timestamp_diff(current_timestamp(),'2021-01-01 00:00:00',second)) / (3*60*60)) ;;
  max_cache_age: "2 hours"
}

datagroup: change_at_midnight {
  sql_trigger: select current_date() ;;
  max_cache_age: "23 hours"
}

explore: user_retention {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  label: "Users"
  from: user_fact
  join: user_activity {
    type: left_outer
    sql_on: ${user_retention.rdg_id} = ${user_activity.rdg_id} ;;
  relationship: one_to_many
  }
  join: user_activity_engagement_min {
    type: left_outer
    sql_on: ${user_retention.rdg_id} = ${user_activity_engagement_min.rdg_id} ;;
    relationship: one_to_many
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${user_retention.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
  join: android_device_helper {
    type: left_outer
    sql_on: ${user_last_event.device_model_number} = ${android_device_helper.retail_model} ;;
    relationship: many_to_one
  }
  join: facebook_daily_export {
    sql_on: ${user_retention.created_pst_date} = ${facebook_daily_export.date}
      and ${user_retention.country} = ${facebook_daily_export.country};;
    relationship: many_to_many
  }
  join: singular_daily_agg_export {
    view_label: "Singular Aggregated"
    sql_on: ${user_retention.created_pst_date} = ${singular_daily_agg_export.date}
      and ${user_retention.country} = ${singular_daily_agg_export.country}
      and ${singular_daily_agg_export.campaign_id} = ${singular_daily_user_attribution_export.campaign_id}
      and ${singular_daily_agg_export.date} = ${singular_daily_user_attribution_export.event_timestamp_date};;
    relationship: many_to_many
  }
  join: singular_daily_user_attribution_export {
    view_label: "Singular User Level"
    type: left_outer
    sql_on: ${user_retention.advertising_id} = ${singular_daily_user_attribution_export.device_id};;
    relationship: one_to_one
  }
  join: transactions_new {
    view_label: "Transactions"
    type: left_outer
    relationship: one_to_many
    # relationship: many_to_many
    # sql_on: ${user_retention.rdg_id} = ${transactions_new.rdg_id} ;;
    sql_on: ${user_retention.rdg_id} = ${transactions_new.rdg_id}
    and ${user_activity.activity_date} = ${transactions_new.transaction_date} --#TEMP: added to (try) build LTV curves
    and ${user_activity_engagement_min.engagement_min} = ${transactions_new.minutes_played};; #TEMP: added to (try) build LTV curves
  }
  join: community_events_activity {
    view_label: "Community Events"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.rdg_id} = ${community_events_activity.rdg_id} ;;
  }
  join: team_ups_activity {
    view_label: "Team Ups"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.rdg_id} = ${team_ups_activity.rdg_id} ;;
  }
  join: loading_times {
    view_label: "Scene Loading Times"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.rdg_id} = ${loading_times.rdg_id} ;;
  }
  join: click_stream {
    view_label: "Click Stream"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.rdg_id} = ${click_stream.rdg_id} ;;
  }
  join: fue_funnels {
    view_label: "FUE Funnel"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.rdg_id} = ${fue_funnels.rdg_id} ;;
  }
  # join: new_afh {
  #   view_label: "Ask for Help"
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${user_retention.rdg_id} = ${new_afh.rdg_id} ;;
  # }
  # join: id_helper_provider {
  #   from: id_helper
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${new_afh.providing_player_id} = ${id_helper_provider.user_id} ;;
  # }
  # join: id_helper_requestor {
  #   from: id_helper
  #   type: left_outer
  #   relationship: many_to_one
  #   sql_on: ${new_afh.requesting_player_id} = ${id_helper_requestor.user_id} ;;
  # }
}

explore: user_card_completion {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  label: "Card Completion (User)"
  from: user_card
  join: user_fact {
    type: left_outer
    sql_on: ${user_card_completion.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${user_card_completion.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
  join: transactions_new {
    view_label: "Transactions"
    type: left_outer
    relationship: one_to_many
    # relationship: many_to_many
    sql_on: ${user_card_completion.rdg_id} = ${transactions_new.rdg_id}
      and ${user_card_completion.current_card} = ${transactions_new.current_card};;
  }
  join: system_value_aggregated {
    view_label: "System Value"
    type: left_outer
    relationship: one_to_one
    sql_on: ${user_card_completion.rdg_id} = ${system_value_aggregated.rdg_id}
      and ${user_card_completion.current_card} = ${system_value_aggregated.current_card};;
  }
}

explore: system_value {
  hidden: no
}
explore: system_value_aggregated {
  hidden: yes
}

explore: transactions {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping} and ${rdg_id} not in @{purchase_exclusion_list};;
  from: transactions_new
  join: user_retention {
    from: user_fact
    type: left_outer
    sql_on: ${transactions.rdg_id} = ${user_retention.rdg_id} ;;
    relationship: many_to_one
    # relationship: many_to_many
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${transactions.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
  join: user_activity {
    type: left_outer
    sql_on: ${transactions.rdg_id} = ${user_activity.rdg_id}
    and ${transactions.transaction_date} = ${user_activity.activity_date};;
    relationship: many_to_many
  }
  join: user_activity_engagement_min {
    type: left_outer
    sql_on: ${transactions.rdg_id} = ${user_activity_engagement_min.rdg_id}
    and ${transactions.minutes_played} = ${user_activity_engagement_min.engagement_min};;
    relationship: many_to_many
  }
  # join: supported_devices {
  #   type: left_outer
  #   sql_on: ${transactions.device_model_number} = ${supported_devices.retail_model} ;;
  #   relationship: many_to_one
  # }
  join: facebook_daily_export {
    type: left_outer
    sql_on: ${transactions.created_pst_date} = ${facebook_daily_export.date};;
    relationship: many_to_many
  }
  join: singular_daily_agg_export {
    sql_on: ${transactions.created_pst_date} = ${singular_daily_agg_export.date};;
    relationship: many_to_many
  }
  join: singular_daily_user_attribution_export {
    type: left_outer
    sql_on: ${transactions.advertising_id} = ${singular_daily_user_attribution_export.device_id} ;;
    relationship: many_to_one
  }
}

explore: rewards {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping} and ${rdg_id} not in @{purchase_exclusion_list};;
  from: rewards
  join: user_fact {
    type: left_outer
    sql_on: ${rewards.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${rewards.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
}

# explore: economy {
#   sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping} and ${rdg_id} not in @{purchase_exclusion_list};;
#   from: rewards_bingo_cards_and_gameplay
#   join: user_fact {
#     type: left_outer
#     sql_on: ${economy.rdg_id} = ${user_fact.rdg_id} ;;
#     relationship: many_to_one
#   }
#   join: user_last_event {
#     type: left_outer
#     sql_on: ${economy.rdg_id} = ${user_last_event.rdg_id} ;;
#     relationship: one_to_one
#   }
  # always_filter: {
  #   filters: [economy.dimension_date: "7 days"]
  # }
  # from: date_dimension
  # join: rewards {
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${economy.dimension_date} = ${rewards.reward_date} ;;
  # }

  # join: transactions_new {
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${economy.dimension_date} = ${transactions_new.transaction_date} ;;
  # }
#}

explore: in_app_messages {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  from: new_iam
  join: user_fact {
    type: left_outer
    sql_on: ${in_app_messages.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${in_app_messages.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }

}

explore: click_stream {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  from: click_stream
  view_label: "Click Stream"
  join: user_fact {
    type: left_outer
    sql_on: ${click_stream.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${click_stream.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: many_to_one
  }
}

explore: ask_for_help {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  from: new_afh
  view_label: "Ask for Help"
  join: id_helper_requesting {
    from: id_helper
    type: left_outer
    relationship: many_to_one
    sql_on: ${ask_for_help.requesting_player_id} = ${id_helper_requesting.user_id} ;;
  }
  join: id_helper_providing {
    from: id_helper
    type: left_outer
    relationship: many_to_one
    sql_on: ${ask_for_help.providing_player_id} = ${id_helper_providing.user_id} ;;
  }
  join: user_fact_requesting {
    view_label: "Requesting Player"
    from: user_fact
    type: left_outer
    sql_on: ${id_helper_requesting.rdg_id} = ${user_fact_requesting.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_fact_providing {
    view_label: "Providing Player"
   from: user_fact
   type: left_outer
   sql_on: ${id_helper_providing.rdg_id} = ${user_fact_providing.rdg_id} ;;
   relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${ask_for_help.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
}

explore: community_events {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  from: community_events_activity
}

explore: ce_aggregated_scores {
  view_label: "Community Event Aggregated - TEMP"
  from: ce_aggregated_scores
}

explore: team_ups {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  from: team_ups_activity
  view_label: "Team Ups"
}

explore: fue_funnels {}

explore: temp_community_events_funnels {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  join: user_fact {
    type: left_outer
    sql_on: ${temp_community_events_funnels.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${temp_community_events_funnels.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
  # join: transactions_new {
  #   view_label: "Transactions"
  #   type: left_outer
  #   relationship: one_to_many
  #   sql_on: ${temp_community_events_funnels.rdg_id} = ${transactions_new.rdg_id}
  #     and ${community_events.card_id} = ${transactions_new.card_id}
  #  ;;
  #}
}

explore: churn_by_tile_by_attempt {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  always_filter: {
    filters: [churn_by_tile_by_attempt.node_selector: "0"]
  }
  view_label: "Churn"
  join: user_fact {
    type: left_outer
    sql_on: ${churn_by_tile_by_attempt.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${churn_by_tile_by_attempt.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: many_to_one
  }
}

explore: churn_by_card {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  from: churn_by_card_by_attempt
  view_label: "Churn"
  join: user_fact {
    type: left_outer
    sql_on: ${churn_by_card.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: one_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${churn_by_card.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
}

explore: gameplay {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  from: round_end
  join: user_fact {
    type: left_outer
    sql_on: ${gameplay.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${gameplay.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
  join: erasers {
    type: left_outer
    sql_on: ${gameplay.primary_team_slot} = ${erasers.character_id} ;;
    relationship: one_to_one
  }
  join: chain_length {
    view_label: "Gameplay"
    sql: left join unnest(json_extract_array(${gameplay.unnest_all_chains})) chain_length ;;
    relationship: one_to_many
  }
  join: sessions_per_day_per_player {
    view_label: "Gameplay"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${sessions_per_day_per_player.rdg_id}
      and ${gameplay.event_date} = ${sessions_per_day_per_player.event_date};;
    relationship: many_to_one ## let's test this
  }
  join: rounds_per_day_per_player {
    view_label: "Gameplay"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${rounds_per_day_per_player.rdg_id}
      and ${gameplay.event_date} = ${rounds_per_day_per_player.event_date};;
    relationship: many_to_one ## let's test this
  }
  join: rounds_per_session_per_player {
    view_label: "Gameplay"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${rounds_per_session_per_player.rdg_id}
      and ${gameplay.event_date} = ${rounds_per_session_per_player.event_date}
      and ${gameplay.session_id} = ${rounds_per_session_per_player.session_id};;
    relationship: many_to_one ## let's test this
  }
  # join: churn_card_data {
  #   view_label: "Churn"
  #   type: inner
  #   relationship: one_to_one
  #   sql_on:  ${gameplay.rdg_id} = ${churn_card_data.rdg_id}
  #     and ${gameplay.round_id} = ${churn_card_data.round_id}
  #     and ${gameplay.current_quest} = ${churn_card_data.current_quest};;
  # }
  join: gameplay_fact {
    type: left_outer
    relationship: one_to_one
    sql_on: ${gameplay.rdg_id} = ${gameplay_fact.rdg_id}
         and ${gameplay.round_id} = ${gameplay_fact.round_id}
         and ${gameplay.event_time} = ${gameplay_fact.event_time};;
  }
  join: new_afh {
    type: left_outer
    relationship: many_to_many
    sql_on: ${gameplay.rdg_id} = ${new_afh.rdg_id}
        and ${gameplay.event_time} = ${new_afh.event_time};;
  }
  join: id_helper_requesting {
    from: id_helper
    type: left_outer
    relationship: many_to_one
    sql_on: ${new_afh.requesting_player_id} = ${id_helper_requesting.user_id} ;;
  }
  join: id_helper_providing {
    from: id_helper
    type: left_outer
    relationship: many_to_one
    sql_on: ${new_afh.providing_player_id} = ${id_helper_providing.user_id} ;;
  }
  join: user_fact_requesting {
    view_label: "Requesting Player"
    from: user_fact
    type: left_outer
    sql_on: ${id_helper_requesting.rdg_id} = ${user_fact_requesting.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_fact_providing {
    view_label: "Providing Player"
    from: user_fact
    type: left_outer
    sql_on: ${id_helper_providing.rdg_id} = ${user_fact_providing.rdg_id} ;;
    relationship: many_to_one
  }
  join: gameplay_explore_mixed_fields {}
  # join: round_start {
  #   view_label: "Round Start"
  #   type: left_outer
  #   sql_on: ${gameplay.rdg_id} = ${round_start.rdg_id}
  #     and ${gameplay.round_id} = ${round_start.round_id} ;;
  #   relationship: one_to_one
  # }
}

explore: round_start {
  hidden: yes
  join: round_end {
  type: left_outer
  relationship: one_to_one
  sql_on: ${round_start.rdg_id} = ${round_end.rdg_id}
    and ${round_start.round_id} = ${round_end.round_id};;
  }
}

explore: temp_fps {
  hidden: yes
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  view_label: "temp fps"
  join: user_fact {
    type: left_outer
    sql_on: ${temp_fps.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
}

explore: events {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  view_label: " Card Data" ## space to bring to top of Explore
  label: "Card Event"
  join: cards {
    type: left_outer
    sql_on:
      ${events.timestamp_time} = ${cards.timestamp}
      and ${events.event_name} = ${cards.event_name}
      and ${events.rdg_id} = ${cards.rdg_id}
    ;;
    relationship: one_to_one
  }
  join: node_data {
    view_label: "Cards" ## to keep within cards grouping
    sql: left outer join unnest(${cards.node_data}) as node_data ;;
    relationship: one_to_many
  }
  join: user_fact {
    type: left_outer
    sql_on: ${events.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${user_fact.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
  join: android_device_helper {
    sql_on: ${events.device_model_number} = ${android_device_helper.retail_model} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: churn_card_data {
  from: churn_card_data
  always_filter: {
    filters: [churn_card_data.node_selector: "0", churn_card_data.node_is_selected: "yes"]
  }
  sql_always_where: ${churn_card_data.rdg_id} not in @{device_internal_tester_mapping};;
  #view_label: "temp churn by tile"
  join: user_fact {
    type: left_outer
    sql_on: ${churn_card_data.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${churn_card_data.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: many_to_one
  }
  join: gameplay_fact {
    type: left_outer
    relationship: one_to_one
    sql_on: ${churn_card_data.rdg_id} = ${gameplay_fact.rdg_id}
      and ${churn_card_data.round_id} = ${gameplay_fact.round_id};;
  }
}

explore: id_helper {}

explore: gameplay_fact {}

explore: click_sequence {
  view_label: "First in Sequence"
  description: "Identifies the common paths players take after triggering an event "
  join: next_in_sequence {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${click_sequence.click_sequence_num} <= ${next_in_sequence.click_sequence_num}
        and ${click_sequence.rdg_id} = ${next_in_sequence.rdg_id} ;;
  }
  join: step_2 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${click_sequence.click_sequence_num} + 1 = ${step_2.click_sequence_num}
    and ${click_sequence.rdg_id} = ${step_2.rdg_id};;
  }
  join: step_3 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_2.click_sequence_num} + 1 = ${step_3.click_sequence_num}
      and ${step_2.rdg_id} = ${step_3.rdg_id};;
  }
  join: step_4 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_3.click_sequence_num} + 1 = ${step_4.click_sequence_num}
      and ${step_3.rdg_id} = ${step_4.rdg_id};;
  }
  join: step_5 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_4.click_sequence_num} + 1 = ${step_5.click_sequence_num}
      and ${step_4.rdg_id} = ${step_5.rdg_id};;
  }
  join: step_6 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_5.click_sequence_num} + 1 = ${step_6.click_sequence_num}
      and ${step_5.rdg_id} = ${step_6.rdg_id};;
  }
  join: step_7 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_6.click_sequence_num} + 1 = ${step_7.click_sequence_num}
      and ${step_6.rdg_id} = ${step_7.rdg_id};;
  }
  join: step_8 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_7.click_sequence_num} + 1 = ${step_8.click_sequence_num}
      and ${step_7.rdg_id} = ${step_8.rdg_id};;
  }
  join: step_9 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_8.click_sequence_num} + 1 = ${step_9.click_sequence_num}
      and ${step_8.rdg_id} = ${step_9.rdg_id};;
  }
  join: step_10 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_9.click_sequence_num} + 1 = ${step_10.click_sequence_num}
      and ${step_9.rdg_id} = ${step_10.rdg_id};;
  }
  join: step_11 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_10.click_sequence_num} + 1 = ${step_11.click_sequence_num}
      and ${step_10.rdg_id} = ${step_11.rdg_id};;
  }
  join: step_12 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_11.click_sequence_num} + 1 = ${step_12.click_sequence_num}
      and ${step_11.rdg_id} = ${step_12.rdg_id};;
  }
  join: step_13 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_12.click_sequence_num} + 1 = ${step_13.click_sequence_num}
      and ${step_12.rdg_id} = ${step_13.rdg_id};;
  }
  join: step_14 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_13.click_sequence_num} + 1 = ${step_14.click_sequence_num}
      and ${step_13.rdg_id} = ${step_14.rdg_id};;
  }
  join: step_15 {
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_14.click_sequence_num} + 1 = ${step_15.click_sequence_num}
      and ${step_14.rdg_id} = ${step_15.rdg_id};;
  }
  join: click_sequence_joined_fields {
    relationship: one_to_one
    sql:  ;;
  }
}

explore: cohort_analysis {
  fields: [
    cohort_analysis*,
    transactions_new.transaction_date,
    transactions_new.days_since_created,
    transactions_new.weeks_since_created,
    transactions_new.minutes_played,
    transactions_new.rdg_id,
    transactions_new.transaction_count,
    transactions_new.iap_id,
    transactions_new.iap_purchase_item,
    transactions_new.currency_spent,
    transactions_new.currency_spent_amount,
    cohort_analysis_mixed_fields*,
    -cohort_analysis.days_between_first_and_last_event,
    -cohort_analysis.days_since_last_event
    ]
  from: user_fact
  join: transactions_new {
    type: left_outer
    relationship: many_to_many
    sql_on: ${cohort_analysis.created_date} = ${transactions_new.created_date} ;;
  }
  join: cohort_analysis_mixed_fields {
    view_label: "Currencies"
  }
}
