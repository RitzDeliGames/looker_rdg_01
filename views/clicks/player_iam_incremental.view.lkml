view: player_iam_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-06-29'


-- create or replace table tal_scratch.player_iam_incremental as
-- select * from tal_scratch.player_iam_incremental limit 1000

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
        , last_level_serial -- definitely want this to break out the iam MTX offers
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
                when date(current_date()) <= '2023-06-29' -- Last Full Update
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

        and event_name = 'ButtonClicked' -- button clicks
        and json_extract_scalar(extra_json,"$.button_tag") like '%InAppMessaging%' -- in app messages only

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
        , round(safe_cast(engagement_ticks as int64) / 2) cumulative_time_played_minutes
        , 1 as count_iam_messages

        -- IAM Button Click Information
        , json_extract_scalar(extra_json,"$.button_tag") as button_tag

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
    , button_tag
    , max(created_at) as created_at
    , max(version) as version
    , max(session_id) as session_id
    , max(experiments) as experiments
    , max(win_streak) as win_streak
    , max(last_level_serial) as last_level_serial
    , max(count_iam_messages) as count_iam_messages
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
    || '_' || ${TABLE}.button_tag

    ;;
    primary_key: yes
    hidden: yes
  }


  dimension: rdg_id {type:string}
  dimension: button_tag {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: count_iam_messages {type:number}
  dimension: cumulative_time_played_minutes {type:number}

  # # Define your dimensions and measures here, like this:
  dimension_group: rdg_date_analysis {
    label: "In App Message Datetime"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

  measure: count_distinct_active_users {
    description: "Use this for counting lifetime orders across many users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: sum_in_app_messages {
    description: "Use this for counting lifetime orders across many users"
    type: sum
    sql: ${TABLE}.count_iam_messages ;;
  }



}
