view: player_coin_source_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-07-05'



-- create or replace table tal_scratch.player_coin_source_incremental as

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
                when date(current_date()) <= '2023-07-05' -- Last Full Update
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

        and (
            -- coins from rewards
            ( event_name = 'reward'
            and json_extract_scalar(extra_json,"$.reward_type") = 'CURRENCY_03' )

            or
            -- coins from in app purchases
            -- here we pull all in app purchases, because coins also come in bundles
            ( event_name = 'transaction'
                and json_extract_scalar(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_01' -- real dollars
                and (
                    json_extract_scalar(extra_json,"$.rvs_id") like '%GPA%' -- check for valid transactions on Google Play
                    or json_extract_scalar(extra_json,"$.rvs_id") like '%AppleAppStore%' -- check for valid transactions on Apple
                    )
            )
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
        , 1 as count_coin_source_events

        --------------------------------------------------------------------------------------------
        -- coin source info
        --------------------------------------------------------------------------------------------

        -- level info
        , safe_cast(json_extract_scalar(extra_json,"$.level_serial") as numeric) level_serial
        , json_extract_scalar(extra_json,"$.level_id") level_id

        -- event name
        , event_name as coin_source_type

        -- coin source
        , case
            when event_name = 'reward' then json_extract_scalar(extra_json,"$.reward_event")
            when event_name = 'transaction' then json_extract_scalar(extra_json,"$.source_id")
            else 'Error' end as coin_source

        -- iap id
        , case
            when event_name = 'reward' then json_extract_scalar(extra_json,"$.reward_event")
            when event_name = 'transaction' then json_extract_scalar(extra_json,"$.iap_id")
            else 'Error' end as coin_source_iap_item

        -- coin source amount
        , case
            when event_name = 'reward' then ifnull(safe_cast(json_extract_scalar(extra_json,"$.reward_amount") as numeric),0)
            when (
                event_name = 'transaction'
                and json_extract_scalar(extra_json,"$.iap_purchase_item") = 'CURRENCY_03'
                )
                then ifnull(safe_cast(json_extract_scalar(extra_json,"$.iap_purchase_qty") as numeric),0)

            else 0 end as coin_source_amount

        --------------------------------------------------------------------------------------------
        -- currency balances
        --------------------------------------------------------------------------------------------

        , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
        , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
        , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric) currency_07_balance

    from
        base_data

)

------------------------------------------------------------------------
-- output for view
------------------------------------------------------------------------

-- select * from get_data_from_extra_json

-- select column_name from `eraser-blast`.tal_scratch.INFORMATION_SCHEMA.COLUMNS where table_name = 'player_coin_source_incremental' order by ordinal_position

select
    -- primary key
    rdg_id
    , rdg_date
    , timestamp_utc
    , coin_source_type
    , coin_source_iap_item

    -- other fields
    , max( created_at ) as created_at
    , max( version ) as version
    , max( session_id ) as session_id
    , max( experiments ) as experiments
    , max( win_streak ) as  win_streak
    , max( last_level_serial ) as last_level_serial
    , max( cumulative_time_played_minutes ) as cumulative_time_played_minutes
    , max( count_coin_source_events ) as count_coin_source_events
    , max( level_serial ) as level_serial
    , max( level_id ) as level_id
    , max( coin_source ) as coin_source
    , max( coin_source_amount ) as coin_source_amount
    , max( currency_03_balance ) as currency_03_balance
    , max( currency_04_balance ) as currency_04_balance
    , max( currency_07_balance ) as currency_07_balance

from
    get_data_from_extra_json
group by
    1,2,3,4,5



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
      || '_' || ${TABLE}.coin_source_type
      || '_' || ${TABLE}.coin_source_iap_item

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

  ## I believe you need this as a separate field or you will get the
  ## "build skipped due to error in required child" error when trying to rebuild
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
