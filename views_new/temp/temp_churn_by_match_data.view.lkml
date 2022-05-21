## WORK IN PROGRESS

view: temp_churn_by_match_data {
  derived_table: {
    #datagroup_trigger: change_at_midnight
    sql: select
          rdg_id
          ,timestamp
          ,json_extract_scalar(extra_json,'$.cleared') tiles_cleared
          ,json_extract_scalar(extra_json,'$.moves') moves_remaining
          ,json_extract_scalar(extra_json,'$.objective_count_total') objective_count_total
          ,json_extract_scalar(extra_json,'$.objective_progress') objective_progress
          ,json_extract_scalar(extra_json,'$.objective_Balloon_value') objective_Balloon_value
          ,json_extract_scalar(extra_json,'$.level') level
          ,current_card
          ,current_quest
          ,cast(quests_completed as int64) quests_completed --proxy for round id
          ,cast(last_value(quests_completed)
                  over (
                      partition by rdg_id
                      order by timestamp
                      rows between 1 preceding AND 1 following
                  ) as int64) as greater_quests_completed
        from `eraser-blast.game_data.events`
        where user_type = 'external'
          and event_name = 'match_made'
          and timestamp >= timestamp(current_date() - 7) --this needs to be changed
          and json_extract_scalar(experiments,'$.fullminigame_20220517') = 'variant_c'  --this needs to be dynamic
        order by rdg_id, timestamp desc
      ;;}

  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${timestamp} ;;
  }

  dimension: churn {
    type: string
    sql: if(quests_completed < greater_quests_completed,'advanced_to_next_tile','still_on_current_tile') ;;
  }

  dimension: current_card {
    type: string
  }

  dimension: current_quest {
    type: number
  }
  dimension: quests_completed {
    type: number
  }

  dimension: greater_quests_completed {
    type: number
  }

  dimension: tiles_cleared {
    type: string
  }

  dimension: moves_remaining {
    type: string
  }

  dimension: objective_count_total {
    type: string
  }

  dimension:  objective_progress {
    type: number
    value_format: "#%"
  }

  dimension:  objective_Balloon_value {
    type: string
  }

  dimension: level {
    type: string
  }

  dimension: is_churn {
    hidden: yes
    type: yesno
    sql:  quests_completed < greater_quests_completed;;
  }

  # dimension: node_attempts_explicit {
  #   type: number
  # }

  # dimension: node_attempts_passive {
  #   type: number
  # }

  # dimension_group: node_end {
  #   type: time
  #   timeframes: [
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  # }


  dimension: rdg_id {
    type: string
  }

  # dimension: round_id {
  #   type: number
  # }

  # dimension: rounds {
  #   type: number
  # }

  dimension: timestamp {
    type: date_time
  }

  measure: player_count {
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id,current_card,current_quest,quests_completed,greater_quests_completed]
  }

}