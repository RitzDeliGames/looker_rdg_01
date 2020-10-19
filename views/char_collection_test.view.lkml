view: char_collection_test {
  derived_table: {
    sql: SELECT
        user_id,
        session_id,
        timestamp,
        created_at,
        JSON_EXTRACT(extra_json,'$.reward_type') AS reward_type,
        --AVG(CAST(REPLACE(JSON_EXTRACT(events.extra_json,'$.reward_amount'),'"','') AS NUMERIC)) AS reward_amount
        CAST(REPLACE(JSON_EXTRACT(events.extra_json,'$.reward_amount'),'"','') AS NUMERIC) AS reward_amount

      FROM events

      WHERE (user_type NOT IN ("internal_editor", "unit_test"))
        AND event_name = 'reward'
      --GROUP BY 1,2,3,4,5
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

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension_group: timestamp {
    type: time
    sql: ${TABLE}.timestamp ;;
  }

  dimension_group: created_at {
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension: reward_type {
    type: string
    sql: ${TABLE}.reward_type ;;
  }

  dimension: reward_amount {
    type: number
    sql: ${TABLE}.reward_amount ;;
  }

  ###################CURRENCY BALANCES MEASURES###################

  parameter: char_collection {
    type: string
    allowed_value: {
      label: "Character Collection"
      value: "Character Collection"
    }

  }

  measure: sum_chars {
    group_label: "1. Character Collection"
    type: count_distinct
    sql: CASE
      WHEN  {% parameter char_collection %} = 'Character Collection'
      THEN ${reward_type}
    END  ;;
  }

  measure: average {
    group_label: "1. Character Collection"
    type: average
    sql: CASE
      WHEN  {% parameter char_collection %} = 'Character Collection'
      THEN ${reward_amount}
    END  ;;
  }

  measure: median {
  group_label: "1. Character Collection"
  type: median
  sql: CASE
        WHEN  {% parameter char_collection %} = 'Character Collection'
        THEN ${reward_amount}
      END  ;;
  }

  measure: 25th_quartile {
  group_label: "1. Character Collection"
  type: percentile
  percentile: 25
  sql: CASE
        WHEN  {% parameter char_collection %} = 'Character Collection'
        THEN ${reward_amount}
      END  ;;
  }

  measure: 75th_quartile {
  group_label: "1. Character Collection"
  type: percentile
  percentile: 75
  sql: CASE
        WHEN  {% parameter char_collection %} = 'Character Collection'
        THEN ${reward_amount}
      END  ;;
  }


  set: detail {
    fields: [
      user_id,
      session_id,
      timestamp_time,
      created_at_time,
      reward_type,
      reward_amount
    ]
  }
}
