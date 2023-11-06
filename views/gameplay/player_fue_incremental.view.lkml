view: player_fue_incremental {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-11-06'

      -- create or replace table tal_scratch.player_fue_incremental as

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
              -- eraser-blast.tal_scratch.date_2023_02_23_tal_only_data
          where

              ------------------------------------------------------------------------
              -- Date selection
              -- We use this because the FIRST time we run this query we want all the data going back
              -- but future runs we only want the last 9 days
              ------------------------------------------------------------------------

              date(timestamp) >=
                  case
                      -- select date(current_date())
                      when date(current_date()) <= '2023-11-06' -- Last Full Update
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

              and event_name in ( 'FUE' , 'NewUser', 'TitleScreenAwake', 'round_start', 'round_end', 'transition' )

              ------------------------------------------------------------------------
              -- my information only
              ------------------------------------------------------------------------

              -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'
              -- and date(timestamp) >= '2023-02-17'
              -- and date(timestamp) <= '2023-02-18'
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

              -- fue information
              , event_name
              , safe_cast(json_extract_scalar(extra_json, "$.current_FueStep") as string) as current_FueStep
              , safe_cast(json_extract_scalar(extra_json, "$.current_ChoreographyStepId") as int64) as current_ChoreographyStepId
              , safe_cast(json_extract_scalar(extra_json, "$.level_serial") as int64) as level_serial
              , safe_cast(json_extract_scalar(extra_json, "$.transition_from") as string) as transition_from
              , safe_cast(json_extract_scalar(extra_json, "$.transition_to") as string) as transition_to

          from
              base_data a
      )

      ------------------------------------------------------------------------
      -- define first play specific steps
      ------------------------------------------------------------------------

      , define_first_play_specific_steps as (

          select
            *
            , case
                when event_name = 'NewUser' then 'NewUser'
                when event_name = 'TitleScreenAwake' then 'TitleScreenAwake'
                when
                  event_name = 'FUE'
                  and current_FueStep = 'FIRST_PLAY'
                  and current_ChoreographyStepId = 1
                  then 'FUE_FIRST_PLAY_Step_1'
                when
                  event_name = 'round_start'
                  and level_serial = 0
                  then 'round_start_0'
                when
                  event_name = 'round_start'
                  and level_serial = 0
                  then 'round_start_0'
                when
                  event_name = 'round_start'
                  and level_serial = 1
                  then 'round_start_1'
                when
                  event_name = 'FUE'
                  and current_FueStep = 'FIRST_PLAY'
                  and current_ChoreographyStepId = 0
                  then 'FUE_FIRST_PLAY_Step_0'
                when
                  event_name = 'round_end'
                  and level_serial = 0
                  then 'round_end_0'
                when
                  event_name = 'transition'
                  and transition_from = 'GameScene'
                  and transition_to = 'MetaScene'
                  then 'first_transition_GameScene_to_MetaScene'
                when
                  event_name = 'FUE'
                  and current_FueStep = 'TASKS_0'
                  and current_ChoreographyStepId = 0
                  then 'FUE_TASKS_0_Step_0'
                when
                  event_name = 'FUE'
                  and current_FueStep = 'TASKS_0'
                  and current_ChoreographyStepId = 1
                  then 'FUE_TASKS_0_Step_1'
                when
                  event_name = 'FUE'
                  and current_FueStep = 'TASKS_1'
                  and current_ChoreographyStepId = 0
                  then 'FUE_TASKS_1_Step_0'
                when
                  event_name = 'FUE'
                  and current_FueStep = 'TASKS_1'
                  and current_ChoreographyStepId = 1
                  then 'FUE_TASKS_1_Step_1'

                when
                  event_name = 'round_end'
                  and level_serial = 1
                  then 'round_end_1'

                when
                  event_name = 'FUE'
                  then 'FUE_' || current_FueStep

               else null
               end as first_play_specific_step

          from
            get_data_from_extra_json


      )

      ------------------------------------------------------------------------
      -- define order of first play specific steps
      ------------------------------------------------------------------------

      , define_order_of_first_play_specific_steps as (

          select
              *
              , case
                  when first_play_specific_step = 'NewUser' then 1
                  when first_play_specific_step = 'TitleScreenAwake' then 2
                  when first_play_specific_step = 'FUE_FIRST_PLAY_Step_1' then 3
                  when first_play_specific_step = 'round_start_0' then 4
                  when first_play_specific_step = 'FUE_FIRST_PLAY_1' then 5
                  when first_play_specific_step = 'FUE_FIRST_PLAY_2' then 6
                  when first_play_specific_step = 'FUE_FIRST_PLAY_Step_0' then 7
                  when first_play_specific_step = 'round_end_0' then 8
                  when first_play_specific_step = 'first_transition_GameScene_to_MetaScene' then 9
                  when first_play_specific_step = 'FUE_TASKS_0_Step_0' then 10
                  when first_play_specific_step = 'FUE_TASKS_0_Step_1' then 11
                  when first_play_specific_step = 'FUE_TASKS_1_Step_0' then 12
                  when first_play_specific_step = 'FUE_TASKS_1_Step_1' then 13
                  when first_play_specific_step = 'round_start_1' then 14
                  when first_play_specific_step = 'FUE_CUPCAKE_FTUV2' then 15
                  when first_play_specific_step = 'round_end_1' then 16
                  when first_play_specific_step = 'FUE_POWERUP_FTUV2_1' then 17
                  when first_play_specific_step = 'FUE_POWERUP_FTUV2_2' then 18
                  when first_play_specific_step = 'FUE_POWERUP_COMBO_1' then 19
                  when first_play_specific_step = 'FUE_PREGAME_FTUV2' then 20
                  when first_play_specific_step = 'FUE_DONUTS_FTUV2' then 21
                  when first_play_specific_step = 'FUE_CLEAR_SKILL_FTUV2_0' then 22
                  when first_play_specific_step = 'FUE_CLEAR_SKILL_FTUV2_1' then 23
                  when first_play_specific_step = 'FUE_CLEAR_SKILL_FTUV2_2' then 24
                  when first_play_specific_step = 'FUE_COOKIES_FTUV2' then 25
                  when first_play_specific_step = 'FUE_VERTICAL_SKILL_FTUV2_0' then 26
                  when first_play_specific_step = 'FUE_VERTICAL_SKILL_FTUV2_1' then 27
                  when first_play_specific_step = 'FUE_VERTICAL_SKILL_FTUV2_2' then 28
                  when first_play_specific_step = 'FUE_BUBBLES_FTUV2_1' then 29
                  when first_play_specific_step = 'FUE_BUBBLES_FTUV2_2' then 30
                  when first_play_specific_step = 'FUE_HORIZONTAL_SKILL_FTUV2_0' then 31
                  when first_play_specific_step = 'FUE_HORIZONTAL_SKILL_FTUV2_1' then 32
                  when first_play_specific_step = 'FUE_HORIZONTAL_SKILL_FTUV2_2' then 33
                  when first_play_specific_step = 'FUE_HONEY' then 34
                  else null
                  end as first_play_specific_steps_order
          from
              define_first_play_specific_steps

      )

      ------------------------------------------------------------------------
      -- output for view
      ------------------------------------------------------------------------

      select
        rdg_id
        , rdg_date
        , timestamp_utc
        , first_play_specific_step
        , max( event_name ) as event_name
        , max( first_play_specific_steps_order ) as first_play_specific_steps_order
        , max( current_FueStep ) as current_FueStep
        , max( current_ChoreographyStepId ) as current_ChoreographyStepId
        , max( level_serial ) as level_serial
        , max( transition_from ) as transition_from
        , max( transition_to ) as transition_to
        , max( created_at ) as created_at
        , max( version ) as version
        , max( session_id ) as session_id
        , max( experiments ) as experiments
        , max( win_streak ) as win_streak
        , max( last_level_serial ) as last_level_serial
        , max( cumulative_time_played_minutes ) as cumulative_time_played_minutes
        , max( count_errors ) as count_errors
        , max( round_count ) as round_count
      from
          define_order_of_first_play_specific_steps
      where
          first_play_specific_step is not null
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
    || '_' || ${TABLE}.first_play_specific_step
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
