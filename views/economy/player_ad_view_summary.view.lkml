view: player_ad_view_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-03-01'

      -- create or replace table tal_scratch.player_ad_view_summary as

      with

      ------------------------------------------------------------------
      -- get rows from iron source
      -- (for iron source we are just pulling in the facebook data )
      ------------------------------------------------------------------

      iron_source_data as (

        select
          c.rdg_id
          , timestamp(date(a.event_timestamp)) as rdg_date
          , a.event_timestamp as timestamp_utc
          , max(a.placement) as source_id
          , max(1) as count_ad_views
          , max(a.ad_network) as ad_network
          , sum(a.revenue) as ad_view_dollars
          , max(a.country) as country
        from
          eraser-blast.ironsource.ironsource_daily_impressions_export a
          left join eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_summary b
            on a.user_id = b.firebase_advertising_id
          left join eraser-blast.looker_scratch.6Y_ritz_deli_games_player_summary_new c
            on b.firebase_user_id = c.user_id

        where
          timestamp(date(a.event_timestamp)) >= '2023-02-23'
          and ad_network = 'facebook'
        group by
          1,2,3

      )

      ------------------------------------------------------------------
      -- get rows from ad_view_incremental
      -- (for dates after '2023-02-23' we exclude facebook and UNITY because it it contained in the iron source data)
      ------------------------------------------------------------------

      , ad_view_incremental_table as (

        select
          *
        from
          `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_incremental`
        where
          case
            when (
                ad_network = 'facebook'
                or ad_network = 'UNITY' )
            and date(rdg_date) >= '2023-02-23'
            then 1
            else 0
            end = 0

      )

      ------------------------------------------------------------------
      -- combine ad_view_incremental_table + iron source
      ------------------------------------------------------------------

      , combined_tables as (

        select
          rdg_id
          , rdg_date
          , timestamp_utc
          , created_at
          , version
          , session_id
          , experiments
          , win_streak
          , count_ad_views
          , source_id
          , ad_network
          , country
          , current_level_id
          , current_level_serial
          , ad_view_dollars
          , coins_balance
          , lives_balance
          , stars_balance
        from
          ad_view_incremental_table
        union all
        select
          rdg_id
          , rdg_date
          , timestamp_utc
          , null as created_at
          , null as version
          , null as session_id
          , null as experiments
          , null as win_streak
          , count_ad_views
          , source_id
          , ad_network
          , country
          , null as current_level_id
          , null as current_level_serial
          , ad_view_dollars
          , null as coins_balance
          , null as lives_balance
          , null as stars_balance
        from
          iron_source_data

      )

      ------------------------------------------------------------------
      -- add cumulative calculations
      ------------------------------------------------------------------

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

      from
        combined_tables

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
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
## Dimensions
################################################################

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
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: count_ad_views {type:number}
  dimension: source_id {type:string}
  dimension: ad_network {type:string}
  dimension: country {type:string}
  dimension: current_level_id {type:string}

  # Numbers
  dimension: current_level_serial {type:number}
  dimension: ad_view_dollars {type:number}
  dimension: coins_balance {type:number}
  dimension: lives_balance {type:number}
  dimension: stars_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: cumulative_ad_view_dollars {type:number}
  dimension: cumulative_count_ad_views {type:number}

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
    group_label: "Count Ad Views"
    type:sum
    sql: ${TABLE}.count_ad_views ;;
  }
  measure: count_ad_views_10 {
    group_label: "Count Ad Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_ad_views ;;
  }
  measure: count_ad_views_25 {
    group_label: "Count Ad Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_ad_views ;;
  }
  measure: count_ad_views_50 {
    group_label: "Count Ad Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_ad_views ;;
  }
  measure: count_ad_views_75 {
    group_label: "Count Ad Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_ad_views ;;
  }
  measure: count_ad_views_95 {
    group_label: "Count Ad Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_ad_views ;;
  }
  measure: sum_ad_view_dollars {
    group_label: "Ad View Dollars"
    type:sum
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_10 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_25 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_50 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_75 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: ad_view_dollars_95 {
    group_label: "Ad View Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_view_dollars ;;
  }
  measure: sum_coins_balance {
    group_label: "Coins Balance"
    type:sum
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_10 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_25 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_50 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_75 {
    group_label: "Coins Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_balance ;;
  }
  measure: coins_balance_95 {
    group_label: "Coins Balance"
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
    group_label: "Cumulative Ad View Dollars"
    type:sum
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_10 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_25 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_50 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_75 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: cumulative_ad_view_dollars_95 {
    group_label: "Cumulative Ad View Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_view_dollars ;;
  }
  measure: sum_cumulative_count_ad_views {
    group_label: "Cumulative Count Ad Views"
    type:sum
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_10 {
    group_label: "Cumulative Count Ad Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_25 {
    group_label: "Cumulative Count Ad Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_50 {
    group_label: "Cumulative Count Ad Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_75 {
    group_label: "Cumulative Count Ad Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }
  measure: cumulative_count_ad_views_95 {
    group_label: "Cumulative Count Ad Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_ad_views ;;
  }



}
