view: firebase_player_daily_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update '2025-01-14'


      -- create or replace table `tal_scratch.firebase_player_daily_incremental` as

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
        , case when event_name = 'in_app_purchase' then ifnull(event_value_in_usd,0) else 0 end as in_app_purchase_amount_in_usd
        , geo.country as firebase_country
        , user_properties
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
            when date(current_date()) <= '2025-01-14' -- Last Full Update
            then '2022-06-01'
            else date_add(current_date(), interval -15 DAY)
            end

          and date(
          safe_cast(substr(_table_suffix,1,4) as int64)
          , safe_cast(substr(_table_suffix,5,2) as int64)
          , safe_cast(substr(_table_suffix,7,2) as int64)
          ) <=
            date_add(current_date(), interval -1 DAY)

        ------------------------------------------------------------------------
        -- only events we want
        ------------------------------------------------------------------------

        and event_name in ('app_open', 'in_app_purchase')

        ------------------------------------------------------------------------
        -- Other Filters
        ------------------------------------------------------------------------

        and user_id is not null
        and device.advertising_id is not null

      )

      ------------------------------------------------------------------------
      -- unnest user properties
      ------------------------------------------------------------------------

      , my_unnest_user_properties_table as (

        select
          a.rdg_date
          , a.user_id as firebase_user_id
          , max(unnest_user_properties.value.string_value) as internet_reachability

        from
          base_data a
          cross join unnest(user_properties) as unnest_user_properties
        where
          unnest_user_properties.key = 'internet_reachability'
        group by
          1,2

      )

      ------------------------------------------------------------------------
      -- summarize base data
      ------------------------------------------------------------------------

      , my_summarize_base_data as (

        select
          rdg_date
          , user_id as firebase_user_id
          , max( advertising_id ) as firebase_advertising_id
          , max( platform ) as firebase_platform
          , max( created_date ) as firebase_created_date
          , sum( in_app_purchase_amount_in_usd ) as in_app_purchase_amount_in_usd
          , max( firebase_country ) as firebase_country
        from
          base_data
        group by
          1,2

      )

      ------------------------------------------------------------------------
      -- combine
      ------------------------------------------------------------------------

      select
        a.*
        , b.internet_reachability
      from
        my_summarize_base_data a
        left join my_unnest_user_properties_table b
          on a.rdg_date = b.rdg_date
          and a.firebase_user_id = b.firebase_user_id

      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (1) + 2 )*( -10 ) minute)) ;;
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

  dimension_group: created_date {
    label: "Installed On"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.firebase_created_date ;;
  }

  dimension: rdg_date {
    type: date
  }

  dimension: firebase_platform {
    type:  string
  }

  dimension: firebase_country {
    type: string
  }

  dimension: day_number {
    type: number
    value_format_name: decimal_0
    sql:
      1 + DATE_DIFF(DATE(${TABLE}.rdg_date), DATE(${TABLE}.firebase_created_date), DAY) ;;
  }

  dimension: internet_reachability {
    type: string
  }

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.firebase_user_id ;;
  }

  measure: in_app_purchase_amount_in_usd {
    type: sum
    value_format_name: usd
    sql: ${TABLE}.in_app_purchase_amount_in_usd ;;
  }

}
