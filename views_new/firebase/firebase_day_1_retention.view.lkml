### PURPOSE ###
# To compare user activity 1 day ahead of their current activity to determine user retention
# This table uses the firebase_analytics explore to find events one day following the chosen
# date

view: firebase_day_1_retention {
  derived_table: {
    explore_source: firebase_analytics {
      column: user_pseudo_id {}
      column: user_id {}
      column: event {field: firebase_analytics.event_date}
      # Binding filters to require derived table to perform the same filtering as the explore source
      # This makes sure we are comparing dates without needing to query all partitioned tables
      bind_filters: {
        from_field: firebase_analytics.date_filter
        to_field: firebase_analytics.date_filter
      }
    }
  }

  ### DIMENSIONS ##

  dimension_group: event {
    description: "The time that a retention event occurred"
    type: time
  }

  dimension: user_id {
    description: "ID that maps to the User ID in Eraser Blast"
  }

  dimension: user_pseudo_id {
    description: "ID that Firebase uses to uniquely identify a user"
  }

  ### MEASURES ###

  measure: user_id_retention {
    description: "Total Retained User IDs / Total User IDs"
    type: number
    sql:
    ${firebase_day_1_retention.total_retained_user_ids} / nullif((${firebase_analytics.total_user_ids}*1),0) ;;
    value_format_name: percent_1
  }

  measure: firebase_user_retention {
    description: "Total Retained Firebase Users / Total Firebase Users"
    type: number
    sql: ${firebase_day_1_retention.total_retained_firebase_users} / nullif((${firebase_analytics.total_firebase_users}*1),0) ;;
    value_format_name: percent_1
  }

  measure: total_retained_user_ids {
    description: "Distinct count of User_IDs that are present in the current filtered date range one day later"
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: total_retained_firebase_users {
    description: "Distinct count of User Pseudo IDs that are present in the current filtered date range one day later"
    type: count_distinct
    sql: ${user_pseudo_id} ;;
  }
}
