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

          -- additional fields
          , version
          , experiments
          , created_date
          , days_since_created
          , day_number

          -- count_rounds
          , count_rounds

          -- Coin Spend Equivalents
          , in_round_coin_spend * (-1) as in_round_coin_spend
          , in_round_mtx_purchase_dollars * safe_divide(6000,0.693) * (-1) as coin_equivalent_in_round_mtx_purchase_dollars
          , in_round_ad_view_dollars * safe_divide(6000,0.99) * (-1) as coin_equivalent_in_round_ad_view_dollars

          -- Coin Reward Equivalents
          , in_round_coin_rewards

          -- Active Modes
          , is_active_flour_frenzy
          , is_active_donut_sprint
          , is_active_castle_climb
          , is_active_hotdog_contest

        from
          ${player_round_summary.SQL_TABLE_NAME}
        where
          1=1
          --and rdg_date = '2024-04-01'
          and game_mode in (
            'campaign'
            , 'gemQuest'
            , 'goFish'
            , 'movesMaster'
            , 'puzzle'
            )

      )


      ---------------------------------------------------------------------------------------------
      -- summarize round summary data
      ---------------------------------------------------------------------------------------------

      , summarize_round_summary_data_table as (

        select
          rdg_id
          , rdg_date
          , game_mode

          -- additional fields
          , max( version ) as version
          , max( experiments ) as experiments
          , max( created_date ) as created_date
          , max( days_since_created ) as days_since_created
          , max( day_number ) as day_number

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

        -- flour frenzy
        union all

        select
          rdg_id
          , rdg_date
          , 'flourFrenzy' as game_mode

          -- additional fields
          , max( version ) as version
          , max( experiments ) as experiments
          , max( created_date ) as created_date
          , max( days_since_created ) as days_since_created
          , max( day_number ) as day_number

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
        where
          is_active_flour_frenzy
        group by
          1,2,3

        -- donut Sprint
        union all

        select
          rdg_id
          , rdg_date
          , 'donutSprint' as game_mode

          -- additional fields
          , max( version ) as version
          , max( experiments ) as experiments
          , max( created_date ) as created_date
          , max( days_since_created ) as days_since_created
          , max( day_number ) as day_number

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
        where
          is_active_donut_sprint
          and date(rdg_date) >= '2025-01-01'
        group by
          1,2,3

        -- is_active_castle_climb
        union all

        select
          rdg_id
          , rdg_date
          , 'castleClimb' as game_mode

          -- additional fields
          , max( version ) as version
          , max( experiments ) as experiments
          , max( created_date ) as created_date
          , max( days_since_created ) as days_since_created
          , max( day_number ) as day_number

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
        where
          is_active_castle_climb
        group by
          1,2,3

        -- is_active_hotdog_contest
        union all

        select
          rdg_id
          , rdg_date
          , 'hotdogContest' as game_mode

          -- additional fields
          , max( version ) as version
          , max( experiments ) as experiments
          , max( created_date ) as created_date
          , max( days_since_created ) as days_since_created
          , max( day_number ) as day_number

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
        where
          is_active_hotdog_contest
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
              when reward_event = 'go_fish' then 'goFish'
              when reward_event = 'zone_restore' then 'campaign'
              when reward_event = 'moves_master' then 'movesMaster'
              when reward_event = 'puzzle' then 'puzzle'
              when reward_event = 'gem_quest' then 'gemQuest'
              when reward_event =  'castle_climb' then 'castleClimb'
              when reward_event =  'donut_sprint' then 'donutSprint'
              when reward_event =  'flour_frenzy' then 'flourFrenzy'
              when reward_event =  'hotdog_contest' then 'hotdogContest'

              else 'Other'
              end as game_mode

          -- additional fields
          , version
          , experiments
          , created_date
          , days_since_created
          , day_number

          -- Coin Reward Equivalents
          , case when
              reward_type = 'CURRENCY_03' then reward_amount
              else 0
              end as additional_rewards_coins

          , case when
              reward_type = 'BOMB' then reward_amount * safe_divide(3900,1)
              else 0
              end as additional_rewards_bomb

          , case when
              reward_type = 'ROCKET' then reward_amount * safe_divide(19000,8)
              else 0
              end as additional_rewards_rocket

          , case when
              reward_type = 'COLOR_BALL' then reward_amount * safe_divide(4900,1)
              else 0
              end as additional_rewards_colorball

          , case when
              reward_type = 'INFINITE_LIVES' then reward_amount * safe_divide(0.35 * 6000 , 0.99)
              else 0
              end as additional_rewards_infinitelives

          , case when
              reward_type = 'clear_cell' then reward_amount * safe_divide(4900,1)
              else 0
              end as additional_rewards_clearcell

          , case when
              reward_type = 'clear_horizontal' then reward_amount * safe_divide(8400,1)
              else 0
              end as additional_rewards_clearhorizontal

          , case when
              reward_type = 'clear_vertical' then reward_amount * safe_divide(8400,1)
              else 0
              end as additional_rewards_clearvertical

          , case when
              reward_type = 'shuffle' then reward_amount * safe_divide(4900,1)
              else 0
              end as additional_rewards_shuffle


        from
          ${player_reward_summary.SQL_TABLE_NAME}

        where
          1=1
          --and rdg_date = '2024-04-01'
          and case
                when
                  reward_event in (
                    'head_2_head'
                    , 'zone_restore'
                    , 'moves_master'
                    , 'puzzle'
                    , 'gem_quest'
                    , 'go_fish'
                  )
                  then 1
                when
                  reward_event in (
                    'castle_climb'
                    , 'flour_frenzy'
                    , 'hotdog_contest'
                  )
                  and date(rdg_date) >= '2024-10-05'
                  then 1
                when
                  reward_event in (
                    'donut_sprint'
                  )
                  and date(rdg_date) >= '2025-01-01'
                  then 1
                else 0
                end = 1
          and reward_event in (
            'head_2_head'
            , 'zone_restore'
            , 'moves_master'
            , 'puzzle'
            , 'gem_quest'
            , 'go_fish'
            , 'castle_climb'
            , 'donut_sprint'
            , 'flour_frenzy'
            , 'hotdog_contest'
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

          -- additional fields
          , max( version ) as version
          , max( experiments ) as experiments
          , max( created_date ) as created_date
          , max( days_since_created ) as days_since_created
          , max( day_number ) as day_number

          -- Coin Reward Equivalents
          , sum( additional_rewards_coins ) as additional_rewards_coins
          , sum( additional_rewards_bomb ) as additional_rewards_bomb
          , sum( additional_rewards_rocket ) as additional_rewards_rocket
          , sum( additional_rewards_colorball ) as additional_rewards_colorball
          , sum( additional_rewards_infinitelives ) as additional_rewards_infinitelives
          , sum( additional_rewards_clearcell ) as additional_rewards_clearcell
          , sum( additional_rewards_clearhorizontal ) as additional_rewards_clearhorizontal
          , sum( additional_rewards_clearvertical ) as additional_rewards_clearvertical
          , sum( additional_rewards_shuffle ) as additional_rewards_shuffle


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

          -- additional fields
          , version
          , experiments
          , created_date
          , days_since_created
          , day_number

          , count_rounds
          , in_round_coin_spend
          , coin_equivalent_in_round_mtx_purchase_dollars
          , coin_equivalent_in_round_ad_view_dollars
          , in_round_coin_rewards
          , 0 as additional_rewards_coins
          , 0 as additional_rewards_bomb
          , 0 as additional_rewards_rocket
          , 0 as additional_rewards_colorball
          , 0 as additional_rewards_infinitelives
          , 0 as additional_rewards_clearcell
          , 0 as additional_rewards_clearhorizontal
          , 0 as additional_rewards_clearvertical
          , 0 as additional_rewards_shuffle
        from
          summarize_round_summary_data_table

        union all
        select
          rdg_id
          , rdg_date
          , game_mode

          -- additional fields
          , version
          , experiments
          , created_date
          , days_since_created
          , day_number

          , 0 as count_rounds
          , 0 in_round_coin_spend
          , 0 coin_equivalent_in_round_mtx_purchase_dollars
          , 0 coin_equivalent_in_round_ad_view_dollars
          , 0 in_round_coin_rewards
          , additional_rewards_coins
          , additional_rewards_bomb
          , additional_rewards_rocket
          , additional_rewards_colorball
          , additional_rewards_infinitelives
          , additional_rewards_clearcell
          , additional_rewards_clearhorizontal
          , additional_rewards_clearvertical
          , additional_rewards_shuffle
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

        -- additional fields
        , max( version ) as version
        , max( experiments ) as experiments
        , max( created_date ) as created_date
        , max( days_since_created ) as days_since_created
        , max( day_number ) as day_number

        -- summarized measures
        , sum(count_rounds) as count_rounds
        , sum(in_round_coin_spend) as in_round_coin_spend
        , sum(coin_equivalent_in_round_mtx_purchase_dollars) as coin_equivalent_in_round_mtx_purchase_dollars
        , sum(coin_equivalent_in_round_ad_view_dollars) as coin_equivalent_in_round_ad_view_dollars
        , sum(in_round_coin_rewards) as in_round_coin_rewards
        , sum(additional_rewards_coins) as additional_rewards_coins
        , sum(additional_rewards_bomb) as additional_rewards_bomb
        , sum( additional_rewards_rocket ) as additional_rewards_rocket
        , sum( additional_rewards_colorball ) as additional_rewards_colorball
        , sum( additional_rewards_infinitelives ) as additional_rewards_infinitelives
        , sum( additional_rewards_clearcell ) as additional_rewards_clearcell
        , sum( additional_rewards_clearhorizontal ) as additional_rewards_clearhorizontal
        , sum( additional_rewards_clearvertical ) as additional_rewards_clearvertical
        , sum( additional_rewards_shuffle ) as additional_rewards_shuffle
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

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

################################################################
## Dimensions
################################################################

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

  dimension: rdg_id {type: string}
  dimension: game_mode {type: string}
  dimension: version {type: string}
  dimension: version_number {
    type:number
    value_format_name: id
    sql:
      safe_cast(${TABLE}.version as numeric)
      ;;
  }
  dimension: experiments {type: string}
  dimension: days_since_created {type: number}
  dimension: day_number {type: number}
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

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: in_round_coin_spend {
    label: "In Round Coin Spend"
    group_label: "Coin Spend Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.in_round_coin_spend) ;;
  }

  measure: coin_equivalent_in_round_mtx_purchase_dollars {
    label: "In Round IAP Dollar Equivalent Spend"
    group_label: "Coin Spend Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars) ;;
  }

  measure: coin_equivalent_in_round_ad_view_dollars {
    label: "In Round IAA Dollar Equivalent Spend"
    group_label: "Coin Spend Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.coin_equivalent_in_round_ad_view_dollars) ;;
  }

  measure: in_round_coin_rewards {
    label: "In Round Coin Rewards"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.in_round_coin_rewards) ;;
  }

  measure: additional_rewards_coins {
    label: "Additional Game Mode Coin Rewards"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_coins) ;;
  }

  measure: additional_rewards_bomb {
    label: "Bombs"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_bomb) ;;
  }

  measure: additional_rewards_rocket {
    label: "Rockets"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_rocket) ;;
  }

  measure: additional_rewards_colorball {
    label: "Color Balls"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_colorball) ;;
  }

  measure: additional_rewards_infinitelives {
    label: "Infinite Lives"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_infinitelives) ;;
  }

  measure: additional_rewards_clearcell {
    label: "Clear Cell"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_clearcell) ;;
  }

  measure: additional_rewards_clearhorizontal {
    label: "Clear Horizontal"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_clearhorizontal) ;;
  }

  measure: additional_rewards_clearvertical {
    label: "Clear Vertical"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_clearvertical) ;;
  }

  measure: additional_rewards_shuffle {
    label: "Shuffle"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.additional_rewards_shuffle) ;;
  }

  measure: total_coin_equivalent_source {
    label: "Total Coin Equivalent Source"
    group_label: "Coin Source Equivalents"
    type: number
    value_format_name: decimal_0
    sql:

      sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )

    ;;
  }

  measure: total_coin_equivalent_spend {
    label: "Total Coin Equivalent Spend"
    group_label: "Coin Spend Equivalents"
    type: number
    value_format_name: decimal_0
    sql:

    sum(
      + ifnull(${TABLE}.in_round_coin_spend,0)
      + ifnull(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars,0)
      + ifnull(${TABLE}.coin_equivalent_in_round_ad_view_dollars,0)
      )
    ;;
  }

  measure: total_coin_efficiency {
    label: "Total Coin Efficiency"
    group_label: "Coin Efficiency"
    type: number
    value_format_name: decimal_0
    sql:

      sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        + ifnull(${TABLE}.in_round_coin_spend,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_ad_view_dollars,0)
        )

    ;;
  }

  measure: count_rounds {
    label: "Count Rounds"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.count_rounds) ;;
  }

  measure: in_round_coin_spend_per_round {
    label: "In Round Coin Spend Per Round"
    group_label: "Coin Spend Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.in_round_coin_spend), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: coin_equivalent_in_round_mtx_purchase_dollars_per_round {
    label: "In Round IAP Dollar Equivalent Spend Per Round"
    group_label: "Coin Spend Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: coin_equivalent_in_round_ad_view_dollars_per_round {
    label: "In Round IAA Dollar Equivalent Spend Per Round"
    group_label: "Coin Spend Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.coin_equivalent_in_round_ad_view_dollars), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: in_round_coin_rewards_per_round {
    label: "In Round Coin Rewards Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.in_round_coin_rewards), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_coins_per_round {
    label: "Additional Game Mode Coin Rewards Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_coins), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_bomb_per_round {
    label: "Bombs Sourced Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_bomb), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_rocket_per_round {
    label: "Rockets Sourced Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_rocket), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_colorball_per_round {
    label: "Color Balls Sourced Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_colorball), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_infinitelives_per_round {
    label: "Infinite Lives Sourced Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_infinitelives), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_clearcell_per_round {
    label: "Clear Cell Sourced Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_clearcell), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_clearhorizontal_per_round {
    label: "Clear Horizontal Sourced Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_clearhorizontal), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_clearvertical_per_round {
    label: "Clear Vertical Sourced Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_clearvertical), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: additional_rewards_shuffle_per_round {
    label: "Shuffle Sourced Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql: safe_divide( sum(${TABLE}.additional_rewards_shuffle), sum(${TABLE}.count_rounds) ) ;;
  }

  measure: total_coin_equivalent_source_per_round {
    label: "Total Coin Equivalent Source Per Round"
    group_label: "Coin Source Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql:
    safe_divide(
      sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      , sum(${TABLE}.count_rounds) )
    ;;
  }

  measure: total_coin_equivalent_spend_per_round {
    label: "Total Coin Equivalent Spend Per Round"
    group_label: "Coin Spend Equivalents Per Round"
    type: number
    value_format_name: decimal_0
    sql:
    safe_divide(
      sum(
        + ifnull(${TABLE}.in_round_coin_spend,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_ad_view_dollars,0)
        )
      , sum(${TABLE}.count_rounds) )
    ;;
  }

  measure: total_coin_efficiency_per_round {
    label: "Total Coin Efficiency Per Round"
    group_label: "Coin Efficiency"
    type: number
    value_format_name: decimal_0
    sql:
    safe_divide(
      sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        + ifnull(${TABLE}.in_round_coin_spend,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_ad_view_dollars,0)
        )
      , sum(${TABLE}.count_rounds) )

    ;;
  }

  measure: iap_percent_of_coin_equivalent_spend {
    label: "% IAP"
    group_label: "% of Coin Spend Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_spend,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_ad_view_dollars,0)
        )
      )
    ;;
  }

  measure: iaa_percent_of_coin_equivalent_spend {
    label: "% IAA"
    group_label: "% of Coin Spend Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.coin_equivalent_in_round_ad_view_dollars,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_spend,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_ad_view_dollars,0)
        )
      )
    ;;
  }

  measure: in_round_coin_spend_percent_of_coin_equivalent_spend {
    label: "% In Round Coin Spend"
    group_label: "% of Coin Spend Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.in_round_coin_spend,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_spend,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_mtx_purchase_dollars,0)
        + ifnull(${TABLE}.coin_equivalent_in_round_ad_view_dollars,0)
        )
    )
    ;;
  }

  measure: end_of_round_coin_rewards_percent_of_coin_equivalent_source {
    label: "% End of Round Coin Rewards"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.in_round_coin_rewards,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }

  measure: additional_coins_percent_of_coin_equivalent_source {
    label: "% End of Game Mode Coin Rewards"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_coins,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }

  measure: additional_rewards_bomb_percent_of_coin_equivalent_source {
    label: "% Bombs"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_bomb,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }

  measure: additional_rewards_rocket_percent_of_coin_equivalent_source {
    label: "% Rocket"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_rocket,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }

  measure: additional_rewards_colorball_percent_of_coin_equivalent_source {
    label: "% ColorBall"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_colorball,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }

  measure: additional_rewards_infinitelives_percent_of_coin_equivalent_source {
    label: "% Infinite Lives"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_infinitelives,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }


  measure: additional_rewards_clearcell_percent_of_coin_equivalent_source {
    label: "% Clear Cell"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_clearcell,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }


  measure: additional_rewards_clearhorizontal_percent_of_coin_equivalent_source {
    label: "% Clear Horizontal"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }

  measure: additional_rewards_clearvertical_percent_of_coin_equivalent_source {
    label: "% Clear Vertical"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_clearvertical,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }

  measure: additional_rewards_shuffle_percent_of_coin_equivalent_source {
    label: "% Shuffle"
    group_label: "% of Coin Souce Equivalents"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(
        ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      , sum(
        + ifnull(${TABLE}.in_round_coin_rewards,0)
        + ifnull(${TABLE}.additional_rewards_coins,0)
        + ifnull(${TABLE}.additional_rewards_bomb,0)
        + ifnull(${TABLE}.additional_rewards_rocket,0)
        + ifnull(${TABLE}.additional_rewards_colorball,0)
        + ifnull(${TABLE}.additional_rewards_infinitelives,0)
        + ifnull(${TABLE}.additional_rewards_clearcell,0)
        + ifnull(${TABLE}.additional_rewards_clearhorizontal,0)
        + ifnull(${TABLE}.additional_rewards_clearvertical,0)
        + ifnull(${TABLE}.additional_rewards_shuffle,0)
        )
      )
    ;;
  }

}
