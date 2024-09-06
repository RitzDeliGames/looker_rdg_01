view: moves_master_recap_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-09-19'

      -- create or replace table tal_scratch.moves_master_recap_summary

            with

      my_event_id_table as (
        select
          event_id
          , safe_cast( right(event_id,3) as int64 ) as event_number
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_moves_master_recap_incremental
          ${moves_master_recap_incremental.SQL_TABLE_NAME}
        group by
          1
      )

      , my_event_id_with_previous_table as (
        select
          event_id
          , event_number
          , lag(event_id) over ( order by event_number asc) as previous_event_id_for_all_players
          , lag(event_number) over ( order by event_number asc) as previous_event_number_for_all_players
        from
          my_event_id_table

      )

      , base_data_with_starting_lags as (

        select
          *

          -- previous event info
          , lag(event_id) over (partition by rdg_id order by timestamp_utc) as previous_event_id
          , lag(player_event_rank) over (partition by rdg_id order by timestamp_utc) as previous_player_event_rank
          , lag(player_count) over (partition by rdg_id order by timestamp_utc) as previous_player_count
          , lag(score) over (partition by rdg_id order by timestamp_utc) as previous_score
          , lag(instance_id) over (partition by rdg_id order by timestamp_utc) as previous_instance_id
          , lag(tier) over (partition by rdg_id order by timestamp_utc) as previous_tier
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_moves_master_recap_incremental
          ${moves_master_recap_incremental.SQL_TABLE_NAME}

      )

        select
          a.*
          , b.event_number
          , b.previous_event_id_for_all_players
          , b.previous_event_number_for_all_players
        from
          base_data_with_starting_lags a
          left join my_event_id_with_previous_table b
            on a.event_id = b.event_id



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
      || '_' || ${TABLE}.rdg_date
      || '_' || ${TABLE}.timestamp_utc
      ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

################################################################
## Dimensions
################################################################

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  # dates
  dimension_group: rdg_date {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

  dimension_group: created_date_timestamp {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_at ;;
  }

  # Strings
  dimension: rdg_id {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: event_id {type:string}
  dimension: instance_id {type:string}
  dimension: reward_0 {type:string}
  dimension: reward_0_type {type:string}
  dimension: reward_1 {type:string}
  dimension: reward_1_type {type:string}
  dimension: reward_2 {type:string}
  dimension: reward_2_type {type:string}
  dimension: reward_3 {type:string}
  dimension: reward_3_type {type:string}
  dimension: previous_event_id {type:string}
  dimension: previous_instance_id {type:string}
  dimension: previous_event_id_for_all_players {type:string}

  # Numbers
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: count_events {type:number}
  dimension: player_event_rank {type:number}
  dimension: player_count {type:number}
  dimension: score {type:number}
  dimension: tier {type:number}
  dimension: reward_0_amount {type:number}
  dimension: reward_1_amount {type:number}
  dimension: reward_2_amount {type:number}
  dimension: reward_3_amount {type:number}
  dimension: previous_player_event_rank {type:number}
  dimension: previous_player_count {type:number}
  dimension: previous_score {type:number}
  dimension: previous_tier {type:number}
  dimension: event_number {type:number}
  dimension: previous_event_number_for_all_players {type:number}

  # Custom
  dimension: played_last_event {
    type: string
    sql:
      case
        when ${TABLE}.previous_event_id_for_all_players = ${TABLE}.previous_event_id
        then 'Yes'
        else 'No'
        end
    ;;
    }
  dimension: tier_placement_audit {
    type: string
    sql:
      case
        when
          ${TABLE}.previous_event_id_for_all_players = ${TABLE}.previous_event_id
          and ${TABLE}.previous_player_event_rank >= 1
          and ${TABLE}.previous_player_event_rank <= 5
          and ${TABLE}.tier = 1
        then 'Tier 1, Played Prior Week w/ Rank Between 1 and 5'
        when
          ${TABLE}.previous_event_id_for_all_players = ${TABLE}.previous_event_id
          and ${TABLE}.previous_player_event_rank >= 6
          and ${TABLE}.previous_player_event_rank <= 10
          and ${TABLE}.tier = 2
          then 'Tier 2, Played Prior Week w/ Rank Between 6 and 10'
        when
          ${TABLE}.previous_event_id_for_all_players <> ${TABLE}.previous_event_id
          and ${TABLE}.previous_player_event_rank is not null
          and ${TABLE}.tier = 3
          then 'Tier 3, Did Not Play Prior Week'
        when
          ${TABLE}.previous_event_id is null
          -- and ${TABLE}.previous_player_event_rank is null
          and ${TABLE}.tier = 3
          then 'Tier 3, No Prior Recap Data or Played Prior Week w/ Rank > 10'
        else
          'Other'
        end
    ;;
  }

################################################################
## Player Counts
################################################################

  ## Player Counts
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
