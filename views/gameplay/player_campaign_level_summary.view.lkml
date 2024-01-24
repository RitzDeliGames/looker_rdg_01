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
      from
        --eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary
        ${player_round_incremental.SQL_TABLE_NAME}
      where
        1=1
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
## Dimensions
################################################################

  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_played_rdg_date ;;
  }

################################################################
## Measures
################################################################

  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    label: "Count Distinct Users"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

}
