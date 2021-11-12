connection: "eraser_blast_gbq"

# include all the views
# include: "/views/**/*.view"
include: "/**/*.view"

##########MODEL##########
datagroup: rdg_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hours"
}

persist_with: rdg_default_datagroup

datagroup: change_at_midnight {
  sql_trigger:  SELECT CURRENT_DATE  ;;
  max_cache_age: "24 hours"
}

datagroup: change_3_hrs {
  sql_trigger: select floor((timestamp_diff(current_timestamp(),'2021-01-01 00:00:00',second)) / (3*60*60)) ;;
  max_cache_age: "2 hours"
}


datagroup: events_raw {
  sql_trigger:  SELECT max(event) FROM `eraser-blast.game_data.events` WHERE DATE(event) = CURRENT_DATE  ;;
}


explore: events {}
