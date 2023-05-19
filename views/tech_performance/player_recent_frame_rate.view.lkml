view: player_recent_frame_rate {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-05-19'

      -- create or replace table tal_scratch.player_recent_frame_rate as

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
              ------------------------------------------------------------------------

              date(timestamp) >= date_add(current_date(), interval -30 day)
              and date(timestamp) <= date_add(current_date(), interval -1 DAY)

              ------------------------------------------------------------------------
              -- user type selection
              -- We only want users that are marked as "external"
              -- This removes any bots or internal QA accounts
              ------------------------------------------------------------------------

              and user_type = 'external'
              and event_name in ('round_end','transition')

              ------------------------------------------------------------------------
              -- Tal Data for Single Event
              ------------------------------------------------------------------------

              -- and timestamp = '2023-04-17 20:52:55 UTC'
              -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'


          )

      -----------------------------------------------------------------------
      -- frame rate histogram breakout
      ------------------------------------------------------------------------

      , frame_rate_histogram_breakout as (
          select
              a.rdg_id
              , a.timestamp_utc
              , a.created_at
              , a.version
              , a.user_type
              , a.session_id
              , a.event_name
              , a.extra_json
              , a.experiments
              , a.win_streak
              , a.currencies
              , a.last_level_serial
              , offset as ms_per_frame
              , sum(safe_cast(frame_time_histogram as int64)) as frame_count
          from
              base_data a
              cross join unnest(split(json_extract_scalar(extra_json,'$.frame_time_histogram_values'))) as frame_time_histogram with offset
          group by
              1,2,3,4,5,6,7,8,9,10,11,12,13
      )

      -----------------------------------------------------------------------
      -- frame rate histogram collapse
      ------------------------------------------------------------------------

      , frame_rate_histogram_collapse as (
          select
              rdg_id
              , timestamp_utc
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
          from
              frame_rate_histogram_breakout a
          group by
              1,2,3,4,5,6,7,8,9,10,11,12
      )

      -----------------------------------------------------------------------
      -- extra json info
      ------------------------------------------------------------------------

      , extra_json_info as (

          select
              rdg_id
              , timestamp(date(timestamp_utc)) as rdg_date
              , timestamp_utc
              , event_name

              , created_at
              , version
              , user_type
              , session_id
              , extra_json
              , experiments
              , win_streak
              , currencies
              , last_level_serial
              , 1 as count_events

              -- frame rate percentages
              , percent_frames_below_22
              , percent_frames_between_23_and_40
              , percent_frames_above_40

              -- config timestamp
              , safe_cast(json_extract_scalar( extra_json , "$.config_timestamp") as numeric) as config_timestamp

              -- currency balances
              , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
              , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
              , safe_cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric) currency_07_balance

              -- transition event information
              , safe_cast(json_extract_scalar( extra_json , "$.transition_from") as string) as scene_transition_from
              , safe_cast(json_extract_scalar( extra_json , "$.transition_to") as string) as scene_transition_to

              -- round end information
              , safe_cast(json_extract_scalar( extra_json , "$.lives") as numeric) as lives
              , ifnull( safe_cast(json_extract_scalar( extra_json , "$.round_length") as numeric) / 60000 , 0 ) as round_length_minutes
              , safe_cast(json_extract_scalar( extra_json , "$.quest_complete") as boolean) as quest_complete
              , case when safe_cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true then 1 else 0 end as count_wins
              , case when safe_cast( json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true then 0 else 1 end as count_losses
              , safe_cast(json_extract_scalar( extra_json , "$.game_mode") as string) as game_mode
              , safe_cast(json_extract_scalar( extra_json , "$.moves_remaining") as numeric) as moves_remaining
              , safe_cast(json_extract_scalar( extra_json , "$.moves_added") as boolean) as moves_added
              , case when safe_cast( json_extract_scalar( extra_json , "$.moves_added") as boolean) = true then 1 else 0 end as count_rounds_with_moved_added
              , safe_cast(json_extract_scalar( extra_json , "$.coins_earned") as numeric) as coins_earned
              , safe_cast(json_extract_scalar( extra_json , "$.objective_count_total") as numeric) as objective_count_total
              , safe_cast(json_extract_scalar( extra_json , "$.objective_progress") as numeric) as objective_progress
              , safe_cast(json_extract_scalar( extra_json , "$.moves") as numeric) as moves
              , safe_cast(json_extract_scalar( extra_json , "$.level_serial") as numeric) as level_serial
              , safe_cast(json_extract_scalar( extra_json , "$.level_id") as string) as level_id
              , safe_cast(json_extract_scalar(extra_json,'$.team_slot_0') as string) primary_team_slot
              , safe_cast(json_extract_scalar(extra_json,'$.team_slot_skill_0') as string) primary_team_slot_skill
              , safe_cast(json_extract_scalar(extra_json,'$.team_slot_level_0') as int64) primary_team_slot_level
              , safe_cast(replace(json_extract_scalar(extra_json,'$.proximity_to_completion'),',','') as float64) proximity_to_completion
              , safe_cast(json_extract_scalar( extra_json , "$.objective_0") as numeric) as objective_0
              , safe_cast(json_extract_scalar( extra_json , "$.objective_1") as numeric) as objective_1
              , safe_cast(json_extract_scalar( extra_json , "$.objective_2") as numeric) as objective_2
              , safe_cast(json_extract_scalar( extra_json , "$.objective_3") as numeric) as objective_3
              , safe_cast(json_extract_scalar( extra_json , "$.objective_4") as numeric) as objective_4
              , safe_cast(json_extract_scalar( extra_json , "$.objective_5") as numeric) as objective_5

          from
              frame_rate_histogram_collapse

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      select
          *
      from
          extra_json_info



      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    publish_as_db_view: yes

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
    || '_' || ${TABLE}.event_name
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Date Groups
####################################################################

  dimension_group: rdg_date {
    label: "Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension_group: timestamp_utc {
    label: "Event Time"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: rdg_id {type: string}
  dimension: event_name {type: string}
  dimension: created_at {type: date}
  dimension: version {type: number}
  dimension: session_id {type: number}
  dimension: win_streak {type: number}
  dimension: last_level_serial {type: number}
  dimension: count_events  {type: number}
  dimension: percent_frames_below_22  {type: number}
  dimension: percent_frames_between_23_and_40 {type: number}
  dimension: percent_frames_above_40 {type: number}
  dimension: config_timestamp {type: number}
  dimension: currency_03_balance {type: number}
  dimension: currency_04_balance {type: number}
  dimension: currency_07_balance {type: number}
  dimension: scene_transition_from {type: string}
  dimension: scene_transition_to {type: string}
  dimension: lives {type: number}
  dimension: round_length_minutes {type: number}
  dimension: quest_complete {type: yesno}
  dimension: count_wins {type: number}
  dimension: count_losses {type: number}
  dimension: game_mode {type: string}
  dimension: moves_remaining {type: number}
  dimension: moves_added {type: number}
  dimension: count_rounds_with_moved_added {type: number}
  dimension: coins_earned {type: number}
  dimension: objective_count_total {type: number}
  dimension: objective_progress {type: number}
  dimension: moves {type: number}
  dimension: level_serial {type: number}
  dimension: level_id {type: string}
  dimension: primary_team_slot {type: string}
  dimension: primary_team_slot_skill {type: string}
  dimension: primary_team_slot_level {type: string}
  dimension: proximity_to_completion {type: number}
  dimension: objective_0 {type: number}
  dimension: objective_1 {type: number}
  dimension: objective_2 {type: number}
  dimension: objective_3 {type: number}
  dimension: objective_4 {type: number}
  dimension: objective_5 {type: number}

####################################################################
## Measures
####################################################################

  measure: count_distinct_users {
    label: "Count Distinct Users"
    type: number
    value_format_name: decimal_0
    sql:
      count(distinct ${TABLE}.rdg_id)

        ;;
  }

  measure: percent_of_events_with_frames_below_22 {
    label: "Percent Frames Below 22"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum( ${TABLE}.percent_frames_below_22 )
        ,
        ( sum( ${TABLE}.percent_frames_below_22 )
          + sum( ${TABLE}.percent_frames_between_23_and_40 )
          + sum( ${TABLE}.percent_frames_above_40 )
          )
      );;
  }
  measure: percent_of_events_with_frames_between_23_and_40 {
    label: "Percent Frames Between 23 and 40"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum( ${TABLE}.percent_frames_between_23_and_40 )
        ,
        ( sum( ${TABLE}.percent_frames_below_22 )
          + sum( ${TABLE}.percent_frames_between_23_and_40 )
          + sum( ${TABLE}.percent_frames_above_40 )
          )
      );;
  }
  measure: percent_of_events_with_frames_above_40 {
    label: "Percent Frames Above 40"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum( ${TABLE}.percent_frames_above_40 )
        ,
        ( sum( ${TABLE}.percent_frames_below_22 )
          + sum( ${TABLE}.percent_frames_between_23_and_40 )
          + sum( ${TABLE}.percent_frames_above_40 )
          )
      );;
  }


}
