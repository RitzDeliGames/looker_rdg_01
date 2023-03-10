view: user_activity {
# this is used to build the retention datasets. at the grain of user and day
  derived_table: {
    sql:
      select
        rdg_id
        ,user_id
        ,timestamp_trunc(timestamp,day) activity
        ,max(cast(last_level_serial as int64)) last_level_serial
      from `eraser-blast.game_data.events`
      where date(created_at) between '2019-01-01' and current_date()
        and date(timestamp) between '2019-01-01' and current_date()
        and user_type = 'external'
      group by 1,2,3
    ;;
    datagroup_trigger: change_at_midnight
    publish_as_db_view: yes
    partition_keys: ["activity"]
  }
  dimension: primary_key {
    type: string
    primary_key: yes
    sql: cast(format_date("%Y%m%d",${activity_date}) as string) || '_' || ${rdg_id} ;;
    hidden: no
  }
  dimension: rdg_id {
    type: string
    hidden: no
  }
  dimension: user_id {
    type: string
    hidden: no
  }
  dimension_group: activity {
    type: time
    timeframes: [
      date
      ,hour_of_day
      ,week
      ,month
      ,quarter
      ,year
    ]
  }
  dimension: days_since_created {
    group_label: "Since Created"
    label: "Days Since Created"
    type: number
    sql: date_diff(${activity_date},${user_retention.created_date},day) ;;
  }
  dimension: weeks_since_created {
    group_label: "Since Created"
    label: "Weeks Since Created"
    type: number
    sql: date_diff(${activity_date},${user_retention.created_date},week) ;;
  }
  dimension: retention_days_cohort {
    type: string
    sql: 'D' || cast((${days_since_created} + 1) as string) ;;
    order_by_field: days_since_created
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
  }
  dimension: last_level_serial_offset {
    group_label: "Level Dimensions"
    label: "Current Level"
    type: number
    sql: ${last_level_serial} + 1 ;;
  }
  measure: active_user_count {
    label: "Active Players (RDG Ids)"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: active_user_count_user_id {
    label: "Active Players (User Ids)"
    type: count_distinct
    sql: ${user_id} ;;
  }
  measure:  days_since_created_025 {
    group_label: "Days Played"
    label: "Days Played - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${days_since_created} ;;
  }
  measure:  days_since_created_25 {
    group_label: "Days Played"
    label: "Days Played - 25%"
    type: percentile
    percentile: 25
    sql: ${days_since_created} ;;
  }
  measure:  days_since_created_med {
    group_label: "Days Played"
    label: "Days Played - Median"
    type: median
    sql: ${days_since_created} ;;
  }
  measure:  days_since_created_75 {
    group_label: "Days Played"
    label: "Days Played - 75%"
    type: percentile
    percentile: 75
    sql: ${days_since_created} ;;
  }
  measure:  days_since_created_975 {
    group_label: "Days Played"
    label: "Days Played - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${days_since_created} ;;
  }
  measure: last_level_completed_025 {
    group_label: "Level Measures"
    label: "Levels Completed - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_10 {
    group_label: "Level Measures"
    label: "Levels Completed - 10%"
    type: percentile
    percentile: 10
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_25 {
    group_label: "Level Measures"
    label: "Levels Completed - 25%"
    type: percentile
    percentile: 25
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_med {
    group_label: "Level Measures"
    label: "Levels Completed - Median"
    type: median
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_75 {
    group_label: "Level Measures"
    label: "Levels Completed - 75%"
    type: percentile
    percentile: 75
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_90 {
    group_label: "Level Measures"
    label: "Levels Completed - 90%"
    type: percentile
    percentile: 90
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_975 {
    group_label: "Level Measures"
    label: "Levels Completed - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${last_level_serial} ;;
  }
  drill_fields: [rdg_id,days_since_created,user_retention.days_played_past_week]
}