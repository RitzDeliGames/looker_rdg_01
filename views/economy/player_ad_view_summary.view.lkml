view: player_ad_view_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-30'

      -- create or replace table tal_scratch.player_ad_view_summary as

      with

      ------------------------------------------------------------------
      -- facebook part 1
      -- get revenue per country per day for facebook from iron source
      ------------------------------------------------------------------

      iron_source_facebook_data as (

        select
          rdg_date
          , country
          , sum(sum_revenue_facebook) as sum_revenue_facebook
        from (

          -- Old Iron Source
          select
            timestamp(date(a.event_timestamp)) as rdg_date
            , country
            -- , sum(1) as count_rows
            , sum(a.revenue) as sum_revenue_facebook
            -- , safe_divide(sum(a.revenue), sum(1)) as estimated_ad_view_dollars_per_view

          from
            eraser-blast.ironsource.ironsource_daily_impressions_export a

          where
            timestamp(date(a.event_timestamp)) >= '2023-02-23'
            and ad_network = 'facebook'
          group by
            1,2

          -- Big Fish (new) Iron Source
          union all
          select
            timestamp(date(a.event_timestamp)) as rdg_date
            , country
            -- , sum(1) as count_rows
            , sum(a.revenue) as sum_revenue_facebook
            -- , safe_divide(sum(a.revenue), sum(1)) as estimated_ad_view_dollars_per_view

          from
            eraser-blast.ironsource.bigfish_is_daily_impressions a

          where
            timestamp(date(a.event_timestamp)) >= '2023-02-23'
            and ad_network = 'facebook'
          group by
            1,2
          ) a
        group by
          1,2

      )

      ------------------------------------------------------------------
      -- facebook fix part 2
      -- from our data
      ---- for facebook - get count of ads per day
      ---- for iron source - get total revenue (to subtract out of total)
      ------------------------------------------------------------------

      , ad_view_incremental_facebook_data as (

        select
          rdg_date
          , country
          , sum( case when ad_network = 'facebook' then count_ad_views else 0 end ) as count_ad_views_facebook
          , sum( case when ad_network = 'ironsource' then ad_view_dollars else 0 end ) as sum_ad_view_dollars_iron_source
        from
          `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_incremental` a
          -- ${player_ad_view_incremental.SQL_TABLE_NAME} a
        where
          rdg_date >= '2023-02-23'
          and ad_network in ( 'facebook' , 'ironsource' )
        group by
          1,2

      )

      ------------------------------------------------------------------
      -- facebook fix part 3
      -- combine and calculate override for facebook
      ------------------------------------------------------------------

      , combined_facebook_fix as (

        select
          a.rdg_date
          , a.country
          , a.sum_revenue_facebook
          , b.count_ad_views_facebook
          , b.sum_ad_view_dollars_iron_source
          , safe_divide(
                -- case
                -- when a.sum_revenue_facebook < b.sum_ad_view_dollars_iron_source
                -- then 0
                -- else a.sum_revenue_facebook - b.sum_ad_view_dollars_iron_source
                -- end
                a.sum_revenue_facebook
                ,
                b.count_ad_views_facebook
                ) estimated_ad_view_dollars_per_view
        from
          iron_source_facebook_data a
          inner join ad_view_incremental_facebook_data b
            on a.rdg_date = b.rdg_date
            and a.country = b.country
      )

      ------------------------------------------------------------------
      -- get rows from ad_view_incremental
      -- we use the iron source data for any facebook impressions after the mediation update, but otherwise just use our data
      ------------------------------------------------------------------

      , ad_view_incremental_table as (

        select
          a.rdg_id
          , a.rdg_date
          , a.timestamp_utc
          , a.created_at
          , a.version
          , a.session_id
          , a.experiments
          , a.win_streak
          , a.count_ad_views
          , a.source_id
          , a.ad_reward_source_id
          , a.ad_reward_iap_id
          , a.ad_network
          , a.country
          , a.current_level_id
          , a.current_level_serial
          , a.last_level_serial
          , ifnull( b.estimated_ad_view_dollars_per_view, a.ad_view_dollars ) as ad_view_dollars
          , a.coins_balance
          , a.lives_balance
          , a.stars_balance

          -- round_information
          , a.round_count
          , a.round_game_mode
          , a.round_start_timestamp_utc
          , a.round_end_timestamp_utc
          , a.round_purchase_type
          , json_extract_scalar(a.extra_json,"$.ad_format") as ad_format

        from
          -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_incremental` a
          ${player_ad_view_incremental.SQL_TABLE_NAME} a
          left join combined_facebook_fix b
            on a.ad_network = 'facebook'
            and safe_cast(a.version as int64) >= 13122
            and a.rdg_date >= '2023-02-23'
            and a.rdg_date = b.rdg_date
            and a.country = b.country

      )

      ------------------------------------------------------------------
      -- add cumulative calculations
      ------------------------------------------------------------------

      , add_cumulative_caluclations as (

      select

        -- All columns from player_ad_view_incremental
        *

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

        -- Cumulative fields
        , sum(ifnull(ad_view_dollars,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_ad_view_dollars

        , sum(ifnull(count_ad_views,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_count_ad_views

        , sum(ifnull(count_ad_views,0)) over (
            partition by rdg_id, rdg_date
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_count_ad_views_this_day


        -- ad placement mapping
        , case
          when source_id like '%DailyReward' then 'Daily Reward'
          when source_id like '%Moves_Master%' then 'Moves Master'
          when source_id like '%Pizza%' then 'Pizza'
          when source_id like '%Lucky_Dice%' then 'Lucky Dice'
          when source_id like '%RequestHelp%' then 'Ask For Help'
          when source_id like '%Battle_Pass%' then 'Battle Pass'
          when source_id like '%Puzzles%' then 'Puzzles'
          when source_id like '%Go_Fish%' then 'Go Fish'

          when ad_reward_source_id = 'quick_boost_rocket' then 'Rocket'
          when ad_reward_source_id = 'quick_lives' then 'Lives'
          when ad_reward_source_id = 'quick_magnifiers' then 'Magnifiers'
          when ad_reward_source_id = 'treasure_trove' then 'Treasure Trove'

          else 'Unmapped'
          end as ad_placement_mapping

      from
        ad_view_incremental_table

      )

      ------------------------------------------------------------------
      -- select results
      ------------------------------------------------------------------

      select
        *
        , @{ad_placements_for_ad_summary} as ad_placement
      from add_cumulative_caluclations





      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -3 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (3) + 2 )*( -10 ) minute)) ;;
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
      || '_' || ${TABLE}.timestamp_utc
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

  # dates
  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }
  dimension_group: created_date_timestamp {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  # Strings
  dimension: rdg_id {type:string}
  dimension: version {type:string}
  dimension: version_number {
    type:number
    sql:
      safe_cast(${TABLE}.version as numeric)
      ;;
  }
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: count_ad_views {type:number}
  dimension: source_id {type:string}
  dimension: ad_placement {
    type: string
    sql:
      ${TABLE}.ad_placement
    ;;
    }
  dimension: ad_network {
    type:string
    sql:
      case
        when lower(${TABLE}.ad_network) like '%admob%' then 'Google'
        when lower(${TABLE}.ad_network) like '%admanager%' then 'Google'
        when lower(${TABLE}.ad_network) like '%applovin%' then 'AppLovin'
        when lower(${TABLE}.ad_network) like '%facebook%' then 'Meta'
        when lower(${TABLE}.ad_network) like '%fyber%' then 'Digital Turbine'
        when lower(${TABLE}.ad_network) like '%dt%' then 'Digital Turbine'
        when lower(${TABLE}.ad_network) like '%liftoff%' then 'Liftoff'
        when lower(${TABLE}.ad_network) like '%meta%' then 'Meta'
        when lower(${TABLE}.ad_network) like '%mintegral%' then 'Mintegral'
        when lower(${TABLE}.ad_network) like '%ironsource%' then 'Unity/iS'
        when lower(${TABLE}.ad_network) like '%unity%' then 'Unity/iS'
        else ${TABLE}.ad_network
      end
      ;;
    }
  dimension: country {type:string}
  dimension: current_level_id {type:string}

  # Round Info
  dimension: round_game_mode {
    group_label: "Round Info"
    type: string}
  dimension: round_purchase_type {
    group_label: "Round Info"
    type: string}
  dimension: round_count {
    group_label: "Round Info"
    type: number}
  dimension_group: round_start_timestamp_utc {
    group_label: "Round Info"
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.round_start_timestamp_utc ;;
  }
  dimension_group: round_end_timestamp_utc {
    group_label: "Round Info"
    type: time
    timeframes: [time, hour, date, week, month, year]
    sql: ${TABLE}.round_end_timestamp_utc ;;
  }

  dimension: ad_source_id {
    type: string
    label: "Starting: Ad Source ID"
    sql: ${TABLE}.source_id ;;
  }

  dimension: ad_reward_source_id {
    label: "Ad Reward Source Id"
    sql: ${TABLE}.ad_reward_source_id ;;
  }

  dimension: ad_reward_iap_id {
    label: "Ad Reward IAP ID"
    sql: ${TABLE}.ad_reward_iap_id ;;
  }

  dimension: ad_reward_id_strings {
    label: "Ad Reward Source Id (Clean)"
    sql: @{ad_reward_id_strings} ;;
  }

  dimension: ad_format {
    type: string
    label: "Ad Format"
    sql: case
          when lower(${TABLE}.ad_format) like '%banner%' then 'Banner'
          when lower(${TABLE}.ad_format) like '%leader%' then 'Banner'
          when lower(${TABLE}.ad_format) like '%inter%' then 'Interstitial'
          when lower(${TABLE}.ad_format) like '%rewarded%' then 'Rewarded'
          else 'Unmapped'
        end
    ;;
  }

  # Numbers
  dimension: current_level_serial {type:number}
  dimension: ad_view_dollars {type:number label: "IAA Dollars"}
  dimension: coins_balance {type:number}
  dimension: lives_balance {type:number}
  dimension: stars_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: cumulative_ad_view_dollars {type:number label: "LTV - IAA"}
  dimension: cumulative_count_ad_views {type:number label: "Cumulative IAA Views"}
  dimension: cumulative_count_ad_views_this_day {type:number label: "Cumulative IAA Views This Date"}

################################################################
## eCPM Ratio from Ad View 1 to Ad View X
################################################################

measure: ecpm_ratio_ad_view_1_to_ad_view_1 {
  group_label: "eCPM Decline by Day"
  label: "Daily IAA View 1 Ratio"
  type: number
  value_format_name: percent_0
  sql:
    safe_divide(
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
      ,
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
    )
  ;;
}

  measure: ecpm_ratio_ad_view_1_to_ad_view_2 {
    group_label: "eCPM Decline by Day"
    label: "Daily IAA View 2 Ratio"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 2
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 2
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
      ,
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
    )
  ;;
  }

  measure: ecpm_ratio_ad_view_1_to_ad_view_5 {
    group_label: "eCPM Decline by Day"
    label: "Daily IAA View 5 Ratio"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 5
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 5
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
      ,
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
    )
  ;;
  }

  measure: ecpm_ratio_ad_view_1_to_ad_view_10 {
    group_label: "eCPM Decline by Day"
    label: "Daily IAA View 10 Ratio"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 10
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 10
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
      ,
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
    )
  ;;
  }

  measure: ecpm_ratio_ad_view_1_to_ad_view_15 {
    group_label: "eCPM Decline by Day"
    label: "Daily IAA View 15 Ratio"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 15
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 15
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
      ,
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
    )
  ;;
  }

  measure: ecpm_ratio_ad_view_1_to_ad_view_20 {
    group_label: "eCPM Decline by Day"
    label: "Daily IAA View 20 Ratio"
    type: number
    value_format_name: percent_0
    sql:
    safe_divide(
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 20
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 20
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
      ,
      safe_divide(
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.ad_view_dollars
        else 0
        end )
        ,
        sum(
        case when ${TABLE}.cumulative_count_ad_views_this_day = 1
        then ${TABLE}.count_ad_views
        else 0
        end )
      )
    )
  ;;
  }

################################################################
## Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

################################################################
## Sums and Percentiles
################################################################

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
        sum(${TABLE}.count_ad_views)
      )
    ;;
    value_format_name: usd
  }

  measure: sum_win_streak {
    group_label: "Win Streak"
    type:sum
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_10 {
    group_label: "Win Streak"
    type: percentile
    percentile: 10
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_25 {
    group_label: "Win Streak"
    type: percentile
    percentile: 25
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_50 {
    group_label: "Win Streak"
    type: percentile
    percentile: 50
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_75 {
    group_label: "Win Streak"
    type: percentile
    percentile: 75
    sql: ${TABLE}.win_streak ;;
  }
  measure: win_streak_95 {
    group_label: "Win Streak"
    type: percentile
    percentile: 95
    sql: ${TABLE}.win_streak ;;
  }

  measure: sum_count_ad_views {
    label: "Sum IAA Views"
    type:sum
    sql: ${TABLE}.count_ad_views ;;
  }

  measure: sum_ad_view_dollars {
    label: "Sum IAA Dollars"
    type:sum
    sql: ${TABLE}.ad_view_dollars ;;
    value_format_name: usd
  }
  measure: ad_view_dollars_10 {
    label: "10th Percentile"
    group_label: "IAA View Dollar Distribution"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_25 {
    label: "25th Percentile"
    group_label: "IAA View Dollar Distribution"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_50 {
    label: "Median"
    group_label: "IAA View Dollar Distribution"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_75 {
    label: "75th Percentile"
    group_label: "IAA View Dollar Distribution"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_95 {
    label: "95th Percentile"
    group_label: "IAA View Dollar Distribution"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_view_dollars ;;
  }

  measure: coins_balance_10 {
    label: "10th Percentile"
    group_label: "Coin Balance Distribution"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_25 {
    label: "25th Percentile"
    group_label: "Coin Balance Distribution"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_50 {
    label: "Median"
    group_label: "Coin Balance Distribution"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_75 {
    label: "75th Percentile"
    group_label: "Coin Balance Distribution"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_95 {
    label: "95th Percentile"
    group_label: "Coin Balance Distribution"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coins_balance ;;
  }

  measure: sum_lives_balance {
    group_label: "Lives Balance"
    type:sum
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_10 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_25 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_50 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_75 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.lives_balance ;;
  }
  measure: lives_balance_95 {
    group_label: "Lives Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.lives_balance ;;
  }
  measure: sum_stars_balance {
    group_label: "Stars Balance"
    type:sum
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_10 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_25 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_50 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_75 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.stars_balance ;;
  }
  measure: stars_balance_95 {
    group_label: "Stars Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.stars_balance ;;
  }
  measure: sum_cumulative_ad_view_dollars {
    label: "Sum LTV - IAA"
    group_label: "Cumulative Ad View Dollars"
    type:sum
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }

  measure: cumulative_ad_view_dollars_10 {
    label: "10th Percentile"
    group_label: "LTV - IAA Distribution"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_25 {
    label: "25th Percentile"
    group_label: "LTV - IAA Distribution"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_50 {
    label: "Median"
    group_label: "LTV - IAA Distribution"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_75 {
    label: "75th Percentile"
    group_label: "LTV - IAA Distribution"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_95 {
    label: "95th Percentile"
    group_label: "LTV - IAA Distribution"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }

  measure: sum_cumulative_count_ad_views {
    label: "Sum Cumulative Count IAA Views"
    type:sum
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }

  measure: cumulative_count_ad_views_10 {
    label: "10th Percentile"
    group_label: "Cumulative Count IAA Views Distribution"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_25 {
    label: "25th Percentile"
    group_label: "Cumulative Count IAA Views Distribution"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_50 {
    label: "Median"
    group_label: "Cumulative Count IAA Views Distribution"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_75 {
    label: "75th Percentile"
    group_label: "Cumulative Count IAA Views Distribution"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_95 {
    label: "95th Percentile"
    group_label: "Cumulative Count IAA Views Distribution"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }



}
