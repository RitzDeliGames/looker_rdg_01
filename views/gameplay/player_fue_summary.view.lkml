view: player_fue_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-11-06'

      -- create or replace table tal_scratch.player_fue_summary as

      with


      ---------------------------------------------------------------------------
      -- base table with cumulative fields
      ---------------------------------------------------------------------------

      base_table_with_cumulative_fields as (

        select

          -- All columns from player_fue_incremental
          *

          -- Player Age Information
          , timestamp(date(created_at)) as created_date -- Created Date
          , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
          , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

          , 1 as count_events
          -- Cumulative fields
          , sum(1) over (
              partition by rdg_id, first_play_specific_step
              order by timestamp_utc asc
              rows between unbounded preceding and current row
              ) first_play_specific_step_instance_number

        from
          -- eraser-blast.looker_scratch.LR_6YGI01699294061538_player_fue_incremental
          ${player_fue_incremental.SQL_TABLE_NAME}

      )

      ---------------------------------------------------------------------------
      -- output
      ---------------------------------------------------------------------------

      select
        *
      from
        base_table_with_cumulative_fields
      where
        first_play_specific_step_instance_number = 1

        -- test with my data
        -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'

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
    || '_' || ${TABLE}.first_play_specific_step
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
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  # dates
  dimension_group: timestamp_utc {
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
  dimension: event_name {type:string}
  dimension: first_play_specific_step {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}

  # Numbers
  dimension: first_play_specific_steps_order {type:number}
  dimension: cumulative_time_played_minutes {type:number}


################################################################
## Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  ## Event Counts
  measure: sum_events {
    type: sum
    sql: ${TABLE}.count_events ;;
  }

}
