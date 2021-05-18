view: round_end {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,current_card
        ,last_unlocked_card
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
        ,json_extract_scalar(extra_json,'$.all_chains') all_chains
        ,json_extract_scalar(extra_json,'$.character_001_skill_used') character_001_skill_used
        ,json_extract_scalar(extra_json,'$.character_002_skill_used') character_002_skill_used
        ,json_extract_scalar(extra_json,'$.character_003_skill_used') character_003_skill_used
        ,json_extract_scalar(extra_json,'$.character_004_skill_used') character_004_skill_used
        ,json_extract_scalar(extra_json,'$.character_005_skill_used') character_005_skill_used
        ,json_extract_scalar(extra_json,'$.character_006_skill_used') character_006_skill_used
        ,json_extract_scalar(extra_json,'$.character_007_skill_used') character_007_skill_used
        ,json_extract_scalar(extra_json,'$.character_008_skill_used') character_008_skill_used
        ,json_extract_scalar(extra_json,'$.character_009_skill_used') character_009_skill_used
        ,json_extract_scalar(extra_json,'$.character_010_skill_used') character_010_skill_used
        ,json_extract_scalar(extra_json,'$.character_011_skill_used') character_011_skill_used
        ,json_extract_scalar(extra_json,'$.character_012_skill_used') character_012_skill_used
        ,json_extract_scalar(extra_json,'$.character_013_skill_used') character_013_skill_used
        ,json_extract_scalar(extra_json,'$.character_014_skill_used') character_014_skill_used
        ,json_extract_scalar(extra_json,'$.character_015_skill_used') character_015_skill_used
        ,json_extract_scalar(extra_json,'$.character_016_skill_used') character_016_skill_used
        ,json_extract_scalar(extra_json,'$.character_017_skill_used') character_017_skill_used
        ,json_extract_scalar(extra_json,'$.character_018_skill_used') character_018_skill_used
        ,json_extract_scalar(extra_json,'$.character_019_skill_used') character_019_skill_used
        ,json_extract_scalar(extra_json,'$.character_020_skill_used') character_020_skill_used
        ,json_extract_scalar(extra_json,'$.character_021_skill_used') character_021_skill_used
        ,json_extract_scalar(extra_json,'$.character_022_skill_used') character_022_skill_used
        ,json_extract_scalar(extra_json,'$.character_023_skill_used') character_023_skill_used
        ,json_extract_scalar(extra_json,'$.character_024_skill_used') character_024_skill_used
        ,json_extract_scalar(extra_json,'$.character_025_skill_used') character_025_skill_used
        ,json_extract_scalar(extra_json,'$.character_026_skill_used') character_026_skill_used
        ,json_extract_scalar(extra_json,'$.character_027_skill_used') character_027_skill_used
        ,json_extract_scalar(extra_json,'$.character_028_skill_used') character_028_skill_used
        ,json_extract_scalar(extra_json,'$.character_029_skill_used') character_029_skill_used
        ,json_extract_scalar(extra_json,'$.character_030_skill_used') character_030_skill_used
        ,json_extract_scalar(extra_json,'$.character_031_skill_used') character_031_skill_used
        ,json_extract_scalar(extra_json,'$.character_032_skill_used') character_032_skill_used
        ,json_extract_scalar(extra_json,'$.character_033_skill_used') character_033_skill_used
        ,json_extract_scalar(extra_json,'$.character_034_skill_used') character_034_skill_used
        ,json_extract_scalar(extra_json,'$.character_035_skill_used') character_035_skill_used
        ,json_extract_scalar(extra_json,'$.character_036_skill_used') character_036_skill_used
        ,json_extract_scalar(extra_json,'$.character_037_skill_used') character_037_skill_used
        ,json_extract_scalar(extra_json,'$.character_038_skill_used') character_038_skill_used
        ,json_extract_scalar(extra_json,'$.character_039_skill_used') character_039_skill_used
        ,json_extract_scalar(extra_json,'$.character_040_skill_used') character_040_skill_used
        ,json_extract_scalar(extra_json,'$.character_041_skill_used') character_041_skill_used
        ,json_extract_scalar(extra_json,'$.character_042_skill_used') character_042_skill_used
        ,json_extract_scalar(extra_json,'$.character_043_skill_used') character_043_skill_used
        ,json_extract_scalar(extra_json,'$.character_044_skill_used') character_044_skill_used
        ,json_extract_scalar(extra_json,'$.character_045_skill_used') character_045_skill_used
        ,json_extract_scalar(extra_json,'$.character_046_skill_used') character_046_skill_used
        ,json_extract_scalar(extra_json,'$.character_047_skill_used') character_047_skill_used
        ,json_extract_scalar(extra_json,'$.character_048_skill_used') character_048_skill_used
        ,cast(json_extract_scalar(extra_json,'$.skill_available') as int64) skill_available
        ,cast(json_extract_scalar(extra_json,'$.skill_used') as int64) skill_used
      from game_data.events
      where event_name = 'round_end'
      and timestamp >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_at_midnight
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
    type: number
    sql: ${TABLE}.score_boost ;;
  }
  dimension: coin_boost {
    type: number
    sql: ${TABLE}.coin_boost ;;
  }
  dimension: exp_boost {
    type: number
    sql: ${TABLE}.exp_boost ;;
  }
  dimension: time_boost {
    type: number
    sql: ${TABLE}.time_boost ;;
  }
  dimension: bubble_boost {
    type: number
    sql: ${TABLE}.bubble_boost ;;
  }
  dimension: five_to_four_boost {
    type: number
    sql: ${TABLE}.five_to_four_boost ;;
  }
  dimension: fever_count {
    type: number
    sql: ${TABLE}.fever_count ;;
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

  dimension: xp_earned {
    type: number
    sql: ${TABLE}.xp_earned ;;
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

  dimension: total_chains {
    type: number
    sql: ${TABLE}.total_chains ;;
  }
  dimension: all_chains {
    type: string
    sql: ${TABLE}.all_chains ;;
  }
  dimension: skill_used {
    type: string
    sql:
      case
        when ${TABLE}.primary_team_slot = 'character_001' then ${TABLE}.character_001_skill_used
        when ${TABLE}.primary_team_slot = 'character_002' then ${TABLE}.character_002_skill_used
        when ${TABLE}.primary_team_slot = 'character_003' then ${TABLE}.character_003_skill_used
        when ${TABLE}.primary_team_slot = 'character_004' then ${TABLE}.character_004_skill_used
        when ${TABLE}.primary_team_slot = 'character_005' then ${TABLE}.character_005_skill_used
        when ${TABLE}.primary_team_slot = 'character_006' then ${TABLE}.character_006_skill_used
        when ${TABLE}.primary_team_slot = 'character_007' then ${TABLE}.character_007_skill_used
        when ${TABLE}.primary_team_slot = 'character_008' then ${TABLE}.character_008_skill_used
        when ${TABLE}.primary_team_slot = 'character_009' then ${TABLE}.character_009_skill_used
        when ${TABLE}.primary_team_slot = 'character_010' then ${TABLE}.character_010_skill_used
        when ${TABLE}.primary_team_slot = 'character_011' then ${TABLE}.character_011_skill_used
        when ${TABLE}.primary_team_slot = 'character_012' then ${TABLE}.character_012_skill_used
        when ${TABLE}.primary_team_slot = 'character_013' then ${TABLE}.character_013_skill_used
        when ${TABLE}.primary_team_slot = 'character_014' then ${TABLE}.character_014_skill_used
        when ${TABLE}.primary_team_slot = 'character_015' then ${TABLE}.character_015_skill_used
        when ${TABLE}.primary_team_slot = 'character_016' then ${TABLE}.character_016_skill_used
        when ${TABLE}.primary_team_slot = 'character_017' then ${TABLE}.character_017_skill_used
        when ${TABLE}.primary_team_slot = 'character_018' then ${TABLE}.character_018_skill_used
        when ${TABLE}.primary_team_slot = 'character_019' then ${TABLE}.character_019_skill_used
        when ${TABLE}.primary_team_slot = 'character_020' then ${TABLE}.character_020_skill_used
        when ${TABLE}.primary_team_slot = 'character_021' then ${TABLE}.character_021_skill_used
        when ${TABLE}.primary_team_slot = 'character_022' then ${TABLE}.character_022_skill_used
        when ${TABLE}.primary_team_slot = 'character_023' then ${TABLE}.character_023_skill_used
        when ${TABLE}.primary_team_slot = 'character_024' then ${TABLE}.character_024_skill_used
        when ${TABLE}.primary_team_slot = 'character_025' then ${TABLE}.character_025_skill_used
        when ${TABLE}.primary_team_slot = 'character_026' then ${TABLE}.character_026_skill_used
        when ${TABLE}.primary_team_slot = 'character_027' then ${TABLE}.character_027_skill_used
        when ${TABLE}.primary_team_slot = 'character_028' then ${TABLE}.character_028_skill_used
        when ${TABLE}.primary_team_slot = 'character_029' then ${TABLE}.character_029_skill_used
        when ${TABLE}.primary_team_slot = 'character_030' then ${TABLE}.character_030_skill_used
        when ${TABLE}.primary_team_slot = 'character_031' then ${TABLE}.character_031_skill_used
        when ${TABLE}.primary_team_slot = 'character_032' then ${TABLE}.character_032_skill_used
        when ${TABLE}.primary_team_slot = 'character_033' then ${TABLE}.character_033_skill_used
        when ${TABLE}.primary_team_slot = 'character_034' then ${TABLE}.character_034_skill_used
        when ${TABLE}.primary_team_slot = 'character_035' then ${TABLE}.character_035_skill_used
        when ${TABLE}.primary_team_slot = 'character_036' then ${TABLE}.character_036_skill_used
        when ${TABLE}.primary_team_slot = 'character_037' then ${TABLE}.character_037_skill_used
        when ${TABLE}.primary_team_slot = 'character_038' then ${TABLE}.character_038_skill_used
        when ${TABLE}.primary_team_slot = 'character_039' then ${TABLE}.character_039_skill_used
        when ${TABLE}.primary_team_slot = 'character_040' then ${TABLE}.character_040_skill_used
        when ${TABLE}.primary_team_slot = 'character_041' then ${TABLE}.character_041_skill_used
        when ${TABLE}.primary_team_slot = 'character_042' then ${TABLE}.character_042_skill_used
        when ${TABLE}.primary_team_slot = 'character_043' then ${TABLE}.character_043_skill_used
        when ${TABLE}.primary_team_slot = 'character_044' then ${TABLE}.character_044_skill_used
        when ${TABLE}.primary_team_slot = 'character_045' then ${TABLE}.character_045_skill_used
        when ${TABLE}.primary_team_slot = 'character_046' then ${TABLE}.character_046_skill_used
        when ${TABLE}.primary_team_slot = 'character_047' then ${TABLE}.character_047_skill_used
        when ${TABLE}.primary_team_slot = 'character_048' then ${TABLE}.character_048_skill_used
        else null
      end
    ;;
  }
  dimension: skills_available {
    type: number
    sql: ${TABLE}.skill_available ;;
  }
  dimension: skills_used {
    type: number
    sql: ${TABLE}.skill_used ;;
  }
  measure: round_end_count {
    type: count
  }
  measure: percent_of_skills_used {
    type: number
    sql: ${skills_used} / ${skills_available} ;;
    value_format_name: percent_1
    description: "Skills Used / Skills Available"
  }

  drill_fields: [rdg_id,current_card_numbered,score_earned,coins_earned]
}
