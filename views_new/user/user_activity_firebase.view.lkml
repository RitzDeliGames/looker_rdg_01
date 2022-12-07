view: user_activity_firebase {
# This is used to build the retention datasets using Firebase data at the grain of user and day.
  derived_table: {
    sql:
      select
        user_id
        ,timestamp_micros(user_first_touch_timestamp) created_at
        ,datetime(timestamp_micros(user_first_touch_timestamp),"America/Los_Angeles") created_at_pst
        ,timestamp_micros(event_timestamp) activity
        ,datetime(timestamp_micros(event_timestamp),"America/Los_Angeles") activity_pst
        ,event_name
      from `eraser-blast.analytics_215101505.events_*`
      where _TABLE_SUFFIX between FORMAT_DATE('%Y%m%d',{% date_start date_filter %}) and FORMAT_DATE('%Y%m%d',{% date_end date_filter %})
      group by 1,2,3,4,5,6
    ;;
  }

  filter: date_filter {
    description: "Choose a date range to query multiple partitioned Firebase tables as needed"
    type: date
  }
  dimension: primary_key {
    hidden: yes
    type: string
    primary_key: yes
    sql: cast(format_date("%Y%m%d",${activity_date}) as string) || '_' || ${user_id} ;;
  }
  dimension: user_id {
    type: string
    hidden: no
  }
  dimension: event_name {}
  dimension_group: activity {
    datatype: timestamp
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
  dimension_group: activity_pst {
    datatype: datetime
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
  dimension_group: created_at {
    datatype: timestamp
    type: time
    timeframes: [
      time
      ,hour_of_day
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]
  }
  dimension_group: created_at_pst {
    datatype: datetime
    type: time
    timeframes: [
      time
      ,hour_of_day
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]
  }

  dimension: days_since_created {
    type: number
    sql: date_diff(${activity_date},${created_at_date},day) ;; #for some reason this will not work when grabbing from the firebase explore
  }
  dimension: days_since_created_pst {
    type: number
    sql: date_diff(${activity_pst_date},${created_at_pst_date},day) ;; #for some reason this will not work when grabbing from the firebase explore
  }
  dimension: retention_days_cohort {
    type: string
    sql: 'D' || cast((${days_since_created} + 1) as string) ;;
    order_by_field: days_since_created
  }
  dimension: retention_days_cohort_pst {
    type: string
    sql: 'D' || cast((${days_since_created_pst} + 1) as string) ;;
    order_by_field: days_since_created
  }
  measure: active_user_count {
    type: count_distinct
    sql: ${user_id} ;;
  }
  drill_fields: [user_id,created_at_date,activity_date]
}
