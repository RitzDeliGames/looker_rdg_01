view: player_daily_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-12-03'

-- create or replace table `tal_scratch.player_daily_summary_test` as

with

-----------------------------------------------------------------------
-- ads by date
-----------------------------------------------------------------------

ads_by_date as (
    select
        rdg_id
        , rdg_date
        , sum( count_ad_views ) as ad_views
        , sum( ad_view_dollars ) as ad_view_dollars

        , sum( case when ad_placement = 'Daily Reward' then count_ad_views else 0 end ) as ad_views_daily_rewards
        , sum( case when ad_placement = 'Moves Master' then count_ad_views else 0 end ) as ad_views_moves_master
        , sum( case when ad_placement = 'Pizza' then count_ad_views else 0 end ) as ad_views_pizza
        , sum( case when ad_placement = 'Lucky Dice' then count_ad_views else 0 end ) as ad_views_lucky_dice
        , sum( case when ad_placement = 'Ask For Help' then count_ad_views else 0 end ) as ad_views_ask_for_help
        , sum( case when ad_placement = 'Battle Pass' then count_ad_views else 0 end ) as ad_views_battle_pass
        , sum( case when ad_placement = 'Puzzles' then count_ad_views else 0 end ) as ad_views_puzzles
        , sum( case when ad_placement = 'Go Fish' then count_ad_views else 0 end ) as ad_views_go_fish
        , sum( case when ad_placement = 'Rocket' then count_ad_views else 0 end ) as ad_views_rocket
        , sum( case when ad_placement = 'Lives' then count_ad_views else 0 end ) as ad_views_lives
        , sum( case when ad_placement = 'Magnifiers' then count_ad_views else 0 end ) as ad_views_magnifiers
        , sum( case when ad_placement = 'Treasure Trove' then count_ad_views else 0 end ) as ad_views_treasure_trove
        , sum( case when ad_placement like '%Castle Climb%' then count_ad_views else 0 end ) as ad_views_castle_climb
        , sum( case when ad_placement = 'Gem Quest' then count_ad_views else 0 end ) as ad_views_gem_quest
        , sum( case when ad_placement = 'Startup Interstitial' then count_ad_views else 0 end ) as ad_views_startup_interstitial
        , sum( case when ad_placement = 'Ad IAM' then count_ad_views else 0 end ) as ad_views_ad_iam
        , sum( case when ad_format_mapped != 'Banner' then count_ad_views else 0 end ) as ad_views_non_banner

        , sum( case when ad_placement = 'Daily Reward' then ad_view_dollars else 0 end ) as ad_dollars_daily_rewards
        , sum( case when ad_placement = 'Moves Master' then ad_view_dollars else 0 end ) as ad_dollars_moves_master
        , sum( case when ad_placement = 'Pizza' then ad_view_dollars else 0 end ) as ad_dollars_pizza
        , sum( case when ad_placement = 'Lucky Dice' then ad_view_dollars else 0 end ) as ad_dollars_lucky_dice
        , sum( case when ad_placement = 'Ask For Help' then ad_view_dollars else 0 end ) as ad_dollars_ask_for_help
        , sum( case when ad_placement = 'Battle Pass' then ad_view_dollars else 0 end ) as ad_dollars_battle_pass
        , sum( case when ad_placement = 'Puzzles' then ad_view_dollars else 0 end ) as ad_dollars_puzzles
        , sum( case when ad_placement = 'Go Fish' then ad_view_dollars else 0 end ) as ad_dollars_go_fish
        , sum( case when ad_placement = 'Rocket' then ad_view_dollars else 0 end ) as ad_dollars_rocket
        , sum( case when ad_placement = 'Lives' then ad_view_dollars else 0 end ) as ad_dollars_lives
        , sum( case when ad_placement = 'Magnifiers' then ad_view_dollars else 0 end ) as ad_dollars_magnifiers
        , sum( case when ad_placement = 'Treasure Trove' then ad_view_dollars else 0 end ) as ad_dollars_treasure_trove
        , sum( case when ad_placement like '%Castle Climb%' then ad_view_dollars else 0 end ) as ad_dollars_castle_climb
        , sum( case when ad_placement = 'Gem Quest' then ad_view_dollars else 0 end ) as ad_dollars_gem_quest
        , sum( case when ad_placement = 'Startup Interstitial' then ad_view_dollars else 0 end ) as ad_dollars_startup_interstitial
        , sum( case when ad_placement = 'Ad IAM' then ad_view_dollars else 0 end ) as ad_dollars_ad_iam
        , sum( case when ad_format_mapped != 'Banner' then ad_view_dollars else 0 end ) as ad_dollars_non_banner


    from
        -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary
        ${player_ad_view_summary.SQL_TABLE_NAME}

    group by
        1,2
)

-----------------------------------------------------------------------
-- popups and iams by date
-----------------------------------------------------------------------

, popups_and_iams_by_date as (
    select
        rdg_id
        , rdg_date
        , sum( case when iam_type = 'Popup' and iam_group = 'BattlePass' then count_iam_messages else 0 end ) as popup_battlepass
        , sum( case when iam_type = 'IAM' and iam_group = 'CE' then count_iam_messages else 0 end ) as iam_ce
        , sum( case when iam_type = 'Popup' and iam_group = 'CastleClimb' then count_iam_messages else 0 end ) as popup_castleclimb
        , sum( case when iam_type = 'IAM' and iam_group = 'Chameleon' then count_iam_messages else 0 end ) as iam_chameleon
        , sum( case when iam_type = 'Popup' and iam_group = 'DailyReward' then count_iam_messages else 0 end ) as popup_dailyreward
        , sum( case when iam_type = 'Popup' and iam_group = 'DonutSprint' then count_iam_messages else 0 end ) as popup_donutsprint
        , sum( case when iam_type = 'Popup' and iam_group = 'FlourFrenzy' then count_iam_messages else 0 end ) as popup_flourfrenzy
        , sum( case when iam_type = 'Popup' and iam_group = 'FoodTruck' then count_iam_messages else 0 end ) as popup_foodtruck
        , sum( case when iam_type = 'Popup' and iam_group = 'GemQuest' then count_iam_messages else 0 end ) as popup_gemquest
        , sum( case when iam_type = 'IAM' and iam_group = 'Generic' then count_iam_messages else 0 end ) as iam_generic
        , sum( case when iam_type = 'Popup' and iam_group = 'GoFish' then count_iam_messages else 0 end ) as popup_gofish
        , sum( case when iam_type = 'Popup' and iam_group = 'HotdogContest' then count_iam_messages else 0 end ) as popup_hotdogcontest
        , sum( case when iam_type = 'Popup' and iam_group = 'LuckyDice' then count_iam_messages else 0 end ) as popup_luckydice
        , sum( case when iam_type = 'IAM' and iam_group = 'MTXOffer' then count_iam_messages else 0 end ) as iam_mtxoffer
        , sum( case when iam_type = 'IAM' and iam_group = 'MTXOffer: Discounted' then count_iam_messages else 0 end ) as iam_mtxoffer_discounted
        , sum( case when iam_type = 'IAM' and iam_group = 'MTXOffer: Halloween' then count_iam_messages else 0 end ) as iam_mtxoffer_halloween
        , sum( case when iam_type = 'IAM' and iam_group = 'MTXOffer: Lemonade' then count_iam_messages else 0 end ) as iam_mtxoffer_lemonade
        , sum( case when iam_type = 'IAM' and iam_group = 'MTXOffer: Spring' then count_iam_messages else 0 end ) as iam_mtxoffer_spring
        , sum( case when iam_type = 'IAM' and iam_group = 'MTXOffer: StarterOffer' then count_iam_messages else 0 end ) as iam_mtxoffer_starteroffer
        , sum( case when iam_type = 'Popup' and iam_group = 'MovesMaster' then count_iam_messages else 0 end ) as popup_movesmaster
        , sum( case when iam_type = 'IAM' and iam_group = 'NameChange' then count_iam_messages else 0 end ) as iam_namechange
        , sum( case when iam_type = 'IAM' and iam_group = 'Notifications' then count_iam_messages else 0 end ) as iam_notifications
        , sum( case when iam_type = 'Popup' and iam_group = 'PizzaTime' then count_iam_messages else 0 end ) as popup_pizzatime
        , sum( case when iam_type = 'Popup' and iam_group = 'Puzzle' then count_iam_messages else 0 end ) as popup_puzzle
        , sum( case when iam_type = 'IAM' and iam_group = 'RateUs' then count_iam_messages else 0 end ) as iam_rateus
        , sum( case when iam_type = 'IAM' and iam_group = 'ShowAd' then count_iam_messages else 0 end ) as iam_showad
        , sum( case when iam_type = 'IAM' and iam_group = 'TOTD' then count_iam_messages else 0 end ) as iam_totd
        , sum( case when iam_type = 'IAM' and iam_group = 'Toaster' then count_iam_messages else 0 end ) as iam_toaster
        , sum( case when iam_type = 'Popup' and iam_group = 'TreasureTrove' then count_iam_messages else 0 end ) as popup_treasuretrove
        , sum( case when iam_type = 'Popup' and iam_group = 'UpdateApp' then count_iam_messages else 0 end ) as popup_updateapp
        , sum( case when iam_type = 'IAM' then count_iam_messages else 0 end ) as iam_total
        , sum( case when iam_type = 'Popup' then count_iam_messages else 0 end ) as popup_total
        , sum( case when iam_type = 'IAM' and iam_destination_type = 'AdView' then count_iam_messages else 0 end ) as iam_destination_adview
        , sum( case when iam_type = 'Popup' and iam_destination_type = 'GameMode' then count_iam_messages else 0 end ) as popup_destination_gamemode
        , sum( case when iam_type = 'IAM' and iam_destination_type = 'Generic' then count_iam_messages else 0 end ) as iam_destination_generic
        , sum( case when iam_type = 'IAM' and iam_destination_type = 'Offer' then count_iam_messages else 0 end ) as iam_destination_offer
        , sum( case when iam_type = 'Popup' and iam_destination_type = 'PlayerAction' then count_iam_messages else 0 end ) as popup_destination_playeraction
        , sum( case when iam_type = 'IAM' and iam_destination_type = 'PlayerAction' then count_iam_messages else 0 end ) as iam_destination_playeraction
        , sum( case when iam_type = 'Popup' and iam_destination_type = 'Reward' then count_iam_messages else 0 end ) as popup_destination_reward
    from
        -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_summary
        ${player_popup_and_iam_summary.SQL_TABLE_NAME}
    group by
        1,2
)

-----------------------------------------------------------------------
-- social interactions by date
-----------------------------------------------------------------------

, social_interactions_by_date as (
    select
        rdg_id
        , rdg_date
        , sum( 1 ) as social_any_interaction_count
        , sum( case when social_categories = 'ViewGlobalLeaderboard' then 1 else 0 end ) as social_view_global_leaderboard_count
        , sum( case when social_categories = 'ViewFriendsLeaderboard' then 1 else 0 end ) as social_view_friends_leaderboard_count
        , sum( case when social_categories = 'ViewWeeklyLeaderboard' then 1 else 0 end ) as social_view_weekly_leaderboard_count
        , sum( case when social_categories = 'ViewLocalLeaderboard' then 1 else 0 end ) as social_view_local_leaderboard_count
    from
        ${player_social_button_clicks_summary.SQL_TABLE_NAME}
    group by
        1,2
)

-----------------------------------------------------------------------
-- mtx by date
-----------------------------------------------------------------------

, mtx_by_date as (
    select
        rdg_id
        , rdg_date
        , sum( count_mtx_purchases ) as count_mtx_purchases
        , sum( mtx_purchase_dollars ) as mtx_purchase_dollars
        , sum( mtx_purchase_dollars_15 ) as mtx_purchase_dollars_15
    from
        -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_summary
        ${player_mtx_purchase_summary.SQL_TABLE_NAME}
    group by
        1,2
)

-----------------------------------------------------------------------
-- ticket spend by date
-----------------------------------------------------------------------

, tickets_spend_by_date as (

  select
    rdg_id
    , rdg_date
    , sum( tickets_spend ) as tickets_spend
  from
    -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ticket_spend_summary
    ${player_ticket_spend_summary.SQL_TABLE_NAME}
  group by
    1,2
)

-----------------------------------------------------------------------
-- player hitches by date
-----------------------------------------------------------------------

, player_hitches_by_date as (

  select
    rdg_id
    , rdg_date
    , sum( 1 ) as hitch_count
  from
    -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_hitch_summary
    ${player_hitch_summary.SQL_TABLE_NAME}
  group by
    1,2
)

-----------------------------------------------------------------------
-- player_daily_incremental w/ prior date played
-----------------------------------------------------------------------

