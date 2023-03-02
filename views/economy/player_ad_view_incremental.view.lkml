view: player_ad_view_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag

      -- create or replace table tal_scratch.player_ad_view_incremental as

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
              -- We use this because the FIRST time we run this query we want all the data going back
              -- but future runs we only want the last 9 days
              ------------------------------------------------------------------------

              date(timestamp) >=
                  case
                      -- select date(current_date())
                      when date(current_date()) <= '2023-03-02' -- Last Full Update
                      then '2019-01-01'
                      else date_add(current_date(), interval -9 day)
                      end
              and date(timestamp) <= date_add(current_date(), interval -1 DAY)
              -- and date(timestamp) = '2023-02-26'

              ------------------------------------------------------------------------
              -- user type selection
              -- We only want users that are marked as "external"
              -- This removes any bots or internal QA accounts
              ------------------------------------------------------------------------
              and user_type = 'external'
              and event_name = 'ad'
          )

      -- SELECT * FROM base_data

      ------------------------------------------------------------------------
      -- data_from_extra_json
      ------------------------------------------------------------------------

      -- select extra_json from `eraser-blast.game_data.events` where date(timestamp) = '2023-02-26' and event_name = 'ad' limit 10

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
              , 1 as count_ad_views

              -- Ad Informaion
              , json_extract_scalar(extra_json,"$.source_id") as source_id
              , json_extract_scalar(extra_json,"$.ad_source_name") ad_source_name
              , json_extract_scalar(extra_json,"$.ad_network") ad_network
              , json_extract_scalar(extra_json,"$.country") country
              , json_extract_scalar(extra_json,"$.current_level_id") current_level_id
              , cast(json_extract_scalar(extra_json,"$.current_level_serial") as numeric) current_level_serial

              -- Various ways to calculate revenue
              , cast(json_extract_scalar(extra_json,"$.publisher_revenue_per_impression") as numeric) publisher_revenue_per_impression
              , cast(json_extract_scalar(extra_json,"$.publisher_revenue_per_impression_in_micros") as numeric) / 100 publisher_revenue_per_impression_in_micros
              , cast(json_extract_scalar(extra_json,"$.revenue") as numeric) revenue
              , cast(json_extract_scalar(extra_json,"$.ad_value") as numeric) ad_value
              , cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
              , cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
              , cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric) currency_07_balance
          from
              base_data
      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      -- select * from `eraser-blast`.tal_scratch.INFORMATION_SCHEMA.COLUMNS where table_name = 'player_ad_view_incremental'

      select
          rdg_id
          , rdg_date
          , timestamp_utc
          , max(created_at) as created_at
          , max(version) as version
          , max(session_id) as session_id
          , max(experiments) as experiments
          , max(win_streak) as win_streak
          , max(count_ad_views) as count_ad_views
          , max(source_id) as source_id
          , max(
              coalesce(
                  ad_source_name
                  , ad_network
                  , '' ) ) as ad_network
          , max(country) as country
          , max(current_level_id) as current_level_id
          , max(current_level_serial) as current_level_serial
          , max(
              coalesce(
                  publisher_revenue_per_impression
                  , publisher_revenue_per_impression_in_micros
                  , revenue
                  , ad_value
                  , 0 ) ) as ad_view_dollars
          , max(currency_03_balance) as coins_balance
          , max(currency_04_balance) as lives_balance
          , max(currency_07_balance) as stars_balance

      from
          get_data_from_extra_json
      group by
          1,2,3

      ;;
    sql_trigger_value: select sum(1) from `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_incremental` ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
    increment_key: "rdg_date"
    increment_offset: 7

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
      ;;
    primary_key: yes
    hidden: yes
  }

  ####################################################################
  ## Other Dimensions
  ####################################################################

  dimension_group: rdg_date_analysis {
    description: "date as defined by rdg_date function"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: rdg_date {
    type: date
  }

  ####################################################################
  ## Measures
  ####################################################################

  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
}
