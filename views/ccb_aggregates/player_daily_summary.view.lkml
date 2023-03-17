view: player_daily_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-03-17'

       -- CREATE OR REPLACE TABLE `tal_scratch.player_daily_summary` AS

      with
      -----------------------------------------------------------------------
      -- ads by date
      -----------------------------------------------------------------------

      ads_by_date as (
          select
              rdg_id
              , rdg_date
              , sum( count_ad_views ) as ad_views
              , sum( ad_view_dollars ) as ad_view_dollars
          from
              eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary
          group by
              1,2
      )

      -----------------------------------------------------------------------
      -- mtx by date
      -----------------------------------------------------------------------

      , mtx_by_date as (
          select
              rdg_id
              , rdg_date
              , sum( count_mtx_purchases ) as count_mtx_purchases
              , sum( mtx_purchase_dollars ) as mtx_purchase_dollars
          from
              eraser-blast.looker_scratch.6Y_ritz_deli_games_player_mtx_purchase_summary
          group by
              1,2
      )

      -----------------------------------------------------------------------
      -- player_daily_incremental w/ prior date played
      -----------------------------------------------------------------------

      , player_daily_incremental_w_prior_date as (
          select
              *
              -- Date last played
              , ifnull(
                      lag(rdg_date, 1) over (
                  partition by rdg_id
                  order by rdg_date ASC
                  )
                  ,timestamp(date(created_utc))) as rdg_date_last_played
          from
              `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_incremental`

      )

      -----------------------------------------------------------------------
      -- join ads data
      -----------------------------------------------------------------------

      , join_on_ads_data as (
          select
              a.rdg_id
              , a.rdg_date
              , max(a.rdg_date_last_played) as rdg_date_last_played
              , max(a.device_id) as device_id
              , max(a.advertising_id) as advertising_id
              , max(a.user_id) as user_id
              , max(a.display_name) as display_name
              , max(a.platform) as platform
              , max(a.country) as country
              , max(a.created_utc) as created_utc
              , max(a.created_date) as created_date
              , max(a.experiments) as experiments
              , max(a.version) as version
              , max(a.install_version) as install_version
              , sum( ifnull(b.ad_view_dollars,0) + ifnull(c.ad_view_dollars,0)) as ad_view_dollars
              , max(a.mtx_ltv_from_data) as mtx_ltv_from_data
              , sum( ifnull(b.ad_views,0) + ifnull(c.ad_views,0)) as ad_views
              , max(a.count_sessions) as count_sessions
              , max(a.cumulative_session_count) as cumulative_session_count
              , max(a.cumulative_engagement_ticks) as cumulative_engagement_ticks
              , max(a.round_start_events) as round_start_events

              , max(a.round_end_events) as round_end_events
              , max(a.round_end_events_campaign) as round_end_events_campaign
              , max(a.round_end_events_movesmaster) as round_end_events_movesmaster
              , max(a.round_end_events_puzzle) as round_end_events_puzzle
              , max(a.round_time_in_minutes) as round_time_in_minutes
              , max(a.round_time_in_minutes_campaign) as round_time_in_minutes_campaign
              , max(a.round_time_in_minutes_movesmaster) as round_time_in_minutes_movesmaster
              , max(a.round_time_in_minutes_puzzle) AS round_time_in_minutes_puzzle


              , max(a.lowest_last_level_serial) as lowest_last_level_serial
              , max(a.highest_last_level_serial) as highest_last_level_serial
              , max(a.highest_quests_completed) as highest_quests_completed
              , max(a.gems_spend) as gems_spend
              , max(a.coins_spend) as coins_spend
              , max(a.stars_spend) as stars_spend
              , max(a.ending_gems_balance) as ending_gems_balance
              , max(a.ending_coins_balance) as ending_coins_balance
              , max(a.ending_lives_balance) as ending_lives_balance
              , max(a.ending_stars_balance) as ending_stars_balance

              -- system_info
              , max( a.hardware ) as hardware
              , max( a.processor_type ) as processor_type
              , max( a.graphics_device_name ) as graphics_device_name
              , max( a.device_model ) as device_model
              , max( a.system_memory_size ) as system_memory_size
              , max( a.graphics_memory_size ) as graphics_memory_size
              , max( a.screen_width ) as screen_width
              , max( a.screen_height ) as screen_height

              -- end of content and zones
              , max( a.end_of_content_levels ) as end_of_content_levels
              , max( a.end_of_content_zones ) as end_of_content_zones
              , max( a.current_zone ) as current_zone
              , max( a.current_zone_progress ) as current_zone_progress



          from
              player_daily_incremental_w_prior_date a
              left join ads_by_date b
                  on b.rdg_id = a.rdg_id
                  and b.rdg_date = a.rdg_date
              left join ads_by_date c
                  on c.rdg_id = a.rdg_id
                  and c.rdg_date < a.rdg_date
                  and c.rdg_date > a.rdg_date_last_played
          group by
              1,2
      )


      -----------------------------------------------------------------------
      -- join ads data
      -----------------------------------------------------------------------

      , join_on_mtx_data as (
          select
              a.rdg_id
              , a.rdg_date
              , max(a.rdg_date_last_played) as rdg_date_last_played
              , max(a.device_id) as device_id
              , max(a.advertising_id) as advertising_id
              , max(a.user_id) as user_id
              , max(a.display_name) as display_name
              , max(a.platform) as platform
              , max(a.country) as country
              , max(a.created_utc) as created_utc
              , max(a.created_date) as created_date
              , max(a.experiments) as experiments
              , max(a.version) as version
              , max(a.install_version) as install_version
              , max(a.ad_view_dollars) as ad_view_dollars
              , sum( ifnull(b.mtx_purchase_dollars,0) + ifnull(c.mtx_purchase_dollars,0)) as mtx_purchase_dollars
              , max(a.mtx_ltv_from_data) as mtx_ltv_from_data
              , max(a.ad_views) as ad_views
              , max(a.count_sessions) as count_sessions
              , max(a.cumulative_session_count) as cumulative_session_count
              , max(a.cumulative_engagement_ticks) as cumulative_engagement_ticks
              , max(a.round_start_events) as round_start_events

              , max(a.round_end_events) as round_end_events
              , max(a.round_end_events_campaign) as round_end_events_campaign
              , max(a.round_end_events_movesmaster) as round_end_events_movesmaster
              , max(a.round_end_events_puzzle) as round_end_events_puzzle
              , max(a.round_time_in_minutes) as round_time_in_minutes
              , max(a.round_time_in_minutes_campaign) as round_time_in_minutes_campaign
              , max(a.round_time_in_minutes_movesmaster) as round_time_in_minutes_movesmaster
              , max(a.round_time_in_minutes_puzzle) AS round_time_in_minutes_puzzle

              , max(a.lowest_last_level_serial) as lowest_last_level_serial
              , max(a.highest_last_level_serial) as highest_last_level_serial
              , max(a.highest_quests_completed) as highest_quests_completed
              , max(a.gems_spend) as gems_spend
              , max(a.coins_spend) as coins_spend
              , max(a.stars_spend) as stars_spend
              , max(a.ending_gems_balance) as ending_gems_balance
              , max(a.ending_coins_balance) as ending_coins_balance
              , max(a.ending_lives_balance) as ending_lives_balance
              , max(a.ending_stars_balance) as ending_stars_balance

              -- system_info
              , max( a.hardware ) as hardware
              , max( a.processor_type ) as processor_type
              , max( a.graphics_device_name ) as graphics_device_name
              , max( a.device_model ) as device_model
              , max( a.system_memory_size ) as system_memory_size
              , max( a.graphics_memory_size ) as graphics_memory_size
              , max( a.screen_width ) as screen_width
              , max( a.screen_height ) as screen_height

              -- end of content and zones
              , max( a.end_of_content_levels ) as end_of_content_levels
              , max( a.end_of_content_zones ) as end_of_content_zones
              , max( a.current_zone ) as current_zone
              , max( a.current_zone_progress ) as current_zone_progress

          from
              join_on_ads_data a
              left join mtx_by_date b
                  on b.rdg_id = a.rdg_id
                  and b.rdg_date = a.rdg_date
              left join mtx_by_date c
                  on c.rdg_id = a.rdg_id
                  and c.rdg_date < a.rdg_date
                  and c.rdg_date > a.rdg_date_last_played
          group by
              1,2
      )

      -----------------------------------------------------------------------
      -- cumulative calculations
      -----------------------------------------------------------------------

      select

        -- Start with all the rows from join_to_player_daily_incremental
        *

        , TIMESTAMP(created_date) as created_date_timestamp

        -- Days Since Created
        , DATE_DIFF(DATE(rdg_date), created_date, DAY) AS days_since_created

        -- Player Day Number
        , 1 + DATE_DIFF(DATE(rdg_date), created_date, DAY) AS day_number

        -- new_player_indicator
        , CASE WHEN DATE_DIFF(DATE(rdg_date), created_date, DAY) = 0 THEN 1 ELSE 0 END AS new_player_indicator

         -- new_player_rdg_id
        , CASE WHEN DATE_DIFF(DATE(rdg_date), created_date, DAY) = 0 THEN rdg_id ELSE NULL END AS new_player_rdg_id

        -- Date last played
        , LAG(DATE(rdg_date), 1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ) date_last_played

        -- Days Since Last Played
        , DATE_DIFF(
            DATE(rdg_date)
            , LAG(DATE(rdg_date), 1) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                )
            , DAY
            ) days_since_last_played

        -- next_date_played
        , LEAD(DATE(rdg_date), 1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ) next_date_played

        -- churn_indicator
        , CASE
            WHEN
              LEAD(DATE(rdg_date), 1) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ) IS NULL
            THEN 1
            ELSE 0
            END AS churn_indicator

        -- churn_rdg_id
        , CASE
            WHEN
              LEAD(DATE(rdg_date), 1) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ) IS NULL
            THEN rdg_id
            ELSE NULL
            END AS churn_rdg_id

        -- days_until_next_played
        , DATE_DIFF(
            LEAD(DATE(rdg_date), 1) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                )
            , DATE(rdg_date)
            , DAY
            ) days_until_next_played

        -- cumulative_mtx_purchase_dollars
        -- Includes adjustment for App Store %
        , SUM( ifnull( mtx_purchase_dollars, 0 ) ) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_mtx_purchase_dollars

        -- cumulative_ad_view_dollars
        , SUM(IFNULL(ad_view_dollars,0)) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_ad_view_dollars

        -- combined_dollars
        -- Includes adjustment for App Store %
        , ifnull( mtx_purchase_dollars, 0 ) + IFNULL(ad_view_dollars,0) AS combined_dollars

        -- cumulative_combined_dollars
        -- Includes adjustment for App Store %
        , SUM(ifnull( mtx_purchase_dollars, 0 ) + IFNULL(ad_view_dollars,0)) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_combined_dollars

        -- daily_mtx_spend_indicator
        , CASE WHEN IFNULL(mtx_purchase_dollars,0) > 0 THEN 1 ELSE 0 END AS daily_mtx_spend_indicator

        -- daily_mtx_spender_rdg_id
        , CASE WHEN IFNULL(mtx_purchase_dollars,0) > 0 THEN rdg_id ELSE NULL END AS daily_mtx_spender_rdg_id

        -- first_mtx_spend_indicator
        , CASE
            WHEN IFNULL(mtx_purchase_dollars,0) > 0
            AND
              SUM(mtx_purchase_dollars) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING )
              = 0
            THEN 1
            ELSE 0
            END AS first_mtx_spend_indicator

        -- lifetime_mtx_spend_indicator
        , CASE
            WHEN
              SUM(mtx_purchase_dollars) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
              > 0
            THEN 1
            ELSE 0
            END AS lifetime_mtx_spend_indicator

        -- lifetime_mtx_spender_rdg_id
        , CASE
            WHEN
              SUM(mtx_purchase_dollars) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
              > 0
            THEN rdg_id
            ELSE NULL
            END AS lifetime_mtx_spender_rdg_id

        -- cumulative_ad_views
        , SUM(ad_views) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_ad_views


        -- Calculate engagement ticks
        -- uses prior row cumulative_engagement_ticks
        , IFNULL(cumulative_engagement_ticks,0) -
            IFNULL(LAG(cumulative_engagement_ticks,1) OVER (
                PARTITION BY rdg_id
                ORDER BY rdg_date ASC
                ),0) AS engagement_ticks

        -- time played
        -- This is calculated as engagement ticks / 2
        , 0.5 * (
            IFNULL(cumulative_engagement_ticks,0) -
            IFNULL(LAG(cumulative_engagement_ticks,1) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ),0))
            AS time_played_minutes

        -- cumulative_time_played_minutes
        , 0.5 * ( IFNULL(cumulative_engagement_ticks,0) ) AS cumulative_time_played_minutes

        -- cumulative_round_start_events
        , SUM(round_start_events) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_start_events

        -- cumulative_round_end_events
        , SUM(round_end_events) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_end_events

        -- round_end_events_campaign
        , SUM(round_end_events_campaign) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_end_events_campaign

        -- round_end_events_movesmaster
        , SUM(round_end_events_movesmaster) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_end_events_movesmaster

        -- round_end_events_puzzle
        , SUM(round_end_events_puzzle) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_end_events_puzzle

        -- round_time_in_minutes
        , SUM(round_time_in_minutes) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_time_in_minutes

        -- round_time_in_minutes_campaign
        , SUM(round_time_in_minutes_campaign) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_time_in_minutes_campaign

        -- round_time_in_minutes_movesmaster
        , SUM(round_time_in_minutes_movesmaster) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_time_in_minutes_movesmaster

        -- round_time_in_minutes_puzzle
        , SUM(round_time_in_minutes_puzzle) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_round_time_in_minutes_puzzle



        -- Calculate quests_completed
        -- uses prior row highest_quests_completed
        , IFNULL(highest_quests_completed,0) -
            IFNULL(LAG(highest_quests_completed,1) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ),0) AS quests_completed

        -- count_days_played
        -- this is just always 1
        , 1 as count_days_played

        -- cumulative_count_days_played
        , SUM(1) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_count_days_played

        -- Calculate levels_progressed
        -- uses prior row highest_last_level_serial
        , IFNULL(highest_last_level_serial,0) -
            IFNULL(LAG(highest_last_level_serial,1) OVER (
              PARTITION BY rdg_id
              ORDER BY rdg_date ASC
              ),0) AS levels_progressed

        -- cumulative_gems_spend
        , SUM(gems_spend) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_gems_spend

        -- cumulative_coins_spend
        , SUM(coins_spend) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_coins_spend

        -- cumulative_star_spend
        , SUM(stars_spend) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) cumulative_star_spend

      FROM
        join_on_mtx_data

      where
          -- select date_add( current_date(), interval -1 day )
          rdg_date <= timestamp(date_add( current_date(), interval -1 day ))



      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -4 hour)) ;;
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
    ;;
  primary_key: yes
  hidden: yes
}

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    group_label: "Activity Dates"
    label: "Activity Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }
  dimension_group: created_date_timestamp {
    group_label: "Install Date"
    label: "Installed On"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date_timestamp ;;
  }

  # strings
  dimension: rdg_id {type:string}
  dimension: new_player_rdg_id {type:string}
  dimension: lifetime_mtx_spender_rdg_id {type:string}
  dimension: churn_rdg_id {type:string}
  dimension: device_id {type:string}
  dimension: advertising_id {type:string}
  dimension: user_id {type:string}
  dimension: platform {type:string}
  dimension: country {type:string}
  dimension: region {type:string sql:@{country_region};;}
  dimension: experiments {type:string}
  dimension: version {type:string}
  dimension: install_version {type:string}

  # numbers
  dimension: mtx_purchase_dollars {type:number}
  dimension: ad_view_dollars {type:number}
  dimension: mtx_ltv_from_data {type:number}
  dimension: ad_views {type:number}
  dimension: count_sessions {type:number}
  dimension: cumulative_session_count {type:number}
  dimension: cumulative_engagement_ticks {type:number}
  dimension: round_start_events {type:number}
  dimension: round_end_events {type:number}
  dimension: lowest_last_level_serial {type:number}
  dimension: highest_last_level_serial {type:number}

  dimension: lowest_last_level_serial_bin {
    type: bin
    bins: [1,50,150,250,400,600,800,1000]
    style: interval
    sql: ${TABLE}.lowest_last_level_serial ;;
    }

  dimension: highest_quests_completed {type:number}
  dimension: gems_spend {type:number}
  dimension: coins_spend {type:number}
  dimension: stars_spend {type:number}
  dimension: ending_gems_balance {type:number}
  dimension: ending_coins_balance {type:number}
  dimension: ending_lives_balance {type:number}
  dimension: ending_stars_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: new_player_indicator {type:number}
  dimension: date_last_played {type:number}
  dimension: days_since_last_played {type:number}
  dimension: next_date_played {type:number}
  dimension: churn_indicator {type:number}
  dimension: days_until_next_played {type:number}
  dimension: cumulative_mtx_purchase_dollars {type:number}
  dimension: cumulative_ad_view_dollars {type:number}
  dimension: combined_dollars {type:number}
  dimension: cumulative_combined_dollars {type:number}
  dimension: daily_mtx_spend_indicator {type:number}
  dimension: daily_mtx_spender_rdg_id {type:number}
  dimension: first_mtx_spend_indicator {type:number}
  dimension: lifetime_mtx_spend_indicator {type:number}
  dimension: cumulative_ad_views {type:number}
  dimension: engagement_ticks {type:number}
  dimension: time_played_minutes {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: cumulative_round_start_events {type:number}
  dimension: cumulative_round_end_events {type:number}
  dimension: quests_completed {type:number}
  dimension: count_days_played {type:number}
  dimension: cumulative_count_days_played {type:number}
  dimension: levels_progressed {type:number}
  dimension: cumulative_gems_spend {type:number}
  dimension: cumulative_coins_spend {type:number}
  dimension: cumulative_star_spend {type:number}

  dimension: round_end_events_campaign {type:number}
  dimension: round_end_events_movesmaster {type:number}
  dimension: round_end_events_puzzle {type:number}
  dimension: round_time_in_minutes {type:number}
  dimension: round_time_in_minutes_campaign {type:number}
  dimension: round_time_in_minutes_movesmaster {type:number}
  dimension: round_time_in_minutes_puzzle {type:number}
  dimension: cumulative_round_end_events_campaign {type:number}
  dimension: cumulative_round_end_events_movesmaster {type:number}
  dimension: cumulative_round_end_events_puzzle {type:number}
  dimension: cumulative_round_time_in_minutes {type:number}
  dimension: cumulative_round_time_in_minutes_campaign {type:number}
  dimension: cumulative_round_time_in_minutes_movesmaster {type:number}
  dimension: cumulative_round_time_in_minutes_puzzle {type:number}

  ## end of content and zones
  dimension: end_of_content_levels {type: yesno}
  dimension: end_of_content_zones {type: yesno}
  dimension: current_zone {type: number}
  dimension: current_zone_progress {type: number}

################################################################
## Unique Player Counts
################################################################

  ## Player Counts
  measure: count_distinct_active_users {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }
  measure: count_distinct_new_player_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    value_format: "#,###"
    sql: ${TABLE}.new_player_rdg_id ;;
  }
  measure: count_distinct_churn_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.churn_rdg_id ;;
  }
  measure: count_distinct_daily_mtx_spender_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: count_distinct_lifetime_mtx_spender_rdg_id {
    group_label: "Unique Player Counts"
    type: count_distinct
    sql: ${TABLE}.lifetime_mtx_spender_rdg_id ;;
  }

