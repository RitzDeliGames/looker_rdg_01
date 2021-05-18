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
        ,json_extract_scalar(extra_json,'$.character_003_skill_used') character_002_skill_used
        ,json_extract_scalar(extra_json,'$.character_004_skill_used') character_004_skill_used
        ,json_extract_scalar(extra_json,'$.character_007_skill_used') character_007_skill_used
        ,json_extract_scalar(extra_json,'$.character_010_skill_used') character_010_skill_used
        ,json_extract_scalar(extra_json,'$.character_012_skill_used') character_012_skill_used
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
  dimension: score_earned {
    type: number
    sql: ${TABLE}.score_earned ;;
  }
  dimension: fever_count {
    type: number
    sql: ${TABLE}.fever_count ;;
  }
  dimension: time_added {
    type: yesno
    sql: ${TABLE}.time_added ;;
  }
  dimension: xp_earned {
    type: number
    sql: ${TABLE}.xp_earned ;;
  }
  dimension: coins_earned {
    type: number
    sql: ${TABLE}.coins_earned ;;
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
        when ${TABLE}.primary_team_slot = 'character_001'
          then ${TABLE}.character_001_skill_used
        when ${TABLE}.primary_team_slot = 'character_002'
          then ${TABLE}.character_002_skill_used
        when ${TABLE}.primary_team_slot = 'character_003'
          then ${TABLE}.character_003_skill_used
        when ${TABLE}.primary_team_slot = 'character_004'
          then ${TABLE}.character_004_skill_used
        when ${TABLE}.primary_team_slot = 'character_005'
          then ${TABLE}.character_005_skill_used
        when ${TABLE}.primary_team_slot = 'character_006'
          then ${TABLE}.character_006_skill_used
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
}
