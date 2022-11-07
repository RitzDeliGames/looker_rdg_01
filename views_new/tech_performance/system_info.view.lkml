view: system_info {
  derived_table: {
    sql:
        select
          rdg_id
          ,timestamp
          ,cast(json_extract_scalar(extra_json, "$.systemMemorySize") as int64) system_memory_size
          ,cast(json_extract_scalar(extra_json, "$.graphicsMemorySize") as int64) graphics_memory_size
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
  dimension: system_memory_size {
    type: number
  }
  dimension: graphics_memory_size {
    type: number
  }
  dimension: system_memory_size_interval_02 {
    label: "System Memory - 500MB Tiers"
    type: tier
    tiers: [0,500,1000,1500,2000,2500,3000,3500,4000,4500,5000,5500,6000,6500,7000,7500,8000,8500,9000,9500,10000]
    style: integer
    sql: ${TABLE}.system_memory_size ;;
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
    sql: ${system_memory_size} ;;
  }
  measure: system_memory_125 {
    group_label: "System Memory"
    label: "System Memory - 12.5%"
    type: percentile
    percentile: 12.5
    sql: ${system_memory_size} ;;
  }
  measure: system_memory_25 {
    group_label: "System Memory"
    label: "System Memory - 25%"
    type: percentile
    percentile: 25
    sql: ${system_memory_size} ;;
  }
  measure: system_memory_375 {
    group_label: "System Memory"
    label: "System Memory - 37.5%"
    type: percentile
    percentile: 37.5
    sql: ${system_memory_size} ;;
  }
  measure: system_memory_med {
    group_label: "System Memory"
    label: "System Memory - Median"
    type: median
    sql: ${system_memory_size} ;;
  }
  measure: system_memory_625 {
    group_label: "System Memory"
    label: "System Memory - 62.5%"
    type: percentile
    percentile: 62.5
    sql: ${system_memory_size} ;;
  }
  measure: system_memory_75 {
    group_label: "System Memory"
    label: "System Memory - 75%"
    type: percentile
    percentile: 75
    sql: ${system_memory_size} ;;
  }
  measure: system_memory_875 {
    group_label: "System Memory"
    label: "System Memory - 87.5%"
    type: percentile
    percentile: 87.5
    sql: ${system_memory_size} ;;
  }
  measure: system_memory_975 {
    group_label: "System Memory"
    label: "System Memory - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${system_memory_size} ;;
  }
}
