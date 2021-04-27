label: "1 Ritz Deli Games"
connection: "eraser_blast_gbq"

# include all the views
# include: "/views/**/*.view"
include: "/**/*.view"

# include all the dashboards
# include: "/dashboards/**/*.dashboard"

datagroup: default_datagroup {
  max_cache_age: "1 hour"
}

datagroup: change_at_midnight {
  sql_trigger: select current_date() ;;
  max_cache_age: "23 hours"
}

explore: user_retention {
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
  # join: transactions_new {
  #   type: left_outer
  #   sql_on: ${user_retention.user_id} = ${transactions_new.rdg_id} ;;
  #   relationship: many_to_one
  # }
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
}

explore: user_card_completion {
  from: user_card
  join: user_fact {
    type: left_outer
    sql_on: ${user_card_completion.rdg_id} = ${user_fact.user_id} ;;
    relationship: many_to_one
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
}
