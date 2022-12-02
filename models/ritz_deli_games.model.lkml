
label: "Eraser Blast"
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

datagroup: change_6_hrs {
  # sql_trigger: select current_date() ;;
  # max_cache_age: "23 hours"
  sql_trigger: select floor((timestamp_diff(current_timestamp(),'2021-01-01 00:00:00',second)) / (6*60*60)) ;;
  max_cache_age: "5 hours"
}

datagroup: change_8_hrs {
  # sql_trigger: select current_date() ;;
  # max_cache_age: "23 hours"
  sql_trigger: select floor((timestamp_diff(current_timestamp(),'2021-01-01 00:00:00',second)) / (8*60*60)) ;;
  max_cache_age: "7 hours"
}

datagroup: change_at_midnight {
  sql_trigger: select current_date() ;;
  max_cache_age: "23 hours"
}

explore: user_retention {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping} and ${rdg_id} not in @{purchase_exclusion_list} ;;
  label: "Users"
  from: user_fact
  join: user_activity {
    view_label: "User Activity - Days"
    type: left_outer
    sql_on: ${user_retention.rdg_id} = ${user_activity.rdg_id} ;;
  relationship: one_to_many
  }
  join: user_activity_engagement_min {
    view_label: "User Activity - Minutes"
    type: left_outer
    sql_on: ${user_retention.rdg_id} = ${user_activity_engagement_min.rdg_id} ;;
    relationship: one_to_many
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${user_retention.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
  join: singular_daily_agg_export {
    view_label: "Singular Aggregated"
    sql_on: ${user_retention.created_pst_date} = ${singular_daily_agg_export.date}
      and ${user_retention.country} = ${singular_daily_agg_export.country}
      and ${singular_daily_agg_export.campaign_id} = ${singular_daily_user_attribution_export.campaign_id}
      and ${singular_daily_agg_export.date} = ${singular_daily_user_attribution_export.event_timestamp_date};;
    relationship: many_to_many
  }
  join: android_advertising_id_helper {
    view_label: "Singular User Level w/Firebase Helper"
    type: left_outer
    sql_on: ${user_retention.user_id} = ${android_advertising_id_helper.user_id};;
    relationship: one_to_one
  }
  join: singular_daily_user_attribution_export {
    view_label: "Singular User Level"
    type: left_outer
    sql_on: ${singular_daily_user_attribution_export.device_id} = ${android_advertising_id_helper.advertising_id};;
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
      and ${user_activity_engagement_min.engagement_ticks} = ${transactions_new.engagement_ticks};;
  }
  join: loading_times {
    view_label: "Scene Loading Times"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.rdg_id} = ${loading_times.rdg_id} ;;
  }
  join: performance_score {
    view_label: "Performance Score"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.rdg_id} = ${performance_score.rdg_id} ;;
  }
  join: system_info {
    view_label: "System Info"
    type: left_outer
    relationship: one_to_one
    sql_on: ${user_retention.rdg_id} = ${system_info.rdg_id} ;;
  }
  join: click_stream {
    view_label: "Click Stream"
    type: left_outer
    relationship: one_to_many
    sql_on: ${user_retention.rdg_id} = ${click_stream.rdg_id} ;;
  }
  join: firebase_analytics {
    view_label: "Users - Firebase Analytics"
    type: full_outer
    relationship: many_to_many
    sql_on: ${user_retention.user_id} = ${firebase_analytics.user_id};;
  }
  join: user_activity_firebase {
    view_label: "User Activity - Firebase Analytics"
    type: left_outer
    sql_on: ${user_retention.user_id} = ${user_activity_firebase.user_id} ;;
    relationship: one_to_many
  }
  join: display_name_helper {
    type: left_outer
    sql_on: ${user_retention.rdg_id} = ${display_name_helper.rdg_id} ;;
    relationship: one_to_one
  }
}

explore: transactions {
  sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping} and ${rdg_id} not in @{purchase_exclusion_list} and ${transaction_date} >= ${created_date};;
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
    and ${transactions.engagement_ticks} = ${user_activity_engagement_min.engagement_ticks};;
    relationship: many_to_many
  }
  join: android_advertising_id_helper {
    view_label: "Singular User Level w/Firebase Helper"
    type: left_outer
    sql_on: ${user_retention.user_id} = ${android_advertising_id_helper.user_id};;
    relationship: one_to_one
  }
  join: singular_daily_agg_export {
    sql_on: ${transactions.created_pst_date} = ${singular_daily_agg_export.date};;
    relationship: many_to_many
  }
  join: singular_daily_user_attribution_export {
    view_label: "Singular User Level"
    type: left_outer
    sql_on: ${singular_daily_user_attribution_export.device_id} = ${android_advertising_id_helper.advertising_id};;
    relationship: one_to_one
  }
  join: display_name_helper {
    type: left_outer
    sql_on: ${transactions.rdg_id} = ${display_name_helper.rdg_id} ;;
    relationship: many_to_one
  }
}

