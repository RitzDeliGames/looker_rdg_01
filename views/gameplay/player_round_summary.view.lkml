view: player_round_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last manual update: '2023-08-10'


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

    , lead(session_id) over (
        partition by rdg_id
        order by round_start_timestamp_utc asc
        ) as next_round_session_id

    -- lag previous win_streak as win_streak_at_round_start
    , ifnull(
        lag(win_streak) over (
          partition by rdg_id
          order by round_start_timestamp_utc asc
          ) , 0 ) as win_streak_at_round_start

  from
    -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_incremental`
    ${player_round_incremental.SQL_TABLE_NAME}
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
    , a.event_name
    , max(a.round_start_cumulative_minutes) as round_start_cumulative_minutes
    , max(a.round_end_cumulative_minutes) as round_end_cumulative_minutes
    , max(a.created_at) as created_at
    , max(a.version) as version
    , max(a.session_id) as session_id
    , max(a.next_round_session_id) as next_round_session_id
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
    , max(a.objectives) as objectives
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
    , max(a.round_count) as round_count
    , max(a.level_difficuly) as level_difficuly

    -- go fish specific fields
    , max(a.gofish_opponent_display_name) as gofish_opponent_display_name
    , max(a.gofish_opponent_moves_remaining) as gofish_opponent_moves_remaining
    , max(a.gofish_round_number) as gofish_round_number
    , max(a.gofish_player_rank) as gofish_player_rank

    -- chum chum boosts used
    , max(a.powerup_hammer) as powerup_hammer
    , max(a.powerup_rolling_pin) as powerup_rolling_pin
    , max(a.powerup_piping_bag) as powerup_piping_bag
    , max(a.powerup_shuffle) as powerup_shuffle
    , max(a.powerup_chopsticks) as powerup_chopsticks
    , max(a.powerup_skillet) as powerup_skillet
    , max(a.skill_disco) as skill_disco
    , max(a.skill_moves) as skill_moves
    , max(a.skill_drill) as skill_drill
    , max(a.total_chum_powerups_used) as total_chum_powerups_used

    -- pre game boosts
    , max( a.pregame_boost_rocket ) as pregame_boost_rocket
    , max( a.pregame_boost_bomb ) as pregame_boost_bomb
    , max( a.pregame_boost_colorball ) as pregame_boost_colorball
    , max( a.pregame_boost_extramoves ) as pregame_boost_extramoves
    , max( a.pregame_boost_total ) as pregame_boost_total

    -- techincal stats
    , max(a.used_memory_bytes) as used_memory_bytes
    , max(a.total_reserved_memory) as total_reserved_memory
    , max(a.gc_reserved_memory) as gc_reserved_memory
    , max(a.system_used_memory) as system_used_memory

    -- frame rates
    , max( a.percent_frames_below_22 ) as percent_frames_below_22
    , max( a.percent_frames_between_23_and_40 ) as percent_frames_between_23_and_40
    , max( a.percent_frames_above_40 ) as percent_frames_above_40

    -- moves master tier
    , max( a.moves_master_tier ) as moves_master_tier

    --------------------------------------------------------------------------
    -- mtx purchase dollars
    --------------------------------------------------------------------------

    , sum( ifnull(
        case
          when b.timestamp_utc < a.round_start_timestamp_utc
          then b.mtx_purchase_dollars
          else 0 end
          ,0) ) as before_round_start_mtx_purchase_dollars

    , sum( ifnull(
        case
          when b.timestamp_utc >= a.round_start_timestamp_utc
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
    -- left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_summary` b
    left join ${player_mtx_purchase_summary.SQL_TABLE_NAME} b

      on b.rdg_id = a.rdg_id
      and b.timestamp_utc > a.previous_round_end_timestamp_utc
      and b.timestamp_utc <= a.round_end_timestamp_utc

  group by
    1,2,3,4,5,6,7

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
    , a.event_name
    , max(a.round_start_cumulative_minutes) as round_start_cumulative_minutes
    , max(a.round_end_cumulative_minutes) as round_end_cumulative_minutes
    , max(a.created_at) as created_at
    , max(a.version) as version
    , max(a.session_id) as session_id
    , max(a.next_round_session_id) as next_round_session_id
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
    , max(a.objectives) as objectives
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
    , max(a.round_count) as round_count
    , max(a.level_difficuly) as level_difficuly

    -- go fish specific fields
    , max(a.gofish_opponent_display_name) as gofish_opponent_display_name
    , max(a.gofish_opponent_moves_remaining) as gofish_opponent_moves_remaining
    , max(a.gofish_round_number) as gofish_round_number
    , max(a.gofish_player_rank) as gofish_player_rank

    -- chum chum boosts used
    , max(a.powerup_hammer) as powerup_hammer
    , max(a.powerup_rolling_pin) as powerup_rolling_pin
    , max(a.powerup_piping_bag) as powerup_piping_bag
    , max(a.powerup_shuffle) as powerup_shuffle
    , max(a.powerup_chopsticks) as powerup_chopsticks
    , max(a.powerup_skillet) as powerup_skillet
    , max(a.skill_disco) as skill_disco
    , max(a.skill_moves) as skill_moves
    , max(a.skill_drill) as skill_drill
    , max(a.total_chum_powerups_used) as total_chum_powerups_used

    -- pre game boosts
    , max( a.pregame_boost_rocket ) as pregame_boost_rocket
    , max( a.pregame_boost_bomb ) as pregame_boost_bomb
    , max( a.pregame_boost_colorball ) as pregame_boost_colorball
    , max( a.pregame_boost_extramoves ) as pregame_boost_extramoves
    , max( a.pregame_boost_total ) as pregame_boost_total

    -- techincal stats
    , max(a.used_memory_bytes) as used_memory_bytes
    , max(a.total_reserved_memory) as total_reserved_memory
    , max(a.gc_reserved_memory) as gc_reserved_memory
    , max(a.system_used_memory) as system_used_memory

    -- frame rates
    , max( a.percent_frames_below_22 ) as percent_frames_below_22
    , max( a.percent_frames_between_23_and_40 ) as percent_frames_between_23_and_40
    , max( a.percent_frames_above_40 ) as percent_frames_above_40

    -- moves master tier
    , max( a.moves_master_tier ) as moves_master_tier

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
    -- left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary` c
    left join ${player_ad_view_summary.SQL_TABLE_NAME} c
      on c.rdg_id = a.rdg_id
      and c.timestamp_utc > a.previous_round_end_timestamp_utc
      and c.timestamp_utc <= a.round_end_timestamp_utc


  group by
    1,2,3,4,5,6,7

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
    , a.event_name
    , max(a.round_start_cumulative_minutes) as round_start_cumulative_minutes
    , max(a.round_end_cumulative_minutes) as round_end_cumulative_minutes
    , max(a.created_at) as created_at
    , max(a.version) as version
    , max(a.session_id) as session_id
    , max(a.next_round_session_id) as next_round_session_id
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
    , max(a.objectives) as objectives
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
    , max(a.round_count) as round_count
    , max(a.level_difficuly) as level_difficuly

    -- go fish specific fields
    , max(a.gofish_opponent_display_name) as gofish_opponent_display_name
    , max(a.gofish_opponent_moves_remaining) as gofish_opponent_moves_remaining
    , max(a.gofish_round_number) as gofish_round_number
    , max(a.gofish_player_rank) as gofish_player_rank

    -- chum chum boosts used
    , max(a.powerup_hammer) as powerup_hammer
    , max(a.powerup_rolling_pin) as powerup_rolling_pin
    , max(a.powerup_piping_bag) as powerup_piping_bag
    , max(a.powerup_shuffle) as powerup_shuffle
    , max(a.powerup_chopsticks) as powerup_chopsticks
    , max(a.powerup_skillet) as powerup_skillet
    , max(a.skill_disco) as skill_disco
    , max(a.skill_moves) as skill_moves
    , max(a.skill_drill) as skill_drill
    , max(a.total_chum_powerups_used) as total_chum_powerups_used

    -- pre game boosts
    , max( a.pregame_boost_rocket ) as pregame_boost_rocket
    , max( a.pregame_boost_bomb ) as pregame_boost_bomb
    , max( a.pregame_boost_colorball ) as pregame_boost_colorball
    , max( a.pregame_boost_extramoves ) as pregame_boost_extramoves
    , max( a.pregame_boost_total ) as pregame_boost_total

    -- techincal stats
    , max(a.used_memory_bytes) as used_memory_bytes
    , max(a.total_reserved_memory) as total_reserved_memory
    , max(a.gc_reserved_memory) as gc_reserved_memory
    , max(a.system_used_memory) as system_used_memory

    -- frame rates
    , max( a.percent_frames_below_22 ) as percent_frames_below_22
    , max( a.percent_frames_between_23_and_40 ) as percent_frames_between_23_and_40
    , max( a.percent_frames_above_40 ) as percent_frames_above_40

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

    -- moves master tier
    , max( a.moves_master_tier ) as moves_master_tier

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
    -- left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_spend_summary` d
    left join ${player_coin_spend_summary.SQL_TABLE_NAME} d
      on d.rdg_id = a.rdg_id
      and d.timestamp_utc > a.previous_round_end_timestamp_utc
      and d.timestamp_utc <= a.round_end_timestamp_utc


  group by
    1,2,3,4,5,6,7

)

