view: adhoc_20240117_target_churn_rate {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    with

      ---------------------------------------------------------------------------------
      -- Retention Target
      ---------------------------------------------------------------------------------

      retention_targets as (

        select
          day_number
          , case
            when day_number = 1 then 1
            when day_number = 2 then 0.45
            when day_number = 3 then 0.347
            when day_number = 4 then 0.301
            when day_number = 5 then 0.266
            when day_number = 6 then 0.25
            when day_number = 7 then 0.231
            when day_number = 8 then 0.22
            when day_number = 9 then 0.203
            when day_number = 10 then 0.191
            when day_number = 11 then 0.182
            when day_number = 12 then 0.174
            when day_number = 13 then 0.169
            when day_number = 14 then 0.164
            when day_number = 15 then 0.16
            when day_number = 16 then 0.156
            when day_number = 17 then 0.152
            when day_number = 18 then 0.148
            when day_number = 19 then 0.145
            when day_number = 20 then 0.142
            when day_number = 21 then 0.139
            when day_number = 22 then 0.136
            when day_number = 23 then 0.134
            when day_number = 24 then 0.132
            when day_number = 25 then 0.129
            when day_number = 26 then 0.127
            when day_number = 27 then 0.125
            when day_number = 28 then 0.123
            when day_number = 29 then 0.122
            when day_number = 30 then 0.122
            when day_number = 31 then 0.12
            else 0 end as retention_target
        from
          unnest( generate_array(1,31) ) as day_number

      )

      ---------------------------------------------------------------------------------
      -- players campaign info by day_number
      ---------------------------------------------------------------------------------

      , base_data as (

        select
          rdg_id
          , day_number
          , level_serial
          , max(
              safe_cast(
                floor( safe_divide(level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
                as string
              )
              || ' to '
              ||
              safe_cast(
                ceiling(safe_divide(level_serial+1,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}-1
                as string
              )
            ) as level_bucket
          , safe_cast(
            floor( safe_divide(level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
            as int64
            ) as level_bucket_order
          , sum(count_wins) as count_wins
          , max(churn_rdg_id) as churn_rdg_id
        from
          ${player_round_summary.SQL_TABLE_NAME} a
        where
          game_mode = 'campaign'
          and day_number between 1 and 31
          and level_serial > 0

          -- Date Filters
          date(rdg_date) >= date({% parameter start_date %})
          and date(rdg_date) <= date({% parameter end_date %})


        group by
          1,2,3

      )

      ---------------------------------------------------------------------------------
      -- add on retention target for next day
      ---------------------------------------------------------------------------------

      , base_data_with_retention_target as (

        select
          a.*
          , b.retention_target
          , c.retention_target as next_day_retention_target
          , 1 as count_levels_won
        from
          base_data a
          inner join retention_targets b
            on a.day_number = b.day_number
          inner join retention_targets c
            on a.day_number = c.day_number - 1

      )

      ---------------------------------------------------------------------------------
      -- calculate levels completed on day
      ---------------------------------------------------------------------------------

      , levels_completed_by_day as (

        select
          *
          , sum(count_levels_won) over (partition by rdg_id, day_number ) as total_count_levels_won_by_day
        from
          base_data_with_retention_target

      )

      ---------------------------------------------------------------------------------
      -- calculate target churn per level by day
      ---------------------------------------------------------------------------------

      , calculate_target_churn_per_level_per_day as (

        select
          *
          , 1-power(
              safe_divide(next_day_retention_target,retention_target)
              , safe_divide(1,total_count_levels_won_by_day)) as flat_churn_target_by_day
        from
          levels_completed_by_day

      )

      ---------------------------------------------------------------------------------
      -- Calculate Target Churn By Level Bucket
      ---------------------------------------------------------------------------------

      , target_churn_by_level_bucket as (

        select
          level_bucket_order
          , level_bucket
          , avg(flat_churn_target_by_day) as target_churn_rate
        from
          calculate_target_churn_per_level_per_day
        group by
          1,2

      )

      ---------------------------------------------------------------------------------
      -- Actual Churn By Level Bucket (Step 1)
      ---------------------------------------------------------------------------------

      , actual_churn_by_level_bucket_step_1 as (

        select
          level_serial
          , level_bucket_order
          , level_bucket
          , count(distinct churn_rdg_id) as count_distinct_churned_players
          , count(distinct rdg_id) as  count_distinct_players
        from
          base_data
        group by
          1,2,3
      )

      ---------------------------------------------------------------------------------
      -- Actual Churn By Level Bucket (step 2)
      ---------------------------------------------------------------------------------

      , actual_churn_by_level_bucket as (

        select
          level_bucket_order
          , level_bucket
          , safe_divide(
              sum(count_distinct_churned_players)
              , sum(count_distinct_players) ) as actual_churn_rate
        from
          actual_churn_by_level_bucket_step_1
        group by
          1,2
      )

      ---------------------------------------------------------------------------------
      -- Combined Target and Actuals
      ---------------------------------------------------------------------------------

      select
        a.level_bucket_order
        , a.level_bucket
        , a.target_churn_rate
        , b.actual_churn_rate
      from
        target_churn_by_level_bucket a
        inner join actual_churn_by_level_bucket b
          on a.level_bucket = b.level_bucket
      order by
        1




      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: level_bucket_order_key {
    type: number
    sql:
    ${TABLE}.level_bucket_order
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

  parameter: start_date {
    type: date
    default_value: "2024-01-01"
  }

  parameter: end_date {
    type: date
    default_value: "2024-01-01"
  }

  parameter: dynamic_level_bucket_size {
    group_label: "Level Buckets"
    type: number
  }

################################################################
## Dimensions
################################################################

  dimension: level_bucket_order {
    type: number}


  dimension: level_bucket {
    label: "Dynamic Level Bucket"
    type:string
  }

################################################################
## Measures
################################################################

  measure: target_churn_rate {
    type: number
    value_format_name: percent_1
    sql: max(${TABLE}.target_churn_rate);;
  }

  measure: actual_churn_rate {
    type: number
    value_format_name: percent_1
    sql: max(${TABLE}.actual_churn_rate);;
  }







}
