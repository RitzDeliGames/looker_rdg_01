view: player_recent_button_clicks {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-05-16'

      -- create or replace table tal_scratch.player_recent_button_clicks as

      with

      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      base_data as (

          select
              rdg_id
              , timestamp as timestamp_utc
              , created_at
              , version
              , user_type
              , session_id
              , event_name
              , extra_json
              , experiments
              , win_streak
              , currencies
              , last_level_serial
          from
              `eraser-blast.game_data.events`
          where

              ------------------------------------------------------------------------
              -- Date selection
              ------------------------------------------------------------------------

              date(timestamp) >= date_add(current_date(), interval -30 day)
              and date(timestamp) <= date_add(current_date(), interval -1 DAY)

              ------------------------------------------------------------------------
              -- user type selection
              -- We only want users that are marked as "external"
              -- This removes any bots or internal QA accounts
              ------------------------------------------------------------------------

              and user_type = 'external'
              and event_name = 'ButtonClicked'
          )

      -- SELECT * FROM base_data

      -----------------------------------------------------------------------
      -- extra json info
      ------------------------------------------------------------------------

      , extra_json_info as (

          select
              rdg_id
              , timestamp(date(timestamp_utc)) as rdg_date
              , timestamp_utc
              , created_at
              , version
              , user_type
              , session_id
              , event_name
              , extra_json
              , experiments
              , win_streak
              , currencies
              , last_level_serial
              , 1 as count_button_clicks
              , cast(json_extract_scalar( extra_json , "$.button_tag") as string) as button_tag
              , cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
              , cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
              , cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric) currency_07_balance
              , cast(json_extract_scalar( extra_json , "$.config_timestamp") as numeric) as config_timestamp

          from
              base_data

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      select
          -- primary key
          rdg_id
          , rdg_date
          , timestamp_utc
          , button_tag

          -- summarized fields
          , max( version ) as version
          , max( session_id ) as session_id
          , max( win_streak ) as win_streak
          , max( last_level_serial ) as last_level_serial
          , max( count_button_clicks ) as count_button_clicks
          , max( config_timestamp ) as config_timestamp
      from
          extra_json_info

      group by
          1,2,3,4

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    publish_as_db_view: yes

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
    || '_' || ${TABLE}.button_tag
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Date Groups
####################################################################

  dimension_group: rdg_date {
    label: "Install Date Group"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension_group: timestamp_utc {
    label: "Campaign Start Date Group"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: version {type: number}
  dimension: session_id {type: string}
  dimension: win_streak {type: number}
  dimension: last_level_serial {type: number}
  dimension: count_button_clicks {type: number}


}
