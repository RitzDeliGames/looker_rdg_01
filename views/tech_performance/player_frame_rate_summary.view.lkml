view: player_frame_rate_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-07-12'

      -- create or replace table tal_scratch.player_error_summary

      select
      *
      from
      ${player_frame_rate_incremental.SQL_TABLE_NAME} a

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
    || '_' || ${TABLE}.sheet_id
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
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: sheet_id {type:string}

################################################################
## Measures
################################################################

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: percent_frames_below_22 {
    label: "% Frames Below 22"
    type: number
    value_format_name: percent_0
    sql:
      safe_divide(
        sum(${TABLE}.percent_frames_below_22)
        ,
        sum(1)
      )
      ;;
  }

  measure: percent_frames_between_23_and_40 {
    label: "% Frames Between 23 and 40"
    type: number
    value_format_name: percent_0
    sql:
      safe_divide(
        sum(${TABLE}.percent_frames_between_23_and_40)
        ,
        sum(1)
      )
      ;;
  }

  measure: percent_frames_above_40 {
    label: "% Frames Above 40"
    type: number
    value_format_name: percent_0
    sql:
      safe_divide(
        sum(${TABLE}.percent_frames_above_40)
        ,
        sum(1)
      )
      ;;
  }



}
