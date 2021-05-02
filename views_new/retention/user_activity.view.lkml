view: user_activity {
  derived_table: {
    sql:
      select
        rdg_id user_id,
        timestamp_trunc(timestamp,day) activity
      from `eraser-blast.game_data.events`
      where created_at >= '2019-01-01'
      and user_type = 'external'
      and rdg_id not in ('accf512f-6b54-4275-95dd-2b0dd7142e9e')
      group by 1,2
    ;;
    datagroup_trigger: change_at_midnight
    publish_as_db_view: yes
    partition_keys: ["activity"]
  }
  dimension: primary_key {
    type: string
    primary_key: yes
    sql: cast(format_date("%Y%m%d",${activity_date}) as string) || '_' || ${user_id} ;;
    hidden: yes
  }
  dimension: user_id {
    type: string
    hidden: yes
  }
  dimension_group: activity {
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
  dimension: retention_days_cohort {
    type: string
    sql: 'D' || cast((${days_since_created} + 1) as string) ;;
    order_by_field: days_since_created
  }
  measure: active_user_count {
    type: count_distinct
    sql: ${user_id} ;;
  }
}
