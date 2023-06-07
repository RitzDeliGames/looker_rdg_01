view: player_reward_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-06-07'

      -- create or replace table tal_scratch.player_reward_incremental as

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
              , engagement_ticks
              , tickets
          from
              `eraser-blast.game_data.events`
          where

              ------------------------------------------------------------------------
              -- Date selection
              -- We use this because the FIRST time we run this query we want all the data going back
              -- but future runs we only want the last 9 days
              ------------------------------------------------------------------------

              date(timestamp) >=
                  case
                      -- select date(current_date())
                      when date(current_date()) <= '2023-06-07' -- Last Full Update
                      then '2022-06-01'
                      else date_add(current_date(), interval -9 day)
                      end
              and date(timestamp) <= date_add(current_date(), interval -1 DAY)

              ------------------------------------------------------------------------
              -- user type selection
              -- We only want users that are marked as "external"
              -- This removes any bots or internal QA accounts
              ------------------------------------------------------------------------

              and user_type = 'external'

              ------------------------------------------------------------------------
              -- this event information
              ------------------------------------------------------------------------

              and event_name = 'reward'

              ------------------------------------------------------------------------
              -- check my data
              -- this is adhoc if I want to check a query with my own data
              ------------------------------------------------------------------------

              -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba' -- me
              -- and rdg_id = '8ee87da9-7cf2-4e6b-930e-801cc291bb34'
              -- and date(timestamp) between '2023-06-01' and '2023-06-06'

          )

      -- SELECT * FROM base_data

      ------------------------------------------------------------------------
      -- data_from_extra_json
      ------------------------------------------------------------------------

      -- select distinct lower(json_extract_scalar(extra_json,"$.reward_type")) as reward_type from base_data order by 1

      , get_data_from_extra_json as (

          select
              rdg_id
              , timestamp(date(timestamp_utc)) as rdg_date
              , timestamp_utc
              , created_at
              , version
              , session_id
              , experiments
              , win_streak
              , last_level_serial
              , round(cast(engagement_ticks as int64) / 2) cumulative_time_played_minutes
              , 1 as count_reward_events
              , json_extract_scalar(extra_json,"$.reward_event") as reward_event

              -----------------------------------------------------------------------------------
              -- rewards: powers
              -----------------------------------------------------------------------------------

              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "rocket" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_rocket
              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "bomb" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_bomb
              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "color_ball" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_color_ball


              -----------------------------------------------------------------------------------
              -- rewards: chum chum powers
              -----------------------------------------------------------------------------------

              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "clear_cell" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_clear_cell
              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "clear_horizontal" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_clear_horizontal
              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "clear_vertical" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_clear_vertical
              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "shuffle" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_shuffle

              -----------------------------------------------------------------------------------
              -- rewards: currencies
              -----------------------------------------------------------------------------------

              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "currency_03" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_currency_03
              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "currency_04" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_currency_04

              -----------------------------------------------------------------------------------
              -- rewards: infinite lives
              -----------------------------------------------------------------------------------

              , case when lower(json_extract_scalar(extra_json,"$.reward_type")) = "infinite_lives" then safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric) else 0 end as reward_infinite_lives

              -----------------------------------------------------------------------------------
              -- balance: powers
              -----------------------------------------------------------------------------------

              , ifnull(safe_cast(json_extract_scalar(tickets,"$.ROCKET") as numeric),0) as balance_rocket
              , ifnull(safe_cast(json_extract_scalar(tickets,"$.BOMB") as numeric),0) as balance_bomb
              , ifnull(safe_cast(json_extract_scalar(tickets,"$.COLOR_BALL") as numeric),0) as balance_color_ball

              -----------------------------------------------------------------------------------
              -- balance: chum chum powers
              -----------------------------------------------------------------------------------

              , ifnull(safe_cast(json_extract_scalar(tickets,"$.clear_cell") as numeric),0)
                  + ifnull(safe_cast(json_extract_scalar(tickets,"$.CLEAR_CELL") as numeric),0) as balance_clear_cell
              , ifnull(safe_cast(json_extract_scalar(tickets,"$.clear_horizontal") as numeric),0) as balance_clear_horizontal
              , ifnull(safe_cast(json_extract_scalar(tickets,"$.clear_vertical") as numeric),0) as balance_clear_vertical
              , ifnull(safe_cast(json_extract_scalar(tickets,"$.shuffle") as numeric),0) as balance_shuffle

              -----------------------------------------------------------------------------------
              -- balance: currencies
              -----------------------------------------------------------------------------------

              , ifnull(safe_cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric),0) balance_currency_03
              , ifnull(safe_cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric),0) balance_currency_04

              -----------------------------------------------------------------------------------
              -- balance: infinite lives
              -----------------------------------------------------------------------------------

              , ifnull(safe_cast(json_extract_scalar(tickets,"$.INFINITE_LIVES") as numeric),0) as balance_infinite_lives

          from
              base_data

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      select
          rdg_id
          , rdg_date
          , timestamp_utc
          , reward_event

          -- side info
          , max(created_at) as created_at
          , max(version) as version
          , max(session_id) as session_id
          , max(experiments) as experiments
          , max(win_streak) as win_streak
          , max(last_level_serial) as last_level_serial
          , max(cumulative_time_played_minutes) as cumulative_time_played_minutes
          , max(count_reward_events) as count_reward_events

          -----------------------------------------------------------------------------------
          -- rewards: powers
          -----------------------------------------------------------------------------------

          , max( reward_rocket ) as reward_rocket
          , max( reward_bomb ) as reward_bomb
          , max( reward_color_ball ) as reward_color_ball

          -----------------------------------------------------------------------------------
          -- rewards: chum chum powers
          -----------------------------------------------------------------------------------

          , max( reward_clear_cell ) as reward_clear_cell
          , max( reward_clear_horizontal ) as reward_clear_horizontal
          , max( reward_clear_vertical ) as reward_clear_vertical
          , max( reward_shuffle ) as reward_shuffle

          -----------------------------------------------------------------------------------
          -- rewards: currencies
          -----------------------------------------------------------------------------------

          , max( reward_currency_03 ) as reward_currency_03
          , max( reward_currency_04 ) as reward_currency_04

          -----------------------------------------------------------------------------------
          -- rewards: infinite lives
          -----------------------------------------------------------------------------------

          , max( reward_infinite_lives ) as reward_infinite_lives

          -----------------------------------------------------------------------------------
          -- balance: powers
          -----------------------------------------------------------------------------------

          , max( balance_rocket ) as balance_rocket
          , max( balance_bomb ) as balance_bomb
          , max( balance_color_ball ) as balance_color_ball

          -----------------------------------------------------------------------------------
          -- balance: chum chum powers
          -----------------------------------------------------------------------------------

          , max( balance_clear_cell ) as balance_clear_cell
          , max( balance_clear_horizontal ) as balance_clear_horizontal
          , max( balance_clear_vertical ) as balance_clear_vertical
          , max( balance_shuffle ) as balance_shuffle

          -----------------------------------------------------------------------------------
          -- balance: currencies
          -----------------------------------------------------------------------------------

          , max( balance_currency_03 ) as balance_currency_03
          , max( balance_currency_04 ) as balance_currency_04

          -----------------------------------------------------------------------------------
          -- balance: infinite lives
          -----------------------------------------------------------------------------------

          , max( balance_infinite_lives ) as balance_infinite_lives

      from
          get_data_from_extra_json
      group by
          1,2,3,4
      -- order by
      --     timestamp_utc desc


      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
    increment_key: "rdg_date"
    increment_offset: 7

  }

  ####################################################################
  ## Primary Key
  ###################################################################

  dimension: primary_key {
    type: string
    sql:
      ${TABLE}.rdg_id
      || '_' || ${TABLE}.rdg_date
      || '_' || ${TABLE}.timestamp_utc
      || '_' || ${TABLE}.reward_event
      ;;
    primary_key: yes
    hidden: yes
  }

  ####################################################################
  ## Dates
  ####################################################################

  dimension_group: reward_date {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
  }

  ####################################################################
  ## Other Dimensions
  ####################################################################

  dimension: rdg_id {type:string}
  dimension: reward_event {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: count_reward_events {type:number}
  dimension: reward_rocket {type:number}
  dimension: reward_bomb {type:number}
  dimension: reward_color_ball {type:number}
  dimension: reward_clear_cell {type:number}
  dimension: reward_clear_horizontal {type:number}
  dimension: reward_clear_vertical {type:number}
  dimension: reward_shuffle {type:number}
  dimension: reward_currency_03 {type:number}
  dimension: reward_currency_04 {type:number}
  dimension: reward_infinite_lives {type:number}
  dimension: balance_rocket {type:number}
  dimension: balance_bomb {type:number}
  dimension: balance_color_ball {type:number}
  dimension: balance_clear_cell {type:number}
  dimension: balance_clear_horizontal {type:number}
  dimension: balance_clear_vertical {type:number}
  dimension: balance_shuffle {type:number}
  dimension: balance_currency_03 {type:number}
  dimension: balance_currency_04 {type:number}
  dimension: balance_infinite_lives {type:number}


  ####################################################################
  ## Measures
  ####################################################################

  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }


}
