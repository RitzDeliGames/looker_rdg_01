view: player_round_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last manual update: '2023-03-15'


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

          -- lag previous win_streak as win_streak_at_round_start
          , ifnull(
              lag(win_streak) over (
                partition by rdg_id
                order by round_start_timestamp_utc asc
                ) , 0 ) as win_streak_at_round_start

        from
          `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_incremental`
      )

      -----------------------------------------------------------------------------
      -- join on mtx_spend
      -----------------------------------------------------------------------------

      , join_on_mtx_spend as (

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
          , max(a.win_streak_at_round_start) as win_streak_at_round_start
          , max(a.win_streak) as win_streak_at_round_end
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
          , max(a.objective_0) as objective_0
          , max(a.objective_1) as objective_1
          , max(a.objective_2) as objective_2
          , max(a.objective_3) as objective_3
          , max(a.objective_4) as objective_4
          , max(a.objective_5) as objective_5
          , max(timestamp(timestamp_millis(safe_cast(a.config_timestamp as int64)))) as config_timestamp

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

        from
          base_data a
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_summary` b
            on b.rdg_id = a.rdg_id
            and b.timestamp_utc > a.previous_round_end_timestamp_utc
            and b.timestamp_utc <= a.round_end_timestamp_utc

        group by
          1,2,3,4,5,6

      )

      -----------------------------------------------------------------------------
      -- join on ad_spend
      -----------------------------------------------------------------------------

      , join_on_ad_spend as (

        select
          a.rdg_id
          , a.rdg_date
          , a.game_mode
          , a.level_serial
          , a.round_start_timestamp_utc
          , a.round_end_timestamp_utc
          , max(a.created_at) as created_at
          , max(a.version) as version
          , max(a.session_id) as session_id
          , max(a.experiments) as experiments
          , max(a.win_streak_at_round_start) as win_streak_at_round_start
          , max(a.win_streak_at_round_end) as win_streak_at_round_end
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

          , max(a.before_round_start_mtx_purchase_dollars) as before_round_start_mtx_purchase_dollars
          , max(a.in_round_mtx_purchase_dollars) as in_round_mtx_purchase_dollars
          , max(a.total_mtx_purchase_dollars) as total_mtx_purchase_dollars
          , max(a.before_round_start_count_mtx_purchases) as before_round_start_count_mtx_purchases
          , max(a.in_round_count_mtx_purchases) as in_round_count_mtx_purchases
          , max(a.total_count_mtx_purchases) as total_count_mtx_purchases
          , max(a.objective_0) as objective_0
          , max(a.objective_1) as objective_1
          , max(a.objective_2) as objective_2
          , max(a.objective_3) as objective_3
          , max(a.objective_4) as objective_4
          , max(a.objective_5) as objective_5
          , max(a.config_timestamp) as config_timestamp

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

        from
          join_on_mtx_spend a
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary` c
            on c.rdg_id = a.rdg_id
            and c.timestamp_utc > a.previous_round_end_timestamp_utc
            and c.timestamp_utc <= a.round_end_timestamp_utc


        group by
          1,2,3,4,5,6

      )

      -----------------------------------------------------------------------------
      -- join on coin_spend
      -----------------------------------------------------------------------------

      , join_on_coin_spend as (

        select
          a.rdg_id
          , a.rdg_date
          , a.game_mode
          , a.level_serial
          , a.round_start_timestamp_utc
          , a.round_end_timestamp_utc
          , max(a.created_at) as created_at
          , max(a.version) as version
          , max(a.session_id) as session_id
          , max(a.experiments) as experiments
          , max(a.win_streak_at_round_start) as win_streak_at_round_start
          , max(a.win_streak_at_round_end) as win_streak_at_round_end
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
          , max(a.objective_0) as objective_0
          , max(a.objective_1) as objective_1
          , max(a.objective_2) as objective_2
          , max(a.objective_3) as objective_3
          , max(a.objective_4) as objective_4
          , max(a.objective_5) as objective_5
          , max(a.config_timestamp) as config_timestamp

          , max(a.before_round_start_mtx_purchase_dollars) as before_round_start_mtx_purchase_dollars
          , max(a.in_round_mtx_purchase_dollars) as in_round_mtx_purchase_dollars
          , max(a.total_mtx_purchase_dollars) as total_mtx_purchase_dollars
          , max(a.before_round_start_count_mtx_purchases) as before_round_start_count_mtx_purchases
          , max(a.in_round_count_mtx_purchases) as in_round_count_mtx_purchases
          , max(a.total_count_mtx_purchases) as total_count_mtx_purchases

          , max(a.before_round_start_ad_view_dollars) as before_round_start_ad_view_dollars
          , max(a.in_round_ad_view_dollars) as in_round_ad_view_dollars
          , max(a.total_ad_view_dollars) as total_ad_view_dollars
          , max(a.before_round_start_count_ad_views) as before_round_start_count_ad_views
          , max(a.in_round_count_ad_views) as in_round_count_ad_views
          , max(a.total_count_ad_views) as total_count_ad_views

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
          join_on_ad_spend a
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_spend_summary` d
            on d.rdg_id = a.rdg_id
            and d.timestamp_utc > a.previous_round_end_timestamp_utc
            and d.timestamp_utc <= a.round_end_timestamp_utc


        group by
          1,2,3,4,5,6

      )

      -- select
      --   date(rdg_date) as rdg_date
      --   , sum( before_round_start_mtx_purchase_dollars ) as before_round_start_count_mtx_purchases
      --   , sum( in_round_mtx_purchase_dollars ) as in_round_mtx_purchase_dollars
      --   , sum( total_mtx_purchase_dollars ) as total_mtx_purchase_dollars
      -- from
      --   join_on_coin_spend
      -- where
      --   date(rdg_date) between '2023-02-11' and '2023-03-01'
      -- group by
      --   1
      -- order by
      --   1

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
          join_on_coin_spend

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
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -4 hour)) ;;
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

  dimension_group: config_timestamp {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.config_timestamp ;;
  }

  # Strings and Numbers
  dimension: rdg_id {
    group_label:"Player IDs"
    type:string
    }
  dimension: game_mode {type:string}
  dimension: level_serial {
    group_label: "Level Fields"
    label: "Current Level"
    type:number
    }
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak_at_round_start {type:number}
  dimension: win_streak_at_round_end {type:number}
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
  dimension: level_id {
    group_label: "Level Fields"
    type:string
    }
  dimension: last_level_serial {
    group_label: "Level Fields"
    type:number
    }
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


  dimension: round_attempt_number_at_churn_tiers {
    type:tier
    tiers: [1,2,5]
    style: integer
    sql: ${TABLE}.cumulative_round_by_level_game_mode_at_churn;;
    }

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
    sql:
      safe_divide(
        sum(${TABLE}.count_rounds)
        ,
        sum(${TABLE}.count_wins)
      )
    ;;
    value_format_name: decimal_1

  }

  measure: mean_proximity_to_completion_on_loss {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(
          case
            when ${TABLE}.count_wins = 0
            then ${TABLE}.proximity_to_completion
            else 0
          end
          )
        ,
        sum(
          case
            when ${TABLE}.count_wins = 0
            then ${TABLE}.count_rounds
            else 0
          end
          )
      )
    ;;
    value_format_name: percent_1

  }

  measure: percent_moves_remaing_vs_moves_at_start_on_win {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(
          case
            when ${TABLE}.count_wins = 1
            then ${TABLE}.moves_remaining
            else 0
          end
          )
        ,
        sum(
          case
            when ${TABLE}.count_wins = 1
            then ${TABLE}.moves
            else 0
          end
          )
      )
    ;;
    value_format_name: percent_1
  }

  measure: median_moves_remaing_on_win {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.count_wins = 1
          then ${TABLE}.moves_remaining
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_objective_0_remaing_on_loss {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.count_wins = 0
          then ${TABLE}.objective_0
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_objective_1_remaing_on_loss {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.count_wins = 0
          then ${TABLE}.objective_1
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_objective_2_remaing_on_loss {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.count_wins = 0
          then ${TABLE}.objective_2
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_objective_3_remaing_on_loss {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.count_wins = 0
          then ${TABLE}.objective_3
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_objective_4_remaing_on_loss {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.count_wins = 0
          then ${TABLE}.objective_4
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_objective_5_remaing_on_loss {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.count_wins = 0
          then ${TABLE}.objective_5
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_attempt_number_at_win {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.count_wins = 1
          then ${TABLE}.cumulative_round_by_level_game_mode
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_attempt_number_at_churn {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      case
          when ${TABLE}.churn_indicator = 1
          then ${TABLE}.cumulative_round_by_level_game_mode
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_round_length_in_minutes {
    group_label: "Calculated Fields"
    type: percentile
    percentile: 50
    sql:
      ${TABLE}.round_length_minutes
      ;;
    value_format_name: decimal_1
  }
  measure: percent_of_rounds_with_moves_added {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_rounds_with_moves_added)
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: percent_1
  }

  measure: mtx_dollars_per_player {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_mtx_purchase_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
      ;;
    value_format_name: usd

  }

  measure: ad_dollars_per_player {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_ad_view_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd

  }

  measure: total_dollars_per_player {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_combined_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd

  }

  measure: coin_spend_per_player {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_coin_spend)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: decimal_0

  }

  measure: level_efficiency_estimate_dollars {
    group_label: "Level Efficiency Estimates"
    type: number
    sql: sum(${TABLE}.in_round_combined_dollars) - sum(${TABLE}.cumulative_combined_dollars_at_churn) ;;
    value_format_name: usd

  }

  measure: level_efficiency_estimate_coin_spend {
    group_label: "Level Efficiency Estimates"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_coin_spend) - sum(${TABLE}.cumulative_coin_spend_at_churn)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: decimal_0

  }

  measure: churn_rate {
    group_label: "Excess Churn Estimate"
    type: number
    sql:
      safe_divide(
        count(distinct ${TABLE}.churn_rdg_id)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0

  }
  measure: churn_rate_on_win {
    group_label: "Excess Churn Estimate"
    type: number
    sql:
      safe_divide(
        count( distinct
          case
            when
              ${TABLE}.count_wins = 1
              and ${TABLE}.churn_indicator = 1
            then ${TABLE}.churn_rdg_id
            else null
            end )
        ,
        count( distinct ${TABLE}.rdg_id )
      )
    ;;
    value_format_name: percent_0
  }

  measure: churn_rate_on_loss {
    group_label: "Excess Churn Estimate"
    type: number
    sql:
      safe_divide(
        count( distinct
          case
            when
              ${TABLE}.count_wins = 0
              and ${TABLE}.churn_indicator = 1
            then ${TABLE}.churn_rdg_id
            else null
            end )
        ,
        count( distinct ${TABLE}.rdg_id )
      )
    ;;
    value_format_name: percent_0
  }

  measure: excess_churn_rate {
      group_label: "Excess Churn Estimate"
      type: number
      sql:
      safe_divide(
        count( distinct
          case
            when
              ${TABLE}.count_wins = 0
              and ${TABLE}.churn_indicator = 1
            then ${TABLE}.churn_rdg_id
            else null
            end )
        -
        count( distinct
          case
            when
              ${TABLE}.count_wins = 1
              and ${TABLE}.churn_indicator = 1
            then ${TABLE}.churn_rdg_id
            else null
            end )
        ,
        count( distinct ${TABLE}.rdg_id )
      )
    ;;
    value_format_name: percent_0
  }










}
