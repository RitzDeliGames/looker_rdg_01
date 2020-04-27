connection: "eraser_blast_gbq"

# include all the views
#include: "/views/**/*.view"
#include: "*.view.lkml"

datagroup: rdg_staging_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: rdg_staging_default_datagroup

#explore: events {}
