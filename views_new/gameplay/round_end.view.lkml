view: round_end {
# this table builds the fact table for the round end events - this is at the user and round grain, setup for unnesting the chain length as well
  derived_table: {
    sql:
      select distinct
        rdg_id
        ,timestamp
        ,session_id
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,cast(last_level_serial as int64) last_level_serial
        ,cast(json_extract_scalar(extra_json,'$.round_id') as int64) round_id
        ,cast(json_extract_scalar(extra_json,'$.quest_complete') as boolean) quest_complete
        ,json_extract_scalar(extra_json,'$.game_mode') game_mode
        ,cast(json_extract_scalar(extra_json,'$.request_help') as boolean) request_help
        ,json_extract_scalar(extra_json,'$.team_slot_0') primary_team_slot
        ,json_extract_scalar(extra_json,'$.team_slot_skill_0') primary_team_slot_skill
        ,cast(json_extract_scalar(extra_json,'$.team_slot_level_0') as int64) primary_team_slot_level
        ,cast(json_extract_scalar(extra_json,'$.rocket_boost') as int64) rocket_boost
        ,cast(json_extract_scalar(extra_json,'$.bomb_boost') as int64) bomb_boost
        ,cast(json_extract_scalar(extra_json,'$.color_ball_boost') as int64) color_ball_boost
        ,cast(json_extract_scalar(extra_json,'$.propeller_boost') as int64) propeller_boost
        ,cast(json_extract_scalar(extra_json,'$.score_earned') as int64) score_earned
        ,cast(json_extract_scalar(extra_json,'$.moves_added') as boolean) moves_added
        ,cast(json_extract_scalar(extra_json,'$.coins_earned') as int64) coins_earned
        ,cast(json_extract_scalar(extra_json,'$.total_chains') as int64) total_chains
        ,cast(json_extract_scalar(extra_json,'$.round_length') as int64) round_length
        ,cast(replace(json_extract_scalar(extra_json,'$.proximity_to_completion'),',','') as float64) proximity_to_completion
        --,cast(json_extract_scalar(extra_json,'$.requirement_amount') as int64) requirement_amount
        ,json_extract(extra_json,'$.all_chains') all_chains
        ,json_extract_scalar(extra_json,'$.all_chains') unnest_all_chains
        ,cast(json_extract_scalar(extra_json,'$.skill_available') as int64) skill_available
        ,cast(json_extract_scalar(extra_json,'$.skill_used') as int64) skill_used
    from game_data.events
   where event_name = 'round_end'
     and timestamp >= '2019-01-01'
     and user_type = 'external'
     and country != 'ZZ'
     and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${round_id} || '_' || ${event_time} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    # hidden: yes
  }
  measure: player_count {
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]
  }
  dimension: session_id {}
  dimension: game_mode {}
  dimension: current_card {
    group_label: "Card Dimensions"
    label: "Player Current Card"
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card"
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: last_unlocked_card_numbered {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card (Numbered)"
    type: number
    value_format: "####"
    sql: @{last_unlocked_card_numbered} ;;
  }
  dimension: card_id {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card (Coalesced)"
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    label: "Player Current Card (Numbered)"
    type: number
    value_format: "####"
    sql: @{current_card_numbered} ;;
  }
  dimension: current_quest {
    group_label: "Card Dimensions"
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: last_level_serial {
    group_label: "Last Level"
    type: number
    sql: ${TABLE}.last_level_serial ;;
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
  dimension: proximity_to_completion {
    group_label: "Proximity to Completion"
    label: "Proximity to Completion"
    type:  number
    sql: ${TABLE}.proximity_to_completion ;;
  }
  dimension: proximity_to_completion_int {
    group_label: "Proximity to Completion"
    label: "Proximity to Completion (Integer)"
    type:  number
    sql: ${TABLE}.proximity_to_completion * 100;;
  }
  dimension: proximity_to_completion_tiers {
    group_label: "Proximity to Completion"
    label: "Proximity to Completion Tiers"
    type: tier
    style: integer
    tiers: [-1,0,1,6,11,16,21,26,31,36,41,46,51,56,61,66,71,76,81,86,91,96,100,101]
    sql: ${proximity_to_completion_int} ;;
  }
  # dimension: requirement_amount {
  #   hidden: yes
  # }
  dimension: rocket_boost {
    group_label: "Boost Impact"
    label: "Rocket Boost"
    type: number
    sql: ${TABLE}.rocket_boost ;;
  }
  dimension: rocket_boost_used {
    group_label: "Boosts Used"
    label: "Rocket Boost"
    sql: if(${TABLE}.rocket_boost>0,"yes","no") ;;
  }
  dimension: bomb_boost {
    group_label: "Boost Impact"
    label: "Bomb Boost"
    type: number
    sql: ${TABLE}.bomb_boost ;;
  }
  dimension: bomb_boost_used {
    group_label: "Boosts Used"
    label: "Bomb Boost"
    sql: if(${TABLE}.bomb_boost>0,"yes","no") ;;
  }
  dimension: color_ball_boost {
    group_label: "Boost Impact"
    label: "Color Ball Boost"
    type: number
    sql: ${TABLE}.color_ball_boost ;;
  }
  dimension: color_ball_boost_used {
    group_label: "Boosts Used"
    label: "Color Ball Boost"
    sql: if(${TABLE}.color_ball_boost>0,"yes","no") ;;
  }
  dimension: propeller_boost {
    group_label: "Boost Impact"
    label: "Propeller Boost"
    type: number
    sql: ${TABLE}.propeller_boost ;;
  }
  dimension: propeller_boost_used {
    group_label: "Boosts Used"
    label: "Propeller Boost"
    sql: if(${TABLE}.propeller_boost>0,"yes","no") ;;
  }
  dimension: moves_added {
    type: yesno
    sql: ${TABLE}.moves_added ;;
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
  dimension: round_length {
    type: number
    sql: ${TABLE}.round_length ;;
  }
  dimension: round_length_num {
    type: number
    sql: ${TABLE}.round_length / 1000;;
  }
  measure: round_length_sum {
    label: "Round Length Sum"
    type: sum
    sql: ${round_length_num} ;;
  }
  measure: round_length_025 {
    group_label: "Round Length"
    label: "Round Length - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${round_length_num} ;;
  }
  measure: round_length_25 {
    group_label: "Round Length"
    label: "Round Length - 25%"
    type: percentile
    percentile: 25
    sql: ${round_length_num} ;;
  }
  measure: round_length_med {
    group_label: "Round Length"
    label: "Round Length - Median"
    type: median
    sql: ${round_length_num} ;;
  }
  measure: round_length_75 {
    group_label: "Round Length"
    label: "Round Length - 75%"
    type: percentile
    percentile: 75
    sql: ${round_length_num} ;;
  }
  measure: round_length_975 {
    group_label: "Round Length"
    label: "Round Length - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${round_length_num} ;;
  }
  dimension: matches_per_second {
    type: number
    value_format: "#.00"
    sql: ${total_chains} / ${round_length_num};;
  }
  dimension: seconds_per_match {
    type: number
    value_format: "#.00"
    sql: ${round_length_num} / ${total_chains};;
  }
  measure: matches_per_second_025 {
    group_label: "Matches per Second"
    label: "Matches per Second - 2.5%"
    type: percentile
    percentile: 2.5
    value_format: "#.00"
    sql: ${matches_per_second} ;;
  }
  measure: matches_per_second_25 {
    group_label: "Matches per Second"
    label: "Matches per Second - 25%"
    type: percentile
    percentile: 25
    value_format: "#.00"
    sql: ${matches_per_second} ;;
  }
  measure: matches_per_second_med {
    group_label: "Matches per Second"
    label: "Matches per Second - Median"
    type: median
    value_format: "#.00"
    sql: ${matches_per_second} ;;
  }
  measure: matches_per_second_75 {
    group_label: "Matches per Second"
    label: "Matches per Second - 75%"
    type: percentile
    percentile: 75
    value_format: "#.00"
    sql: ${matches_per_second} ;;
  }
  measure: matches_per_second_975 {
    group_label: "Matches per Second"
    label: "Matches per Second - 97.5%"
    type: percentile
    percentile: 97.5
    value_format: "#.00"
    sql: ${matches_per_second} ;;
  }
  measure: seconds_per_matches_025 {
    group_label: "Seconds per Match"
    label: "Seconds per Match - 2.5%"
    type: percentile
    percentile: 2.5
    value_format: "#.00"
    sql: ${seconds_per_match} ;;
  }
  measure: seconds_per_matches_25 {
    group_label: "Seconds per Match"
    label: "Seconds per Match - 25%"
    type: percentile
    percentile: 25
    value_format: "#.00"
    sql: ${seconds_per_match} ;;
  }
  measure: seconds_per_matches_med {
    group_label: "Seconds per Match"
    label: "Seconds per Match - Median"
    type: median
    value_format: "#.00"
    sql: ${seconds_per_match} ;;
  }
  measure: seconds_per_matches_75 {
    group_label: "Seconds per Match"
    label: "Seconds per Match - 75%"
    type: percentile
    percentile: 75
    value_format: "#.00"
    sql: ${seconds_per_match} ;;
  }
  measure: seconds_per_matches_975 {
    group_label: "Seconds per Match"
    label: "Seconds per Match - 97.5%"
    type: percentile
    percentile: 97.5
    value_format: "#.00"
    sql: ${seconds_per_match} ;;
  }
  drill_fields: [proximity_to_completion,rdg_id,current_card_numbered]
}
