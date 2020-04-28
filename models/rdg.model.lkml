connection: "eraser_blast_gbq"

# include all the views
include: "/views/**/*.view"

datagroup: rdg_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: rdg_default_datagroup

explore: round_end_events {
  sql_always_where: event_name = 'round_end' ;;
}

# explore: round_events {}
