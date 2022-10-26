view: churn_by_level_by_attempt {
  derived_table: {
    sql:
      select
        a.rdg_id
        ,a.timestamp
        ,a.last_level_id
        --,a.level_id
        ,a.game_mode
        ,cast(a.last_level_serial as int64) last_level_serial
        ,cast(a.round_id as int64) round_id
        ,cast(a.greater_round_id as int64) greater_round_id
        ,cast(b.rounds as int64) rounds
        ,cast(a.total_chains as int64) total_chains
        ,cast(a.round_length as int64) round_length
      from
        (select
           rdg_id
          ,json_extract_scalar(extra_json,"$.round_id") round_id
          ,timestamp
          ,last_level_id
          ,last_level_serial
          --,json_extract_scalar(extra_json,"$.level_id") level_id
          ,json_extract_scalar(extra_json,'$.game_mode') game_mode
          ,cast(json_extract_scalar(extra_json,'$.total_chains') as int64) total_chains
          ,cast(json_extract_scalar(extra_json,'$.round_length') as int64) round_length
          ,last_value(json_extract_scalar(extra_json, "$.round_id"))
            over (
                partition by rdg_id
                order by timestamp
                rows between 1 preceding AND 1 following
            ) greater_round_id
        from `eraser-blast.game_data.events`
        where date(timestamp) > '2022-06-05'
          and event_name = 'round_end') as a
      join
        (select
          rdg_id
          ,json_extract_scalar(extra_json,"$.round_id") round_id
          ,json_extract_scalar(extra_json,"$.rounds") rounds
        from `eraser-blast.game_data.events`
        where date(timestamp) > '2022-06-05'
          and event_name = 'round_end') as b
      on a.rdg_id = b.rdg_id
        and a.round_id = b.round_id
      order by 1, 2 desc    ;;
    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${timestamp} ;;
  }
  dimension: rdg_id {}
  measure: player_count {
    label: "Unique Player Count"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id,round_id,greater_round_id,rounds]
  }
  dimension: timestamp {
    type: date_time
  }
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
  }
  # dimension: level_id {
  #   group_label: "Level Dimensions"
  #   label: "Last Level Played - Extracted"
  #   type: string
  # }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
  }
  dimension: last_level_serial_offset {
    group_label: "Level Dimensions"
    label: "Last Level Completed + 1"
    type: number
    sql: ${last_level_serial} + 1 ;;
  }
  dimension: game_mode {}
  dimension:rounds {
    type: number
  }
  dimension: round_id {
    type: number
  }
  dimension: greater_round_id {
    type: number
  }
  dimension: churn {
    type: string
    sql: if(${round_id} < ${greater_round_id},'played_again','stuck') ;;
  }
  dimension: total_chains {
    type: number
  }
  dimension: round_length {
    type: number
  }
  dimension: round_length_num {
    type: number
    sql: ${round_length} / 1000;;
  }
  measure: round_length_med {
    label: "Round Length - Median"
    type: median
    sql: ${round_length_num} ;;
    drill_fields: [last_level_serial, last_level_id]
  }
}
