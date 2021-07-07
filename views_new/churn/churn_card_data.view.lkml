## WORK IN PROGRESS

view: churn_card_data {
  derived_table: {
    datagroup_trigger: change_at_midnight
    sql: select
           cast(json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_attempts_explicit") as int64) as node_attempts_explicit
          ,TIMESTAMP_MILLIS(cast(json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_end_time") as int64)) as node_end
          ,cast(json_extract(extra_json, "$.round_id") as int64) as round_id
          --,json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.isCompleted") = 'true' as is_completed
          ,json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.rounds") as rounds
          ,json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_attempts_passive") as node_attempts_passive
          ,TIMESTAMP_MILLIS(cast(json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_last_update_time") as int64)) as node_last_update
          ,json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_last_update_tick") as node_last_update_tick
          ,cast(last_value(json_extract(extra_json, "$.round_id"))
                  over (
                      partition by rdg_id
                      order by timestamp
                      rows between 1 preceding AND 1 following
                  ) as int64) as greater_round_id
          ,timestamp
          ,current_card
          ,current_quest
          ,json_extract_scalar(extra_json,'$.card_id') card_id
          ,rdg_id

        from game_data.events
        where user_type = 'external'
          and event_name = 'cards'
          and current_quest = {% parameter node_selector %}+1
          and timestamp >= timestamp(current_date() - 90)
        order by timestamp desc
  ;;}

dimension: primary_key {
  hidden: yes
  type: string
  sql: ${rdg_id} || ${timestamp} ;;
}



dimension: rdg_id {}

dimension: timestamp {
  type: date_time
}

dimension: node_attempts_explicit {
  type: number
}

dimension: node_attempts_passive {}

dimension: node_end {}

  dimension: churn {
    type: string
    sql: if(${round_id} < ${greater_round_id},'played_again','stuck') ;;
  }

dimension: round_id {}

dimension: rounds {}

dimension: greater_round_id {
  type: number
}

dimension: card_id {
  type: string
}

dimension: current_card {
  type: string
}

dimension: current_quest {
  type: number
}

measure: player_count {
  type: count_distinct
  sql: ${rdg_id} ;;
  drill_fields: [rdg_id,node_attempts_explicit]
}

dimension: node_is_selected {
  type: yesno
  sql: ${current_quest} = {% parameter node_selector %}+1 ;;
}

parameter: node_selector {
  type: unquoted
  allowed_value: {
    label: "Node 1"
    value: "0"
  }
  allowed_value: {
    label: "Node 2"
    value: "1"
  }
  allowed_value: {
    label: "Node 3"
    value: "2"
  }
  allowed_value: {
    label: "Node 4"
    value: "3"
  }
  allowed_value: {
    label: "Node 5"
    value: "4"
  }
  allowed_value: {
    label: "Node 6"
    value: "5"
  }
  allowed_value: {
    label: "Node 7"
    value: "6"
  }
  allowed_value: {
    label: "Node 8"
    value: "7"
  }
  allowed_value: {
    label: "Node 9"
    value: "8"
  }
  allowed_value: {
    label: "Node 10"
    value: "9"
  }
  allowed_value: {
    label: "Node 11"
    value: "10"
  }
  allowed_value: {
    label: "Node 12"
    value: "11"
  }
  allowed_value: {
    label: "Node 13"
    value: "12"
  }
  allowed_value: {
    label: "Node 14"
    value: "13"
  }
  allowed_value: {
    label: "Node 15"
    value: "14"
  }
  allowed_value: {
    label: "Node 16"
    value: "15"
  }
  allowed_value: {
    label: "Node 17"
    value: "16"
  }
  allowed_value: {
    label: "Node 18"
    value: "17"
  }
  allowed_value: {
    label: "Node 19"
    value: "18"
  }
  allowed_value: {
    label: "Node 20"
    value: "19"
  }
  allowed_value: {
    label: "Node 21"
    value: "20"
  }
  allowed_value: {
    label: "Node 22"
    value: "21"
  }
  allowed_value: {
    label: "Node 23"
    value: "22"
  }
  allowed_value: {
    label: "Node 24"
    value: "23"
  }
}
}
