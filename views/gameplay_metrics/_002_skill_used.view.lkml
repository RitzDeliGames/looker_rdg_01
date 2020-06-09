include: "/views/**/events.view"


view: _002_skill_used {
  extends: [events]
  derived_table: {
    sql: SELECT
        timestamp_insert,
        created_at,
        extra_json,
        user_type,
        player_xp_level,
        payer,
        character_skill_used
      FROM
        events
        CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.{% parameter character %}_skill_used'))) AS character_skill_used
    WHERE event_name = 'round_end'
    AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
    ;;
  }


#########################`eraser-blast.game_data.events


  parameter: character {
    type: unquoted
    default_value: "character_001"
    suggest_explore: _002_skill_used
    suggest_dimension: _002_skill_used.character_dimension
  }


  #parameter: character_number {
  #  description: "Type a number from 01-50"
  #  type: unquoted
  #  default_value: "01"
  #}

  dimension: character_dimension {
    type: string
    sql: REPLACE(JSON_EXTRACT(extra_json,'$.team_slot_0'),'"','') ;;
  }


  dimension: primary_key {
    type: string
    hidden: yes
    sql:  CONCAT(${character_dimension},${extra_json}) ;;
  }



  #################


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: timestamp_insert {
    type: time
    hidden: yes
    sql: ${TABLE}.timestamp_insert ;;
  }

  dimension: character_skill_used {
    type: number
    sql: CAST(if(character_skill_used = '' ,'0', character_skill_used) AS NUMERIC);;
  }

  dimension: player_xp_level {
    type: number
    sql: ${TABLE}.player_xp_level ;;
  }

  dimension: character_skill {
    type: number
    sql: REPLACE(JSON_EXTRACT(${extra_json},
      '$.team_slot_skill_0'),'"','') ;;
  }

  dimension: character_level {
    type: number
    sql: REPLACE(JSON_EXTRACT(${extra_json},
      '$.team_slot_level_0'),'"','') ;;
  }

  dimension: coins_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.coins_earned'),'"','') as NUMERIC) ;;
  }

  dimension: score_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.score_earned'),'"','') as NUMERIC) ;;
  }

  dimension: xp_earned {
    type: number
    sql: CAST(REPLACE(JSON_EXTRACT(${extra_json},
      '$.xp_earned'),'"','') as NUMERIC) ;;
  }


  measure: total_skill_used {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Skill Used"
      url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
    }
    type: sum
    sql: ${character_skill_used} ;;
  }

  measure: 1_min_skill_used {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Skill Used"
      url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
    }
    group_label: "boxplot"
    type: min
    sql: ${character_skill_used} ;;
  }

  measure: 5_max_skill_used {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Skill Used"
      url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
    }
    group_label: "boxplot"
    type: max
    sql: ${character_skill_used} ;;
  }

  measure: 3_median_skill_used {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Skill Used"
      url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
    }
    group_label: "boxplot"
    type: median
    sql: ${character_skill_used} ;;
  }

  measure: 2_25_skill_used {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Skill Used"
      url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
    }
    group_label: "boxplot"
    type: percentile
    percentile: 25
    sql: ${character_skill_used} ;;
  }

  measure: 4_75_skill_used {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Skill Used"
      url: "{{ link }}&sorts=_002_skill_used.character_skill_used+desc"
    }
    group_label: "boxplot"
    type: percentile
    percentile: 75
    sql: ${character_skill_used} ;;
  }


#   dimension: user_type {
#     type: string
#     suggest_explore: events
#     suggest_dimension: events.user_type
# #     sql: ${TABLE}.user_type ;;
#   }

  set: detail {
    fields: [character_dimension,
      user_type,
      character_skill_used,
      character_skill,
      character_level]
  }

}
