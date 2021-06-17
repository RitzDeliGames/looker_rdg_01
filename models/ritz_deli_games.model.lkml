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
  label: "Users"
  from: user_fact
  join: user_activity {
    type: left_outer
    sql_on: ${user_retention.user_id} = ${user_activity.user_id} ;;
    relationship: one_to_many
  }
  join: user_activity_engagement_min {
    type: left_outer
    sql_on: ${user_retention.user_id} = ${user_activity_engagement_min.user_id} ;;
    relationship: one_to_many
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${user_retention.user_id} = ${user_last_event.user_id} ;;
    relationship: one_to_one
  }
  join: supported_devices {
    type: left_outer
    sql_on: ${user_last_event.device_model_number} = ${supported_devices.retail_model} ;;
    relationship: many_to_one
  }
  join: facebook_daily_export {
    sql_on: ${user_retention.created_pst_date} = ${facebook_daily_export.date}
      AND ${user_retention.country} = ${facebook_daily_export.country};;
    relationship: many_to_many
  }
  join: transactions_new {
    view_label: "Transactions"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.user_id} = ${transactions_new.rdg_id} ;;
  }
}

explore: user_card_completion {
  from: user_card
  join: user_fact {
    type: left_outer
    sql_on: ${user_card_completion.rdg_id} = ${user_fact.user_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${user_card_completion.rdg_id} = ${user_last_event.user_id} ;;
    relationship: one_to_one
  }
  join: transactions_new {
    view_label: "Transactions"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_card_completion.rdg_id} = ${transactions_new.rdg_id}
      and ${user_card_completion.card_id} = ${transactions_new.card_id}
    ;;
  }
}

explore: transactions {
  from: transactions_new
  join: user_fact {
    type: left_outer
    sql_on: ${transactions.rdg_id} = ${user_fact.user_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${transactions.rdg_id} = ${user_last_event.user_id} ;;
    relationship: one_to_one
  }
  join: supported_devices {
    type: left_outer
    sql_on: ${transactions.device_model_number} = ${supported_devices.retail_model} ;;
    relationship: many_to_one
  }
  join: facebook_daily_export {
    type: left_outer
    sql_on: ${transactions.created_pst_date} = ${facebook_daily_export.date};;
    relationship: many_to_many
  }
}

explore: economy {
  from: rewards_bingo_cards_and_gameplay
  join: user_fact {
    type: left_outer
    sql_on: ${economy.rdg_id} = ${user_fact.user_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${economy.rdg_id} = ${user_last_event.user_id} ;;
    relationship: one_to_one
  }
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
}

explore: in_app_messages {
  from: new_iam
}

explore: ask_for_help {
  from: new_afh
}

explore: churn {
  from: temp_churn_by_tile_by_attempt
  view_label: "temp churn by tile"
  join: user_fact {
    type: left_outer
    sql_on: ${churn.rdg_id} = ${user_fact.user_id} ;;
    relationship: one_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${churn.rdg_id} = ${user_last_event.user_id} ;;
    relationship: one_to_one
  }
}

explore: churn_by_card {
  from: temp_churn_by_card_by_attempt
  view_label: "temp churn by card"
  join: user_fact {
    type: left_outer
    sql_on: ${churn_by_card.rdg_id} = ${user_fact.user_id} ;;
    relationship: one_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${churn_by_card.rdg_id} = ${user_last_event.user_id} ;;
    relationship: one_to_one
  }
}

explore: gameplay {
  from: round_end
  join: user_fact {
    type: left_outer
    sql_on: ${gameplay.rdg_id} = ${user_fact.user_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${gameplay.rdg_id} = ${user_last_event.user_id} ;;
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
  join: rounds_per_day_per_player {
    view_label: "Gameplay"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${rounds_per_day_per_player.user_id}
      and ${gameplay.event_date} = ${rounds_per_day_per_player.event_date};;
    relationship: many_to_one ## let's test this
  }
  join: rounds_per_session_per_player {
    view_label: "Gameplay"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${rounds_per_session_per_player.user_id}
      and ${gameplay.event_date} = ${rounds_per_session_per_player.event_date}
      and ${gameplay.session_id} = ${rounds_per_session_per_player.session_id};;
    relationship: many_to_one ## let's test this
  }
}

explore: events {
  view_label: " Events" ## space to bring to top of Explore
  join: supported_devices {
    sql_on: ${events.device_model_number} = ${supported_devices.retail_model} ;;
    type: left_outer
    relationship: many_to_one
  }
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
    sql_on: ${events.rdg_id} = ${user_fact.user_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${user_fact.user_id} = ${user_last_event.user_id} ;;
    relationship: one_to_one
  }
}
