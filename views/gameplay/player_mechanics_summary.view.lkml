view: player_mechanics_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-01-24'

      with

      ------------------------------------------------------------------------------
      -- base data w/ split
      ------------------------------------------------------------------------------

      base_data as (

        select
          a.*
          , objectives_split

        from
          --eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary a
          ${player_round_summary.SQL_TABLE_NAME} a
          cross join unnest(split(objectives)) as objectives_split with offset
        where
          1=1
          and objectives is not null
          and game_mode = 'campaign'
          and level_serial >= 1
          -- and date(rdg_date) = '2024-08-01'
          -- and rdg_id = '3989ffa2-2b93-4f33-a940-86c4746036ba'


      )

      ------------------------------------------------------------------------------
      -- summarized data
      ------------------------------------------------------------------------------

      select

        -- unique fields
        rdg_id
        , level_serial
        , level_id
        , rdg_date
        , version
        , objectives_split

        -- Player Age Information
        , timestamp(date(min(created_at))) as created_date -- Created Date
        , date_diff(date(min(rdg_date)), date(min(created_at)), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(min(rdg_date)), date(min(created_at)), day) as day_number -- Player Day Number

        -- summarized info
        , max(level_difficuly) as level_difficuly
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
        base_data
      group by
        1,2,3,4,5,6

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
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
    || '_' || ${TABLE}.level_serial
    || '_' || ${TABLE}.level_id
    || '_' || ${TABLE}.rdg_date
    || '_' || ${TABLE}.version
    || '_' || ${TABLE}.objectives_split
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
    sql: ${TABLE}.rdg_date ;;
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


  dimension: version {
    label: "Version"
    type: number
    sql: ${TABLE}.version ;;
  }

  dimension: version_number {
    type:number
    sql:
      safe_cast(${TABLE}.version as numeric)
      ;;
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

  dimension: objectives_split {
    label: "Level Mechanic"
    type: string
    }

################################################################
## Measures
################################################################

  measure: count_distinct_users {
    label: "Count Distinct Users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: count_distinct_level_id {
    label: "Count Distinct Levels"
    type: count_distinct
    sql: ${TABLE}.level_id ;;
  }

  measure: count_distinct_churned_users {
    type: count_distinct
    sql: ${TABLE}.churn_rdg_id ;;
  }

  measure: sum_count_rounds {label: "Count Rounds" type: sum sql: ${TABLE}.count_rounds;; value_format_name: decimal_0}
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

  measure: churn_rate_per_round {
    group_label: "Churn"
    label: "Churn Rate Per Round"
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.churn_indicator)
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: percent_2
  }

  measure: average_chums_used_per_round {
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.total_chum_powerups_used)
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: decimal_3
  }

  measure: average_in_round_coin_spend_per_round {
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_coin_spend)
        ,
        sum(${TABLE}.count_rounds)
      )
    ;;
    value_format_name: decimal_0
  }

  measure: average_in_round_mtx_dollars_per_round {
    label: "Average In Round IAP Dollars Per Round"
    type:  number
    sql:
      safe_divide(
        sum(${TABLE}.in_round_mtx_purchase_dollars)
        ,
        sum(${TABLE}.count_rounds)
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

  measure: pregame_boost_rocket_per_round {
    group_label: "Pre-Game Boosts"
    label: "Total Rockets Per Level"
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
    label: "Total Bombs Per Level"
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
    label: "Total Colorballs Per Level"
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
    label: "Total ExtraMoves Per Level"
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
    label: "Total Boosts Per Level"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        sum(${TABLE}.pregame_boost_total)
        , sum(${TABLE}.count_rounds)
      ) ;;
  }

}
