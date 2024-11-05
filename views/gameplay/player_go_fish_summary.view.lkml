view: player_go_fish_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-11-04

      with

      --------------------------------------------------
      -- get the extra json
      --------------------------------------------------

      my_extra_json_table as (

        select
          *
          , safe_cast(json_extract_scalar( extra_json , "$.player_rank") as string) as player_rank
          , safe_cast(json_extract_scalar( extra_json , "$.opponent_display_name") as string) as opponent_display_name
          , safe_cast(json_extract_scalar( extra_json , "$.opponent_moves_remaining") as numeric) as opponent_moves_remaining
          , safe_cast(json_extract_scalar( extra_json , "$.base_rank_up_points") as numeric) as base_rank_up_points
          , safe_cast(json_extract_scalar( extra_json , "$.total_rank_points_earned") as numeric) as total_rank_points_earned
          , safe_cast(json_extract_scalar( extra_json , "$.rank_up_true_false") as boolean) as rank_up_true_false
          , safe_cast(json_extract_scalar( extra_json , "$.rank_up_reward") as string) as rank_up_reward
          , safe_cast(json_extract_scalar( extra_json , "$.rank_up_reward_amount") as numeric) as rank_up_reward_amount
          , safe_cast(json_extract_scalar( extra_json , "$.config_timestamp") as numeric) as config_timestamp
          , safe_cast(json_extract_scalar( extra_json , "$.frame_count") as numeric) as frame_count
          , safe_cast(json_extract_scalar( extra_json , "$.round_count") as numeric) as round_count
          , safe_cast(json_extract_scalar( extra_json , "$.errors_this_session") as numeric) as errors_this_session
        from
          -- eraser-blast.looker_scratch.LR_6Y1IP1730770397241_player_go_fish_incremental
          ${player_go_fish_incremental.SQL_TABLE_NAME}
        -- where
        --   date(rdg_date) = '2024-11-03'
      )

      --------------------------------------------------
      -- Additional Calculations
      --------------------------------------------------

      , additional_calculations_table as (

        select
          *
          , safe_cast( right(player_rank, 2) as numeric) as player_rank_number
          , timestamp(created_at) as created_date_timestamp
          , date_diff(date(rdg_date), date(created_at), day) AS days_since_created
          , 1 + date_diff(date(rdg_date), date(created_at), day) AS day_number
          , safe_cast(version as numeric) as version_number
        from
          my_extra_json_table

      )

      --------------------------------------------------
      -- Output
      --------------------------------------------------

      select * from additional_calculations_table



      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -3 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (3) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

  ####################################################################
  ## Primary Key
  ####################################################################

  dimension: primary_key {
    type: string
    sql:
      ${TABLE}.rdg_id
      || '_' || ${TABLE}.event_id
      ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension_group: rdg_date {
    label: "Activity"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: timestamp_utc {type: date_time}

  dimension_group: created_date {
    label: "Install"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.created_date_timestamp ;;
  }

  dimension: rdg_id {type:string}
  dimension: version {type: string}
  dimension: session_id {type: string}
  dimension: event_name {type: string}
  dimension: opponent_display_name {type: string}
  dimension: total_rank_points_earned {type: string}
  dimension: rank_up_true_false {type: yesno}
  dimension: rank_up_reward {type: string}
  dimension: player_rank {type: string}

  dimension: version_number {type: number}
  dimension: win_streak {type: number}
  dimension: last_level_serial {type: number}
  dimension: engagement_ticks {type: number}
  dimension: opponent_moves_remaining {type: number}
  dimension: base_rank_up_points {type: number}
  dimension: rank_up_reward_amount {type: number}
  dimension: config_timestamp {type: number}
  dimension: frame_count {type: number}
  dimension: round_count {type: number}
  dimension: player_rank_number {type: number}
  dimension: days_since_created {type: number}
  dimension: day_number {type: number}

################################################################
## Measures
################################################################

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: count_instances {
    label: "Count Instances"
    type: number
    sql: sum(1) ;;
  }

}
