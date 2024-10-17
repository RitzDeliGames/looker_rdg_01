view: player_campaign_level_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-01-24'

      with

      ----------------------------------------------------------------
      -- campaign levels
      ----------------------------------------------------------------

      campaign_levels as (

      select
      rdg_id
      , level_serial

      -- Player Age Information
      , timestamp(date(min(created_at))) as created_date -- Created Date
      , date_diff(date(min(rdg_date)), date(min(created_at)), day) as days_since_created -- Days Since Created
      , 1 + date_diff(date(min(rdg_date)), date(min(created_at)), day) as day_number -- Player Day Number

      , min(round_start_cumulative_minutes) as min_round_start_cumulative_minutes
      , max(level_difficuly) as level_difficuly
      , min(level_id) as level_id
      , min(rdg_date) as first_played_rdg_date
      , max(rdg_date) as last_played_rdg_date
      , min(version) as min_version
      , max(version) as max_version
      , min(experiments) as experiments
      , sum(count_rounds) as count_rounds
      , sum(count_wins) as count_wins
      , sum(count_losses) as count_losses
      , sum(powerup_hammer) as powerup_hammer
      , sum(powerup_rolling_pin) as powerup_rolling_pin
      , sum(powerup_piping_bag) as powerup_piping_bag
      , sum(powerup_shuffle) as powerup_shuffle
      , sum(powerup_chopsticks) as powerup_chopsticks
      , sum(powerup_skillet) as powerup_skillet
      , sum(skill_disco) as skill_disco
      , sum(skill_moves) as skill_moves
      , sum(skill_drill) as skill_drill
      , sum(total_chum_powerups_used) as total_chum_powerups_used
      , sum(in_round_mtx_purchase_dollars) as  in_round_mtx_purchase_dollars
      , sum(in_round_count_mtx_purchases) as in_round_count_mtx_purchases
      , sum(in_round_ad_view_dollars) as in_round_ad_view_dollars
      , sum(in_round_count_ad_views) as in_round_count_ad_views
      , sum(in_round_coin_spend) as in_round_coin_spend
      , sum(in_round_count_coin_spend_events) as in_round_count_coin_spend_events
      , sum(in_round_combined_dollars) as in_round_combined_dollars
      , max(churn_indicator) as churn_indicator
      , max(churn_rdg_id) as churn_rdg_id
      , max(case when count_wins = 1 then moves_remaining else 0 end ) as moves_remaining_on_win

      -- pre game boosts
      , sum( pregame_boost_rocket ) as pregame_boost_rocket
      , sum( pregame_boost_bomb ) as pregame_boost_bomb
      , sum( pregame_boost_colorball ) as pregame_boost_colorball
      , sum( pregame_boost_extramoves ) as pregame_boost_extramoves
      , sum( pregame_boost_total ) as pregame_boost_total

      from
      -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary
      ${player_round_summary.SQL_TABLE_NAME}
      where
      game_mode = 'campaign'
      -- and date(rdg_date) = '2024-01-01'
      group by
      1,2

      )

      ----------------------------------------------------------------
      -- coin_spend
      ----------------------------------------------------------------

      , coin_spend_table as (

      select
      rdg_id
      , last_level_serial as level_serial
      , timestamp(date(min(created_at))) as created_date -- Created Date
      , date_diff(date(min(rdg_date)), date(min(created_at)), day) as days_since_created -- Days Since Created
      , 1 + date_diff(date(min(rdg_date)), date(min(created_at)), day) as day_number -- Player Day Number
      , min(rdg_date) as first_played_rdg_date
      , max(rdg_date) as last_played_rdg_date
      , min(version) as min_version
      , max(version) as max_version
      , min(experiments) as experiments
      , sum( coin_spend ) as coin_spend
      , sum( case when coin_spend_name_group = 'Extra Moves' then coin_spend else 0 end ) as coin_spend_extra_moves
      , sum( case when coin_spend_name_group = 'Food Truck' then coin_spend else 0 end ) as coin_spend_food_truck
      , sum( case when coin_spend_name_group = 'Chum Chum Skill' then coin_spend else 0 end ) as coin_spend_chum_chum_skill
      , sum( case when coin_spend_name_group = 'Boost' then coin_spend else 0 end ) as coin_spend_pre_game_boosts
      , sum( case when coin_spend_name_group = 'Lives' then coin_spend else 0 end ) as coin_spend_lives
      , sum( case when coin_spend_name_group = 'New Chum Chum' then coin_spend else 0 end ) as coin_spend_new_chum_chum
      , sum( case when coin_spend_name_group = 'Legacy' then coin_spend else 0 end ) as coin_spend_legacy
      , sum( case when coin_spend_name_group = 'Gem Quest' then coin_spend else 0 end ) as coin_spend_gem_quest
      from
      -- eraser-blast.looker_scratch.LR_6Y2JU1729203524061_player_coin_spend_summary
      ${player_coin_spend_summary.SQL_TABLE_NAME}
      -- where
      -- date(rdg_date) = '2024-01-01'
      group by
      1,2

      )

      ----------------------------------------------------------------
      -- mtx_purchases
      ----------------------------------------------------------------

      , mtx_purchases as (

      select
      rdg_id
      , last_level_serial as level_serial
      -- Player Age Information
      , timestamp(date(min(created_at))) as created_date -- Created Date
      , date_diff(date(min(rdg_date)), date(min(created_at)), day) as days_since_created -- Days Since Created
      , 1 + date_diff(date(min(rdg_date)), date(min(created_at)), day) as day_number -- Player Day Number
      , min(rdg_date) as first_played_rdg_date
      , max(rdg_date) as last_played_rdg_date
      , min(version) as min_version
      , max(version) as max_version
      , min(experiments) as experiments
      , sum( count_mtx_purchases ) as count_mtx_purchases
      , sum( mtx_purchase_dollars ) as mtx_purchase_dollars
      , sum( case when cumulative_count_mtx_purchases = 1 then count_mtx_purchases else 0 end ) as count_first_time_mtx_purchases
      , sum( case when cumulative_count_mtx_purchases = 1 then mtx_purchase_dollars else 0 end ) as first_time_mtx_purchase_dollars
      from
      -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_summary
      ${player_mtx_purchase_summary.SQL_TABLE_NAME}
      -- where
      -- date(rdg_date) = '2024-01-01'
      group by
      1,2

      )

      ----------------------------------------------------------------
      -- ad_views
      ----------------------------------------------------------------

      , ad_views as (

      select
      rdg_id
      , last_level_serial as level_serial
      , timestamp(date(min(created_at))) as created_date -- Created Date
      , date_diff(date(min(rdg_date)), date(min(created_at)), day) as days_since_created -- Days Since Created
      , 1 + date_diff(date(min(rdg_date)), date(min(created_at)), day) as day_number -- Player Day Number
      , min(rdg_date) as first_played_rdg_date
      , max(rdg_date) as last_played_rdg_date
      , min(version) as min_version
      , max(version) as max_version
      , min(experiments) as experiments
      , sum( count_ad_views ) as count_ad_views
      , sum( ad_view_dollars ) as ad_view_dollars
      , sum( case when cumulative_count_ad_views = 1 then count_ad_views else 0 end ) as count_first_time_ad_views
      , sum( case when cumulative_count_ad_views = 1 then ad_view_dollars else 0 end ) as first_time_ad_view_dollars
      , sum( case when ad_placement_mapping = 'Daily Reward' then count_ad_views else 0 end ) as ad_views_daily_rewards
      , sum( case when ad_placement_mapping = 'Moves Master' then count_ad_views else 0 end ) as ad_views_moves_master
      , sum( case when ad_placement_mapping = 'Pizza' then count_ad_views else 0 end ) as ad_views_pizza
      , sum( case when ad_placement_mapping = 'Lucky Dice' then count_ad_views else 0 end ) as ad_views_lucky_dice
      , sum( case when ad_placement_mapping = 'Ask For Help' then count_ad_views else 0 end ) as ad_views_ask_for_help
      , sum( case when ad_placement_mapping = 'Battle Pass' then count_ad_views else 0 end ) as ad_views_battle_pass
      , sum( case when ad_placement_mapping = 'Puzzles' then count_ad_views else 0 end ) as ad_views_puzzles
      , sum( case when ad_placement_mapping = 'Go Fish' then count_ad_views else 0 end ) as ad_views_go_fish
      , sum( case when ad_placement_mapping = 'Rocket' then count_ad_views else 0 end ) as ad_views_rocket
      , sum( case when ad_placement_mapping = 'Lives' then count_ad_views else 0 end ) as ad_views_lives
      , sum( case when ad_placement_mapping = 'Magnifiers' then count_ad_views else 0 end ) as ad_views_magnifiers
      , sum( case when ad_placement_mapping = 'Treasure Trove' then count_ad_views else 0 end ) as ad_views_treasure_trove

      from
      -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary
      ${player_ad_view_summary.SQL_TABLE_NAME}
      -- where
      -- date(rdg_date) = '2024-01-01'
      group by
      1,2

      )

      ----------------------------------------------------------------
      -- Combined
      ----------------------------------------------------------------

      , my_combined_list as (

      select
      rdg_id
      , level_serial
      , min(created_date) as created_date
      , min(days_since_created) as days_since_created
      , min(day_number) as day_number
      , min(first_played_rdg_date) as first_played_rdg_date
      , min(last_played_rdg_date) as last_played_rdg_date
      , min(min_version) as min_version
      , min(max_version) as max_version
      , min(experiments) as experiments

      from (
      select
      rdg_id
      , level_serial
      , min(created_date) as created_date
      , min(days_since_created) as days_since_created
      , min(day_number) as day_number
      , min(first_played_rdg_date) as first_played_rdg_date
      , min(last_played_rdg_date) as last_played_rdg_date
      , min(min_version) as min_version
      , min(max_version) as max_version
      , min(experiments) as experiments
      from
      campaign_levels
      group by 1,2

      union all
      select
      rdg_id
      , level_serial
      , min(created_date) as created_date
      , min(days_since_created) as days_since_created
      , min(day_number) as day_number
      , min(first_played_rdg_date) as first_played_rdg_date
      , min(last_played_rdg_date) as last_played_rdg_date
      , min(min_version) as min_version
      , min(max_version) as max_version
      , min(experiments) as experiments
      from
      mtx_purchases
      group by 1,2

      union all
      select
      rdg_id
      , level_serial
      , min(created_date) as created_date
      , min(days_since_created) as days_since_created
      , min(day_number) as day_number
      , min(first_played_rdg_date) as first_played_rdg_date
      , min(last_played_rdg_date) as last_played_rdg_date
      , min(min_version) as min_version
      , min(max_version) as max_version
      , min(experiments) as experiments
      from
      ad_views
      group by 1,2

      union all
      select
      rdg_id
      , level_serial
      , min(created_date) as created_date
      , min(days_since_created) as days_since_created
      , min(day_number) as day_number
      , min(first_played_rdg_date) as first_played_rdg_date
      , min(last_played_rdg_date) as last_played_rdg_date
      , min(min_version) as min_version
      , min(max_version) as max_version
      , min(experiments) as experiments
      from
      coin_spend_table
      group by 1,2

      ) a
      group by
      1,2
      )

      ----------------------------------------------------------------
      -- Output
      ----------------------------------------------------------------

      select
      a.*
      , b.* except (
      rdg_id
      , level_serial
      , created_date
      , days_since_created
      , day_number
      , first_played_rdg_date
      , last_played_rdg_date
      , min_version
      , max_version
      , experiments  )
      , c.* except (
      rdg_id
      , level_serial
      , created_date
      , days_since_created
      , day_number
      , first_played_rdg_date
      , last_played_rdg_date
      , min_version
      , max_version
      , experiments  )
      , d.* except (
      rdg_id
      , level_serial
      , created_date
      , days_since_created
      , day_number
      , first_played_rdg_date
      , last_played_rdg_date
      , min_version
      , max_version
      , experiments  )
      , e.* except (
      rdg_id
      , level_serial
      , created_date
      , days_since_created
      , day_number
      , first_played_rdg_date
      , last_played_rdg_date
      , min_version
      , max_version
      , experiments  )
      from
      my_combined_list a
      left join campaign_levels b
      on a.rdg_id = b.rdg_id
      and a.level_serial = b.level_serial
      left join mtx_purchases c
      on a.rdg_id = c.rdg_id
      and a.level_serial = c.level_serial
      left join ad_views d
      on a.rdg_id = d.rdg_id
      and a.level_serial = d.level_serial
      left join coin_spend_table e
      on a.rdg_id = e.rdg_id
      and a.level_serial = e.level_serial

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["first_played_rdg_date"]

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.level_serial
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

  parameter: dynamic_level_bucket_size {
    type: number
  }

  parameter: dynamic_in_round_coin_spend_size {
    type: number
  }

  parameter: selected_experiment {

    type: string
    default_value:  "$.No_AB_Test_Split"
  }


