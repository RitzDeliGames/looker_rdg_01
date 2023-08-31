view: firebase_player_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-30'

       -- CREATE OR REPLACE TABLE `tal_scratch.firebase_player_summary` AS


      WITH

      -----------------------------------------------------------------------
      -- Get base data
      -----------------------------------------------------------------------

      latest_update_table as (
        select
          max(date(rdg_date)) as latest_update

        from
          -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_daily_incremental`
          ${firebase_player_daily_incremental.SQL_TABLE_NAME}

      )


      -----------------------------------------------------------------------
      -- Get values from player summary
      -----------------------------------------------------------------------

      , pre_aggregate_calculations_from_base_data AS (

      SELECT

          firebase_user_id
          , latest_update_table.latest_update
          , rdg_date

          -- device_id
          , first_value(firebase_advertising_id) OVER (
            PARTITION BY firebase_user_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) firebase_advertising_id

          -- platform
          , first_value(firebase_platform) OVER (
            PARTITION BY firebase_user_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) firebase_platform

          -- created_date
          , first_value(firebase_created_date) OVER (
            PARTITION BY firebase_user_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) firebase_created_date


      FROM
          -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_daily_incremental`
          ${firebase_player_daily_incremental.SQL_TABLE_NAME}
        , latest_update_table

      )

      -----------------------------------------------------------------------
      -- Summarize Data
      -----------------------------------------------------------------------

      , summarize_data AS (

        select
            firebase_user_id
            , max(rdg_date) as last_played_date
            , max(latest_update) as latest_table_update
            , max(firebase_advertising_id) as firebase_advertising_id
            , max(firebase_platform) as firebase_platform
            , max(firebase_created_date) as firebase_created_date

        FROM
          pre_aggregate_calculations_from_base_data
        GROUP BY
          1

      )

      -----------------------------------------------------------------------
      -- De Dupe Advertising ID Step 1
      -----------------------------------------------------------------------

      , de_dupe_advertising_id_step_1 AS (

      SELECT

            -- firebase_user_id
            -- , max(rdg_date) as last_played_date
            -- , max(latest_update) as latest_table_update
            -- , max(firebase_advertising_id) as firebase_advertising_id
            -- , max(firebase_platform) as firebase_platform
            -- , max(firebase_created_date) as firebase_created_date

          firebase_advertising_id

          , first_value(firebase_user_id) over (
              partition by firebase_advertising_id
              order by last_played_date
              rows between unbounded preceding and unbounded following

          ) as firebase_user_id

          , last_value(last_played_date) over (
              partition by firebase_advertising_id
              order by last_played_date
              rows between unbounded preceding and unbounded following

          ) as last_played_date

          , last_value(latest_table_update) over (
              partition by firebase_advertising_id
              order by last_played_date
              rows between unbounded preceding and unbounded following

          ) as latest_table_update

          , last_value(firebase_platform) over (
              partition by firebase_advertising_id
              order by last_played_date
              rows between unbounded preceding and unbounded following

          ) as firebase_platform

          , first_value(firebase_created_date) over (
              partition by firebase_advertising_id
              order by last_played_date
              rows between unbounded preceding and unbounded following

          ) as firebase_created_date

      FROM
        summarize_data
      where
        firebase_advertising_id is not null

      )

      -----------------------------------------------------------------------
      -- Summarize Data
      -----------------------------------------------------------------------

      , de_dupe_advertising_id_step_2 AS (

        select
            firebase_advertising_id
            , max(last_played_date) as last_played_date
            , max(latest_table_update) as latest_table_update
            , max(firebase_user_id) as firebase_user_id
            , max(firebase_platform) as firebase_platform
            , max(firebase_created_date) as firebase_created_date

        FROM
          de_dupe_advertising_id_step_1
        GROUP BY
          1

      )

      -----------------------------------------------------------------------
      -- Select output
      -----------------------------------------------------------------------

      SELECT
        A.*
      FROM
        de_dupe_advertising_id_step_2 A

      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (2) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["firebase_created_date"]

  }

################################################################
## Dimensions
################################################################

  # strings
  dimension: firebase_user_id {type: string}
  dimension: firebase_advertising_id {type: string}
  dimension: firebase_platform {type: string}

  # dates
  dimension_group: last_played_date {
    type: time
    timeframes: [date, week, month, year]
  }
  dimension_group: firebase_created_date {
    type: time
    timeframes: [date, week, month, year]
  }

################################################################
## Measures
################################################################

  # Player Count
  measure: count_distinct_players {
    type: count_distinct
    sql: ${TABLE}.firebase_user_id ;;
  }


}
