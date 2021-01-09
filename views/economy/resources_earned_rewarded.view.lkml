view: resources_earned_rewarded {
  derived_table: {
    sql: SELECT
      a.user_id AS user_id_a,
      b.user_id AS user_id_b,
      b.version AS version,
      a.date AS earned_date,
      b.date AS reward_date,
      a.resources_earned_type,
      b.reward_type,
      a.resources_earned,
      b.resources_rewarded
      FROM
      (SELECT
      user_id,
      DATE(timestamp) AS date,
      "CURRENCY_03" AS resources_earned_type,
      SUM(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.coins_earned") AS INT64)) AS resources_earned
      FROM `eraser-blast.game_data.events`
      WHERE event_name IN ("round_end")
      GROUP BY 1, 2, 3
      ORDER BY 1 DESC
      ) AS a
      RIGHT JOIN
      (SELECT
      user_id,
      version,
      DATE(timestamp) AS date,
      JSON_EXTRACT_SCALAR(extra_json,"$.reward_type") AS reward_type,
      SUM(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.reward_amount") AS INT64)) AS resources_rewarded,
      FROM `eraser-blast.game_data.events`
      WHERE event_name IN ("reward")
      GROUP BY 1, 2, 3, 4
      ORDER BY 1 DESC
      ) AS b
      ON a.date = b.date
      AND a.resources_earned_type = b.reward_type
      AND a.user_id = b.user_id
      --WHERE b.reward_type = "CURRENCY_03"
      ORDER BY 1 DESC
       ;;
  }

  dimension: version {}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id_b ;;
  }

  dimension: earned_date {
    hidden: yes
    type: date
    datatype: date
    sql: ${TABLE}.earned_date ;;
  }

  dimension: reward_date {
    type: date
    datatype: date
    sql: ${TABLE}.reward_date ;;
  }

  dimension: resources_earned_type {
    type: string
    sql: ${TABLE}.resources_earned_type ;;
  }

  dimension: reward_type {
    type: string
    sql: ${TABLE}.reward_type ;;
  }

  dimension: resources_earned {
    hidden: yes
    type: number
    sql: ${TABLE}.resources_earned ;;
  }

  measure: resources_earned_sum {
    type: sum
    sql: IFNULL(${resources_earned},0) ;;
  }

  dimension: resources_rewarded {
    hidden: yes
    type: number
    sql: ${TABLE}.resources_rewarded ;;
  }

  measure: resources_rewarded_sum {
    type: sum
    sql: IFNULL(${resources_rewarded},0) ;;
  }

  measure: resources_rewarded_earned_sum {
    type: number
    sql: ${resources_earned_sum} + ${resources_rewarded_sum} ;;
  }

  set: detail {
    fields: [
      earned_date,
      reward_date,
      resources_earned_type,
      reward_type,
      resources_earned,
      resources_rewarded
    ]
  }
}
