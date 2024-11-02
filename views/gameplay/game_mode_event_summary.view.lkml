view: game_mode_event_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-09-12'

      with

      flour_frenzy_daily as (

        select
          b.flour_frenzy_event_start_date as event_start_date
          , a.rdg_id
          , min(safe_cast(a.version as numeric)) as version_number_at_start_of_event
          , min(a.day_number) as day_number_at_start_of_event
          , min(a.lowest_last_level_serial) as lowest_level_at_start_of_event
          , min(a.experiments) as experiments
          , sum(a.count_days_played) as count_days_played
          , max( case when a.feature_participation_flour_frenzy > 0 then 1 else 0 end ) as game_mode_participation_indicator
          , max( case when a.feature_participation_flour_frenzy > 0 then 1 else 0 end ) as game_mode_completion_indicator
          , sum( case when a.feature_participation_flour_frenzy > 0 then a.count_days_played else 0 end ) as days_played_game_mode
          , sum( 0 ) as game_mode_round_end_events
          , max( case when a.daily_popup_FlourFrenzy is not null then 1 else 0 end ) as game_mode_popup_indicator
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary a
          -- left join eraser-blast.looker_scratch.6Y_ritz_deli_games_live_ops_calendar b
          --  on date(a.rdg_date) = b.rdg_date
          ${player_daily_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        where
          b.flour_frenzy_event_start_date is not null
        group by
          1,2

      )

      , castle_climb_daily as (

        select
          b.castle_climb_event_start_date as event_start_date
          , a.rdg_id
          , min(safe_cast(a.version as numeric)) as version_number_at_start_of_event
          , min(a.day_number) as day_number_at_start_of_event
          , min(a.lowest_last_level_serial) as lowest_level_at_start_of_event
          , min(a.experiments) as experiments
          , sum(a.count_days_played) as count_days_played
          , max( case when a.feature_participation_castle_climb > 0 then 1 else 0 end ) as game_mode_participation_indicator
          , max( case when a.feature_participation_castle_climb > 0 then 1 else 0 end ) as game_mode_completion_indicator
          , sum( case when a.feature_participation_castle_climb > 0 then a.count_days_played else 0 end ) as days_played_game_mode
          , sum( 0 ) as game_mode_round_end_events
          , max( case when a.daily_popup_CastleClimb is not null then 1 else 0 end ) as game_mode_popup_indicator
        from
          ${player_daily_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        where
          b.castle_climb_event_start_date is not null
        group by
          1,2

      )

      , hot_dog_daily as (

        select
          b.hot_dog_event_start_date as event_start_date
          , a.rdg_id
          , min(safe_cast(a.version as numeric)) as version_number_at_start_of_event
          , min(a.day_number) as day_number_at_start_of_event
          , min(a.lowest_last_level_serial) as lowest_level_at_start_of_event
          , min(a.experiments) as experiments
          , sum(a.count_days_played) as count_days_played
          , max( case when a.feature_participation_hot_dog_contest > 0 then 1 else 0 end ) as game_mode_participation_indicator
          , max( case when a.feature_participation_hot_dog_contest > 0 then 1 else 0 end ) as game_mode_completion_indicator
          , sum( case when a.feature_participation_hot_dog_contest > 0 then a.count_days_played else 0 end ) as days_played_game_mode
          , sum( 0 ) as game_mode_round_end_events
          , max( case when a.daily_popup_HotdogContest is not null then 1 else 0 end ) as game_mode_popup_indicator
        from
          ${player_daily_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        where
          b.hot_dog_event_start_date is not null
        group by
          1,2

      )

      , moves_master_daily as (

        select
          b.moves_master_event_start_date as event_start_date
          , a.rdg_id
          , min(safe_cast(a.version as numeric)) as version_number_at_start_of_event
          , min(a.day_number) as day_number_at_start_of_event
          , min(a.lowest_last_level_serial) as lowest_level_at_start_of_event
          , min(a.experiments) as experiments
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

      , puzzle_daily as (

        select
          b.puzzle_event_start_date as event_start_date
          , a.rdg_id
          , min(safe_cast(a.version as numeric)) as version_number_at_start_of_event
          , min(a.day_number) as day_number_at_start_of_event
          , min(a.lowest_last_level_serial) as lowest_level_at_start_of_event
          , min(a.experiments) as experiments
          , sum(a.count_days_played) as count_days_played
          , max( case when a.round_end_events_puzzle > 0 then 1 else 0 end ) as game_mode_participation_indicator
          , max( case when a.round_end_events_puzzle > 0 and a.feature_completion_puzzle > 0 then 1 else 0 end ) as game_mode_completion_indicator
          , sum( case when a.round_end_events_puzzle > 0 then a.count_days_played else 0 end ) as days_played_game_mode
          , sum( a.round_end_events_puzzle ) as game_mode_round_end_events
          , max( case when a.daily_popup_Puzzle is not null then 1 else 0 end ) as game_mode_popup_indicator
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

      , puzzle_rounds as (

        select
          b.puzzle_event_start_date as event_start_date
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
          and a.game_mode = 'puzzle'
          --and b.moves_master_event_start_date = '2024-09-03'
          --and date(a.rdg_date) >= '2024-09-03'

        group by
          1,2
      )

      , go_fish_daily as (

        select
          b.go_fish_event_start_date as event_start_date
          , a.rdg_id
          , min(safe_cast(a.version as numeric)) as version_number_at_start_of_event
          , min(a.day_number) as day_number_at_start_of_event
          , min(a.lowest_last_level_serial) as lowest_level_at_start_of_event
          , min(a.experiments) as experiments
          , sum(a.count_days_played) as count_days_played
          , max( case when a.round_end_events_gofish > 0 then 1 else 0 end ) as game_mode_participation_indicator
          , max( case when a.round_end_events_gofish > 0 and a.gofish_full_matches_completed > 0 then 1 else 0 end ) as game_mode_completion_indicator
          , sum( case when a.round_end_events_gofish > 0 then a.count_days_played else 0 end ) as days_played_game_mode
          , sum( a.round_end_events_gofish ) as game_mode_round_end_events
          , max( case when a.daily_popup_GoFish is not null then 1 else 0 end ) as game_mode_popup_indicator
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

      , go_fish_rounds as (

        select
          b.go_fish_event_start_date as event_start_date
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
          and a.game_mode = 'goFish'
          --and b.moves_master_event_start_date = '2024-09-03'
          --and date(a.rdg_date) >= '2024-09-03'

        group by
          1,2
      )

      , gem_quest_daily as (

        select
          b.gem_quest_event_start_date as event_start_date
          , a.rdg_id
          , min(safe_cast(a.version as numeric)) as version_number_at_start_of_event
          , min(a.day_number) as day_number_at_start_of_event
          , min(a.lowest_last_level_serial) as lowest_level_at_start_of_event
          , min(a.experiments) as experiments
          , sum(a.count_days_played) as count_days_played
          , max( case when a.round_end_events_gemquest > 0 then 1 else 0 end ) as game_mode_participation_indicator
          , max( case when a.round_end_events_gemquest > 0 and a.feature_completion_gem_quest > 0 then 1 else 0 end ) as game_mode_completion_indicator
          , sum( case when a.round_end_events_gemquest > 0 then a.count_days_played else 0 end ) as days_played_game_mode
          , sum( a.round_end_events_gemquest ) as game_mode_round_end_events
          , max( case when a.daily_popup_GemQuest is not null then 1 else 0 end ) as game_mode_popup_indicator
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

      , gem_quest_rounds as (

        select
          b.gem_quest_event_start_date as event_start_date
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
          and a.game_mode = 'gemQuest'
          --and b.moves_master_event_start_date = '2024-09-03'
          --and date(a.rdg_date) >= '2024-09-03'

        group by
          1,2
      )

      , flour_frenzy_rounds as (

        select
          b.flour_frenzy_event_start_date as event_start_date
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
          b.flour_frenzy_event_start_date is not null
          and a.is_active_flour_frenzy
          --and b.moves_master_event_start_date = '2024-09-03'
          --and date(a.rdg_date) >= '2024-09-03'

        group by
          1,2
      )

      , castle_climb_rounds as (

        select
          b.castle_climb_event_start_date as event_start_date
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
          ${player_round_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        where
          b.castle_climb_event_start_date is not null
          and a.is_active_castle_climb

        group by
          1,2
      )

      , hot_dog_rounds as (

        select
          b.hot_dog_event_start_date as event_start_date
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
          ${player_round_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        where
          b.hot_dog_event_start_date is not null
          and a.is_active_hotdog_contest

        group by
          1,2
      )

      select
        timestamp(a.event_start_date) as event_start_date
        , 'movesMaster' as game_mode
        , a.rdg_id
        , a.version_number_at_start_of_event
        , a.day_number_at_start_of_event
        , a.lowest_level_at_start_of_event
        , a.experiments
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

      union all
      select
        timestamp(a.event_start_date) as event_start_date
        , 'puzzle' as game_mode
        , a.rdg_id
        , a.version_number_at_start_of_event
        , a.day_number_at_start_of_event
        , a.lowest_level_at_start_of_event
        , a.experiments
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
        puzzle_daily a
        left join puzzle_rounds b
          on a.event_start_date = b.event_start_date
          and a.rdg_id = b.rdg_id

      union all
      select
        timestamp(a.event_start_date) as event_start_date
        , 'goFish' as game_mode
        , a.rdg_id
        , a.version_number_at_start_of_event
        , a.day_number_at_start_of_event
        , a.lowest_level_at_start_of_event
        , a.experiments
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
        go_fish_daily a
        left join go_fish_rounds b
          on a.event_start_date = b.event_start_date
          and a.rdg_id = b.rdg_id

      union all
      select
        timestamp(a.event_start_date) as event_start_date
        , 'gemQuest' as game_mode
        , a.rdg_id
        , a.version_number_at_start_of_event
        , a.day_number_at_start_of_event
        , a.lowest_level_at_start_of_event
        , a.experiments
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
        gem_quest_daily a
        left join gem_quest_rounds b
          on a.event_start_date = b.event_start_date
          and a.rdg_id = b.rdg_id


      union all
      select
        timestamp(a.event_start_date) as event_start_date
        , 'flourFrenzy' as game_mode
        , a.rdg_id
        , a.version_number_at_start_of_event
        , a.day_number_at_start_of_event
        , a.lowest_level_at_start_of_event
        , a.experiments
        , a.count_days_played
        , a.game_mode_participation_indicator
        , a.game_mode_completion_indicator
        , a.days_played_game_mode
        , ifnull( b.count_rounds, 0 ) as game_mode_round_end_events
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
        flour_frenzy_daily a
        left join flour_frenzy_rounds b
          on a.event_start_date = b.event_start_date
          and a.rdg_id = b.rdg_id

      union all
      select
        timestamp(a.event_start_date) as event_start_date
        , 'castleClimb' as game_mode
        , a.rdg_id
        , a.version_number_at_start_of_event
        , a.day_number_at_start_of_event
        , a.lowest_level_at_start_of_event
        , a.experiments
        , a.count_days_played
        , a.game_mode_participation_indicator
        , a.game_mode_completion_indicator
        , a.days_played_game_mode
        , ifnull( b.count_rounds, 0 ) as game_mode_round_end_events
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
        castle_climb_daily a
        left join castle_climb_rounds b
          on a.event_start_date = b.event_start_date
          and a.rdg_id = b.rdg_id

      union all
      select
        timestamp(a.event_start_date) as event_start_date
        , 'hotdogContest' as game_mode
        , a.rdg_id
        , a.version_number_at_start_of_event
        , a.day_number_at_start_of_event
        , a.lowest_level_at_start_of_event
        , a.experiments
        , a.count_days_played
        , a.game_mode_participation_indicator
        , a.game_mode_completion_indicator
        , a.days_played_game_mode
        , ifnull( b.count_rounds, 0 ) as game_mode_round_end_events
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
        hot_dog_daily a
        left join hot_dog_rounds b
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

  dimension: version_number_at_start_of_event {
    type: number
    label: "Version Number"
    }
  dimension: day_number_at_start_of_event {
    type: number
    label: "Day Number"
    }

  dimension: lowest_level_at_start_of_event {
    type:number
    label: "Lowest Campaign Level"
    }

  parameter: dynamic_level_bucket_size {
    type: number
  }

  dimension: dynamic_level_bucket {
    label: "Dynamic Level Bucket"
    type:string
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.lowest_level_at_start_of_event,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as string
      )
    || ' to '
    ||
    safe_cast(
      ceiling(safe_divide(${TABLE}.lowest_level_at_start_of_event+1,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}-1
      as string
      )
    ;;
  }

  dimension: dynamic_level_bucket_order {
    label: "Dynamic Level Bucket Order"
    type:number
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.lowest_level_at_start_of_event,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as int64
      )
    ;;
  }

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
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

  measure: unique_dau_during_event {
    label: "Unique Players During Event"
    type: number
    value_format_name: decimal_0
    sql:
    sum(1)
  ;;
  }

  measure: unique_dau_participating_in_event {
    label: "Unique Players Participating in Event"
    type: number
    value_format_name: decimal_0
    sql:
      sum(${TABLE}.game_mode_participation_indicator)
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

  measure: percent_unique_dau_to_see_popup {
    label: "Average % Active Players To View Popup"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      sum( ${TABLE}.game_mode_popup_indicator )
      , sum(1)
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

  measure: percent_of_rounds_with_moves_added {
    label: "Percent of Rounds With Moves Added"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.count_rounds_with_moves_added else 0 end )
      , sum(case when ${TABLE}.game_mode_participation_indicator = 1 then ${TABLE}.game_mode_round_end_events else 0 end )
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
