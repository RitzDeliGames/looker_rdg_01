view: retention {
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
      timezone: UTC
      column: signup_day { field: events.user_first_seen_date }
      column: user_id {}
      bind_filters: {
        from_field: events.payer
        to_field: events.payer
      }
      bind_filters: {
        from_field: events.country
        to_field: events.country
      }
      bind_filters: {
        from_field: events.release_version
        to_field: events.release_version
      }
      bind_filters: {
        from_field: events.release_version_minor
        to_field: events.release_version_minor
      }
      bind_filters: {
        from_field: events.event_date
        to_field: events.event_date
      }

       #add aditional filters/dimensions here
    }
  }
  dimension: signup_day {
    convert_tz: no
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
      bind_filters: {
        from_field: events.payer
        to_field: events.payer
      }
      bind_filters: {
        from_field: events.country
        to_field: events.country
      }
      bind_filters: {
        from_field: events.release_version
        to_field: events.release_version
      }
      bind_filters: {
        from_field: events.release_version_minor
        to_field: events.release_version_minor
      }
      bind_filters: {
        from_field: events.event_date
        to_field: events.event_date
      }

      #add aditional filters/dimensions here
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
