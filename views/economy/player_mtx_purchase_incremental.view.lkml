view: player_mtx_purchase_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:


      -- ccb_aggregate_update_tag
      -- update '2023-03-02'

      -- create or replace table tal_scratch.player_mtx_purchase_incremental as

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

              ------------------------------------------------------------------------
              -- this event information
              ------------------------------------------------------------------------

              and event_name = 'transaction'
              and json_extract_scalar(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_01' -- real dollars
              and (
                  json_extract_scalar(extra_json,"$.rvs_id") like '%GPA%' -- check for valid transactions on Google Play
                  or json_extract_scalar(extra_json,"$.rvs_id") like '%AppleAppStore%' -- check for valid transactions on Apple
                  )
          )

      -- SELECT * FROM base_data

      ------------------------------------------------------------------------
      -- data_from_extra_json
      ------------------------------------------------------------------------

      -- select extra_json from base_data limit 10

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
              , 1 as count_mtx_purchases

              -- MTX Purchase Informaion
              , json_extract_scalar(extra_json,"$.source_id") as source_id
              , json_extract_scalar(extra_json,"$.store_session_id") store_session_id
              , json_extract_scalar(extra_json,"$.iap_purchase_item") iap_purchase_item
              , cast(json_extract_scalar(extra_json,"$.iap_purchase_qty") as numeric) iap_purchase_qty
              , json_extract_scalar(extra_json,"$.transaction_id") transaction_id

              -- purchase amount + app store cut
                , ifnull(cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") as numeric) * 0.01 * 0.70 ,0) mtx_purchase_dollars

              -- currency balances
              , cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
              , cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
              , cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric) currency_07_balance

          from
              base_data

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      -- select * from get_data_from_extra_json

      -- select column_name from `eraser-blast`.tal_scratch.INFORMATION_SCHEMA.COLUMNS where table_name = 'player_mtx_purchase_incremental' order by ordinal_position

      select
          rdg_id
          , rdg_date
          , timestamp_utc
          , transaction_id
          , max(created_at) as created_at
          , max(version) as version
          , max(session_id) as session_id
          , max(experiments) as experiments
          , max(win_streak) as win_streak
          , max(last_level_serial) as last_level_serial
          , max(count_mtx_purchases) as count_mtx_purchases
          , max(source_id) as source_id
          , max(store_session_id) as store_session_id
          , max(iap_purchase_item) as iap_purchase_item
          , max(iap_purchase_qty) as iap_purchase_qty
          , max(mtx_purchase_dollars) as mtx_purchase_dollars
          , max(currency_03_balance) as coins_balance
          , max(currency_04_balance) as lives_balance
          , max(currency_07_balance) as stars_balance
          , max(cumulative_time_played_minutes) as cumulative_time_played_minutes

      from
          get_data_from_extra_json
      group by
          1,2,3,4

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
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
      || '_' || ${TABLE}.transaction_id
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
  measure: mtx_purchase_dollars {
    type: sum
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }

}