view: temp_churn_by_tile_by_attempt {
  derived_table: {
    sql:
      with card_data as (
        select
          json_query(extra_json,'$.node_data[12]') current_node_entry,
          --custom_json_extract(extra_json, concat("$.node_data[?(@.node_id == '", current_quest, "')]")) current_node_entry,
          *
        from game_data.events
        where user_type = "external"
          and event_name = "cards"
        order by timestamp desc
      )
        select
          rdg_id,
          timestamp,
          current_card,
          cast(current_quest as int64) current_quest,
          cast(json_extract(current_node_entry, "$.node_attempts_explicit") as int64) node_attempts_explicit,
          json_extract(current_node_entry, "$.node_end_time") node_end_time,
          cast(json_extract(extra_json, "$.round_id") as int64) round_id,
          cast(last_value(json_extract(extra_json, "$.round_id"))
              over (
                  partition by rdg_id
                  order by timestamp
                  rows between 1 preceding AND 1 following
              ) as int64) greater_round_id
        from card_data
        order by timestamp desc
    ;;
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
    drill_fields: [rdg_id]
  }
  dimension: timestamp {
    type: date_time
  }
  dimension: current_card {}
  dimension: current_quest {
    type: number
  }
  dimension:node_attempts_explicit {
    type: number
  }
  dimension: round_id {}
  dimension: greater_round_id {}
  dimension: churn {
    type: string
    sql: if(${round_id} < ${greater_round_id},'played_again','stuck') ;;
  }
}
