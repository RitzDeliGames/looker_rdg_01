connection: "eraser_blast_gbq"

# include all the views
include: "/views/**/*.view"

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
  join: user_last_event {
    type: left_outer
    sql_on: ${user_retention.user_id} = ${user_last_event.user_id} ;;
    relationship: one_to_one
  }
}

explore: events {
  # join: supported {}
}
