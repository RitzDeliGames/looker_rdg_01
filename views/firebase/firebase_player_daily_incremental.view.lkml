view: firebase_player_daily_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      with

      ------------------------------------------------------------------------
      -- base data, get the columns and time range we want
      ------------------------------------------------------------------------

      base_data as (

      select
        timestamp(date(
          safe_cast(substr(_table_suffix,1,4) as int64)
          , safe_cast(substr(_table_suffix,5,2) as int64)
          , safe_cast(substr(_table_suffix,7,2) as int64)
          )) as rdg_date
        -- , timestamp(date(timestamp_micros(event_timestamp))) rdg_date
        , user_id -- this would be joined to player_summary
        , device.advertising_id advertising_id --this would be joined to singular
        , timestamp(date(timestamp_micros(user_first_touch_timestamp))) created_date
        , platform
        , event_name
        -- , event_params
        -- , key as event_params_key
        -- , value.string_value as event_params_string_value
        -- , value.int_value as event_params_int_value
        -- , value.float_value as event_params_float_value
        -- , value.double_value as event_params_double_value

      from
        `eraser-blast.analytics_215101505.events_*`
        -- , unnest(event_params)

      where

        ------------------------------------------------------------------------
        -- Date selection
        -- We use this because the FIRST time we run this query we want all the data going back
        -- but future runs we only want the last 9 days
        ------------------------------------------------------------------------

        date(
          safe_cast(substr(_table_suffix,1,4) as int64)
          , safe_cast(substr(_table_suffix,5,2) as int64)
          , safe_cast(substr(_table_suffix,7,2) as int64)
          ) >=
          case
            -- select date(current_date())
            when date(current_date()) <= '2023-02-24' -- Last Full Update
            then '2019-01-01'
            else date_add(current_date(), interval -9 DAY)
            end

         and date(
          safe_cast(substr(_table_suffix,1,4) as int64)
          , safe_cast(substr(_table_suffix,5,2) as int64)
          , safe_cast(substr(_table_suffix,7,2) as int64)
          ) <=
            date_add(current_date(), interval -1 DAY)

        ------------------------------------------------------------------------
        -- Other Filters
        ------------------------------------------------------------------------

        and user_id is not null

      )

      ------------------------------------------------------------------------
      --
      ------------------------------------------------------------------------

      select
        rdg_date
        , user_id as firebase_user_id
        , max( advertising_id ) as firebase_advertising_id
        , max( platform ) as firebase_platform
        , max( created_date ) as firebase_created_date
      from
        base_data
      group by
        1,2

      ;;
    sql_trigger_value: select sum(1) from `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_spend_incremental` ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
    increment_key: "rdg_date"
    increment_offset: 7

  }
  #
  # # Define your dimensions and measures here, like this:
  dimension_group: rdg_date_analysis {
    description: "date as defined by rdg_date function"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: rdg_date {
    type: date
  }

  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.firebase_user_id ;;
  }
}
