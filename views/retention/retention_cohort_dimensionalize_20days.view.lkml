include: "/views/**/events.view"


view: retention_cohort_dimensionalize_20days {
  extends: [events]

  derived_table: {
    sql: WITH cohort AS (SELECT
  TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_TRUNC(CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')) AS TIMESTAMP), DAY)), 'America/Los_Angeles') AS signup_day,
  events.user_id  AS user_id
FROM `eraser-blast.game_data.events` AS events

WHERE (events.user_type = 'external') AND (user_type NOT IN ("internal_editor", "unit_test"))
GROUP BY 1,2)
  ,  data AS (SELECT
  events.user_id  AS user_id,
  TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_TRUNC(CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp , 'America/Los_Angeles')) AS TIMESTAMP), DAY)), 'America/Los_Angeles') AS event_day,
  COUNT(DISTINCT events.user_id ) AS unique_events
FROM `eraser-blast.game_data.events` AS events

WHERE (events.user_type = 'external') AND (user_type NOT IN ("internal_editor", "unit_test"))
GROUP BY 1,2)
  ,  day_list AS (SELECT
  TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_TRUNC(CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp , 'America/Los_Angeles')) AS TIMESTAMP), DAY)), 'America/Los_Angeles') AS activity_day
FROM `eraser-blast.game_data.events` AS events

WHERE (events.user_type = 'external') AND (user_type NOT IN ("internal_editor", "unit_test"))
GROUP BY 1)
  ,  retention AS (WITH
      cohort AS (SELECT * FROM cohort),
      data AS (SELECT * FROM data),
      day_list AS (SELECT * FROM day_list)

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
       )
SELECT
  CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', cast(retention.signup_day as timestamp)  , 'America/Los_Angeles')) AS DATE) AS retention_signup_day_date,
  CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', cast(retention.activity_day as timestamp) , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', cast((cast(retention.signup_day as timestamp)) as timestamp) , 'America/Los_Angeles')), DAY) AS INT64) AS retention_days_diff,
  experiments,
  1.0 * (COUNT(DISTINCT CASE WHEN (cast(retention.event_day  as timestamp)  IS NOT NULL) THEN retention.user_id  ELSE NULL END)) / nullif((COUNT(DISTINCT retention.user_id )),0)  AS retention_percent_of_cohort_active
FROM `eraser-blast.game_data.events` AS events
LEFT JOIN retention ON events.user_id = retention.user_id
                and (CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')) AS DATE)) = (CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', cast(retention.signup_day as timestamp)  , 'America/Los_Angeles')) AS DATE))

WHERE ((CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', cast(retention.activity_day as timestamp) , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', cast((cast(retention.signup_day as timestamp)) as timestamp) , 'America/Los_Angeles')), DAY) AS INT64) <= 20)) AND (user_type NOT IN ("internal_editor", "unit_test"))
GROUP BY 1,2,3
       ;;
  }


  dimension: retention_signup_day_date {
    group_label: "retention_cohort_20days"
    type: date
    datatype: date
    sql: ${TABLE}.retention_signup_day_date ;;
  }

  dimension: retention_days_diff {
    group_label: "retention_cohort_20days"
    type: number
    sql: ${TABLE}.retention_days_diff ;;
  }

  # dimension: events_variants {
  #   type: string
  #   sql: ${TABLE}.events_variants ;;
  # }

  dimension: retention_percent_of_cohort_active {
    group_label: "retention_cohort_20days"
    type: number
    sql: ${TABLE}.retention_percent_of_cohort_active ;;
  }

  dimension: retention_total_users {
    group_label: "retention_cohort_20days"
    type: number
    sql: ${TABLE}.retention_total_users ;;
  }

  dimension: experiments {
    group_label: "retention_cohort_20days"
    type: string
    sql: ${TABLE}.experiments ;;
  }

  dimension: events_variants {
    group_label: "retention_cohort_20days"
    type: string
    sql: REPLACE(@{variant_ids},'"','') ;;
  }

  # MEASURES
  measure: 1_min_ {
    group_label: "measures_retention_cohort_20days"
    type: min
    value_format_name: percent_1
    sql: ${retention_percent_of_cohort_active} ;;
  }

  measure: 5_max_ {
    group_label: "measures_retention_cohort_20days"
    type: max
    value_format_name: percent_1
    sql: ${retention_percent_of_cohort_active} ;;
  }

  measure: 3_median_ {
    group_label: "measures_retention_cohort_20days"
    type: median
    value_format_name: percent_1
    sql: ${retention_percent_of_cohort_active} ;;
  }

  measure: 2_25th_ {
    group_label: "measures_retention_cohort_20days"
    type: percentile
    percentile: 25
    value_format_name: percent_1
    sql: ${retention_percent_of_cohort_active} ;;
  }

  measure: 4_75th_ {
    group_label: "measures_retention_cohort_20days"
    type: percentile
    percentile: 75
    value_format_name: percent_1
    sql: ${retention_percent_of_cohort_active} ;;
  }

  measure: count {
    group_label: "measures_retention_cohort_20days"
    type: count
    drill_fields: [detail*]
  }

  set: detail {
    fields: [retention_signup_day_date, retention_days_diff, events_variants, retention_percent_of_cohort_active, retention_total_users]
  }
}
