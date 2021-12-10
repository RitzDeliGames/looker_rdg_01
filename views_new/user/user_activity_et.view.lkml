view: user_activity_engagement_min {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp_trunc(timestamp,day) activity
        ,engagement_ticks
      from `eraser-blast.game_data.events`
      where created_at >= '2019-01-01'
      and user_type = 'external'
      and rdg_id not in ('accf512f-6b54-4275-95dd-2b0dd7142e9e')
      group by 1,2,3
    ;;
    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
    #partition_keys: ["activity"]
  }
  dimension: primary_key {
    type: string
    primary_key: yes
    sql: cast(${engagement_min} as string) || '_' || ${rdg_id} ;;
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
  dimension: engagement_min_cohort {
    label: "Minutes Played Cohort"
    type: string
    sql: 'MP' || cast((${engagement_min}) as string) ;;
    order_by_field: engagement_min
  }
  dimension: engagement_2_min_interval {
    label: "Minutes Played - 2 Min Tiers"
    type: tier
    tiers: [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60]
    style: integer
    sql: ${engagement_min} ;;
  }
  dimension: engagement_min_interval {
    label: "Minutes Played - 5 Min Tiers"
    type: tier
    tiers: [0,5,10,15,20,25,30,35,40,45,50,55,60,65]
    style: integer
    sql: ${engagement_min} ;;
  }
  dimension: engagement_15_min_interval {
    label: "Minutes Played - 15 Min Tiers"
    type: tier
    tiers: [0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,225,240]
    style: integer
    sql: ${engagement_min} ;;
  }
  measure: active_user_count {
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: engagement_min_max {
    label: "Max Minutes Played"
    type: max
    sql: ${engagement_min} ;;
  }
}
