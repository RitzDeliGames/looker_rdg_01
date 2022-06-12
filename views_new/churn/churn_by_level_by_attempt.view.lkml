view: churn_by_level_by_attempt {
  derived_table: {
    sql:
      select
        rdg_id,
        timestamp,
        cast(last_level_serial as int64) last_level_serial,
        cast(json_extract(extra_json, "$.rounds") as int64) rounds,
        cast(json_extract(extra_json, "$.round_id") as int64) round_id,
        cast(last_value(json_extract(extra_json, "$.round_id"))
            over (
                partition by rdg_id
                order by timestamp
                rows between 1 preceding AND 1 following
            ) as int64) greater_round_id
      from game_data.events
      where user_type = "external"
        and event_name = "cards"
        and timestamp >= timestamp(current_date() - 90)
      order by 1, 2 desc
    ;;
    datagroup_trigger: change_at_midnight
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
    drill_fields: [rdg_id,rounds,round_id,greater_round_id]
  }
  dimension: timestamp {
    type: date_time
  }
  dimension: last_level_serial {
    label: "Last Level"
  }
  dimension:rounds {
    type: number
  }
  dimension: round_id {}
  dimension: greater_round_id {}
  dimension: churn {
    type: string
    sql: if(${round_id} < ${greater_round_id},'played_again','stuck') ;;
  }
}