################################################################
## Average Daily Numbers
################################################################

  measure: average_daily_active_users {
    group_label: "Average Daily Numbers"
    label: "Average Daily Active Users (DAU)"
    type: number
    sql:
      safe_divide(
        sum(1)
        ,
        count(distinct ${TABLE}.rdg_date)
      )
    ;;
    value_format_name: decimal_0
  }

################################################################
## Other Calculations
################################################################

  measure: percent_players_playing_rounds {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_campaign {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_campaign > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }
  measure: percent_players_playing_movesmaster {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_movesmaster > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: percent_players_playing_puzzle {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct case
          when ${TABLE}.round_end_events_puzzle > 0
          then ${TABLE}.rdg_id
          else null
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

  measure: churn_rate {
    group_label: "Calculated Fields"
    type: number
    sql:
      safe_divide(
        count(distinct ${TABLE}.churn_rdg_id )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_0
  }

################################################################
## Revenue Metrics
################################################################

  measure: average_mtx_purchase_revenue_per_player{
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.mtx_purchase_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }

  measure: average_daily_mtx_conversion {
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.daily_mtx_spend_indicator)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_1
  }

  measure: average_ad_revenue_per_player{
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.ad_view_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }

  measure: average_daily_ads_conversion {
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum( case
          when ${TABLE}.count_ad_views > 0
          then 1
          else 0
          end )
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: percent_1
  }

  measure: average_combined_revenue_per_player{
    group_label: "Revenue Metrics"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.combined_dollars)
        ,
        count(distinct ${TABLE}.rdg_id)
      )
    ;;
    value_format_name: usd
  }


## Sums / Percentiles

  measure: sum_mtx_purchase_dollars {
    group_label: "MTX Purchase Dollars"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_10 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_25 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_50 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_75 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: mtx_purchase_dollars_95 {
    group_label: "MTX Purchase Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }
  measure: sum_ad_view_dollars {
    group_label: "Ad View Dollars"
    type:sum
    value_format: "$#,###"
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
  measure: sum_mtx_ltv_from_data {
    group_label: "MTX LTV From Data"
    type:sum
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_10 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 10
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_25 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 25
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_50 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 50
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_75 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 75
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: mtx_ltv_from_data_95 {
    group_label: "MTX LTV From Data"
    type: percentile
    percentile: 95
    sql: ${TABLE}.mtx_ltv_from_data ;;
  }
  measure: sum_ad_views {
    group_label: "Ad Views"
    type:sum
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_10 {
    group_label: "Ad Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_25 {
    group_label: "Ad Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_50 {
    group_label: "Ad Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_75 {
    group_label: "Ad Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ad_views ;;
  }
  measure: ad_views_95 {
    group_label: "Ad Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ad_views ;;
  }
  measure: sum_count_sessions {
    group_label: "Count Sessions"
    type:sum
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_10 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_25 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_50 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_75 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_sessions ;;
  }
  measure: count_sessions_95 {
    group_label: "Count Sessions"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_sessions ;;
  }
  measure: sum_cumulative_session_count {
    group_label: "Cumulative Session Count"
    type:sum
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_10 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_25 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_50 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_75 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: cumulative_session_count_95 {
    group_label: "Cumulative Session Count"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_session_count ;;
  }
  measure: sum_cumulative_engagement_ticks {
    group_label: "Cumulative Engagement Ticks"
    type:sum
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_10 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_25 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_50 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_75 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: cumulative_engagement_ticks_95 {
    group_label: "Cumulative Engagement Ticks"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_engagement_ticks ;;
  }
  measure: sum_round_start_events {
    group_label: "Round Start Events"
    type:sum
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_10 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_25 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_50 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_75 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_start_events ;;
  }
  measure: round_start_events_95 {
    group_label: "Round Start Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_start_events ;;
  }
  measure: sum_round_end_events {
    group_label: "Round End Events"
    type:sum
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_10 {
    group_label: "Round End Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_25 {
    group_label: "Round End Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_50 {
    group_label: "Round End Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_75 {
    group_label: "Round End Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events ;;
  }
  measure: round_end_events_95 {
    group_label: "Round End Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events ;;
  }
  measure: sum_lowest_last_level_serial {
    group_label: "Lowest Last Level Serial"
    type:sum
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_10 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 10
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_25 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 25
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_50 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 50
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_75 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 75
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: lowest_last_level_serial_95 {
    group_label: "Lowest Last Level Serial"
    type: percentile
    percentile: 95
    sql: ${TABLE}.lowest_last_level_serial ;;
  }
  measure: sum_highest_last_level_serial {
    group_label: "Highest Last Level Serial"
    type:sum
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_10 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 10
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_25 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 25
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_50 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 50
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_75 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 75
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: highest_last_level_serial_95 {
    group_label: "Highest Last Level Serial"
    type: percentile
    percentile: 95
    sql: ${TABLE}.highest_last_level_serial ;;
  }
  measure: sum_highest_quests_completed {
    group_label: "Highest Quests Completed"
    type:sum
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_10 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 10
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_25 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 25
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_50 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 50
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_75 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 75
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: highest_quests_completed_95 {
    group_label: "Highest Quests Completed"
    type: percentile
    percentile: 95
    sql: ${TABLE}.highest_quests_completed ;;
  }
  measure: sum_gems_spend {
    group_label: "Gems Spend"
    type:sum
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_10 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_25 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_50 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_75 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.gems_spend ;;
  }
  measure: gems_spend_95 {
    group_label: "Gems Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.gems_spend ;;
  }
  measure: sum_coins_spend {
    group_label: "Coins Spend"
    type:sum
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_10 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_25 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_50 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_75 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.coins_spend ;;
  }
  measure: coins_spend_95 {
    group_label: "Coins Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.coins_spend ;;
  }
  measure: sum_stars_spend {
    group_label: "Stars Spend"
    type:sum
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_10 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_25 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_50 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_75 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.stars_spend ;;
  }
  measure: stars_spend_95 {
    group_label: "Stars Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.stars_spend ;;
  }
  measure: sum_ending_gems_balance {
    group_label: "Ending Gems Balance"
    type:sum
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_10 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_25 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_50 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_75 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: ending_gems_balance_95 {
    group_label: "Ending Gems Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_gems_balance ;;
  }
  measure: sum_ending_coins_balance {
    group_label: "Ending Coins Balance"
    type:sum
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_10 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_25 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_50 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_75 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: ending_coins_balance_95 {
    group_label: "Ending Coins Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_coins_balance ;;
  }
  measure: sum_ending_lives_balance {
    group_label: "Ending Lives Balance"
    type:sum
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_10 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_25 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_50 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_75 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: ending_lives_balance_95 {
    group_label: "Ending Lives Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_lives_balance ;;
  }
  measure: sum_ending_stars_balance {
    group_label: "Ending Stars Balance"
    type:sum
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_10 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 10
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_25 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 25
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_50 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 50
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_75 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 75
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: ending_stars_balance_95 {
    group_label: "Ending Stars Balance"
    type: percentile
    percentile: 95
    sql: ${TABLE}.ending_stars_balance ;;
  }
  measure: sum_days_since_created {
    group_label: "Days Since Created"
    type:sum
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_10 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 10
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_25 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 25
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_50 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 50
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_75 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 75
    sql: ${TABLE}.days_since_created ;;
  }
  measure: days_since_created_95 {
    group_label: "Days Since Created"
    type: percentile
    percentile: 95
    sql: ${TABLE}.days_since_created ;;
  }
  measure: sum_day_number {
    group_label: "Day Number"
    type:sum
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_10 {
    group_label: "Day Number"
    type: percentile
    percentile: 10
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_25 {
    group_label: "Day Number"
    type: percentile
    percentile: 25
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_50 {
    group_label: "Day Number"
    type: percentile
    percentile: 50
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_75 {
    group_label: "Day Number"
    type: percentile
    percentile: 75
    sql: ${TABLE}.day_number ;;
  }
  measure: day_number_95 {
    group_label: "Day Number"
    type: percentile
    percentile: 95
    sql: ${TABLE}.day_number ;;
  }
  measure: sum_new_player_indicator {
    group_label: "New Player Indicator"
    type:sum
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_10 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_25 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_50 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_75 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: new_player_indicator_95 {
    group_label: "New Player Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.new_player_indicator ;;
  }
  measure: sum_churn_indicator {
    group_label: "Churn Indicator"
    type:sum
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_10 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_25 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_50 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_75 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: churn_indicator_95 {
    group_label: "Churn Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.churn_indicator ;;
  }
  measure: sum_cumulative_mtx_purchase_dollars {
    group_label: "Cumulative MTX Purchase Dollars"
    type:sum
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_10 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_25 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_50 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_75 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
  }
  measure: cumulative_mtx_purchase_dollars_95 {
    group_label: "Cumulative MTX Purchase Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_mtx_purchase_dollars ;;
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
  measure: sum_combined_dollars {
    group_label: "Combined Dollars"
    type:sum
    value_format: "$#,###"
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_10 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_25 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_50 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_75 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: combined_dollars_95 {
    group_label: "Combined Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.combined_dollars ;;
  }
  measure: sum_cumulative_combined_dollars {
    group_label: "Cumulative Combined Dollars"
    type:sum
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_10 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_25 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_50 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_75 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: cumulative_combined_dollars_95 {
    group_label: "Cumulative Combined Dollars"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_combined_dollars ;;
  }
  measure: sum_daily_mtx_spend_indicator {
    group_label: "Daily MTX Spend Indicator"
    type:sum
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_10 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_25 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_50 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_75 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: daily_mtx_spend_indicator_95 {
    group_label: "Daily MTX Spend Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.daily_mtx_spend_indicator ;;
  }
  measure: sum_daily_mtx_spender_rdg_id {
    group_label: "Daily MTX Spender Rdg Id"
    type:sum
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_10 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 10
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_25 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 25
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_50 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 50
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_75 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 75
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: daily_mtx_spender_rdg_id_95 {
    group_label: "Daily MTX Spender Rdg Id"
    type: percentile
    percentile: 95
    sql: ${TABLE}.daily_mtx_spender_rdg_id ;;
  }
  measure: sum_first_mtx_spend_indicator {
    group_label: "First MTX Spend Indicator"
    type:sum
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_10 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_25 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_50 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_75 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: first_mtx_spend_indicator_95 {
    group_label: "First MTX Spend Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.first_mtx_spend_indicator ;;
  }
  measure: sum_lifetime_mtx_spend_indicator {
    group_label: "Lifetime MTX Spend Indicator"
    type:sum
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_10 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 10
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_25 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 25
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_50 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 50
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_75 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 75
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: lifetime_mtx_spend_indicator_95 {
    group_label: "Lifetime MTX Spend Indicator"
    type: percentile
    percentile: 95
    sql: ${TABLE}.lifetime_mtx_spend_indicator ;;
  }
  measure: sum_cumulative_ad_views {
    group_label: "Cumulative Ad Views"
    type:sum
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_10 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_25 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_50 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_75 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: cumulative_ad_views_95 {
    group_label: "Cumulative Ad Views"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_ad_views ;;
  }
  measure: sum_engagement_ticks {
    group_label: "Engagement Ticks"
    type:sum
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_10 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 10
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_25 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 25
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_50 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 50
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_75 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 75
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: engagement_ticks_95 {
    group_label: "Engagement Ticks"
    type: percentile
    percentile: 95
    sql: ${TABLE}.engagement_ticks ;;
  }
  measure: sum_time_played_minutes {
    group_label: "Time Played Minutes"
    type:sum
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_10 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_25 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_50 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_75 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: time_played_minutes_95 {
    group_label: "Time Played Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.time_played_minutes ;;
  }
  measure: sum_cumulative_time_played_minutes {
    group_label: "Cumulative Time Played Minutes"
    type:sum
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_10 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_25 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_50 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_75 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: cumulative_time_played_minutes_95 {
    group_label: "Cumulative Time Played Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: sum_cumulative_round_start_events {
    group_label: "Cumulative Round Start Events"
    type:sum
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_10 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_25 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_50 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_75 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: cumulative_round_start_events_95 {
    group_label: "Cumulative Round Start Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_start_events ;;
  }
  measure: sum_cumulative_round_end_events {
    group_label: "Cumulative Round End Events"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_10 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_25 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_50 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_75 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: cumulative_round_end_events_95 {
    group_label: "Cumulative Round End Events"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events ;;
  }
  measure: sum_quests_completed {
    group_label: "Quests Completed"
    type:sum
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_10 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 10
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_25 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 25
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_50 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 50
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_75 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 75
    sql: ${TABLE}.quests_completed ;;
  }
  measure: quests_completed_95 {
    group_label: "Quests Completed"
    type: percentile
    percentile: 95
    sql: ${TABLE}.quests_completed ;;
  }
  measure: sum_count_days_played {
    group_label: "Count Days Played"
    type:sum
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_10 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_25 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_50 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_75 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_days_played ;;
  }
  measure: count_days_played_95 {
    group_label: "Count Days Played"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_days_played ;;
  }
  measure: sum_cumulative_count_days_played {
    group_label: "Cumulative Count Days Played"
    type:sum
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_10 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_25 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_50 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_75 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: cumulative_count_days_played_95 {
    group_label: "Cumulative Count Days Played"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_count_days_played ;;
  }
  measure: sum_levels_progressed {
    group_label: "Levels Progressed"
    type:sum
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_10 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 10
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_25 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 25
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_50 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 50
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_75 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 75
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: levels_progressed_95 {
    group_label: "Levels Progressed"
    type: percentile
    percentile: 95
    sql: ${TABLE}.levels_progressed ;;
  }
  measure: sum_cumulative_gems_spend {
    group_label: "Cumulative Gems Spend"
    type:sum
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_10 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_25 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_50 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_75 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: cumulative_gems_spend_95 {
    group_label: "Cumulative Gems Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_gems_spend ;;
  }
  measure: sum_cumulative_coins_spend {
    group_label: "Cumulative Coins Spend"
    type:sum
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_10 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_25 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_50 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_75 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: cumulative_coins_spend_95 {
    group_label: "Cumulative Coins Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_coins_spend ;;
  }
  measure: sum_cumulative_star_spend {
    group_label: "Cumulative Star Spend"
    type:sum
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_10 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_25 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_50 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_75 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_star_spend ;;
  }
  measure: cumulative_star_spend_95 {
    group_label: "Cumulative Star Spend"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_star_spend ;;
  }

  measure: sum_round_end_events_campaign {
    group_label: "Round End Events Campaign"
    type:sum
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_10 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_25 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_50 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_75 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: round_end_events_campaign_95 {
    group_label: "Round End Events Campaign"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events_campaign ;;
  }
  measure: sum_round_end_events_movesmaster {
    group_label: "Round End Events Movesmaster"
    type:sum
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_10 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_25 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_50 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_75 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: round_end_events_movesmaster_95 {
    group_label: "Round End Events Movesmaster"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events_movesmaster ;;
  }
  measure: sum_round_end_events_puzzle {
    group_label: "Round End Events Puzzle"
    type:sum
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_10 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_25 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_50 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_75 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: round_end_events_puzzle_95 {
    group_label: "Round End Events Puzzle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_end_events_puzzle ;;
  }
  measure: sum_round_time_in_minutes {
    group_label: "Round Time In Minutes"
    type:sum
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_10 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_25 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_50 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_75 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: round_time_in_minutes_95 {
    group_label: "Round Time In Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_time_in_minutes ;;
  }
  measure: sum_round_time_in_minutes_campaign {
    group_label: "Round Time In Minutes Campaign"
    type:sum
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_10 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_25 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_50 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_75 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: round_time_in_minutes_campaign_95 {
    group_label: "Round Time In Minutes Campaign"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_time_in_minutes_campaign ;;
  }
  measure: sum_round_time_in_minutes_movesmaster {
    group_label: "Round Time In Minutes Movesmaster"
    type:sum
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_10 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_25 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_50 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_75 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: round_time_in_minutes_movesmaster_95 {
    group_label: "Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_time_in_minutes_movesmaster ;;
  }
  measure: sum_round_time_in_minutes_puzzle {
    group_label: "Round Time In Minutes Puzzle"
    type:sum
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_10 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_25 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_50 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_75 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: round_time_in_minutes_puzzle_95 {
    group_label: "Round Time In Minutes Puzzle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.round_time_in_minutes_puzzle ;;
  }
  measure: sum_cumulative_round_end_events_campaign {
    group_label: "Cumulative Round End Events Campaign"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_10 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_25 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_50 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_75 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: cumulative_round_end_events_campaign_95 {
    group_label: "Cumulative Round End Events Campaign"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events_campaign ;;
  }
  measure: sum_cumulative_round_end_events_movesmaster {
    group_label: "Cumulative Round End Events Movesmaster"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_10 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_25 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_50 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_75 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: cumulative_round_end_events_movesmaster_95 {
    group_label: "Cumulative Round End Events Movesmaster"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events_movesmaster ;;
  }
  measure: sum_cumulative_round_end_events_puzzle {
    group_label: "Cumulative Round End Events Puzzle"
    type:sum
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_10 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_25 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_50 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_75 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: cumulative_round_end_events_puzzle_95 {
    group_label: "Cumulative Round End Events Puzzle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_end_events_puzzle ;;
  }
  measure: sum_cumulative_round_time_in_minutes {
    group_label: "Cumulative Round Time In Minutes"
    type:sum
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_10 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_25 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_50 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_75 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: cumulative_round_time_in_minutes_95 {
    group_label: "Cumulative Round Time In Minutes"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_time_in_minutes ;;
  }
  measure: sum_cumulative_round_time_in_minutes_campaign {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type:sum
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_10 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_25 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_50 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_75 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: cumulative_round_time_in_minutes_campaign_95 {
    group_label: "Cumulative Round Time In Minutes Campaign"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_time_in_minutes_campaign ;;
  }
  measure: sum_cumulative_round_time_in_minutes_movesmaster {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type:sum
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_10 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_25 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_50 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_75 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: cumulative_round_time_in_minutes_movesmaster_95 {
    group_label: "Cumulative Round Time In Minutes Movesmaster"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_time_in_minutes_movesmaster ;;
  }
  measure: sum_cumulative_round_time_in_minutes_puzzle {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type:sum
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_10 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_25 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_50 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_75 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }
  measure: cumulative_round_time_in_minutes_puzzle_95 {
    group_label: "Cumulative Round Time In Minutes Puzzle"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_round_time_in_minutes_puzzle ;;
  }


}
