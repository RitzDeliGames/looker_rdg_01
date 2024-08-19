view: moves_master_recap_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-09-19'

      -- create or replace table tal_scratch.moves_master_recap_summary

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
        ${moves_master_recap_incremental.SQL_TABLE_NAME}
      -- where
      --   rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba' -- me
      --   and date(rdg_date) between '2024-07-01' and '2024-08-18'

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
  dimension:event_id {type:string}
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


################################################################
## Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

}
