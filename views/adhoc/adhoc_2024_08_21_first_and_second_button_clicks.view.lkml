view: adhoc_2024_08_21_first_and_second_button_clicks {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


      -- ccb_aggregate_update_tag
      -- update '2024-08-21'

      -- create or replace table tal_scratch.adhoc_2024_08_21_first_and_second_button_clicks as

      with

      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      base_data as (

          select
              rdg_id
              , timestamp as timestamp_utc
              , timestamp(date(timestamp)) as rdg_date
              , version
              , session_id
              , experiments
              , currencies
              , last_level_serial
              , 1 as count_button_clicks
              , safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) as button_tag
          from
              `eraser-blast.game_data.events`
          where

              ------------------------------------------------------------------------
              -- Date selection
              ------------------------------------------------------------------------

              date(timestamp) >= '2024-01-01'
              and date(timestamp) <= '2024-08-20'

              ------------------------------------------------------------------------
              -- user type selection
              -- We only want users that are marked as "external"
              -- This removes any bots or internal QA accounts
              ------------------------------------------------------------------------

              and user_type = 'external'
              and event_name = 'ButtonClicked'

              -- My Data
              -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'
              -- and date(timestamp) = '2024-08-20'
          )

      ------------------------------------------------------------------------
      -- lag lead functions
      ------------------------------------------------------------------------

      , my_lag_lead_function_table as (

        select
          *
          , sum(1) over (partition by rdg_id, session_id order by timestamp_utc rows between unbounded preceding and current row ) as count_of_button_clicks
          , lead(timestamp_utc) over (partition by rdg_id, session_id order by timestamp_utc ) as next_timestamp_utc
        from
          base_data

      )

      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      select
        *
        , timestamp_diff(next_timestamp_utc, timestamp_utc, millisecond) as time_diff_in_milliseconds
      from
        my_lag_lead_function_table
      where
        count_of_button_clicks = 1



      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.timestamp_utc
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension_group: rdg_date {
    label: "Activity Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension_group: timestamp_utc {
    label: "Activity Timestamp"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

  dimension_group: next_timestamp_utc {
    label: "Activity Timestamp"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.next_timestamp_utc ;;
  }

  dimension: version {type: string}
  dimension: version_number {type: number sql: safe_cast(${TABLE}.version as numeric);;}
  dimension: session_id {type: string}
  dimension: experiments {type:string}
  dimension: last_level_serial {type: number}
  dimension: rdg_id {type: string}
  dimension: button_tag {type: string}
  dimension: count_button_clicks {type: number}
  dimension: time_diff_in_milliseconds {type:number}

################################################################
## Measures
################################################################

  measure: count_distinct_rdg_id {
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }

  measure: count_rows {
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.count_button_clicks) ;;

  }

  measure: time_diff_in_milliseconds_10 {
    group_label: "Time Diff In Milliseconds"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.time_diff_in_milliseconds ;;
  }
  measure: time_diff_in_milliseconds_25 {
    group_label: "Time Diff In Milliseconds"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.time_diff_in_milliseconds ;;
  }
  measure: time_diff_in_milliseconds_50 {
    group_label: "Time Diff In Milliseconds"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.time_diff_in_milliseconds ;;
  }
  measure: time_diff_in_milliseconds_75 {
    group_label: "Time Diff In Milliseconds"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.time_diff_in_milliseconds ;;
  }

  measure: time_diff_in_milliseconds_80 {
    group_label: "Time Diff In Milliseconds"
    label: "80th Percentile"
    type: percentile
    percentile: 80
    sql: ${TABLE}.time_diff_in_milliseconds ;;
  }

  measure: time_diff_in_milliseconds_85 {
    group_label: "Time Diff In Milliseconds"
    label: "85th Percentile"
    type: percentile
    percentile: 85
    sql: ${TABLE}.time_diff_in_milliseconds ;;
  }

  measure: time_diff_in_milliseconds_90 {
    group_label: "Time Diff In Milliseconds"
    label: "90th Percentile"
    type: percentile
    percentile: 90
    sql: ${TABLE}.time_diff_in_milliseconds ;;
  }

  measure: time_diff_in_milliseconds_95 {
    group_label: "Time Diff In Milliseconds"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.time_diff_in_milliseconds ;;
  }


}