################################################################
## Dimensions
################################################################

  dimension: rdg_id { type:string }
  dimension: level_difficuly {
    label: "Level Difficulty Label"
    type: string
  }
  dimension: level_difficuly_order {
    label: "Level Difficulty Label Order"
    type: number
    sql:
        case
          when ${TABLE}.level_difficuly = 'easy' then 1
          when ${TABLE}.level_difficuly = 'normal' then 2
          when ${TABLE}.level_difficuly = 'hard' then 3
          else 4
          end

      ;;
  }

  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_played_rdg_date ;;
  }

  dimension_group: created_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  dimension: days_since_created {type:number}
  dimension: day_number {type:number}

  dimension: level_serial {
    type: number
    label: "Level"
    sql: ${TABLE}.level_serial ;;
  }

  dimension: dynamic_level_bucket {
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
    label: "Dynamic Level Bucket Order"
    type:number
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as int64
      )
    ;;
  }

  dimension: dynamic_in_round_coin_spend_bucket {
    label: "Dynamic In Round Coin Spend Bucket"
    type:string
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.in_round_coin_spend,{% parameter dynamic_in_round_coin_spend_size %}))*{% parameter dynamic_in_round_coin_spend_size %}
      as string
      )
    || ' to '
    ||
    safe_cast(
      ceiling(safe_divide(${TABLE}.in_round_coin_spend+1,{% parameter dynamic_in_round_coin_spend_size %}))*{% parameter dynamic_in_round_coin_spend_size %}-1
      as string
      )
    ;;
  }

  dimension: dynamic_in_round_coin_spend_bucket_order {
    label: "Dynamic In Round Coin Spend Bucket Order"
    type:number
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.in_round_coin_spend,{% parameter dynamic_in_round_coin_spend_size %}))*{% parameter dynamic_in_round_coin_spend_size %}
      as int64
      )
    ;;
  }

  dimension: in_round_coin_spend {
    label: "In Round Coin Spend"
    type: number
    sql: ${TABLE}.in_round_coin_spend ;;
  }


  dimension: min_version {
    label: "Lowest Version"
    type: number
    sql: ${TABLE}.min_version ;;

  }

  dimension: count_rounds {
    type: number


  }

  dimension: count_wins {
    type: number


  }

  dimension: count_losses {
    type: number


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
## Measures
################################################################

  measure: count_distinct_users {
    label: "Unique Players"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: count_distinct_churned_users {
    type: count_distinct
    sql: ${TABLE}.churn_rdg_id ;;
  }

  measure: sum_count_rounds {type: sum sql: ${TABLE}.count_rounds;; value_format_name: decimal_0}
  measure: sum_count_wins {type: sum sql: ${TABLE}.count_wins;; value_format_name: decimal_0}
  measure: sum_count_losses {type: sum sql: ${TABLE}.count_losses;; value_format_name: decimal_0}
  measure: sum_powerup_hammer {label: "Chums Spend: Hammer" type: sum sql: ${TABLE}.powerup_hammer;; value_format_name: decimal_0}
  measure: sum_powerup_rolling_pin {label: "Chums Spend: Rolling Pin" type: sum sql: ${TABLE}.powerup_rolling_pin;; value_format_name: decimal_0}
  measure: sum_powerup_piping_bag {label: "Chums Spend: Piping Bag" type: sum sql: ${TABLE}.powerup_piping_bag;; value_format_name: decimal_0}
  measure: sum_powerup_shuffle {label: "Chums Spend: Shuffle" type: sum sql: ${TABLE}.powerup_shuffle;; value_format_name: decimal_0}
  measure: sum_powerup_chopsticks {label: "Chums Spend: Chopsticks" type: sum sql: ${TABLE}.powerup_chopsticks;; value_format_name: decimal_0}
  measure: sum_powerup_skillet {label: "Chums Spend: Skillet" type: sum sql: ${TABLE}.powerup_skillet;; value_format_name: decimal_0}
  measure: sum_skill_disco {label: "Chums Spend: Disco" type: sum sql: ${TABLE}.skill_disco;; value_format_name: decimal_0}
  measure: sum_skill_moves {label: "Chums Spend: Moves" type: sum sql: ${TABLE}.skill_moves;; value_format_name: decimal_0}
  measure: sum_skill_drill {label: "Chums Spend: Drill" type: sum sql: ${TABLE}.skill_drill;; value_format_name: decimal_0}
  measure: sum_total_chum_powerups_used {label: "Chums Spend: Total"type: sum sql: ${TABLE}.total_chum_powerups_used;; value_format_name: decimal_0}

  measure: sum_in_round_count_mtx_purchases {
    label: "Sum Count In Round IAPs"
    type: sum
    sql: ${TABLE}.in_round_count_mtx_purchases;;
    value_format_name: decimal_0
  }

  measure: sum_in_round_count_ad_views {
    label: "Sum Count In Round IAA Views"
    type: sum
    sql: ${TABLE}.in_round_count_ad_views;;
    value_format_name: decimal_0
  }

  measure: sum_in_round_coin_spend {type: sum sql: ${TABLE}.in_round_coin_spend;; value_format_name: decimal_0}
  measure: sum_in_round_count_coin_spend_events {type: sum sql: ${TABLE}.in_round_count_coin_spend_events;; value_format_name: decimal_0}

  measure: sum_in_round_mtx_purchase_dollars {
    label: "Sum In Round IAP Dollars"
    type: sum
    sql: ${TABLE}.in_round_mtx_purchase_dollars;;
    value_format_name: usd
  }

  measure: sum_in_round_ad_view_dollars {
    label: "Sum In Round IAA Dollars"
    type: sum
    sql: ${TABLE}.in_round_ad_view_dollars;;
    value_format_name: usd
  }
  measure: sum_in_round_combined_dollars {type: sum sql: ${TABLE}.in_round_combined_dollars;; value_format_name: usd}

  measure: count_users {label: "Count Users" type: sum sql: 1;; value_format_name: decimal_0}
  measure: count_churn_indicator {label: "Count Churned Users" type: sum sql: ${TABLE}.churn_indicator;; value_format_name: decimal_0}

  measure: mean_attempts_per_success {
    label: "APS"
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

  measure: churn_rate {
    group_label: "Churn"
    label: "Churn Rate"
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.churn_indicator)
        ,
        sum(1)
      )
    ;;
    value_format_name: percent_2
  }

  measure: excess_churn_rate {
    group_label: "Churn"
    type: number
    sql:
      safe_divide(
        sum(
          case
            when
              ${TABLE}.count_wins < 1
            then ${TABLE}.churn_indicator
            else 0
            end )
        -
        sum(
          case
            when
              ${TABLE}.count_wins >= 1
            then ${TABLE}.churn_indicator
            else 0
            end )
        ,
        sum(1)
      )
    ;;
    value_format_name: percent_1
  }

  measure: average_chums_used_per_level {
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.total_chum_powerups_used)
        ,
        sum(1)
      )
    ;;
    value_format_name: decimal_3
  }

  measure: average_in_round_coin_spend_per_level {
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_coin_spend)
        ,
        sum(1)
      )
    ;;
    value_format_name: decimal_0
  }

  measure: average_in_round_mtx_dollars_per_level {
    label: "Average In Round IAP Dollars Per Level"
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_mtx_purchase_dollars)
        ,
        sum(1)
      )
    ;;
    value_format_name: usd
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

  measure: pregame_boost_rocket_per_level {
    group_label: "Pre-Game Boosts"
    label: "Total Rockets Per Level"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_rocket)
        , sum(1)
      ) ;;
  }

  measure: sum_pregame_boost_bomb {
    group_label: "Pre-Game Boosts"
    label: "Total Bombs"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_bomb) ;;
  }

  measure: pregame_boost_bomb_per_level {
    group_label: "Pre-Game Boosts"
    label: "Total Bombs Per Level"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_bomb)
        , sum(1)
      ) ;;
  }

  measure: sum_pregame_boost_colorball {
    group_label: "Pre-Game Boosts"
    label: "Total Colorballs"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_colorball) ;;
  }

  measure: pregame_boost_colorball_per_level {
    group_label: "Pre-Game Boosts"
    label: "Total Colorballs Per Level"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_colorball)
        , sum(1)
      ) ;;
  }

  measure: sum_pregame_boost_extramoves {
    group_label: "Pre-Game Boosts"
    label: "Total ExtraMoves"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_extramoves) ;;
  }

  measure: pregame_boost_extramoves_per_level {
    group_label: "Pre-Game Boosts"
    label: "Total ExtraMoves Per Level"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_extramoves)
        , sum(1)
      ) ;;
  }

  measure: sum_pregame_boost_total {
    group_label: "Pre-Game Boosts"
    label: "Total Boosts"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.pregame_boost_total) ;;
  }

  measure: pregame_boost_total_per_level {
    group_label: "Pre-Game Boosts"
    label: "Total Boosts Per Level"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_total)
        , sum(1)
      ) ;;
  }

