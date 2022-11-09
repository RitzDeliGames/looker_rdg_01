view: churn_by_level_by_proximity {
  derived_table: {
    sql:
      select
        a.rdg_id
        ,a.timestamp
        ,a.game_mode
        ,cast(a.last_level_serial as int64) last_level_serial
        ,cast(a.round_id as int64) round_id
        ,cast(a.greater_round_id as int64) greater_round_id
        ,cast(b.proximity_to_completion as float64) proximity_to_completion
      from
        (select
           rdg_id
          ,json_extract_scalar(extra_json,"$.round_id") round_id
          ,timestamp
          ,last_level_serial
          ,json_extract_scalar(extra_json,'$.game_mode') game_mode
          ,last_value(json_extract_scalar(extra_json, "$.round_id"))
            over (
                partition by rdg_id
                order by timestamp
                rows between 1 preceding AND 1 following
            ) greater_round_id
        from `eraser-blast.game_data.events`
        where timestamp >= timestamp(current_date() - 90) --are both of these filters needed?
          and date(timestamp) > '2022-06-05'
          and event_name = 'round_end') as a
      join
        (select
          rdg_id
          ,json_extract_scalar(extra_json,"$.round_id") round_id
          ,cast(replace(json_extract_scalar(extra_json,'$.proximity_to_completion'),',','') as float64) proximity_to_completion
        from `eraser-blast.game_data.events`
        where timestamp >= timestamp(current_date() - 90) --are both of these filters needed?
          and date(timestamp) > '2022-06-05'
          and event_name = 'round_end') as b
      on a.rdg_id = b.rdg_id
        and a.round_id = b.round_id
      order by 1, 2 desc    ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${timestamp} ;;
  }
  dimension: rdg_id {}
  measure: player_count {
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id,round_id,greater_round_id]
  }
  dimension: timestamp {
    type: date_time
  }
  dimension: game_mode {}
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
    label: "Last Level Completed w/ID"
    type: number
    sql: ${TABLE}.last_level_serial;;
    html: {{ rendered_value }} || {{ last_level_id._rendered_value }} ;;
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
    sql: if(${TABLE}.proximity_to_completion <= 1, ${TABLE}.proximity_to_completion * 100, ${TABLE}.proximity_to_completion);;
  }
  dimension: proximity_to_completion_tiers {
    group_label: "Proximity to Completion"
    label: "Proximity to Completion Tiers"
    type: tier
    style: integer
    tiers: [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100]
    sql: ${proximity_to_completion_int} ;;
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
}
