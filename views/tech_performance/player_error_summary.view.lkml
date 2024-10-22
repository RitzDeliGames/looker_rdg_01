view: player_error_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-09-27'

      -- create or replace table tal_scratch.player_error_summary

      select
      *

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

      from
        ${player_error_incremental.SQL_TABLE_NAME} a

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
    || '_' || ${TABLE}.rdg_date
    || '_' || ${TABLE}.timestamp_utc
    || '_' || ${TABLE}.extra_json
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
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  # dates
  dimension_group: timestamp_utc {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }


  dimension_group: created_date_timestamp {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
  }

  # Strings
  dimension: rdg_id {type:string}
  dimension: extra_json {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: my_full_error {type:string}
  dimension: my_error_excluding_frame {type:string}
  dimension: simplified_error {type:string}

  # Numbers
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: count_errors {type:number}
  dimension: round_count {type:number}

################################################################
## Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  ## Error Counts
  measure: sum_errors {
    type: sum
    sql: ${TABLE}.count_errors ;;
  }

}
