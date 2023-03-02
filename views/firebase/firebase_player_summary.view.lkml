view: firebase_player_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-03-01'

      WITH

      -----------------------------------------------------------------------
      -- Get base data
      -----------------------------------------------------------------------

      latest_update_table as (
        select
          max(date(rdg_date)) as latest_update

        from
          `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_daily_incremental`

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
          , FIRST_VALUE(firebase_advertising_id) OVER (
            PARTITION BY firebase_user_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) firebase_advertising_id

          -- platform
          , FIRST_VALUE(firebase_platform) OVER (
            PARTITION BY firebase_user_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) firebase_platform

          -- created_date
          , FIRST_VALUE(firebase_created_date) OVER (
            PARTITION BY firebase_user_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) firebase_created_date


      FROM
        `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_daily_incremental`
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
      -- Select output
      -----------------------------------------------------------------------

      SELECT
        A.*
      FROM
        summarize_data A


      ;;
    sql_trigger_value: select sum(1) from `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary` ;;
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
