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

    , remove_the_duplicates as (

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

    )

      ------------------------------------------------------------------------
      -- add ending currency balances
      ------------------------------------------------------------------------

select
    *
    ,
    safe_cast(json_extract_scalar(
        last_value(currencies) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.CURRENCY_04") as numeric) as ending_balance_currency_04

    ,
    safe_cast(json_extract_scalar(
        last_value(currencies) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.CURRENCY_03") as numeric) as ending_balance_currency_03
    ,
    safe_cast(json_extract_scalar(
        last_value(currencies) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.CURRENCY_01") as numeric) as ending_balance_currency_01

    ,
    safe_cast(json_extract_scalar(
        last_value(currencies) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.MAGNIFIER") as numeric) as ending_balance_magnifier
  ,
    safe_cast(json_extract_scalar(
        last_value(currencies) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.CURRENCY_07") as numeric) as ending_balance_currency_07
  ,
    safe_cast(json_extract_scalar(
        last_value(currencies) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.DICE") as numeric) as ending_balance_dice
  ,
    safe_cast(json_extract_scalar(
        last_value(tickets) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.ROCKET") as numeric) as ending_balance_rocket
  ,
    safe_cast(json_extract_scalar(
        last_value(tickets) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.BOMB") as numeric) as ending_balance_bomb
  ,
    safe_cast(json_extract_scalar(
        last_value(tickets) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.COLOR_BALL") as numeric) as ending_balance_color_ball
  ,
    safe_cast(json_extract_scalar(
        last_value(tickets) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.clear_cell") as numeric) as ending_balance_clear_cell
  ,
    safe_cast(json_extract_scalar(
        last_value(tickets) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.clear_horizontal") as numeric) as ending_balance_clear_horizontal
  ,
    safe_cast(json_extract_scalar(
        last_value(tickets) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.clear_vertical") as numeric) as ending_balance_clear_vertical
  ,
    safe_cast(json_extract_scalar(
        last_value(tickets) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.chopsticks") as numeric) as ending_balance_chopsticks
  ,
    safe_cast(json_extract_scalar(
        last_value(tickets) over (
          partition by rdg_id
          order by timestamp_utc asc
          rows between unbounded preceding and unbounded following )
      , "$.skillet") as numeric) as ending_balance_skillet
  from
    remove_the_duplicates


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
      , "$.logs[0]"
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
      , "$.logs[0]"
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
## Ending Currency Balances
####################################################################

  dimension: ending_balance_currency_04 {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_currency_03 {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_currency_01 {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_magnifier {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_currency_07 {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_dice {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_rocket {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_bomb {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_color_ball {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_clear_cell {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_clear_horizontal {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_clear_vertical {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_chopsticks {
    group_label: "Ending Currency Balances"
    type: number

  }

  dimension: ending_balance_skillet {
    group_label: "Ending Currency Balances"
    type: number

  }

#   dimension: ending_balance_currency_04 {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.currencies) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.CURRENCY_04") as numeric)
#   ;;
#   }

# dimension: ending_balance_currency_03 {
#   group_label: "Ending Currency Balances"
#   type: number
#   sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.currencies) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.CURRENCY_03") as numeric)
#   ;;
# }

#   dimension: ending_balance_currency_01 {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.currencies) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.CURRENCY_01") as numeric)
#   ;;
#   }

#   dimension: ending_balance_magnifier {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.currencies) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.MAGNIFIER") as numeric)
#   ;;
#   }

#   dimension: ending_balance_currency_07 {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.currencies) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.CURRENCY_07") as numeric)
#   ;;
#   }

#   dimension: ending_balance_dice {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.currencies) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.DICE") as numeric)
#   ;;
#   }

#   dimension: ending_balance_rocket {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.tickets) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.ROCKET") as numeric)
#   ;;
#   }

#   dimension: ending_balance_bomb {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.tickets) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.BOMB") as numeric)
#   ;;
#   }

#   dimension: ending_balance_color_ball {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.tickets) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.COLOR_BALL") as numeric)
#   ;;
#   }

#   dimension: ending_balance_clear_cell {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.tickets) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.clear_cell") as numeric)
#   ;;
#   }

#   dimension: ending_balance_clear_horizontal {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.tickets) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.clear_horizontal") as numeric)
#   ;;
#   }

#   dimension: ending_balance_clear_vertical {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.tickets) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.clear_vertical") as numeric)
#   ;;
#   }

#   dimension: ending_balance_chopsticks {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.tickets) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.chopsticks") as numeric)
#   ;;
#   }

#   dimension: ending_balance_skillet {
#     group_label: "Ending Currency Balances"
#     type: number
#     sql:
#     safe_cast(json_extract_scalar(
#         last_value(${TABLE}.tickets) over (
#           partition by ${TABLE}.rdg_id
#           order by ${TABLE}.timestamp_utc asc
#           rows between unbounded preceding and unbounded following )
#       , "$.skillet") as numeric)
#   ;;
#   }

####################################################################
## measures
####################################################################

measure: count_of_rows {
  type: number
  value_format_name: decimal_0
  sql: sum(1) ;;

}


}
