
view: round_id_decay_per_churn {
  derived_table: {
    sql: SELECT
        CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')) AS DATE) AS events_user_first_seen_date,
          CASE
            WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
            WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
            WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
            WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
            WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
            WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
            WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
            WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
            WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
            WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
            WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
            WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
            WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
            WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
          END  AS events_experiment_names,
        CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) AS events_round_id,
        COUNT(DISTINCT events.user_id ) AS events_count_unique_person_id,
        ROUND(100 * (1 - ((LAG(COUNT(DISTINCT events.user_id)) OVER(ORDER BY MAX((CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC))))) / COUNT(DISTINCT events.user_id))), 0)  AS events_churn_int,
        (1 - ((LAG(COUNT(DISTINCT events.user_id)) OVER(ORDER BY MAX((CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC))))) / COUNT(DISTINCT events.user_id)))  AS events_churn_decimal
      FROM `eraser-blast.game_data.events` AS events

      WHERE user_type NOT IN ("internal_editor", "unit_test")
      GROUP BY 1,2,3
      --ORDER BY 1,3,2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: events_experiment_names {
    type: string
    sql: ${TABLE}.events_experiment_names ;;
  }

  dimension: events_user_first_seen_date {
    type: date
    datatype: date
    sql: ${TABLE}.events_user_first_seen_date ;;
  }

  dimension: events_round_id {
    type: number
    sql: ${TABLE}.events_round_id ;;
  }

  dimension: events_count_unique_person_id {
    type: number
    sql: ${TABLE}.events_count_unique_person_id ;;
  }

  dimension: events_churn_int {
    type: number
    sql: CAST(${TABLE}.events_churn_int AS NUMERIC) ;;
  }

  dimension: events_churn_decimal {
    type: number
    sql: CAST(${TABLE}.events_churn_decimal AS NUMERIC) ;;
  }



  measure: 1_min {
    group_label: "Since_Install_measures"
    type: min
    sql: ${events_churn_int} * (-1) ;;
  }

  measure: 2_25th {
    group_label: "Since_Install_measures"
    type: percentile
    percentile: 25
    sql: ${events_churn_int} * (-1) ;;
  }

  measure: 3_median {
    group_label: "Since_Install_measures"
    type: median
    sql: ${events_churn_int} * (-1) ;;
  }

  measure: 4_75th {
    group_label: "Since_Install_measures"
    type: percentile
    percentile: 75
    sql: ${events_churn_int} * (-1) ;;
  }

  measure: 5_max {
    group_label: "Since_Install_measures"
    type: max
    sql: ${events_churn_int} * (-1) ;;
  }


  set: detail {
    fields: [events_experiment_names, events_round_id, events_count_unique_person_id, events_churn_int, events_churn_decimal]
  }
}
