view: player_simple_event_summary_hotdog {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-09-18'

      -- create or replace table tal_scratch.player_simple_event_summary_hotdog

        select
          rdg_id
          , safe_cast(json_extract_scalar( extra_json , "$.event_id") as string) as event_id
          , min(timestamp(date(timestamp_utc))) as rdg_date
          , min(timestamp_utc) as min_timestamp_utc
          , max(timestamp_utc) as max_timestamp_utc
          , sum( ifnull(safe_cast(json_extract_scalar( extra_json , "$.score") as numeric),0) ) as total_score
        from
          -- eraser-blast.looker_scratch.LR_6YSN61726674717925_player_simple_event_incremental
          ${player_simple_event_incremental.SQL_TABLE_NAME}
        where
          safe_cast(json_extract_scalar( extra_json , "$.event_id") as string) like 'hc%'
          -- and date(rdg_date) = '2024-09-17'
        group by
          1,2

      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -3 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (3) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

  ####################################################################
  ## Primary Key
  ####################################################################

  dimension: primary_key {
    type: string
    sql:
      ${TABLE}.rdg_id
      || '_' || ${TABLE}.event_id
      ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  # Strings
  dimension: rdg_id {type:string}
  dimension: event_id {type:string}

################################################################
## Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
  measure: count_instances {
    label: "Count Instances"
    type: number
    sql: sum(1) ;;
  }

}
