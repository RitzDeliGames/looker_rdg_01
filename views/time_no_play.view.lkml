# include: "/views/**/events.view"

view: time_no_play {
#   extends: [events]

  derived_table: {
    sql: SELECT user_id,
       -- platform,
       -- current_card,
       --session_id,
       MAX(CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS DATE)) AS event_date,
       MAX(TIMESTAMP) AS last_event,
       CURRENT_DATE() AS current_date,
       CURRENT_TIME() AS current_time,
       TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), MAX(CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS timestamp)), HOUR) AS hours_since_last_play,
       TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), MAX(CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', timestamp , 'America/Los_Angeles')) AS timestamp)), DAY) AS days_since_last_play,
       MAX(CAST(JSON_EXTRACT(extra_json,"$.rounds") AS NUMERIC)) AS rounds,
       MAX(CAST(REPLACE(JSON_EXTRACT(extra_json,'$.round_id'),'"','') AS NUMERIC)) AS round_id

FROM `eraser-blast.game_data.events`
WHERE event_name = "cards"
--  AND user_id = "anon-a4096ecc-dcd7-4386-a05a-3d133a0b93b6"
-- AND session_id = '56321bd7-d97c-4a16-978f-551e6f2ae157-08/08/2020 22:10:20'
GROUP BY user_id--, platform--, session_id--, current_card--,
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

#   dimension: platform {
#     type: string
#     sql: ${TABLE}.platform ;;
#   }

#   dimension: session_id {
#     type: string
#     sql: ${TABLE}.session_id ;;
#   }

#   dimension: current_card {
#     type: string
#     sql: ${TABLE}.current_card ;;
#   }

  dimension: event_date {
    type: date
    datatype: date
    sql: ${TABLE}.event_date ;;
  }

  dimension_group: last_event {
    type: time
    sql: ${TABLE}.last_event ;;
  }

  dimension: current_date {
    type: date
    datatype: date
    sql: ${TABLE}.current_date ;;
  }

  dimension_group: current_time {
    type: time
    sql: ${TABLE}.current_time ;;
  }

  dimension: hours_since_last_play {
    type: number
    sql: ${TABLE}.hours_since_last_play ;;
  }

  dimension: days_since_last_play {
    type: number
    sql: ${TABLE}.days_since_last_play ;;
  }

  dimension: rounds_no {
    type: number
    sql: ${TABLE}.rounds ;;
  }

  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }


  ########
  measure: days_since_last_play_measure {
    type: number
    sql: ${days_since_last_play} ;;
  }

  measure: count_unique_users {
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: rounds_played {
    type: average
    sql: ${rounds_no} ;;
  }


  set: detail {
    fields: [
      user_id,
      event_date,
      last_event_time,
      current_date,
      current_time_time,
      hours_since_last_play,
      days_since_last_play,
      rounds_no,
      round_id
    ]
  }
}
