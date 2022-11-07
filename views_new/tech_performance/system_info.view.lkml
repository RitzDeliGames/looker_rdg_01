view: system_info {
  derived_table: {
    sql:
        select
          rdg_id
          ,timestamp
          ,cast(json_extract_scalar(extra_json, "$.systemMemorySize") as int64) systemMemorySize
        from `eraser-blast.game_data.events`
        where timestamp >= '2022-06-01'
          and user_type = 'external'
          and event_name = 'system_info'
    ;;
    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
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
  dimension: systemMemorySize {
    type: number
  }
  measure: count {
    label: "Count of Players"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: system_memory_025 {
    group_label: "System Memory"
    label: "System Memory - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${systemMemorySize} ;;
  }
  measure: system_memory_25 {
    group_label: "System Memory"
    label: "System Memory - 25%"
    type: percentile
    percentile: 25
    sql: ${systemMemorySize} ;;
  }
  measure: system_memory_med {
    group_label: "System Memory"
    label: "System Memory - Median"
    type: median
    sql: ${systemMemorySize} ;;
  }
  measure: system_memory_75 {
    group_label: "System Memory"
    label: "System Memory - 75%"
    type: percentile
    percentile: 75
    sql: ${systemMemorySize} ;;
  }
  measure: system_memory_975 {
    group_label: "System Memory"
    label: "System Memory - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${systemMemorySize} ;;
  }
}
