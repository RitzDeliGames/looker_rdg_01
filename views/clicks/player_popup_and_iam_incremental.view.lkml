view: player_popup_and_iam_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-11-18'

      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      select
        rdg_id
        , timestamp(date(timestamp)) as rdg_date
        , timestamp as timestamp_utc
        , safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) as button_tag
        , max( created_at ) as created_at
        , max( version ) as version
        , max( user_type ) as user_type
        , max( session_id ) as session_id
        , max( event_name ) as event_name
        , max( extra_json ) as extra_json
        , max( experiments ) as experiments
        , max( win_streak ) as win_streak
        , max( currencies ) as currencies
        , max( last_level_serial ) as last_level_serial
        , max( engagement_ticks ) as engagement_ticks
        , max( round(safe_cast(engagement_ticks as int64) / 2) ) as cumulative_time_played_minutes
        , max( 1 ) as count_iam_messages

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
      when date(current_date()) <= '2024-11-18' -- Last Full Update
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
      and (
            safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_PM_%'
            or safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_InAppMessaging_%'
        )

    group by
      1,2,3,4

      ;;
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
    || '_' || ${TABLE}.button_tag
      ;;
    primary_key: yes
    hidden: yes
  }

  dimension_group: rdg_date_analysis {
    label: "Activity"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

####################################################################
## Measures
####################################################################

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

}
