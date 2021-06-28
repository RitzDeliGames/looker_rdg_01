view: user_activity {
# this is used to build the retention datasets. at the grain of user and day
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp_trunc(timestamp,day) activity
        ,timestamp_trunc(datetime(timestamp,'US/Pacific'),day) activity_pst
      from `eraser-blast.game_data.events`
      where created_at >= '2019-01-01'
      and user_type = 'external'
      and rdg_id not in ('accf512f-6b54-4275-95dd-2b0dd7142e9e')
      group by 1,2,3
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
    partition_keys: ["activity"]
  }
  dimension: primary_key {
    type: string
    primary_key: yes
    sql: cast(format_date("%Y%m%d",${activity_date}) as string) || '_' || ${rdg_id} ;;
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    hidden: yes
  }
  dimension_group: activity {
    type: time
    timeframes: [
      date,
      hour_of_day,
      month,
      quarter,
      year
    ]
  }
  dimension_group: activity_pst {
    datatype: datetime
    type: time
    timeframes: [
      date,
      month,
      quarter,
      year
    ]
  }
  dimension: days_since_created {
    type: number
    sql: date_diff(${activity_date},${user_retention.created_date},day) ;;
  }
  dimension: days_since_created_pst {
    type: number
    sql: date_diff(${activity_pst_date},${user_retention.created_pst_date},day) ;;
  }
  dimension: retention_days_cohort {
    type: string
    sql: 'D' || cast((${days_since_created} + 1) as string) ;;
    order_by_field: days_since_created
  }
  dimension: retention_days_cohort_pst {
    type: string
    sql: 'D' || cast((${days_since_created_pst} + 1) as string) ;;
    order_by_field: days_since_created_pst
  }
  measure: active_user_count {
    type: count_distinct
    sql: ${rdg_id} ;;
  }
}
