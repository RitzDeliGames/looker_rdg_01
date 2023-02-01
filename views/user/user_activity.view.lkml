view: user_activity {
# this is used to build the retention datasets. at the grain of user and day
  derived_table: {
    sql:
      select
        rdg_id
        ,user_id
        ,timestamp_trunc(timestamp,day) activity
      from `eraser-blast.game_data.events`
      where date(created_at) between '2019-01-01' and current_date()
        and date(timestamp) between '2019-01-01' and current_date()
        and user_type = 'external'
      group by 1,2,3
    ;;
    datagroup_trigger: change_6_hrs
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
    type: number
    sql: date_diff(${activity_date},${user_retention.created_date},day) ;;
  }
  dimension: retention_days_cohort {
    type: string
    sql: 'D' || cast((${days_since_created} + 1) as string) ;;
    order_by_field: days_since_created
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

  drill_fields: [rdg_id,days_since_created,user_retention.days_played_past_week]
}
