view: adhoc_2024_06_27_castle_climb_reward_funnel {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


      with

      -------------------------------------------------------------
      -- base data
      -------------------------------------------------------------

      base_data as (

        select
          rdg_id
          , b.castle_climb_event_start_date
          , sum( case when safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%Chest%' then 1 else 0 end ) as chest_events
          , sum( case when event_name = 'reward' then 1 else 0 end ) as reward_events
        from
          eraser-blast.game_data.events a
          -- left join eraser-blast.looker_scratch.6Y_ritz_deli_games_live_ops_calendar b
          left join eraser-blast.looker_scratch.LR_6YPRL1719510956268_live_ops_calendar b
            on date(a.timestamp) = date(b.rdg_date)
        where
          date(timestamp) between '2024-05-01' and '2024-06-26'
          and (
              event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar(extra_json, "$.button_tag") as string) like '%CastleClimb%'
            or (
              event_name = 'reward'
              and safe_cast(json_extract_scalar(extra_json, "$.reward_event") as string) = 'castle_climb'
            ))
          and b.castle_climb_event_start_date is not null
        group by
          1,2

      )

      -------------------------------------------------------------
      -- add chest indicator
      -------------------------------------------------------------

      , my_chest_indicator_table as (

        select
          *
          , case when chest_events > 0 then 1 else 0 end as chest_indicator
          , case
              when reward_events > 8 then 8
              when chest_events > 0 then 8
              else reward_events
              end as reward_events_fixed
        from
          base_data

      )

      -------------------------------------------------------------
      -- summarize
      -------------------------------------------------------------

      , my_summarize_table as (

        select
          castle_climb_event_start_date
          , reward_events_fixed
          , sum(chest_indicator) as count_chest_indicator
          , sum(1) as count_players
        from
          my_chest_indicator_table
        group by
          1,2

      )

      -------------------------------------------------------------
      -- add totals
      -------------------------------------------------------------

      , my_add_totals_table as (

        select
          *
          , sum( count_players ) over ( partition by castle_climb_event_start_date ) as total_event_players
          , sum( count_players ) over (
              partition by castle_climb_event_start_date order by reward_events_fixed desc
              rows between unbounded preceding and current row )
              as total_event_players_desc
        from
          my_summarize_table
      )

      -------------------------------------------------------------
      -- final
      -------------------------------------------------------------

      select
        *
      from
        my_add_totals_table

      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.castle_climb_event_start_date
    || '_' || ${TABLE}.reward_events_fixed
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension_group: castle_climb_event_start_date {
    label: "Castle Climb Event Start"
    type: time
    timeframes: [date]
    sql: ${TABLE}.castle_climb_event_start_date ;;
  }

  dimension: reward_events_fixed {
    type: number
    label: "Reward Events"
    }

################################################################
## Measures
################################################################

  measure: count_players {
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.count_players) ;;
  }

  measure: total_event_players {
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.total_event_players) ;;
  }

  measure: total_event_players_desc {
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.total_event_players_desc) ;;
  }

  measure: completion_funnel {
    type: number
    value_format_name: percent_0
    sql:
      safe_divide(
        sum(${TABLE}.total_event_players_desc)
        , sum(${TABLE}.total_event_players)
      )
      ;;
  }


}
