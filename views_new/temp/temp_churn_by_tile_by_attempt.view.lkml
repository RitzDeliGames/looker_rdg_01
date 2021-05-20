view: temp_churn_by_tile_by_attempt {
  derived_table: {
    sql:
      with card_data as (
        select
          --json_query(extra_json,'$.node_data[12]') current_node_entry,
          json_query(extra_json,{% parameter churn.node_selector %}) current_node_entry
          ,*
        from game_data.events
        where user_type = 'external'
          and event_name = 'cards'
          and timestamp >= timestamp(current_date() - 90)
        order by timestamp desc
      )
        select
          rdg_id
          ,timestamp
          ,current_card
          ,current_quest
          --,cast(regexp_extract({% parameter churn.node_selector %}, r"\[(.*?)\]") as int64) + 1 current_quest
          ,cast(json_extract(current_node_entry, "$.node_attempts_explicit") as int64) node_attempts_explicit
          ,json_extract(current_node_entry, "$.node_end_time") node_end_time
          ,cast(json_extract(extra_json, "$.round_id") as int64) round_id
          ,cast(last_value(json_extract(extra_json, "$.round_id"))
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
    drill_fields: [rdg_id,node_attempts_explicit]
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



  parameter: node_selector {
    type: string
    allowed_value: {
      label: "Node 1"
      value: "$.node_data[0]"
    }
    allowed_value: {
      label: "Node 2"
      value: "$.node_data[1]"
    }
    allowed_value: {
      label: "Node 3"
      value: "$.node_data[2]"
    }
    allowed_value: {
      label: "Node 4"
      value: "$.node_data[3]"
    }
    allowed_value: {
      label: "Node 5"
      value: "$.node_data[4]"
    }
    allowed_value: {
      label: "Node 6"
      value: "$.node_data[5]"
    }
    allowed_value: {
      label: "Node 7"
      value: "$.node_data[6]"
    }
    allowed_value: {
      label: "Node 8"
      value: "$.node_data[7]"
    }
    allowed_value: {
      label: "Node 9"
      value: "$.node_data[8]"
    }
    allowed_value: {
      label: "Node 10"
      value: "$.node_data[9]"
    }
    allowed_value: {
      label: "Node 11"
      value: "$.node_data[10]"
    }
    allowed_value: {
      label: "Node 12"
      value: "$.node_data[11]"
    }
    allowed_value: {
      label: "Node 13"
      value: "$.node_data[12]"
    }
    allowed_value: {
      label: "Node 14"
      value: "$.node_data[13]"
    }
    allowed_value: {
      label: "Node 15"
      value: "$.node_data[14]"
    }
    allowed_value: {
      label: "Node 16"
      value: "$.node_data[15]"
    }
    allowed_value: {
      label: "Node 17"
      value: "$.node_data[16]"
    }
    allowed_value: {
      label: "Node 18"
      value: "$.node_data[17]"
    }
    allowed_value: {
      label: "Node 19"
      value: "$.node_data[18]"
    }
    allowed_value: {
      label: "Node 20"
      value: "$.node_data[19]"
    }
    allowed_value: {
      label: "Node 21"
      value: "$.node_data[20]"
    }
    allowed_value: {
      label: "Node 22"
      value: "$.node_data[21]"
    }
    allowed_value: {
      label: "Node 23"
      value: "$.node_data[22]"
    }
    allowed_value: {
      label: "Node 24"
      value: "$.node_data[23]"
    }
  }
}
