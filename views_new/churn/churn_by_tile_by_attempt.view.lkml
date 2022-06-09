## WORK IN PROGRESS

# If necessary, uncomment the line below to include explore_source.
# include: "ritz_deli_games.model.lkml"

view: churn_by_tile_by_attempt {
  derived_table: {
    #datagroup_trigger: change_at_midnight
    explore_source: churn_card_data {
      column: extra_json {}
      column: rdg_id {}
      column: timestamp {}
      column: card_id {}
      column: current_card {}
      column: current_quest {}
      column: last_level_serial {}
      derived_column: node_attempts_explicit {
        # To Summarize all the columns below, we are running two queries, one to identify the node, and another to identify each field contained within that node
        sql: cast(json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_attempts_explicit") as int64) ;;
      }
      derived_column: node_end {
        sql: TIMESTAMP_MILLIS(cast(json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_end_time") as int64)) ;;
      }
      derived_column: round_id {
        sql: cast(json_extract(extra_json, "$.round_id") as int64) ;;
      }
      derived_column: is_completed {
        sql: json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.isCompleted") = 'true' ;;
      }
      derived_column: rounds {
        sql: json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.rounds") ;;
      }
      derived_column: node_attempts_passive {
        sql: json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_attempts_passive") ;;
      }
      derived_column: node_last_updated {
        #Convert node_last_updated_time to int64, then use timestamp_millis to convert the int64 to date
        sql: TIMESTAMP_MILLIS(cast(json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_last_update_time") as int64)) ;;
      }
      derived_column: node_last_update_tick {
        sql: json_query(json_query(extra_json,"$.node_data[{% parameter node_selector %}]"),"$.node_last_update_tick") ;;
      }
      derived_column: greater_round_id {
        sql: cast(last_value(json_extract(extra_json, "$.round_id"))
              over (
                  partition by rdg_id
                  order by timestamp
                  rows between 1 preceding AND 1 following
              ) as int64)  ;;
      }
      derived_column: node_selected {
        sql: {% parameter node_selector %} ;;
      }
    }
  }

  dimension: pk {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${timestamp} ;;
  }

  dimension: extra_json {
    #hidden: yes
  }

  dimension: rdg_id {}

  dimension: timestamp {
    type: date_time
  }

  dimension: card_id {}

  dimension: churn {
    type: string
    sql: if(${round_id} < ${greater_round_id},'played_again','stuck') ;;
  }

  dimension: current_card {}

  dimension: current_quest {
    type: number
  }

  dimension: last_level_serial {
    type: number
  }

  dimension: greater_round_id {
    type: number
  }

  dimension: is_completed {
    type: yesno
  }

  dimension: node_is_selected {
    hidden: yes
    type: yesno
    sql: ${current_quest} = {% parameter node_selector %}+1 ;;
  }

  dimension: node_selected {
    #hidden: yes
    sql: {% parameter node_selector %} ;;
  }

  dimension_group: node_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
  }

  dimension: node_attempts_explicit {
    type: number
  }

  dimension: node_attempts_passive {
    type: number
  }

  dimension_group: node_last_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
  }

  dimension: node_last_update_tick {}

  dimension: round_id {
    type: number
  }

  dimension: rounds {}

  measure: player_count {
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id,node_attempts_explicit]
  }

  parameter: node_selector {
    type: number
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