#########################################################################################
## Player Day Number
#########################################################################################

  measure: player_day_number_mean {
    group_label: "Day Number To Reach Level"
    label: "Mean"
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.day_number)
        ,
        sum(1)
      )
    ;;
    value_format_name: decimal_1
  }

  measure: player_day_number_10 {
    group_label: "Day Number To Reach Level"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.day_number ;;
    value_format_name: decimal_0
  }
  measure: player_day_number_25 {
    group_label: "Day Number To Reach Level"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.day_number ;;
    value_format_name: decimal_0
  }
  measure: player_day_number_50 {
    group_label: "Day Number To Reach Level"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.day_number ;;
    value_format_name: decimal_0
  }
  measure: player_day_number_75 {
    group_label: "Day Number To Reach Level"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.day_number ;;
    value_format_name: decimal_0
  }
  measure: player_day_number_95 {
    group_label: "Day Number To Reach Level"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.day_number ;;
    value_format_name: decimal_0
  }

#########################################################################################
## Selectable Measure
#########################################################################################

  parameter: select_measure {
    label: "Select Measure"
    type: string
    suggestions: [
      "Unique Players"
      , "APS"
    ]
  }

  measure: selected_measure {
    label: "Selected Measure"
    type: number
    value_format_name: decimal_1
    sql:
    case
      when {% parameter select_measure %} = "Unique Players" then ${count_distinct_users}
      when {% parameter select_measure %} = "APS" then ${mean_attempts_per_success}
      else sum(0)
      end
  ;;


  }


