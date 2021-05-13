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
        ,json_extract_scalar(extra_json,'$.team_slot_level_0') primary_team_slot_level
        ,json_extract_scalar(extra_json,'$.score_boost') score_boost
        ,json_extract_scalar(extra_json,'$.coin_boost') coin_boost
        ,json_extract_scalar(extra_json,'$.exp_boost') exp_boost
        ,json_extract_scalar(extra_json,'$.time_boost') time_boost
        ,json_extract_scalar(extra_json,'$.bubble_boost') bubble_boost
        ,json_extract_scalar(extra_json,'$.five_to_four_boost') five_to_four_boost
        ,json_extract_scalar(extra_json,'$.score_earned') score_earned
        ,json_extract_scalar(extra_json,'$.fever_count') fever_count
        ,json_extract_scalar(extra_json,'$.time_added') time_added
        ,json_extract_scalar(extra_json,'$.xp_earned') xp_earned
        ,json_extract_scalar(extra_json,'$.coins_earned') coins_earned
        ,json_extract_scalar(extra_json,'$.total_chains') total_chains
        ,json_extract_scalar(extra_json,'$.all_chains') all_chains
        ,json_extract_scalar(extra_json,'$.character_007_skill_used') character_007_skill_used
        ,json_extract_scalar(extra_json,'$.character_012_skill_used') character_012_skill_used
        ,json_extract_scalar(extra_json,'$.character_004_skill_used') character_004_skill_used
        ,json_extract_scalar(extra_json,'$.character_010_skill_used') character_010_skill_used
        ,json_extract_scalar(extra_json,'$.character_001_skill_used') character_001_skill_used
        ,json_extract_scalar(extra_json,'$.skill_available') skill_available
        ,json_extract_scalar(extra_json,'$.skill_used') skill_used
      from game_data.events
      where event_name = 'round_end'
      and timestamp >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
    ;;
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
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
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
    type: string
    sql: ${TABLE}.primary_team_slot_level ;;
  }
  dimension: score_boost {
    type: number
    sql: ${TABLE}.score_boost ;;
  }
  dimension: coin_boost {}
  dimension: exp_boost {}
  dimension: time_boost {}
  dimension: bubble_boost {}
  dimension: five_to_four_boost {}
  dimension: score_earned {}
  dimension: fever_count {}
  dimension: time_added {}
  dimension: xp_earned {}
  dimension: coins_earned {}
  dimension: total_chains {}
  dimension: all_chains {}
  dimension: skill_used {
    type: string
    sql:
      case
        when ${TABLE}.primary_team_slot = 'character_001'
          then ${TABLE}.character_001_skill_used
        when ${TABLE}.primary_team_slot = 'character_004'
          then ${TABLE}.character_004_skill_used
        when ${TABLE}.primary_team_slot = 'character_007'
          then ${TABLE}.character_007_skill_used
        when ${TABLE}.primary_team_slot = 'character_010'
          then ${TABLE}.character_010_skill_used
        when ${TABLE}.primary_team_slot = 'character_012'
          then ${TABLE}.character_012_skill_used
        else null
      end
    ;;
  }
  dimension: character_007_skill_used {}
  dimension: character_012_skill_used {}
  dimension: character_004_skill_used {}
  dimension: character_010_skill_used {}
  dimension: character_001_skill_used {}
  dimension: skill_available {}
  # dimension: skill_used {}
}
