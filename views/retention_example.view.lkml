view: retention_example {
  derived_table: {
    sql:
    WITH
      cohort AS (SELECT * FROM ${cohort.SQL_TABLE_NAME}),
      data AS (SELECT * FROM ${data.SQL_TABLE_NAME}),
      day_list AS (SELECT * FROM ${day_list.SQL_TABLE_NAME})

    SELECT
      cohort.user_id
      , cohort.signup_day
      , data.event_day
      , day_list.activity_day
      , data.unique_events
    FROM
      cohort
    CROSS JOIN day_list
    LEFT JOIN data
      ON data.user_id = cohort.user_id
      AND day_list.activity_day = data.event_day

      WHERE 1=1
        AND activity_day >= signup_day
       ;;
  }

  measure: count {
    type: count
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: signup_day {
    type: time
    sql: cast(${TABLE}.signup_day as timestamp)  ;;
  }

  dimension_group: event_day {
    type: time
    sql: cast(${TABLE}.event_day  as timestamp) ;;
  }

  dimension_group: diff  {
    type: duration
    sql_start: cast(${signup_day_raw} as timestamp) ;;
    sql_end: cast(${activity_day_raw} as timestamp) ;;
  }

  dimension_group: activity_day {
    label: "for fan out"
    type: time
    sql: ${TABLE}.activity_day ;;
  }

  dimension: unique_events {
    type: number
    sql: ${TABLE}.unique_events ;;
  }

  measure: total_events {
    type: sum
    sql: ${unique_events} ;;
  }

  measure: total_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: total_active_users {
    type: count_distinct
    sql: ${user_id} ;;
    filters: [event_day_date: "-NULL"]
  }

  measure: percent_of_cohort_active {
    type: number
    value_format_name: percent_1
    sql: 1.0 * ${total_active_users} / nullif(${total_users},0) ;;
  }
}

view: cohort {
  derived_table: {
    #datagroup_trigger: change_at_midnight
    explore_source: events {
      timezone: query_timezone
      column: signup_day { field: events.user_first_seen_date }
      column: user_id {}
      filters: {
        field: events.user_type
        value: "external"
      }
      bind_filters: {
        from_field: events.payer
        to_field: events.payer
      }
      bind_filters: {
        from_field: events.country
        to_field: events.country
      }
      bind_filters: {
        from_field: events.game_version
        to_field: events.game_version
      }
    }
  }
  dimension: signup_day {
    convert_tz: yes
    type: date
  }
  dimension: user_id {}
}

view: day_list {
  derived_table: {
    #datagroup_trigger: change_at_midnight
    explore_source: events {
      timezone: query_timezone

      column: activity_day { field:events.event_date}
      filters: {
        field: events.user_type
        value: "external"
      }
    }
  }
  dimension: activity_day {
    type: date
  }
}

view: data {
  derived_table: {
    #datagroup_trigger: change_at_midnight
    explore_source: events {
      timezone: query_timezone

      column: user_id {}
      column: unique_events { field:events.count_unique_person_id }
      column: event_day { field:events.event_date}
      filters: {
        field: events.user_type
        value: "external"
      }
      bind_filters: {
        from_field: events.payer
        to_field: events.payer
      }
      bind_filters: {
        from_field: events.country
        to_field: events.country
      }
      bind_filters: {
        from_field: events.game_version
        to_field: events.game_version
      }
    }
  }
  dimension: user_id {}
  dimension: unique_events {
    type: number
  }
  dimension: event_day {
    type: date
  }
}

# view: retention_example {
#   derived_table: {
#     sql: with cohort as (
#       SELECT
#           events.user_id AS user_id ,
#           DATETIME_TRUNC(CAST(created_at AS DATETIME), day) AS signup_day
#       FROM `eraser-blast.game_data.events` EVENTS
#       WHERE
#       {% condition events.payer %} events.payer {% endcondition %}
#       AND {% condition events.country %} events.country {% endcondition %}
#       AND {% condition events.game_version %} events.version {% endcondition %}
#       AND {% condition events.device_os_version %}
#       CASE
#           WHEN events.platform LIKE '%iOS 13%' THEN 'iOS 13'
#           WHEN events.platform LIKE '%iOS 12%' THEN 'iOS 12'
#           WHEN events.platform LIKE '%iOS 11%' THEN 'iOS 11'
#           WHEN events.platform LIKE '%iOS 10%' THEN 'iOS 10'
#           WHEN events.platform LIKE '%iOS 10%' THEN 'iOS 10'
#           WHEN events.platform LIKE '%Android OS 10%' THEN 'Android 10'
#           WHEN events.platform LIKE '%Android OS 9%' THEN 'Android 9'
#           WHEN events.platform LIKE '%Android OS 8%' THEN 'Android 8'
#           WHEN events.platform LIKE '%Android OS 7%' THEN 'Android 7'
#         END {% endcondition %}
#       AND {% condition events.device_platform %} CASE
#           WHEN events.platform LIKE '%iOS%' THEN 'Apple'
#           WHEN events.platform LIKE '%Android%' THEN 'Google'
#           WHEN events.hardware LIKE '%Chrome%' AND events.user_id LIKE '%facebook%' THEN 'Facebook'
#         END {% endcondition %}
#       AND {% condition events.device_model %} CASE
#           WHEN events.hardware = 'iPhone6,2' THEN 'iPhone 5s Global'
#           WHEN events.hardware = 'iPhone7,1' THEN 'iPhone 6 Plus'
#           WHEN events.hardware = 'iPhone7,2' THEN 'iPhone 6'
#           WHEN events.hardware = 'iPhone8,1' THEN 'iPhone 6s'
#           WHEN events.hardware = 'iPhone8,2' THEN 'iPhone 6s Plus'
#           WHEN events.hardware = 'iPhone8,4' THEN 'iPhone SE GSM'
#           WHEN events.hardware = 'iPhone9,1' THEN 'iPhone 7'
#           WHEN events.hardware = 'iPhone9,2' THEN 'iPhone 7 Plus'
#           WHEN events.hardware = 'iPhone9,3' THEN 'iPhone 7'
#           WHEN events.hardware = 'iPhone9,4' THEN 'iPhone 7 Plus'
#           WHEN events.hardware = 'iPhone10,1' THEN 'iPhone 8'
#           WHEN events.hardware = 'iPhone10,2' THEN 'iPhone 8 Plus'
#           WHEN events.hardware = 'iPhone10,3' THEN 'iPhone X Global'
#           WHEN events.hardware = 'iPhone10,4' THEN 'iPhone 8'
#           WHEN events.hardware = 'iPhone10,5' THEN 'iPhone 8 Plus'
#           WHEN events.hardware = 'iPhone10,6' THEN 'iPhone X GSM'
#           WHEN events.hardware = 'iPhone11,2' THEN 'iPhone XS'
#           WHEN events.hardware = 'iPhone11,4' THEN 'iPhone XS Max'
#           WHEN events.hardware = 'iPhone11,6' THEN 'iPhone XS Max Global'
#           WHEN events.hardware = 'iPhone11,8' THEN 'iPhone XR'
#           WHEN events.hardware = 'iPhone12,1' THEN 'iPhone 11'
#           WHEN events.hardware = 'iPhone12,3' THEN 'iPhone 11 Pro'
#           WHEN events.hardware = 'iPhone12,5' THEN 'iPhone 11 Pro Max'
#           WHEN events.hardware = 'iPhone12,8' THEN 'iPhone SE - 2nd Gen'
#           WHEN events.hardware = 'iPad4,1' THEN 'iPad Air - 1st Gen'
#           WHEN events.hardware = 'iPad5,3' THEN 'iPad Air - 2nd Gen'
#           WHEN events.hardware = 'iPad6,3' THEN 'iPad Pro - 9.7'
#           WHEN events.hardware = 'iPad6,7' THEN 'iPad Pro - 12.9'
#           WHEN events.hardware = 'iPad7,5' THEN 'iPad - 6th Gen'
#           WHEN events.hardware = 'iPad7,11' THEN 'iPad - 7th Gen - 10.2'
#           WHEN events.hardware = 'iPad8,11' THEN 'iPad Pro - 4th Gen - 12.9'
#           WHEN events.hardware = 'iPad11,3' THEN 'iPad Air - 3rd Gen'
#           WHEN events.hardware = 'samsung SM-A102U' THEN 'Samsung Galaxy A10'
#           WHEN events.hardware = 'samsung SM-S102DL' THEN 'Samsung Galaxy A10'
#           WHEN events.hardware = 'samsung SM-A205U' THEN 'Samsung Galaxy A20'
#           WHEN events.hardware = 'samsung SM-A505G' THEN 'Samsung Galaxy A50'
#           WHEN events.hardware = 'samsung SM-A505U' THEN 'Samsung Galaxy A50'
#           WHEN events.hardware = 'samsung SM-M305F' THEN 'Samsung Galaxy M30'
#           WHEN events.hardware = 'samsung SM-G935U' THEN 'Samsung Galaxy S7'
#           WHEN events.hardware = 'samsung SM-G930V' THEN 'Samsung Galaxy S7'
#           WHEN events.hardware = 'samsung SM-G950F' THEN 'Samsung Galaxy S8'
#           WHEN events.hardware = 'samsung SM-G950U' THEN 'Samsung Galaxy S8'
#           WHEN events.hardware = 'samsung SM-G955U' THEN 'Samsung Galaxy S8+'
#           WHEN events.hardware = 'samsung SM-G960U1' THEN 'Samsung Galaxy S9'
#           WHEN events.hardware = 'samsung SM-G960U' THEN 'Samsung Galaxy S9'
#           WHEN events.hardware = 'samsung SM-G965U' THEN 'Samsung Galaxy S9+'
#           WHEN events.hardware = 'samsung SM-G973U' THEN 'Samsung Galaxy S10'
#           WHEN events.hardware = 'samsung SM-G970U' THEN 'Samsung Galaxy S10'
#           WHEN events.hardware = 'samsung SM-G981U' THEN 'Samsung Galaxy S20'
#           WHEN events.hardware = 'samsung SM-G986U' THEN 'Samsung Galaxy S20+'
#           WHEN events.hardware = 'samsung SM-J337AZ' THEN 'Samsung Galaxy J3'
#           WHEN events.hardware = 'samsung SM-J400M' THEN 'Samsung Galaxy J4'
#           WHEN events.hardware = 'samsung SM-J737T1' THEN 'Samsung Galaxy J7'
#           WHEN events.hardware = 'samsung SM-N950U' THEN 'Samsung Galaxy Note8'
#           WHEN events.hardware = 'samsung SM-N960U' THEN 'Samsung Galaxy Note9'
#           WHEN events.hardware = 'samsung SM-N960U1' THEN 'Samsung Galaxy Note9'
#           WHEN events.hardware = 'samsung SM-N975U' THEN 'Samsung Galaxy Note10+'
#           WHEN events.hardware = 'samsung SM-N975U1' THEN 'Samsung Galaxy Note10+'
#           WHEN events.hardware = 'samsung SM-T560NU' THEN 'Samsung Galaxy Tab 9.6'
#           WHEN events.hardware = 'motorola Moto G (5) Plus' THEN 'Motorola Moto G5 Plus'
#           WHEN events.hardware = 'LGE LG-LS777' THEN 'LGE Stylo 3'
#           WHEN events.hardware = 'LGE LGMP450' THEN 'LGE Stylo Plus'
#           WHEN events.hardware = 'LGE LM-X410(FG)' THEN 'LGE K30'
#           WHEN events.hardware = 'LGE LGLK430' THEN 'LGE G Pad'
#           WHEN events.hardware = 'Umx U693CL' THEN 'Assurance Wireless - Unimax 693CL'
#           WHEN events.hardware = 'ANS L51' THEN 'Assurance Wireless - ANS L51'
#           WHEN events.hardware = 'Yulong cp3705A' THEN 'Yulong Coolpad 3705A'
#           ELSE events.hardware
#         END {% endcondition %}
#
#
#       and REPLACE(JSON_EXTRACT(extra_json,"$.current_FueStep"),'"','') = "FIRST_PLAY"),
#
#       data as (
#       SELECT user_id,
#             DATETIME_TRUNC(CAST(TIMESTAMP AS DATETIME), day) event_day,
#             COUNT( distinct event_name) AS unique_events
#         FROM `eraser-blast.game_data.events`
#         GROUP BY 1,2
#       ),
#
#       day_list as (
#       SELECT DISTINCT(DATETIME_TRUNC(CAST(TIMESTAMP AS DATETIME), day)) AS activity_day
#
#           FROM `eraser-blast.game_data.events`
#       )
#
#       select
#       cohort.user_id
#       , cohort.signup_day
#       , data.event_day
#       , day_list.activity_day
#       , data.unique_events
#       from
#       cohort
#       cross join day_list
#       left join data on data.user_id = cohort.user_id
#                 and day_list.activity_day = data.event_day
#
#
#
#       WHERE 1=1
#       and activity_day >= signup_day
#        ;;
#   }
#
#   measure: count {
#     type: count
#   }
#
#   dimension: user_id {
#     type: string
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension_group: signup_day {
#     type: time
#     sql: cast(${TABLE}.signup_day as timestamp)  ;;
#   }
#
#   dimension_group: event_day {
#     type: time
#     sql: cast(${TABLE}.event_day  as timestamp) ;;
#   }
#
#   dimension_group: diff  {
#     type: duration
#     sql_start: cast(${signup_day_raw} as timestamp) ;;
#     sql_end: cast(${activity_day_raw} as timestamp) ;;
#   }
#
#   dimension_group: activity_day {
#     type: time
#     sql: ${TABLE}.activity_day ;;
#   }
#
#   dimension: unique_events {
#     type: number
#     sql: ${TABLE}.unique_events ;;
#   }
#
#   measure: total_users {
#     type: count_distinct
#     sql: ${user_id} ;;
#   }
#
#   measure: total_active_users {
#     type: count_distinct
#     sql: ${user_id} ;;
# #     filters: [unique_events: ">0"]
#   }
#
#   measure: percent_of_cohort_active {
#     type: number
#     value_format_name: percent_1
#     sql: 1.0 * ${total_active_users} / nullif(${total_users},0) ;;
#   }
# }
