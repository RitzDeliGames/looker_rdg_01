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

          -- Hot Dog Competition
          , date('2023-07-20') as hot_dog_start_date
          , 2 as hot_dog_day_length

          -- Moves Master
          , date('2022-10-11') as moves_master_start_date
          , 7 as moves_master_day_length
          , 1 as moves_master_days_off_at_end

          -- Puzzle
          , date('2023-05-17') as puzzle_start_date
          , 7 as puzzle_day_length
          , 1 as puzzle_days_off_at_end

          -- Go Fish
          , date('2023-09-22') as go_fish_start_date
          , 7 as go_fish_day_length
          , 1 as go_fish_days_off_at_end

          -- Gem Quest
          , date('2024-03-28') as gem_quest_start_date
          , 7 as gem_quest_day_length
          , 1 as gem_quest_days_off_at_end

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
          , case
              when rdg_date < hot_dog_start_date
              then null
              else date_diff(rdg_date,hot_dog_start_date,day)
              end as hot_dog_day_number
          , case
              when rdg_date < moves_master_start_date
              then null
              else date_diff(rdg_date,moves_master_start_date,day)
              end as moves_master_day_number
          , case
              when rdg_date < puzzle_start_date
              then null
              else date_diff(rdg_date,puzzle_start_date,day)
              end as puzzle_day_number
          , case
              when rdg_date < go_fish_start_date
              then null
              else date_diff(rdg_date,go_fish_start_date,day)
              end as go_fish_day_number
          , case
              when rdg_date < gem_quest_start_date
              then null
              else date_diff(rdg_date,gem_quest_start_date,day)
              end as gem_quest_day_number
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
          , floor(safe_divide( hot_dog_day_number, hot_dog_day_length ))+1 as hot_dog_number
          , floor(safe_divide( moves_master_day_number, moves_master_day_length ))+1 as moves_master_number
          , floor(safe_divide( puzzle_day_number, puzzle_day_length ))+1 as puzzle_number
          , floor(safe_divide( go_fish_day_number, go_fish_day_length ))+1 as go_fish_number
          , floor(safe_divide( gem_quest_day_number, gem_quest_day_length ))+1 as gem_quest_number
        from my_live_ops_day_number_table

      )

      ------------------------------------------------------------
      -- Live Ops Event Start Date
      ------------------------------------------------------------

      , my_live_ops_event_start_date_table as (

        select
          *
          , min(rdg_date) over ( partition by safe_cast(castle_climb_number as string) order by rdg_date ) as castle_climb_event_start_date
          , min(rdg_date) over ( partition by safe_cast(hot_dog_number as string) order by rdg_date ) as hot_dog_event_start_date
          , min(rdg_date) over ( partition by safe_cast(moves_master_number as string) order by rdg_date ) as moves_master_event_start_date
          , row_number() over ( partition by safe_cast(moves_master_number as string) order by rdg_date asc ) as moves_master_event_day_number
          , row_number() over ( partition by safe_cast(moves_master_number as string) order by rdg_date desc ) as moves_master_event_days_remaining
          , min(rdg_date) over ( partition by safe_cast(puzzle_number as string) order by rdg_date ) as puzzle_event_start_date
          , row_number() over ( partition by safe_cast(puzzle_number as string) order by rdg_date asc ) as puzzle_event_day_number
          , row_number() over ( partition by safe_cast(puzzle_number as string) order by rdg_date desc ) as puzzle_event_days_remaining
          , min(rdg_date) over ( partition by safe_cast(go_fish_number as string) order by rdg_date ) as go_fish_event_start_date
          , row_number() over ( partition by safe_cast(go_fish_number as string) order by rdg_date asc ) as go_fish_event_day_number
          , row_number() over ( partition by safe_cast(go_fish_number as string) order by rdg_date desc ) as go_fish_event_days_remaining
          , min(rdg_date) over ( partition by safe_cast(gem_quest_number as string) order by rdg_date ) as gem_quest_event_start_date
          , row_number() over ( partition by safe_cast(gem_quest_number as string) order by rdg_date asc ) as gem_quest_event_day_number
          , row_number() over ( partition by safe_cast(gem_quest_number as string) order by rdg_date desc ) as gem_quest_event_days_remaining
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

        -- castle climb
        , max( castle_climb_start_date ) as castle_climb_start_date
        , max( castle_climb_day_length ) as castle_climb_day_length
        , max( castle_climb_day_number ) as castle_climb_day_number
        , max( castle_climb_number ) as castle_climb_number
        , max( case when castle_climb_day_number is null then null else castle_climb_event_start_date end ) as castle_climb_event_start_date

        -- hot_dog
        , max( hot_dog_start_date ) as hot_dog_start_date
        , max( hot_dog_day_length ) as hot_dog_day_length
        , max( hot_dog_day_number ) as hot_dog_day_number
        , max( hot_dog_number ) as hot_dog_number
        , max( case when hot_dog_day_number is null then null else hot_dog_event_start_date end ) as hot_dog_event_start_date

        -- moves_master
        , max( moves_master_start_date ) as moves_master_start_date
        , max( moves_master_day_length ) as moves_master_day_length
        , max( moves_master_day_number ) as moves_master_day_number
        , max( case when moves_master_event_days_remaining <= moves_master_days_off_at_end then null else moves_master_number end ) as moves_master_number
        , max( case when moves_master_day_number is null then null when moves_master_event_days_remaining <= moves_master_days_off_at_end then null else moves_master_event_start_date end ) as moves_master_event_start_date
        , max( case when moves_master_day_number is null then null when moves_master_event_days_remaining <= moves_master_days_off_at_end then null else moves_master_event_day_number end ) as moves_master_event_day_number

        -- puzzle
        , max( puzzle_start_date ) as puzzle_start_date
        , max( puzzle_day_length ) as puzzle_day_length
        , max( puzzle_day_number ) as puzzle_day_number
        , max( case when puzzle_event_days_remaining <= puzzle_days_off_at_end then null else puzzle_number end ) as puzzle_number
        , max( case when puzzle_day_number is null then null when puzzle_event_days_remaining <= puzzle_days_off_at_end then null else puzzle_event_start_date end ) as puzzle_event_start_date
        , max( case when puzzle_day_number is null then null when puzzle_event_days_remaining <= puzzle_days_off_at_end then null else puzzle_event_day_number end ) as puzzle_event_day_number


        -- go_fish
        , max( go_fish_start_date ) as go_fish_start_date
        , max( go_fish_day_length ) as go_fish_day_length
        , max( go_fish_day_number ) as go_fish_day_number
        , max( case when go_fish_event_days_remaining <= go_fish_days_off_at_end then null else go_fish_number end ) as go_fish_number
        , max( case when go_fish_day_number is null then null when go_fish_event_days_remaining <= go_fish_days_off_at_end then null else go_fish_event_start_date end ) as go_fish_event_start_date
        , max( case when go_fish_day_number is null then null when go_fish_event_days_remaining <= go_fish_days_off_at_end then null else go_fish_event_day_number end ) as go_fish_event_day_number

        -- gem_quest
        , max( gem_quest_start_date ) as gem_quest_start_date
        , max( gem_quest_day_length ) as gem_quest_day_length
        , max( gem_quest_day_number ) as gem_quest_day_number
        , max( case when gem_quest_event_days_remaining <= gem_quest_days_off_at_end then null else gem_quest_number end ) as gem_quest_number
        , max( case when gem_quest_day_number is null then null when gem_quest_event_days_remaining <= gem_quest_days_off_at_end then null else gem_quest_event_start_date end ) as gem_quest_event_start_date
        , max( case when gem_quest_day_number is null then null when gem_quest_event_days_remaining <= gem_quest_days_off_at_end then null else gem_quest_event_day_number end ) as gem_quest_event_day_number


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

  ############################################################
  ## Hot Dog
  ############################################################

  dimension_group: hot_dog_start_date {

    group_label: "Hot Dog Competition"
    label: "Launch"
    type: time
    timeframes: [date, week, month, year]
    sql: timestamp(${TABLE}.hot_dog_start_date) ;;
  }

  dimension: hot_dog_day_length {
    group_label: "Hot Dog Competition"
    label: "Event Length in Days"
    type: number
  }

  dimension: hot_dog_day_number {
    group_label: "Hot Dog Competition"
    label: "Days Since Launch"
    type: number
  }

  dimension: hot_dog_number {
    group_label: "Hot Dog Competition"
    label: "Event Number"
    type: number
  }

  dimension: hot_dog_event_start_date {
    group_label: "Hot Dog Competition"
    label: "Event Start Date"
    type: date
  }

  ############################################################
  ## Moves Master
  ############################################################

  dimension_group: moves_master_start_date {
    group_label: "Moves Master"
    label: "Launch"
    type: time
    timeframes: [date, week, month, year]
    sql: timestamp(${TABLE}.moves_master_start_date) ;;
  }

  dimension: moves_master_day_length {
    group_label: "Moves Master"
    label: "Event Length in Days"
    type: number
  }

  dimension: moves_master_day_number {
    group_label: "Moves Master"
    label: "Days Since Launch"
    type: number
  }

  dimension: moves_master_number {
    group_label: "Moves Master"
    label: "Event Number"
    type: number
  }

  dimension: moves_master_event_start_date {
    group_label: "Moves Master"
    label: "Event Start Date"
    type: date
  }

  dimension: moves_master_event_day_number {
    group_label: "Moves Master"
    label: "Event Day Number"
    type: number
  }


  ############################################################
  ## Puzzle
  ############################################################

  dimension_group: puzzle_start_date {
    group_label: "Puzzle"
    label: "Launch"
    type: time
    timeframes: [date, week, month, year]
    sql: timestamp(${TABLE}.puzzle_start_date) ;;
  }

  dimension: puzzle_day_length {
    group_label: "Puzzle"
    label: "Event Length in Days"
    type: number
  }

  dimension: puzzle_day_number {
    group_label: "Puzzle"
    label: "Days Since Launch"
    type: number
  }

  dimension: puzzle_number {
    group_label: "Puzzle"
    label: "Event Number"
    type: number
  }

  dimension: puzzle_event_start_date {
    group_label: "Puzzle"
    label: "Event Start Date"
    type: date
  }

  ############################################################
  ## Go Fish
  ############################################################

  dimension_group: go_fish_start_date {
    group_label: "Go Fish"
    label: "Launch"
    type: time
    timeframes: [date, week, month, year]
    sql: timestamp(${TABLE}.go_fish_start_date) ;;
  }

  dimension: go_fish_day_length {
    group_label: "Go Fish"
    label: "Event Length in Days"
    type: number
  }

  dimension: go_fish_day_number {
    group_label: "Go Fish"
    label: "Days Since Launch"
    type: number
  }

  dimension: go_fish_number {
    group_label: "Go Fish"
    label: "Event Number"
    type: number
  }

  dimension: go_fish_event_start_date {
    group_label: "Go Fish"
    label: "Event Start Date"
    type: date
  }

  ############################################################
  ## Gem Quest
  ############################################################

  dimension_group: gem_quest_start_date {
    group_label: "Gem Quest"
    label: "Launch"
    type: time
    timeframes: [date, week, month, year]
    sql: timestamp(${TABLE}.gem_quest_start_date) ;;
  }

  dimension: gem_quest_day_length {
    group_label: "Gem Quest"
    label: "Event Length in Days"
    type: number
  }

  dimension: gem_quest_day_number {
    group_label: "Gem Quest"
    label: "Days Since Launch"
    type: number
  }

  dimension: gem_quest_number {
    group_label: "Gem Quest"
    label: "Event Number"
    type: number
  }

  dimension: gem_quest_event_start_date {
    group_label: "Gem Quest"
    label: "Event Start Date"
    type: date
  }

}
