view: player_round_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

  -- ccb_aggregate_update_tag

    -- select * from tal_scratch.player_round_summary order by round_start_timestamp_utc
    -- create or replace table tal_scratch.player_round_summary as

    with

    base_data as (

      select

        -- All columns from player_round_incremental
        *
        , case when moves_added then 1 else 0 end as count_rounds_with_moves_added

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

        -- level_serial override
        , case
            when level_serial is not null then level_serial
            when level_id like 'FTUE_Level%' then safe_cast(substring(level_id,11,2) as int64)
            when level_id like 'FTUV%' then safe_cast(substring(level_id,12,2) as int64)
            when level_id like 'Level_%' then safe_cast(substring(level_id,7,3) as int64)
            when level_id like 'NewBeehiveLevel%' then safe_cast(substring(level_id,16,2) as int64)
            when level_id like 'Newlevel052022level%' then safe_cast(substring(level_id,20,2) as int64)
            when level_id like 'Newlevel0527%' then safe_cast(substring(level_id,13,2) as int64)
            when level_id like 'U2A_startlevel_%' then safe_cast(substring(level_id,16,2) as int64)
            when level_id like 'intro202203Level%' then safe_cast(substring(level_id,17,2) as int64)
            else null end as level_serial_fix

        -- lag previous round end
        , ifnull(
            lag(round_end_timestamp_utc) over (
              partition by rdg_id
              order by round_start_timestamp_utc asc
              ) , created_at ) as previous_round_end_timestamp_utc

        -- lead next round_start (check for churn)
        , lead(round_start_timestamp_utc) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            ) as next_round_start_timestamp_utc

      from
        `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_incremental`

      -- where
        -- rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'
        -- rdg_id = 'f205e9e2-b1fd-4bed-be82-799a7df56a84'

    )

    -----------------------------------------------------------------------------
    -- join on mtx_spend, ad_view, coin spend
    -----------------------------------------------------------------------------

    , join_on_spend_summaries as (

      select
        a.rdg_id
        , a.rdg_date
        , a.game_mode
        , a.level_serial_fix as level_serial
        , a.round_start_timestamp_utc
        , a.round_end_timestamp_utc
        , max(a.created_at) as created_at
        , max(a.version) as version
        , max(a.session_id) as session_id
        , max(a.experiments) as experiments
        , max(a.win_streak) as win_streak
        , max(a.count_rounds) as count_rounds
        , max(a.lives) as lives
        , max(a.round_length_minutes) as round_length_minutes
        , max(a.quest_complete) as quest_complete
        , max(a.count_wins) as count_wins
        , max(a.count_losses) as count_losses
        , max(a.moves_remaining) as moves_remaining
        , max(a.moves_added) as moves_added
        , max(a.count_rounds_with_moves_added) as count_rounds_with_moves_added
        , max(a.coins_earned) as coins_earned
        , max(a.objective_count_total) as objective_count_total
        , max(a.objective_progress) as objective_progress
        , max(a.moves) as moves
        , max(a.level_id) as level_id
        , max(a.last_level_serial) as last_level_serial
        , max(a.primary_team_slot) as primary_team_slot
        , max(a.primary_team_slot_skill) as primary_team_slot_skill
        , max(a.primary_team_slot_level) as primary_team_slot_level
        , max(a.proximity_to_completion) as proximity_to_completion
        , max(a.coins_balance) as coins_balance
        , max(a.lives_balance) as lives_balance
        , max(a.stars_balance) as stars_balance
        , max(a.created_date) as created_date
        , max(a.days_since_created) as days_since_created
        , max(a.day_number) as day_number
        , max(a.previous_round_end_timestamp_utc) as previous_round_end_timestamp_utc
        , max(a.next_round_start_timestamp_utc) as next_round_start_timestamp_utc

        --------------------------------------------------------------------------
        -- mtx purchase dollars
        --------------------------------------------------------------------------

        , sum( ifnull(
            case
              when b.timestamp_utc < round_start_timestamp_utc
              then b.mtx_purchase_dollars
              else 0 end
              ,0) ) as before_round_start_mtx_purchase_dollars

        , sum( ifnull(
            case
              when b.timestamp_utc >= round_start_timestamp_utc
              then b.mtx_purchase_dollars
              else 0 end
              ,0) ) as in_round_mtx_purchase_dollars

        , sum( ifnull(b.mtx_purchase_dollars,0) ) as total_mtx_purchase_dollars

        --------------------------------------------------------------------------
        -- mtx purchase count
        --------------------------------------------------------------------------

        , sum( ifnull(
            case
              when b.timestamp_utc < a.round_start_timestamp_utc
              then b.count_mtx_purchases
              else 0 end
              ,0) ) as before_round_start_count_mtx_purchases

        , sum( ifnull(
            case
              when b.timestamp_utc >= a.round_start_timestamp_utc
              then b.count_mtx_purchases
              else 0 end
              ,0) ) as in_round_count_mtx_purchases

        , sum( ifnull(b.count_mtx_purchases,0) ) as total_count_mtx_purchases


        --------------------------------------------------------------------------
        -- ad_view_dollars
        --------------------------------------------------------------------------

        , sum( ifnull(
            case
              when c.timestamp_utc < a.round_start_timestamp_utc
              then c.ad_view_dollars
              else 0 end
              ,0) ) as before_round_start_ad_view_dollars

        , sum( ifnull(
            case
              when c.timestamp_utc >= a.round_start_timestamp_utc
              then c.ad_view_dollars
              else 0 end
              ,0) ) as in_round_ad_view_dollars

        , sum( ifnull(c.ad_view_dollars,0) ) as total_ad_view_dollars

        --------------------------------------------------------------------------
        -- count_ad_views
        --------------------------------------------------------------------------

        , sum( ifnull(
            case
              when c.timestamp_utc < a.round_start_timestamp_utc
              then c.count_ad_views
              else 0 end
              ,0) ) as before_round_start_count_ad_views

        , sum( ifnull(
            case
              when c.timestamp_utc >= a.round_start_timestamp_utc
              then c.count_ad_views
              else 0 end
              ,0) ) as in_round_count_ad_views

        , sum( ifnull(c.count_ad_views,0) ) as total_count_ad_views

        --------------------------------------------------------------------------
        -- coin_spend
        --------------------------------------------------------------------------

        , sum( ifnull(
            case
              when d.timestamp_utc < a.round_start_timestamp_utc
              then d.coin_spend
              else 0 end
              ,0) ) as before_round_start_coin_spend

        , sum( ifnull(
            case
              when d.timestamp_utc >= a.round_start_timestamp_utc
              then d.coin_spend
              else 0 end
              ,0) ) as in_round_coin_spend

        , sum( ifnull(d.coin_spend,0) ) as total_coin_spend

        --------------------------------------------------------------------------
        -- count_coin_spend_events
        --------------------------------------------------------------------------

        , sum( ifnull(
            case
              when d.timestamp_utc < a.round_start_timestamp_utc
              then d.count_coin_spend_events
              else 0 end
              ,0) ) as before_round_start_count_coin_spend_events

        , sum( ifnull(
            case
              when d.timestamp_utc >= a.round_start_timestamp_utc
              then d.count_coin_spend_events
              else 0 end
              ,0) ) as in_round_count_coin_spend_events

        , sum( ifnull(d.count_coin_spend_events,0) ) as total_count_coin_spend_events

      from
        base_data a
        left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_summary` b
          on b.rdg_id = a.rdg_id
          and b.timestamp_utc > a.previous_round_end_timestamp_utc
          and b.timestamp_utc <= a.round_end_timestamp_utc
        left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary` c
          on c.rdg_id = a.rdg_id
          and c.timestamp_utc > a.previous_round_end_timestamp_utc
          and c.timestamp_utc <= a.round_end_timestamp_utc
        left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_spend_summary` d
          on d.rdg_id = a.rdg_id
          and d.timestamp_utc > a.previous_round_end_timestamp_utc
          and d.timestamp_utc <= a.round_end_timestamp_utc


      group by
        1,2,3,4,5,6

    )

    -----------------------------------------------------------------------------
    -- window functions
    -----------------------------------------------------------------------------

    , add_window_functions as (

      select
        *

        -- Combined Dollars
        , before_round_start_mtx_purchase_dollars + before_round_start_ad_view_dollars as before_round_start_combined_dollars
        , in_round_mtx_purchase_dollars + in_round_ad_view_dollars as in_round_combined_dollars
        , total_mtx_purchase_dollars + total_ad_view_dollars as total_combined_dollars

        -- round attempt number
        , sum(ifnull(count_rounds,0)) over (
            partition by rdg_id, level_serial, game_mode
            order by round_start_timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_round_by_level_game_mode

        -- Cumulative fields

        , sum(ifnull(total_mtx_purchase_dollars,0)) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            rows between unbounded preceding and current row
            ) round_end_cumulative_mtx_purchase_dollars

        , sum(ifnull(total_count_mtx_purchases,0)) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            rows between unbounded preceding and current row
            ) round_end_cumulative_count_mtx_purchases

        , sum(ifnull(total_ad_view_dollars,0)) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            rows between unbounded preceding and current row
            ) round_end_cumulative_ad_view_dollars

        , sum(ifnull(total_count_ad_views,0)) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            rows between unbounded preceding and current row
            ) round_end_cumulative_count_ad_views

        , sum(ifnull(total_coin_spend,0)) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            rows between unbounded preceding and current row
            ) round_end_cumulative_coin_spend

        , sum(ifnull(total_count_coin_spend_events,0)) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            rows between unbounded preceding and current row
            ) round_end_cumulative_count_coin_spend_events

        , sum(ifnull(total_mtx_purchase_dollars,0) + ifnull(total_ad_view_dollars,0)) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            rows between unbounded preceding and current row
            ) round_end_cumulative_combined_dollars

      from
        join_on_spend_summaries

    )

    -----------------------------------------------------------------------------
    -- add churn info
    -----------------------------------------------------------------------------

    select
      *
      -- Churn Stuff
      , case when next_round_start_timestamp_utc is null then 1 else 0 end as churn_indicator
      , case when next_round_start_timestamp_utc is null then rdg_id else null end as churn_rdg_id
      , case
          when next_round_start_timestamp_utc is null
          then cumulative_round_by_level_game_mode
          else 0 end as cumulative_round_by_level_game_mode_at_churn
      , case
          when next_round_start_timestamp_utc is null
          then round_end_cumulative_mtx_purchase_dollars
          else 0 end as cumulative_mtx_purchase_dollars_at_churn
      , case
          when next_round_start_timestamp_utc is null
          then round_end_cumulative_count_mtx_purchases
          else 0 end as cumulative_count_mtx_purchases_at_churn
      , case
          when next_round_start_timestamp_utc is null
          then round_end_cumulative_ad_view_dollars
          else 0 end as cumulative_ad_view_dollars_at_churn
      , case
          when next_round_start_timestamp_utc is null
          then round_end_cumulative_count_ad_views
          else 0 end as cumulative_count_ad_views_at_churn
      , case
          when next_round_start_timestamp_utc is null
          then round_end_cumulative_coin_spend
          else 0 end as cumulative_coin_spend_at_churn
      , case
          when next_round_start_timestamp_utc is null
          then round_end_cumulative_count_coin_spend_events
          else 0 end as cumulative_count_coin_spend_events_at_churn
      , case
          when next_round_start_timestamp_utc is null
          then round_end_cumulative_combined_dollars
          else 0 end as cumulative_combined_dollars_at_churn

    from
      add_window_functions



      ;;
    sql_trigger_value: select sum(1) from `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_spend_summary` ;;
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
    || '_' || ${TABLE}.round_start_timestamp_utc
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }
  dimension_group: created_date_timestamp {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  # Strings and Numbers
  dimension: rdg_id {type:string}
  dimension: game_mode {type:string}
  dimension: level_serial {type:number}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: count_rounds {type:number}
  dimension: round_length_minutes {type:number}
  dimension: count_wins {type:number}
  dimension: count_losses {type:number}
  dimension: moves_remaining {type:number}
  dimension: count_rounds_with_moves_added {type:number}
  dimension: coins_earned {type:number}
  dimension: objective_count_total {type:number}
  dimension: objective_progress {type:number}
  dimension: moves {type:number}
  dimension: level_id {type:string}
  dimension: last_level_serial {type:number}
  dimension: primary_team_slot {type:string}
  dimension: primary_team_slot_skill {type:string}
  dimension: primary_team_slot_level {type:number}
  dimension: proximity_to_completion {type:number}
  dimension: coins_balance {type:number}
  dimension: lives_balance {type:number}
  dimension: stars_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: before_round_start_mtx_purchase_dollars {type:number}
  dimension: in_round_mtx_purchase_dollars {type:number}
  dimension: total_mtx_purchase_dollars {type:number}
  dimension: before_round_start_count_mtx_purchases {type:number}
  dimension: in_round_count_mtx_purchases {type:number}
  dimension: total_count_mtx_purchases {type:number}
  dimension: before_round_start_ad_view_dollars {type:number}
  dimension: in_round_ad_view_dollars {type:number}
  dimension: total_ad_view_dollars {type:number}
  dimension: before_round_start_count_ad_views {type:number}
  dimension: in_round_count_ad_views {type:number}
  dimension: total_count_ad_views {type:number}
  dimension: before_round_start_coin_spend {type:number}
  dimension: in_round_coin_spend {type:number}
  dimension: total_coin_spend {type:number}
  dimension: before_round_start_count_coin_spend_events {type:number}
  dimension: in_round_count_coin_spend_events {type:number}
  dimension: total_count_coin_spend_events {type:number}
  dimension: before_round_start_combined_dollars {type:number}
  dimension: in_round_combined_dollars {type:number}
  dimension: total_combined_dollars {type:number}
  dimension: cumulative_round_by_level_game_mode {type:number}
  dimension: round_end_cumulative_mtx_purchase_dollars {type:number}
  dimension: round_end_cumulative_count_mtx_purchases {type:number}
  dimension: round_end_cumulative_ad_view_dollars {type:number}
  dimension: round_end_cumulative_count_ad_views {type:number}
  dimension: round_end_cumulative_coin_spend {type:number}
  dimension: round_end_cumulative_count_coin_spend_events {type:number}
  dimension: round_end_cumulative_combined_dollars {type:number}
  dimension: churn_indicator {type:number}
  dimension: churn_rdg_id {type:string}
  dimension: cumulative_round_by_level_game_mode_at_churn {type:number}
  dimension: cumulative_mtx_purchase_dollars_at_churn {type:number}
  dimension: cumulative_count_mtx_purchases_at_churn {type:number}
  dimension: cumulative_ad_view_dollars_at_churn {type:number}
  dimension: cumulative_count_ad_views_at_churn {type:number}
  dimension: cumulative_coin_spend_at_churn {type:number}
  dimension: cumulative_count_coin_spend_events_at_churn {type:number}
  dimension: cumulative_combined_dollars_at_churn {type:number}



################################################################
## Player Counts
################################################################

  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: count_distinct_churned_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.churn_rdg_id ;;
  }

################################################################
## Calculated Fields for Dashboards
################################################################

  measure: mean_attempts_per_success {
    group_label: "Calculated Fields"
    type: number
    sql: SUM(${TABLE}.count_rounds)/SUM(${TABLE}.count_wins) ;;
    value_format_name: decimal_1

  }

  measure: churn_rate {
    group_label: "Calculated Fields"
    type: number
    sql: COUNT(DISTINCT ${TABLE}.churn_rdg_id)/COUNT(DISTINCT ${TABLE}.rdg_id) ;;
    value_format_name: percent_0

  }

  measure: mtx_dollars_per_player {
    group_label: "Calculated Fields"
    type: number
    sql: SUM(${TABLE}.in_round_mtx_purchase_dollars)/COUNT(DISTINCT ${TABLE}.rdg_id) ;;
    value_format_name: usd

  }

  measure: ad_dollars_per_player {
    group_label: "Calculated Fields"
    type: number
    sql: SUM(${TABLE}.in_round_ad_view_dollars)/COUNT(DISTINCT ${TABLE}.rdg_id) ;;
    value_format_name: usd

  }

  measure: total_dollars_per_player {
    group_label: "Calculated Fields"
    type: number
    sql: SUM(${TABLE}.in_round_combined_dollars)/COUNT(DISTINCT ${TABLE}.rdg_id) ;;
    value_format_name: usd

  }

################################################################
## Sums and Percentiles
################################################################

  measure: sum_win_streak {
    group_label: "Win Streak"
    type:sum
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_10 {
    group_label: "Win Streak"
    type: percentile
    percentile: 10
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_25 {
    group_label: "Win Streak"
    type: percentile
    percentile: 25
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_50 {
    group_label: "Win Streak"
    type: percentile
    percentile: 50
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_75 {
    group_label: "Win Streak"
    type: percentile
    percentile: 75
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_95 {
    group_label: "Win Streak"
    type: percentile
    percentile: 95
    sql: ${TABLE}.win_streak ;;
  }
  measure: sum_count_rounds {
    group_label: "Count Rounds"
    type:sum
    sql: ${TABLE}.count_rounds ;;
  }
  measure: count_rounds_10 {
    group_label: "Count Rounds"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_rounds ;;
  }
  measure: count_rounds_25 {
    group_label: "Count Rounds"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_rounds ;;
  }
  measure: count_rounds_50 {
    group_label: "Count Rounds"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_rounds ;;
  }
  measure: count_rounds_75 {
    group_label: "Count Rounds"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_rounds ;;
  }
  measure: count_rounds_95 {
    group_label: "Count Rounds"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_rounds ;;
  }
  measure: sum_round_length_minutes {
    group_label: "Round Length Minutes"
    type:sum
    sql: ${TABLE}.round_length_minutes ;;
  }
  measure: round_length_minutes_10 {
    group_label: "Round Length Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_length_minutes ;;
  }
  measure: round_length_minutes_25 {
    group_label: "Round Length Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_length_minutes ;;
  }
  measure: round_length_minutes_50 {
    group_label: "Round Length Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_length_minutes ;;
  }
  measure: round_length_minutes_75 {
    group_label: "Round Length Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_length_minutes ;;
  }
  measure: round_length_minutes_95 {
    group_label: "Round Length Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_length_minutes ;;
  }
  measure: sum_count_wins {
    group_label: "Count Wins"
    type:sum
    sql: ${TABLE}.count_wins ;;
  }
  measure: count_wins_10 {
    group_label: "Count Wins"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_wins ;;
  }
  measure: count_wins_25 {
    group_label: "Count Wins"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_wins ;;
  }
  measure: count_wins_50 {
    group_label: "Count Wins"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_wins ;;
  }
  measure: count_wins_75 {
    group_label: "Count Wins"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_wins ;;
  }
  measure: count_wins_95 {
    group_label: "Count Wins"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_wins ;;
  }
  measure: sum_count_losses {
    group_label: "Count Losses"
    type:sum
    sql: ${TABLE}.count_losses ;;
  }
  measure: count_losses_10 {
    group_label: "Count Losses"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_losses ;;
  }
  measure: count_losses_25 {
    group_label: "Count Losses"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_losses ;;
  }
  measure: count_losses_50 {
    group_label: "Count Losses"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_losses ;;
  }
  measure: count_losses_75 {
    group_label: "Count Losses"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_losses ;;
  }
  measure: count_losses_95 {
    group_label: "Count Losses"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_losses ;;
  }
  measure: sum_moves_remaining {
    group_label: "Moves Remaining"
    type:sum
    sql: ${TABLE}.moves_remaining ;;
  }
  measure: moves_remaining_10 {
    group_label: "Moves Remaining"
    type: percentile
    percentile: 10
    sql: ${TABLE}.moves_remaining ;;
  }
  measure: moves_remaining_25 {
    group_label: "Moves Remaining"
    type: percentile
    percentile: 25
    sql: ${TABLE}.moves_remaining ;;
  }
  measure: moves_remaining_50 {
    group_label: "Moves Remaining"
    type: percentile
    percentile: 50
    sql: ${TABLE}.moves_remaining ;;
  }
  measure: moves_remaining_75 {
    group_label: "Moves Remaining"
    type: percentile
    percentile: 75
    sql: ${TABLE}.moves_remaining ;;
  }
  measure: moves_remaining_95 {
    group_label: "Moves Remaining"
    type: percentile
    percentile: 95
    sql: ${TABLE}.moves_remaining ;;
  }
  measure: sum_count_rounds_with_moves_added {
    group_label: "Count Rounds With Moves Added"
    type:sum
    sql: ${TABLE}.count_rounds_with_moves_added ;;
  }
  measure: count_rounds_with_moves_added_10 {
    group_label: "Count Rounds With Moves Added"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_rounds_with_moves_added ;;
  }
  measure: count_rounds_with_moves_added_25 {
    group_label: "Count Rounds With Moves Added"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_rounds_with_moves_added ;;
  }
  measure: count_rounds_with_moves_added_50 {
    group_label: "Count Rounds With Moves Added"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_rounds_with_moves_added ;;
  }
  measure: count_rounds_with_moves_added_75 {
    group_label: "Count Rounds With Moves Added"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_rounds_with_moves_added ;;
  }
  measure: count_rounds_with_moves_added_95 {
    group_label: "Count Rounds With Moves Added"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_rounds_with_moves_added ;;
  }
  measure: sum_coins_earned {
    group_label: "Coins Earned"
    type:sum
    sql: ${TABLE}.coins_earned ;;
  }
  measure: coins_earned_10 {
    group_label: "Coins Earned"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_earned ;;
  }
  measure: coins_earned_25 {
    group_label: "Coins Earned"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_earned ;;
  }
  measure: coins_earned_50 {
    group_label: "Coins Earned"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_earned ;;
  }
  measure: coins_earned_75 {
    group_label: "Coins Earned"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_earned ;;
  }
  measure: coins_earned_95 {
    group_label: "Coins Earned"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coins_earned ;;
  }
  measure: sum_proximity_to_completion {
    group_label: "Proximity To Completion"
    type:sum
    sql: ${TABLE}.proximity_to_completion ;;
  }
  measure: proximity_to_completion_10 {
    group_label: "Proximity To Completion"
    type: percentile
    percentile: 10
    sql: ${TABLE}.proximity_to_completion ;;
  }
  measure: proximity_to_completion_25 {
    group_label: "Proximity To Completion"
    type: percentile
    percentile: 25
    sql: ${TABLE}.proximity_to_completion ;;
  }
  measure: proximity_to_completion_50 {
    group_label: "Proximity To Completion"
    type: percentile
    percentile: 50
    sql: ${TABLE}.proximity_to_completion ;;
  }
  measure: proximity_to_completion_75 {
    group_label: "Proximity To Completion"
    type: percentile
    percentile: 75
    sql: ${TABLE}.proximity_to_completion ;;
  }
  measure: proximity_to_completion_95 {
    group_label: "Proximity To Completion"
    type: percentile
    percentile: 95
    sql: ${TABLE}.proximity_to_completion ;;
  }
  measure: sum_coins_balance {
    group_label: "Coins Balance"
    type:sum
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_10 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_25 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_50 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_75 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_95 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coins_balance ;;
  }
  measure: sum_lives_balance {
    group_label: "Lives Balance"
    type:sum
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_10 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_25 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_50 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_75 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_95 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.lives_balance ;;
  }
  measure: sum_stars_balance {
    group_label: "Stars Balance"
    type:sum
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_10 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_25 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_50 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_75 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_95 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.stars_balance ;;
  }
  measure: sum_in_round_mtx_purchase_dollars {
    group_label: "In Round MTX Purchase Dollars"
    type:sum
    sql: ${TABLE}.in_round_mtx_purchase_dollars ;;
  }
  measure: in_round_mtx_purchase_dollars_10 {
    group_label: "In Round MTX Purchase Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.in_round_mtx_purchase_dollars ;;
  }
  measure: in_round_mtx_purchase_dollars_25 {
    group_label: "In Round MTX Purchase Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.in_round_mtx_purchase_dollars ;;
  }
  measure: in_round_mtx_purchase_dollars_50 {
    group_label: "In Round MTX Purchase Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.in_round_mtx_purchase_dollars ;;
  }
  measure: in_round_mtx_purchase_dollars_75 {
    group_label: "In Round MTX Purchase Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.in_round_mtx_purchase_dollars ;;
  }
  measure: in_round_mtx_purchase_dollars_95 {
    group_label: "In Round MTX Purchase Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.in_round_mtx_purchase_dollars ;;
  }
  measure: sum_in_round_count_mtx_purchases {
    group_label: "In Round Count MTX Purchases"
    type:sum
    sql: ${TABLE}.in_round_count_mtx_purchases ;;
  }
  measure: in_round_count_mtx_purchases_10 {
    group_label: "In Round Count MTX Purchases"
    type: percentile
    percentile: 10
    sql: ${TABLE}.in_round_count_mtx_purchases ;;
  }
  measure: in_round_count_mtx_purchases_25 {
    group_label: "In Round Count MTX Purchases"
    type: percentile
    percentile: 25
    sql: ${TABLE}.in_round_count_mtx_purchases ;;
  }
  measure: in_round_count_mtx_purchases_50 {
    group_label: "In Round Count MTX Purchases"
    type: percentile
    percentile: 50
    sql: ${TABLE}.in_round_count_mtx_purchases ;;
  }
  measure: in_round_count_mtx_purchases_75 {
    group_label: "In Round Count MTX Purchases"
    type: percentile
    percentile: 75
    sql: ${TABLE}.in_round_count_mtx_purchases ;;
  }
  measure: in_round_count_mtx_purchases_95 {
    group_label: "In Round Count MTX Purchases"
    type: percentile
    percentile: 95
    sql: ${TABLE}.in_round_count_mtx_purchases ;;
  }
  measure: sum_in_round_ad_view_dollars {
    group_label: "In Round Ad View Dollars"
    type:sum
    sql: ${TABLE}.in_round_ad_view_dollars ;;
  }
  measure: in_round_ad_view_dollars_10 {
    group_label: "In Round Ad View Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.in_round_ad_view_dollars ;;
  }
  measure: in_round_ad_view_dollars_25 {
    group_label: "In Round Ad View Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.in_round_ad_view_dollars ;;
  }
  measure: in_round_ad_view_dollars_50 {
    group_label: "In Round Ad View Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.in_round_ad_view_dollars ;;
  }
  measure: in_round_ad_view_dollars_75 {
    group_label: "In Round Ad View Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.in_round_ad_view_dollars ;;
  }
  measure: in_round_ad_view_dollars_95 {
    group_label: "In Round Ad View Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.in_round_ad_view_dollars ;;
  }
  measure: sum_in_round_count_ad_views {
    group_label: "In Round Count Ad Views"
    type:sum
    sql: ${TABLE}.in_round_count_ad_views ;;
  }
  measure: in_round_count_ad_views_10 {
    group_label: "In Round Count Ad Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.in_round_count_ad_views ;;
  }
  measure: in_round_count_ad_views_25 {
    group_label: "In Round Count Ad Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.in_round_count_ad_views ;;
  }
  measure: in_round_count_ad_views_50 {
    group_label: "In Round Count Ad Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.in_round_count_ad_views ;;
  }
  measure: in_round_count_ad_views_75 {
    group_label: "In Round Count Ad Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.in_round_count_ad_views ;;
  }
  measure: in_round_count_ad_views_95 {
    group_label: "In Round Count Ad Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.in_round_count_ad_views ;;
  }
  measure: sum_in_round_coin_spend {
    group_label: "In Round Coin Spend"
    type:sum
    sql: ${TABLE}.in_round_coin_spend ;;
  }
  measure: in_round_coin_spend_10 {
    group_label: "In Round Coin Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.in_round_coin_spend ;;
  }
  measure: in_round_coin_spend_25 {
    group_label: "In Round Coin Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.in_round_coin_spend ;;
  }
  measure: in_round_coin_spend_50 {
    group_label: "In Round Coin Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.in_round_coin_spend ;;
  }
  measure: in_round_coin_spend_75 {
    group_label: "In Round Coin Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.in_round_coin_spend ;;
  }
  measure: in_round_coin_spend_95 {
    group_label: "In Round Coin Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.in_round_coin_spend ;;
  }
  measure: sum_in_round_count_coin_spend_events {
    group_label: "In Round Count Coin Spend Events"
    type:sum
    sql: ${TABLE}.in_round_count_coin_spend_events ;;
  }
  measure: in_round_count_coin_spend_events_10 {
    group_label: "In Round Count Coin Spend Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.in_round_count_coin_spend_events ;;
  }
  measure: in_round_count_coin_spend_events_25 {
    group_label: "In Round Count Coin Spend Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.in_round_count_coin_spend_events ;;
  }
  measure: in_round_count_coin_spend_events_50 {
    group_label: "In Round Count Coin Spend Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.in_round_count_coin_spend_events ;;
  }
  measure: in_round_count_coin_spend_events_75 {
    group_label: "In Round Count Coin Spend Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.in_round_count_coin_spend_events ;;
  }
  measure: in_round_count_coin_spend_events_95 {
    group_label: "In Round Count Coin Spend Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.in_round_count_coin_spend_events ;;
  }
  measure: sum_in_round_combined_dollars {
    group_label: "In Round Combined Dollars"
    type:sum
    sql: ${TABLE}.in_round_combined_dollars ;;
  }
  measure: in_round_combined_dollars_10 {
    group_label: "In Round Combined Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.in_round_combined_dollars ;;
  }
  measure: in_round_combined_dollars_25 {
    group_label: "In Round Combined Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.in_round_combined_dollars ;;
  }
  measure: in_round_combined_dollars_50 {
    group_label: "In Round Combined Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.in_round_combined_dollars ;;
  }
  measure: in_round_combined_dollars_75 {
    group_label: "In Round Combined Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.in_round_combined_dollars ;;
  }
  measure: in_round_combined_dollars_95 {
    group_label: "In Round Combined Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.in_round_combined_dollars ;;
  }
  measure: sum_cumulative_round_by_level_game_mode {
    group_label: "Cumulative Round By Level Game Mode"
    type:sum
    sql: ${TABLE}.cumulative_round_by_level_game_mode ;;
  }
  measure: cumulative_round_by_level_game_mode_10 {
    group_label: "Cumulative Round By Level Game Mode"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_by_level_game_mode ;;
  }
  measure: cumulative_round_by_level_game_mode_25 {
    group_label: "Cumulative Round By Level Game Mode"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_by_level_game_mode ;;
  }
  measure: cumulative_round_by_level_game_mode_50 {
    group_label: "Cumulative Round By Level Game Mode"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_by_level_game_mode ;;
  }
  measure: cumulative_round_by_level_game_mode_75 {
    group_label: "Cumulative Round By Level Game Mode"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_by_level_game_mode ;;
  }
  measure: cumulative_round_by_level_game_mode_95 {
    group_label: "Cumulative Round By Level Game Mode"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_by_level_game_mode ;;
  }
  measure: sum_round_end_cumulative_mtx_purchase_dollars {
    group_label: "Round End Cumulative MTX Purchase Dollars"
    type:sum
    sql: ${TABLE}.round_end_cumulative_mtx_purchase_dollars ;;
  }
  measure: round_end_cumulative_mtx_purchase_dollars_10 {
    group_label: "Round End Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_cumulative_mtx_purchase_dollars ;;
  }
  measure: round_end_cumulative_mtx_purchase_dollars_25 {
    group_label: "Round End Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_cumulative_mtx_purchase_dollars ;;
  }
  measure: round_end_cumulative_mtx_purchase_dollars_50 {
    group_label: "Round End Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_cumulative_mtx_purchase_dollars ;;
  }
  measure: round_end_cumulative_mtx_purchase_dollars_75 {
    group_label: "Round End Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_cumulative_mtx_purchase_dollars ;;
  }
  measure: round_end_cumulative_mtx_purchase_dollars_95 {
    group_label: "Round End Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_cumulative_mtx_purchase_dollars ;;
  }
  measure: sum_round_end_cumulative_count_mtx_purchases {
    group_label: "Round End Cumulative Count MTX Purchases"
    type:sum
    sql: ${TABLE}.round_end_cumulative_count_mtx_purchases ;;
  }
  measure: round_end_cumulative_count_mtx_purchases_10 {
    group_label: "Round End Cumulative Count MTX Purchases"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_cumulative_count_mtx_purchases ;;
  }
  measure: round_end_cumulative_count_mtx_purchases_25 {
    group_label: "Round End Cumulative Count MTX Purchases"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_cumulative_count_mtx_purchases ;;
  }
  measure: round_end_cumulative_count_mtx_purchases_50 {
    group_label: "Round End Cumulative Count MTX Purchases"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_cumulative_count_mtx_purchases ;;
  }
  measure: round_end_cumulative_count_mtx_purchases_75 {
    group_label: "Round End Cumulative Count MTX Purchases"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_cumulative_count_mtx_purchases ;;
  }
  measure: round_end_cumulative_count_mtx_purchases_95 {
    group_label: "Round End Cumulative Count MTX Purchases"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_cumulative_count_mtx_purchases ;;
  }
  measure: sum_round_end_cumulative_ad_view_dollars {
    group_label: "Round End Cumulative Ad View Dollars"
    type:sum
    sql: ${TABLE}.round_end_cumulative_ad_view_dollars ;;
  }
  measure: round_end_cumulative_ad_view_dollars_10 {
    group_label: "Round End Cumulative Ad View Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_cumulative_ad_view_dollars ;;
  }
  measure: round_end_cumulative_ad_view_dollars_25 {
    group_label: "Round End Cumulative Ad View Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_cumulative_ad_view_dollars ;;
  }
  measure: round_end_cumulative_ad_view_dollars_50 {
    group_label: "Round End Cumulative Ad View Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_cumulative_ad_view_dollars ;;
  }
  measure: round_end_cumulative_ad_view_dollars_75 {
    group_label: "Round End Cumulative Ad View Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_cumulative_ad_view_dollars ;;
  }
  measure: round_end_cumulative_ad_view_dollars_95 {
    group_label: "Round End Cumulative Ad View Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_cumulative_ad_view_dollars ;;
  }
  measure: sum_round_end_cumulative_count_ad_views {
    group_label: "Round End Cumulative Count Ad Views"
    type:sum
    sql: ${TABLE}.round_end_cumulative_count_ad_views ;;
  }
  measure: round_end_cumulative_count_ad_views_10 {
    group_label: "Round End Cumulative Count Ad Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_cumulative_count_ad_views ;;
  }
  measure: round_end_cumulative_count_ad_views_25 {
    group_label: "Round End Cumulative Count Ad Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_cumulative_count_ad_views ;;
  }
  measure: round_end_cumulative_count_ad_views_50 {
    group_label: "Round End Cumulative Count Ad Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_cumulative_count_ad_views ;;
  }
  measure: round_end_cumulative_count_ad_views_75 {
    group_label: "Round End Cumulative Count Ad Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_cumulative_count_ad_views ;;
  }
  measure: round_end_cumulative_count_ad_views_95 {
    group_label: "Round End Cumulative Count Ad Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_cumulative_count_ad_views ;;
  }
  measure: sum_round_end_cumulative_coin_spend {
    group_label: "Round End Cumulative Coin Spend"
    type:sum
    sql: ${TABLE}.round_end_cumulative_coin_spend ;;
  }
  measure: round_end_cumulative_coin_spend_10 {
    group_label: "Round End Cumulative Coin Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_cumulative_coin_spend ;;
  }
  measure: round_end_cumulative_coin_spend_25 {
    group_label: "Round End Cumulative Coin Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_cumulative_coin_spend ;;
  }
  measure: round_end_cumulative_coin_spend_50 {
    group_label: "Round End Cumulative Coin Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_cumulative_coin_spend ;;
  }
  measure: round_end_cumulative_coin_spend_75 {
    group_label: "Round End Cumulative Coin Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_cumulative_coin_spend ;;
  }
  measure: round_end_cumulative_coin_spend_95 {
    group_label: "Round End Cumulative Coin Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_cumulative_coin_spend ;;
  }
  measure: sum_round_end_cumulative_count_coin_spend_events {
    group_label: "Round End Cumulative Count Coin Spend Events"
    type:sum
    sql: ${TABLE}.round_end_cumulative_count_coin_spend_events ;;
  }
  measure: round_end_cumulative_count_coin_spend_events_10 {
    group_label: "Round End Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_cumulative_count_coin_spend_events ;;
  }
  measure: round_end_cumulative_count_coin_spend_events_25 {
    group_label: "Round End Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_cumulative_count_coin_spend_events ;;
  }
  measure: round_end_cumulative_count_coin_spend_events_50 {
    group_label: "Round End Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_cumulative_count_coin_spend_events ;;
  }
  measure: round_end_cumulative_count_coin_spend_events_75 {
    group_label: "Round End Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_cumulative_count_coin_spend_events ;;
  }
  measure: round_end_cumulative_count_coin_spend_events_95 {
    group_label: "Round End Cumulative Count Coin Spend Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_cumulative_count_coin_spend_events ;;
  }
  measure: sum_round_end_cumulative_combined_dollars {
    group_label: "Round End Cumulative Combined Dollars"
    type:sum
    sql: ${TABLE}.round_end_cumulative_combined_dollars ;;
  }
  measure: round_end_cumulative_combined_dollars_10 {
    group_label: "Round End Cumulative Combined Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_cumulative_combined_dollars ;;
  }
  measure: round_end_cumulative_combined_dollars_25 {
    group_label: "Round End Cumulative Combined Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_cumulative_combined_dollars ;;
  }
  measure: round_end_cumulative_combined_dollars_50 {
    group_label: "Round End Cumulative Combined Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_cumulative_combined_dollars ;;
  }
  measure: round_end_cumulative_combined_dollars_75 {
    group_label: "Round End Cumulative Combined Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_cumulative_combined_dollars ;;
  }
  measure: round_end_cumulative_combined_dollars_95 {
    group_label: "Round End Cumulative Combined Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_cumulative_combined_dollars ;;
  }
  measure: sum_churn_indicator {
    group_label: "Churn Indicator"
    type:sum
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_10 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_25 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_50 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_75 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_95 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: sum_cumulative_round_by_level_game_mode_at_churn {
    group_label: "Cumulative Round By Level Game Mode At Churn"
    type:sum
    sql: ${TABLE}.cumulative_round_by_level_game_mode_at_churn ;;
  }
  measure: cumulative_round_by_level_game_mode_at_churn_10 {
    group_label: "Cumulative Round By Level Game Mode At Churn"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_by_level_game_mode_at_churn ;;
  }
  measure: cumulative_round_by_level_game_mode_at_churn_25 {
    group_label: "Cumulative Round By Level Game Mode At Churn"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_by_level_game_mode_at_churn ;;
  }
  measure: cumulative_round_by_level_game_mode_at_churn_50 {
    group_label: "Cumulative Round By Level Game Mode At Churn"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_by_level_game_mode_at_churn ;;
  }
  measure: cumulative_round_by_level_game_mode_at_churn_75 {
    group_label: "Cumulative Round By Level Game Mode At Churn"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_by_level_game_mode_at_churn ;;
  }
  measure: cumulative_round_by_level_game_mode_at_churn_95 {
    group_label: "Cumulative Round By Level Game Mode At Churn"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_by_level_game_mode_at_churn ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars_at_churn {
    group_label: "Cumulative MTX Purchase Dollars At Churn"
    type:sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_at_churn ;;
  }
  measure: cumulative_mtx_purchase_dollars_at_churn_10 {
    group_label: "Cumulative MTX Purchase Dollars At Churn"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_at_churn ;;
  }
  measure: cumulative_mtx_purchase_dollars_at_churn_25 {
    group_label: "Cumulative MTX Purchase Dollars At Churn"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_at_churn ;;
  }
  measure: cumulative_mtx_purchase_dollars_at_churn_50 {
    group_label: "Cumulative MTX Purchase Dollars At Churn"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_at_churn ;;
  }
  measure: cumulative_mtx_purchase_dollars_at_churn_75 {
    group_label: "Cumulative MTX Purchase Dollars At Churn"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_at_churn ;;
  }
  measure: cumulative_mtx_purchase_dollars_at_churn_95 {
    group_label: "Cumulative MTX Purchase Dollars At Churn"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_at_churn ;;
  }
  measure: sum_cumulative_count_mtx_purchases_at_churn {
    group_label: "Cumulative Count MTX Purchases At Churn"
    type:sum
    sql: ${TABLE}.cumulative_count_mtx_purchases_at_churn ;;
  }
  measure: cumulative_count_mtx_purchases_at_churn_10 {
    group_label: "Cumulative Count MTX Purchases At Churn"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_mtx_purchases_at_churn ;;
  }
  measure: cumulative_count_mtx_purchases_at_churn_25 {
    group_label: "Cumulative Count MTX Purchases At Churn"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_mtx_purchases_at_churn ;;
  }
  measure: cumulative_count_mtx_purchases_at_churn_50 {
    group_label: "Cumulative Count MTX Purchases At Churn"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_mtx_purchases_at_churn ;;
  }
  measure: cumulative_count_mtx_purchases_at_churn_75 {
    group_label: "Cumulative Count MTX Purchases At Churn"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_mtx_purchases_at_churn ;;
  }
  measure: cumulative_count_mtx_purchases_at_churn_95 {
    group_label: "Cumulative Count MTX Purchases At Churn"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_mtx_purchases_at_churn ;;
  }
  measure: sum_cumulative_ad_view_dollars_at_churn {
    group_label: "Cumulative Ad View Dollars At Churn"
    type:sum
    sql: ${TABLE}.cumulative_ad_view_dollars_at_churn ;;
  }
  measure: cumulative_ad_view_dollars_at_churn_10 {
    group_label: "Cumulative Ad View Dollars At Churn"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_view_dollars_at_churn ;;
  }
  measure: cumulative_ad_view_dollars_at_churn_25 {
    group_label: "Cumulative Ad View Dollars At Churn"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_view_dollars_at_churn ;;
  }
  measure: cumulative_ad_view_dollars_at_churn_50 {
    group_label: "Cumulative Ad View Dollars At Churn"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_view_dollars_at_churn ;;
  }
  measure: cumulative_ad_view_dollars_at_churn_75 {
    group_label: "Cumulative Ad View Dollars At Churn"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_view_dollars_at_churn ;;
  }
  measure: cumulative_ad_view_dollars_at_churn_95 {
    group_label: "Cumulative Ad View Dollars At Churn"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_view_dollars_at_churn ;;
  }
  measure: sum_cumulative_count_ad_views_at_churn {
    group_label: "Cumulative Count Ad Views At Churn"
    type:sum
    sql: ${TABLE}.cumulative_count_ad_views_at_churn ;;
  }
  measure: cumulative_count_ad_views_at_churn_10 {
    group_label: "Cumulative Count Ad Views At Churn"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_ad_views_at_churn ;;
  }
  measure: cumulative_count_ad_views_at_churn_25 {
    group_label: "Cumulative Count Ad Views At Churn"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_ad_views_at_churn ;;
  }
  measure: cumulative_count_ad_views_at_churn_50 {
    group_label: "Cumulative Count Ad Views At Churn"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_ad_views_at_churn ;;
  }
  measure: cumulative_count_ad_views_at_churn_75 {
    group_label: "Cumulative Count Ad Views At Churn"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_ad_views_at_churn ;;
  }
  measure: cumulative_count_ad_views_at_churn_95 {
    group_label: "Cumulative Count Ad Views At Churn"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_ad_views_at_churn ;;
  }
  measure: sum_cumulative_coin_spend_at_churn {
    group_label: "Cumulative Coin Spend At Churn"
    type:sum
    sql: ${TABLE}.cumulative_coin_spend_at_churn ;;
  }
  measure: cumulative_coin_spend_at_churn_10 {
    group_label: "Cumulative Coin Spend At Churn"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_coin_spend_at_churn ;;
  }
  measure: cumulative_coin_spend_at_churn_25 {
    group_label: "Cumulative Coin Spend At Churn"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_coin_spend_at_churn ;;
  }
  measure: cumulative_coin_spend_at_churn_50 {
    group_label: "Cumulative Coin Spend At Churn"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_coin_spend_at_churn ;;
  }
  measure: cumulative_coin_spend_at_churn_75 {
    group_label: "Cumulative Coin Spend At Churn"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_coin_spend_at_churn ;;
  }
  measure: cumulative_coin_spend_at_churn_95 {
    group_label: "Cumulative Coin Spend At Churn"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_coin_spend_at_churn ;;
  }
  measure: sum_cumulative_count_coin_spend_events_at_churn {
    group_label: "Cumulative Count Coin Spend Events At Churn"
    type:sum
    sql: ${TABLE}.cumulative_count_coin_spend_events_at_churn ;;
  }
  measure: cumulative_count_coin_spend_events_at_churn_10 {
    group_label: "Cumulative Count Coin Spend Events At Churn"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_coin_spend_events_at_churn ;;
  }
  measure: cumulative_count_coin_spend_events_at_churn_25 {
    group_label: "Cumulative Count Coin Spend Events At Churn"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_coin_spend_events_at_churn ;;
  }
  measure: cumulative_count_coin_spend_events_at_churn_50 {
    group_label: "Cumulative Count Coin Spend Events At Churn"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_coin_spend_events_at_churn ;;
  }
  measure: cumulative_count_coin_spend_events_at_churn_75 {
    group_label: "Cumulative Count Coin Spend Events At Churn"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_coin_spend_events_at_churn ;;
  }
  measure: cumulative_count_coin_spend_events_at_churn_95 {
    group_label: "Cumulative Count Coin Spend Events At Churn"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_coin_spend_events_at_churn ;;
  }
  measure: sum_cumulative_combined_dollars_at_churn {
    group_label: "Cumulative Combined Dollars At Churn"
    type:sum
    sql: ${TABLE}.cumulative_combined_dollars_at_churn ;;
  }
  measure: cumulative_combined_dollars_at_churn_10 {
    group_label: "Cumulative Combined Dollars At Churn"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_combined_dollars_at_churn ;;
  }
  measure: cumulative_combined_dollars_at_churn_25 {
    group_label: "Cumulative Combined Dollars At Churn"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_combined_dollars_at_churn ;;
  }
  measure: cumulative_combined_dollars_at_churn_50 {
    group_label: "Cumulative Combined Dollars At Churn"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_combined_dollars_at_churn ;;
  }
  measure: cumulative_combined_dollars_at_churn_75 {
    group_label: "Cumulative Combined Dollars At Churn"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_combined_dollars_at_churn ;;
  }
  measure: cumulative_combined_dollars_at_churn_95 {
    group_label: "Cumulative Combined Dollars At Churn"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_combined_dollars_at_churn ;;
  }





}