-----------------------------------------------------------------------------
-- join on coin rewards
-----------------------------------------------------------------------------

, join_on_coin_rewards as (

  select
    a.rdg_id
    , a.rdg_date
    , a.game_mode
    , a.level_serial
    , a.round_start_timestamp_utc
    , a.round_end_timestamp_utc
    , a.event_name
    , max(a.round_start_cumulative_minutes) as round_start_cumulative_minutes
    , max(a.round_end_cumulative_minutes) as round_end_cumulative_minutes
    , max(a.created_at) as created_at
    , max(a.version) as version
    , max(a.session_id) as session_id
    , max(a.next_round_session_id) as next_round_session_id
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
    , max(a.objectives) as objectives
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
    , max(a.round_count) as round_count
    , max(a.level_difficuly) as level_difficuly

    -- go fish specific fields
    , max(a.gofish_opponent_display_name) as gofish_opponent_display_name
    , max(a.gofish_opponent_moves_remaining) as gofish_opponent_moves_remaining
    , max(a.gofish_round_number) as gofish_round_number
    , max(a.gofish_player_rank) as gofish_player_rank

    -- chum chum boosts used
    , max(a.powerup_hammer) as powerup_hammer
    , max(a.powerup_rolling_pin) as powerup_rolling_pin
    , max(a.powerup_piping_bag) as powerup_piping_bag
    , max(a.powerup_shuffle) as powerup_shuffle
    , max(a.powerup_chopsticks) as powerup_chopsticks
    , max(a.powerup_skillet) as powerup_skillet
    , max(a.skill_disco) as skill_disco
    , max(a.skill_moves) as skill_moves
    , max(a.skill_drill) as skill_drill
    , max(a.total_chum_powerups_used) as total_chum_powerups_used

    -- pre game boosts
    , max( a.pregame_boost_rocket ) as pregame_boost_rocket
    , max( a.pregame_boost_bomb ) as pregame_boost_bomb
    , max( a.pregame_boost_colorball ) as pregame_boost_colorball
    , max( a.pregame_boost_extramoves ) as pregame_boost_extramoves
    , max( a.pregame_boost_total ) as pregame_boost_total

    -- techincal stats
    , max(a.used_memory_bytes) as used_memory_bytes
    , max(a.total_reserved_memory) as total_reserved_memory
    , max(a.gc_reserved_memory) as gc_reserved_memory
    , max(a.system_used_memory) as system_used_memory

    -- frame rates
    , max( a.percent_frames_below_22 ) as percent_frames_below_22
    , max( a.percent_frames_between_23_and_40 ) as percent_frames_between_23_and_40
    , max( a.percent_frames_above_40 ) as percent_frames_above_40

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

    -- moves master tier
    , max( a.moves_master_tier ) as moves_master_tier

    -- Coin Spend
    , max(a.before_round_start_coin_spend) as before_round_start_coin_spend
    , max(a.in_round_coin_spend) as in_round_coin_spend
    , max(a.total_coin_spend) as total_coin_spend
    , max(a.before_round_start_count_coin_spend_events) as before_round_start_count_coin_spend_events
    , max(a.in_round_count_coin_spend_events) as in_round_count_coin_spend_events
    , max(a.total_count_coin_spend_events) as total_count_coin_spend_events

    --------------------------------------------------------------------------
    -- coin rewards
    --------------------------------------------------------------------------

    , sum( ifnull(
        case
          when d.timestamp_utc < a.round_start_timestamp_utc
          then d.reward_amount
          else 0 end
          ,0) ) as before_round_start_coin_rewards

    , sum( ifnull(
        case
          when d.timestamp_utc >= a.round_start_timestamp_utc
          then d.reward_amount
          else 0 end
          ,0) ) as in_round_coin_rewards

    , sum( ifnull(d.reward_amount,0) ) as total_coin_rewards

    --------------------------------------------------------------------------
    -- count coin reward events
    --------------------------------------------------------------------------

    , sum( ifnull(
        case
          when d.timestamp_utc < a.round_start_timestamp_utc
          then d.reward_events
          else 0 end
          ,0) ) as before_round_start_count_coin_reward_events

    , sum( ifnull(
        case
          when d.timestamp_utc >= a.round_start_timestamp_utc
          then d.reward_events
          else 0 end
          ,0) ) as in_round_count_coin_reward_events

    , sum( ifnull(d.reward_events,0) ) as total_count_coin_reward_events

  from
    join_on_coin_spend a
    -- left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_coin_spend_summary` d
    left join ${player_reward_summary.SQL_TABLE_NAME} d
      on d.rdg_id = a.rdg_id
      and d.timestamp_utc > a.previous_round_end_timestamp_utc
      and d.timestamp_utc <= a.round_end_timestamp_utc
      and d.reward_type = 'CURRENCY_03' -- coin rewards only

  group by
    1,2,3,4,5,6,7

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

    -- cumulative rounds this session
    , sum(ifnull(count_rounds,0)) over (
        partition by rdg_id, session_id
        order by round_start_timestamp_utc asc
        rows between unbounded preceding and current row
        ) cumulative_rounds_this_session

    -- total rounds this session
    , sum(ifnull(count_rounds,0)) over (
        partition by rdg_id, session_id
        order by round_start_timestamp_utc asc
        rows between unbounded preceding and unbounded following
        ) total_rounds_this_session

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

    , sum(ifnull(count_wins,0)) over (
            partition by rdg_id
            order by round_start_timestamp_utc asc
            rows between 19 preceding and current row
            ) count_wins_over_prior_20_rounds

    , sum(ifnull(count_wins,0)) over (
          partition by rdg_id
          order by round_start_timestamp_utc asc
          rows between 9 preceding and current row
          ) count_wins_over_prior_10_rounds

    , sum(ifnull(count_wins,0)) over (
            partition by rdg_id, game_mode
            order by round_start_timestamp_utc asc
            rows between 19 preceding and current row
            ) count_wins_over_prior_20_rounds_by_game_mode

    , sum(ifnull(count_wins,0)) over (
          partition by rdg_id, game_mode
          order by round_start_timestamp_utc asc
          rows between 9 preceding and current row
          ) count_wins_over_prior_10_rounds_by_game_mode


    -------------------------------------------------------------------------------------------
    -- Lag Wins over last 20 rounds
    ---- for Consecutive Losses
    ---- and for discounting win rate
    -------------------------------------------------------------------------------------------

    , 0.90 as consecutive_loss_rate_discount
    , count_losses as lag_losses_00
    , lag(count_losses,1) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_01
    , lag(count_losses,2) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_02
    , lag(count_losses,3) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_03
    , lag(count_losses,4) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_04
    , lag(count_losses,5) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_05
    , lag(count_losses,6) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_06
    , lag(count_losses,7) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_07
    , lag(count_losses,8) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_08
    , lag(count_losses,9) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_09
    , lag(count_losses,10) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_10
    , lag(count_losses,11) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_11
    , lag(count_losses,12) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_12
    , lag(count_losses,13) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_13
    , lag(count_losses,14) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_14
    , lag(count_losses,15) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_15
    , lag(count_losses,16) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_16
    , lag(count_losses,17) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_17
    , lag(count_losses,18) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_18
    , lag(count_losses,19) over (partition by rdg_id, game_mode order by round_start_timestamp_utc asc) as lag_losses_19

  from
    join_on_coin_rewards

)

-----------------------------------------------------------------------------
-- add churn info
-----------------------------------------------------------------------------

select
  *

  -----------------------------------------------------------------------------
  -- count losses over last 20 games
  -----------------------------------------------------------------------------

     , ifnull(lag_losses_00,0)
      + ifnull(lag_losses_01,0)
      + ifnull(lag_losses_02,0)
      + ifnull(lag_losses_03,0)
      + ifnull(lag_losses_04,0)
      + ifnull(lag_losses_05,0)
      + ifnull(lag_losses_06,0)
      + ifnull(lag_losses_07,0)
      + ifnull(lag_losses_08,0)
      + ifnull(lag_losses_09,0)
      + ifnull(lag_losses_10,0)
      + ifnull(lag_losses_11,0)
      + ifnull(lag_losses_12,0)
      + ifnull(lag_losses_13,0)
      + ifnull(lag_losses_14,0)
      + ifnull(lag_losses_15,0)
      + ifnull(lag_losses_16,0)
      + ifnull(lag_losses_17,0)
      + ifnull(lag_losses_18,0)
      + ifnull(lag_losses_19,0)

     as count_losse_over_last_20_rounds_by_game_mode

  -----------------------------------------------------------------------------
  -- Consecutive losses
  -----------------------------------------------------------------------------

  , case
      when ifnull(lag_losses_00,1) = 0 then 0
      when ifnull(lag_losses_01,1) = 0 then 1
      when ifnull(lag_losses_02,1) = 0 then 2
      when ifnull(lag_losses_03,1) = 0 then 3
      when ifnull(lag_losses_04,1) = 0 then 4
      when ifnull(lag_losses_05,1) = 0 then 5
      when ifnull(lag_losses_06,1) = 0 then 6
      when ifnull(lag_losses_07,1) = 0 then 7
      when ifnull(lag_losses_08,1) = 0 then 8
      when ifnull(lag_losses_09,1) = 0 then 9
      when ifnull(lag_losses_10,1) = 0 then 10
      when ifnull(lag_losses_11,1) = 0 then 11
      when ifnull(lag_losses_12,1) = 0 then 12
      when ifnull(lag_losses_13,1) = 0 then 13
      when ifnull(lag_losses_14,1) = 0 then 14
      when ifnull(lag_losses_15,1) = 0 then 15
      when ifnull(lag_losses_16,1) = 0 then 16
      when ifnull(lag_losses_17,1) = 0 then 17
      when ifnull(lag_losses_18,1) = 0 then 18
      when ifnull(lag_losses_19,1) = 0 then 19
      else 20
      end as consecutive_losses_20


  -----------------------------------------------------------------------------
  -- Discounted Win Rate
  -----------------------------------------------------------------------------

  , round(
      power(consecutive_loss_rate_discount,0)*(1-consecutive_loss_rate_discount) * lag_losses_00
      + power(consecutive_loss_rate_discount,1)*(1-consecutive_loss_rate_discount) * lag_losses_01
      + power(consecutive_loss_rate_discount,2)*(1-consecutive_loss_rate_discount) * lag_losses_02
      + power(consecutive_loss_rate_discount,3)*(1-consecutive_loss_rate_discount) * lag_losses_03
      + power(consecutive_loss_rate_discount,4)*(1-consecutive_loss_rate_discount) * lag_losses_04
      + power(consecutive_loss_rate_discount,5)*(1-consecutive_loss_rate_discount) * lag_losses_05
      + power(consecutive_loss_rate_discount,6)*(1-consecutive_loss_rate_discount) * lag_losses_06
      + power(consecutive_loss_rate_discount,7)*(1-consecutive_loss_rate_discount) * lag_losses_07
      + power(consecutive_loss_rate_discount,8)*(1-consecutive_loss_rate_discount) * lag_losses_08
      + power(consecutive_loss_rate_discount,9)*(1-consecutive_loss_rate_discount) * lag_losses_09
      + power(consecutive_loss_rate_discount,10)*(1-consecutive_loss_rate_discount) * lag_losses_10
      + power(consecutive_loss_rate_discount,11)*(1-consecutive_loss_rate_discount) * lag_losses_11
      + power(consecutive_loss_rate_discount,12)*(1-consecutive_loss_rate_discount) * lag_losses_12
      + power(consecutive_loss_rate_discount,13)*(1-consecutive_loss_rate_discount) * lag_losses_13
      + power(consecutive_loss_rate_discount,14)*(1-consecutive_loss_rate_discount) * lag_losses_14
      + power(consecutive_loss_rate_discount,15)*(1-consecutive_loss_rate_discount) * lag_losses_15
      + power(consecutive_loss_rate_discount,16)*(1-consecutive_loss_rate_discount) * lag_losses_16
      + power(consecutive_loss_rate_discount,17)*(1-consecutive_loss_rate_discount) * lag_losses_17
      + power(consecutive_loss_rate_discount,18)*(1-consecutive_loss_rate_discount) * lag_losses_18
      + power(consecutive_loss_rate_discount,19)*(1-consecutive_loss_rate_discount) * lag_losses_19
    , 2 )

    as discounted_lose_win_ratio


  -----------------------------------------------------------------------------
  -- Churn Stuff
  -----------------------------------------------------------------------------

  , case when next_round_session_id <> session_id then 1 else 0 end as last_round_in_session_indicator
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
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -4 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (4) + 2 )*( -10 ) minute)) ;;
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
## Parameters
################################################################

  parameter: dynamic_level_bucket_size {
    group_label: "Level Buckets"
    type: number
  }

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
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

  # dates
  dimension_group: round_start_timestamp_utc {
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.round_start_timestamp_utc ;;
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
  dimension: round_start_cumulative_minutes {type:number}
  dimension: round_end_cumulative_minutes {type:number}
  dimension: level_serial {
    group_label: "Level Fields"
    label: "Current Level"
    type:number
    }
  dimension: version {type:string}
  dimension: version_number {
    type:number
    sql:
      safe_cast(${TABLE}.version as numeric)
      ;;
  }
  dimension: cumulative_rounds_this_session {type:number}
  dimension: total_rounds_this_session {type:number}
  dimension: event_name {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak_at_round_start {type:number}
  dimension: win_streak_at_round_end {type:number}
  dimension: count_rounds {type:number}
  dimension: round_length_minutes {
    type:number
    value_format_name: decimal_1
    sql: round(${TABLE}.round_length_minutes,1) ;;
    }
  dimension: count_wins {type:number}
  dimension: count_losses {type:number}
  dimension: moves_remaining {type:number}
  dimension: count_rounds_with_moves_added {type:number}
  dimension: coins_earned {type:number}
  dimension: objective_count_total {type:number}
  dimension: objective_progress {type:number}
  dimension: objectives {type: string}
  dimension: moves {type:number}
  dimension: level_id {
    group_label: "Level Fields"
    type:string
    }
  dimension: last_level_serial {
    group_label: "Level Fields"
    type:number
    }
  dimension: level_difficulty {
    group_label: "Level Fields"
    type:string
    sql: ${TABLE}.level_difficuly ;;
  }
  dimension: round_count {type:number}

  dimension: primary_team_slot {type:string}
  dimension: primary_team_slot_skill {type:string}
  dimension: primary_team_slot_level {type:number}
  dimension: proximity_to_completion {type:number}
  dimension: coins_balance {type:number}
  dimension: lives_balance {type:number}
  dimension: stars_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: 7_day_week_number {
    type: number
    group_label: "Grouped Day Numbers"
    label: "7 Day Week Number"
    value_format_name: decimal_0
    sql: safe_cast(ceiling(${TABLE}.day_number/7) as int64) ;;
  }

  dimension: before_round_start_mtx_purchase_dollars {
    label: "Before Round Start IAP Dollars"
    type:number
    }
  dimension: in_round_mtx_purchase_dollars {
    label: "In Round IAP Dollars"
    type:number
    }

  dimension: total_mtx_purchase_dollars {
    label: "Total IAP Dollars"
    type:number
    }

  dimension: before_round_start_count_mtx_purchases {
    label: "Before Round Start Count of IAPs"
    type:number
    }

  dimension: in_round_count_mtx_purchases {
    label: "In Round Count of IAPs"
    type:number
    }

  dimension: total_count_mtx_purchases {
    label: "Total Count of IAPs"
    type:number
    }

  dimension: before_round_start_ad_view_dollars {
    label: "Before Round Start IAA Dollars"
    type:number
    }

  dimension: in_round_ad_view_dollars {
    label: "In Round IAA Dollars"
    type:number
    }

  dimension: total_ad_view_dollars {
    label: "Total IAA Dollars"
    type:number
    }

  dimension: before_round_start_count_ad_views {
    label: "Before Round Start Count of IAA Views"
    type:number
    }

  dimension: in_round_count_ad_views {
    label: "In Round Count of IAA Views"
    type:number
    }

  dimension: total_count_ad_views {
    label: "Total Count of IAA Views"
    type:number
    }

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

  dimension: before_round_start_coin_rewards {type:number}
  dimension: in_round_coin_rewards {type:number}
  dimension: total_coin_rewards {type:number}
  dimension: before_round_start_count_coin_reward_events {type:number}
  dimension: in_round_count_coin_reward_events {type:number}
  dimension: total_count_coin_reward_events {type:number}


  dimension: round_end_cumulative_mtx_purchase_dollars {
    label: "Round End LTV - IAP"
    type:number
    }

  dimension: round_end_cumulative_count_mtx_purchases {
    label: "Round End Cumulative Count of IAPs"
    type:number
    }

  dimension: round_end_cumulative_ad_view_dollars {
    label: "Round End LTV - IAA"
    type:number
    }

  dimension: round_end_cumulative_count_ad_views {
    label: "Round End Cumulative Count of IAA Views"
    type:number
    }

  dimension: round_end_cumulative_coin_spend {type:number}
  dimension: round_end_cumulative_count_coin_spend_events {type:number}
  dimension: round_end_cumulative_combined_dollars {type:number}
  dimension: churn_indicator {type:number}
  dimension: churn_rdg_id {type:string}
  dimension: cumulative_round_by_level_game_mode_at_churn {type:number}

  dimension: cumulative_mtx_purchase_dollars_at_churn {
    label: "LTV - IAP at Churn"
    type:number
    }

  dimension: cumulative_count_mtx_purchases_at_churn {
    label: "Cumulative Count of IAPs at Churn"
    type:number
    }

  dimension: cumulative_ad_view_dollars_at_churn {
    label: "LTV - IAA at Churn"
    type:number
    }

  dimension: cumulative_count_ad_views_at_churn {
    label: "Cumulative Count of IAA Views at Churn"
    type:number
    }

  dimension: cumulative_coin_spend_at_churn {type:number}
  dimension: cumulative_count_coin_spend_events_at_churn {type:number}
  dimension: cumulative_combined_dollars_at_churn {type:number}

  ## Dynamic Difficulty fields
  dimension: count_wins_over_prior_20_rounds {group_label: "Dynamic Difficulty Tuning" type:number}
  dimension: count_wins_over_prior_10_rounds {group_label: "Dynamic Difficulty Tuning" type:number}
  dimension: count_wins_over_prior_20_rounds_by_game_mode {group_label: "Dynamic Difficulty Tuning" type:number}
  dimension: count_wins_over_prior_10_rounds_by_game_mode {group_label: "Dynamic Difficulty Tuning" type:number}
  dimension: discounted_lose_win_ratio {group_label: "Dynamic Difficulty Tuning" type: number}
  dimension: consecutive_losses_20 {group_label: "Dynamic Difficulty Tuning" type: number}
  dimension: count_losse_over_last_20_rounds_by_game_mode {
    group_label: "Dynamic Difficulty Tuning"
    label: "Count Losses Over Last 20 Rounds By Game Mode"
    type: number}

  dimension: round_attempt_number_at_churn_tiers {
    type:tier
    tiers: [1,2,5]
    style: integer
    sql: ${TABLE}.cumulative_round_by_level_game_mode_at_churn;;
    }

  ## go fish specific fields
  dimension: gofish_opponent_display_name {type:string}
  dimension: gofish_opponent_moves_remaining {type:number}
  dimension: gofish_round_number {type:number}
  dimension: gofish_player_rank {type:number}

  ## chum chum boosts used
  dimension: powerup_hammer { group_label: "Chum Chum Skills Used" type:number}
  dimension: powerup_rolling_pin { group_label: "Chum Chum Skills Used" type:number}
  dimension: powerup_piping_bag { group_label: "Chum Chum Skills Used" type:number}
  dimension: powerup_shuffle { group_label: "Chum Chum Skills Used" type:number}
  dimension: powerup_chopsticks { group_label: "Chum Chum Skills Used" type:number}
  dimension: powerup_skillet { group_label: "Chum Chum Skills Used" type:number}
  dimension: total_chum_powerups_used { group_label: "Chum Chum Skills Used" type:number}

  ## Moves Master Tier
  dimension: moves_master_tier {
    label: "Moves Master Tier"
    type: number
    value_format_name: decimal_0
    sql: ${TABLE}.moves_master_tier ;;
  }

  ## Puzzle Piece Mapping
  dimension: puzzle_piece_number_mapping_by_date {
    label: "Puzzle Piece # Mapping by Date"
    type: string
    sql: @{puzzle_piece_number_mapping_by_date} ;;
  }

################################################################
## Level Buckets
################################################################

  dimension: level_bucket {
    group_label: "Level Buckets"
    label: "Level Bucket"
    type:tier
    tiers: [0,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,850,900,950,1000,1050]
    style: integer
    sql: ${TABLE}.level_serial;;
  }

  dimension: dynamic_level_bucket {
    group_label: "Level Buckets"
    label: "Dynamic Level Bucket"
    type:string
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as string
      )
    || ' to '
    ||
    safe_cast(
      ceiling(safe_divide(${TABLE}.level_serial+1,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}-1
      as string
      )
    ;;
  }

  dimension: dynamic_level_bucket_order {
    group_label: "Level Buckets"
    label: "Dynamic Level Bucket Order"
    type:number
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as int64
      )
    ;;
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
## Ad hoc - Level Bucket Churn Analysis
################################################################

  dimension: adhoc_level_buckets_for_churn_analysis {
    group_label: "Ad Hoc Churn Analysis"
    label: "Adhoc Level Buckets - 50th Percentile"
    type:string
    sql:
     @{adhoc_level_buckets_for_churn_analysis_50th_pct}
    ;;
  }

  measure: adhoc_target_churn_by_level_buckets_for_churn_analysis {
    group_label: "Ad Hoc Churn Analysis"
    label: "Adhoc Churn Targets - 50th Percentile"
    type:max
    sql:
     @{adhoc_target_churn_by_level_buckets_for_churn_analysis_50th_pct}
    ;;
    value_format_name: percent_1
    }

  dimension: adhoc_level_buckets_for_churn_analysis_75th_pct {
    group_label: "Ad Hoc Churn Analysis"
    label: "Adhoc Level Buckets - 75th Percentile"
    type:string
    sql:
     @{adhoc_level_buckets_for_churn_analysis_75th_pct}
    ;;
  }




  measure: adhoc_target_churn_by_level_buckets_for_churn_analysis_75th_pct {
    group_label: "Ad Hoc Churn Analysis"
    label: "Adhoc Churn Targets - 75th Percentile"
    type:max
    sql:
     @{adhoc_target_churn_by_level_buckets_for_churn_analysis_75th_pct}
    ;;
    value_format_name: percent_1
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

  measure: count_7_day_churn_players {
    group_label: "Calculated Fields"
    type: number
    sql:
      sum(
          case
            when date_diff(date(${TABLE}.next_round_start_timestamp_utc),date(${TABLE}.rdg_date),DAY) >= 7
            then 1
            when ${TABLE}.next_round_start_timestamp_utc is null
            then 1
            else 0
            end
        )
    ;;
    value_format_name: decimal_1

  }

  measure: 7_day_churn_rate {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct
          case
            when date_diff(date(${TABLE}.next_round_start_timestamp_utc),date(${TABLE}.rdg_date),DAY) >= 7
            then ${TABLE}.rdg_id
            when ${TABLE}.next_round_start_timestamp_utc is null
            then ${TABLE}.rdg_id
            else null
            end
        )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_1

  }

  measure: 7_day_churn_rate_per_round {
    group_label: "Calculated Fields"
    label: "7 Day Churn Rate Per Round"
    type: number
    sql:
      safe_divide(
        sum(
          case
            when date_diff(date(${TABLE}.next_round_start_timestamp_utc),date(${TABLE}.rdg_date),DAY) >= 7
            then 1
            when ${TABLE}.next_round_start_timestamp_utc is null
            then 1
            else 0
            end
        )
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: percent_1

  }

  measure: coin_spend_per_7_day_churn_round {
    group_label: "Calculated Fields"
    label: "Coin Spend Per 7 Day Churn Round"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_coin_spend)
        ,
        sum(
          case
            when date_diff(date(${TABLE}.next_round_start_timestamp_utc),date(${TABLE}.rdg_date),DAY) >= 7
            then 1
            when ${TABLE}.next_round_start_timestamp_utc is null
            then 1
            else 0
            end
        )
      )
    ;;
    value_format_name: decimal_0

  }


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
    value_format_name: decimal_2

  }

  measure: mean_win_rate {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_wins)
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: percent_0

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





  measure: moves_remaing_on_win_10 {
    group_label: "Moves Remaining On Win"
    type: percentile
    percentile: 10
    sql:
      case
          when ${TABLE}.count_wins = 1
          then ${TABLE}.moves_remaining
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: moves_remaing_on_win_25 {
    group_label: "Moves Remaining On Win"
    type: percentile
    percentile: 25
    sql:
      case
          when ${TABLE}.count_wins = 1
          then ${TABLE}.moves_remaining
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: median_moves_remaing_on_win {
    group_label: "Moves Remaining On Win"
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

  measure: moves_remaing_on_win_75 {
    group_label: "Moves Remaining On Win"
    type: percentile
    percentile: 75
    sql:
      case
          when ${TABLE}.count_wins = 1
          then ${TABLE}.moves_remaining
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: moves_remaing_on_win_95 {
    group_label: "Moves Remaining On Win"
    type: percentile
    percentile: 95
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


  measure: attempt_number_at_win_10 {
    group_label: "Attempt Number At Win"
    type: percentile
    percentile: 10
    sql:
      case
          when ${TABLE}.count_wins = 1
          then ${TABLE}.cumulative_round_by_level_game_mode
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: attempt_number_at_win_25 {
    group_label: "Attempt Number At Win"
    type: percentile
    percentile: 25
    sql:
      case
          when ${TABLE}.count_wins = 1
          then ${TABLE}.cumulative_round_by_level_game_mode
          else null
        end
    ;;
    value_format_name: decimal_0
  }
  measure: median_attempt_number_at_win {
    group_label: "Attempt Number At Win"
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

  measure: attempt_number_at_win_75 {
    group_label: "Attempt Number At Win"
    type: percentile
    percentile: 75
    sql:
      case
          when ${TABLE}.count_wins = 1
          then ${TABLE}.cumulative_round_by_level_game_mode
          else null
        end
    ;;
    value_format_name: decimal_0
  }

  measure: attempt_number_at_win_95 {
    group_label: "Attempt Number At Win"
    type: percentile
    percentile: 95
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
    group_label: "Attempt Number At Churn"
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
    label: "IAP Dollars Per Player"
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
    label: "IAA Dollars Per Player"
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

  measure: coin_spend_per_round {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_coin_spend)
        ,
        sum(${TABLE}.count_rounds)
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

  measure: level_efficiency_estimate_coin_spend_per_round {
    group_label: "Level Efficiency Estimates"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_coin_spend) - sum(${TABLE}.cumulative_coin_spend_at_churn)
        ,
        sum(${TABLE}.count_rounds)
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
    value_format_name: percent_1
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
    value_format_name: percent_1
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
    value_format_name: percent_1
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
    value_format_name: percent_1
  }

  measure: churn_rate_per_round {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.churn_indicator)
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: percent_1
  }

  measure: last_round_in_session_rate_per_round {
    label: "Last Round In Session Rate Per Round"
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.last_round_in_session_indicator)
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: percent_1
  }

########################################33
## Chum Skills used percentiles
########################################33

  measure: total_chum_powerups_used_10 {
    group_label: "Chum Chum Skills Used"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.total_chum_powerups_used;;
    value_format_name: decimal_0
  }

  measure: total_chum_powerups_used_25 {
    group_label: "Chum Chum Skills Used"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.total_chum_powerups_used;;
    value_format_name: decimal_0
  }

  measure: total_chum_powerups_used_50 {
    group_label: "Chum Chum Skills Used"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.total_chum_powerups_used;;
    value_format_name: decimal_0
  }

  measure: total_chum_powerups_used_75 {
    group_label: "Chum Chum Skills Used"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.total_chum_powerups_used;;
    value_format_name: decimal_0
  }

  measure: total_chum_powerups_used_95 {
    group_label: "Chum Chum Skills Used"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.total_chum_powerups_used;;
    value_format_name: decimal_0
  }

########################################33
## Round Time in Minutes
########################################33

  measure: round_length_in_minutes_mean {
    group_label: "Round Length in Minutes"
    label: "Mean"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.round_length_minutes)
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: decimal_1

  }

  measure: round_length_in_minutes_10 {
    group_label: "Round Length in Minutes"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_length_minutes;;
    value_format_name: decimal_1
  }

  measure: round_length_in_minutes_25 {
    group_label: "Round Length in Minutes"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_length_minutes;;
    value_format_name: decimal_1
  }

  measure: median_round_length_in_minutes {
    group_label: "Round Length in Minutes"
    label: "Median"
    type: percentile
    percentile: 50
    sql:
      ${TABLE}.round_length_minutes
      ;;
    value_format_name: decimal_1
  }

  measure: round_length_in_minutes_75 {
    group_label: "Round Length in Minutes"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_length_minutes;;
    value_format_name: decimal_1
  }

  measure: round_length_in_minutes_95 {
    group_label: "Round Length in Minutes"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_length_minutes;;
    value_format_name: decimal_1
  }

########################################33
## Used Memory Bytes
########################################33

  dimension: used_memory_bytes {type:number}

  measure: used_memory_bytes_10 {
    group_label: "Used Memory Bytes"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.used_memory_bytes;;
    value_format_name: decimal_0
  }

  measure: used_memory_bytes_25 {
    group_label: "Used Memory Bytes"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.used_memory_bytes;;
    value_format_name: decimal_0
  }

  measure: used_memory_bytes_50 {
    group_label: "Used Memory Bytes"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.used_memory_bytes;;
    value_format_name: decimal_0
  }

  measure: used_memory_bytes_75 {
    group_label: "Used Memory Bytes"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.used_memory_bytes;;
    value_format_name: decimal_0
  }

  measure: used_memory_bytes_95 {
    group_label: "Used Memory Bytes"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.used_memory_bytes;;
    value_format_name: decimal_0
  }

########################################33
## Total Reserved Memory
########################################33

  dimension: total_reserved_memory {type:number}

  measure: total_reserved_memory_10 {
    group_label: "Total Reserved Memory"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.total_reserved_memory;;
    value_format_name: decimal_0
  }

  measure: total_reserved_memory_25 {
    group_label: "Total Reserved Memory"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.total_reserved_memory;;
    value_format_name: decimal_0
  }

  measure: total_reserved_memory_50 {
    group_label: "Total Reserved Memory"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.total_reserved_memory;;
    value_format_name: decimal_0
  }

  measure: total_reserved_memory_75 {
    group_label: "Total Reserved Memory"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.total_reserved_memory;;
    value_format_name: decimal_0
  }

  measure: total_reserved_memory_95 {
    group_label: "Total Reserved Memory"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.total_reserved_memory;;
    value_format_name: decimal_0
  }

########################################33
## GC Reserved Memory
########################################33

  dimension: gc_reserved_memory {type:number}

  measure: gc_reserved_memory_10 {
    group_label: "GC Reserved Memory"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.gc_reserved_memory;;
    value_format_name: decimal_0
  }

  measure: gc_reserved_memory_25 {
    group_label: "GC Reserved Memory"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.gc_reserved_memory;;
    value_format_name: decimal_0
  }

  measure: gc_reserved_memory_50 {
    group_label: "GC Reserved Memory"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.gc_reserved_memory;;
    value_format_name: decimal_0
  }

  measure: gc_reserved_memory_75 {
    group_label: "GC Reserved Memory"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.gc_reserved_memory;;
    value_format_name: decimal_0
  }

  measure: gc_reserved_memory_95 {
    group_label: "GC Reserved Memory"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.gc_reserved_memory;;
    value_format_name: decimal_0
  }

########################################33
## System Used Memory
########################################33

  dimension: system_used_memory {type:number}

  measure: system_used_memory_10 {
    group_label: "System Used Memory"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.system_used_memory;;
    value_format_name: decimal_0
  }

  measure: system_used_memory_25 {
    group_label: "System Used Memory"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.system_used_memory;;
    value_format_name: decimal_0
  }

  measure: system_used_memory_50 {
    group_label: "System Used Memory"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.system_used_memory;;
    value_format_name: decimal_0
  }

  measure: system_used_memory_75 {
    group_label: "System Used Memory"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.system_used_memory;;
    value_format_name: decimal_0
  }

  measure: system_used_memory_95 {
    group_label: "System Used Memory"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.system_used_memory;;
    value_format_name: decimal_0
  }


########################################33
## Rounds to Reach Loss Screen
########################################33

  dimension: count_rounds_to_reach_loss_screen {
    type:number
    sql:
      case
        when ${TABLE}.count_losses = 1 or ${TABLE}.count_rounds_with_moves_added = 1
        then 1
        else 0
        end
      ;;
    }

################################################################
## Frame Rates
################################################################

  dimension: percent_frames_below_22 {
    group_label: "Frame Rate Distribution"
    type: number
    value_format_name: percent_1
  }
  dimension: percent_frames_between_23_and_40 {
    group_label: "Frame Rate Distribution"
    type: number
    value_format_name: percent_1
  }
  dimension: percent_frames_above_40 {
    group_label: "Frame Rate Distribution"
    type: number
    value_format_name: percent_1
  }

  measure: percent_of_events_with_frames_below_22 {
    label: "Percent Frames Below 22"
    group_label: "Frame Rate Distribution"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum( ${TABLE}.percent_frames_below_22 )
        ,
        ( sum( ${TABLE}.percent_frames_below_22 )
          + sum( ${TABLE}.percent_frames_between_23_and_40 )
          + sum( ${TABLE}.percent_frames_above_40 )
          )
      );;
  }
  measure: percent_of_events_with_frames_between_23_and_40 {
    label: "Percent Frames Between 23 and 40"
    group_label: "Frame Rate Distribution"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum( ${TABLE}.percent_frames_between_23_and_40 )
        ,
        ( sum( ${TABLE}.percent_frames_below_22 )
          + sum( ${TABLE}.percent_frames_between_23_and_40 )
          + sum( ${TABLE}.percent_frames_above_40 )
          )
      );;
  }
  measure: percent_of_events_with_frames_above_40 {
    label: "Percent Frames Above 40"
    group_label: "Frame Rate Distribution"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum( ${TABLE}.percent_frames_above_40 )
        ,
        ( sum( ${TABLE}.percent_frames_below_22 )
          + sum( ${TABLE}.percent_frames_between_23_and_40 )
          + sum( ${TABLE}.percent_frames_above_40 )
          )
      );;
  }

 measure: estimate_moves_collected_in_moves_master {
  label: "Estimate Moves Master Moves Collected"
  type: number
  value_format_name: decimal_0
  sql:
    sum(
      case
        when ${TABLE}.game_mode = 'movesMaster'
        and ${TABLE}.count_wins = 1
        then ${TABLE}.moves_remaining *
          case
            when ${TABLE}.in_round_count_ad_views > 0
            then 2
            else 1
            end
        else 0
        end
      )
  ;;
 }

######################################################################################
## Pre Game Boosts
######################################################################################

  measure: sum_pregame_boost_rocket {
    group_label: "Pre-Game Boosts"
    label: "Total Rockets"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_rocket) ;;
  }

  measure: pregame_boost_rocket_per_round {
    group_label: "Pre-Game Boosts"
    label: "Total Rockets Per Round"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_rocket)
        , sum(${TABLE}.count_rounds)
      ) ;;
  }

  measure: sum_pregame_boost_bomb {
    group_label: "Pre-Game Boosts"
    label: "Total Bombs"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_bomb) ;;
  }

  measure: pregame_boost_bomb_per_round {
    group_label: "Pre-Game Boosts"
    label: "Total Bombs Per Round"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_bomb)
        , sum(${TABLE}.count_rounds)
      ) ;;
  }

  measure: sum_pregame_boost_colorball {
    group_label: "Pre-Game Boosts"
    label: "Total Colorballs"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_colorball) ;;
  }

  measure: pregame_boost_colorball_per_round {
    group_label: "Pre-Game Boosts"
    label: "Total Colorballs Per Round"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_colorball)
        , sum(${TABLE}.count_rounds)
      ) ;;
  }

  measure: sum_pregame_boost_extramoves {
    group_label: "Pre-Game Boosts"
    label: "Total ExtraMoves"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_extramoves) ;;
  }

  measure: pregame_boost_extramoves_per_round {
    group_label: "Pre-Game Boosts"
    label: "Total ExtraMoves Per Round"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_extramoves)
        , sum(${TABLE}.count_rounds)
      ) ;;
  }

  measure: sum_pregame_boost_total {
    group_label: "Pre-Game Boosts"
    label: "Total Boosts"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_total) ;;
  }

  measure: pregame_boost_total_per_round {
    group_label: "Pre-Game Boosts"
    label: "Total Boosts Per Round"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_total)
        , sum(${TABLE}.count_rounds)
      ) ;;
  }


}
