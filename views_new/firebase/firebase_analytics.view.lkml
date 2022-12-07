view: firebase_analytics {
  derived_table: {
    sql: select distinct
                user_pseudo_id
                ,user_id
                ,device.advertising_id advertising_id
                ,user_first_touch_timestamp
                ,timestamp_micros(user_first_touch_timestamp) created_at
                ,event_name
                ,timestamp_micros(event_timestamp) activity
          from `eraser-blast.analytics_215101505.events_*`
         where _TABLE_SUFFIX between FORMAT_DATE('%Y%m%d',{% date_start date_filter %}) and FORMAT_DATE('%Y%m%d',{% date_end date_filter %}) ;;
  }

  ### FILTERS ###

  filter: date_filter {
    description: "Choose a date range to query multiple partitioned Firebase tables as needed"
    type: date
  }

  ### PRIMARY KEY ###

  dimension: primary_key {
    hidden: yes
    type: string
    primary_key: yes
    sql: ${user_pseudo_id} || ${event_name} || ${activity_raw} ;;
  }

  ### DIMENSIONS ###

  # dimension: days_since_created {
  #   type: number
  #   sql: round(cast((${event_timestamp}/(86400000000)) - (${user_first_touch_timestamp}/(86400000000)) as int64),0) ;;
  # }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }
  # dimension: user_first_touch_timestamp {
  #   description: "The time (in microseconds) at which the user first opened the app or visited the site."
  #   type: number
  #   sql: ${TABLE}.user_first_touch_timestamp ;;
  # }

  dimension_group: created_at {
    #datatype: epoch
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
  dimension_group: activity {
    type: time
    timeframes: [
      raw
      ,hour_of_day
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]
    sql: ${TABLE}.activity ;;
  }
  dimension: user_id {
    description: "The user ID set via the setUserId API."
    group_label: "Player IDs"
    label: "Firebase Psuedo Id"
    type: string
    sql:${TABLE}.user_id ;;
  }
  dimension: user_pseudo_id {
    description: "The pseudonymous id (e.g., app instance ID) for the user."
    group_label: "Player IDs"
    label: "Firebase Psuedo Id"
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
  }
  dimension: advertising_id {
    #description: "The user ID set via the setUserId API."
    group_label: "Player IDs"
    label: "Firebase Psuedo Id"
    type: string
    sql:${TABLE}.advertising_id ;;
  }

  ### MEASURES ###

  measure: count {
    hidden: yes
    description: "Count of Rows"
    type: count
  }
  measure: total_firebase_users {
    description: "Distinct count of User Pseudo IDs"
    label: "Count of Firebase Pseudo IDs"
    type: count_distinct
    sql: ${user_pseudo_id} ;;
  }
  measure: total_user_ids {
    description: "Distinct count of User IDs"
    label: "Count of Firebase User IDs"
    type: count_distinct
    sql: ${user_id} ;;
  }
  measure: total_advertising_ids {
    description: "Distinct count of User IDs"
    label: "Count of Firebase Advertising IDs"
    type: count_distinct
    sql: ${advertising_id} ;;
  }

}
