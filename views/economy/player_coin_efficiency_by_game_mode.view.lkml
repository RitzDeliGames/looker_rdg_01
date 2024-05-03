view: player_coin_efficiency_by_game_mode {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-05-02'

      -- create or replace table tal_scratch.player_coin_efficiency_by_game_mode as

      with

      ---------------------------------------------------------------------------------------------
      -- round summary data
      ---------------------------------------------------------------------------------------------

      round_summary_data as (

        select
          rdg_id
          , rdg_date
          , game_mode
          , count_rounds

          -- Coin Spend Equivalents
          , in_round_coin_spend * (-1) as in_round_coin_spend
          , in_round_mtx_purchase_dollars * safe_divide(6000,99) * (-1) as coin_equivalent_in_round_mtx_purchase_dollars
          , in_round_ad_view_dollars * safe_divide(6000,99) * (-1) as coin_equivalent_in_round_ad_view_dollars

          -- Coin Reward Equivalents
          , in_round_coin_rewards

        from
          ${player_round_summary.SQL_TABLE_NAME}
        where
          rdg_date = '2024-04-01'

      )

      ---------------------------------------------------------------------------------------------
      -- round summary data
      ---------------------------------------------------------------------------------------------

      select
        rdg_id
        , rdg_date
        , game_mode

        -- Coin Spend Equivalents
        , sum( in_round_coin_spend ) as in_round_coin_spend
        , sum( coin_equivalent_in_round_mtx_purchase_dollars ) as coin_equivalent_in_round_mtx_purchase_dollars
        , sum( coin_equivalent_in_round_ad_view_dollars ) as coin_equivalent_in_round_ad_view_dollars

        -- Coin Reward Equivalents
        , sum( in_round_coin_rewards ) as in_round_coin_rewards

      from
        round_summary_data
      group by
        1,2,3





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
    || '_' || ${TABLE}.rdg_date
    || '_' || ${TABLE}.game_mode
    ;;
    primary_key: yes
    hidden: yes
  }

# ################################################################
# ## Parameters
# ################################################################

#   parameter: selected_experiment {
#     type: string
#     default_value:  "$.No_AB_Test_Split"
#   }

################################################################
## Dimensions
################################################################

  # Date Groups
  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: rdg_id {type: string}
  dimension: game_mode {type: string}

################################################################
## Measures
################################################################

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: in_round_coin_spend {
    label: "In Round Coin Spend"
    group_label: "Coin Spend Equivalents"
    type: number
    sql: sum(${TABLE}.in_round_coin_spend) ;;
  }

  measure: coin_equivalent_in_round_mtx_purchase_dollars {
    label: "In Round IAP Dollar Equivalent Spend"
    group_label: "Coin Spend Equivalents"
    type: number
    sql: sum(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars) ;;
  }

  measure: coin_equivalent_in_round_ad_view_dollars {
    label: "In Round IAA Dollar Equivalent Spend"
    group_label: "Coin Spend Equivalents"
    type: number
    sql: sum(${TABLE}.coin_equivalent_in_round_ad_view_dollars) ;;
  }

  measure: in_round_coin_rewards {
    label: "In Round Coin Rewards"
    group_label: "Coin Source Equivalents"
    type: number
    sql: sum(${TABLE}.in_round_coin_rewards) ;;
  }


}
