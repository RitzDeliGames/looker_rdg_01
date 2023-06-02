view: big_query_jobs {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-06-02'

      -- create or replace table tal_scratch.big_query_jobs_incremental as

      select
        timestamp(date(creation_time)) as rdg_date
        , creation_time
        , project_id
        , user_email
        , job_id
        , job_type
        , statement_type
        , priority
        , start_time
        , total_slot_ms
        , total_bytes_processed
        , total_bytes_billed
      from
        `region-us`.INFORMATION_SCHEMA.JOBS
      where
        -- Filter by the partition column first to limit the amount of data scanned.
        -- Eight days allows for jobs created before the 7 day end_time filter.
        -- creation_time BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 180 DAY) AND CURRENT_TIMESTAMP()

        date(creation_time) >=
            case
                -- select date(current_date())
                when date(current_date()) <= '2023-06-02' -- Last Full Update
                then '2022-06-01'
                else date_add(current_date(), interval -9 day)
                end
        and date(creation_time) <= date_add(current_date(), interval -1 DAY)

        -- -- select distinct job_type from `region-us`.INFORMATION_SCHEMA.JOBS
        -- AND job_type = 'QUERY'

        -- -- select distinct statement_type from `region-us`.INFORMATION_SCHEMA.JOBS
        -- AND statement_type != 'SCRIPT'

        -- AND end_time BETWEEN TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 180 DAY) AND CURRENT_TIMESTAMP();


      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
    increment_key: "rdg_date"
    increment_offset: 7

  }


  # # Define your dimensions and measures here, like this:
  dimension_group: creation_time {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.creation_time ;;
  }

  dimension: project_id {type:string}
  dimension: user_email {type:string}
  dimension: job_id {type:string}
  dimension: job_type {type:string}
  dimension: statement_type {type:string}
  dimension: priority {type:string}

  measure: cumulative_mtx_purchase_dollars_95 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }

  measure: MB_processed {
    group_label: "Stats"
    type: number
    value_format_name: decimal_0
    sql:
      safe_divide(
        sum(${TABLE}.total_bytes_processed)
        , 1000
        )
    ;;
  }

  measure: MB_billed {
    group_label: "Stats"
    type: number
    value_format_name: decimal_0
    sql:
    safe_divide(
      sum(${TABLE}.total_bytes_billed)
      , 1000
      )
  ;;
  }




}
