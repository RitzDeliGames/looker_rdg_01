view: player_error_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-09-27'


-- create or replace table tal_scratch.player_error_incremental as

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
                when date(current_date()) <= '2023-09-27' -- Last Full Update
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

        and event_name = 'errors'
    )

------------------------------------------------------------------------
-- data_from_extra_json
------------------------------------------------------------------------

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
        , 1 as count_errors
        , a.round_count
        , a.extra_json

        -- error information
        , json_query_array( extra_json, "$.logs" )[0] as my_error

    from
        base_data a
)

------------------------------------------------------------------------
-- find first colon in error log
------------------------------------------------------------------------

, find_starting_colon as (

  select
    *
    , strpos(my_error, ':') as starting_colon
  from
    get_data_from_extra_json
)

------------------------------------------------------------------------
-- find ending color or comma
------------------------------------------------------------------------

, find_ending_comma_or_colon as (

  select
    *
    , right(my_error,length(my_error)-starting_colon) as my_error_excluding_frame
    , strpos(right(my_error,length(my_error)-starting_colon), ':' ) as ending_colon
    , strpos(right(my_error,length(my_error)-starting_colon), ',' ) as ending_comma
  from
    find_starting_colon

)

------------------------------------------------------------------------
-- fix ending colon/comma
------------------------------------------------------------------------


, fix_endings as (

select
  *
  , case when ending_colon = 0 then null else ending_colon end as ending_colon_fixed
  , case when ending_comma = 0 then null else ending_comma end as ending_comma_fixed
from find_ending_comma_or_colon

)

------------------------------------------------------------------------
-- get simplified error
------------------------------------------------------------------------

, get_simplified_error as (

select
  *
  , left(
      right(my_error,length(my_error)-starting_colon-1)
      , case
          when ending_colon_fixed is not null and ending_comma_fixed is null then ending_colon_fixed-2
          when ending_comma_fixed is not null and ending_colon_fixed is null then ending_comma_fixed-2
          when ending_colon_fixed < ending_comma_fixed then ending_colon_fixed-2
          when ending_comma_fixed < ending_comma_fixed then ending_colon_fixed-2
          else length(right(my_error,length(my_error)-starting_colon-1))
          end ) as simplified_error

from fix_endings

)

------------------------------------------------------------------------
-- output for view
------------------------------------------------------------------------

select
  rdg_id
  , rdg_date
  , timestamp_utc
  , extra_json
  , max( created_at ) as created_at
  , max( version ) as version
  , max( session_id ) as session_id
  , max( experiments ) as experiments
  , max( win_streak ) as win_streak
  , max( last_level_serial ) as last_level_serial
  , max( cumulative_time_played_minutes ) as cumulative_time_played_minutes
  , max( count_errors ) as count_errors
  , max( round_count ) as round_count
  , max( my_error ) as my_full_error
  , max( my_error_excluding_frame ) as my_error_excluding_frame
  , max( simplified_error ) as simplified_error

from
    get_simplified_error
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
    || '_' || ${TABLE}.extra_json
    ;;
    primary_key: yes
    hidden: yes
  }

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
    sql: ${TABLE}.rdg_id ;;
  }
}
