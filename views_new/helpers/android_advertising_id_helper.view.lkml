view: android_advertising_id_helper {
  derived_table: {
    sql:
      select
        user_first_touch_timestamp
        ,date(timestamp_micros(user_first_touch_timestamp)) as install_date
        ,user_id
        ,device.advertising_id as advertising_id
      from `eraser-blast.analytics_215101505.*`
      where platform = 'ANDROID'
      --and date(timestamp_micros(user_first_touch_timestamp)) >= '2022-04-01'
      --and event_name = 'app_open'
      --and _TABLE_SUFFIX > '202220601'
      group by 1,2,3,4
      ;;

    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
    #partition_keys: ["created"]
  }

  dimension_group: install_date {
    label: "Install Date"
    type: time
    timeframes: [
      date
      ,hour_of_day
      ,week
      ,month
      ,quarter
      ,year
    ]
    sql: timestamp_micros(${TABLE}.user_first_touch_timestamp) ;;
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    sql: ${advertising_id} || '_' || ${user_id} ;;
    hidden: no
  }

  dimension: user_id {}

  dimension:  advertising_id {
    label: "Firebase Ad Id"
  }

  measure: user_id_count {
    label: "Count of User Ids"
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: advertising_id_count {
    label: "Count of Firebase Advertising Ids"
    type: count_distinct
    sql: ${advertising_id} ;;
  }
}