#########################################################################################
## Progression Metrics
#########################################################################################

  measure: progression_count_mtx_purchases {
    group_label: "Progression Metrics"
    label: "Count IAP"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.count_mtx_purchases )  ;;
  }

  measure: progression_count_first_time_mtx_purchases {
    group_label: "Progression Metrics"
    label: "Count First Time IAP"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.count_first_time_mtx_purchases )  ;;
  }

  measure: progression_mtx_purchase_dollars {
    group_label: "Progression Metrics"
    label: "IAP Dollars"
    type: number
    value_format_name: usd_0
    sql: sum( ${TABLE}.mtx_purchase_dollars )  ;;
  }

  measure: progression_first_time_mtx_purchase_dollars {
    group_label: "Progression Metrics"
    label: "First Time IAP Dollars"
    type: number
    value_format_name: usd_0
    sql: sum( ${TABLE}.first_time_mtx_purchase_dollars )  ;;
  }

  measure: progression_count_ad_views {
    group_label: "Progression Metrics"
    label: "Count Ad Views"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.count_ad_views )  ;;
  }

  measure: progression_ad_view_dollars {
    group_label: "Progression Metrics"
    label: "Ad Dollars"
    type: number
    value_format_name: usd_0
    sql: sum( ${TABLE}.ad_view_dollars )  ;;
  }

  measure: progression_count_first_time_ad_views {
    group_label: "Progression Metrics"
    label: "Count First Time Ad Views"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.count_first_time_ad_views )  ;;
  }

  measure: progression_first_time_ad_view_dollars {
    group_label: "Progression Metrics"
    label: "First Time Ad Dollars"
    type: number
    value_format_name: usd_0
    sql: sum( ${TABLE}.first_time_ad_view_dollars )  ;;
  }

  measure: progression_ad_views_daily_rewards {
    group_label: "Progression Metrics"
    label: "Ad Views: Daily Reward"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_daily_rewards )  ;;
  }

  measure: progression_ad_views_moves_master {
    group_label: "Progression Metrics"
    label: "Ad Views: Moves Master"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_moves_master )  ;;
  }

  measure: progression_ad_views_ad_views_pizza {
    group_label: "Progression Metrics"
    label: "Ad Views: Pizza"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_pizza )  ;;
  }

  measure: progression_ad_views_lucky_dice {
    group_label: "Progression Metrics"
    label: "Ad Views: Lucky Dice"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_lucky_dice )  ;;
  }

  measure: progression_ad_views_battle_pass {
    group_label: "Progression Metrics"
    label: "Ad Views: Battle Pass"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_battle_pass )  ;;
  }

  measure: progression_ad_views_puzzles {
    group_label: "Progression Metrics"
    label: "Ad Views: Puzzle"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_puzzles )  ;;
  }

  measure: progression_ad_views_go_fish {
    group_label: "Progression Metrics"
    label: "Ad Views: Go Fish"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_go_fish )  ;;
  }

  measure: progression_ad_views_rocket {
    group_label: "Progression Metrics"
    label: "Ad Views: Rocket"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_rocket )  ;;
  }

  measure: progression_ad_views_lives {
    group_label: "Progression Metrics"
    label: "Ad Views: Lives"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_lives )  ;;
  }

  measure: progression_ad_views_treasure_trove {
    group_label: "Progression Metrics"
    label: "Ad Views: Treasure Trove"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.ad_views_treasure_trove )  ;;
  }

  measure: progression_coin_spend {
    group_label: "Progression Metrics"
    label: "Coin Spend"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend )  ;;
  }

  measure: progression_coin_spend_extra_moves {
    group_label: "Progression Metrics"
    label: "Coin Spend: Extra Moves"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend_extra_moves )  ;;
  }

  measure: progression_coin_spend_food_truck {
    group_label: "Progression Metrics"
    label: "Coin Spend: Food Truck"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend_food_truck )  ;;
  }

  measure: progression_coin_spend_chum_chum_skill {
    group_label: "Progression Metrics"
    label: "Coin Spend: Chum Chum Skill"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend_chum_chum_skill )  ;;
  }

  measure: progression_coin_spend_pre_game_boosts {
    group_label: "Progression Metrics"
    label: "Coin Spend: Pre-Game Boosts"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend_pre_game_boosts )  ;;
  }

  measure: progression_coin_spend_lives {
    group_label: "Progression Metrics"
    label: "Coin Spend: Lives"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend_lives )  ;;
  }

  measure: progression_coin_spend_new_chum_chum {
    group_label: "Progression Metrics"
    label: "Coin Spend: New Chum Chum"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend_new_chum_chum )  ;;
  }

  measure: progression_coin_spend_legacy {
    group_label: "Progression Metrics"
    label: "Coin Spend: Legacy"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend_legacy )  ;;
  }

  measure: progression_coin_spend_gem_quest {
    group_label: "Progression Metrics"
    label: "Coin Spend: Gem Quest"
    type: number
    value_format_name: decimal_0
    sql: sum( ${TABLE}.coin_spend_gem_quest )  ;;
  }

