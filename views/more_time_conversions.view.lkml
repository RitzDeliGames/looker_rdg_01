explore: more_time_conversions {}

view: more_time_conversions {
  derived_table: {
    sql: WITH rounds_tbl AS (
          SELECT
              consecutive_days,
              quests_completed,
              DATE(DATETIME(timestamp, "America/Los_Angeles")) as date_tstz,
              current_card,
              CAST(REPLACE(JSON_VALUE(extra_json,'$.round_id'),'"','') AS NUMERIC) AS round_id,
              CAST(REPLACE(JSON_VALUE(extra_json,'$.current_quest'),'"','') AS NUMERIC) AS current_quest
          FROM events
          WHERE event_name = 'round_end'
            AND user_type = "external"
            AND install_version = "6400"),

      button_tbl AS (
          SELECT
              consecutive_days,
              quests_completed,
              current_card,
              DATE(DATETIME(timestamp, "America/Los_Angeles")) as date_tstz,
              JSON_EXTRACT_SCALAR(extra_json,"$.button_tag") AS button,

          FROM events
          WHERE event_name = "ButtonClicked"
            AND JSON_EXTRACT_SCALAR(extra_json,"$.button_tag") IN ("Sheet_BuyMoreTime.Close","Sheet_BuyMoreTime.Confirm")
            AND user_type = "external"
            AND install_version = "6400")

      SELECT b.consecutive_days,
             b.quests_completed,
             b.current_card,
             b.date_tstz,
             b.button,
             r.round_id,
             r.current_quest,

             COUNT(b.date_tstz) AS closes
            -- COUNT(b.date_tstz) AS transactions

      FROM button_tbl AS b
      LEFT JOIN rounds_tbl AS r
        ON b.date_tstz = r.date_tstz
        AND b.consecutive_days = r.consecutive_days
        AND b.current_card = r.current_card
        AND b.quests_completed = r.quests_completed
      GROUP BY 1,2,3,4,5,6,7
      --ORDER BY 1 ASC, 2 ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: consecutive_days {
    type: number
    sql: ${TABLE}.consecutive_days ;;
  }

  dimension: quests_completed {
    type: number
    sql: ${TABLE}.quests_completed ;;
  }

  dimension: current_card {
    type: string
    sql: ${TABLE}.current_card ;;
  }

  dimension: date_tstz {
    type: date
    datatype: date
    sql: ${TABLE}.date_tstz ;;
  }

  dimension: button {
    type: string
    sql: ${TABLE}.button ;;
  }

  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }

  dimension: current_quest {
    type: number
    sql: ${TABLE}.current_quest ;;
  }

  dimension: closes {
    type: number
    sql: ${TABLE}.closes ;;
  }

  set: detail {
    fields: [
      consecutive_days,
      quests_completed,
      current_card,
      date_tstz,
      button,
      round_id,
      current_quest,
      closes
    ]
  }
}
