view: players_n_churn {
  derived_table: {
    sql: SELECT JSON_EXTRACT(events.experiments,'$.content_20201106') AS experiment,
       user_id,
       COUNT(DISTINCT REPLACE(JSON_VALUE(events.extra_json,'$.current_quest'),'"','')) AS count_unique_tile

FROM `eraser-blast.game_data.events` AS events

WHERE (events.install_version = '6400')
  AND (events.experiments LIKE '%content\\_20201106%')
  AND (((CASE
          WHEN events.platform LIKE '%iOS%' THEN 'Apple'
          WHEN events.platform LIKE '%Android%' THEN 'Google'
          WHEN events.hardware LIKE '%Chrome%' AND events.user_id LIKE '%facebook%' THEN 'Facebook'
        END) = 'Google'))
  AND (events.current_card = 'card_001_a')
  AND (NOT (CAST(REPLACE(JSON_VALUE(events.extra_json,'$.current_quest'),'"','') AS NUMERIC) IS NULL))
  AND (created_at  >= TIMESTAMP('2020-07-06 00:00:00')
  AND user_type = "external")
GROUP BY 1,2
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: experiment {
    type: string
    sql: ${TABLE}.experiment ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: count_unique_tile {
    type: number
    sql: ${TABLE}.count_unique_tile ;;
  }

  set: detail {
    fields: [experiment, user_id, count_unique_tile]
  }
}
