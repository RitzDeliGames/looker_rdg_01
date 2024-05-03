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
          -- primary key
          rdg_id
          , rdg_date
          , game_mode

          -- count_rounds
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
      -- summarize round summary data
      ---------------------------------------------------------------------------------------------

      , summarize_round_summary_data_table as (

        select
          rdg_id
          , rdg_date
          , game_mode

          -- Count Rounds
          , sum(count_rounds) as count_rounds

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

      )

      ---------------------------------------------------------------------------------------------
      -- additional reward data
      ---------------------------------------------------------------------------------------------

      , additional_reward_data_table as (

        select
          -- primary key
          rdg_id
          , rdg_date
          , case
              when reward_event = 'head_2_head' then 'goFish'
              else 'Other'
              end as game_mode

          -- Coin Reward Equivalents
          , case when
              reward_type = 'CURRENCY_03' then reward_amount
              else 0
              end as additional_rewards_coins

        from
          ${player_reward_summary.SQL_TABLE_NAME}

        where
          1=1
          and rdg_date = '2024-04-01'
          and reward_event in (
            'head_2_head'
            )

      )

      ---------------------------------------------------------------------------------------------
      -- additional reward data
      ---------------------------------------------------------------------------------------------

      , summarize_additional_reward_data_table as (

        select
          rdg_id
          , rdg_date
          , game_mode

          -- Coin Reward Equivalents
          , sum( additional_rewards_coins ) as additional_rewards_coins

        from
          additional_reward_data_table
        group by
          1,2,3

      )

      ---------------------------------------------------------------------------------------------
      -- union tables
      ---------------------------------------------------------------------------------------------

      , union_all_tables as (

        select
          rdg_id
          , rdg_date
          , game_mode
          , count_rounds
          , in_round_coin_spend
          , coin_equivalent_in_round_mtx_purchase_dollars
          , coin_equivalent_in_round_ad_view_dollars
          , in_round_coin_rewards
          , 0 as additional_rewards_coins
        from
          summarize_round_summary_data_table

        union all
        select
          rdg_id
          , rdg_date
          , game_mode
          , 0 as count_rounds
          , 0 in_round_coin_spend
          , 0 coin_equivalent_in_round_mtx_purchase_dollars
          , 0 coin_equivalent_in_round_ad_view_dollars
          , 0 in_round_coin_rewards
          , additional_rewards_coins
        from
          summarize_additional_reward_data_table

      )

      ---------------------------------------------------------------------------------------------
      -- summarize combined tables
      ---------------------------------------------------------------------------------------------

      select
        -- primary key
        rdg_id
        , rdg_date
        , game_mode

        -- summarized measures
        , sum(count_rounds) as count_rounds
        , sum(in_round_coin_spend) as in_round_coin_spend
        , sum(coin_equivalent_in_round_mtx_purchase_dollars) as coin_equivalent_in_round_mtx_purchase_dollars
        , sum(coin_equivalent_in_round_ad_view_dollars) as coin_equivalent_in_round_ad_view_dollars
        , sum(in_round_coin_rewards) as in_round_coin_rewards
        , sum(additional_rewards_coins) as additional_rewards_coins
      from
        union_all_tables
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

  measure: additional_rewards_coins {
    label: "Additional Game Mode Coin Rewards"
    group_label: "Coin Source Equivalents"
    type: number
    sql: sum(${TABLE}.additional_rewards_coins) ;;
  }


}
