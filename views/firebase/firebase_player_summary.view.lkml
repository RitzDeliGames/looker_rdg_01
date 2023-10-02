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
          `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_daily_incremental`
          -- ${firebase_player_daily_incremental.SQL_TABLE_NAME}

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
          `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_daily_incremental`
          -- ${firebase_player_daily_incremental.SQL_TABLE_NAME}
        , latest_update_table

      )

      -----------------------------------------------------------------------
      -- Calculate Day Number
      -----------------------------------------------------------------------

      , calculate_day_number as (

          select
            *
            , date_diff(date(rdg_date), date(firebase_created_date), day)+1 as day_number
          from
            pre_aggregate_calculations_from_base_data

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

            -- retention
            , max(date_diff(date(latest_update),date(firebase_created_date),DAY) + 1) as max_available_day_number
            , max( case when day_number = 2 then 1 else 0 end ) as retention_d2
            , max( case when day_number = 3 then 1 else 0 end ) as retention_d3
            , max( case when day_number = 4 then 1 else 0 end ) as retention_d4
            , max( case when day_number = 5 then 1 else 0 end ) as retention_d5
            , max( case when day_number = 6 then 1 else 0 end ) as retention_d6
            , max( case when day_number = 7 then 1 else 0 end ) as retention_d7
            , max( case when day_number = 8 then 1 else 0 end ) as retention_d8
            , max( case when day_number = 9 then 1 else 0 end ) as retention_d9
            , max( case when day_number = 10 then 1 else 0 end ) as retention_d10
            , max( case when day_number = 11 then 1 else 0 end ) as retention_d11
            , max( case when day_number = 12 then 1 else 0 end ) as retention_d12
            , max( case when day_number = 13 then 1 else 0 end ) as retention_d13
            , max( case when day_number = 14 then 1 else 0 end ) as retention_d14
            , max( case when day_number = 15 then 1 else 0 end ) as retention_d15
            , max( case when day_number = 21 then 1 else 0 end ) as retention_d21
            , max( case when day_number = 30 then 1 else 0 end ) as retention_d30
            , max( case when day_number = 31 then 1 else 0 end ) as retention_d31
            , max( case when day_number = 46 then 1 else 0 end ) as retention_d46
            , max( case when day_number = 60 then 1 else 0 end ) as retention_d60
            , max( case when day_number = 61 then 1 else 0 end ) as retention_d61
            , max( case when day_number = 90 then 1 else 0 end ) as retention_d90
            , max( case when day_number = 120 then 1 else 0 end ) as retention_d120

        FROM
          calculate_day_number
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

            -- retention
            , last_value( max_available_day_number ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as max_available_day_number
            , last_value( retention_d2 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d2
            , last_value( retention_d3 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d3
            , last_value( retention_d4 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d4
            , last_value( retention_d5 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d5
            , last_value( retention_d6 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d6
            , last_value( retention_d7 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d7
            , last_value( retention_d8 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d8
            , last_value( retention_d9 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d9
            , last_value( retention_d10 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d10
            , last_value( retention_d11 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d11
            , last_value( retention_d12 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d12
            , last_value( retention_d13 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d13
            , last_value( retention_d14 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d14
            , last_value( retention_d15 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d15
            , last_value( retention_d21 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d21
            , last_value( retention_d30 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d30
            , last_value( retention_d31 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d31
            , last_value( retention_d46 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d46
            , last_value( retention_d60 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d60
            , last_value( retention_d61 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d61
            , last_value( retention_d90 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d90
            , last_value( retention_d120 ) over ( partition by firebase_advertising_id order by last_played_date rows between unbounded preceding and unbounded following ) as retention_d120



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

            -- retention
            , max(max_available_day_number) as max_available_day_number
            , max(retention_d2) as retention_d2
            , max(retention_d3) as retention_d3
            , max(retention_d4) as retention_d4
            , max(retention_d5) as retention_d5
            , max(retention_d6) as retention_d6
            , max(retention_d7) as retention_d7
            , max(retention_d8) as retention_d8
            , max(retention_d9) as retention_d9
            , max(retention_d10) as retention_d10
            , max(retention_d11) as retention_d11
            , max(retention_d12) as retention_d12
            , max(retention_d13) as retention_d13
            , max(retention_d14) as retention_d14
            , max(retention_d15) as retention_d15
            , max(retention_d21) as retention_d21
            , max(retention_d30) as retention_d30
            , max(retention_d31) as retention_d31
            , max(retention_d46) as retention_d46
            , max(retention_d60) as retention_d60
            , max(retention_d61) as retention_d61
            , max(retention_d90) as retention_d90
            , max(retention_d120) as retention_d120

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

################################################################
## Retention
################################################################

  measure: average_retention_d2 {
    group_label: "Average Retention"
    label: "D2"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.retention_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.firebase_advertising_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
  }


  measure: average_retention_d30 {
    group_label: "Average Retention"
    label: "D30"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.retention_d30
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.firebase_advertising_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
  }


}
