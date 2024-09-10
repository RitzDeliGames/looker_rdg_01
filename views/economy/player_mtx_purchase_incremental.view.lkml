view: player_mtx_purchase_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:


      -- ccb_aggregate_update_tag
      -- update '2023-08-31'


-- create or replace table tal_scratch.player_mtx_purchase_incremental as

with

------------------------------------------------------------------------
-- Select all columns w/ the current date range
------------------------------------------------------------------------

base_data_full as (

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
        , platform
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
                when date(current_date()) <= '2024-09-10' -- Last Full Update
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

        and event_name in ( 'transaction', 'round_start', 'round_end' )
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
        base_data_full
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
        , max(safe_cast(json_extract_scalar( extra_json , "$.level_serial") as numeric)) as level_serial
        , max(safe_cast(json_extract_scalar( extra_json , "$.level_id") as string)) as level_id
    from
        base_data_full
    where
        event_name = 'round_end'
        and round_count is not null
    group by
        1,2
    )

------------------------------------------------------------------------
-- base data for transactions only
------------------------------------------------------------------------

, base_data as (

    select
        *
    from
        base_data_full
    where
        event_name = 'transaction'
        and json_extract_scalar(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_01' -- real dollars
        and (
              (
                  platform like '%Android%'
                  and json_extract_scalar(extra_json,"$.rvs_id") LIKE '%GPA%' -- check for valid transactions on Google Play
                )
              OR (
                  platform like '%iOS%'
                  and length(json_extract_scalar(extra_json,"$.rvs_id")) > 2 -- check for valid transactions on Apple
                )
              )
    )


------------------------------------------------------------------------
-- data_from_extra_json
------------------------------------------------------------------------

-- select extra_json from base_data limit 10

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
        , a.last_level_serial
        , round(safe_cast(a.engagement_ticks as int64) / 2) cumulative_time_played_minutes
        , 1 as count_mtx_purchases
        , a.round_count
        , a.platform

        -- MTX Purchase Informaion
        , json_extract_scalar(a.extra_json,"$.source_id") as source_id
        , json_extract_scalar(a.extra_json,"$.store_session_id") store_session_id
        , json_extract_scalar(a.extra_json,"$.iap_purchase_item") iap_purchase_item
        , safe_cast(json_extract_scalar(a.extra_json,"$.iap_purchase_qty") as numeric) iap_purchase_qty
        , json_extract_scalar(a.extra_json,"$.transaction_id") transaction_id
        , json_extract_scalar(a.extra_json,'$.iap_id') iap_id

        -- purchase amount + app store cut
          , ifnull(safe_cast(json_extract_scalar(a.extra_json,"$.transaction_purchase_amount") as numeric) * 0.01 * 0.70 ,0) mtx_purchase_dollars

        -- currency balances
        , safe_cast(json_extract_scalar(a.currencies,"$.CURRENCY_03") as numeric) currency_03_balance
        , safe_cast(json_extract_scalar(a.currencies,"$.CURRENCY_04") as numeric) currency_04_balance
        , safe_cast(json_extract_scalar(a.currencies,"$.CURRENCY_07") as numeric) currency_07_balance

        -- round information
        , b.round_start_timestamp_utc
        , c.round_end_timestamp_utc
        , c.game_mode
        , c.level_id
        , c.level_serial

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
    , max(iap_id) as iap_id
    , max(mtx_purchase_dollars) as mtx_purchase_dollars
    , max(currency_03_balance) as coins_balance
    , max(currency_04_balance) as lives_balance
    , max(currency_07_balance) as stars_balance
    , max(cumulative_time_played_minutes) as cumulative_time_played_minutes

    -- round_information
    , max(round_count) as round_count
    , max(game_mode) as round_game_mode
    , max(round_start_timestamp_utc) as round_start_timestamp_utc
    , max(round_end_timestamp_utc) as round_end_timestamp_utc
    , max(case
        when timestamp_utc between round_start_timestamp_utc and round_end_timestamp_utc
        then 'in_round'
        else 'out_of_round'
        end
        ) as round_purchase_type
    , max(level_serial) as level_serial
    , max(level_id) as level_id

from
    get_data_from_extra_json
group by
    1,2,3,4


      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (1) + 2 )*( -10 ) minute)) ;;
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
