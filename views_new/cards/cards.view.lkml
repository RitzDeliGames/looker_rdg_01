view: cards {
  derived_table: {
    sql:
      select
        rdg_id
        ,event_name
        ,timestamp
        ,json_extract_scalar(extra_json,'$.card_id') card_id
        ,timestamp_millis(cast(json_extract_scalar(extra_json,'$.card_start_time') as int64)) card_start_time
        ,timestamp_millis(cast(json_extract_scalar(extra_json,'$.card_update_time') as int64)) card_update_time
        ,timestamp_millis(cast(json_extract_scalar(extra_json,'$.card_end_time') as int64)) card_end_time
        ,json_extract_scalar(extra_json,'$.round_id') round_id
        ,json_extract_scalar(extra_json,'$.rounds') rounds
        ,json_extract_scalar(extra_json,'$.sessions') sessions
        ,array_to_string(json_extract_array(extra_json,'$.card_state'),',') card_state
        ,array_length(json_extract_array(extra_json,'$.card_state')) incomplete_nodes
        ,array_to_string(json_extract_array(extra_json,'$.card_state_progress'),',') card_state_progress
        ,array_length(json_extract_array(extra_json,'$.card_state_progress')) in_progress_nodes
        ,array_to_string(json_extract_array(extra_json,'$.card_state_completed'),',') card_state_completed
        ,array_length(json_extract_array(extra_json,'$.card_state_completed')) completed_nodes
        ,json_extract_array(extra_json,'$.node_data') node_data
        --,json_extract_scalar(extra_json,'$.card_id') current_quest
      from game_data.events
      where timestamp >= timestamp(current_date() - 90)
        and timestamp < timestamp(current_date())
        and event_name = 'cards'
        and user_type = 'external'
    ;;
    datagroup_trigger: change_3_hrs
  }
  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${event_name} || ${timestamp} ;;
  }
  dimension: rdg_id {
    hidden: yes
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: event_name {
    hidden: yes
    type: string
    sql: ${TABLE}.event_name ;;
  }
  dimension: timestamp {
    hidden: yes
    type: date_time
    sql: ${TABLE}.timestamp ;;
  }
  dimension: card_id {
    group_label: "Card Dimensions"
    label: "Player Current Card"
    type: string
    sql: ${TABLE}.card_id ;;
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    label: "Player Current Card (Numbered)"
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: card_start_time {
    type: date_time
    sql: ${TABLE}.card_start_time ;;
  }
  dimension: card_update_time {
    type: date_time
    sql: ${TABLE}.card_update_time ;;
  }
  dimension: card_end_time {
    type: date_time
    sql: ${TABLE}.card_end_time ;;
  }
  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }
  dimension: rounds {
    type: number
    sql: ${TABLE}.rounds ;;
  }
  dimension: sessions {
    type: number
    sql: ${TABLE}.sessions ;;
  }
  dimension: card_state {
    type: string
    sql: ${TABLE}.card_state ;;
  }
  dimension: incomplete_nodes {
    type: number
    sql: ${TABLE}.incomplete_nodes ;;
  }
  dimension: card_state_progress {
    type: string
    sql: ${TABLE}.card_state_progress ;;
  }
  dimension: in_progress_nodes {
    type: number
    sql: ${TABLE}.in_progress_nodes ;;
  }
  dimension: card_state_completed {
    type: string
    sql: ${TABLE}.card_state_completed ;;
  }
  dimension: completed_nodes {
    type: number
    sql: ${TABLE}.completed_nodes ;;
  }
  dimension: node_data {
    hidden: yes
    type: string
    sql: ${TABLE}.node_data ;;
  }
  # dimension: current_quest {
  #   type: string
  #   sql: ${TABLE}.current_quest ;;
  # }
}
