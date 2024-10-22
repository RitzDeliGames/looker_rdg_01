view: player_error_by_dau {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-10-22'

      with

      ------------------------------------------------------------
      -- my_dau_data
      ------------------------------------------------------------

      my_dau_data as (

        select
          rdg_date
          , rdg_id
          , max( timestamp(created_date) ) as created_date
          , max( days_since_created ) as days_since_created
          , max( day_number ) as day_number
          , max( version ) as version
          , max( experiments ) as experiments
          , max( highest_last_level_serial ) as last_level_serial
          , max( cumulative_time_played_minutes ) as cumulative_time_played_minutes

        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary
          ${player_daily_summary.SQL_TABLE_NAME}
        -- where
          -- date(rdg_date) = '2024-01-01'
        group by
          1,2

      )

      ------------------------------------------------------------
      -- my_error_data
      ------------------------------------------------------------

      , my_error_data as (

        select
          rdg_date
          , rdg_id
          , my_error_excluding_frame
          , max( simplified_error ) as simplified_error
          , sum( count_errors ) as count_errors
        from
          -- `eraser-blast.looker_scratch.LR_6Y3LG1729616131553_player_error_summary`
          ${player_error_summary.SQL_TABLE_NAME}
        -- where
          -- date(rdg_date) = '2024-01-01'
        group by
          1,2,3
      )

      ------------------------------------------------------------
      -- My Error by Date
      ------------------------------------------------------------

      , my_errors_by_date as (

        select
          rdg_date
          , my_error_excluding_frame
          , sum( count_errors ) as count_errors
        from
          my_error_data
        group by
          1,2
      )

      ------------------------------------------------------------
      -- My Ranked Errors
      ------------------------------------------------------------

      , my_ranked_errors_per_day as (

        select
          rdg_date
          , my_error_excluding_frame
          , count_errors
          , row_number() over (partition by rdg_date order by count_errors desc ) as row_number_of_error
        from
          my_errors_by_date

      )

      ------------------------------------------------------------
      -- My Top 100 Errors Per Day
      ------------------------------------------------------------

      , my_top_100_errors_per_day as (

        select
          rdg_date
          , my_error_excluding_frame
        from
          my_ranked_errors_per_day
        where
          row_number_of_error <= 100

      )

      ------------------------------------------------------------
      -- Base Data
      ------------------------------------------------------------

      , my_base_data as (

        select
          a.*
          , b.my_error_excluding_frame
        from
          my_dau_data a
          left join my_top_100_errors_per_day b
            on a.rdg_date = b.rdg_date

      )

      ------------------------------------------------------------
      -- combine data
      ------------------------------------------------------------

      select
        a.*
        , b.* except( rdg_id, rdg_date, my_error_excluding_frame )
        , 1 as count_dau
        , case when b.rdg_id is not null then 1 else 0 end as count_dau_with_error
        , b.rdg_id as rdg_id_with_error
      from
        my_base_data a
        left join my_error_data b
          on a.rdg_id = b.rdg_id
          and a.rdg_date = b.rdg_date
          and a.my_error_excluding_frame = b.my_error_excluding_frame

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
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
    || '_' || ${TABLE}.my_error_excluding_frame
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

  dimension: rdg_id { type:string }
  dimension: my_error_excluding_frame { type:string }
  dimension: simplified_error { type:string }
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: version {type: string}

  dimension_group: rdg_date {
    label: "Activity"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension_group: created_date {
    label: "Install"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  dimension: version_number {
    type:number
    sql:
      safe_cast(${TABLE}.version as numeric)
      ;;
  }

  dimension: last_level_serial {
    type: number
    sql: ${TABLE}.last_level_serial ;;
  }

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

################################################################
## Measures
################################################################

  measure: count_distinct_users {
    label: "Unique Players"
    group_label: "Unique Players"
    type: count_distinct
    value_format_name: decimal_0
    sql: ${TABLE}.rdg_id ;;
  }

  measure: count_distinct_users_with_error {
    label: "Unique Players With Error"
    group_label: "Unique Players"
    type: count_distinct
    sql: ${TABLE}.rdg_id_with_error ;;
  }

  measure: percent_unique_sers_with_error {
    label: "% Unique Players With Error"
    group_label: "Unique Players"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count(distinct ${TABLE}.rdg_id_with_error)
        , count(distinct ${TABLE}.rdg_id )
        ) ;;
  }

  measure: total_dau {
    label: "Total DAU"
    group_label: "DAU"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.count_dau ) ;;
  }

  measure: total_dau_with_error {
    label: "Total DAU With Error"
    group_label: "DAU"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.count_dau_with_error )  ;;
  }

  measure: percent_dau_with_error {
    label: "% DAU With Error"
    group_label: "DAU"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum( ${TABLE}.count_dau_with_error )
        , sum( ${TABLE}.count_dau )
        ) ;;
  }

  measure: errors_per_dau_with_error {
    label: "Errors Per DAU with Error"
    group_label: "DAU"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum( ${TABLE}.count_errors )
        , sum( ${TABLE}.count_dau_with_error )
        ) ;;
  }

  measure: total_errors {
    label: "Total Errors"
    group_label: "Total Errors"
    type: number
    value_format_name: decimal_0
    sql:
      sum( ${TABLE}.count_errors ) ;;
  }







}
