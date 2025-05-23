
label: "Chum Chum Blast"
connection: "chum_chum_blast_prod"

######################################################################

## Include all views

######################################################################

include: "/**/*.view"

######################################################################

## Explore: Click Sequence

######################################################################

explore: click_stream {
  from: click_stream
  view_label: "Click Stream"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${click_stream.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${click_stream.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

}

explore: click_sequence {
  view_label: "First in Sequence"
  description: "Identifies the common paths players take after triggering an event "
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${click_sequence.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${click_sequence.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
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

################################################################

## Explore: Player Daily Summary

################################################################

explore: player_daily_summary {
  label: "Player Daily Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_daily_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_daily_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

  join: version_summary {
    view_label:  "Version Summary"
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_daily_summary.version} = ${version_summary.version};;
  }

  join: live_ops_calendar {
    view_label: "Live Ops Calendar"
    from:  live_ops_calendar
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_daily_summary.rdg_date_date} = ${live_ops_calendar.rdg_date_date};;

  }

}

################################################################

## Explore: Player Summary

################################################################


explore: player_summary_new {
  label: "Player Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_summary_new.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_bucket_by_first_10_levels {
    view_label: "Level 10 Moves Made Buckets"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_summary_new.rdg_id} = ${player_bucket_by_first_10_levels.rdg_id}
      ;;
  }

  join: version_summary_at_install {
    view_label:  "Version Summary At Install"
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_summary_new.version_at_install} = ${version_summary_at_install.version};;
  }
  join: version_summary_d2 {
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_summary_new.version_d2} = ${version_summary_d2.version};;
  }
  join: version_summary_d7 {
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_summary_new.version_d7} = ${version_summary_d7.version};;
  }
  join: version_summary_d14 {
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_summary_new.version_d14} = ${version_summary_d14.version};;
  }
  join: version_summary_d30 {
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_summary_new.version_d30} = ${version_summary_d30.version};;
  }
  join: version_summary_d60 {
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_summary_new.version_d60} = ${version_summary_d60.version};;
  }
  join: version_summary_current {
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_summary_new.version_current} = ${version_summary_current.version};;
  }

}

################################################################

## Explore: Player Round Summary

################################################################

explore: player_round_summary {
  label: "Player Round Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_round_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_round_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

  join: player_bucket_by_first_10_levels {
    view_label: "Level 10 Moves Made Buckets"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_round_summary.rdg_id} = ${player_bucket_by_first_10_levels.rdg_id}
      ;;
  }

}

################################################################

## Explore: Player Campaign Level Summary

################################################################

explore: player_campaign_level_summary {
  label: "Player Campaign Level Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_campaign_level_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_campaign_level_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

}


################################################################

## Explore: Player Mechanics Summary

################################################################

explore: player_mechanics_summary {
  label: "Player Mechanics Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_mechanics_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_mechanics_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

}

################################################################

## Explore: Player Puzzle Level Summary

################################################################

explore: player_puzzle_level_summary {
  label: "Player Puzzle Level Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_puzzle_level_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_puzzle_level_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

}

################################################################

## Explore: Player Ad View Summary

################################################################

explore: player_ad_view_summary {
  label: "Player Ad View Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_ad_view_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_ad_view_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

  join: live_ops_calendar {
    view_label: "Live Ops Calendar"
    from:  live_ops_calendar
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_ad_view_summary.rdg_date_date} = ${live_ops_calendar.rdg_date_date};;
  }

}

################################################################

## Explore: Player Mtx Summary

################################################################

