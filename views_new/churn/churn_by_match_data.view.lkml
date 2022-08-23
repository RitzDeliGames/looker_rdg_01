## WORK IN PROGRESS

view: churn_by_match_data {
  derived_table: {
    #datagroup_trigger: change_at_midnight
    sql: select
          rdg_id
          ,timestamp
          ,last_level_id
          ,cast(last_level_serial as int64) last_level_serial
          --,json_extract_scalar(extra_json,'$.cleared') tiles_cleared
          ,cast(json_extract_scalar(extra_json,'$.moves') as int64) moves_remaining
          ,json_extract_scalar(extra_json,'$.objective_count_total') objective_count_total
          ,json_extract_scalar(extra_json,'$.objective_progress') objective_progress
          ,cast(json_extract_scalar(extra_json,'$.objective_Balloon_value') as int64) objective_balloon_value
          ,json_extract_scalar(extra_json,'$.level') level
          ,cast(last_value(last_level_serial)
                  over (
                      partition by rdg_id
                      order by timestamp
                      rows between 1 preceding AND 1 following
                  ) as int64) as greater_last_level_serial
          ,experiments
        from `eraser-blast.game_data.events`
        where user_type = 'external'
          and event_name = 'match_made'
          and timestamp >= timestamp(current_date() - 90) --this needs to be changed
        order by rdg_id, timestamp desc
      ;;}

  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${timestamp} ;;
  }

  dimension: level {
    group_label: "Level Dimensions"
    label: "Level - Extracted"
    type: string
  }

  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
  }

  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
  }

  dimension: last_level_serial_with_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed w/Schema ID"
    type: number
    sql: ${TABLE}.last_level_serial ;;
    html: {{ rendered_value }} || {{ last_level_id._rendered_value }} ;;
  }

  dimension: last_level_serial_with_id_extracted {
    group_label: "Level Dimensions"
    label: "Last Level Completed w/Extracted ID"
    type: number
    sql: ${TABLE}.last_level_serial ;;
    html: {{ rendered_value }} || {{ level._rendered_value }} ;;
  }

  dimension: greater_last_level_serial {
    group_label: "Level Dimensions"
    label: "Greater Last Level Completed"
    type: number
  }

  dimension: churn {
    type: string
    sql: if(${last_level_serial} < ${greater_last_level_serial},'still_on_current_tile','advanced_to_next_tile') ;;
  }

  dimension: is_churn {
    hidden: yes
    type: yesno
    sql:  ${last_level_serial} < ${greater_last_level_serial};;
  }

  dimension: moves_remaining {
    type: number
  }

  dimension: objective_count_total {
    type: string
  }

  dimension:  objective_progress {
    type: number
    value_format: "#%"
  }

  dimension:  objective_balloon_value {
    type: number
  }



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

  dimension: experiments {
    type: string
    sql: ${TABLE}.experiments ;;
    hidden: yes
  }
  dimension: altleveltuning_20220721   {
    group_label: "Experiments - Live"
    label: "Level Order v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altleveltuning_20220721'),'unassigned') ;;
  }
  dimension: altleveltuning_20220706   {
    group_label: "Experiments - Closed"
    label: "Level Order v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altleveltuning_20220706'),'unassigned') ;;
  }
  dimension: altlevelorder_20220623   {
    group_label: "Experiments - Closed"
    label: "Level Order v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altlevelorder_20220623'),'unassigned') ;;
  }
  dimension: experiment_zoneoptions_20220621   {
    group_label: "Experiments - Live"
    label: "Zones v4"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.zoneoptions_20220621'),'unassigned') ;;
  }
  dimension: eraserskills_20220629   {
    group_label: "Experiments - Live"
    label: "Eraser Skills v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.eraserskills_20220629'),'unassigned') ;;
  }
  dimension: dailyrewards_20220628   {
    group_label: "Experiments - Live"
    label: "Daily Rewards v4"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.dailyrewards_20220628'),'unassigned') ;;
  }

  measure: player_count {
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id,last_level_serial,greater_last_level_serial]
  }
}
