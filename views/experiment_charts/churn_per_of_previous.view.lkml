view: churn_per_of_previous {
  derived_table: {
    sql: SELECT
        CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20210108') != 'unassigned' THEN 'NewUX2'
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END  AS events_experiment_names,
        CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) AS events_round_id,
        COUNT(DISTINCT events.user_id ) AS events_count_unique_person_id,
        ((LAG(COUNT(DISTINCT events.user_id)) OVER(PARTITION BY MAX((CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20210108') != 'unassigned' THEN 'NewUX2'
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END)) ORDER BY MAX((CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC))))) / (COUNT(DISTINCT events.user_id))) - 1  AS events_churn_decimal
      FROM `eraser-blast.game_data.events` AS events

      WHERE (((CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) >= 1 AND CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) <= 30))) AND (created_at  >= TIMESTAMP('2020-07-06 00:00:00')
          AND user_type = "external"
          AND events.user_id NOT IN ("anon-c39ef24b-bb78-4339-9e42-befd5532a5d4"))
      GROUP BY 1,2
      ORDER BY 1 ,2
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

  dimension: events_round_id {
    type: number
    sql: ${TABLE}.events_round_id ;;
  }

  dimension: events_count_unique_person_id {
    type: number
    sql: ${TABLE}.events_count_unique_person_id ;;
  }

  dimension: events_churn_decimal {
    type: number
    sql: ${TABLE}.events_churn_decimal ;;
  }


  # MEASURES
  measure: 1_min_ {
    group_label: "measures_churn_percentage_of_previous_distribution"
    type: min
    value_format_name: percent_1
    sql: ${events_churn_decimal} ;;
  }

  measure: 5_max_ {
    group_label: "measures_churn_percentage_of_previous_distribution"
    type: max
    value_format_name: percent_1
    sql: ${events_churn_decimal} ;;
  }

  measure: 3_median_ {
    group_label: "measures_churn_percentage_of_previous_distribution"
    type: median
    value_format_name: percent_1
    sql: ${events_churn_decimal} ;;
  }

  measure: 2_25th_ {
    group_label: "measures_churn_percentage_of_previous_distribution"
    type: percentile
    percentile: 25
    value_format_name: percent_1
    sql: ${events_churn_decimal} ;;
  }

  measure: 4_75th_ {
    group_label: "measures_churn_percentage_of_previous_distribution"
    type: percentile
    percentile: 75
    value_format_name: percent_1
    sql: ${events_churn_decimal} ;;
  }

  set: detail {
    fields: [events_experiment_names, events_round_id, events_count_unique_person_id, events_churn_decimal]
  }
}
