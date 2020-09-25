view: round_length_by_tile {
  derived_table: {
    sql: SELECT
        a.*, b.round_length
      FROM (
        SELECT
          user_id,
          session_id,
          CAST(REPLACE(JSON_EXTRACT(extra_json,
              "$.round_id"),'"','') AS INT64) AS round_id,
          REPLACE(REPLACE(JSON_EXTRACT(extra_json,
                "$.card_state_progress"),"[",""),"]","") AS tile,
        FROM
          `eraser-blast.game_data.events`
        WHERE
          event_name = "cards"
        ORDER BY
          user_id,
          round_id ASC) AS a
      JOIN
      (  SELECT
          user_id,
          session_id,
          CAST(REPLACE(JSON_EXTRACT(extra_json,
              "$.round_id"),'"','') AS INT64) AS round_id,
          CAST(REPLACE(JSON_EXTRACT(extra_json,
              "$.round_length"),'"','') AS INT64)/1000 AS round_length,
        FROM
          `eraser-blast.game_data.events`
        WHERE
          event_name = "round_end"
        ORDER BY
          user_id,
          round_id ASC) AS b
      ON a.user_id = b.user_id
      AND a.round_id = b.round_id
      AND a.session_id = b.session_id
      ORDER BY a.user_id DESC, a.round_id ASC
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

  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }

  dimension: tile {
    type: string
    sql: ${TABLE}.tile ;;
  }

  dimension: round_length {
    type: number
    sql: ${TABLE}.round_length ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_id ;;
  }



  measure: 1_min_ {
    group_label: "descriptive Statistics Measures"
    type: min
    sql: CAST(${round_length} AS NUMERIC) ;;
  }

  measure: 5_max_ {
    group_label: "descriptive Statistics Measures"
    type: max
    sql: CAST(${round_length} AS NUMERIC) ;;
  }

  measure: 3_median_ {
    group_label: "descriptive Statistics Measures"
    type: median
    sql: CAST(${round_length} AS NUMERIC) ;;
  }

  measure: 2_25th_ {
    group_label: "descriptive Statistics Measures"
    type: percentile
    percentile: 25
    sql: CAST(${round_length} AS NUMERIC) ;;
  }

  measure: 4_75th_ {
    group_label: "descriptive Statistics Measures"
    type: percentile
    percentile: 75
    sql: CAST(${round_length} AS NUMERIC) ;;
  }

  set: detail {
    fields: [user_id, round_id, tile, round_length, session_id]
  }
}
