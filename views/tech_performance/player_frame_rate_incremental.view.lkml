view: player_frame_rate_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-07-12'


      -- create or replace table tal_scratch.player_ticket_spend_incremental as

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
                     when date(current_date()) <= '2024-07-12' -- Last Full Update
                     then '2024-06-01'
                     else date_add(current_date(), interval -9 day)
                     end
              and date(timestamp) <= date_add(current_date(), interval -1 DAY)

              -- date(timestamp) = '2024-05-14'

              ------------------------------------------------------------------------
              -- user type selection
              -- We only want users that are marked as "external"
              -- This removes any bots or internal QA accounts
              ------------------------------------------------------------------------
              and user_type = 'external'

              ------------------------------------------------------------------------
              -- this event information
              ------------------------------------------------------------------------

              and event_name = 'frame_histogram'

          )

      ------------------------------------------------------------------------
      -- data_from_extra_json
      ------------------------------------------------------------------------

      , frame_rate_histogram_breakout as (

        select
          a.rdg_id
          , a.timestamp_utc
          , a.extra_json
          , safe_cast(json_extract_scalar(a.extra_json, "$.id") as string) as sheet_id
          , safe_cast(json_extract_scalar(a.extra_json, "$.frame_time_histogram_observations") as numeric) as frame_time_histogram_observations
          , offset as ms_per_frame
          , sum(safe_cast(frame_time_histogram as int64)) as frame_count

          -- other fields
          , max(a.created_at) as created_at
          , max(a.version) as version
          , max(a.session_id) as session_id
          , max(a.experiments) as experiments
          , max(a.last_level_serial) as last_level_serial
          , max(a.engagement_ticks) as engagement_ticks

        from
          base_data a
          cross join unnest(split(json_extract_scalar(extra_json,'$.frame_time_histogram_values'))) as frame_time_histogram with offset
        group by
          1,2,3,4,5,6

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      -- select * from get_data_from_extra_json

      -- select column_name from `eraser-blast`.tal_scratch.INFORMATION_SCHEMA.COLUMNS where table_name = 'player_coin_spend_incremental' order by ordinal_position

      select
        rdg_id
        , timestamp_utc
        , a.sheet_id
        , max(timestamp(date(timestamp_utc))) as rdg_date
        , max(frame_time_histogram_observations) as frame_time_histogram_observations

        -- frame rate percentages
        , safe_divide(
          sum( case when ms_per_frame <= 22 then frame_count else 0 end )
          , sum( frame_count )
          ) as percent_frames_below_22

        , safe_divide(
          sum( case when ms_per_frame > 22 and ms_per_frame <= 40 then frame_count else 0 end )
          , sum( frame_count )
          ) as percent_frames_between_23_and_40

        , safe_divide(
          sum( case when ms_per_frame > 40 then frame_count else 0 end )
          , sum( frame_count )
          ) as percent_frames_above_40

        -- other fields
        , max(a.created_at) as created_at
        , max(a.version) as version
        , max(a.session_id) as session_id
        , max(a.experiments) as experiments
        , max(a.last_level_serial) as last_level_serial
        , max(a.engagement_ticks) as engagement_ticks

      from
        frame_rate_histogram_breakout a
      group by
        1,2,3

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
    || '_' || ${TABLE}.sheet_id
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
