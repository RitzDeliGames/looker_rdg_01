view: temp_session {
  derived_table: {
    sql:
      select
        rdg_id
        ,session_id
        ,current_card
        ,last_unlocked_card
        ,max(timestamp) timestamp
        ,count(timestamp) attempts_per_session
      from game_data.events
      where event_name = 'round_end'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
      group by 1,2,3,4
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
  }
  dimension: rdg_id {}
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_raw} ;;
    primary_key: yes
    hidden: yes
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
  dimension: attempts_per_session {
    type: number
  }
  measure: attempts_per_session_025 {
    label: "Attempts/Session - 2.5%"
    value_format: "0"
    type: percentile
    percentile: 2.5
    sql: ${attempts_per_session} ;;
  }
  measure: attempts_per_session_25 {
    label: "Attempts/Session - 25%"
    value_format: "0"
    type: percentile
    percentile: 25
    sql: ${attempts_per_session} ;;
  }
  measure: attempts_per_session_med {
    label: "Attempts/Session - Med"
    value_format: "0"
    type: median
    sql: ${attempts_per_session} ;;
  }
  measure: attempts_per_session_95 {
    label: "Attempts/Session - 75%"
    value_format: "0"
    type: percentile
    percentile: 75
    sql: ${attempts_per_session} ;;
  }
  measure: attempts_per_session_975 {
    label: "Attempts/Session - 97.5%"
    value_format: "0"
    type: percentile
    percentile: 97.5
    sql: ${attempts_per_session} ;;
  }

}
