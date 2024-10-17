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
  measure: sum_powerup_hammer {type: sum sql: ${TABLE}.powerup_hammer;; value_format_name: decimal_0}
  measure: sum_powerup_rolling_pin {type: sum sql: ${TABLE}.powerup_rolling_pin;; value_format_name: decimal_0}
  measure: sum_powerup_piping_bag {type: sum sql: ${TABLE}.powerup_piping_bag;; value_format_name: decimal_0}
  measure: sum_powerup_shuffle {type: sum sql: ${TABLE}.powerup_shuffle;; value_format_name: decimal_0}
  measure: sum_powerup_chopsticks {type: sum sql: ${TABLE}.powerup_chopsticks;; value_format_name: decimal_0}
  measure: sum_powerup_skillet {type: sum sql: ${TABLE}.powerup_skillet;; value_format_name: decimal_0}
  measure: sum_total_chum_powerups_used {type: sum sql: ${TABLE}.total_chum_powerups_used;; value_format_name: decimal_0}

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
