view: player_recent_full_event_data {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-06-08'


      -- create or replace table tal_scratch.player_recent_full_event_data as

      with

      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      base_data as (

          select
              rdg_id
              , timestamp as timestamp_utc
              , platform
              , version
              , session_id
              , last_level_serial
              , event_name
              , extra_json
              , experiments
              , currencies
              , tickets
          from
              `eraser-blast.game_data.events`
          where

              ------------------------------------------------------------------------
              -- Date selection
              ------------------------------------------------------------------------

              date(timestamp) >= date_add(current_date(), interval -9 day)
              and date(timestamp) <= date_add(current_date(), interval +1 DAY)

              ------------------------------------------------------------------------
              -- user type selection
              -- We only want users that are marked as "external"
              -- This removes any bots or internal QA accounts
              ------------------------------------------------------------------------

              and user_type = 'external'

              ------------------------------------------------------------------------
              -- check my data
              -- this is adhoc if I want to check a query with my own data
              ------------------------------------------------------------------------

              -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba' -- me
              -- and rdg_id = '8ee87da9-7cf2-4e6b-930e-801cc291bb34'
              -- and date(timestamp) between '2023-06-01' and '2023-06-06'

          )

      ------------------------------------------------------------------------
      -- Remove Duplicates
      ------------------------------------------------------------------------

      select

        --- primary key
        rdg_id
        , timestamp_utc
        , event_name
        , extra_json
        , last_level_serial

        -- other fields
        , max( platform ) as platform
        , max( version ) as version
        , max( session_id ) as session_id
        , max( experiments ) as experiments
        , max( currencies ) as currencies
        , max( tickets ) as tickets
      from
         base_data
      group by
        1,2,3,4,5


      ;;
    # sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    publish_as_db_view: no
    # partition_keys: ["timestamp_utc"]
    # cluster_keys: ["rdg_id"]

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.timestamp_utc
    || '_' || ${TABLE}.event_name
    || '_' || ${TABLE}.extra_json
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Date Groups
####################################################################

  dimension_group: timestamp_utc {
    label: "Event Time"
    type: time
    timeframes: [hour_of_day, time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: rdg_id {type: string}
  dimension: platform {type: string}
  dimension: version {type: string}
  dimension: session_id {type: string}
  dimension: last_level_serial {type: number}
  dimension: event_name {type: string}
  dimension: extra_json {type: string}
  dimension: experiments {type: string}
  dimension: currencies {type: string}
  dimension: tickets {type: string}

####################################################################
## Custom - Seleted Field from Extra Json
####################################################################


  parameter: selected_extra_json_field_input {
    type: string
    suggestions: [
      "$.button_tag"
      , "$.game_mode"
      , "$.logs","$.error", "$.stack","$.config_timestamp","$.frame_count", "$.round_count"
      ]
    }

  dimension: selected_extra_json_field {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.extra_json,{% parameter selected_extra_json_field_input %})
        as string)
    ;;
  }

  parameter: selected_extra_json_field_input_2 {
    type: string
    suggestions: [
      "$.button_tag"
      , "$.game_mode"
      , "$.logs","$.error", "$.stack","$.config_timestamp","$.frame_count", "$.round_count"
    ]
  }

  dimension: selected_extra_json_field_2 {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.extra_json,{% parameter selected_extra_json_field_input_2 %})
        as string)
    ;;
  }



####################################################################
## measures
####################################################################

measure: count_of_rows {
  type: number
  value_format_name: decimal_0
  sql: sum(1) ;;

}


}
