view: round_end {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,session_id
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,cast(json_extract_scalar(extra_json,'$.round_id') as int64) round_id
        ,cast(json_extract_scalar(extra_json,'$.quest_complete') as boolean) quest_complete
        ,cast(json_extract_scalar(extra_json,'$.request_help') as boolean) request_help
        ,json_extract_scalar(extra_json,'$.team_slot_0') primary_team_slot
        ,json_extract_scalar(extra_json,'$.team_slot_skill_0') primary_team_slot_skill
        ,cast(json_extract_scalar(extra_json,'$.team_slot_level_0') as int64) primary_team_slot_level
        ,cast(json_extract_scalar(extra_json,'$.score_boost') as int64) score_boost
        ,cast(json_extract_scalar(extra_json,'$.coin_boost') as int64) coin_boost
        ,cast(json_extract_scalar(extra_json,'$.exp_boost') as int64) exp_boost
        ,cast(json_extract_scalar(extra_json,'$.time_boost') as int64) time_boost
        ,cast(json_extract_scalar(extra_json,'$.bubble_boost') as int64) bubble_boost
        ,cast(json_extract_scalar(extra_json,'$.five_to_four_boost') as int64) five_to_four_boost
        ,cast(json_extract_scalar(extra_json,'$.score_earned') as int64) score_earned
        ,cast(json_extract_scalar(extra_json,'$.fever_count') as int64) fever_count
        ,cast(json_extract_scalar(extra_json,'$.time_added') as boolean) time_added
        ,cast(json_extract_scalar(extra_json,'$.xp_earned') as int64) xp_earned
        ,cast(json_extract_scalar(extra_json,'$.coins_earned') as int64) coins_earned
        ,cast(json_extract_scalar(extra_json,'$.total_chains') as int64) total_chains
        ,json_extract(extra_json,'$.all_chains') all_chains
        ,json_extract_scalar(extra_json,'$.all_chains') unnest_all_chains
        ,array_length(case when json_value(extra_json, '$.bubble_normal') = "0" then null else split(json_value(extra_json, '$.bubble_normal'),',') end) bubbles_popped_normal
        ,array_length(case when json_value(extra_json, '$.bubble_coins') = "" then null else split(json_value(extra_json, '$.bubble_coins'),',') end) bubbles_popped_coins
        ,array_length(case when json_value(extra_json, '$.bubble_xp') = "" then null else split(json_value(extra_json, '$.bubble_xp'),',') end) bubbles_popped_xp
        ,array_length(case when json_value(extra_json, '$.bubble_time') = "" then null else split(json_value(extra_json, '$.bubble_time'),',') end) bubbles_popped_time
        ,array_length(case when json_value(extra_json, '$.bubble_score') = "" then null else split(json_value(extra_json, '$.bubble_score'),',') end) bubbles_popped_score
        ,array_length(case when json_value(extra_json, '$.bubble_h_burst') = "" then null else split(json_value(extra_json, '$.bubble_h_burst'),',') end) bubbles_h_burst_score
        ,array_length(case when json_value(extra_json, '$.bubble_v_burst') = "" then null else split(json_value(extra_json, '$.bubble_v_burst'),',') end) bubbles_v_burst_score
        ,array_length(case when json_value(extra_json, '$.bubble_x_burst') = "" then null else split(json_value(extra_json, '$.bubble_x_burst'),',') end) bubbles_x_burst_score
        ,array_length(case when json_value(extra_json, '$.bubble_multi_burst') = "" then null else split(json_value(extra_json, '$.bubble_multi_burst'),',') end) bubbles_multi_burst_score
        ,array_length(case when json_value(extra_json, '$.bubble_convert_random') = "" then null else split(json_value(extra_json, '$.bubble_convert_random'),',') end) bubbles_convert_random_score
        ,array_length(case when json_value(extra_json, '$.bubble_stop_time') = "" then null else split(json_value(extra_json, '$.bubble_stop_time'),',') end) bubbles_stop_time_score
        ,array_length(case when json_value(extra_json, '$.bubble_instant_fever') = "" then null else split(json_value(extra_json, '$.bubble_instant_fever'),',') end) bubbles_instant_fever_score
        ,json_extract_scalar(extra_json,'$.character_001_matched') character_001_matched
        ,json_extract_scalar(extra_json,'$.character_002_matched') character_002_matched
        ,json_extract_scalar(extra_json,'$.character_003_matched') character_003_matched
        ,json_extract_scalar(extra_json,'$.character_004_matched') character_004_matched
        ,json_extract_scalar(extra_json,'$.character_005_matched') character_005_matched
        ,json_extract_scalar(extra_json,'$.character_006_matched') character_006_matched
        ,json_extract_scalar(extra_json,'$.character_007_matched') character_007_matched
        ,json_extract_scalar(extra_json,'$.character_008_matched') character_008_matched
        ,json_extract_scalar(extra_json,'$.character_009_matched') character_009_matched
        ,json_extract_scalar(extra_json,'$.character_010_matched') character_010_matched
        ,json_extract_scalar(extra_json,'$.character_011_matched') character_011_matched
        ,json_extract_scalar(extra_json,'$.character_012_matched') character_012_matched
        ,json_extract_scalar(extra_json,'$.character_013_matched') character_013_matched
        ,json_extract_scalar(extra_json,'$.character_014_matched') character_014_matched
        ,json_extract_scalar(extra_json,'$.character_015_matched') character_015_matched
        ,json_extract_scalar(extra_json,'$.character_016_matched') character_016_matched
        ,json_extract_scalar(extra_json,'$.character_017_matched') character_017_matched
        ,json_extract_scalar(extra_json,'$.character_018_matched') character_018_matched
        ,json_extract_scalar(extra_json,'$.character_019_matched') character_019_matched
        ,json_extract_scalar(extra_json,'$.character_020_matched') character_020_matched
        ,json_extract_scalar(extra_json,'$.character_021_matched') character_021_matched
        ,json_extract_scalar(extra_json,'$.character_022_matched') character_022_matched
        ,json_extract_scalar(extra_json,'$.character_023_matched') character_023_matched
        ,json_extract_scalar(extra_json,'$.character_024_matched') character_024_matched
        ,json_extract_scalar(extra_json,'$.character_025_matched') character_025_matched
        ,json_extract_scalar(extra_json,'$.character_026_matched') character_026_matched
        ,json_extract_scalar(extra_json,'$.character_027_matched') character_027_matched
        ,json_extract_scalar(extra_json,'$.character_028_matched') character_028_matched
        ,json_extract_scalar(extra_json,'$.character_029_matched') character_029_matched
        ,json_extract_scalar(extra_json,'$.character_030_matched') character_030_matched
        ,json_extract_scalar(extra_json,'$.character_031_matched') character_031_matched
        ,json_extract_scalar(extra_json,'$.character_032_matched') character_032_matched
        ,json_extract_scalar(extra_json,'$.character_033_matched') character_033_matched
        ,json_extract_scalar(extra_json,'$.character_034_matched') character_034_matched
        ,json_extract_scalar(extra_json,'$.character_035_matched') character_035_matched
        ,json_extract_scalar(extra_json,'$.character_036_matched') character_036_matched
        ,json_extract_scalar(extra_json,'$.character_037_matched') character_037_matched
        ,json_extract_scalar(extra_json,'$.character_038_matched') character_038_matched
        ,json_extract_scalar(extra_json,'$.character_039_matched') character_039_matched
        ,json_extract_scalar(extra_json,'$.character_040_matched') character_040_matched
        ,json_extract_scalar(extra_json,'$.character_041_matched') character_041_matched
        ,json_extract_scalar(extra_json,'$.character_042_matched') character_042_matched
        ,json_extract_scalar(extra_json,'$.character_043_matched') character_043_matched
        ,json_extract_scalar(extra_json,'$.character_044_matched') character_044_matched
        ,json_extract_scalar(extra_json,'$.character_045_matched') character_045_matched
        ,json_extract_scalar(extra_json,'$.character_046_matched') character_046_matched
        ,json_extract_scalar(extra_json,'$.character_047_matched') character_047_matched
        ,json_extract_scalar(extra_json,'$.character_048_matched') character_048_matched
        ,cast(json_extract_scalar(extra_json,'$.skill_available') as int64) skill_available
        ,cast(json_extract_scalar(extra_json,'$.skill_used') as int64) skill_used
        ,cast(json_extract(json_extract(extra_json,"$.elements"),"$.element_001") as int64) boxes_popped
        ,cast(json_extract(json_extract(extra_json,"$.elements"),"$.element_027") as int64) smog_popped
      from game_data.events
      where event_name = 'round_end'
      and timestamp >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_raw} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    hidden: yes
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,year
    ]
  }
  dimension: session_id {}
  dimension: current_card {
    hidden: yes
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    hidden: no
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: card_id {
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_numbered {
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: current_quest {
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }
  dimension: quest_complete {
    type: yesno
    sql: ${TABLE}.quest_complete ;;
  }
  dimension: request_help {
    type: yesno
    sql: ${TABLE}.request_help ;;
  }
  dimension: primary_team_slot {
    type: string
    sql: ${TABLE}.primary_team_slot ;;
  }
  dimension: primary_team_slot_skill {
    type: string
    sql: ${TABLE}.primary_team_slot_skill ;;
  }
  dimension: primary_team_slot_level {
    type: number
    sql: ${TABLE}.primary_team_slot_level ;;
  }
  dimension: score_boost {
    group_label: "Boost Impact"
    label: "Score Boost"
    type: number
    sql: ${TABLE}.score_boost ;;
  }
  dimension: score_boost_used {
    group_label: "Boosts Used"
    label: "Score Boost"
    sql: if(${TABLE}.score_boost>0,"yes","no") ;;
  }
  dimension: coin_boost {
    group_label: "Boost Impact"
    label: "Coin Boost"
    type: number
    sql: ${TABLE}.coin_boost ;;
  }
  dimension: coin_boost_used {
    group_label: "Boosts Used"
    label: "Coin Boost"
    sql: if(${TABLE}.coin_boost>0,"yes","no") ;;
  }
  dimension: exp_boost {
    group_label: "Boost Impact"
    label: "XP Boost"
    type: number
    sql: ${TABLE}.exp_boost ;;
  }
  dimension: exp_boost_used {
    group_label: "Boosts Used"
    label: "XP Boost"
    sql: if(${TABLE}.exp_boost>0,"yes","no") ;;
  }
  dimension: time_boost {
    group_label: "Boost Impact"
    label: "Time Boost"
    type: number
    sql: ${TABLE}.time_boost ;;
  }
  dimension: time_boost_used {
    group_label: "Boosts Used"
    label: "Time Boost"
    sql: if(${TABLE}.time_boost>0,"yes","no") ;;
  }
  dimension: bubble_boost {
    group_label: "Boost Impact"
    label: "Bubble Boost"
    type: number
    sql: ${TABLE}.bubble_boost ;;
  }
  dimension: bubble_boost_used {
    group_label: "Boosts Used"
    label: "Bubble Boost"
    sql: if(${TABLE}.bubble_boost>0,"yes","no") ;;
  }
  dimension: five_to_four_boost {
    group_label: "Boost Impact"
    label: "5-to-4 Boost"
    type: number
    sql: ${TABLE}.five_to_four_boost ;;
  }
  dimension: five_to_four_boost_used {
    group_label: "Boosts Used"
    label: "5-to-4 Boost"
    sql: if(${TABLE}.five_to_four_boost>0,"yes","no") ;;
  }
  dimension: time_added {
    type: yesno
    sql: ${TABLE}.time_added ;;
  }
  dimension: score_earned {
    type: number
    sql: ${TABLE}.score_earned ;;
  }
  measure: score_earned_025 {
    group_label: "Score"
    label: "Score - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${score_earned} ;;
  }
  measure: score_earned_25 {
    group_label: "Score"
    label: "Score - 25%"
    type: percentile
    percentile: 25
    sql: ${score_earned} ;;
  }
  measure: score_earned_50 {
    group_label: "Score"
    label: "Score - Median"
    type: median
    sql: ${score_earned} ;;
  }
  measure: score_earned_75 {
    group_label: "Score"
    label: "Score - 75%"
    type: percentile
    percentile: 75
    sql: ${score_earned} ;;
  }
  measure: score_earned_975 {
    group_label: "Score"
    label: "Score - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${score_earned} ;;
  }
  dimension: coins_earned {
    type: number
    sql: ${TABLE}.coins_earned ;;
  }
  measure: coins_earned_025 {
    group_label: "Coins"
    label: "Coins - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${coins_earned} ;;
  }
  measure: coins_earned_25 {
    group_label: "Coins"
    label: "Coins - 25%"
    type: percentile
    percentile: 25
    sql: ${coins_earned} ;;
  }
  measure: coins_earned_50 {
    group_label: "Coins"
    label: "Coins - Median"
    type: median
    sql: ${coins_earned} ;;
  }
  measure: coins_earned_75 {
    group_label: "Coins"
    label: "Coins - 75%"
    type: percentile
    percentile: 75
    sql: ${coins_earned} ;;
  }
  measure: coins_earned_975 {
    group_label: "Coins"
    label: "Coins - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${coins_earned} ;;
  }
  dimension: fever_count {
    type: number
    sql: ${TABLE}.fever_count ;;
  }
  measure: fever_count_025 {
    group_label: "Fever Count"
    label: "Fever Count - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${fever_count} ;;
  }
  measure: fever_count_25 {
    group_label: "Fever Count"
    label: "Fever Count - 25%"
    type: percentile
    percentile: 25
    sql: ${fever_count} ;;
  }
  measure: fever_count_50 {
    group_label: "Fever Count"
    label: "Fever Count - Median"
    type: median
    sql: ${fever_count} ;;
  }
  measure: fever_count_75 {
    group_label: "Fever Count"
    label: "Fever Count - 75%"
    type: percentile
    percentile: 75
    sql: ${fever_count} ;;
  }
  measure: fever_count_975 {
    group_label: "Fever Count"
    label: "Fever Count - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${fever_count} ;;
  }
  dimension: xp_earned {
    type: number
    sql: ${TABLE}.xp_earned ;;
  }
  measure: xp_earned_025 {
    group_label: "XP Earned"
    label: "XP Earned - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${xp_earned} ;;
  }
  measure: xp_earned_25 {
    group_label: "XP Earned"
    label: "XP Earned - 25%"
    type: percentile
    percentile: 25
    sql: ${xp_earned} ;;
  }
  measure: xp_earned_50 {
    group_label: "XP Earned"
    label: "XP Earned - Median"
    type: median
    sql: ${xp_earned} ;;
  }
  measure: xp_earned_75 {
    group_label: "XP Earned"
    label: "XP Earned - 75%"
    type: percentile
    percentile: 75
    sql: ${xp_earned} ;;
  }
  measure: xp_earned_975 {
    group_label: "XP Earned"
    label: "XP Earned - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${xp_earned} ;;
  }
  dimension: total_chains {
    type: number
    sql: ${TABLE}.total_chains ;;
  }
  measure: total_chains_025 {
    group_label: "Chain Count"
    label: "Chain Count - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${total_chains} ;;
  }
  measure: total_chains_25 {
    group_label: "Chain Count"
    label: "Chain Count - 25%"
    type: percentile
    percentile: 25
    sql: ${total_chains} ;;
  }
  measure: total_chains_50 {
    group_label: "Chain Count"
    label: "Chain Count - Median"
    type: median
    sql: ${total_chains} ;;
  }
  measure: total_chains_75 {
    group_label: "Chain Count"
    label: "Chain Count - 75%"
    type: percentile
    percentile: 75
    sql: ${total_chains} ;;
  }
  measure: total_chains_975 {
    group_label: "Chain Count"
    label: "Chain Count - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${total_chains} ;;
  }
  dimension: skills_available {
    type: number
    sql: ${TABLE}.skill_available ;;
  }
  measure: skills_available_025 {
    group_label: "Skill Available"
    label: "Skill Available - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${skills_available} ;;
  }
  measure: skills_available_25 {
    group_label: "Skill Available"
    label: "Skill Available - 25%"
    type: percentile
    percentile: 25
    sql: ${skills_available} ;;
  }
  measure: skills_available_50 {
    group_label: "Skill Available"
    label: "Skill Available - Median"
    type: median
    sql: ${skills_available} ;;
  }
  measure: skills_available_75 {
    group_label: "Skill Available"
    label: "Skill Available - 75%"
    type: percentile
    percentile: 75
    sql: ${skills_available} ;;
  }
  measure: skills_available_975 {
    group_label: "Skill Available"
    label: "Skill Available - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${skills_available} ;;
  }
  dimension: skills_used {
    type: number
    sql: ${TABLE}.skill_used ;;
  }
  measure: skills_used_025 {
    group_label: "Skill Used"
    label: "Skill Used - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${skills_used} ;;
  }
  measure: skills_used_25 {
    group_label: "Skill Used"
    label: "Skill Used - 25%"
    type: percentile
    percentile: 25
    sql: ${skills_used} ;;
  }
  measure: skills_used_50 {
    group_label: "Skill Used"
    label: "Skill Used - Median"
    type: median
    sql: ${skills_used} ;;
  }
  measure: skills_used_75 {
    group_label: "Skill Used"
    label: "Skill Used - 75%"
    type: percentile
    percentile: 75
    sql: ${skills_used} ;;
  }
  measure: skills_used_975 {
    group_label: "Skill Used"
    label: "Skill Used - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${skills_used} ;;
  }
  dimension: skill_matches {
    type: number
    sql:
      case
        when ${TABLE}.primary_team_slot = 'character_001' then ${TABLE}.character_001_matched
        when ${TABLE}.primary_team_slot = 'character_002' then ${TABLE}.character_002_matched
        when ${TABLE}.primary_team_slot = 'character_003' then ${TABLE}.character_003_matched
        when ${TABLE}.primary_team_slot = 'character_004' then ${TABLE}.character_004_matched
        when ${TABLE}.primary_team_slot = 'character_005' then ${TABLE}.character_005_matched
        when ${TABLE}.primary_team_slot = 'character_006' then ${TABLE}.character_006_matched
        when ${TABLE}.primary_team_slot = 'character_007' then ${TABLE}.character_007_matched
        when ${TABLE}.primary_team_slot = 'character_008' then ${TABLE}.character_008_matched
        when ${TABLE}.primary_team_slot = 'character_009' then ${TABLE}.character_009_matched
        when ${TABLE}.primary_team_slot = 'character_010' then ${TABLE}.character_010_matched
        when ${TABLE}.primary_team_slot = 'character_011' then ${TABLE}.character_011_matched
        when ${TABLE}.primary_team_slot = 'character_012' then ${TABLE}.character_012_matched
        when ${TABLE}.primary_team_slot = 'character_013' then ${TABLE}.character_013_matched
        when ${TABLE}.primary_team_slot = 'character_014' then ${TABLE}.character_014_matched
        when ${TABLE}.primary_team_slot = 'character_015' then ${TABLE}.character_015_matched
        when ${TABLE}.primary_team_slot = 'character_016' then ${TABLE}.character_016_matched
        when ${TABLE}.primary_team_slot = 'character_017' then ${TABLE}.character_017_matched
        when ${TABLE}.primary_team_slot = 'character_018' then ${TABLE}.character_018_matched
        when ${TABLE}.primary_team_slot = 'character_019' then ${TABLE}.character_019_matched
        when ${TABLE}.primary_team_slot = 'character_020' then ${TABLE}.character_020_matched
        when ${TABLE}.primary_team_slot = 'character_021' then ${TABLE}.character_021_matched
        when ${TABLE}.primary_team_slot = 'character_022' then ${TABLE}.character_022_matched
        when ${TABLE}.primary_team_slot = 'character_023' then ${TABLE}.character_023_matched
        when ${TABLE}.primary_team_slot = 'character_024' then ${TABLE}.character_024_matched
        when ${TABLE}.primary_team_slot = 'character_025' then ${TABLE}.character_025_matched
        when ${TABLE}.primary_team_slot = 'character_026' then ${TABLE}.character_026_matched
        when ${TABLE}.primary_team_slot = 'character_027' then ${TABLE}.character_027_matched
        when ${TABLE}.primary_team_slot = 'character_028' then ${TABLE}.character_028_matched
        when ${TABLE}.primary_team_slot = 'character_029' then ${TABLE}.character_029_matched
        when ${TABLE}.primary_team_slot = 'character_030' then ${TABLE}.character_030_matched
        when ${TABLE}.primary_team_slot = 'character_031' then ${TABLE}.character_031_matched
        when ${TABLE}.primary_team_slot = 'character_032' then ${TABLE}.character_032_matched
        when ${TABLE}.primary_team_slot = 'character_033' then ${TABLE}.character_033_matched
        when ${TABLE}.primary_team_slot = 'character_034' then ${TABLE}.character_034_matched
        when ${TABLE}.primary_team_slot = 'character_035' then ${TABLE}.character_035_matched
        when ${TABLE}.primary_team_slot = 'character_036' then ${TABLE}.character_036_matched
        when ${TABLE}.primary_team_slot = 'character_037' then ${TABLE}.character_037_matched
        when ${TABLE}.primary_team_slot = 'character_038' then ${TABLE}.character_038_matched
        when ${TABLE}.primary_team_slot = 'character_039' then ${TABLE}.character_039_matched
        when ${TABLE}.primary_team_slot = 'character_040' then ${TABLE}.character_040_matched
        when ${TABLE}.primary_team_slot = 'character_041' then ${TABLE}.character_041_matched
        when ${TABLE}.primary_team_slot = 'character_042' then ${TABLE}.character_042_matched
        when ${TABLE}.primary_team_slot = 'character_043' then ${TABLE}.character_043_matched
        when ${TABLE}.primary_team_slot = 'character_044' then ${TABLE}.character_044_matched
        when ${TABLE}.primary_team_slot = 'character_045' then ${TABLE}.character_045_matched
        when ${TABLE}.primary_team_slot = 'character_046' then ${TABLE}.character_046_matched
        when ${TABLE}.primary_team_slot = 'character_047' then ${TABLE}.character_047_matched
        when ${TABLE}.primary_team_slot = 'character_048' then ${TABLE}.character_048_matched
        else null
      end
    ;;
  }
  dimension: efficient_skill_matches {
    type: number
    sql:
      case
        when ${TABLE}.primary_team_slot = 'character_001' then ${TABLE}.character_001_matched / 14
        when ${TABLE}.primary_team_slot = 'character_002' then ${TABLE}.character_002_matched / 12
        when ${TABLE}.primary_team_slot = 'character_003' then ${TABLE}.character_003_matched / 12
        when ${TABLE}.primary_team_slot = 'character_004' then ${TABLE}.character_004_matched / 12
        when ${TABLE}.primary_team_slot = 'character_005' then ${TABLE}.character_005_matched / 12
        when ${TABLE}.primary_team_slot = 'character_006' then ${TABLE}.character_006_matched / 12
        when ${TABLE}.primary_team_slot = 'character_007' then ${TABLE}.character_007_matched / 11
        when ${TABLE}.primary_team_slot = 'character_008' then ${TABLE}.character_008_matched / 11
        when ${TABLE}.primary_team_slot = 'character_009' then ${TABLE}.character_009_matched / 15
        when ${TABLE}.primary_team_slot = 'character_010' then ${TABLE}.character_010_matched / 16
        when ${TABLE}.primary_team_slot = 'character_011' then ${TABLE}.character_011_matched / 12
        when ${TABLE}.primary_team_slot = 'character_012' then ${TABLE}.character_012_matched / 12
        when ${TABLE}.primary_team_slot = 'character_013' then ${TABLE}.character_013_matched / 14
        when ${TABLE}.primary_team_slot = 'character_014' then ${TABLE}.character_014_matched / 14
        when ${TABLE}.primary_team_slot = 'character_015' then ${TABLE}.character_015_matched / 18
        when ${TABLE}.primary_team_slot = 'character_016' then ${TABLE}.character_016_matched / 14
        when ${TABLE}.primary_team_slot = 'character_017' then ${TABLE}.character_017_matched / 13
        when ${TABLE}.primary_team_slot = 'character_018' then ${TABLE}.character_018_matched / 13
        when ${TABLE}.primary_team_slot = 'character_019' then ${TABLE}.character_019_matched / 11
        when ${TABLE}.primary_team_slot = 'character_020' then ${TABLE}.character_020_matched / 19
        when ${TABLE}.primary_team_slot = 'character_021' then ${TABLE}.character_021_matched / 15
        when ${TABLE}.primary_team_slot = 'character_022' then ${TABLE}.character_022_matched / 22
        when ${TABLE}.primary_team_slot = 'character_023' then ${TABLE}.character_023_matched / 13
        when ${TABLE}.primary_team_slot = 'character_024' then ${TABLE}.character_024_matched / 11
        when ${TABLE}.primary_team_slot = 'character_025' then ${TABLE}.character_025_matched / 16
        when ${TABLE}.primary_team_slot = 'character_026' then ${TABLE}.character_026_matched / 14
        when ${TABLE}.primary_team_slot = 'character_027' then ${TABLE}.character_027_matched / 15
        when ${TABLE}.primary_team_slot = 'character_028' then ${TABLE}.character_028_matched / 20
        when ${TABLE}.primary_team_slot = 'character_029' then ${TABLE}.character_029_matched / 15
        when ${TABLE}.primary_team_slot = 'character_030' then ${TABLE}.character_030_matched / 19
        when ${TABLE}.primary_team_slot = 'character_031' then ${TABLE}.character_031_matched / 15
        when ${TABLE}.primary_team_slot = 'character_032' then ${TABLE}.character_032_matched / 21
        when ${TABLE}.primary_team_slot = 'character_033' then ${TABLE}.character_033_matched / 15
        when ${TABLE}.primary_team_slot = 'character_034' then ${TABLE}.character_034_matched / 14
        when ${TABLE}.primary_team_slot = 'character_035' then ${TABLE}.character_035_matched / 20
        when ${TABLE}.primary_team_slot = 'character_036' then ${TABLE}.character_036_matched / 13
        when ${TABLE}.primary_team_slot = 'character_037' then ${TABLE}.character_037_matched / 7
        when ${TABLE}.primary_team_slot = 'character_038' then ${TABLE}.character_038_matched / 13
        when ${TABLE}.primary_team_slot = 'character_039' then ${TABLE}.character_039_matched / 16
        when ${TABLE}.primary_team_slot = 'character_040' then ${TABLE}.character_040_matched / 15
        when ${TABLE}.primary_team_slot = 'character_041' then ${TABLE}.character_041_matched / 15
        when ${TABLE}.primary_team_slot = 'character_042' then ${TABLE}.character_042_matched / 23
        when ${TABLE}.primary_team_slot = 'character_043' then ${TABLE}.character_043_matched / 14
        when ${TABLE}.primary_team_slot = 'character_044' then ${TABLE}.character_044_matched / 15
        when ${TABLE}.primary_team_slot = 'character_045' then ${TABLE}.character_045_matched / 13
        when ${TABLE}.primary_team_slot = 'character_046' then ${TABLE}.character_046_matched / 14
        when ${TABLE}.primary_team_slot = 'character_047' then ${TABLE}.character_047_matched / 9
        when ${TABLE}.primary_team_slot = 'character_048' then ${TABLE}.character_048_matched / 16
        else null
      end
    ;;
  }
  measure:  skill_efficiency_025 {
    group_label: "Skill Efficiency"
    label: "Skill Efficiency - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${efficient_skill_matches} ;;
  }
  measure:  skill_efficiency_25 {
    group_label: "Skill Efficiency"
    label: "Skill Efficiency - 25%"
    type: percentile
    percentile: 25
    sql: ${efficient_skill_matches} ;;
  }
  measure:  skill_efficiency_50 {
    group_label: "Skill Efficiency"
    label: "Skill Efficiency - 50%"
    type: median
    sql: ${efficient_skill_matches} ;;
  }
  measure:  skill_efficiency_75 {
    group_label: "Skill Efficiency"
    label: "Skill Efficiency - 75%"
    type: percentile
    percentile: 75
    sql: ${efficient_skill_matches} ;;
  }
  measure:  skill_efficiency_975 {
    group_label: "Skill Efficiency"
    label: "Skill Efficiency - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${efficient_skill_matches} ;;
  }
  dimension: bubbles_popped_normal {
    group_label: "Bubbles"
    label: "Normal"
    type: number
  }
  dimension: bubbles_popped_coins {
    group_label: "Bubbles"
    label: "Coins"
    type: number
  }
  dimension: bubbles_popped_score {
    group_label: "Bubbles"
    label: "Score"
    type: number
  }
  dimension: bubbles_popped_all {
    group_label: "Bubbles"
    label: "All"
    type: number
    sql: ${bubbles_popped_normal} + ${bubbles_popped_coins} + ${bubbles_popped_score} ;;
  }
  measure: bubbles_popped_all_025 {
    group_label: "Bubbles Popped"
    label: "All Bubbles - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${bubbles_popped_all} ;;
  }
  measure: bubbles_popped_all_25 {
    group_label: "Bubbles Popped"
    label: "All Bubbles - 25%"
    type: percentile
    percentile: 25
    sql: ${bubbles_popped_all} ;;
  }
  measure: bubbles_popped_all_med {
    group_label: "Bubbles Popped"
    label: "All Bubbles - Median"
    type: median
    sql: ${bubbles_popped_all} ;;
  }
  measure: bubbles_popped_all_75 {
    group_label: "Bubbles Popped"
    label: "All Bubbles - 75%"
    type: percentile
    percentile: 75
    sql: ${bubbles_popped_all} ;;
  }
  measure: bubbles_popped_all_975 {
    group_label: "Bubbles Popped"
    label: "All Bubbles - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${bubbles_popped_all} ;;
  }
  dimension: boxes_popped {
    group_label: "Elements"
    label: "Boxes"
    type: number
  }
  measure: boxes_popped_all_025 {
    group_label: "Boxes Popped"
    label: "Boxes Popped - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${boxes_popped} ;;
  }
  measure: boxes_popped_all_25 {
    group_label: "Boxes Popped"
    label: "Boxes Popped - 25%"
    type: percentile
    percentile: 25
    sql: ${boxes_popped} ;;
  }
  measure: boxes_popped_all_med {
    group_label: "Boxes Popped"
    label: "Boxes Popped - Median"
    type: median
    sql: ${boxes_popped} ;;
  }
  measure: boxes_popped_all_75 {
    group_label: "Boxes Popped"
    label: "Boxes Popped - 75%"
    type: percentile
    percentile: 75
    sql: ${boxes_popped} ;;
  }
  measure: boxes_popped_all_975 {
    group_label: "Boxes Popped"
    label: "Boxes Popped - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${boxes_popped} ;;
  }
  dimension: smog_popped {
    group_label: "Elements"
    label: "Smog"
    type: number
  }
  measure: smog_popped_all_025 {
    group_label: "Smog Popped"
    label: "Smog Popped - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${smog_popped} ;;
  }
  measure: smog_popped_all_25 {
    group_label: "Smog Popped"
    label: "Smog Popped - 25%"
    type: percentile
    percentile: 25
    sql: ${smog_popped} ;;
  }
  measure: smog_popped_all_med {
    group_label: "Smog Popped"
    label: "Smog Popped - Median"
    type: median
    sql: ${smog_popped} ;;
  }
  measure: smog_popped_all_75 {
    group_label: "Smog Popped"
    label: "Smog Popped - 75%"
    type: percentile
    percentile: 75
    sql: ${smog_popped} ;;
  }
  measure: smog_popped_all_975 {
    group_label: "Smog Popped"
    label: "Smog Popped - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${smog_popped} ;;
  }

  dimension: all_chains {
    type: string
    sql: ${TABLE}.all_chains ;; #TAKE THE AVERAGE OR MEDIAN
    #sql: CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.all_chains')))
  }
  dimension: unnest_all_chains {
    hidden: yes
    type: string
    sql: '[' || ${TABLE}.unnest_all_chains || ']' ;;
  }
  measure: round_end_count {
    label: "Rounds Played"
    type: count
  }
  measure: session_count {
    label: "Sessions Played"
    type: count_distinct
    sql: ${TABLE}.session_id ;;
  }
  measure: percent_of_skills_used {
    type: number
    sql: ${skills_used} / ${skills_available} ;;
    value_format_name: percent_1
    description: "Skills Used / Skills Available"
  }

  drill_fields: [rdg_id,current_card_numbered,score_earned,coins_earned,fever_count]
}
