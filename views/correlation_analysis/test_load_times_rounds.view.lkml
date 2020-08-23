view: test_load_times_rounds {
  derived_table: {
    sql: SELECT session_id,
                user_id,
                TIMESTAMP_DIFF(MAX(timestamp), min(timestamp), MINUTE) AS minutes,
                COUNT(JSON_Value(extra_json, '$.rounds')) AS rounds,
                ROUND(AVG(CAST(JSON_EXTRACT(extra_json, '$.load_time') AS NUMERIC) / 1000), 0) AS avg_load_time_rd_0,
                ROUND(SUM(CAST(JSON_EXTRACT(extra_json, '$.load_time') AS NUMERIC) / 1000), 0) AS sum_load_time_rd_0,

         FROM events
         WHERE event_name IN ('transition', 'cards')
           AND user_type NOT IN ("internal_editor", "unit_test")
           AND user_id <>  "user_id_not_set"
           -- AND (user_type = 'external')
           -- AND user_id IN ('anon-4f450865-8145-4ec0-a2ec-904e4ccb2690', 'facebook-108420860850386')
           -- AND session_id = '32020253-111d-4428-bf88-0965293219c2-07/08/2020 10:34:44'
         GROUP BY session_id, user_id
         ORDER BY avg_load_time_rd_0 ASC
        ;;
  }


  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: minutes {
    type: number
    sql: ${TABLE}.minutes ;;
  }

  dimension: rounds {
    type: number
    sql: ${TABLE}.rounds ;;
  }

  dimension: avg_load_time_rd_0 {
    type: number
    sql: ${TABLE}.avg_load_time_rd_0 ;;
  }

  dimension: sum_load_time_rd_0 {
    type: number
    sql: ${TABLE}.sum_load_time_rd_0 ;;
  }


  # MEASURES

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_unique_person_id {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: avg_rounds {
    type: average
    sql: ROUND(${rounds}, 0) ;;
  }

  measure: sum_total_rounds {
    type: sum
    sql: ROUND(${rounds}, 0) ;;
  }

  measure: avg_time_minutes {
    type: average
    sql: ${minutes} ;;
  }

  measure: sum_total_minutes {
    type: sum
    sql: ROUND(${minutes}, 0) ;;
  }

  measure: avg_sum_load_times {
    type: average
    sql: ROUND(${sum_load_time_rd_0}, 0) ;;
  }



  ########################

  parameter: descriptive_stats_churn {
    type: string
    allowed_value: {
      label: "per minute"
      value: "per minute"
    }
    allowed_value: {
      label: "per round"
      value: "per round"
    }
  }


  measure: 1_min_ {
    group_label: "descriptive Statistics Measures"
    type: min
    sql: CASE
      WHEN  {% parameter descriptive_stats_churn %} = "per minute"
      THEN ${minutes}
      WHEN  {% parameter descriptive_stats_churn %} = "per round"
      THEN ${rounds}
    END  ;;
  }



  measure: 5_max_ {
    group_label: "descriptive Statistics Measures"
    type: max
    sql: CASE
      WHEN  {% parameter descriptive_stats_churn %} = "per minute"
      THEN ${minutes}
      WHEN  {% parameter descriptive_stats_churn %} = "per round"
      THEN ${rounds}
    END  ;;
  }

  measure: 3_median_ {
    group_label: "descriptive Statistics Measures"
    type: median
    sql: CASE
      WHEN  {% parameter descriptive_stats_churn %} = "per minute"
      THEN ${minutes}
      WHEN  {% parameter descriptive_stats_churn %} = "per round"
      THEN ${rounds}
    END  ;;
  }

  measure: 2_25th_ {
    group_label: "descriptive Statistics Measures"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter descriptive_stats_churn %} = "per minute"
      THEN ${minutes}
      WHEN  {% parameter descriptive_stats_churn %} = "per round"
      THEN ${rounds}
    END  ;;
  }

  measure: 4_75th_ {
    group_label: "descriptive Statistics Measures"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter descriptive_stats_churn %} = "per minute"
      THEN ${minutes}
      WHEN  {% parameter descriptive_stats_churn %} = "per round"
      THEN ${rounds}
    END  ;;
  }



  set: detail {
    fields: [session_id, user_id, minutes, rounds, avg_load_time_rd_0]
  }

}
