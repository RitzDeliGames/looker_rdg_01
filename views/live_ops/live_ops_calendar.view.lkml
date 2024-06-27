view: live_ops_calendar {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-06-27'

      with

      ------------------------------------------------------------
      -- Row Number Table
      ------------------------------------------------------------

      my_row_number_table as (

        select
          my_row_number

          -- Calendar Start Date
          -- select min(rdg_date) from eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary
          , date('2022-06-01') as calendar_start_date

          -- Castle Climb
          , date('2024-05-14') as castle_climb_start_date
          , 4 as castle_climb_day_length


        from
          unnest( generate_array(1,365 * 15 ) ) as my_row_number

      )

      ------------------------------------------------------------
      -- rdg date table
      ------------------------------------------------------------

      , my_rdg_date_table as (

        select
          *
          , date_add(calendar_start_date, interval my_row_number - 1 day) as rdg_date
        from
          my_row_number_table

      )

      ------------------------------------------------------------
      -- Live Ops Day Number Table
      ------------------------------------------------------------

      , my_live_ops_day_number_table as (

        select
          *
          , case
              when rdg_date < castle_climb_start_date
              then null
              else date_diff(rdg_date,castle_climb_start_date,day)
              end as castle_climb_day_number
        from
          my_rdg_date_table
      )

      ------------------------------------------------------------
      -- Live Ops Number Table
      ------------------------------------------------------------

      , my_live_ops_number_table as (

        select
          *
          , floor(safe_divide( castle_climb_day_number, castle_climb_day_length ))+1 as castle_climb_number
        from my_live_ops_day_number_table

      )

      ------------------------------------------------------------
      -- Live Ops Event Start Date
      ------------------------------------------------------------

      , my_live_ops_event_start_date_table as (

        select
          *
          , min(rdg_date) over ( partition by safe_cast(castle_climb_number as string) order by rdg_date ) as castle_climb_event_start_date
        from
          my_live_ops_number_table

      )

      ------------------------------------------------------------
      -- Final Table - Last Chance to Avoid Dupes
      ------------------------------------------------------------

      select
        rdg_date
        , max( my_row_number ) as my_row_number
        , max( calendar_start_date ) as calendar_start_date
        , max( castle_climb_start_date ) as castle_climb_start_date
        , max( castle_climb_day_length ) as castle_climb_day_length
        , max( castle_climb_day_number ) as castle_climb_day_number
        , max( castle_climb_number ) as castle_climb_number
        , max( case when castle_climb_day_number is null then null else castle_climb_event_start_date end ) as castle_climb_event_start_date
      from
        my_live_ops_event_start_date_table
      where
        rdg_date is not null
      group by
        1

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (1) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes

  }


####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_date_timestamp
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension_group: rdg_date {
    label: "Activity"
    type: time
    timeframes: [date, week, month, year]
    sql: timestamp(${TABLE}.rdg_date) ;;
  }

  ############################################################
  ## Castle Climb
  ############################################################

  dimension_group: castle_climb_start_date {
    group_label: "Castle Climb"
    label: "Launch"
    type: time
    timeframes: [date, week, month, year]
    sql: timestamp(${TABLE}.castle_climb_start_date) ;;
  }

  dimension: castle_climb_day_length {
    group_label: "Castle Climb"
    label: "Event Length in Days"
    type: number
  }

  dimension: castle_climb_day_number {
    group_label: "Castle Climb"
    label: "Days Since Launch"
    type: number
  }

  dimension: castle_climb_number {
    group_label: "Castle Climb"
    label: "Event Number"
    type: number
  }

  dimension: castle_climb_event_start_date {
    group_label: "Castle Climb"
    label: "Event Start Date"
    type: date
  }



}
