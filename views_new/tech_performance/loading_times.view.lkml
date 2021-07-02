view: loading_times {
  derived_table: {
    sql:
    select
      rdg_id
      ,timestamp
      ,cast(json_extract_scalar(extra_json, '$.load_time') as numeric) load_time
      ,json_extract_scalar(extra_json, '$.transition_from') transition_from
      ,json_extract_scalar(extra_json, '$.transition_to') transition_to

    from game_data.events
    where event_name = 'transition'
      and timestamp >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
  ;;
    datagroup_trigger: change_3_hrs
  }

  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${event_raw} ;;
  }
  dimension: rdg_id {}
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
  dimension: load_time {}
  dimension: transition_from {}
  dimension: transition_to {}
  dimension: transition_from_to {
    type: string
    sql: concat(${transition_from}, " - ", ${transition_to}) ;;
  }
  dimension: load_time_sec {
    type: number
    sql: CAST((${load_time} / 1000) AS NUMERIC) ;;
  }
  measure: load_time_025 {
    group_label: "Scene Loading Times"
    label: "Scene Loading Times - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${load_time_sec} ;;
  }
  measure: load_time_25 {
    group_label: "Scene Loading Times"
    label: "Scene Loading Times - 25%"
    type: percentile
    percentile: 25
    sql: ${load_time_sec} ;;
  }
  measure: load_time_med {
    group_label: "Scene Loading Times"
    label: "Scene Loading Times - Median"
    type: median
    sql: ${load_time_sec} ;;
  }
  measure: load_time_75 {
    group_label: "Scene Loading Times"
    label: "Scene Loading Times - 75%"
    type: percentile
    percentile: 75
    sql: ${load_time_sec} ;;
  }
  measure: load_time_975 {
    group_label: "Scene Loading Times"
    label: "Scene Loading Times - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${load_time_sec} ;;
  }
}
