
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
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_daily_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }

  join: version_summary {
    view_label:  "Version Summary"
    from:  version_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on: ${player_daily_summary.version} = ${version_summary.version};;
  }
}

################################################################

## Explore: Player Summary

################################################################


explore: player_summary_new {
  label: "Player Summary"

  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
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

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_round_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }

  join: level_mechanics {
    view_label:  "Level Mechanics"
    from:  level_mechanics
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_round_summary.level_serial} = ${level_mechanics.level_serial}
      ;;
  }


}

################################################################

## Explore: Player Ad View Summary

################################################################

explore: player_ad_view_summary {
  label: "Player Ad View Summary"
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_ad_view_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Mtx Summary

################################################################

explore: player_mtx_purchase_summary {
  label: "Player Mtx Purchase Summary"
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_mtx_purchase_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Coin Spend Summary

################################################################

explore: player_coin_spend_summary {
  label: "Player Coin Spend Summary"
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_coin_spend_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Hourly

################################################################

explore: player_hourly {
  label: "Player Hourly"
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_hourly.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Weekly Summary

################################################################

explore: player_weekly_summary {
  label: "Player Weekly Summary"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_weekly_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Monthly Summary

################################################################

explore: player_monthly_summary {
  label: "Player Monthly Summary"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_monthly_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Recent Frame Rate

################################################################

explore: player_recent_frame_rate {
  label: "Player Recent Frame Rate"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_recent_frame_rate.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Recent Button Clicks

################################################################

explore: player_recent_button_clicks {
  label: "Player Recent Button Clicks"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_recent_button_clicks.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}


################################################################

## Explore: Player Recent Full Data

################################################################

explore: player_recent_full_event_data {

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_recent_full_event_data.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player IAM Incremental

################################################################

explore: player_iam_incremental {

  label: "Player IAM Summary"

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_iam_incremental.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Coin Source Summary

################################################################

explore: player_coin_source_summary {

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_coin_source_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Profiler Event Recent

################################################################

explore: player_profiler_event_recent {

  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_profiler_event_recent.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }

  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Explore: Player Battle Pass Summary

################################################################

explore: player_battle_pass_summary {
  label: "Player Battle Pass Summary"
  join: player_summary_new {
    view_label: "Player Summary"
    type: left_outer
    relationship: many_to_one
    sql_on:
      ${player_battle_pass_summary.rdg_id} = ${player_summary_new.rdg_id}
      ;;
  }
  join: singular_campaign_summary {
    view_label:  "Singular Campaign Info"
    from:  singular_campaign_summary
    type:  left_outer
    relationship:  many_to_one
    sql_on:
      ${player_summary_new.singular_campaign_id_override} = ${singular_campaign_summary.singular_campaign_id}
      and date(${player_summary_new.singular_created_date_override}) = date(${singular_campaign_summary.singular_install_date})
      ;;
  }
}

################################################################

## Other Explores

################################################################

explore: firebase_player_summary {}
explore: singular_campaign_summary {}
explore: singular_creative_summary {}
explore: big_query_jobs {}
explore: player_daily_incremental {}
explore: ab_test_full_iterations {}
explore: revenue_model{}
# explore: ab_test_t_test{}

# explore: player_ad_view_incremental {}
# explore: firebase_player_daily_incremental {}
# explore: player_coin_source_incremental {}
# explore: player_coin_spend_incremental {}
# explore: player_round_incremental {}
# explore: player_mtx_purchase_incremental {}
# explore: player_battle_pass_incremental {}
explore: player_error_incremental {}
