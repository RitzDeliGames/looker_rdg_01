view: big_query_jobs {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-06-02'

      select
        rdg_date
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
        tal_scratch.big_query_jobs

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
    # increment_key: "rdg_date"
    # increment_offset: 7

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