explore: rewards {
  sql_always_where: ${reward_date} >= ${user_fact.created_date};;# and ${rdg_id} not in @{device_internal_tester_mapping} and ${rdg_id} not in @{purchase_exclusion_list} ;;
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

explore: in_app_messages {
  #sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
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
  #sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
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

explore: churn_by_level_by_attempt {
  #sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  view_label: "Churn by Level - Attempt"
  join: user_fact {
    type: left_outer
    sql_on: ${churn_by_level_by_attempt.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: one_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${churn_by_level_by_attempt.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
}

explore: churn_by_level_by_proximity {
 # sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  view_label: "Churn by Level - Proximity"
  join: user_fact {
    type: left_outer
    sql_on: ${churn_by_level_by_proximity.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: one_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${churn_by_level_by_proximity.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
}

explore: churn_by_level_derived {
   view_label: "Churn by Level (Derived) - Attempt"
}

explore: churn_by_match_made {
  label: "Match Made"
  hidden: yes
}

explore: churn_by_match_data {
  label: "Churn by Matches Made"
  #sql_always_where: ${churn_by_match_data.rdg_id} not in @{device_internal_tester_mapping};;
  #view_label: "temp churn by tile"
  join: user_fact {
    type: left_outer
    sql_on: ${churn_by_match_data.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${churn_by_match_data.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: many_to_one
  }
}

explore: gameplay {
  sql_always_where: ${event_date} >= ${user_fact.created_date};;#${rdg_id} not in @{device_internal_tester_mapping} and
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
  join: attempts_per_level {
    view_label: "Gameplay"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${attempts_per_level.rdg_id}
      and ${gameplay.last_level_id} = ${attempts_per_level.last_level_id};;
    relationship: many_to_one ## let's test this
  }
  join: sessions_per_day_per_player {
    view_label: "Gameplay - Sessions"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${sessions_per_day_per_player.rdg_id}
      and ${gameplay.event_date} = ${sessions_per_day_per_player.event_date};;
    relationship: many_to_one ## let's test this
  }
  join: rounds_per_day_per_player {
    view_label: "Gameplay - Rounds"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${rounds_per_day_per_player.rdg_id}
      and ${gameplay.event_date} = ${rounds_per_day_per_player.event_date};;
    relationship: many_to_one ## let's test this
  }
  join: rounds_per_session_per_player {
    view_label: "Gameplay - Sessions"
    type: left_outer
    sql_on: ${gameplay.rdg_id} =  ${rounds_per_session_per_player.rdg_id}
      and ${gameplay.event_date} = ${rounds_per_session_per_player.event_date}
      and ${gameplay.session_id} = ${rounds_per_session_per_player.session_id};;
    relationship: many_to_one ## let's test this
  }
  join: gameplay_fact {
    type: left_outer
    relationship: one_to_one
    sql_on: ${gameplay.rdg_id} = ${gameplay_fact.rdg_id}
     and ${gameplay.round_id} = ${gameplay_fact.round_id}
     and ${gameplay.event_time} = ${gameplay_fact.event_time};;
  }
  join: transactions_new {
    view_label: "Transactions"
    type: full_outer
    relationship: many_to_many
    sql_on: ${gameplay.rdg_id} = ${transactions_new.rdg_id}
      and ${gameplay.last_level_serial} = ${transactions_new.last_level_serial};;
  }
}

explore: fps {
  #sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
  label: "Frame Rate"
  view_label: "Frame Rate"
  join: user_fact {
    type: left_outer
    sql_on: ${fps.rdg_id} = ${user_fact.rdg_id} ;;
    relationship: many_to_one
  }
  join: user_last_event {
    type: left_outer
    sql_on: ${fps.rdg_id} = ${user_last_event.rdg_id} ;;
    relationship: one_to_one
  }
  join: performance_score {
    type: left_outer
    sql_on: ${fps.rdg_id} = ${performance_score.rdg_id} ;;
    relationship: many_to_one
  }
  join: system_info {
    type: left_outer
    sql_on: ${fps.rdg_id} = ${system_info.rdg_id} ;;
    relationship: many_to_one
  }
}

explore: weighted_fps {}

explore: gameplay_fact {}

explore: click_sequence {
  #sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping};;
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
    view_label: "Step 02"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${click_sequence.click_sequence_num} + 1 = ${step_2.click_sequence_num}
    and ${click_sequence.rdg_id} = ${step_2.rdg_id};;
  }
  join: step_3 {
    view_label: "Step 03"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_2.click_sequence_num} + 1 = ${step_3.click_sequence_num}
      and ${step_2.rdg_id} = ${step_3.rdg_id};;
  }
  join: step_4 {
    view_label: "Step 04"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_3.click_sequence_num} + 1 = ${step_4.click_sequence_num}
      and ${step_3.rdg_id} = ${step_4.rdg_id};;
  }
  join: step_5 {
    view_label: "Step 05"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_4.click_sequence_num} + 1 = ${step_5.click_sequence_num}
      and ${step_4.rdg_id} = ${step_5.rdg_id};;
  }
  join: step_6 {
    view_label: "Step 06"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_5.click_sequence_num} + 1 = ${step_6.click_sequence_num}
      and ${step_5.rdg_id} = ${step_6.rdg_id};;
  }
  join: step_7 {
    view_label: "Step 07"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_6.click_sequence_num} + 1 = ${step_7.click_sequence_num}
      and ${step_6.rdg_id} = ${step_7.rdg_id};;
  }
  join: step_8 {
    view_label: "Step 08"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_7.click_sequence_num} + 1 = ${step_8.click_sequence_num}
      and ${step_7.rdg_id} = ${step_8.rdg_id};;
  }
  join: step_9 {
    view_label: "Step 09"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_8.click_sequence_num} + 1 = ${step_9.click_sequence_num}
      and ${step_8.rdg_id} = ${step_9.rdg_id};;
  }
  join: step_10 {
    view_label: "Step 10"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_9.click_sequence_num} + 1 = ${step_10.click_sequence_num}
      and ${step_9.rdg_id} = ${step_10.rdg_id};;
  }
  join: step_11 {
    view_label: "Step 11"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_10.click_sequence_num} + 1 = ${step_11.click_sequence_num}
      and ${step_10.rdg_id} = ${step_11.rdg_id};;
  }
  join: step_12 {
    view_label: "Step 12"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_11.click_sequence_num} + 1 = ${step_12.click_sequence_num}
      and ${step_11.rdg_id} = ${step_12.rdg_id};;
  }
  join: step_13 {
    view_label: "Step 13"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_12.click_sequence_num} + 1 = ${step_13.click_sequence_num}
      and ${step_12.rdg_id} = ${step_13.rdg_id};;
  }
  join: step_14 {
    view_label: "Step 14"
    from: click_sequencing
    type: left_outer
    relationship: one_to_one
    sql_on: ${step_13.click_sequence_num} + 1 = ${step_14.click_sequence_num}
      and ${step_13.rdg_id} = ${step_14.rdg_id};;
  }
  join: step_15 {
    view_label: "Step 15"
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
  #sql_always_where: ${rdg_id} not in @{device_internal_tester_mapping} ;;
  from: cohort_selection
  join: transactions_new {
    type: left_outer
    relationship: many_to_many
    sql_on: ${cohort_analysis.first_created_date} = ${transactions_new.created_date}
        and ${cohort_analysis.rdg_id} = ${transactions_new.rdg_id}
       -- and ${transactions_new.transaction_date} >= ${cohort_analysis.first_created_date}
      ;;
  }
  join: cohort_analysis_mixed_fields {
    view_label: "Currencies"
  }
  join: user_last_event {
    view_label: "User Last Event"
    type: left_outer
    relationship: one_to_one
    sql_on: ${cohort_analysis.rdg_id} = ${user_last_event.rdg_id} ;;
  }
  join: user_activity_engagement_min {
    view_label: "User Activity - Engagement Ticks"
    type: left_outer
    relationship: many_to_many
    sql_on: ${cohort_analysis.rdg_id} = ${user_activity_engagement_min.rdg_id} ;;
  }
  join: sessions_per_day_per_player {
    type: left_outer
    relationship: many_to_many
    sql_on: ${cohort_analysis.first_created_date} = ${sessions_per_day_per_player.created_date}
        and ${cohort_analysis.rdg_id} = ${sessions_per_day_per_player.rdg_id};;
  }
  join: rounds_per_day_per_player {
    type: left_outer
    relationship: many_to_many
    sql_on: ${cohort_analysis.first_created_date} = ${rounds_per_day_per_player.created_date} ;;
  }

}

explore: cohort_selection {
  hidden: yes
}

### FIREBASE REPORTING - DAU, DAY 1 RETENTION ###

explore: firebase_analytics {
  always_filter: {
    filters: [firebase_analytics.date_filter: "7 days"]
  }
}

# EXPLORES ADDED FOR VIEWING INCLUDED DATA

explore: sessions_per_day_per_player {}

explore: android_advertising_id_helper {
  label: "Temp Android Advertising ID Helper"
}
