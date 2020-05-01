connection: "eraser_blast_gbq"

# include all the views
include: "/views/**/*.view"

datagroup: rdg_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: rdg_default_datagroup

explore: events {
  sql_always_where:
    user_type NOT IN ("internal_editor", "unit_test");;
}

explore: gameplay_metrics {
  sql_always_where:
    event_name = "round_end"
    AND JSON_EXTRACT(${extra_json},"$.team_slot_0") IS NOT NULL
    AND user_type NOT IN ("internal_editor", "unit_test");;
}

explore: transaction {
  sql_always_where: event_name = "transaction""
    AND user_type NOT IN ("internal_editor", "unit_test");;
}
