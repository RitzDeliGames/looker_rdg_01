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
          , in_round_mtx_purchase_dollars
          , in_round_ad_view_dollars
          , in_round_coin_spend
          , in_round_coin_rewards

          , in_round_mtx_purchase_dollars * safe_divide(6000,99)
            + in_round_ad_view_dollars * safe_divide(6000,99)
            + in_round_coin_spend
            as coin_equivalent_sink

          , in_round_coin_rewards
            as coin_equivalent_source

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

        , sum( count_rounds ) as count_rounds
        , sum( in_round_mtx_purchase_dollars ) as in_round_mtx_purchase_dollars
        , sum( in_round_ad_view_dollars ) as in_round_ad_view_dollars
        , sum( in_round_coin_spend ) as in_round_coin_spend
        , sum( in_round_coin_rewards ) as in_round_coin_rewards
        , sum( coin_equivalent_sink ) as coin_equivalent_sink
        , sum( coin_equivalent_source ) as coin_equivalent_source

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

################################################################
## Measures
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }




}
