view: z_resources_earned_rewarded {#JOING TOGETHER EARNED & REWARDED INTO A NET FLOW?
  derived_table: {
    sql: SELECT
      b.user_id,
      b.install_version,
      b.created_at,
      b.timestamp,
      a.resources_earned_type,
      b.reward_type,
      a.resources_earned,
      b.resources_rewarded
      FROM
      (SELECT
      user_id,
      created_at,
      install_version,
      timestamp AS date,
      "CURRENCY_03" AS resources_earned_type,
      CAST(JSON_EXTRACT_SCALAR(extra_json,"$.coins_earned") AS INT64) AS resources_earned
      FROM `eraser-blast.game_data.events`
      WHERE event_name IN ("round_end")
      ORDER BY 1 DESC
      ) AS a
      RIGHT JOIN
      (SELECT
      user_id,
      created_at,
      install_version,
      timestamp,
      JSON_EXTRACT_SCALAR(extra_json,"$.reward_type") AS reward_type,
      CAST(JSON_EXTRACT_SCALAR(extra_json,"$.reward_amount") AS INT64) AS resources_rewarded,
      FROM `eraser-blast.game_data.events`
      WHERE event_name IN ("reward")
      ORDER BY 1 DESC
      ) AS b
      ON a.user_id = b.user_id
      AND a.created_at = b.created_at
      AND a.install_version = b.install_version
      AND a.resources_earned_type = b.reward_type
      --WHERE b.reward_type = "CURRENCY_03"
      ORDER BY 1 DESC
       ;;
  }

  dimension: install_version {}

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: earned_date {
    hidden: yes
    type: date
    datatype: date
    sql: ${TABLE}.earned_date ;;
  }

  dimension: resources_earned_type {
    type: string
    sql: ${TABLE}.resources_earned_type ;;
  }

  dimension: reward_type {
    type: string
    sql: ${TABLE}.reward_type ;;
  }

  dimension: resources_earned_ {
    hidden: yes
    type: number
    sql: ${TABLE}.resources_earned ;;
  }

  measure: resources_earned {
    type: sum
    sql: IFNULL(${resources_earned_},0) ;;
  }

  #dimension: resources_rewarded {
  #  hidden: yes
  #  type: number
  #  sql: ${TABLE}.resources_rewarded ;;
  #}

  #measure: resources_rewarded_sum {
  #  type: number
  #  sql: IFNULL(${resources_rewarded},0) ;;
  #}

  #measure: resources_rewarded_earned_sum {
  #  type: number
  #  sql: ${resources_earned_sum} + ${resources_rewarded_sum} ;;
  #  drill_fields: [detail*]
  #}

  dimension_group: user_first_seen {
    type: time
    group_label: "Install Date"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp ;;
  }

  set: detail {
    fields: [
      earned_date,
      resources_earned_type,
      reward_type,
      resources_earned,
    ]
  }
}