explore: player_mtx_purchase_summary {
  label: "Player Mtx Purchase Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_mtx_purchase_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_mtx_purchase_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Coin Spend Summary

################################################################

explore: player_coin_spend_summary {
  label: "Player Coin Spend Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_coin_spend_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_coin_spend_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Hourly

################################################################

explore: player_hourly {
  label: "Player Hourly"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_hourly.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_hourly.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Weekly Summary

################################################################

explore: player_weekly_summary {
  label: "Player Weekly Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_weekly_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_weekly_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Monthly Summary

################################################################

explore: player_monthly_summary {
  label: "Player Monthly Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_monthly_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_monthly_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Recent Frame Rate

################################################################

explore: player_recent_frame_rate {
  label: "Player Recent Frame Rate"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_recent_frame_rate.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_recent_frame_rate.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Recent Button Clicks

################################################################

explore: player_recent_button_clicks {
  label: "Player Recent Button Clicks"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_recent_button_clicks.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_recent_button_clicks.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}


################################################################

## Explore: Player Recent Full Data

################################################################

explore: player_recent_full_event_data {
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_recent_full_event_data.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_recent_full_event_data.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player IAM Incremental

################################################################

explore: player_popup_and_iam_summary {

  label: "Player Popup and IAM Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_popup_and_iam_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_popup_and_iam_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Coin Source Summary

################################################################

explore: player_coin_source_summary {
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_coin_source_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_coin_source_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Profiler Event Recent

################################################################

explore: player_profiler_event_recent {
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_profiler_event_recent.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_profiler_event_recent.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}



################################################################

## Explore: Player Hitch Summary

################################################################

explore: player_hitch_summary {
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_hitch_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_hitch_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Battle Pass Summary

################################################################

explore: player_battle_pass_summary {
  label: "Player Battle Pass Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_battle_pass_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_battle_pass_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Error Summary

################################################################

explore: player_error_summary {
  label: "Player Error Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_error_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_error_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: player_error_by_dau {
  label: "Player Errors by DAU"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_error_by_dau.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_error_by_dau.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player FUE Summary

################################################################

explore: player_fue_summary {
  label: "Player FUE Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_fue_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_fue_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Notification Summary

################################################################

explore: player_notification_summary {
  label: "Player Notification Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_notification_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_notification_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Reward Summary

################################################################

explore: player_reward_summary {
  label: "Player Reward Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_reward_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_reward_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Coin Efficiency

################################################################

explore: player_coin_efficiency_by_game_mode {
  label: "Player Coin Efficiency"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_coin_efficiency_by_game_mode.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_coin_efficiency_by_game_mode.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}


################################################################

## Explore: Player Ticket Spend Summary

################################################################

explore: player_ticket_spend_summary {
  label: "Player Ticket Spend Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_ticket_spend_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_ticket_spend_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Tickets and Ad Views Summary

################################################################

explore: player_tickets_plus_ads_summary {
  label: "Player Ticket and Ad Views Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_tickets_plus_ads_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_tickets_plus_ads_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Frame Rate Summary

################################################################

explore: player_frame_rate_summary {
  label: "Player Frame Rate Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_frame_rate_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_frame_rate_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Moves Master Recap Summary

################################################################

explore: moves_master_recap_summary {
  label: "Moves Master Recap Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${moves_master_recap_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${moves_master_recap_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Game Mode Event Summary

################################################################

explore: game_mode_event_summary {
  label: "Game Mode Event Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${game_mode_event_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${game_mode_event_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Simple Event Summaries

################################################################

explore: player_simple_event_summary_hotdog {
  group_label: "Chum Chum Simple Event Summaries"
  label: "Hot Dog Simple Event Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_simple_event_summary_hotdog.rdg_id} = ${player_block_list.rdg_id} ;;
  }

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_simple_event_summary_hotdog.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: player_simple_event_summary_flourfrenzy {
  group_label: "Chum Chum Simple Event Summaries"
  label: "Flour Frenzy Simple Event Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_simple_event_summary_flourfrenzy.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_simple_event_summary_flourfrenzy.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Go Fish Event

################################################################

explore: player_go_fish_summary {
  label: "Player Go Fish Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_go_fish_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_go_fish_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Social Button Clicks Summary

################################################################

explore: player_social_button_clicks_summary {
  label: "Player Social Button Click Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_social_button_clicks_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_social_button_clicks_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: FB Log In Events Summary

################################################################

explore: player_fb_log_in_events_summary {
  label: "Player Meta Log In Events Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_fb_log_in_events_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_fb_log_in_events_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Player Daily Achievement Summary

################################################################

explore: player_achievement_summary {
  label: "Player Daily Achievement Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_achievement_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_achievement_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: Purchase Funnel

################################################################

explore: player_purchase_funnel_summary {
  label: "Player Purchase Funnel Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_purchase_funnel_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_purchase_funnel_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## Explore: player_engagement_threshold_summary

################################################################

explore: player_engagement_threshold_summary {
  label: "Player Engagement Threshold Summary"
  sql_always_where: ${player_block_list.rdg_id} is null ;;

  join: player_block_list {
    view_label: "Block List"
    type: left_outer
    relationship: many_to_one
    sql_on: ${player_engagement_threshold_summary.rdg_id} = ${player_block_list.rdg_id} ;;
  }
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_engagement_threshold_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

################################################################

## AB Test Explores

################################################################

explore: active_ab_tests_list {label: "AB Tests: Active AB Test List" group_label: "Chum Chum AB Tests"}
explore: ab_test_full_iterations {label: "AB Tests: Full Iterations" group_label: "Chum Chum AB Tests"}
explore: ab_test_current_population {label: "AB Tests: Current Population: Round Summary" group_label: "Chum Chum AB Tests"}
explore: ab_test_current_population_w_daily_summary {label: "AB Tests: Current Population: Daily Summary" group_label: "Chum Chum AB Tests"}
explore: ab_test_aggregate_check {label: "AB Test: Aggregate Check" group_label: "Chum Chum AB Tests"}
explore: ab_test_full_iterations_new {label: "AB Test: Full Iterations: New" group_label: "Chum Chum AB Tests"}
explore: ab_test_player_summary {label: "AB Test: New Players" group_label: "Chum Chum AB Tests"}
explore: ab_test_player_daily {label: "AB Test: All Players" group_label: "Chum Chum AB Tests"}
explore: ab_test_campaign_levels {label: "AB Test: Campaign Levels" group_label: "Chum Chum AB Tests"}


################################################################

## Adhoc Explores

################################################################

explore: adhoc_2024_11_21_aps_vs_churn_early_moves_buckets {label: "APS vs. Churn Scatter (Early Moves)" group_label: "Chum Chum Adhoc"}
explore: adhoc_20231213_moves_master_moves_per_week {label: "Moves Master Moves Remaining Per Week" group_label: "Chum Chum Adhoc"}
explore: adhoc_20240112_aps_vs_churn_scatter {label: "APS vs. Churn Scatter" group_label: "Chum Chum Adhoc"}
explore: adhoc_20240117_target_churn_rate {label: "Target Churn Rate By Level Bucket" group_label: "Chum Chum Adhoc"}
explore: adhoc_20240202_churn_by_recent_wins_losses {label: "Churn By Recent Wins and Losses" group_label: "Chum Chum Adhoc"}
explore: adhoc_2024_02_12_battle_pass_player_summary {label: "Battle Pass Player Summary" group_label: "Chum Chum Adhoc"}
explore: adhoc_2024_02_21_aps_vs_churn_spender_non_spender {label: "APS vs. Churn Scatter - Spender vs. Non Spender" group_label: "Chum Chum Adhoc"}
explore: adhoc_2024_02_26_puzzle_vs_campaign_aps_vs_churn {label: "APS vs. Churn Scatter - Puzzle vs. Campaign" group_label: "Chum Chum Adhoc"}
explore: adhoc_2024_06_27_castle_climb_reward_funnel {label: "Castle Climb Reward Funnel" group_label: "Chum Chum Adhoc"}
explore: player_bucket_by_first_10_levels {label: "Player Level 10 Moves Made" group_label: "Chum Chum Adhoc"}
explore: adhoc_check_applovin_ads_vs_telemetry {label: "Check Applovin vs. Telemetry" group_label: "Chum Chum Adhoc"}
explore: adhoc_2025_01_06_high_memory_usage {label: "Check High Memory Usage In Later Rounds" group_label: "Chum Chum Adhoc"}

explore: adhoc_2025_01_09_gem_quest_memory_change_over_session {
  label: "Gem Quest Memory Change Over Session"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2025_01_09_gem_quest_memory_change_over_session.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_10_23_treasure_trove_weekly_comparison {
  label: "Treasure Trove Weekly Comparison"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_10_23_treasure_trove_weekly_comparison.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_09_23_check_multiple_flour_frenzy_joins {
  label: "Check Multiple Flour Frenzy Joins"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_09_23_check_multiple_flour_frenzy_joins.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_06_13_tickets_funnel {
  label: "Tickets Test Funnel 5/11-6/11"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_06_13_tickets_funnel.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_08_15_quitting_player_profiles {
  label: "Quitting Player Profiles"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_08_15_quitting_player_profiles.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_08_21_first_and_second_button_clicks {
  label: "Time Between 1st and 2nd Button Clicks"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_08_21_first_and_second_button_clicks.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_09_18_rate_us_IAM_per_player_per_day {
  label: "Rate Us IAM Per Player Per Day"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_09_18_rate_us_IAM_per_player_per_day.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_09_19_notifications_iam_check {
  label: "Notifcations IAM: Time to Get"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_09_19_notifications_iam_check.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_09_20_check_time_to_join_flour_frenzy {
  label: "Check Time To Join Flour Frenzy"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_09_20_check_time_to_join_flour_frenzy.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2024_11_13_daily_rewards_per_week {
  label: "Daily Rewards Per Week - Experiment Check"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2024_11_13_daily_rewards_per_week.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2025_01_15_startup_interstitials_per_minute {
  label: "Startup Interstitials Per Minute"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2025_01_15_startup_interstitials_per_minute.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}

explore: adhoc_2025_01_16_puzzle_iam_rounds_played {
  label: "Puzzle IAM Rounds Played"
  group_label: "Chum Chum Adhoc"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${adhoc_2025_01_16_puzzle_iam_rounds_played.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
}


################################################################

## Financial Explores

################################################################

explore: sales_reports {
  group_label: "Platform Data"
  label: "Google Play Daily Revenue"

  join: player_mtx_purchase_summary {
    view_label: "Player MTX Summary"
    type: left_outer
    relationship: one_to_one
    sql_on: ${sales_reports.order_number} = ${player_mtx_purchase_summary.order_id} ;;
  }
}

explore: earnings_reports {
  group_label: "Platform Data"
  label: "Google Play Monthly Earnings"
  description: "Monthly payment from Google. Includes revenue, fees, chargebacks and taxes."
}

################################################################

## Other Explores

################################################################

explore: firebase_player_summary {}
explore: firebase_player_daily_incremental {}
explore: singular_campaign_summary {}
explore: singular_campaign_detail {}
explore: singular_creative_summary {
  view_label: "Creative Summary"
}
explore: big_query_jobs {}
explore: player_daily_incremental {}
explore: player_ad_view_incremental {}
explore: player_mtx_purchase_incremental {}
explore: revenue_model{}
explore: player_summary_staging {}
# explore: ab_test_t_test{}
explore: live_ops_calendar {}
explore: gogame_data {}
# explore: player_frame_rate_incremental {}
# explore: moves_master_recap_incremental {}

explore: player_block_list {}
explore: singular_player_attribution {}
explore: bfg_player_attribution {}
explore: applovin_ads_data_summary {}
# explore:player_fb_log_in_events_incremental {}
# explore: player_hitch_incremental {}
# explore: player_engagement_threshold_incremental {}
# explore: applovin_ads_data_incremental {}
# explore: player_achievement_incremental {}
# explore: player_purchase_funnel_incremental {}
# explore: player_social_button_clicks_incremental {}
# explore: player_popup_and_iam_incremental {}
# explore: player_simple_event_incremental {}
# explore: player_simple_event_summary_hotdog {}
# explore: player_simple_event_summary_flourfrenzy {}
# explore: player_ticket_spend_incremental {}
# explore: player_reward_incremental {}
# explore: player_notification_incremental {}
# explore: player_ad_view_incremental {}
# explore: firebase_player_daily_incremental {}
# explore: player_coin_source_incremental {}
# explore: player_coin_spend_incremental {}
# explore: player_round_incremental {}
# explore: player_battle_pass_incremental {}
# explore: player_error_incremental {}
# explore: player_fue_incremental {}
# explore: big_query_cost_log_incremental {}
# explore: player_go_fish_incremental {}
