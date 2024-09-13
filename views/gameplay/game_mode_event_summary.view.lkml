view: game_mode_event_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-09-12'

      with

      moves_master_daily as (

        select
          b.moves_master_event_start_date as event_start_date
          , a.rdg_id
          , sum(a.count_days_played) as count_days_played
          , max( case when a.round_end_events_movesmaster > 0 then 1 else 0 end ) as game_mode_participation_indicator
          , max( case when a.round_end_events_movesmaster > 0 then 1 else 0 end ) as game_mode_completion_indicator
          , sum( case when a.round_end_events_movesmaster > 0 then a.count_days_played else 0 end ) as days_played_game_mode
          , sum( a.round_end_events_movesmaster ) as game_mode_round_end_events
          , max( case when a.daily_popup_MovesMaster is not null then 1 else 0 end ) as game_mode_popup_indicator
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary a
          -- left join eraser-blast.looker_scratch.6Y_ritz_deli_games_live_ops_calendar b
          --  on date(a.rdg_date) = b.rdg_date
          ${player_daily_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        where
          b.moves_master_event_start_date is not null
          -- and b.moves_master_event_start_date = '2024-09-03'
          -- and date(a.rdg_date) >= '2024-09-03'
        group by
          1,2

      )

      , moves_master_rounds as (

        select
          b.moves_master_event_start_date as event_start_date
          , a.rdg_id
          , count( distinct a.level_id ) as count_unique_levels
          , sum( a.count_rounds ) as count_rounds
          , sum( a.count_wins ) as count_wins
          , sum( a.count_rounds_with_moves_added ) as count_rounds_with_moves_added
          , sum( a.pregame_boost_total ) as pregame_boost_total
          , sum( a.total_chum_powerups_used ) as total_chum_powerups_used
          , sum( a.in_round_coin_spend ) as in_round_coin_spend
          , sum( a.in_round_count_ad_views ) as in_round_count_ad_views
          , sum( a.in_round_combined_dollars ) as in_round_combined_dollars
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary a
          -- left join eraser-blast.looker_scratch.6Y_ritz_deli_games_live_ops_calendar b
          --   on date(a.rdg_date) = b.rdg_date
          ${player_round_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        where
          b.moves_master_event_start_date is not null
          and a.game_mode = 'movesMaster'
          --and b.moves_master_event_start_date = '2024-09-03'
          --and date(a.rdg_date) >= '2024-09-03'

        group by
          1,2
      )

      select
        timestamp(a.event_start_date) as event_start_date
        , 'movesMaster' as game_mode
        , a.rdg_id
        , a.count_days_played
        , a.game_mode_participation_indicator
        , a.game_mode_completion_indicator
        , a.days_played_game_mode
        , a.game_mode_round_end_events
        , a.game_mode_popup_indicator
        , ifnull( b.count_unique_levels, 0 ) as count_unique_levels
        , ifnull( b.count_rounds, 0 ) as count_rounds
        , ifnull( b.count_wins, 0 ) as count_wins
        , ifnull( b.count_rounds_with_moves_added, 0 ) as count_rounds_with_moves_added
        , ifnull( b.pregame_boost_total, 0 ) as pregame_boost_total
        , ifnull( b.total_chum_powerups_used, 0 ) as total_chum_powerups_used
        , ifnull( b.in_round_coin_spend, 0 ) as in_round_coin_spend
        , ifnull( b.in_round_count_ad_views, 0 ) as in_round_count_ad_views
        , ifnull( b.in_round_combined_dollars  , 0 ) as in_round_combined_dollars
      from
        moves_master_daily a
        left join moves_master_rounds b
          on a.event_start_date = b.event_start_date
          and a.rdg_id = b.rdg_id

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["event_start_date"]

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.event_start_date
    || '_' || ${TABLE}.game_mode
    || '_' || ${TABLE}.rdg_id
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: rdg_id { type:string }
  dimension: game_mode { type:string }
  dimension_group: event_start_date {
    label: "Event Start"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.event_start_date ;;
  }
  dimension: event_start_date_string {
    label: "Event Start Key"
    type:string
    sql:
      format_datetime("%Y-%m-%d",${TABLE}.event_start_date)

    ;;
  }

################################################################
## Measure
################################################################

measure: percent_dau_in_mode {
  label: "Average % DAU In Mode"
  type: number
  value_format_name: percent_0
  sql:
    safe_divide(
      sum(${TABLE}.days_played_game_mode)
      , sum(${TABLE}.count_days_played)
      )
  ;;
}

  measure: percent_unique_dau_in_mode {
    label: "Average % Unique Players In Mode"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      sum(${TABLE}.game_mode_participation_indicator)
      , sum(1)
      )
  ;;
  }

  measure: percent_unique_engaged_dau_to_complete_event {
    label: "Average % Engaged Players To Complete Event"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      sum(${TABLE}.game_mode_completion_indicator)
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: percent_unique_engaged_dau_to_see_popup {
    label: "Average % Engaged Players To View Popup"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.game_mode_popup_indicator else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_rounds_with_moves_added_per_player {
    label: "Average Rounds With Moves Added Per Player"
    type: number
    value_format_name: decimal_1
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.count_rounds_with_moves_added else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_pre_game_boosts_per_player {
    label: "Average Pre-Game Boosts Per Player"
    type: number
    value_format_name: decimal_1
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.pregame_boost_total else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_chum_chums_per_player {
    label: "Average Chum Chums Used Per Player"
    type: number
    value_format_name: decimal_1
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.total_chum_powerups_used else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_coins_spend_per_player {
    label: "Average Coins Spent Per Player"
    type: number
    value_format_name: decimal_0
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.in_round_coin_spend else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_ads_vied_per_player {
    label: "Average Ads Viewed Per Player"
    type: number
    value_format_name: decimal_1
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.in_round_count_ad_views else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_combined_dollars_per_player {
    label: "Average Revenue Per Player"
    type: number
    value_format_name: usd
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.in_round_combined_dollars else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_unique_levels_played_per_player {
    label: "Average Unique Levels Played Per Player"
    type: number
    value_format_name: decimal_1
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.count_unique_levels else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_rounds_played_per_player {
    group_label: "Rounds Played"
    label: "Average"
    type: number
    value_format_name: decimal_1
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.game_mode_round_end_events else 0 end )
      , sum(${TABLE}.game_mode_participation_indicator)
      )
  ;;
  }

  measure: average_aps_per_player {
    label: "Average APS"
    type: number
    value_format_name: decimal_1
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.count_rounds else 0 end )
      , sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.count_wins else 0 end )
      )
  ;;
  }

  measure: rounds_played_10 {
    group_label: "Rounds Played"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    value_format_name: decimal_0
    sql: case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.game_mode_round_end_events else null end  ;;
  }

  measure: rounds_played_25 {
    group_label: "Rounds Played"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    value_format_name: decimal_0
    sql: case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.game_mode_round_end_events else null end  ;;
  }

  measure: rounds_played_50 {
    group_label: "Rounds Played"
    label: "Median"
    type: percentile
    percentile: 50
    value_format_name: decimal_0
    sql: case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.game_mode_round_end_events else null end  ;;
  }

  measure: rounds_played_75 {
    group_label: "Rounds Played"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    value_format_name: decimal_0
    sql: case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.game_mode_round_end_events else null end  ;;
  }

  measure: rounds_played_95 {
    group_label: "Rounds Played"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    value_format_name: decimal_0
    sql: case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.game_mode_round_end_events else null end  ;;
  }

}