#########################################################################################
## Minutes At Round Start
#########################################################################################

  measure: cumulative_minutes_at_first_play_mean {
    group_label: "Cumulative Minutes At First Play"
    label: "Mean"
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.min_round_start_cumulative_minutes)
        ,
        sum(1)
      )
    ;;
    value_format_name: decimal_0
  }

  measure: cumulative_minutes_at_first_play_10 {
    group_label: "Cumulative Minutes At First Play"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.min_round_start_cumulative_minutes ;;
    value_format_name: decimal_0
  }
  measure: cumulative_minutes_at_first_play_25 {
    group_label: "Cumulative Minutes At First Play"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.min_round_start_cumulative_minutes ;;
    value_format_name: decimal_0
  }
  measure: cumulative_minutes_at_first_play_50 {
    group_label: "Cumulative Minutes At First Play"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.min_round_start_cumulative_minutes ;;
    value_format_name: decimal_0
  }
  measure: cumulative_minutes_at_first_play_75 {
    group_label: "Cumulative Minutes At First Play"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.min_round_start_cumulative_minutes ;;
    value_format_name: decimal_0
  }
  measure: cumulative_minutes_at_first_play_95 {
    group_label: "Cumulative Minutes At First Play"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.min_round_start_cumulative_minutes ;;
    value_format_name: decimal_0
  }




}
