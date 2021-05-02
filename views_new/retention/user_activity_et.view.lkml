view: user_activity_engagement_min {
  derived_table: {
    sql:
      select
        rdg_id user_id
        ,timestamp_trunc(timestamp,day) activity
        ,engagement_ticks
      from `eraser-blast.game_data.events`
      where created_at >= '2019-01-01'
      and user_type = 'external'
      and rdg_id not in ('accf512f-6b54-4275-95dd-2b0dd7142e9e')
      group by 1,2,3
    ;;
    #datagroup_trigger: default_datagroup
    publish_as_db_view: yes
    #partition_keys: ["activity"]
  }
  dimension: primary_key {
    type: string
    primary_key: yes
    sql: cast(${engagement_min} as string) || '_' || ${user_id} ;;
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
  dimension: engagement_min {
    label: "Minutes Played"
    type: number
    sql: ${TABLE}.engagement_ticks / 2 ;;
  }
  # dimension: days_since_created {
  #   type: number
  #   sql: date_diff(${activity_date},${user_retention.created_date},day) ;;
  # }
  dimension: engagement_min_cohort {
    label: "Minutes Played Cohort"
    type: string
    sql: 'MP' || cast((${engagement_min}) as string) ;;
    order_by_field: engagement_min
  }
  measure: active_user_count {
    type: count_distinct
    sql: ${user_id} ;;
  }
}
