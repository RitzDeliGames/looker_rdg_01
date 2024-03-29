view: player_campaign_level_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-01-24'

      select
        rdg_id
        , level_serial

        -- Player Age Information
        , timestamp(date(min(created_at))) as created_date -- Created Date
        , date_diff(date(min(rdg_date)), date(min(created_at)), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(min(rdg_date)), date(min(created_at)), day) as day_number -- Player Day Number

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
      from
        --eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary
        ${player_round_summary.SQL_TABLE_NAME}
      where
        level_serial >= 1
        -- and rdg_date = '2024-01-01'
        and game_mode = 'campaign'

      group by
        1,2

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
    suggestions:  [
      "$.No_AB_Test_Split"

      , "$.altLevelOrderp2_20240314"
      , "$.reversedQPO_20240313"

      , "$.livesCosting_20240202"

      , "$.swapTeamp2_20240209"
      , "$.goFishAds_20240208"
      , "$.dailyPopups_20240207"

      , "$.ExtraMoves1k_20240130"
      , "$.loAdMax_20240131"
      , "$.extendedQPO_20240131"

      , "$.blockColor_20240119"
      , "$.propBehavior_20240118"
      , "$.lv400500MovesTest_20240116"
      , "$.lv200300MovesTest_20240116"
      , "$.extraMovesOffering_20240111"

      ,"$.lv650800Moves_20240105"
      ,"$.lv100200Movesp2_20240103"
      ,"$.fueLevelsV3p2_20240102"
      ,"$.showLockedCharacters_20231215"
      ,"$.scrollableTT_20231213"
      ,"$.coinMultiplier_20231208"

      ,"$.lv100200Moves_20231207"
      ,"$.fueLevelsV3_20231207"
      ,"$.hapticv3_20231207"
      ,"$.swapTeam_20231206"
      ,"$.colorBoost_20231205"
      ,"$.lv300400MovesTest_20231207"

      ,"$.hudSquirrel_20231128"
      ,"$.blockSize_11152023"
      ,"$.lockedEvents_20231107"

      ,"$.coinPayout_20231108"

    ]
  }


################################################################
## Dimensions
################################################################

  dimension: rdg_id { type:string }

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
    sql: ${TABLE}.count_rounds ;;

  }

  dimension: count_wins {
    type: number
    sql: ${TABLE}.count_rounds ;;

  }

  dimension: count_losses {
    type: number
    sql: ${TABLE}.count_rounds ;;

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



}
