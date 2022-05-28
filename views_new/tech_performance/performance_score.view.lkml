view: performance_score {
  derived_table: {
    sql:
        select
          rdg_id
          ,timestamp
          ,cast(json_extract_scalar(extra_json, "$.rendering_performance_score") as int64) rendering_performance_score
        from `eraser-blast.game_data.events`
        where timestamp >= '2019-01-01'
          and user_type = 'external'
          and country != 'ZZ'
        and event_name = 'TitleScreenAwake'
    ;;

    datagroup_trigger: change_8_hrs
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
  dimension: rendering_performance_score {
    type: number
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
