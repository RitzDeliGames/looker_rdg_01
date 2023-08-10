view: player_ad_view_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-08-10'

      -- create or replace table tal_scratch.player_ad_view_incremental as

      with


      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      full_base_data as (

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
              , case
                  when event_name = 'round_end'
                  then safe_cast(json_extract_scalar(extra_json,"$.round_count") as int64)-1
                  else safe_cast(json_extract_scalar(extra_json,"$.round_count") as int64)
                  end as round_count
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
                      when date(current_date()) <= '2023-08-10' -- Last Full Update
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
              and event_name in ('ad','transaction', 'round_start', 'round_end' )
          )

      ------------------------------------------------------------------------
      -- round_start data
      ------------------------------------------------------------------------

      , my_round_start_data as (

          select
              rdg_id
              , round_count
              , max(timestamp_utc) as round_start_timestamp_utc
          from
              full_base_data
          where
              event_name = 'round_start'
              and round_count is not null
          group by
              1,2
          )

      ------------------------------------------------------------------------
      -- round_end data
      ------------------------------------------------------------------------

      , my_round_end_data as (

          select
              rdg_id
              , round_count
              , max(timestamp_utc) as round_end_timestamp_utc
              , max(safe_cast(json_extract_scalar( extra_json , "$.game_mode") as string)) as game_mode
          from
              full_base_data
          where
              event_name = 'round_end'
              and round_count is not null
          group by
              1,2
          )

      ------------------------------------------------------------------------
      -- Get the transaction that follows the ad
      ------------------------------------------------------------------------

      , full_base_data_with_next_record as (

          select
              *
              , lead(json_extract_scalar(extra_json,"$.source_id")) over (
                  partition by rdg_id
                  order by timestamp_utc asc ) as ad_reward_source_id_all

              , lead(event_name) over (
                  partition by rdg_id
                  order by timestamp_utc asc ) as ad_reward_event_name

              , lead(json_extract_scalar(extra_json,"$.transaction_purchase_currency")) over (
                  partition by rdg_id
                  order by timestamp_utc asc ) as ad_reward_transaction_purchase_currency

          from
              full_base_data
          where
              event_name in ('ad','transaction')

      )

      ------------------------------------------------------------------------
      -- filter back down to ads data only
      ------------------------------------------------------------------------

      , base_data as (

          select
              *
              , case
                  when
                      ad_reward_event_name = 'transaction'
                      and ad_reward_transaction_purchase_currency = 'REWARDED_AD'
                  then  ad_reward_source_id_all
                  else null
                  end as ad_reward_source_id
          from
              full_base_data_with_next_record
          where
              event_name = 'ad'
      )

      ------------------------------------------------------------------------
      -- data_from_extra_json
      ------------------------------------------------------------------------

      -- select extra_json from `eraser-blast.game_data.events` where date(timestamp) = '2023-02-26' and event_name = 'ad' limit 10

      , get_data_from_extra_json as (

          select
              a.rdg_id
              , timestamp(date(a.timestamp_utc)) as rdg_date
              , a.timestamp_utc
              , a.created_at
              , a.version
              , a.session_id
              , a.experiments
              , a.win_streak
              , a.ad_reward_source_id
              , 1 as count_ad_views

              -- Ad Informaion
              , json_extract_scalar(a.extra_json,"$.source_id") as source_id
              , json_extract_scalar(a.extra_json,"$.ad_source_name") ad_source_name
              , json_extract_scalar(a.extra_json,"$.ad_network") ad_network
              , json_extract_scalar(a.extra_json,"$.country") country
              , json_extract_scalar(a.extra_json,"$.current_level_id") current_level_id
              , safe_cast(json_extract_scalar(a.extra_json,"$.current_level_serial") as numeric) current_level_serial

              -- Various ways to calculate revenue
              , safe_cast(json_extract_scalar(a.extra_json,"$.publisher_revenue_per_impression") as numeric) publisher_revenue_per_impression
              , safe_cast(json_extract_scalar(a.extra_json,"$.publisher_revenue_per_impression_in_micros") as numeric) / 100 publisher_revenue_per_impression_in_micros
              , safe_cast(json_extract_scalar(a.extra_json,"$.revenue") as numeric) revenue
              , safe_cast(json_extract_scalar(a.extra_json,"$.ad_value") as numeric) ad_value

              -- currency balances
              , safe_cast(json_extract_scalar(a.currencies,"$.CURRENCY_03") as numeric) currency_03_balance
              , safe_cast(json_extract_scalar(a.currencies,"$.CURRENCY_04") as numeric) currency_04_balance
              , safe_cast(json_extract_scalar(a.currencies,"$.CURRENCY_07") as numeric) currency_07_balance

              -- round information
              , a.round_count
              , b.round_start_timestamp_utc
              , c.round_end_timestamp_utc
              , c.game_mode

          from
              base_data a
              left join my_round_start_data b
                  on a.rdg_id = b.rdg_id
                  and a.round_count = b.round_count
              left join my_round_end_data c
                  on a.rdg_id = c.rdg_id
                  and a.round_count = c.round_count
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
          , max(ad_reward_source_id) as ad_reward_source_id
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

          -- round information
          , max(round_count) as round_count
          , max(round_start_timestamp_utc) as round_start_timestamp_utc
          , max(round_end_timestamp_utc) as round_end_timestamp_utc
          , max(game_mode) as game_mode


      from
          get_data_from_extra_json
      group by
          1,2,3

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
