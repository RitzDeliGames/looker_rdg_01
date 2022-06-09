view: new_afh {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,'$.rdg_afh_id') rdg_afh_id
        ,json_extract_scalar(extra_json,'$.is_fake') is_fake
        ,json_extract_scalar(extra_json,'$.request_card_id') request_card_id
        ,json_extract_scalar(extra_json,'$.request_tile_id') request_tile_id
        ,json_extract_scalar(extra_json,'$.request_sent_timestamp') request_sent_timestamp
        ,json_extract_scalar(extra_json,'$.afh_action') afh_action
        ,json_extract_scalar(extra_json,'$.requesting_player_id') requesting_player_id
        ,json_extract_scalar(extra_json,'$.providing_player_id') providing_player_id
        ,extra_json
      from game_data.events
      where event_name = 'afh'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_8_hrs
  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_raw} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
   # hidden: yes
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,year
    ]
  }
  dimension: current_card {
    hidden: yes
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    hidden: no
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: card_id {
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_numbered {
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: current_quest {
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: last_level_serial {
    type: number
    sql: ${TABLE}.last_level_serial ;;
  }
  dimension: rdg_afh_id {}
  dimension: request_card_id {}
  dimension: request_card_numbered {
    label: "Request Card Numbered"
    type: number
    value_format: "####"
    sql: @{request_card_numbered} ;;
  }
  dimension: request_tile_id {
    type: number
  }
  dimension: request_card_quest {
    label: "Request Card + Quest"
    type: number
    value_format: "####"
    sql: cast(${request_card_numbered} as int64) + cast(${request_tile_id} as int64);;
  }
  dimension: request_sent_timestamp {}
  dimension: afh_action {}
  dimension: requesting_player_id {}
  dimension: providing_player_id {}
  measure: requesting_player_distinct_count {
    label: "Unique Requesting Player Count"
    type: count_distinct
    sql: ${requesting_player_id} ;;
  }
  measure:  providing_player_distinct_count {
    label: "Unique Helping Player Count"
    type: count_distinct
    sql: ${providing_player_id};;
  }
  measure: requests_count {
    label: "AFH Count"
    type: count_distinct
    sql: ${rdg_afh_id} ;;
  }
}
