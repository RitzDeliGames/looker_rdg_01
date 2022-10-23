view: performance_score {
  derived_table: {
    sql:
        select
          rdg_id
          ,timestamp
          ,last_level_serial
          ,cast(json_extract_scalar(extra_json, "$.rendering_performance_score") as int64) rendering_performance_score
        from `eraser-blast.game_data.events`
        where timestamp >= '2022-06-01'
          and user_type = 'external'
          and country != 'ZZ'
        and event_name = 'TitleScreenAwake'
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
  dimension: last_level_serial {
    label: "Last Level Played"
    type: number
  }
  dimension: rendering_performance_score {
    type: number
  }
  dimension: rendering_performance_score_interval_02 {
    label: "Rendering Performance Score - 2 Unit Tiers"
    type: tier
    tiers: [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100]
    style: integer
    sql: ${rendering_performance_score} ;;
  }
  dimension: rendering_performance_score_interval_05 {
    label: "Rendering Performance Score - 5 Unit Tiers"
    type: tier
    tiers: [0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100]
    style: integer
    sql: ${rendering_performance_score} ;;
  }
  dimension: rendering_performance_score_interval_10 {
    label: "Rendering Performance Score - 10 Unit Tiers"
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80,90,100]
    style: integer
    sql: ${rendering_performance_score} ;;
  }
  dimension: rendering_performance_score_interval_15 {
    label: "Rendering Performance Score - 15 Unit Tiers"
    type: tier
    tiers: [0,15,30,45,60]
    style: integer
    sql: ${rendering_performance_score} ;;
  }
  dimension: rendering_performance_score_interval_30 {
    label: "Rendering Performance Score - 30 Unit Tiers"
    type: tier
    tiers: [0,30,60]
    style: integer
    sql: ${rendering_performance_score} ;;
  }
  measure: count {
    label: "Count of Players"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: rendering_performance_score_025 {
    group_label: "Rendering Performance Score"
    label: "Rendering Performance Score - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${rendering_performance_score} ;;
  }
  measure: rendering_performance_score_25 {
    group_label: "Rendering Performance Score"
    label: "Rendering Performance Score - 25%"
    type: percentile
    percentile: 25
    sql: ${rendering_performance_score} ;;
  }
  measure: rendering_performance_score_med {
    group_label: "Rendering Performance Score"
    label: "Rendering Performance Score - Median"
    type: median
    sql: ${rendering_performance_score} ;;
  }
  measure: rendering_performance_score_75 {
    group_label: "Rendering Performance Score"
    label: "Rendering Performance Score - 75%"
    type: percentile
    percentile: 75
    sql: ${rendering_performance_score} ;;
  }
  measure: rendering_performance_score_975 {
    group_label: "Rendering Performance Score"
    label: "Rendering Performance Score - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${rendering_performance_score} ;;
  }
}
