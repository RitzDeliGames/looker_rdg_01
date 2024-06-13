view: adhoc_2024_06_13_tickets_funnel {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


      -- create or replace table tal_scratch.2024_06_12_tickets_funnel_data as

      with

      ----------------------------------------------------------------------------------------------------------------
      -- Base Data
      ----------------------------------------------------------------------------------------------------------------

      base_data as (

        select
          timestamp as timestamp_utc
          , timestamp(date(timestamp)) as rdg_date
          , rdg_id
          , event_name
          , extra_json
          , json_extract_scalar(extra_json,'$.button_tag') as button_tag
          , json_extract_scalar(extra_json,'$.current_FueStep') as current_FueStep
          , json_extract_scalar(extra_json,'$.transaction_purchase_currency') as transaction_purchase_currency
          , 1 as count_rows
        from
          `eraser-blast.game_data.events`
        where
          date(timestamp) between '2024-05-11' and '2024-06-12'
          -- and date(timestamp) = '2024-06-11'

          -- tickets experiment
          and safe_cast(
            json_extract_scalar(experiments,'$.ticketsv2_20240510')
            as string) = 'variant_a'

          -- Events we care about
          and case
            when
              event_name = 'ButtonClicked'
              and json_extract_scalar(extra_json,'$.button_tag') like '%Ticket%'
              then 1
            when
              event_name = 'FUE'
              and json_extract_scalar(extra_json,'$.current_FueStep') like '%TICKET%'
              then 1
            when
              event_name = 'transaction'
              and json_extract_scalar(extra_json,'$.transaction_purchase_currency') like '%TICKET%'
              then 1
            else 0
            end = 1

      )

      ----------------------------------------------------------------------------------------------------------------
      -- Add Count of Rows
      ----------------------------------------------------------------------------------------------------------------

      , table_add_count_of_rows as (

        select
          *
          , sum( count_rows ) over (
              partition by rdg_id, event_name
              order by timestamp_utc asc
              rows between unbounded preceding and current row ) as event_number_count
        from
          base_data

      )

      ----------------------------------------------------------------------------------------------------------------
      -- Get List of Active Players
      ----------------------------------------------------------------------------------------------------------------

      , table_get_list_of_active_players as (

      select
        distinct rdg_id
      from
        eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary
      where
        date(rdg_date) between '2024-05-11' and '2024-06-12'
        -- and date(rdg_date) = '2024-06-11'
        and safe_cast(
              json_extract_scalar(experiments,'$.ticketsv2_20240510')
              as string) = 'variant_a'

      )

      ----------------------------------------------------------------------------------------------------------------
      -- Add Active Players to data
      ----------------------------------------------------------------------------------------------------------------

      select
        *
      from
        table_add_count_of_rows

      union all

      select
        null as timestamp_utc
        , null as rdg_date
        , rdg_id
        , 'AnyActivity' as event_name
        , null as extra_json
        , null as button_tag
        , null as current_FueStep
        , null as transaction_purchase_currency
        , 1 as count_rows
        , 1 as event_number_count
      from
        table_get_list_of_active_players


      -- select * from tal_scratch.2024_06_12_tickets_funnel_data order by rdg_id


      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
  }


################################################################
## Dimensions
################################################################

  dimension_group: rdg_date {
    label: "Activity Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension_group: timestamp_utc {
    label: "Activity Timestamp"
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.timestamp_utc ;;
  }

  dimension: rdg_id {type: string}
  dimension: event_name {type: string}
  dimension: extra_json {type: string}
  dimension: button_tag {type: string}
  dimension: current_FueStep {type: string}
  dimension: transaction_purchase_currency {type: string}
  dimension: event_number_count {type: number}
  dimension: my_event_name {
    sql:
      case
        when ${TABLE}.event_name = 'transaction'
        then ${TABLE}.event_name || ' ' || safe_cast(${TABLE}.event_number_count as string)
      else
        ${TABLE}.event_name
      end

    ;;
  }

################################################################
## Measures
################################################################

  measure: count_distinct_rdg_id {
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }

  measure: count_rows {
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.count_rows) ;;

  }

}
