include: "events.view"
view: round_end {
  extends: [events]
  derived_table: {
    sql: SELECT *
    FROM
    `eraser-blast.game_data.events`
    CROSS JOIN UNNEST(SPLIT(JSON_EXTRACT_SCALAR(extra_json, '$.{% parameter character %}_skill_used'))) AS character_skill_used
    WHERE JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
    AND event_name = "round_end"
    ;;
  }
  }
