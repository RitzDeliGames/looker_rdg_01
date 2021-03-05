view: afh_hack {
  derived_table: {
    sql: SELECT a.*, b.*
      FROM
          (SELECT quests_completed AS helper_quests_completed, COUNT(DISTINCT user_id) AS count_of_helpers
          --user_id, current_card, quests_completed, JSON_EXTRACT_SCALAR(extra_json,"$.providing_player_id") AS provider_id, extra_json
          FROM `eraser-blast.game_data.events`
          WHERE event_name = "afh"
          AND JSON_EXTRACT_SCALAR(extra_json,"$.afh_action") = "completed"
          GROUP BY 1
          ORDER BY 1 ASC
          LIMIT 100) AS a
      RIGHT JOIN
          (SELECT quests_completed AS all_quests_completed, COUNT(DISTINCT user_id) AS count_of_all_players
          FROM `eraser-blast.game_data.events`
          WHERE JSON_EXTRACT_SCALAR(experiments,"$.askForHelp_20210112") = "variant_a"
          GROUP BY 1
          ORDER BY 1 ASC) AS b
      ON a.helper_quests_completed = b.all_quests_completed
      ORDER BY 1 ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: helper_quests_completed {
    type: number
    sql: ${TABLE}.helper_quests_completed ;;
  }

  dimension: count_of_helpers {
    type: number
    sql: ${TABLE}.count_of_helpers ;;
  }

  dimension: all_quests_completed {
    type: number
    sql: ${TABLE}.all_quests_completed ;;
  }

  dimension: count_of_all_players {
    type: number
    sql: ${TABLE}.count_of_all_players ;;
  }

  measure: helper_count {
    type: sum
    sql: ${count_of_helpers} ;;
  }

  measure: player_count {
    type: sum
    sql: ${count_of_all_players} ;;
  }

  set: detail {
    fields: [helper_quests_completed, count_of_helpers, all_quests_completed, player_count]
  }
}