, player_daily_incremental_w_prior_date as (
    select
        * except ( cumulative_engagement_ticks, secret_eggs )

        -- Fix for cumulative engagement ticks
        , ifnull(coalesce(
          case when cumulative_engagement_ticks = 0 then null else cumulative_engagement_ticks end
          , case
              when lag(cumulative_engagement_ticks,1) over ( partition by rdg_id order by rdg_date asc ) = 0
              then null
              else lag(cumulative_engagement_ticks,1) over ( partition by rdg_id order by rdg_date asc )
              end
          , case
              when lag(cumulative_engagement_ticks,2) over ( partition by rdg_id order by rdg_date asc ) = 0
              then null
              else lag(cumulative_engagement_ticks,2) over ( partition by rdg_id order by rdg_date asc )
              end
          , case
              when lag(cumulative_engagement_ticks,3) over ( partition by rdg_id order by rdg_date asc ) = 0
              then null
              else lag(cumulative_engagement_ticks,3) over ( partition by rdg_id order by rdg_date asc )
              end
          , case
              when lag(cumulative_engagement_ticks,4) over ( partition by rdg_id order by rdg_date asc ) = 0
              then null
              else lag(cumulative_engagement_ticks,4) over ( partition by rdg_id order by rdg_date asc )
              end
          ),0) as cumulative_engagement_ticks

        -- Fix for secret eggs
        , ifnull(coalesce(
          case when secret_eggs = 0 then null else secret_eggs end
          , case
              when lag(secret_eggs,1) over ( partition by rdg_id order by rdg_date asc ) = 0
              then null
              else lag(secret_eggs,1) over ( partition by rdg_id order by rdg_date asc )
              end
          , case
              when lag(secret_eggs,2) over ( partition by rdg_id order by rdg_date asc ) = 0
              then null
              else lag(secret_eggs,2) over ( partition by rdg_id order by rdg_date asc )
              end
          , case
              when lag(secret_eggs,3) over ( partition by rdg_id order by rdg_date asc ) = 0
              then null
              else lag(secret_eggs,3) over ( partition by rdg_id order by rdg_date asc )
              end
          , case
              when lag(secret_eggs,4) over ( partition by rdg_id order by rdg_date asc ) = 0
              then null
              else lag(secret_eggs,4) over ( partition by rdg_id order by rdg_date asc )
              end
          ),0) as secret_eggs

        -- Date last played
        , ifnull(
                lag(rdg_date, 1) over (
            partition by rdg_id
            order by rdg_date ASC
            )
            ,timestamp(date(created_utc))) as rdg_date_last_played

        -- To prevent multiple created dates for an rdg_id
        , min(created_date) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) as created_date_fix

    from
        -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_incremental`
        ${player_daily_incremental.SQL_TABLE_NAME}
        -- tal_scratch.player_daily_incremental_test

)

-----------------------------------------------------------------------
-- join ads data
-----------------------------------------------------------------------

, join_on_ads_data as (
    select
        a.rdg_id
        , a.rdg_date
        , max(a.rdg_date_last_played) as rdg_date_last_played
        , max(a.device_id) as device_id
        , max(a.advertising_id) as advertising_id
        , max(a.user_id) as user_id
        , max(a.bfg_uid) as bfg_uid
        , max(a.display_name) as display_name
        , max(a.platform) as platform
        , max(a.country) as country
        , max(a.created_date_fix) as created_date
        , max(a.experiments) as experiments
        , max(a.version) as version
        , max(a.install_version) as install_version
        , sum( ifnull(b.ad_view_dollars,0) + ifnull(c.ad_view_dollars,0)) as ad_view_dollars
        , max(a.mtx_ltv_from_data) as mtx_ltv_from_data
        , sum( ifnull(b.ad_views,0) + ifnull(c.ad_views,0)) as ad_views

        , sum( ifnull(b.ad_views_daily_rewards,0) + ifnull(c.ad_views_daily_rewards,0)) as ad_views_daily_rewards
        , sum( ifnull(b.ad_views_moves_master,0) + ifnull(c.ad_views_moves_master,0)) as ad_views_moves_master
        , sum( ifnull(b.ad_views_pizza,0) + ifnull(c.ad_views_pizza,0)) as ad_views_pizza
        , sum( ifnull(b.ad_views_lucky_dice,0) + ifnull(c.ad_views_lucky_dice,0)) as ad_views_lucky_dice
        , sum( ifnull(b.ad_views_ask_for_help,0) + ifnull(c.ad_views_ask_for_help,0)) as ad_views_ask_for_help
        , sum( ifnull(b.ad_views_battle_pass,0) + ifnull(c.ad_views_battle_pass,0)) as ad_views_battle_pass
        , sum( ifnull(b.ad_views_puzzles,0) + ifnull(c.ad_views_puzzles,0)) as ad_views_puzzles
        , sum( ifnull(b.ad_views_go_fish,0) + ifnull(c.ad_views_go_fish,0)) as ad_views_go_fish
        , sum( ifnull(b.ad_views_rocket,0) + ifnull(c.ad_views_rocket,0)) as ad_views_rocket
        , sum( ifnull(b.ad_views_lives,0) + ifnull(c.ad_views_lives,0)) as ad_views_lives
        , sum( ifnull(b.ad_views_magnifiers,0) + ifnull(c.ad_views_magnifiers,0)) as ad_views_magnifiers
        , sum( ifnull(b.ad_views_treasure_trove,0) + ifnull(c.ad_views_treasure_trove,0)) as ad_views_treasure_trove
        , sum( ifnull(b.ad_views_castle_climb,0) + ifnull(c.ad_views_castle_climb,0)) as ad_views_castle_climb
        , sum( ifnull(b.ad_views_gem_quest,0) + ifnull(c.ad_views_gem_quest,0)) as ad_views_gem_quest
        , sum( ifnull(b.ad_views_startup_interstitial,0) + ifnull(c.ad_views_startup_interstitial,0)) as ad_views_startup_interstitial
        , sum( ifnull(b.ad_views_ad_iam,0) + ifnull(c.ad_views_ad_iam,0)) as ad_views_ad_iam
        , sum( ifnull(b.ad_views_non_banner,0) + ifnull(c.ad_views_non_banner,0)) as ad_views_non_banner

        , sum( ifnull(b.ad_dollars_daily_rewards,0) + ifnull(c.ad_dollars_daily_rewards,0)) as ad_dollars_daily_rewards
        , sum( ifnull(b.ad_dollars_moves_master,0) + ifnull(c.ad_dollars_moves_master,0)) as ad_dollars_moves_master
        , sum( ifnull(b.ad_dollars_pizza,0) + ifnull(c.ad_dollars_pizza,0)) as ad_dollars_pizza
        , sum( ifnull(b.ad_dollars_lucky_dice,0) + ifnull(c.ad_dollars_lucky_dice,0)) as ad_dollars_lucky_dice
        , sum( ifnull(b.ad_dollars_ask_for_help,0) + ifnull(c.ad_dollars_ask_for_help,0)) as ad_dollars_ask_for_help
        , sum( ifnull(b.ad_dollars_battle_pass,0) + ifnull(c.ad_dollars_battle_pass,0)) as ad_dollars_battle_pass
        , sum( ifnull(b.ad_dollars_puzzles,0) + ifnull(c.ad_dollars_puzzles,0)) as ad_dollars_puzzles
        , sum( ifnull(b.ad_dollars_go_fish,0) + ifnull(c.ad_dollars_go_fish,0)) as ad_dollars_go_fish
        , sum( ifnull(b.ad_dollars_rocket,0) + ifnull(c.ad_dollars_rocket,0)) as ad_dollars_rocket
        , sum( ifnull(b.ad_dollars_lives,0) + ifnull(c.ad_dollars_lives,0)) as ad_dollars_lives
        , sum( ifnull(b.ad_dollars_magnifiers,0) + ifnull(c.ad_dollars_magnifiers,0)) as ad_dollars_magnifiers
        , sum( ifnull(b.ad_dollars_treasure_trove,0) + ifnull(c.ad_dollars_treasure_trove,0)) as ad_dollars_treasure_trove
        , sum( ifnull(b.ad_dollars_castle_climb,0) + ifnull(c.ad_dollars_castle_climb,0)) as ad_dollars_castle_climb
        , sum( ifnull(b.ad_dollars_gem_quest,0) + ifnull(c.ad_dollars_gem_quest,0)) as ad_dollars_gem_quest
        , sum( ifnull(b.ad_dollars_startup_interstitial,0) + ifnull(c.ad_dollars_startup_interstitial,0)) as ad_dollars_startup_interstitial
        , sum( ifnull(b.ad_dollars_ad_iam,0) + ifnull(c.ad_dollars_ad_iam,0)) as ad_dollars_ad_iam
        , sum( ifnull(b.ad_dollars_non_banner,0) + ifnull(c.ad_dollars_non_banner,0)) as ad_dollars_non_banner

        , max(a.count_sessions) as count_sessions
        , max(a.cumulative_engagement_ticks) as cumulative_engagement_ticks
        , max(a.round_start_events) as round_start_events

        , max(a.round_end_events) as round_end_events
        , max(a.round_end_events_campaign) as round_end_events_campaign
        , max(a.round_end_events_movesmaster) as round_end_events_movesmaster
        , max(a.round_end_events_puzzle) as round_end_events_puzzle
        , max(a.round_end_events_gemquest) as round_end_events_gemquest
        , max(a.round_end_events_askforhelp) as round_end_events_askforhelp
        , max(a.round_end_events_gofish) as round_end_events_gofish
        , max(a.gofish_full_matches_completed) as gofish_full_matches_completed
        , max(a.gofish_full_matches_won) as gofish_full_matches_won
        , max(a.round_win_events_gemquest) as round_win_events_gemquest

        , max(a.round_time_in_minutes) as round_time_in_minutes
        , max(a.round_time_in_minutes_campaign) as round_time_in_minutes_campaign
        , max(a.round_time_in_minutes_movesmaster) as round_time_in_minutes_movesmaster
        , max(a.round_time_in_minutes_puzzle) AS round_time_in_minutes_puzzle
        , max(a.round_time_in_minutes_askforhelp) AS round_time_in_minutes_askforhelp
        , max(a.round_time_in_minutes_gofish) AS round_time_in_minutes_gofish

        , max(a.lowest_last_level_serial) as lowest_last_level_serial
        , max(a.highest_last_level_serial) as highest_last_level_serial
        , max(a.max_gofish_rank) as max_gofish_rank

        , max(a.coins_spend) as coins_spend
        , max(a.coins_sourced_from_rewards) as coins_sourced_from_rewards
        , max(a.stars_spend) as stars_spend

        -- ending currency balances
        , max(a.ending_coins_balance) as ending_coins_balance
        , max(a.ending_lives_balance) as ending_lives_balance
        , max(a.ending_stars_balance) as ending_stars_balance
        , max(a.dice_balance) as ending_dice_balance
        , max(a.ticket_balance) as ending_ticket_balance
        , max(a.secret_eggs) as secret_eggs

        -- system_info
        , max( a.hardware ) as hardware
        , max( a.processor_type ) as processor_type
        , max( a.graphics_device_name ) as graphics_device_name
        , max( a.device_model ) as device_model
        , max( a.system_memory_size ) as system_memory_size
        , max( a.graphics_memory_size ) as graphics_memory_size
        , max( a.screen_width ) as screen_width
        , max( a.screen_height ) as screen_height

        -- end of content and zones
        , max( a.end_of_content_levels ) as end_of_content_levels
        , max( a.end_of_content_zones ) as end_of_content_zones
        , max( a.current_zone ) as current_zone

        -- feature participation
        , max( a.feature_participation_daily_reward ) as feature_participation_daily_reward
        , max( a.feature_participation_daily_reward_day_7_completed ) as feature_participation_daily_reward_day_7_completed
        , max( a.feature_participation_pizza_time ) as feature_participation_pizza_time
        , max( a.feature_participation_flour_frenzy ) as feature_participation_flour_frenzy
        , max( a.feature_participation_lucky_dice ) as feature_participation_lucky_dice
        , max( a.feature_participation_treasure_trove ) as feature_participation_treasure_trove
        , max( a.feature_participation_battle_pass ) as feature_participation_battle_pass
        , max( a.feature_participation_castle_climb ) as feature_participation_castle_climb
        , max( a.feature_participation_donut_sprint ) as feature_participation_donut_sprint

        , max( feature_participation_ask_for_help_request ) as feature_participation_ask_for_help_request
        , max( feature_participation_ask_for_help_completed ) as feature_participation_ask_for_help_completed
        , max( feature_participation_ask_for_help_high_five ) as feature_participation_ask_for_help_high_five
        , max( feature_participation_ask_for_help_high_five_return ) as feature_participation_ask_for_help_high_five_return
        , max( feature_participation_hot_dog_contest ) as feature_participation_hot_dog_contest
        , max( feature_participation_food_truck ) as feature_participation_food_truck

        -- feature completion
        , max( a.feature_completion_castle_climb ) as feature_completion_castle_climb
        , max( a.feature_completion_gem_quest ) as feature_completion_gem_quest
        , max( a.feature_completion_puzzle ) as feature_completion_puzzle

        -- ask for help counts
        , max( feature_participation_ask_for_help_request ) as count_ask_for_help_request
        , max( feature_participation_ask_for_help_completed ) as count_ask_for_help_completed
        , max( feature_participation_ask_for_help_high_five ) as count_ask_for_help_high_five
        , max( feature_participation_ask_for_help_high_five_return ) as count_ask_for_help_high_five_return

        -- errors
        , max( a.errors_low_memory_warning ) as errors_low_memory_warning
        , max( a.errors_null_reference_exception ) as errors_null_reference_exception

        -- load times
        , max( a.average_load_time_all ) as average_load_time_all
        , max( a.average_load_time_from_title_scene ) as average_load_time_from_title_scene
        , max( a.average_load_time_from_meta_scene ) as average_load_time_from_meta_scene
        , max( a.average_load_time_from_game_scene ) as average_load_time_from_game_scene
        , max( a.average_load_time_from_app_start ) as average_load_time_from_app_start
        , max( a.average_asset_load_time ) as average_asset_load_time
        , max( ifnull(a.low_render_perf_count,0) ) as low_render_perf_count_cumulative

        -- frame rates
        , max( a.percent_frames_below_22 ) as percent_frames_below_22
        , max( a.percent_frames_between_23_and_40 ) as percent_frames_between_23_and_40
        , max( a.percent_frames_above_40 ) as percent_frames_above_40

        -- possible crashes
        , max( a.count_possible_crashes_from_fast_title_screen_awake ) as count_possible_crashes_from_fast_title_screen_awake

        -- ending boost balances
        , max( a.ending_balance_rocket ) as ending_balance_rocket
        , max( a.ending_balance_bomb ) as ending_balance_bomb
        , max( a.ending_balance_color_ball ) as ending_balance_color_ball
        , max( a.ending_balance_clear_cell ) as ending_balance_clear_cell
        , max( a.ending_balance_clear_horizontal ) as ending_balance_clear_horizontal
        , max( a.ending_balance_clear_vertical ) as ending_balance_clear_vertical
        , max( a.ending_balance_shuffle ) as ending_balance_shuffle
        , max( a.ending_balance_chopsticks ) as ending_balance_chopsticks
        , max( a.ending_balance_skillet ) as ending_balance_skillet
        , max( a.ending_balance_moves ) as ending_balance_moves
        , max( a.ending_balance_disco ) as ending_balance_disco

        -- Chum Skills Used
        , max( a.powerup_hammer ) as powerup_hammer
        , max( a.powerup_rolling_pin ) as powerup_rolling_pin
        , max( a.powerup_piping_bag ) as powerup_piping_bag
        , max( a.powerup_shuffle ) as powerup_shuffle
        , max( a.powerup_chopsticks ) as powerup_chopsticks
        , max( a.powerup_skillet ) as powerup_skillet
        , max( a.total_chum_powerups_used ) as total_chum_powerups_used

        -- Pregame Boosts
        , max( a.pregame_boost_rocket ) as pregame_boost_rocket
        , max( a.pregame_boost_bomb ) as pregame_boost_bomb
        , max( a.pregame_boost_colorball ) as pregame_boost_colorball
        , max( a.pregame_boost_extramoves ) as pregame_boost_extramoves

        -- Daily Pop-up
        , max( a.daily_popup_BattlePass ) as daily_popup_BattlePass
        , max( a.daily_popup_DailyReward ) as daily_popup_DailyReward
        , max( a.daily_popup_FlourFrenzy ) as daily_popup_FlourFrenzy
        , max( a.daily_popup_GoFish ) as daily_popup_GoFish
        , max( a.daily_popup_HotdogContest ) as daily_popup_HotdogContest
        , max( a.daily_popup_LuckyDice ) as daily_popup_LuckyDice
        , max( a.daily_popup_MovesMaster ) as daily_popup_MovesMaster
        , max( a.daily_popup_PizzaTime ) as daily_popup_PizzaTime
        , max( a.daily_popup_Puzzle ) as daily_popup_Puzzle
        , max( a.daily_popup_TreasureTrove ) as daily_popup_TreasureTrove
        , max( a.daily_popup_UpdateApp ) as daily_popup_UpdateApp
        , max( a.daily_popup_CastleClimb ) as daily_popup_CastleClimb
        , max( a.daily_popup_GemQuest ) as daily_popup_GemQuest
        , max( a.daily_popup_DonutSprint ) as daily_popup_DonutSprint

        -- Estimate Ad Placements
        , max( a.estimate_ad_placements_movesmaster ) as estimate_ad_placements_movesmaster
        , max( a.estimate_ad_placements_battlepass ) as estimate_ad_placements_battlepass
        , max( a.estimate_ad_placements_gofish ) as estimate_ad_placements_gofish
        , max( a.estimate_ad_placements_puzzle ) as estimate_ad_placements_puzzle
        , max( a.estimate_ad_placements_lives ) as estimate_ad_placements_lives
        , max( a.estimate_ad_placements_pizzatime ) as estimate_ad_placements_pizzatime
        , max( a.estimate_ad_placements_luckydice ) as estimate_ad_placements_luckydice
        , max( a.estimate_ad_placements_rocket ) as estimate_ad_placements_rocket

    from
        player_daily_incremental_w_prior_date a
        left join ads_by_date b
            on b.rdg_id = a.rdg_id
            and b.rdg_date = a.rdg_date
        left join ads_by_date c
            on c.rdg_id = a.rdg_id
            and c.rdg_date < a.rdg_date
            and c.rdg_date > a.rdg_date_last_played
    group by
        1,2
)


-----------------------------------------------------------------------
-- join ads data
-----------------------------------------------------------------------

, join_on_mtx_data as (
    select
        a.rdg_id
        , a.rdg_date
        , max(a.rdg_date_last_played) as rdg_date_last_played
        , max(a.device_id) as device_id
        , max(a.advertising_id) as advertising_id
        , max(a.user_id) as user_id
        , max(a.bfg_uid) as bfg_uid
        , max(a.display_name) as display_name
        , max(a.platform) as platform
        , max(a.country) as country
        , max(a.created_date) as created_date
        , max(a.experiments) as experiments
        , max(a.version) as version
        , max(a.install_version) as install_version
        , max(a.ad_view_dollars) as ad_view_dollars
        , sum( ifnull(b.mtx_purchase_dollars,0) + ifnull(c.mtx_purchase_dollars,0)) as mtx_purchase_dollars
        , sum( ifnull(b.mtx_purchase_dollars_15,0) + ifnull(c.mtx_purchase_dollars_15,0)) as mtx_purchase_dollars_15
        , sum( ifnull(b.count_mtx_purchases,0) + ifnull(c.count_mtx_purchases,0)) as count_mtx_purchases
        , max(a.mtx_ltv_from_data) as mtx_ltv_from_data
        , max(a.ad_views) as ad_views

        , max(a.ad_views_daily_rewards) as ad_views_daily_rewards
        , max(a.ad_views_moves_master) as ad_views_moves_master
        , max(a.ad_views_pizza) as ad_views_pizza
        , max(a.ad_views_lucky_dice) as ad_views_lucky_dice
        , max(a.ad_views_ask_for_help) as ad_views_ask_for_help
        , max(a.ad_views_battle_pass) as ad_views_battle_pass
        , max(a.ad_views_puzzles) as ad_views_puzzles
        , max(a.ad_views_go_fish) as ad_views_go_fish
        , max(a.ad_views_rocket) as ad_views_rocket
        , max(a.ad_views_lives) as ad_views_lives
        , max(a.ad_views_magnifiers) as ad_views_magnifiers
        , max(a.ad_views_treasure_trove) as ad_views_treasure_trove
        , max(a.ad_views_castle_climb) as ad_views_castle_climb
        , max(a.ad_views_gem_quest) as ad_views_gem_quest
        , max(a.ad_views_startup_interstitial) as ad_views_startup_interstitial
        , max(a.ad_views_ad_iam) as ad_views_ad_iam
        , max(a.ad_views_non_banner) as ad_views_non_banner

        , max(a.ad_dollars_daily_rewards) as ad_dollars_daily_rewards
        , max(a.ad_dollars_moves_master) as ad_dollars_moves_master
        , max(a.ad_dollars_pizza) as ad_dollars_pizza
        , max(a.ad_dollars_lucky_dice) as ad_dollars_lucky_dice
        , max(a.ad_dollars_ask_for_help) as ad_dollars_ask_for_help
        , max(a.ad_dollars_battle_pass) as ad_dollars_battle_pass
        , max(a.ad_dollars_puzzles) as ad_dollars_puzzles
        , max(a.ad_dollars_go_fish) as ad_dollars_go_fish
        , max(a.ad_dollars_rocket) as ad_dollars_rocket
        , max(a.ad_dollars_lives) as ad_dollars_lives
        , max(a.ad_dollars_magnifiers) as ad_dollars_magnifiers
        , max(a.ad_dollars_treasure_trove) as ad_dollars_treasure_trove
        , max(a.ad_dollars_castle_climb) as ad_dollars_castle_climb
        , max(a.ad_dollars_gem_quest) as ad_dollars_gem_quest
        , max(a.ad_dollars_startup_interstitial) as ad_dollars_startup_interstitial
        , max(a.ad_dollars_ad_iam) as ad_dollars_ad_iam
        , max(a.ad_dollars_non_banner) as ad_dollars_non_banner

        , max(a.count_sessions) as count_sessions
        , max(a.cumulative_engagement_ticks) as cumulative_engagement_ticks
        , max(a.round_start_events) as round_start_events

        , max(a.round_end_events) as round_end_events
        , max(a.round_end_events_campaign) as round_end_events_campaign
        , max(a.round_end_events_movesmaster) as round_end_events_movesmaster
        , max(a.round_end_events_puzzle) as round_end_events_puzzle
        , max(a.round_end_events_gemquest) as round_end_events_gemquest
        , max(a.round_end_events_askforhelp) as round_end_events_askforhelp
        , max(a.round_end_events_gofish) as round_end_events_gofish
        , max(a.gofish_full_matches_completed) as gofish_full_matches_completed
        , max(a.gofish_full_matches_won) as gofish_full_matches_won
        , max(a.round_win_events_gemquest) as round_win_events_gemquest

        , max(a.round_time_in_minutes) as round_time_in_minutes
        , max(a.round_time_in_minutes_campaign) as round_time_in_minutes_campaign
        , max(a.round_time_in_minutes_movesmaster) as round_time_in_minutes_movesmaster
        , max(a.round_time_in_minutes_puzzle) AS round_time_in_minutes_puzzle
        , max(a.round_time_in_minutes_askforhelp) AS round_time_in_minutes_askforhelp
        , max(a.round_time_in_minutes_gofish) AS round_time_in_minutes_gofish

        , max(a.lowest_last_level_serial) as lowest_last_level_serial
        , max(a.highest_last_level_serial) as highest_last_level_serial
        , max(a.max_gofish_rank) as max_gofish_rank

        , max(a.coins_spend) as coins_spend
        , max(a.coins_sourced_from_rewards) as coins_sourced_from_rewards
        , max(a.stars_spend) as stars_spend

        -- ending currency balances
        , max(a.ending_coins_balance) as ending_coins_balance
        , max(a.ending_lives_balance) as ending_lives_balance
        , max(a.ending_stars_balance) as ending_stars_balance
        , max(a.ending_dice_balance) as ending_dice_balance
        , max(a.ending_ticket_balance) as ending_ticket_balance
        , max(a.secret_eggs) as secret_eggs

        -- system_info
        , max( a.hardware ) as hardware
        , max( a.processor_type ) as processor_type
        , max( a.graphics_device_name ) as graphics_device_name
        , max( a.device_model ) as device_model
        , max( a.system_memory_size ) as system_memory_size
        , max( a.graphics_memory_size ) as graphics_memory_size
        , max( a.screen_width ) as screen_width
        , max( a.screen_height ) as screen_height

        -- end of content and zones
        , max( a.end_of_content_levels ) as end_of_content_levels
        , max( a.end_of_content_zones ) as end_of_content_zones
        , max( a.current_zone ) as current_zone

        -- feature participation
        , max( a.feature_participation_daily_reward ) as feature_participation_daily_reward
        , max( a.feature_participation_daily_reward_day_7_completed ) as feature_participation_daily_reward_day_7_completed
        , max( a.feature_participation_pizza_time ) as feature_participation_pizza_time
        , max( a.feature_participation_flour_frenzy ) as feature_participation_flour_frenzy
        , max( a.feature_participation_lucky_dice ) as feature_participation_lucky_dice
        , max( a.feature_participation_treasure_trove ) as feature_participation_treasure_trove
        , max( a.feature_participation_battle_pass ) as feature_participation_battle_pass
        , max( feature_participation_ask_for_help_request ) as feature_participation_ask_for_help_request
        , max( feature_participation_ask_for_help_completed ) as feature_participation_ask_for_help_completed
        , max( feature_participation_ask_for_help_high_five ) as feature_participation_ask_for_help_high_five
        , max( feature_participation_ask_for_help_high_five_return ) as feature_participation_ask_for_help_high_five_return
        , max( feature_participation_hot_dog_contest ) as feature_participation_hot_dog_contest
        , max( a.feature_participation_castle_climb ) as feature_participation_castle_climb
        , max( a.feature_participation_donut_sprint ) as feature_participation_donut_sprint
        , max( a.feature_participation_food_truck ) as feature_participation_food_truck

        -- feature completion
        , max( a.feature_completion_castle_climb ) as feature_completion_castle_climb
        , max( a.feature_completion_gem_quest ) as feature_completion_gem_quest
        , max( a.feature_completion_puzzle ) as feature_completion_puzzle

        -- ask for help counts
        , max( feature_participation_ask_for_help_request ) as count_ask_for_help_request
        , max( feature_participation_ask_for_help_completed ) as count_ask_for_help_completed
        , max( feature_participation_ask_for_help_high_five ) as count_ask_for_help_high_five
        , max( feature_participation_ask_for_help_high_five_return ) as count_ask_for_help_high_five_return

        -- errors
        , max( a.errors_low_memory_warning ) as errors_low_memory_warning
        , max( a.errors_null_reference_exception ) as errors_null_reference_exception

        -- load times
        , max( a.average_load_time_all ) as average_load_time_all
        , max( a.average_load_time_from_title_scene ) as average_load_time_from_title_scene
        , max( a.average_load_time_from_meta_scene ) as average_load_time_from_meta_scene
        , max( a.average_load_time_from_game_scene ) as average_load_time_from_game_scene
        , max( a.average_load_time_from_app_start ) as average_load_time_from_app_start
        , max( a.average_asset_load_time ) as average_asset_load_time
        , max( a.low_render_perf_count_cumulative ) as low_render_perf_count_cumulative

        -- frame rates
        , max( a.percent_frames_below_22 ) as percent_frames_below_22
        , max( a.percent_frames_between_23_and_40 ) as percent_frames_between_23_and_40
        , max( a.percent_frames_above_40 ) as percent_frames_above_40

        -- possible crashes
        , max( a.count_possible_crashes_from_fast_title_screen_awake ) as count_possible_crashes_from_fast_title_screen_awake

        -- ending boost balances
        , max( a.ending_balance_rocket ) as ending_balance_rocket
        , max( a.ending_balance_bomb ) as ending_balance_bomb
        , max( a.ending_balance_color_ball ) as ending_balance_color_ball
        , max( a.ending_balance_clear_cell ) as ending_balance_clear_cell
        , max( a.ending_balance_clear_horizontal ) as ending_balance_clear_horizontal
        , max( a.ending_balance_clear_vertical ) as ending_balance_clear_vertical
        , max( a.ending_balance_shuffle ) as ending_balance_shuffle
        , max( a.ending_balance_chopsticks ) as ending_balance_chopsticks
        , max( a.ending_balance_skillet ) as ending_balance_skillet
        , max( a.ending_balance_moves ) as ending_balance_moves
        , max( a.ending_balance_disco ) as ending_balance_disco

        -- Chum Skills Used
        , max( a.powerup_hammer ) as powerup_hammer
        , max( a.powerup_rolling_pin ) as powerup_rolling_pin
        , max( a.powerup_piping_bag ) as powerup_piping_bag
        , max( a.powerup_shuffle ) as powerup_shuffle
        , max( a.powerup_chopsticks ) as powerup_chopsticks
        , max( a.powerup_skillet ) as powerup_skillet
        , max( a.total_chum_powerups_used ) as total_chum_powerups_used

        -- Pregame Boosts
        , max( a.pregame_boost_rocket ) as pregame_boost_rocket
        , max( a.pregame_boost_bomb ) as pregame_boost_bomb
        , max( a.pregame_boost_colorball ) as pregame_boost_colorball
        , max( a.pregame_boost_extramoves ) as pregame_boost_extramoves

        -- Daily Pop-up
        , max( a.daily_popup_BattlePass ) as daily_popup_BattlePass
        , max( a.daily_popup_DailyReward ) as daily_popup_DailyReward
        , max( a.daily_popup_FlourFrenzy ) as daily_popup_FlourFrenzy
        , max( a.daily_popup_GoFish ) as daily_popup_GoFish
        , max( a.daily_popup_HotdogContest ) as daily_popup_HotdogContest
        , max( a.daily_popup_LuckyDice ) as daily_popup_LuckyDice
        , max( a.daily_popup_MovesMaster ) as daily_popup_MovesMaster
        , max( a.daily_popup_PizzaTime ) as daily_popup_PizzaTime
        , max( a.daily_popup_Puzzle ) as daily_popup_Puzzle
        , max( a.daily_popup_TreasureTrove ) as daily_popup_TreasureTrove
        , max( a.daily_popup_UpdateApp ) as daily_popup_UpdateApp
        , max( a.daily_popup_CastleClimb ) as daily_popup_CastleClimb
        , max( a.daily_popup_GemQuest ) as daily_popup_GemQuest
        , max( a.daily_popup_DonutSprint ) as daily_popup_DonutSprint

        -- Estimate Ad Placements
        , max( a.estimate_ad_placements_movesmaster ) as estimate_ad_placements_movesmaster
        , max( a.estimate_ad_placements_battlepass ) as estimate_ad_placements_battlepass
        , max( a.estimate_ad_placements_gofish ) as estimate_ad_placements_gofish
        , max( a.estimate_ad_placements_puzzle ) as estimate_ad_placements_puzzle
        , max( a.estimate_ad_placements_lives ) as estimate_ad_placements_lives
        , max( a.estimate_ad_placements_pizzatime ) as estimate_ad_placements_pizzatime
        , max( a.estimate_ad_placements_luckydice ) as estimate_ad_placements_luckydice
        , max( a.estimate_ad_placements_rocket ) as estimate_ad_placements_rocket

    from
        join_on_ads_data a
        left join mtx_by_date b
            on b.rdg_id = a.rdg_id
            and b.rdg_date = a.rdg_date
        left join mtx_by_date c
            on c.rdg_id = a.rdg_id
            and c.rdg_date < a.rdg_date
            and c.rdg_date > a.rdg_date_last_played
    group by
        1,2
)

-----------------------------------------------------------------------
-- system info fixes - step one
-- select the times where system info changes
-----------------------------------------------------------------------

, system_info_changes as (

  select
    rdg_id
    , rdg_date

    -- system_info
    , hardware
    , processor_type
    , graphics_device_name
    , device_model
    , system_memory_size
    , graphics_memory_size
    , screen_width
    , screen_height

    -- next_rdg_date
    , case
        when
          lead(rdg_date) over (
            partition by rdg_id
            order by rdg_date
          ) is null
        -- select DATE(TIMESTAMP '2099-12-25 15:30:00 America/Los_Angeles')
        then TIMESTAMP(DATE(TIMESTAMP '2099-12-25 15:30:00 America/Los_Angeles'))
        else
          lead(rdg_date) over (
            partition by rdg_id
            order by rdg_date
          )
        end
      as next_rdg_date
    from
        join_on_mtx_data
  where
    hardware is not null
  order by
    rdg_date


)

-----------------------------------------------------------------------
-- system info fixes - step two
-- join back onto data with the updated system info
-----------------------------------------------------------------------

, data_with_system_info_updates as (

    select
        a.rdg_id
        , a.rdg_date

        , a.rdg_date_last_played
        , a.device_id
        , a.advertising_id
        , a.user_id
        , a.bfg_uid
        , a.display_name
        , a.platform
        , a.country
        , a.created_date
        , a.experiments
        , a.version
        , a.install_version
        , a.ad_view_dollars
        , a.mtx_purchase_dollars
        , a.mtx_purchase_dollars_15
        , a.count_mtx_purchases
        , a.mtx_ltv_from_data
        , a.ad_views

        , a.ad_views_daily_rewards
        , a.ad_views_moves_master
        , a.ad_views_pizza
        , a.ad_views_lucky_dice
        , a.ad_views_ask_for_help
        , a.ad_views_battle_pass
        , a.ad_views_puzzles
        , a.ad_views_go_fish
        , a.ad_views_rocket
        , a.ad_views_lives
        , a.ad_views_magnifiers
        , a.ad_views_treasure_trove
        , a.ad_views_castle_climb
        , a.ad_views_gem_quest
        , a.ad_views_startup_interstitial
        , a.ad_views_ad_iam
        , a.ad_views_non_banner

        , a.ad_dollars_daily_rewards
        , a.ad_dollars_moves_master
        , a.ad_dollars_pizza
        , a.ad_dollars_lucky_dice
        , a.ad_dollars_ask_for_help
        , a.ad_dollars_battle_pass
        , a.ad_dollars_puzzles
        , a.ad_dollars_go_fish
        , a.ad_dollars_rocket
        , a.ad_dollars_lives
        , a.ad_dollars_magnifiers
        , a.ad_dollars_treasure_trove
        , a.ad_dollars_castle_climb
        , a.ad_dollars_gem_quest
        , a.ad_dollars_startup_interstitial
        , a.ad_dollars_ad_iam
        , a.ad_dollars_non_banner

        , a.count_sessions
        , a.cumulative_engagement_ticks
        , a.round_start_events

        , a.round_end_events
        , a.round_end_events_campaign
        , a.round_end_events_movesmaster
        , a.round_end_events_puzzle
        , a.round_end_events_gemquest
        , a.round_end_events_askforhelp
        , a.round_end_events_gofish
        , a.gofish_full_matches_completed
        , a.gofish_full_matches_won
        , a.round_win_events_gemquest

        , a.round_time_in_minutes
        , a.round_time_in_minutes_campaign
        , a.round_time_in_minutes_movesmaster
        , a.round_time_in_minutes_puzzle
        , a.round_time_in_minutes_askforhelp
        , a.round_time_in_minutes_gofish

        , a.lowest_last_level_serial
        , a.highest_last_level_serial
        , a.max_gofish_rank as this_date_max_go_fish_rank

        , a.coins_spend
        , a.coins_sourced_from_rewards
        , a.stars_spend

        -- ending currency balances
        , a.ending_coins_balance
        , a.ending_lives_balance
        , a.ending_stars_balance
        , a.ending_dice_balance
        , a.ending_ticket_balance
        , a.secret_eggs

        -- end of content and zones
        , a.end_of_content_levels
        , a.end_of_content_zones
        , a.current_zone

        -- feature participation
        , a.feature_participation_daily_reward
        , a.feature_participation_daily_reward_day_7_completed
        , a.feature_participation_pizza_time
        , a.feature_participation_flour_frenzy
        , a.feature_participation_lucky_dice
        , a.feature_participation_treasure_trove
        , a.feature_participation_battle_pass
        , a.feature_participation_ask_for_help_request
        , a.feature_participation_ask_for_help_completed
        , a.feature_participation_ask_for_help_high_five
        , a.feature_participation_ask_for_help_high_five_return
        , a.feature_participation_hot_dog_contest
        , a.feature_participation_food_truck
        , a.feature_participation_castle_climb
        , a.feature_participation_donut_sprint
        , case
            when
              a.feature_participation_daily_reward = 1
              or a.feature_participation_pizza_time = 1
              or a.feature_participation_flour_frenzy = 1
              or a.feature_participation_lucky_dice = 1
              or a.feature_participation_treasure_trove = 1
              or a.feature_participation_battle_pass = 1
              or a.feature_participation_ask_for_help_request = 1
              or a.feature_participation_ask_for_help_completed = 1
              or a.feature_participation_ask_for_help_high_five = 1
              or a.feature_participation_ask_for_help_high_five_return = 1
              or a.feature_participation_hot_dog_contest = 1
              or a.feature_completion_castle_climb = 1
              or a.feature_participation_food_truck = 1
              then 1
            else 0
            end as feature_participation_any_event

        -- feature completion
        , a.feature_completion_castle_climb
        , a.feature_completion_gem_quest
        , a.feature_completion_puzzle

        -- ask for help counts
        , a.count_ask_for_help_request
        , a.count_ask_for_help_completed
        , a.count_ask_for_help_high_five
        , a.count_ask_for_help_high_five_return

        -- system info fixes
        , ifnull( a.hardware, b.hardware ) as hardware
        , ifnull( a.processor_type, b.processor_type ) as processor_type
        , ifnull( a.graphics_device_name, b.graphics_device_name ) as graphics_device_name
        , ifnull( a.device_model, b.device_model ) as device_model
        , safe_cast(ifnull( a.system_memory_size, b.system_memory_size ) as int64) as system_memory_size
        , safe_cast(ifnull( a.graphics_memory_size, b.graphics_memory_size ) as int64) as graphics_memory_size

        , safe_cast(
            right(ifnull( a.screen_width, b.screen_width ),
            case
                when instr(reverse(ifnull( a.screen_width, b.screen_width )),',',1)-1 < 0
                then length(ifnull( a.screen_width, b.screen_width ))
                else instr(reverse(ifnull( a.screen_width, b.screen_width )),',',1)-1
                end )
            as int64) as screen_width

        , safe_cast(
            right(ifnull( a.screen_height, b.screen_height ),
            case
                when instr(reverse(ifnull( a.screen_height, b.screen_height )),',',1)-1 < 0
                then length(ifnull( a.screen_height, b.screen_height ))
                else instr(reverse(ifnull( a.screen_height, b.screen_height )),',',1)-1
                end )
            as int64) as screen_height

        -- errors
        , a.errors_low_memory_warning
        , a.errors_null_reference_exception

        -- load times
        , a.average_load_time_all
        , a.average_load_time_from_title_scene
        , a.average_load_time_from_meta_scene
        , a.average_load_time_from_game_scene
        , a.average_load_time_from_app_start
        , a.average_asset_load_time
        , a.low_render_perf_count_cumulative

        -- frame rates
        , a.percent_frames_below_22
        , a.percent_frames_between_23_and_40
        , a.percent_frames_above_40

        -- possible crashes
        , a.count_possible_crashes_from_fast_title_screen_awake

        -- ending boost balances
        , a.ending_balance_rocket
        , a.ending_balance_bomb
        , a.ending_balance_color_ball
        , a.ending_balance_clear_cell
        , a.ending_balance_clear_horizontal
        , a.ending_balance_clear_vertical
        , a.ending_balance_shuffle
        , a.ending_balance_chopsticks
        , a.ending_balance_skillet
        , a.ending_balance_moves
        , a.ending_balance_disco

        -- Chum Skills Used
        , a.powerup_hammer
        , a.powerup_rolling_pin
        , a.powerup_piping_bag
        , a.powerup_shuffle
        , a.powerup_chopsticks
        , a.powerup_skillet
        , a.total_chum_powerups_used

        -- Pregame Boosts
        , a.pregame_boost_rocket
        , a.pregame_boost_bomb
        , a.pregame_boost_colorball
        , a.pregame_boost_extramoves
        , ifnull( a.pregame_boost_rocket, 0 )
            + ifnull( a.pregame_boost_bomb, 0 )
            + ifnull( a.pregame_boost_colorball, 0 )
            + ifnull( a.pregame_boost_extramoves, 0 )
            as pregame_boost_total

        -- Daily Pop-up
        , a.daily_popup_BattlePass
        , a.daily_popup_DailyReward
        , a.daily_popup_FlourFrenzy
        , a.daily_popup_GoFish
        , a.daily_popup_HotdogContest
        , a.daily_popup_LuckyDice
        , a.daily_popup_MovesMaster
        , a.daily_popup_PizzaTime
        , a.daily_popup_Puzzle
        , a.daily_popup_TreasureTrove
        , a.daily_popup_UpdateApp
        , a.daily_popup_CastleClimb
        , a.daily_popup_GemQuest
        , a.daily_popup_DonutSprint

        -- Estimate Ad Placements
        , a.estimate_ad_placements_movesmaster
        , a.estimate_ad_placements_battlepass
        , a.estimate_ad_placements_gofish
        , a.estimate_ad_placements_puzzle
        , a.estimate_ad_placements_lives
        , a.estimate_ad_placements_pizzatime
        , a.estimate_ad_placements_luckydice
        , a.estimate_ad_placements_rocket

    from
        join_on_mtx_data a
        left join system_info_changes b
            on a.rdg_id = b.rdg_id
            and a.rdg_date < b.next_rdg_date
            and a.rdg_date > b.rdg_date
)


-----------------------------------------------------------------------
-- add on popups and iams
-----------------------------------------------------------------------

, add_on_popups_and_iams_step as (

  select
    a.*
    , ifnull(b.popup_battlepass,0) as popup_battlepass
    , ifnull(b.iam_ce,0) as iam_ce
    , ifnull(b.popup_castleclimb,0) as popup_castleclimb
    , ifnull(b.iam_chameleon,0) as iam_chameleon
    , ifnull(b.popup_dailyreward,0) as popup_dailyreward
    , ifnull(b.popup_donutsprint,0) as popup_donutsprint
    , ifnull(b.popup_flourfrenzy,0) as popup_flourfrenzy
    , ifnull(b.popup_foodtruck,0) as popup_foodtruck
    , ifnull(b.popup_gemquest,0) as popup_gemquest
    , ifnull(b.iam_generic,0) as iam_generic
    , ifnull(b.popup_gofish,0) as popup_gofish
    , ifnull(b.popup_hotdogcontest,0) as popup_hotdogcontest
    , ifnull(b.popup_luckydice,0) as popup_luckydice
    , ifnull(b.iam_mtxoffer,0) as iam_mtxoffer
    , ifnull(b.iam_mtxoffer_discounted,0) as iam_mtxoffer_discounted
    , ifnull(b.iam_mtxoffer_halloween,0) as iam_mtxoffer_halloween
    , ifnull(b.iam_mtxoffer_lemonade,0) as iam_mtxoffer_lemonade
    , ifnull(b.iam_mtxoffer_spring,0) as iam_mtxoffer_spring
    , ifnull(b.iam_mtxoffer_starteroffer,0) as iam_mtxoffer_starteroffer
    , ifnull(b.popup_movesmaster,0) as popup_movesmaster
    , ifnull(b.iam_namechange,0) as iam_namechange
    , ifnull(b.iam_notifications,0) as iam_notifications
    , ifnull(b.popup_pizzatime,0) as popup_pizzatime
    , ifnull(b.popup_puzzle,0) as popup_puzzle
    , ifnull(b.iam_rateus,0) as iam_rateus
    , ifnull(b.iam_showad,0) as iam_showad
    , ifnull(b.iam_totd,0) as iam_totd
    , ifnull(b.iam_toaster,0) as iam_toaster
    , ifnull(b.popup_treasuretrove,0) as popup_treasuretrove
    , ifnull(b.popup_updateapp,0) as popup_updateapp
    , ifnull(b.iam_total,0) as iam_total
    , ifnull(b.popup_total,0) as popup_total
    , ifnull(b.iam_destination_adview,0) as iam_destination_adview
    , ifnull(b.popup_destination_gamemode,0) as popup_destination_gamemode
    , ifnull(b.iam_destination_generic,0) as iam_destination_generic
    , ifnull(b.iam_destination_offer,0) as iam_destination_offer
    , ifnull(b.popup_destination_playeraction,0) as popup_destination_playeraction
    , ifnull(b.iam_destination_playeraction,0) as iam_destination_playeraction
    , ifnull(b.popup_destination_reward,0) as popup_destination_reward
  from
    data_with_system_info_updates a
    left join popups_and_iams_by_date b
      on a.rdg_id = b.rdg_id
      and a.rdg_date = b.rdg_date

)


-----------------------------------------------------------------------
-- join social data
-----------------------------------------------------------------------

, add_on_social_step as (

  select
    a.*
    , ifnull(b.social_any_interaction_count,0) as social_any_interaction_count
    , ifnull(b.social_view_global_leaderboard_count,0) as social_view_global_leaderboard_count
    , ifnull(b.social_view_friends_leaderboard_count,0) as social_view_friends_leaderboard_count
    , ifnull(b.social_view_weekly_leaderboard_count,0) as social_view_weekly_leaderboard_count
    , ifnull(b.social_view_local_leaderboard_count,0) as social_view_local_leaderboard_count

  from
    add_on_popups_and_iams_step a
    left join social_interactions_by_date b
      on a.rdg_id = b.rdg_id
      and a.rdg_date = b.rdg_date

)

-----------------------------------------------------------------------
-- join tickets
-- join hitches
-----------------------------------------------------------------------

, add_on_tickets_step as (

  select
    a.*
    , ifnull(b.tickets_spend,0) as tickets_spend
    , ifnull(c.hitch_count,0) as hitch_count
  from
    add_on_social_step a
    left join tickets_spend_by_date b
      on a.rdg_id = b.rdg_id
      and a.rdg_date = b.rdg_date
    left join player_hitches_by_date c
      on a.rdg_id = c.rdg_id
      and a.rdg_date = c.rdg_date
)



-----------------------------------------------------------------------
-- cumulative calculations
-----------------------------------------------------------------------

, cumulative_calculations_step_1 as (

  select

    -- Start with all the rows from join_to_player_daily_incremental
    *

    , TIMESTAMP(created_date) as created_date_timestamp

    -- Days Since Created
    , DATE_DIFF(DATE(rdg_date), created_date, DAY) AS days_since_created

    -- Player Day Number
    , 1 + DATE_DIFF(DATE(rdg_date), created_date, DAY) AS day_number

    -- new_player_indicator
    , CASE WHEN DATE_DIFF(DATE(rdg_date), created_date, DAY) = 0 THEN 1 ELSE 0 END AS new_player_indicator

     -- new_player_rdg_id
    , CASE WHEN DATE_DIFF(DATE(rdg_date), created_date, DAY) = 0 THEN rdg_id ELSE NULL END AS new_player_rdg_id

    -- Date last played
    , LAG(DATE(rdg_date), 1) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ) date_last_played

    -- Days Since Last Played
    , DATE_DIFF(
        DATE(rdg_date)
        , LAG(DATE(rdg_date), 1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            )
        , DAY
        ) days_since_last_played

    -- next_date_played
    , LEAD(DATE(rdg_date), 1) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ) next_date_played

    -- cumulative_session_count
    , SUM(count_sessions) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_session_count

    -- churn_indicator
    , CASE
        WHEN
          LEAD(DATE(rdg_date), 1) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ) IS NULL
        THEN 1
        ELSE 0
        END AS churn_indicator

    -- churn_rdg_id
    , CASE
        WHEN
          LEAD(DATE(rdg_date), 1) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ) IS NULL
        THEN rdg_id
        ELSE NULL
        END AS churn_rdg_id

    -- days_until_next_played
    , DATE_DIFF(
        LEAD(DATE(rdg_date), 1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            )
        , DATE(rdg_date)
        , DAY
        ) days_until_next_played

    -- cumulative_mtx_purchase_dollars
    -- Includes adjustment for App Store %
    , SUM( ifnull( mtx_purchase_dollars, 0 ) ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_mtx_purchase_dollars

    , SUM( ifnull( mtx_purchase_dollars_15, 0 ) ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_mtx_purchase_dollars_15

    -- cumulative_count_mtx_purchases
    , SUM( ifnull( count_mtx_purchases, 0 ) ) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_count_mtx_purchases

    -- cumulative_ad_view_dollars
    , SUM(IFNULL(ad_view_dollars,0)) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_ad_view_dollars

    -- cumulative_ad_view_dollars_non_banner
    , SUM(IFNULL(ad_dollars_non_banner,0)) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_ad_dollars_non_banner

    -- combined_dollars
    -- Includes adjustment for App Store %
    , ifnull( mtx_purchase_dollars, 0 ) + IFNULL(ad_view_dollars,0) AS combined_dollars
    , ifnull( mtx_purchase_dollars_15, 0 ) + IFNULL(ad_view_dollars,0) AS combined_dollars_15

    -- cumulative_combined_dollars
    -- Includes adjustment for App Store %
    , SUM(ifnull( mtx_purchase_dollars, 0 ) + IFNULL(ad_view_dollars,0)) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_combined_dollars

    , SUM(ifnull( mtx_purchase_dollars_15, 0 ) + IFNULL(ad_view_dollars,0)) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_combined_dollars_15

    -- daily_mtx_spend_indicator
    , CASE WHEN IFNULL(mtx_purchase_dollars,0) > 0 THEN 1 ELSE 0 END AS daily_mtx_spend_indicator

    -- daily_mtx_spender_rdg_id
    , CASE WHEN IFNULL(mtx_purchase_dollars,0) > 0 THEN rdg_id ELSE NULL END AS daily_mtx_spender_rdg_id

    -- first_mtx_spend_indicator
    , CASE
        WHEN IFNULL(mtx_purchase_dollars,0) > 0
        AND
          ifnull( sum(mtx_purchase_dollars) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING ),0)
          = 0
        THEN 1
        ELSE 0
        END AS first_mtx_spend_indicator

    -- lifetime_mtx_spend_indicator
    , CASE
        WHEN
          SUM(mtx_purchase_dollars) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
          > 0
        THEN 1
        ELSE 0
        END AS lifetime_mtx_spend_indicator

    -- lifetime_mtx_spender_rdg_id
    , CASE
        WHEN
          SUM(mtx_purchase_dollars) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
          > 0
        THEN rdg_id
        ELSE NULL
        END AS lifetime_mtx_spender_rdg_id

    -- cumulative_ad_views
    , SUM(ad_views) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_ad_views

    , SUM(ad_views_non_banner) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_ad_views_non_banner


    -- first_ad_view_indicator
    , CASE
        WHEN IFNULL(ad_views,0) > 0
        AND
          ifnull( SUM(ad_views) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING ),0)
          = 0
        THEN 1
        ELSE 0
        END AS first_ad_view_indicator


    -- first_ad_view_indicator_non_banner
    , CASE
        WHEN IFNULL(ad_views_non_banner,0) > 0
        AND
          ifnull( SUM(ad_views_non_banner) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING ),0)
          = 0
        THEN 1
        ELSE 0
        END AS first_ad_view_indicator_non_banner


    -- Calculate engagement ticks
    -- uses prior row cumulative_engagement_ticks
    , IFNULL(cumulative_engagement_ticks,0) -
        IFNULL(LAG(cumulative_engagement_ticks,1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ),0) AS engagement_ticks

    -- time played
    -- This is calculated as engagement ticks / 2
    , 0.5 * (
        case
        when ifnull(cumulative_engagement_ticks,0) - ifnull(lag(cumulative_engagement_ticks,1) over ( partition by rdg_id order by rdg_date asc ),0) > 2800
        then 2800
        else ifnull(cumulative_engagement_ticks,0) - ifnull(lag(cumulative_engagement_ticks,1) over ( partition by rdg_id order by rdg_date asc ),0)
        end
        )
        AS time_played_minutes

    -- cumulative_time_played_minutes
    -- , 0.5 * ( IFNULL(cumulative_engagement_ticks,0) ) AS cumulative_time_played_minutes

    -- cumulative_round_start_events
    , SUM(round_start_events) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_start_events

    -- cumulative_round_end_events
    , SUM(round_end_events) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_end_events

    -- round_end_events_campaign
    , SUM(round_end_events_campaign) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_end_events_campaign

    -- round_end_events_movesmaster
    , SUM(round_end_events_movesmaster) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_end_events_movesmaster

    -- round_end_events_puzzle
    , SUM(round_end_events_puzzle) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_end_events_puzzle

    -- round_end_events_askforhelp
    , SUM(round_end_events_askforhelp) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_end_events_askforhelp

    -- round_end_events_gofish
    , SUM(round_end_events_gofish) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_end_events_gofish

    -- round_end_events_gemquest
    , SUM(round_end_events_gemquest) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_end_events_gemquest

    -- cumulative days played go fish
    , sum( case when gofish_full_matches_completed > 0 then 1 else 0 end ) over (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_days_with_gofish_full_matches_completed

    -- cumulative go fish matches
    , sum( gofish_full_matches_completed ) over (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_gofish_full_matches_completed

    -- cumulative go fish wins
    , sum( gofish_full_matches_won ) over (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_gofish_full_matches_won

    -- round_time_in_minutes
    , SUM(round_time_in_minutes) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_time_in_minutes

    -- round_time_in_minutes_campaign
    , SUM(round_time_in_minutes_campaign) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_time_in_minutes_campaign

    -- round_time_in_minutes_movesmaster
    , SUM(round_time_in_minutes_movesmaster) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_time_in_minutes_movesmaster

    -- round_time_in_minutes_puzzle
    , SUM(round_time_in_minutes_puzzle) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_time_in_minutes_puzzle

    -- round_time_in_minutes_askforhelp
    , SUM(round_time_in_minutes_askforhelp) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_time_in_minutes_askforhelp

    -- round_time_in_minutes_gofish
    , SUM(round_time_in_minutes_gofish) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_round_time_in_minutes_gofish

    -- count_days_played
    -- this is just always 1
    , 1 as count_days_played

    -- cumulative_count_days_played
    , SUM(1) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_count_days_played

    -- Calculate levels_progressed
    -- uses prior row highest_last_level_serial
    , IFNULL(highest_last_level_serial,0) -
        IFNULL(LAG(highest_last_level_serial,1) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ),0) AS levels_progressed

    -- this_date_max_go_fish_rank
    , MAX(this_date_max_go_fish_rank) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) max_gofish_rank

    -- cumulative_coins_spend
    , SUM(coins_spend) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_coins_spend

          -- , a.coins_sourced_from_rewards

    -- cumulative_coins_sourced_from_rewards
    , SUM(coins_sourced_from_rewards) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_coins_sourced_from_rewards

    -- cumulative_star_spend
    , SUM(stars_spend) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_star_spend


    -- low_render_perf_count
    -- low_render_perf_count_cumulative

    , low_render_perf_count_cumulative
      - ifnull(lag(low_render_perf_count_cumulative, 1) over (
          partition by rdg_id
          order by rdg_date asc
          ),0) low_render_perf_count

    -- cumulative Chum Skills Used
    , SUM(total_chum_powerups_used) OVER (
        PARTITION BY rdg_id
        ORDER BY rdg_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) cumulative_total_chum_powerups_used


  FROM
    add_on_tickets_step

  where
      -- select date_add( current_date(), interval -1 day )
      rdg_date <= timestamp(date_add( current_date(), interval -1 day ))


)

-----------------------------------------------------------------------
-- fix for cumulative time played minutes
-----------------------------------------------------------------------

, fix_for_cumulative_time_played_minutes_table as (

  select
    *
    , SUM(time_played_minutes) OVER (
          PARTITION BY rdg_id
          ORDER BY rdg_date ASC
          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
          ) cumulative_time_played_minutes
  from
    cumulative_calculations_step_1
)

-----------------------------------------------------------------------
-- select *
-----------------------------------------------------------------------

  select
    *
  from
    fix_for_cumulative_time_played_minutes_table



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
    ;;
  primary_key: yes
  hidden: yes
}

################################################################
## Parameters
################################################################

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

  parameter: selected_experiment_start_date {
    type: date
  }

  dimension: selected_experiment_installed_after_start_date {
    type: string
    sql:
      case
        when date(${TABLE}.created_date_timestamp) < date({% parameter selected_experiment_start_date %})
        then 'Installed Before Start Date'
        else 'Installed After Start Date'
        end
    ;;
  }

################################################################
## Dimensions
################################################################

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  # rdg_date for join
  dimension: join_rdg_date {
    type: date
    sql: date(${TABLE}.rdg_date) ;;
  }

  # dates
  dimension_group: rdg_date {
    group_label: "Activity Dates"
    label: "Activity"
    type: time
    timeframes: [date, week, month, year, day_of_week, day_of_week_index]
    sql: ${TABLE}.rdg_date ;;
  }
  dimension_group: created_date_timestamp {
    group_label: "Install Date"
    label: "Install"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date_timestamp ;;
  }

  # strings
  dimension: rdg_id {
    group_label: "Player Ids"
    type:string
  }
  dimension: new_player_rdg_id {
    group_label: "Player Ids"
    type:string
  }
  dimension: lifetime_mtx_spender_rdg_id {
    label: "Lifetime IAP Spender Rdg Id"
    type: string
    }
  dimension: churn_rdg_id {type:string}
  dimension: device_id {type:string}
  dimension: advertising_id {type:string}
  dimension: user_id {type:string}
  dimension: bfg_uid {type:string}
  dimension: platform {type:string}
  dimension: country {type:string}
  dimension: region {type:string sql:@{country_region};;}
  dimension: experiments {type:string}
  dimension: version {type:string}

  dimension: version_number {
    type:number
    sql:
      safe_cast(${TABLE}.version as numeric)
      ;;
    }

  dimension: install_version {type:string}

  dimension: install_version_number {
    type:number
    sql:
      safe_cast(${TABLE}.install_version as numeric)
      ;;
  }

  # numbers
  dimension: mtx_purchase_dollars {
    label: "IAP Dollars - 30%"
    type: number
    }

  dimension: mtx_purchase_dollars_15 {
    label: "IAP Dollars - 15%"
    type: number
  }

  dimension: count_mtx_purchases {
    label: "Count of IAP"
    type: number
    }

  dimension: cumulative_count_mtx_purchases {
    label: "Cumulative Count of IAP"
    type: number
    }

  dimension: ad_view_dollars {
    label: "IAA Dollars"
    type: number
    }

  dimension: ad_dollars_non_banner {
    label: "IAA Dollars (Non-Banner)"
    type: number
  }

  dimension: mtx_ltv_from_data {
    label: "IAP LTV (From Data)"
    type: number
    }

  dimension: ad_views {
    label: "Count of IAA Views"
    type: number
    }

  dimension: ad_views_non_banner {
    label: "Count of IAA Views - Non-Banner"
    type: number
  }

  dimension: count_sessions {type:number}
  dimension: cumulative_session_count {type:number}
  dimension: cumulative_engagement_ticks {type:number}
  dimension: round_start_events {type:number}
  dimension: round_end_events {type:number}
  dimension: lowest_last_level_serial {type:number}
  dimension: highest_last_level_serial {type:number}

  # feature participation
  dimension: feature_participation_daily_reward {
    group_label: "Daily Feature Participation"
    label: "Daily Reward"
    type:number}
  dimension: feature_participation_daily_reward_day_7_completed {
    group_label: "Daily Feature Participation"
    label: "Daily Reward Day 7"
    type:number}
  dimension: feature_participation_pizza_time {
    group_label: "Daily Feature Participation"
    label: "Pizza Time"
    type:number}
  dimension: feature_participation_flour_frenzy {
    group_label: "Daily Feature Participation"
    label: "Flour Frenzy"
    type:number}
  dimension: feature_participation_lucky_dice {
    group_label: "Daily Feature Participation"
    label: "Lucky Dice"
    type:number}
  dimension: feature_participation_treasure_trove {
    group_label: "Daily Feature Participation"
    label: "Treasure Trove"
    type:number}
  dimension: feature_participation_battle_pass {
    group_label: "Daily Feature Participation"
    label: "Battle Pass"
    type:number}

  dimension: feature_participation_ask_for_help_request {
    group_label: "Daily Feature Participation"
    label: "Ask For Help - Request"
    type:number}
  dimension: feature_participation_ask_for_help_completed {
    group_label: "Daily Feature Participation"
    label: "Ask For Help - Completed"
    type:number}
  dimension: feature_participation_ask_for_help_high_five {
    group_label: "Daily Feature Participation"
    label: "Ask For Help - High Five"
    type:number}
  dimension: feature_participation_ask_for_help_high_five_return {
    group_label: "Daily Feature Participation"
    label: "Ask For Help - High Five Return"
    type:number}

  # feature_participation_hot_dog_contest
  dimension: feature_participation_hot_dog_contest {
    group_label: "Daily Feature Participation"
    label: "Hotdog Contest"
    type:number}

  dimension: feature_participation_food_truck {
    group_label: "Daily Feature Participation"
    label: "Food Truck"
    type:number}



  dimension: lowest_last_level_serial_bin {
    type: bin
    bins: [0,50,150,250,400,600,800,1000]
    style: interval
    sql: ${TABLE}.lowest_last_level_serial ;;
    }

  dimension: highest_quests_completed {type:number}
  dimension: gems_spend {type:number}
  dimension: coins_spend {type:number}
  dimension: stars_spend {type:number}
  dimension: ending_gems_balance {type:number}
  dimension: ending_coins_balance {type:number}
  dimension: ending_lives_balance {type:number}
  dimension: ending_stars_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}

  dimension: 30_day_month_number {
    type: number
    group_label: "Grouped Day Numbers"
    label: "30 Day Month Number"
    value_format_name: decimal_0
    sql: safe_cast(ceiling(${TABLE}.day_number/30) as int64) ;;
  }

  dimension: 7_day_week_number {
    type: number
    group_label: "Grouped Day Numbers"
    label: "7 Day Week Number"
    value_format_name: decimal_0
    sql: safe_cast(ceiling(${TABLE}.day_number/7) as int64) ;;
  }

  dimension: new_player_indicator {type:number}
  dimension: date_last_played {type:number}
  dimension: days_since_last_played {type:number}
  dimension: next_date_played {type:number}
  dimension: churn_indicator {type:number}
  dimension: days_until_next_played {type:number}

  dimension: cumulative_mtx_purchase_dollars {
    label: "Cumulative IAP Dollars - 30%"
    type:number
    }

  dimension: cumulative_mtx_purchase_dollars_15 {
    label: "Cumulative IAP Dollars - 15%"
    type:number
  }

  dimension: cumulative_ad_view_dollars {
    label: "Cumulative IAA Dollars"
    type:number
    }

  dimension: cumulative_ad_dollars_non_banner {
    label: "Cumulative IAA Dollars (Non-Banner)"
    type:number
  }

  dimension: combined_dollars {type:number}
  dimension: cumulative_combined_dollars {type:number}

  dimension: daily_mtx_spend_indicator {
    label: "Daily IAP Spend Indicator"
    type: number
    }

  dimension: daily_mtx_spender_rdg_id {
    label: "Daily IAP Spender Rdg Id"
    type:number
    }

  dimension: first_mtx_spend_indicator {
    label: "First IAP Indicator"
    type:number
    }

  dimension: first_ad_view_indicator {
    label: "First IAA Indicator"
    type:number
    }

  dimension: first_ad_view_indicator_non_banner {
    label: "First IAA Indicator - Non-Banner"
    type:number
  }

  dimension: lifetime_mtx_spend_indicator {
    label: "Lifetime IAP Spender Indicator"
    type: number
    }

  dimension: cumulative_ad_views {
    label: "Cumulative IAA Views"
    type: number
    }

  dimension: cumulative_ad_views_non_banner {
    label: "Cumulative IAA Views (Non-Banner)"
    type: number
  }

  dimension: engagement_ticks {type:number}
  dimension: time_played_minutes {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: cumulative_round_start_events {type:number}
  dimension: cumulative_round_end_events {type:number}
  dimension: quests_completed {type:number}
  dimension: count_days_played {type:number}
  dimension: cumulative_count_days_played {type:number}
  dimension: levels_progressed {type:number}
  dimension: cumulative_gems_spend {type:number}
  dimension: cumulative_coins_spend {type:number}
  dimension: cumulative_coins_sourced_from_rewards {type:number}
  dimension: cumulative_star_spend {type:number}

  dimension: round_end_events_campaign {type:number}
  dimension: round_end_events_movesmaster {type:number}
  dimension: round_end_events_puzzle {type:number}
  dimension: round_end_events_gemquest {type:number}
  dimension: round_end_events_askforhelp {type:number}

  dimension: gofish_full_matches_completed {type: number}
  dimension: gofish_full_matches_won {type: number}
  dimension: cumulative_days_with_gofish_full_matches_completed {type: number}
  dimension: cumulative_gofish_full_matches_completed {type: number}
  dimension: cumulative_gofish_full_matches_won {type: number}

  dimension: round_time_in_minutes {type:number}
  dimension: round_time_in_minutes_campaign {type:number}
  dimension: round_time_in_minutes_movesmaster {type:number}
  dimension: round_time_in_minutes_puzzle {type:number}
  dimension: round_time_in_minutes_askforhelp {type:number}

  dimension: cumulative_round_end_events_campaign {type:number}
  dimension: cumulative_round_end_events_movesmaster {type:number}
  dimension: cumulative_round_end_events_puzzle {type:number}
  dimension: cumulative_round_end_events_askforhelp {type:number}

  dimension: cumulative_round_time_in_minutes {type:number}
  dimension: cumulative_round_time_in_minutes_campaign {type:number}
  dimension: cumulative_round_time_in_minutes_movesmaster {type:number}
  dimension: cumulative_round_time_in_minutes_puzzle {type:number}
  dimension: cumulative_round_time_in_minutes_askforhelp {type:number}

  ## end of content and zones
  dimension: end_of_content_levels {type: yesno}
  dimension: end_of_content_zones {type: yesno}
  dimension: current_zone {type: number}
  dimension: current_zone_progress {type: number}

   ## player age bins
  dimension: player_day_number_bin {
    type:  tier
    style: integer
    tiers: [0,1,2,7,30,60,90,120,180,365]
    sql: ${TABLE}.day_number ;;
  }

## system_info
  dimension: hardware {
    group_label: "System Info"
    type: string
  }
  dimension: processor_type {
    group_label: "System Info"
    type: string
  }
  dimension: graphics_device_name {
    group_label: "System Info"
    type: string
  }
  dimension: device_model {
    group_label: "System Info"
    type: string
  }
  dimension: system_memory_size {
    group_label: "System Info"
    type: number
  }
  dimension: system_memory_size_bin {
    group_label: "System Info"
    label: "System Memory Bins"
    type: tier
    tiers: [0,1000,2000,3000,4000,5000,6000,7000,8000]
    sql: ${system_memory_size} ;;
  }
  dimension: graphics_memory_size {
    group_label: "System Info"
    type: number
  }
  dimension: screen_width {
    group_label: "System Info"
    type: number
  }
  dimension: screen_height {
    group_label: "System Info"
    type: number
  }
  dimension: screen_dimensions {
    group_label: "System Info"
    type: string
    sql:
      safe_cast(${TABLE}.screen_width as string)
      || ' x '
      || safe_cast(${TABLE}.screen_height as string) ;;
  }

  dimension: aspect_ratio_9 {
    group_label: "System Info"
    type: string
    sql:
      cast( round(9 * safe_divide( ${TABLE}.screen_height , ${TABLE}.screen_width ),0) as string )
      || ':9'
    ;;

  }

  ## errors
  dimension: errors_low_memory_warning {
    group_label: "Errors"
    label: "Count Low Memory Warnings"
    type: number
  }
  dimension: errors_null_reference_exception {
    group_label: "Errors"
    label: "Count Null Reference Exceptions"
    type: number
  }
  dimension: rdg_id_with_errors_low_memory_warning {
    group_label: "Errors"
    label: "Low Memory Warning Rdg ID"
    type: number
    sql: case when ${TABLE}.errors_low_memory_warning > 0 then ${TABLE}.rdg_id else null end ;;
  }
  dimension: rdg_id_with_errors_null_reference_exception {
    group_label: "Errors"
    label: "Null Reference Exception Rdg ID"
    type: number
    sql: case when ${TABLE}.errors_null_reference_exception > 0 then ${TABLE}.rdg_id else null end ;;
  }


  ## Puzzle Piece Mapping
  dimension: puzzle_piece_number_mapping_by_date {
    label: "Puzzle Piece # Mapping by Date"
    type: string
    sql: @{puzzle_piece_number_mapping_by_date} ;;
  }

  dimension: puzzle_piece_number_mapping_start_date {
    label: "Puzzle Piece # Mapping Start Date"
    type: date
    sql: @{puzzle_piece_number_mapping_start_date} ;;
  }

################################################################
## Unique Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
  measure: count_distinct_new_player_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    value_format: "#,###"
    sql: ${TABLE}.new_player_rdg_id ;;
  }
  measure: count_distinct_churn_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.churn_rdg_id ;;
  }
  measure: count_distinct_daily_mtx_spender_rdg_id {
    label: "Count Distinct Daily IAP Spender Rdg Id"
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: count_distinct_lifetime_mtx_spender_rdg_id {
    label: "Count Distinct Lifetime IAP Spender Rdg Id"
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.lifetime_mtx_spender_rdg_id ;;
  }
  measure: count_distinct_7_day_churn_rdg_id {
    group_label: "Unique Player Counts"
    type: number
    sql:
      count(distinct
        case
          when date_diff(${TABLE}.next_date_played,date(${TABLE}.rdg_date),DAY) >= 7
          then ${TABLE}.rdg_id
          when ${TABLE}.next_date_played is null
          then ${TABLE}.rdg_id
          else null
          end
      )
     ;;
    value_format_name: decimal_0
  }

################################################################
## Engagement Milestones
################################################################

  measure: engagement_milestone_cumulative_time_05_plus_minutes {
    group_label: "Engagement Milestone - Cumulative Time Played Minutes"
    label: "5+ Min"
    type: number
    sql:
      safe_divide(
        count(distinct
          case
            when ${TABLE}.cumulative_time_played_minutes >= 5
            then ${TABLE}.rdg_id
            else null
            end
          )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_cumulative_time_15_plus_minutes {
    group_label: "Engagement Milestone - Cumulative Time Played Minutes"
    label: "15+ Min"
    type: number
    sql:
      safe_divide(
        count(distinct
          case
            when ${TABLE}.cumulative_time_played_minutes >= 15
            then ${TABLE}.rdg_id
            else null
            end
          )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_cumulative_time_30_plus_minutes {
    group_label: "Engagement Milestone - Cumulative Time Played Minutes"
    label: "30+ Min"
    type: number
    sql:
      safe_divide(
        count(distinct
          case
            when ${TABLE}.cumulative_time_played_minutes >= 30
            then ${TABLE}.rdg_id
            else null
            end
          )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_cumulative_time_60_plus_minutes {
    group_label: "Engagement Milestone - Cumulative Time Played Minutes"
    label: "60+ Min"
    type: number
    sql:
      safe_divide(
        count(distinct
          case
            when ${TABLE}.cumulative_time_played_minutes >= 60
            then ${TABLE}.rdg_id
            else null
            end
          )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }


################################################################
## Average Daily Numbers
################################################################

  measure: average_daily_active_users {
    group_label: "Average Daily Numbers"
    label: "Average Daily Active Users (DAU)"
    type: number
    sql:
      safe_divide(
        sum(1)
        ,
        count(distinct ${TABLE}.rdg_date)
      )
    ;;
    value_format_name: decimal_0
  }

################################################################
## Other Calculations
################################################################

  measure: percent_players_unlocked_disco {
    group_label: "Chum Unlock %s"
    label: "Disco"
    type: number
    value_format_name: percent_2
    sql:
      safe_divide(
        count(distinct case when ending_balance_disco is not null then rdg_id else null end )
        ,
        count(distinct rdg_id)
      )
    ;;
  }

  measure: percent_players_unlocked_clear_cell {
    group_label: "Chum Unlock %s"
    label: "Clear Cell"
    type: number
    value_format_name: percent_2
    sql:
      safe_divide(
        count(distinct case when ending_balance_clear_cell is not null then rdg_id else null end )
        ,
        count(distinct rdg_id)
      )
    ;;
  }

  measure: percent_players_unlocked_clear_horizontal {
    group_label: "Chum Unlock %s"
    label: "Clear Horizontal"
    type: number
    value_format_name: percent_2
    sql:
      safe_divide(
        count(distinct case when ending_balance_clear_horizontal is not null then rdg_id else null end )
        ,
        count(distinct rdg_id)
      )
    ;;
  }

  measure: percent_players_unlocked_clear_vertical {
    group_label: "Chum Unlock %s"
    label: "Clear Vertical"
    type: number
    value_format_name: percent_2
    sql:
      safe_divide(
        count(distinct case when ending_balance_clear_vertical is not null then rdg_id else null end )
        ,
        count(distinct rdg_id)
      )
    ;;
  }

  measure: percent_players_unlocked_shuffle {
    group_label: "Chum Unlock %s"
    label: "Shuffle"
    type: number
    value_format_name: percent_2
    sql:
      safe_divide(
        count(distinct case when ending_balance_shuffle is not null then rdg_id else null end )
        ,
        count(distinct rdg_id)
      )
    ;;
  }

  measure: percent_players_unlocked_chopsticks {
    group_label: "Chum Unlock %s"
    label: "Chopsticks"
    type: number
    value_format_name: percent_2
    sql:
      safe_divide(
        count(distinct case when ending_balance_chopsticks is not null then rdg_id else null end )
        ,
        count(distinct rdg_id)
      )
    ;;
  }

  measure: percent_players_unlocked_skillet {
    group_label: "Chum Unlock %s"
    label: "Skillet"
    type: number
    value_format_name: percent_2
    sql:
      safe_divide(
        count(distinct case when ending_balance_skillet is not null then rdg_id else null end )
        ,
        count(distinct rdg_id)
      )
    ;;
  }

  measure: percent_players_unlocked_moves {
    group_label: "Chum Unlock %s"
    label: "Moves Bunny"
    type: number
    value_format_name: percent_2
    sql:
      safe_divide(
        count(distinct case when ending_balance_moves is not null then rdg_id else null end )
        ,
        count(distinct rdg_id)
      )
    ;;
  }

  measure: percent_players_engaged_any_event {
    group_label: "Daily Feature Participation"
    label: "Any Feature"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_any_event > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_social_any {
    group_label: "Daily Feature Participation"
    label: "Social - Weekly Leaderboard"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.social_any_interaction_count > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_social_view_global {
    group_label: "Daily Feature Participation"
    label: "Social - Global Leaderboard"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.social_view_global_leaderboard_count > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_social_view_friends {
    group_label: "Daily Feature Participation"
    label: "Social - Friends Leaderboard"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.social_view_friends_leaderboard_count > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_social_view_local {
    group_label: "Daily Feature Participation"
    label: "Social - Local Leaderboard"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.social_view_local_leaderboard_count > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }


  measure: percent_players_engaged_with_battle_pass {
    group_label: "Daily Feature Participation"
    label: "Battle Pass"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_battle_pass > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_treasure_trove {
    group_label: "Daily Feature Participation"
    label: "Treasure Trove"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_treasure_trove > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_hotdog_contest {
    group_label: "Daily Feature Participation"
    label: "Hotdog Contest"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_hot_dog_contest > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_food_truck {
    group_label: "Daily Feature Participation"
    label: "Food Truck"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_food_truck > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_castle_climb {
    group_label: "Daily Feature Participation"
    label: "Castle Climb"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_castle_climb > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_donut_sprint {
    group_label: "Daily Feature Participation"
    label: "Donut Sprint"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_donut_sprint > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }


  measure: percent_players_engaged_with_lucky_dice {
    group_label: "Daily Feature Participation"
    label: "Lucky Dice"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_lucky_dice > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_flour_frenzy {
    group_label: "Daily Feature Participation"
    label: "Flour Frenzy"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_flour_frenzy > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_pizza_time {
    group_label: "Daily Feature Participation"
    label: "Pizza Time"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_pizza_time > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_daily_reward {
    group_label: "Daily Feature Participation"
    label: "Daily Reward"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_daily_reward > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_ask_for_help_request {
    group_label: "Daily Feature Participation"
    label: "Ask for Help Request"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_ask_for_help_request > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_engaged_with_ask_for_help_completed {
    group_label: "Daily Feature Participation"
    label: "Ask for Help Completed"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_participation_ask_for_help_completed > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_completed_castle_climb {
    group_label: "Daily Feature Completion"
    label: "Castle Climb"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_completion_castle_climb > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_completed_gem_quest {
    group_label: "Daily Feature Completion"
    label: "Gem Quest"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_completion_gem_quest > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: feature_completion_puzzle {
    group_label: "Daily Feature Completion"
    label: "Puzzle"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.feature_completion_puzzle > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_rounds {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_campaign {
    group_label: "Participation by Game Mode"
    label: "Campaign"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_campaign > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }
  measure: percent_players_playing_any_mode {
    group_label: "Participation by Game Mode"
    label: "Any Mode (ex Campaign)"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_movesmaster > 0
            or ${TABLE}.round_end_events_puzzle > 0
            or ${TABLE}.round_end_events_gofish > 0
            or ${TABLE}.round_end_events_gemquest > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }
  measure: percent_players_playing_movesmaster {
    group_label: "Participation by Game Mode"
    label: "Moves Master"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_movesmaster > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_over_level_40 {
    group_label: "Participation by Game Mode"
    label: "Players Over Level 40"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.highest_last_level_serial >= 40
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_puzzle {
    group_label: "Participation by Game Mode"
    label: "Puzzle"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_puzzle > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_gemquest {
    group_label: "Participation by Game Mode"
    label: "Gem Quest"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_gemquest > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_askforhelp {
    group_label: "Participation by Game Mode"
    label: "Ask For Help"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_askforhelp > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_gofish {
    group_label: "Participation by Game Mode"
    label: "Go Fish"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_gofish > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: go_fish_daily_full_match_win_rate {
    label: "Go Fish Daily Full Match Win Rate"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.gofish_full_matches_won)
        , sum(${TABLE}.gofish_full_matches_completed)
      )
    ;;
    value_format_name: percent_0
  }


  measure: churn_rate {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct ${TABLE}.churn_rdg_id )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: count_distinct_7_day_churn_rate {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct
          case
            when date_diff(${TABLE}.next_date_played,date(${TABLE}.rdg_date),DAY) >= 7
            then ${TABLE}.rdg_id
            when ${TABLE}.next_date_played is null
            then ${TABLE}.rdg_id
            else null
            end
        )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
     ;;
    value_format_name: percent_0
  }

################################################################
## Average Game Mode Rounds Per DAU
################################################################

  measure: average_game_mode_rounds_per_dau_campaign {
    group_label: "Average Game Mode Rounds Per DAU"
    label: "Campaign"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.round_end_events_campaign )
        ,
        sum( ${TABLE}.count_days_played )
      )
    ;;
    value_format_name: decimal_1
  }
  measure: average_game_mode_rounds_per_dau_movesmaster {
    group_label: "Average Game Mode Rounds Per DAU"
    label: "Moves Master"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.round_end_events_movesmaster )
        ,
        sum( ${TABLE}.count_days_played )
      )
    ;;
    value_format_name: decimal_1
  }

  measure: average_game_mode_rounds_per_dau_puzzle {
    group_label: "Average Game Mode Rounds Per DAU"
    label: "Puzzle"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.round_end_events_puzzle )
        ,
        sum( ${TABLE}.count_days_played )
      )
    ;;
    value_format_name: decimal_1
  }

  measure: average_game_mode_rounds_per_dau_gemquest {
    group_label: "Average Game Mode Rounds Per DAU"
    label: "Gem Quest"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.round_end_events_gemquest )
        ,
        sum( ${TABLE}.count_days_played )
      )
    ;;
    value_format_name: decimal_1
  }

  measure: average_game_mode_rounds_per_dau_gofish {
    group_label: "Average Game Mode Rounds Per DAU"
    label: "Go Fish"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.round_end_events_gofish )
        ,
        sum( ${TABLE}.count_days_played )
      )
    ;;
    value_format_name: decimal_1
  }

################################################################
## Revenue Metrics
################################################################

  measure: average_mtx_purchase_revenue_per_player{
    label: "Average IAP Per Player - 30%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }

  measure: average_mtx_purchase_revenue_per_player_15{
    label: "Average IAP Per Player - 15%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars_15)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }

  measure: average_mtx_arpdau {
    label: "IAP ARPDAU - 30%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: usd
  }

  measure: average_mtx_arpdau_15 {
    label: "IAP ARPDAU - 15%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars_15)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: usd
  }


  measure: average_daily_mtx_conversion {
    label: "Daily IAP Conversion"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.daily_mtx_spend_indicator)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: percent_1
  }

  measure: average_daily_mtx_revenue_per_spender {
    label: "IAP ARPS - 30%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        sum(${TABLE}.daily_mtx_spend_indicator)
      )
    ;;
    value_format_name: usd
  }

  measure: average_daily_mtx_revenue_per_spender_15 {
    label: "IAP ARPS - 15%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars_15)
        ,
        sum(${TABLE}.daily_mtx_spend_indicator)
      )
    ;;
    value_format_name: usd
  }

  measure: average_daily_ad_revenue_per_ad_viewer {
    label: "IAA Revenue Per Ad Viewer"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_view_dollars)
        ,
         sum( case
          when ${TABLE}.ad_views > 0
          then 1
          else 0
          end )
      )
    ;;
    value_format: "$0.0000"
  }

  measure: average_daily_ad_revenue_per_ad_viewer_non_banner {
    label: "IAA Revenue Per Ad Viewer (Non-Banner)"
    group_label: "Revenue Metrics (Non-Banner)"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_dollars_non_banner)
        ,
         sum( case
          when ${TABLE}.ad_views_non_banner > 0
          then 1
          else 0
          end )
      )
    ;;
    value_format: "$0.0000"
  }

  measure: average_ad_revenue_per_player{
    label: "Average IAA Per Player"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_view_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format: "$0.0000"
  }

  measure: average_ad_revenue_per_player_non_banner{
    label: "Average IAA Per Player (Non-Banner)"
    group_label: "Revenue Metrics (Non-Banner)"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_dollars_non_banner)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format: "$0.0000"
  }

  measure: average_ad_arpdau {
    label: "IAA ARPDAU"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_view_dollars)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format: "$0.0000"
  }

  measure: average_ad_arpdau_non_banner {
    label: "IAA ARPDAU (Non-Banner)"
    group_label: "Revenue Metrics (Non-Banner)"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_dollars_non_banner)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format: "$0.0000"
  }

  measure: average_ad_arpdau_startup_interstitial {
    label: "IAA ARPDAU - Startup Interstitial"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_dollars_startup_interstitial)
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: usd
  }

  measure: average_iaa_ecpm {
    label: "IAA eCPM"
    group_label: "Revenue Metrics"
    type: number
    sql:
      1000
      *
      safe_divide(
        sum(${TABLE}.ad_view_dollars)
        ,
        sum(${TABLE}.ad_views)
      )
    ;;
    value_format: "$0.0000"
  }

  measure: average_iaa_ecpm_non_banner {
    label: "IAA eCPM (Non-Banner)"
    group_label: "Revenue Metrics (Non-Banner)"
    type: number
    sql:
      1000
      *
      safe_divide(
        sum(${TABLE}.ad_dollars_non_banner)
        ,
        sum(${TABLE}.ad_views_non_banner)
      )
    ;;
    value_format: "$0.0000"
  }

  measure: average_daily_ads_conversion {
    label: "Daily IAA Conversion"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum( case
          when ${TABLE}.ad_views > 0
          then 1
          else 0
          end )
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: percent_1
  }

  measure: average_daily_ads_conversion_non_banner {
    label: "Daily IAA Conversion - Non-Banner"
    group_label: "Revenue Metrics - Non-Banner"
    type: number
    sql:
      safe_divide(
        sum( case
          when ${TABLE}.ad_views_non_banner > 0
          then 1
          else 0
          end )
        ,
        sum(${TABLE}.count_days_played)
      )
    ;;
    value_format_name: percent_1
  }

  measure: average_combined_revenue_per_player{
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.combined_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }

  measure: average_daily_iap_spenders {
    label: "Average Daily IAP Spenders"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.daily_mtx_spend_indicator)
        ,
        count(distinct ${TABLE}.rdg_date)
      )
    ;;
    value_format_name: decimal_0
  }

  measure: average_daily_iap_revenue {
    label: "Average Daily IAP Revenue - 30%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        count(distinct ${TABLE}.rdg_date)
      )
    ;;
    value_format_name: usd_0
  }

  measure: average_daily_iap_revenue_15 {
    label: "Average Daily IAP Revenue - 15%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars_15)
        ,
        count(distinct ${TABLE}.rdg_date)
      )
    ;;
    value_format_name: usd_0
  }

  measure: average_revenue_per_iap_purchase {
    label: "Average Revenue Per IAP Purchase - 30%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        sum(${TABLE}.count_mtx_purchases)
      )
    ;;
    value_format_name: usd
  }

  measure: average_revenue_per_iap_purchase_15 {
    label: "Average Revenue Per IAP Purchase - 15%"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars_15)
        ,
        sum(${TABLE}.count_mtx_purchases)
      )
    ;;
    value_format_name: usd
  }

  measure: average_iap_purchases_per_day {
    label: "Average IAP Purchases Per Day"
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_mtx_purchases)
        ,
        count(distinct ${TABLE}.rdg_date)
      )
    ;;
    value_format_name: decimal_0
  }

######################################################################
## Hitch Count Distributions
######################################################################

  measure: average_hitches_per_day {
    group_label: "Count Hitches"
    label: "Average Hitches Per DAU"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.hitch_count)
        , sum(${TABLE}.count_days_played)
      )
      ;;
    value_format_name: decimal_1
  }

  measure: sum_count_hitches {
    group_label: "Count Hitches"
    label: "Total Hitches"
    type:sum
    sql: ${TABLE}.hitch_count ;;
    value_format_name: decimal_0
  }

  measure: count_hitches_10 {
    group_label: "Count Hitches"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.hitch_count ;;
    value_format_name: decimal_0
  }
  measure: count_hitches_25 {
    group_label: "Count Hitches"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.hitch_count ;;
    value_format_name: decimal_0
  }
  measure: count_hitches_50 {
    group_label: "Count Hitches"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.hitch_count ;;
    value_format_name: decimal_0
  }
  measure: count_hitches_75 {
    group_label: "Count Hitches"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.hitch_count ;;
    value_format_name: decimal_0
  }
  measure: count_hitches_95 {
    group_label: "Count Hitches"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.hitch_count ;;
    value_format_name: decimal_0
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
    value_format_name: decimal_0
    sql: round(${TABLE}.percent_frames_above_40*100) ;;
  }
  measure: percent_dau_with_5_percent_of_frames_or_more_above_40 {
    label: "Percent of DAU with 25% of frames above 40ms"
    group_label: "Frame Rate Distribution"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum(
          case
            when round(${TABLE}.percent_frames_above_40*100) >= 25
            then 1
            else 0
          end
          )
        ,
        sum( 1 )
        )

        ;;
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

################################################################
## Ad Placement Estimates
################################################################

  measure: estimate_ad_placements_movesmaster_per_day {
    label: "Moves Master"
    group_label: "Estimate Ad Placements Per Day"
    type: number
    value_format_name: decimal_1
    sql: safe_divide( sum( ${TABLE}.estimate_ad_placements_movesmaster ) , sum( ${TABLE}.count_days_played ) );;
  }

  measure: estimate_ad_placements_battlepass_per_day {
    label: "Battle Pass"
    group_label: "Estimate Ad Placements Per Day"
    type: number
    value_format_name: decimal_1
    sql: safe_divide( sum( ${TABLE}.estimate_ad_placements_battlepass ) , sum( ${TABLE}.count_days_played ) );;
  }

  measure: estimate_ad_placements_gofish_per_day {
    label: "Go Fish"
    group_label: "Estimate Ad Placements Per Day"
    type: number
    value_format_name: decimal_1
    sql: safe_divide( sum( ${TABLE}.estimate_ad_placements_gofish ) , sum( ${TABLE}.count_days_played ) );;
  }

  measure: estimate_ad_placements_puzzle_per_day {
    label: "Puzzle"
    group_label: "Estimate Ad Placements Per Day"
    type: number
    value_format_name: decimal_1
    sql: safe_divide( sum( ${TABLE}.estimate_ad_placements_puzzle ) , sum( ${TABLE}.count_days_played ) );;
  }

  measure: estimate_ad_placements_lives_per_day {
    label: "Lives"
    group_label: "Estimate Ad Placements Per Day"
    type: number
    value_format_name: decimal_1
    sql: safe_divide( sum( ${TABLE}.estimate_ad_placements_lives ) , sum( ${TABLE}.count_days_played ) );;
  }

  measure: estimate_ad_placements_pizzatime_per_day {
    label: "Pizza Time"
    group_label: "Estimate Ad Placements Per Day"
    type: number
    value_format_name: decimal_1
    sql: safe_divide( sum( ${TABLE}.estimate_ad_placements_pizzatime ) , sum( ${TABLE}.count_days_played ) );;
  }

  measure: estimate_ad_placements_luckydice_per_day {
    label: "Lucky Dice"
    group_label: "Estimate Ad Placements Per Day"
    type: number
    value_format_name: decimal_1
    sql: safe_divide( sum( ${TABLE}.estimate_ad_placements_luckydice ) , sum( ${TABLE}.count_days_played ) );;
  }

  measure: estimate_ad_placements_rocket_per_day {
    label: "Rocket"
    group_label: "Estimate Ad Placements Per Day"
    type: number
    value_format_name: decimal_1
    sql: safe_divide( sum( ${TABLE}.estimate_ad_placements_rocket ) , sum( ${TABLE}.count_days_played ) );;
  }

################################################################
## Possible Crashes
################################################################

dimension: count_possible_crashes_from_fast_title_screen_awake {
  group_label: "Possible Crashes"
  type: number}

measure: percent_of_players_with_possible_crashes_from_fast_title_screen_awake {
  group_label: "Possible Crashes"
  type: number
  sql:
    safe_divide(
      count(distinct
        case
          when ${TABLE}.count_possible_crashes_from_fast_title_screen_awake > 0
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count(distinct ${TABLE}.rdg_id )
      )
  ;;
  value_format_name: percent_1
}

  measure: average_possible_crashes_from_fast_title_screen_awake_per_player {
    group_label: "Possible Crashes"
    type: number
    sql:
    safe_divide(
      sum( ${TABLE}.count_possible_crashes_from_fast_title_screen_awake )
      ,
      sum( ${TABLE}.count_days_played )
      )
  ;;
    value_format_name: decimal_1
  }

################################################################
## Go Fish Max Rank
################################################################

  dimension: max_gofish_rank {
    group_label: "Go Fish Rank"
    type: number
  }

  dimension: this_date_max_go_fish_rank {
    group_label: "Go Fish Rank"
    type: number
  }

  measure: gofish_rank_10 {
    group_label: "Go Fish Rank"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.max_gofish_rank ;;
  }
  measure: gofish_rank_25 {
    group_label: "Go Fish Rank"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.max_gofish_rank ;;
  }
  measure: gofish_rank_50 {
    group_label: "Go Fish Rank"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.max_gofish_rank ;;
  }
  measure: gofish_rank_75 {
    group_label: "Go Fish Rank"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.max_gofish_rank ;;
  }
  measure: gofish_rank_95 {
    group_label: "Go Fish Rank"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.max_gofish_rank ;;
  }

################################################################
## Low Render Perf Count
################################################################

  dimension: low_render_perf_count {
    group_label: "Low Render Perf Count"
    type: number
  }

  measure: low_render_perf_count_10 {
    group_label: "Low Render Perf Count"
    type: percentile
    percentile: 10
    sql: ${TABLE}.low_render_perf_count ;;
  }
  measure: low_render_perf_count_25 {
    group_label: "Low Render Perf Count"
    type: percentile
    percentile: 25
    sql: ${TABLE}.low_render_perf_count ;;
  }
  measure: low_render_perf_count_50 {
    group_label: "Low Render Perf Count"
    type: percentile
    percentile: 50
    sql: ${TABLE}.low_render_perf_count ;;
  }
  measure: low_render_perf_count_75 {
    group_label: "Low Render Perf Count"
    type: percentile
    percentile: 75
    sql: ${TABLE}.low_render_perf_count ;;
  }
  measure: low_render_perf_count_95 {
    group_label: "Low Render Perf Count"
    type: percentile
    percentile: 95
    sql: ${TABLE}.low_render_perf_count ;;
  }

################################################################
## Go Fish Rounds Played
################################################################

  dimension: round_end_events_gofish {
    group_label: "Go Fish Rounds"
    type: number
  }

  dimension: cumulative_round_end_events_gofish {
    group_label: "Go Fish Rounds"
    type: number
  }

  measure: gofish_rounds_10 {
    group_label: "Go Fish Rounds"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events_gofish ;;
  }
  measure: gofish_rounds_25 {
    group_label: "Go Fish Rounds"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events_gofish ;;
  }
  measure: gofish_rounds_50 {
    group_label: "Go Fish Rounds"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events_gofish ;;
  }
  measure: gofish_rounds_75 {
    group_label: "Go Fish Rounds"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events_gofish ;;
  }
  measure: gofish_rounds_95 {
    group_label: "Go Fish Rounds"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events_gofish ;;
  }

################################################################
## Ad Views By Placement
################################################################

  dimension: ad_views_daily_rewards {
    group_label: "IAA Views By Placement"
    label: "Daily Rewards IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_moves_master {
    group_label: "IAA Views By Placement"
    label: "Moves Master IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_pizza {
    group_label: "IAA Views By Placement"
    label: "Pizza IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_lucky_dice {
    group_label: "IAA Views By Placement"
    label: "Lucky Dice IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_ask_for_help {
    group_label: "IAA Views By Placement"
    label: "Ask For Help IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_battle_pass {
    group_label: "IAA Views By Placement"
    label: "Battle Pass IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_puzzles {
    group_label: "IAA Views By Placement"
    label: "Puzzles IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_go_fish {
    group_label: "IAA Views By Placement"
    label: "Go Fish IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_rocket {
    group_label: "IAA Views By Placement"
    label: "Rocket IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_lives {
    group_label: "IAA Views By Placement"
    label: "Lives IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_magnifiers {
    group_label: "IAA Views By Placement"
    label: "Magnifiers IAA Views"
    value_format_name: decimal_0
    type: number
  }

  dimension: ad_views_treasure_trove {
    group_label: "IAA Views By Placement"
    label: "Treasure Trove IAA Views"
    value_format_name: decimal_0
    type: number
  }

################################################################
## Mean Ad Views Per Round Played
################################################################

  measure: iaa_views_per_round_movesmaster {
    group_label: "IAA Views Per Round Played"
    label: "IAA Views Per Round - Moves Master"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_moves_master), sum(${TABLE}.round_end_events_movesmaster) )  ;;
  }

  measure: iaa_views_per_round_puzzle {
    group_label: "IAA Views Per Round Played"
    label: "IAA Views Per Round - Puzzle"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_puzzles), sum(${TABLE}.round_end_events_puzzle) )  ;;
  }

  measure: iaa_views_per_round_gofish {
    group_label: "IAA Views Per Round Played"
    label: "IAA Views Per Round - Go Fish"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_go_fish), sum(${TABLE}.round_end_events_gofish) )  ;;
  }





################################################################
## Mean Ad Views By Placement
################################################################

  measure: mean_ad_views_total {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Total"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_daily_rewards {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Daily Rewards"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_daily_rewards), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_moves_master {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Moves Master"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_moves_master), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_pizza {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Pizza"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_pizza), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_lucky_dice {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Lucky Dice"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_lucky_dice), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_ask_for_help {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Ask For Help"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_ask_for_help), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_battle_pass {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Battle Pass"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_battle_pass), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_puzzles {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Puzzles"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_puzzles), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_go_fish {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Go Fish"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_go_fish), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_rocket {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Rocket"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_rocket), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_lives {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Lives"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_lives), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_magnifiers {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Magnifiers"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_magnifiers), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_treasure_trove {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Treasure Trove"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_treasure_trove), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_castle_climb {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Castle Climb"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_castle_climb), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_gem_quest {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Gem Quest"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_gem_quest), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_startup_interstitial {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Startup Interstitial"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_startup_interstitial), sum(${TABLE}.count_days_played) )  ;;
  }

  measure: mean_ad_views_ad_iam {
    group_label: "Mean IAA Views By Placement"
    label: "IAA Views Per DAU - Ad IAM"
    value_format_name: decimal_1
    type: number
    sql: safe_divide( sum(${TABLE}.ad_views_ad_iam), sum(${TABLE}.count_days_played) )  ;;
  }

################################################################
## Ad Dollars By Placement
################################################################

  dimension: ad_dollars_daily_rewards {
    group_label: "IAA Dollars By Placement"
    label: "Daily Rewards IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_moves_master {
    group_label: "IAA Dollars By Placement"
    label: "Moves Master IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_pizza {
    group_label: "IAA Dollars By Placement"
    label: "Pizza IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_lucky_dice {
    group_label: "IAA Dollars By Placement"
    label: "Lucky Dice IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_ask_for_help {
    group_label: "IAA Dollars By Placement"
    label: "Ask For Help IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_battle_pass {
    group_label: "IAA Dollars By Placement"
    label: "Battle Pass IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_puzzles {
    group_label: "IAA Dollars By Placement"
    label: "Puzzles IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_go_fish {
    group_label: "IAA Dollars By Placement"
    label: "Go Fish IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_rocket {
    group_label: "IAA Dollars By Placement"
    label: "Rocket IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_lives {
    group_label: "IAA Dollars By Placement"
    label: "Lives IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_magnifiers {
    group_label: "IAA Dollars By Placement"
    label: "Magnifiers IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_treasure_trove {
    group_label: "IAA Dollars By Placement"
    label: "Treasure Trove IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_castle_climb {
    group_label: "IAA Dollars By Placement"
    label: "Castle Climb IAA Dollars"
    value_format_name: usd
  }

  dimension: ad_dollars_gem_quest {
    group_label: "IAA Dollars By Placement"
    label: "Gem Quest IAA Dollars"
    value_format_name: usd
  }



################################################################
## Other Sums / Percentiles
################################################################

  measure: sum_mtx_purchase_dollars {
    label: "Net IAP Dollars - 30%"
    group_label: "IAP Dollars"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.mtx_purchase_dollars ;;
    drill_fields: [mtx_purchase_dollars,rdg_id]
  }


  measure: sum_mtx_purchase_dollars_15 {
    label: "Net IAP Dollars - 15%"
    group_label: "IAP Dollars"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.mtx_purchase_dollars_15 ;;
  }

  measure: sum_mtx_purchase_dollars_gross {
    label: "Gross IAP Dollars"
    group_label: "IAP Dollars"
    type:number
    value_format: "$#,###"
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        , 0.70
      )
    ;;
  }

  measure: mtx_purchase_dollars_10 {
    label: "10th Percentile"
    group_label: "IAP Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.mtx_purchase_dollars ;;
    value_format_name: usd
  }
  measure: mtx_purchase_dollars_25 {
    label: "25th Percentile"
    group_label: "IAP Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.mtx_purchase_dollars ;;
    value_format_name: usd
  }
  measure: mtx_purchase_dollars_50 {
    label: "Median"
    group_label: "IAP Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.mtx_purchase_dollars ;;
    value_format_name: usd
  }
  measure: mtx_purchase_dollars_75 {
    label: "75th Percentile"
    group_label: "IAP Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.mtx_purchase_dollars ;;
    value_format_name: usd
  }
  measure: mtx_purchase_dollars_95 {
    label: "95th Percentile"
    group_label: "IAP Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.mtx_purchase_dollars ;;
    value_format_name: usd
  }
  measure: sum_ad_view_dollars {
    label: "IAA Dollars"
    group_label: "IAA Dollars"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.ad_view_dollars ;;
  }

  measure: sum_ad_dollars_non_banner {
    label: "IAA Dollars (Non-Banner)"
    group_label: "IAA Dollars (Non-Banner)"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.ad_dollars_non_banner ;;
  }

  measure: sum_ad_view_dollars_startup_interstitial {
    label: "IAA Dollars - Startup Interstitial"
    group_label: "IAA Dollars"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.ad_dollars_startup_interstitial ;;
  }

  measure: ad_view_dollars_10 {
    label: "10th Percentile"
    group_label: "IAA Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_25 {
    label: "25th Percentile"
    group_label: "IAA Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_50 {
    label: "Median"
    group_label: "IAA Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_75 {
    label: "75th Percentile"
    group_label: "IAA Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_95 {
    label: "95th Percentile"
    group_label: "IAA Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: sum_mtx_ltv_from_data {
    label: "Sum IAP LTV"
    group_label: "IAP LTV (From Data)"
    type:sum
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_10 {
    label: "10th Percentile"
    group_label: "IAP LTV (From Data)"
    type: percentile
    percentile: 10
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_25 {
    label: "25th Percentile"
    group_label: "IAP LTV (From Data)"
    type: percentile
    percentile: 25
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_50 {
    label: "Median"
    group_label: "IAP LTV (From Data)"
    type: percentile
    percentile: 50
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_75 {
    label: "75th Percentile"
    group_label: "IAP LTV (From Data)"
    type: percentile
    percentile: 75
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_95 {
    label: "95th Percentile"
    group_label: "IAP LTV (From Data)"
    type: percentile
    percentile: 95
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }

  measure: sum_ad_views {
    label: "IAA Views"
    group_label: "IAA Views"
    type:sum
    sql: ${TABLE}.ad_views ;;
  }

  measure: sum_ad_views_non_banner {
    label: "IAA Views - Non-Banner"
    group_label: "IAA Views - Non-Banner"
    type:sum
    sql: ${TABLE}.ad_views_non_banner ;;
  }

  measure: sum_ad_views_startup_interstitial {
    label: "IAA Views - Startup Interstitial"
    group_label: "IAA Views"
    type:sum
    sql: ${TABLE}.ad_views_startup_interstitial ;;
  }

  measure: ad_views_per_dau {
    label: "Average % of DAU Viewing Ads"
    group_label: "IAA Views"
    type: number
    value_format_name: percent_0
    sql:
      safe_divide(
        sum( case when ${TABLE}.ad_views > 0 then 1 else 0 end )
        ,
        sum( ${TABLE}.count_days_played)
        )
      ;;
  }

  measure: ad_views_per_dau_non_banner {
    label: "Average % of DAU Viewing Ads - Non-Banner"
    group_label: "IAA Views - Non-Banner"
    type: number
    value_format_name: percent_0
    sql:
      safe_divide(
        sum( case when ${TABLE}.ad_views_non_banner > 0 then 1 else 0 end )
        ,
        sum( ${TABLE}.count_days_played)
        )
      ;;
  }

  measure: ad_views_per_viewing_dau {
    label: "Average IAA Views Per Viewing DAU"
    group_label: "IAA Views"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum( ${TABLE}.ad_views )
        ,
        sum( case when ${TABLE}.ad_views > 0 then 1 else 0 end )
        )
      ;;
  }

  measure: ad_views_per_viewing_dau_non_banner {
    label: "Average IAA Views Per Viewing DAU - Non-Banner"
    group_label: "IAA Views - Non-Banner"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum( ${TABLE}.ad_views_non_banner )
        ,
        sum( case when ${TABLE}.ad_views > 0 then 1 else 0 end )
        )
      ;;
  }

  measure: ad_views_per_dau_actual {
    label: "Average IAA Views Per DAU"
    group_label: "IAA Views"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum( ${TABLE}.ad_views )
        ,
        sum( ${TABLE}.count_days_played)
        )
      ;;
  }

  measure: ad_views_per_dau_actual_non_banner {
    label: "Average IAA Views Per DAU - Non-Banner"
    group_label: "IAA Views - Non-Banner"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum( ${TABLE}.ad_views_non_banner )
        ,
        sum( ${TABLE}.count_days_played)
        )
      ;;
  }

  measure: ad_views_10 {
    label: "10th Percentile"
    group_label: "IAA Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_25 {
    label: "25th Percentile"
    group_label: "IAA Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_50 {
    label: "Median"
    group_label: "IAA Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_50_non_banner {
    label: "Median - Non-Banner"
    group_label: "IAA Views - Non-Banner"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_views_non_banner ;;
  }
  measure: ad_views_75 {
    label: "75th Percentile"
    group_label: "IAA Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_95 {
    label: "95th Percentile"
    group_label: "IAA Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_views ;;
  }

  measure: average_sessions_per_day {
    group_label: "Count Sessions"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.count_sessions)
        , sum(${TABLE}.count_days_played)
      )
      ;;
    value_format_name: decimal_1
  }

  measure: sum_count_sessions {
    group_label: "Count Sessions"
    type:sum
    sql: ${TABLE}.count_sessions ;;
  }

  measure: count_sessions_10 {
    group_label: "Count Sessions"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_sessions ;;
    value_format_name: decimal_0
  }
  measure: count_sessions_25 {
    group_label: "Count Sessions"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_sessions ;;
    value_format_name: decimal_0
  }
  measure: count_sessions_50 {
    group_label: "Count Sessions"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_sessions ;;
    value_format_name: decimal_0
  }
  measure: count_sessions_75 {
    group_label: "Count Sessions"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_sessions ;;
    value_format_name: decimal_0
  }
  measure: count_sessions_95 {
    group_label: "Count Sessions"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_sessions ;;
    value_format_name: decimal_0
  }

  measure: average_minutes_per_session {
    group_label: "Average Minutes Per Session"
    label: "Mean"
    type: number
    percentile: 10
    sql:
      safe_divide(
        sum( ${TABLE}.time_played_minutes )
        , sum( ${TABLE}.count_sessions )
      )
      ;;
    value_format_name: decimal_1
  }

  measure: minutes_per_session_10 {
    group_label: "Average Minutes Per Session"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql:
      safe_divide(
        ${TABLE}.time_played_minutes
        , ${TABLE}.count_sessions
      )
      ;;
    value_format_name: decimal_0
  }

  measure: minutes_per_session_25 {
    group_label: "Average Minutes Per Session"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql:
      safe_divide(
        ${TABLE}.time_played_minutes
        , ${TABLE}.count_sessions
      )
      ;;
    value_format_name: decimal_0
  }

  measure: minutes_per_session_50 {
    group_label: "Average Minutes Per Session"
    label: "Median"
    type: percentile
    percentile: 50
    sql:
      safe_divide(
        ${TABLE}.time_played_minutes
        , ${TABLE}.count_sessions
      )
      ;;
    value_format_name: decimal_0
  }

  measure: minutes_per_session_75 {
    group_label: "Average Minutes Per Session"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql:
      safe_divide(
        ${TABLE}.time_played_minutes
        , ${TABLE}.count_sessions
      )
      ;;
    value_format_name: decimal_0
  }

  measure: minutes_per_session_95 {
    group_label: "Average Minutes Per Session"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql:
      safe_divide(
        ${TABLE}.time_played_minutes
        , ${TABLE}.count_sessions
      )
      ;;
    value_format_name: decimal_0
  }





  measure: sum_cumulative_session_count {
    group_label: "Cumulative Session Count"
    type:sum
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_10 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_25 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_50 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_75 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_95 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: sum_cumulative_engagement_ticks {
    group_label: "Cumulative Engagement Ticks"
    type:sum
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_10 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_25 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_50 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_75 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_95 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: sum_round_start_events {
    group_label: "Round Start Events"
    type:sum
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_10 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_25 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_50 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_75 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_95 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_start_events ;;
  }
  measure: sum_round_end_events {
    group_label: "Round End Events"
    type:sum
    sql: ${TABLE}.round_end_events ;;
  }

  measure: round_end_events_per_day {
    label: "Average Round Events Per Day"
    group_label: "Round End Events"
    type:number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.round_end_events)
        ,
        sum(${TABLE}.count_days_played)
        )
        ;;
  }

  measure: round_end_events_10 {
    group_label: "Round End Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_25 {
    group_label: "Round End Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_50 {
    group_label: "Round End Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_75 {
    group_label: "Round End Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_95 {
    group_label: "Round End Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events ;;
  }
  measure: sum_lowest_last_level_serial {
    group_label: "Lowest Last Level Serial"
    type:sum
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_10 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 10
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_25 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 25
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_50 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 50
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_75 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 75
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_95 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 95
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: sum_highest_last_level_serial {
    group_label: "Highest Last Level Serial"
    type:sum
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_10 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 10
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_25 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 25
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_50 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 50
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_75 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 75
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_95 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 95
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: sum_highest_quests_completed {
    group_label: "Highest Quests Completed"
    type:sum
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_10 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 10
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_25 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 25
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_50 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 50
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_75 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 75
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_95 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 95
    sql: ${TABLE}.highest_quests_completed ;;
  }

  measure: sum_coins_spend {
    group_label: "Coins Spend"
    type:sum
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_10 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_25 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_50 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_75 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_95 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coins_spend ;;
  }
  measure: sum_stars_spend {
    group_label: "Stars Spend"
    type:sum
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_10 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_25 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_50 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_75 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_95 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.stars_spend ;;
  }

  measure: sum_ending_coins_balance {
    group_label: "Ending Coins Balance"
    type:sum
    sql: ${TABLE}.ending_coins_balance ;;
  }

  measure: ending_coins_balance_10 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_25 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_50 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_75 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_95 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_coins_balance ;;
  }

  ## Ending Ticket Balance
  measure: ending_ticket_balance_10 {
    label: "10th Percentile"
    group_label: "Ending Ticket Balance"
    type: percentile
    percentile: 10
    value_format_name: decimal_0
    sql: ${TABLE}.ending_ticket_balance ;;
  }
  measure: ending_ticket_balance_25 {
    label: "25th Percentile"
    group_label: "Ending Ticket Balance"
    type: percentile
    percentile: 25
    value_format_name: decimal_0
    sql: ${TABLE}.ending_ticket_balance ;;
  }
  measure: ending_ticket_balance_50 {
    label: "Median"
    group_label: "Ending Ticket Balance"
    type: percentile
    percentile: 50
    value_format_name: decimal_0
    sql: ${TABLE}.ending_ticket_balance ;;
  }
  measure: ending_ticket_balance_75 {
    label: "75th Percentile"
    group_label: "Ending Ticket Balance"
    type: percentile
    percentile: 75
    value_format_name: decimal_0
    sql: ${TABLE}.ending_ticket_balance ;;
  }
  measure: ending_ticket_balance_95 {
    label: "95th Percentile"
    group_label: "Ending Ticket Balance"
    type: percentile
    percentile: 95
    value_format_name: decimal_0
    sql: ${TABLE}.ending_ticket_balance ;;
  }

  ## Secret Eggs Balance
  dimension: secret_eggs {type:number}

  measure: secret_eggs_10 {
    label: "10th Percentile"
    group_label: "Secret Eggs Balance"
    type: percentile
    percentile: 10
    value_format_name: decimal_0
    sql: ${TABLE}.secret_eggs ;;
  }
  measure: secret_eggs_25 {
    label: "25th Percentile"
    group_label: "Secret Eggs Balance"
    type: percentile
    percentile: 25
    value_format_name: decimal_0
    sql: ${TABLE}.secret_eggs ;;
  }
  measure: secret_eggs_50 {
    label: "Median"
    group_label: "Secret Eggs Balance"
    type: percentile
    percentile: 50
    value_format_name: decimal_0
    sql: ${TABLE}.secret_eggs ;;
  }
  measure: secret_eggs_75 {
    label: "75th Percentile"
    group_label: "Secret Eggs Balance"
    type: percentile
    percentile: 75
    value_format_name: decimal_0
    sql: ${TABLE}.secret_eggs ;;
  }
  measure: secret_eggs_95 {
    label: "95th Percentile"
    group_label: "Secret Eggs Balance"
    type: percentile
    percentile: 95
    value_format_name: decimal_0
    sql: ${TABLE}.secret_eggs ;;
  }

  ## Ending Dice Balance
  measure: ending_dice_balance_10 {
    label: "10th Percentile"
    group_label: "Ending Dice Balance"
    type: percentile
    percentile: 10
    value_format_name: decimal_0
    sql: ${TABLE}.ending_dice_balance ;;
  }
  measure: ending_dice_balance_25 {
    label: "25th Percentile"
    group_label: "Ending Dice Balance"
    type: percentile
    percentile: 25
    value_format_name: decimal_0
    sql: ${TABLE}.ending_dice_balance ;;
  }
  measure: ending_dice_balance_50 {
    label: "Median"
    group_label: "Ending Dice Balance"
    type: percentile
    percentile: 50
    value_format_name: decimal_0
    sql: ${TABLE}.ending_dice_balance ;;
  }
  measure: ending_dice_balance_75 {
    label: "75th Percentile"
    group_label: "Ending Dice Balance"
    type: percentile
    percentile: 75
    value_format_name: decimal_0
    sql: ${TABLE}.ending_dice_balance ;;
  }
  measure: ending_dice_balance_95 {
    label: "95th Percentile"
    group_label: "Ending Dice Balance"
    type: percentile
    percentile: 95
    value_format_name: decimal_0
    sql: ${TABLE}.ending_dice_balance ;;
  }


  measure: sum_ending_lives_balance {
    group_label: "Ending Lives Balance"
    type:sum
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_10 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_25 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_50 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_75 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_95 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: sum_ending_stars_balance {
    label: "Sum"
    group_label: "Ending Stars Balance"
    type:sum
    value_format_name: decimal_0
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: mean_ending_stars_balance {
    label: "Mean"
    group_label: "Ending Stars Balance"
    type:number
    value_format_name: decimal_1
    sql:
    safe_divide(
      sum( case when ${TABLE}.ending_stars_balance > 10000 then null else ${TABLE}.ending_stars_balance end )
      , sum( case when ${TABLE}.ending_stars_balance > 10000 then null else 1 end )
    )
    ;;
  }
  measure: ending_stars_balance_10 {
    label: "10th Percentile"
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 10
    value_format_name: decimal_0
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_25 {
    label: "25th Percentile"
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 25
    value_format_name: decimal_0
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_50 {
    label: "Median"
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 50
    value_format_name: decimal_0
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_75 {
    label: "75th Percentile"
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 75
    value_format_name: decimal_0
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_95 {
    label: "95th Percentile"
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 95
    value_format_name: decimal_0
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: sum_days_since_created {
    group_label: "Days Since Created"
    type:sum
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_10 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 10
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_25 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 25
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_50 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 50
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_75 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 75
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_95 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 95
    sql: ${TABLE}.days_since_created ;;
  }
  measure: sum_day_number {
    group_label: "Day Number"
    type:sum
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_10 {
    group_label: "Day Number"
    type: percentile
    percentile: 10
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_25 {
    group_label: "Day Number"
    type: percentile
    percentile: 25
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_50 {
    group_label: "Day Number"
    type: percentile
    percentile: 50
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_75 {
    group_label: "Day Number"
    type: percentile
    percentile: 75
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_95 {
    group_label: "Day Number"
    type: percentile
    percentile: 95
    sql: ${TABLE}.day_number ;;
  }
  measure: sum_new_player_indicator {
    group_label: "New Player Indicator"
    type:sum
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_10 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_25 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_50 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_75 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_95 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.new_player_indicator ;;
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
  measure: sum_cumulative_mtx_purchase_dollars {
    label: "Sum Cumulative IAP Dollars"
    group_label: "Cumulative IAP Dollars"
    type:sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_10 {
    label: "10th Percentile"
    group_label: "Cumulative IAP Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_25 {
    label: "25th Percentile"
    group_label: "Cumulative IAP Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_50 {
    label: "Median"
    group_label: "Cumulative IAP Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_75 {
    label: "75th Percentile"
    group_label: "Cumulative IAP Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_95 {
    label: "95th Percentile"
    group_label: "Cumulative IAP Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: sum_cumulative_ad_view_dollars {
    label: "Sum Cumulative IAA Dollars"
    group_label: "Cumulative IAA Dollars"
    type:sum
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_10 {
    label: "10th Percentile"
    group_label: "Cumulative IAA Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_25 {
    label: "25th Percentile"
    group_label: "Cumulative IAA Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_50 {
    label: "Median"
    group_label: "Cumulative IAA Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_75 {
    label: "75th Percentile"
    group_label: "Cumulative IAA Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_95 {
    label: "95th Percentile"
    group_label: "Cumulative IAA Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: sum_combined_dollars {
    group_label: "Combined Dollars"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_10 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_25 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_50 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_75 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_95 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: sum_cumulative_combined_dollars {
    group_label: "Cumulative Combined Dollars"
    type:sum
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_10 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_25 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_50 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_75 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_95 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }

  measure: sum_daily_mtx_spend_indicator {
    label: "Sum Daily IAP Spend Indicator"
    type: sum
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }

  measure: sum_first_mtx_spend_indicator {
    label: "Sum First IAP Spend Indicator"
    type:sum
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }

  measure: sum_lifetime_mtx_spend_indicator {
    label: "Sum Lifetime IAP Spend Indicator"
    type:sum
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }

  measure: sum_cumulative_ad_views {
    label: "Sum Cumulative IAA Views"
    group_label: "Cumulative IAA Views"
    type:sum
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_10 {
    label: "10th Percentile"
    group_label: "Cumulative IAA Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_25 {
    label: "25th Percentile"
    group_label: "Cumulative IAA Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_50 {
    label: "Median"
    group_label: "Cumulative IAA Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_75 {
    label: "75th Percentile"
    group_label: "Cumulative IAA Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_95 {
    label: "95th Percentile"
    group_label: "Cumulative IAA Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_views ;;
  }

  measure: sum_cumulative_ad_views_non_banner {
    label: "Sum Cumulative IAA Views (Non-Banner)"
    group_label: "Cumulative IAA Views (Non-Banner)"
    type:sum
    sql: ${TABLE}.cumulative_ad_views_non_banner ;;
  }
  measure: cumulative_ad_views_10_non_banner {
    label: "10th Percentile (Non-Banner)"
   group_label: "Cumulative IAA Views (Non-Banner)"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_views_non_banner ;;
  }
  measure: cumulative_ad_views_25_non_banner {
    label: "25th Percentile (Non-Banner)"
    group_label: "Cumulative IAA Views (Non-Banner)"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_views_non_banner ;;
  }
  measure: cumulative_ad_views_50_non_banner {
    label: "Median (Non-Banner)"
    group_label: "Cumulative IAA Views (Non-Banner)"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_views_non_banner ;;
  }
  measure: cumulative_ad_views_75_non_banner {
    label: "75th Percentile (Non-Banner)"
    group_label: "Cumulative IAA Views (Non-Banner)"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_views_non_banner ;;
  }
  measure: cumulative_ad_views_95_non_banner {
    label: "95th Percentile (Non-Banner)"
    group_label: "Cumulative IAA Views (Non-Banner)"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_views_non_banner ;;
  }

  measure: sum_engagement_ticks {
    group_label: "Engagement Ticks"
    type:sum
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_10 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 10
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_25 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 25
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_50 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 50
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_75 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 75
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_95 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 95
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: sum_time_played_minutes {
    group_label: "Time Played Minutes"
    type:sum
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_10 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_25 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_50 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_75 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_95 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: sum_cumulative_time_played_minutes {
    group_label: "Cumulative Time Played Minutes"
    type:sum
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_10 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_25 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_50 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_75 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_95 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: sum_cumulative_round_start_events {
    group_label: "Cumulative Round Start Events"
    type:sum
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_10 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_25 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_50 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_75 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_95 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: sum_cumulative_round_end_events {
    group_label: "Cumulative Round End Events"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_10 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_25 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_50 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_75 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_95 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events ;;
  }

  measure: sum_count_days_played {
    group_label: "Count Days Played"
    type:sum
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_10 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_25 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_50 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_75 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_95 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_days_played ;;
  }
  measure: sum_cumulative_count_days_played {
    group_label: "Cumulative Count Days Played"
    type:sum
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_10 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_25 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_50 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_75 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_95 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: sum_levels_progressed {
    group_label: "Levels Progressed"
    type:sum
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_10 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 10
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_25 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 25
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_50 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 50
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_75 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 75
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_95 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 95
    sql: ${TABLE}.levels_progressed ;;
  }

  measure: sum_cumulative_coins_spend {
    group_label: "Cumulative Coins Spend"
    type:sum
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_10 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_25 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_50 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_75 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_95 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: sum_cumulative_star_spend {
    group_label: "Cumulative Star Spend"
    type:sum
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_10 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_25 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_50 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_75 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_95 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_star_spend ;;
  }

  measure: sum_round_end_events_campaign {
    group_label: "Round End Events Campaign"
    type:sum
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_10 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_25 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_50 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_75 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_95 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: sum_round_end_events_movesmaster {
    group_label: "Round End Events Movesmaster"
    type:sum
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_10 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_25 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_50 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_75 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_95 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: sum_round_end_events_puzzle {
    group_label: "Round End Events Puzzle"
    type:sum
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_10 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_25 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_50 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_75 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_95 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: sum_round_end_events_gemquest {
    group_label: "Round End Events Gem Quest"
    type:sum
    sql: ${TABLE}.round_end_events_gemquest ;;
  }
  measure: round_end_events_gemquest_10 {
    group_label: "Round End Events Gem Quest"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events_gemquest ;;
  }
  measure: round_end_events_gemquest_25 {
    group_label: "Round End Events Gem Quest"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events_gemquest ;;
  }
  measure: round_end_events_gemquest_50 {
    group_label: "Round End Events Gem Quest"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events_gemquest ;;
  }
  measure: round_end_events_gemquest_75 {
    group_label: "Round End Events Gem Quest"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events_gemquest ;;
  }
  measure: round_end_events_gemquest_95 {
    group_label: "Round End Events Gem Quest"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events_gemquest ;;
  }
  measure: sum_round_time_in_minutes {
    group_label: "Round Time In Minutes"
    type:sum
    sql: ${TABLE}.round_time_in_minutes ;;
  }

  measure: average_round_time_per_session {
    label: "Average Round Minutes Per Session"
    group_label: "Round Time In Minutes"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.round_time_in_minutes)
        ,
        sum(${TABLE}.count_sessions)
        )
    ;;
  }

  measure: round_time_in_minutes_10 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_25 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_50 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_75 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_95 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: sum_round_time_in_minutes_campaign {
    group_label: "Round Time In Minutes Campaign"
    type:sum
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_10 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_25 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_50 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_75 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_95 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: sum_round_time_in_minutes_movesmaster {
    group_label: "Round Time In Minutes Movesmaster"
    type:sum
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_10 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_25 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_50 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_75 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_95 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: sum_round_time_in_minutes_puzzle {
    group_label: "Round Time In Minutes Puzzle"
    type:sum
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_10 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_25 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_50 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_75 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_95 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: sum_cumulative_round_end_events_campaign {
    group_label: "Cumulative Round End Events Campaign"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_10 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_25 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_50 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_75 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_95 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: sum_cumulative_round_end_events_movesmaster {
    group_label: "Cumulative Round End Events Movesmaster"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_10 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_25 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_50 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_75 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_95 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: sum_cumulative_round_end_events_puzzle {
    group_label: "Cumulative Round End Events Puzzle"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_10 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_25 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_50 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_75 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_95 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: sum_cumulative_round_time_in_minutes {
    group_label: "Cumulative Round Time In Minutes"
    type:sum
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_10 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_25 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_50 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_75 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_95 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: sum_cumulative_round_time_in_minutes_campaign {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type:sum
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_10 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_25 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_50 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_75 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_95 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: sum_cumulative_round_time_in_minutes_movesmaster {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type:sum
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_10 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_25 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_50 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_75 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_95 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: sum_cumulative_round_time_in_minutes_puzzle {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type:sum
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_10 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_25 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_50 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_75 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_95 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }

  ###############################################################
  ## Load Times
  ###############################################################

  measure: average_load_time_all_10 {
    group_label: "Load Times"
    type: percentile
    percentile: 10
    sql: ${TABLE}.average_load_time_all ;;
  }

  measure: average_load_time_all_25 {
    group_label: "Load Times"
    type: percentile
    percentile: 25
    sql: ${TABLE}.average_load_time_all ;;
  }

  measure: average_load_time_all_50 {
    group_label: "Load Times"
    type: percentile
    percentile: 50
    sql: ${TABLE}.average_load_time_all ;;
  }

  measure: average_load_time_all_75 {
    group_label: "Load Times"
    type: percentile
    percentile: 75
    sql: ${TABLE}.average_load_time_all ;;
  }

  measure: average_load_time_all_95 {
    group_label: "Load Times"
    type: percentile
    percentile: 95
    sql: ${TABLE}.average_load_time_all ;;
  }

  measure: average_load_time_from_title_scene_10 {
    group_label: "Load Times"
    type: percentile
    percentile: 10
    sql: ${TABLE}.average_load_time_from_title_scene ;;
  }

  measure: average_load_time_from_title_scene_25 {
    group_label: "Load Times"
    type: percentile
    percentile: 25
    sql: ${TABLE}.average_load_time_from_title_scene ;;
  }

  measure: average_load_time_from_title_scene_50 {
    group_label: "Load Times"
    type: percentile
    percentile: 50
    sql: ${TABLE}.average_load_time_from_title_scene ;;
  }

  measure: average_load_time_from_title_scene_75 {
    group_label: "Load Times"
    type: percentile
    percentile: 75
    sql: ${TABLE}.average_load_time_from_title_scene ;;
  }

  measure: average_load_time_from_title_scene_95 {
    group_label: "Load Times"
    type: percentile
    percentile: 95
    sql: ${TABLE}.average_load_time_from_title_scene ;;
  }

  measure: average_load_time_from_meta_scene_10 {
    group_label: "Load Times"
    type: percentile
    percentile: 10
    sql: ${TABLE}.average_load_time_from_meta_scene ;;
  }

  measure: average_load_time_from_meta_scene_25 {
    group_label: "Load Times"
    type: percentile
    percentile: 25
    sql: ${TABLE}.average_load_time_from_meta_scene ;;
  }

  measure: average_load_time_from_meta_scene_50 {
    group_label: "Load Times"
    type: percentile
    percentile: 50
    sql: ${TABLE}.average_load_time_from_meta_scene ;;
  }

  measure: average_load_time_from_meta_scene_75 {
    group_label: "Load Times"
    type: percentile
    percentile: 75
    sql: ${TABLE}.average_load_time_from_meta_scene ;;
  }

  measure: average_load_time_from_meta_scene_95 {
    group_label: "Load Times"
    type: percentile
    percentile: 95
    sql: ${TABLE}.average_load_time_from_meta_scene ;;
  }

    measure: average_load_time_from_game_scene_10 {
      group_label: "Load Times"
      type: percentile
      percentile: 10
      sql: ${TABLE}.average_load_time_from_game_scene ;;
    }

    measure: average_load_time_from_game_scene_25 {
      group_label: "Load Times"
      type: percentile
      percentile: 25
      sql: ${TABLE}.average_load_time_from_game_scene ;;
    }

    measure: average_load_time_from_game_scene_50 {
      group_label: "Load Times"
      type: percentile
      percentile: 50
      sql: ${TABLE}.average_load_time_from_game_scene ;;
    }

    measure: average_load_time_from_game_scene_75 {
      group_label: "Load Times"
      type: percentile
      percentile: 75
      sql: ${TABLE}.average_load_time_from_game_scene ;;
    }

    measure: average_load_time_from_game_scene_95 {
      group_label: "Load Times"
      type: percentile
      percentile: 95
      sql: ${TABLE}.average_load_time_from_game_scene ;;
    }

  measure: average_load_time_from_app_start_10 {
    group_label: "Load Times"
    type: percentile
    percentile: 10
    sql: ${TABLE}.average_load_time_from_app_start ;;
  }

  measure: average_load_time_from_app_start_25 {
    group_label: "Load Times"
    type: percentile
    percentile: 25
    sql: ${TABLE}.average_load_time_from_app_start ;;
  }

  measure: average_load_time_from_app_start_50 {
    group_label: "Load Times"
    type: percentile
    percentile: 50
    sql: ${TABLE}.average_load_time_from_app_start ;;
  }

  measure: average_load_time_from_app_start_75 {
    group_label: "Load Times"
    type: percentile
    percentile: 75
    sql: ${TABLE}.average_load_time_from_app_start ;;
  }

  measure: average_load_time_from_app_start_95 {
    group_label: "Load Times"
    type: percentile
    percentile: 95
    sql: ${TABLE}.average_load_time_from_app_start ;;
  }

    measure: average_asset_load_time_10 {
      group_label: "Load Times"
      type: percentile
      percentile: 10
      sql: ${TABLE}.average_asset_load_time ;;
    }


    measure: average_asset_load_time_25 {
      group_label: "Load Times"
      type: percentile
      percentile: 25
      sql: ${TABLE}.average_asset_load_time ;;
    }


    measure: average_asset_load_time_50 {
      group_label: "Load Times"
      type: percentile
      percentile: 50
      sql: ${TABLE}.average_asset_load_time ;;
    }


    measure: average_asset_load_time_75 {
      group_label: "Load Times"
      type: percentile
      percentile: 75
      sql: ${TABLE}.average_asset_load_time ;;
    }


    measure: average_asset_load_time_95 {
      group_label: "Load Times"
      type: percentile
      percentile: 95
      sql: ${TABLE}.average_asset_load_time ;;
    }

  measure: coin_spend_per_round_10 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 10
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: coin_spend_per_round_25 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 25
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: coin_spend_per_round_50 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 50
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: coin_spend_per_round_75 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 75
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: coin_spend_per_round_95 {
    group_label: "Coin Spend Per Round"
    type: percentile
    percentile: 95
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_spend , ${TABLE}.round_end_events )  ;;
  }

  measure: sum_coins_sourced_from_rewards {
    group_label: "Coins Sourced From Rewards"
    type:sum
    sql: ${TABLE}.coins_sourced_from_rewards ;;
  }

  measure: coins_sourced_from_rewards_per_dau {
    label: "Average Coins Sourced From Rewards Per DAU"
    group_label: "Coins Sourced From Rewards"
    type: number
    value_format_name: decimal_0
    sql:
      safe_divide(
        sum( ${TABLE}.coins_sourced_from_rewards )
        , sum(${TABLE}.count_days_played)
        )
        ;;
  }

  measure: cumulative_coins_sourced_from_rewards_10 {
    group_label: "Coins Sourced From Rewards"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_sourced_from_rewards ;;
  }
  measure: coins_sourced_from_rewards_25 {
    group_label: "Coins Sourced From Rewards"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_sourced_from_rewards ;;
  }
  measure: coins_sourced_from_rewards_50 {
    group_label: "Coins Sourced From Rewards"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_sourced_from_rewards ;;
  }
  measure: coins_sourced_from_rewards_75 {
    group_label: "Coins Sourced From Rewards"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_sourced_from_rewards ;;
  }
  measure: coins_sourced_from_rewards_95 {
    group_label: "Coins Sourced From Rewards"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coins_sourced_from_rewards ;;
  }

  measure: coins_sourced_per_round_10 {
    group_label: "Coin Source Per Round"
    type: percentile
    percentile: 10
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_sourced_from_rewards , ${TABLE}.round_end_events )  ;;
  }

  measure: coins_sourced_per_round_25 {
    group_label: "Coin Source Per Round"
    type: percentile
    percentile: 25
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_sourced_from_rewards , ${TABLE}.round_end_events )  ;;
  }

  measure: coins_sourced_per_round_50 {
    group_label: "Coin Source Per Round"
    type: percentile
    percentile: 50
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_sourced_from_rewards , ${TABLE}.round_end_events )  ;;
  }

  measure: coins_sourced_per_round_75 {
    group_label: "Coin Source Per Round"
    type: percentile
    percentile: 75
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_sourced_from_rewards , ${TABLE}.round_end_events )  ;;
  }

  measure: coins_sourced_per_round_95 {
    group_label: "Coin Source Per Round"
    type: percentile
    percentile: 95
    value_format_name: decimal_0
    sql: safe_divide( ${TABLE}.coins_sourced_from_rewards , ${TABLE}.round_end_events )  ;;
  }

  measure: average_power_up_balance {
    type: number
    label: "Average Pre-Game Power Up Balance"
    group_label: "Power Up Balances"
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(
          ifnull(${TABLE}.ending_balance_rocket,0)
          + ifnull(${TABLE}.ending_balance_bomb,0)
          + ifnull(${TABLE}.ending_balance_color_ball,0)
          )
        ,
        sum(
          ${TABLE}.count_days_played
          )
      )
    ;;
  }

  measure: sum_ending_balance_rocket {
    group_label: "Ending Balance Rocket"
    type:sum
    sql: ${TABLE}.ending_balance_rocket ;;
  }
  measure: ending_balance_rocket_10 {
    group_label: "Ending Balance Rocket"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_rocket ;;
  }
  measure: ending_balance_rocket_25 {
    group_label: "Ending Balance Rocket"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_rocket ;;
  }
  measure: ending_balance_rocket_50 {
    group_label: "Ending Balance Rocket"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_rocket ;;
  }
  measure: ending_balance_rocket_75 {
    group_label: "Ending Balance Rocket"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_rocket ;;
  }
  measure: ending_balance_rocket_95 {
    group_label: "Ending Balance Rocket"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_rocket ;;
  }
  measure: sum_ending_balance_bomb {
    group_label: "Ending Balance Bomb"
    type:sum
    sql: ${TABLE}.ending_balance_bomb ;;
  }
  measure: ending_balance_bomb_10 {
    group_label: "Ending Balance Bomb"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_bomb ;;
  }
  measure: ending_balance_bomb_25 {
    group_label: "Ending Balance Bomb"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_bomb ;;
  }
  measure: ending_balance_bomb_50 {
    group_label: "Ending Balance Bomb"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_bomb ;;
  }
  measure: ending_balance_bomb_75 {
    group_label: "Ending Balance Bomb"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_bomb ;;
  }
  measure: ending_balance_bomb_95 {
    group_label: "Ending Balance Bomb"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_bomb ;;
  }

  measure: ending_balance_bomb_99 {
    group_label: "Ending Balance Bomb"
    type: percentile
    percentile: 99
    sql: ${TABLE}.ending_balance_bomb ;;
  }

  measure: sum_ending_balance_color_ball {
    group_label: "Ending Balance Color Ball"
    type:sum
    sql: ${TABLE}.ending_balance_color_ball ;;
  }
  measure: ending_balance_color_ball_10 {
    group_label: "Ending Balance Color Ball"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_color_ball ;;
  }
  measure: ending_balance_color_ball_25 {
    group_label: "Ending Balance Color Ball"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_color_ball ;;
  }
  measure: ending_balance_color_ball_50 {
    group_label: "Ending Balance Color Ball"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_color_ball ;;
  }
  measure: ending_balance_color_ball_75 {
    group_label: "Ending Balance Color Ball"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_color_ball ;;
  }
  measure: ending_balance_color_ball_95 {
    group_label: "Ending Balance Color Ball"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_color_ball ;;
  }
  measure: sum_ending_balance_clear_cell {
    group_label: "Ending Balance Clear Cell"
    type:sum
    sql: ${TABLE}.ending_balance_clear_cell ;;
  }
  measure: ending_balance_clear_cell_10 {
    group_label: "Ending Balance Clear Cell"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_clear_cell ;;
  }
  measure: ending_balance_clear_cell_25 {
    group_label: "Ending Balance Clear Cell"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_clear_cell ;;
  }
  measure: ending_balance_clear_cell_50 {
    group_label: "Ending Balance Clear Cell"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_clear_cell ;;
  }
  measure: ending_balance_clear_cell_75 {
    group_label: "Ending Balance Clear Cell"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_clear_cell ;;
  }
  measure: ending_balance_clear_cell_95 {
    group_label: "Ending Balance Clear Cell"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_clear_cell ;;
  }
  measure: sum_ending_balance_clear_horizontal {
    group_label: "Ending Balance Clear Horizontal"
    type:sum
    sql: ${TABLE}.ending_balance_clear_horizontal ;;
  }
  measure: ending_balance_clear_horizontal_10 {
    group_label: "Ending Balance Clear Horizontal"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_clear_horizontal ;;
  }
  measure: ending_balance_clear_horizontal_25 {
    group_label: "Ending Balance Clear Horizontal"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_clear_horizontal ;;
  }
  measure: ending_balance_clear_horizontal_50 {
    group_label: "Ending Balance Clear Horizontal"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_clear_horizontal ;;
  }
  measure: ending_balance_clear_horizontal_75 {
    group_label: "Ending Balance Clear Horizontal"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_clear_horizontal ;;
  }
  measure: ending_balance_clear_horizontal_95 {
    group_label: "Ending Balance Clear Horizontal"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_clear_horizontal ;;
  }
  measure: sum_ending_balance_clear_vertical {
    group_label: "Ending Balance Clear Vertical"
    type:sum
    sql: ${TABLE}.ending_balance_clear_vertical ;;
  }
  measure: ending_balance_clear_vertical_10 {
    group_label: "Ending Balance Clear Vertical"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_clear_vertical ;;
  }
  measure: ending_balance_clear_vertical_25 {
    group_label: "Ending Balance Clear Vertical"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_clear_vertical ;;
  }
  measure: ending_balance_clear_vertical_50 {
    group_label: "Ending Balance Clear Vertical"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_clear_vertical ;;
  }
  measure: ending_balance_clear_vertical_75 {
    group_label: "Ending Balance Clear Vertical"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_clear_vertical ;;
  }
  measure: ending_balance_clear_vertical_95 {
    group_label: "Ending Balance Clear Vertical"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_clear_vertical ;;
  }
  measure: sum_ending_balance_shuffle {
    group_label: "Ending Balance Shuffle"
    type:sum
    sql: ${TABLE}.ending_balance_shuffle ;;
  }
  measure: ending_balance_shuffle_10 {
    group_label: "Ending Balance Shuffle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_shuffle ;;
  }
  measure: ending_balance_shuffle_25 {
    group_label: "Ending Balance Shuffle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_shuffle ;;
  }
  measure: ending_balance_shuffle_50 {
    group_label: "Ending Balance Shuffle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_shuffle ;;
  }
  measure: ending_balance_shuffle_75 {
    group_label: "Ending Balance Shuffle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_shuffle ;;
  }
  measure: ending_balance_shuffle_95 {
    group_label: "Ending Balance Shuffle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_shuffle ;;
  }
  measure: sum_ending_balance_chopsticks {
    group_label: "Ending Balance Chopsticks"
    type:sum
    sql: ${TABLE}.ending_balance_chopsticks ;;
  }
  measure: ending_balance_chopsticks_10 {
    group_label: "Ending Balance Chopsticks"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_chopsticks ;;
  }
  measure: ending_balance_chopsticks_25 {
    group_label: "Ending Balance Chopsticks"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_chopsticks ;;
  }
  measure: ending_balance_chopsticks_50 {
    group_label: "Ending Balance Chopsticks"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_chopsticks ;;
  }
  measure: ending_balance_chopsticks_75 {
    group_label: "Ending Balance Chopsticks"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_chopsticks ;;
  }
  measure: ending_balance_chopsticks_95 {
    group_label: "Ending Balance Chopsticks"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_chopsticks ;;
  }
  measure: sum_ending_balance_skillet {
    group_label: "Ending Balance Skillet"
    type:sum
    sql: ${TABLE}.ending_balance_skillet ;;
  }
  measure: ending_balance_skillet_10 {
    group_label: "Ending Balance Skillet"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_balance_skillet ;;
  }
  measure: ending_balance_skillet_25 {
    group_label: "Ending Balance Skillet"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_balance_skillet ;;
  }
  measure: ending_balance_skillet_50 {
    group_label: "Ending Balance Skillet"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_balance_skillet ;;
  }
  measure: ending_balance_skillet_75 {
    group_label: "Ending Balance Skillet"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_balance_skillet ;;
  }
  measure: ending_balance_skillet_95 {
    group_label: "Ending Balance Skillet"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_balance_skillet ;;
  }

######################################################################################
## Daily Popup
######################################################################################

dimension: count_of_daily_popups_shown {
  label: "Count of Daily Popups Shown"
  group_label: "Daily Popup"
  type: number
  sql:
    ${TABLE}.popup_total
  ;;
}

  dimension: count_of_daily_popups_and_iams_shown {
    label: "Count of Daily Popups and IAMs Shown"
    type: number
    sql:
    ${TABLE}.popup_total + ${TABLE}.iam_total
  ;;
  }

  dimension: count_of_daily_popups_and_iams_shown_bin {
    label: "Count of Daily Popups and IAMs Shown (Bin)"
    type: string
    sql:
      case
        when ${TABLE}.popup_total + ${TABLE}.iam_total <= 0 then '00'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 1 then '01'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 2 then '02'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 3 then '03'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 4 then '04'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 5 then '05'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 6 then '06'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 7 then '07'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 8 then '08'
        when ${TABLE}.popup_total + ${TABLE}.iam_total = 9 then '09'
        else '10+'
        end
  ;;
  }



measure: count_daily_popup_BattlePass {
  label: "Count Daily Popups: BattlePass"
  group_label: "Daily Popup"
  type: number
  sql: sum( ${TABLE}.popup_battlepass )   ;;
  value_format_name: decimal_0
}

  measure: count_daily_popup_DailyReward {
    label: "Count Daily Popups: DailyReward"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_dailyreward )    ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_FlourFrenzy {
    label: "Count Daily Popups: FlourFrenzy"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_flourfrenzy )    ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_foodtruck {
    label: "Count Daily Popups: FoodTruck"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_foodtruck )    ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_GoFish {
    label: "Count Daily Popups: GoFish"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_gofish )    ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_HotdogContest {
    label: "Count Daily Popups: HotdogContest"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_hotdogcontest )    ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_LuckyDice {
    label: "Count Daily Popups: LuckyDice"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_luckydice )   ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_MovesMaster {
    label: "Count Daily Popups: MovesMaster"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_movesmaster )   ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_PizzaTime {
    label: "Count Daily Popups: PizzaTime"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_pizzatime )   ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_Puzzle {
    label: "Count Daily Popups: Puzzle"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_puzzle )   ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_TreasureTrove {
    label: "Count Daily Popups: TreasureTrove"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_treasuretrove )   ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_UpdateApp {
    label: "Count Daily Popups: UpdateApp"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_updateapp )   ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_CastleClimb {
    label: "Count Daily Popups: CastleClimb"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_castleclimb )   ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_GemQuest {
    label: "Count Daily Popups: GemQuest"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_gemquest )  ;;
    value_format_name: decimal_0
  }

  measure: count_daily_popup_DonutSprint {
    label: "Count Daily Popups: DonutSprint"
    group_label: "Daily Popup"
    type: number
    sql: sum( ${TABLE}.popup_donutsprint )  ;;
    value_format_name: decimal_0
  }


  ######################################################################################
  ## Popups/IAM Per DAU
  ## https://docs.google.com/spreadsheets/d/1Rchj0WMpqLQKI-1tMo2qFFii7HK0YoUdB-OXb_HIt7A/edit?usp=drive_link
  ######################################################################################

  measure: popup_iam_per_player_iam_ce {
    label: "IAM - Ce"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_ce ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_chameleon {
    label: "IAM - Chameleon"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_chameleon ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_generic {
    label: "IAM - Generic"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_generic ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_mtxoffer {
    label: "IAM - Mtxoffer"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_mtxoffer ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_mtxoffer_discounted {
    label: "IAM - Mtxoffer_Discounted"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_mtxoffer_discounted ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_mtxoffer_halloween {
    label: "IAM - Mtxoffer_Halloween"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_mtxoffer_halloween ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_mtxoffer_lemonade {
    label: "IAM - Mtxoffer_Lemonade"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_mtxoffer_lemonade ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_mtxoffer_spring {
    label: "IAM - Mtxoffer_Spring"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_mtxoffer_spring ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_mtxoffer_starteroffer {
    label: "IAM - Mtxoffer_Starteroffer"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_mtxoffer_starteroffer ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_namechange {
    label: "IAM - Namechange"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_namechange ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_notifications {
    label: "IAM - Notifications"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_notifications ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_rateus {
    label: "IAM - Rateus"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_rateus ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_showad {
    label: "IAM - Showad"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_showad ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_toaster {
    label: "IAM - Toaster"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_toaster ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_totd {
    label: "IAM - Totd"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_totd ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_battlepass {
    label: "Popup - Battlepass"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_battlepass ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_castleclimb {
    label: "Popup - Castleclimb"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_castleclimb ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_dailyreward {
    label: "Popup - Dailyreward"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_dailyreward ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_donutsprint {
    label: "Popup - Donutsprint"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_donutsprint ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_flourfrenzy {
    label: "Popup - Flourfrenzy"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_flourfrenzy ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_foodtruck {
    label: "Popup - Foodtruck"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_foodtruck ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_gemquest {
    label: "Popup - Gemquest"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_gemquest ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_gofish {
    label: "Popup - Gofish"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_gofish ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_hotdogcontest {
    label: "Popup - Hotdogcontest"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_hotdogcontest ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_luckydice {
    label: "Popup - Luckydice"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_luckydice ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_movesmaster {
    label: "Popup - Movesmaster"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_movesmaster ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_pizzatime {
    label: "Popup - Pizzatime"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_pizzatime ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_puzzle {
    label: "Popup - Puzzle"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_puzzle ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_treasuretrove {
    label: "Popup - Treasuretrove"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_treasuretrove ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_updateapp {
    label: "Popup - Updateapp"
    group_label: "Popup/IAM By Group per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_updateapp ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_total {
    label: "IAM - Total"
    group_label: "Popup/IAM Totals per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_total ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_total {
    label: "Popup - Total"
    group_label: "Popup/IAM Totals per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_total ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_destination_gamemode {
    label: "Popup - Gamemode"
    group_label: "Popup/IAM By Destination per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_destination_gamemode ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_destination_playeraction {
    label: "Popup - Playeraction"
    group_label: "Popup/IAM By Destination per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_destination_playeraction ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_popup_destination_reward {
    label: "Popup - Reward"
    group_label: "Popup/IAM By Destination per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.popup_destination_reward ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_destination_adview {
    label: "IAM - Adview"
    group_label: "Popup/IAM By Destination per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_destination_adview ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_destination_generic {
    label: "IAM - Generic"
    group_label: "Popup/IAM By Destination per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_destination_generic ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_destination_offer {
    label: "IAM - Offer"
    group_label: "Popup/IAM By Destination per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_destination_offer ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

  measure: popup_iam_per_player_iam_destination_playeraction {
    label: "IAM - Playeraction"
    group_label: "Popup/IAM By Destination per DAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum( ${TABLE}.iam_destination_playeraction ) , sum( ${TABLE}.count_days_played ) ) ;;
  }

# popup_battlepass
# iam_ce
# popup_castleclimb
# iam_chameleon
# popup_dailyreward
# popup_donutsprint
# popup_flourfrenzy
# popup_foodtruck
# popup_gemquest
# iam_generic
# popup_gofish
# popup_hotdogcontest
# popup_luckydice
# iam_mtxoffer
# iam_mtxoffer_discounted
# iam_mtxoffer_halloween
# iam_mtxoffer_lemonade
# iam_mtxoffer_spring
# iam_mtxoffer_starteroffer
# popup_movesmaster
# iam_namechange
# iam_notifications
# popup_pizzatime
# popup_puzzle
# iam_rateus
# iam_showad
# iam_totd
# iam_toaster
# popup_treasuretrove
# popup_updateapp
# iam_total
# popup_total
# iam_destination_adview
# popup_destination_gamemode
# iam_destination_generic
# iam_destination_offer
# popup_destination_playeraction
# iam_destination_playeraction
# popup_destination_reward

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

  measure: pregame_boost_rocket_per_dau {
    group_label: "Pre-Game Boosts"
    label: "Total Rockets Per DAU"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_rocket)
        , sum(${TABLE}.count_days_played)
      ) ;;
  }

  measure: sum_pregame_boost_bomb {
    group_label: "Pre-Game Boosts"
    label: "Total Bombs"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_bomb) ;;
  }

  measure: pregame_boost_bomb_per_dau {
    group_label: "Pre-Game Boosts"
    label: "Total Bombs Per DAU"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_bomb)
        , sum(${TABLE}.count_days_played)
      ) ;;
  }

  measure: sum_pregame_boost_colorball {
    group_label: "Pre-Game Boosts"
    label: "Total Colorballs"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_colorball) ;;
  }

  measure: pregame_boost_colorball_per_dau {
    group_label: "Pre-Game Boosts"
    label: "Total Colorballs Per DAU"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_colorball)
        , sum(${TABLE}.count_days_played)
      ) ;;
  }

  measure: sum_pregame_boost_extramoves {
    group_label: "Pre-Game Boosts"
    label: "Total ExtraMoves"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_extramoves) ;;
  }

  measure: pregame_boost_extramoves_per_dau {
    group_label: "Pre-Game Boosts"
    label: "Total ExtraMoves Per DAU"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_extramoves)
        , sum(${TABLE}.count_days_played)
      ) ;;
  }

  measure: sum_pregame_boost_total {
    group_label: "Pre-Game Boosts"
    label: "Total Boosts"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_total) ;;
  }

  measure: pregame_boost_total_per_dau {
    group_label: "Pre-Game Boosts"
    label: "Total Boosts Per DAU"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_total)
        , sum(${TABLE}.count_days_played)
      ) ;;
  }



}
