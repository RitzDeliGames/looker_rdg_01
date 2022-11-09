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
}
