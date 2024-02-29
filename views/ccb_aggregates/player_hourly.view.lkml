view: player_hourly {
# # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-05-19'

-- create or replace table tal_scratch.player_hourly_base_data as

      WITH

      ------------------------------------------------------------------------
      -- Select all columns w/ the current date range
      ------------------------------------------------------------------------

      base_data AS (

        SELECT
          timestamp as timestamp_utc
          , created_at
          , platform
          , country
          , version
          , user_type
          , session_id
          , event_name
          , extra_json
          , ltv
          , currencies
          , experiments
          , rdg_id
          , device_id
          , social_id
          , `language` as language_json
          , install_version
          , engagement_ticks
          , quests_completed
          , session_count
          , advertising_id
          , display_name
          , last_level_id
          , last_level_serial
          , win_streak
          , user_id
          , hardware
          , devices
        FROM
          `eraser-blast.game_data.events` a
        WHERE
          ------------------------------------------------------------------------
          -- Date selection
          -- last 9 full days
          -- up to 1 hour ago
          ------------------------------------------------------------------------

          -- select DATE_ADD(timestamp_trunc(current_timestamp, hour), INTERVAL 0 hour)
          DATE(timestamp) >= DATE_ADD(CURRENT_DATE(), INTERVAL -9 DAY)
          AND timestamp < DATE_ADD(timestamp_trunc(current_timestamp, hour), INTERVAL 0 hour)

          ------------------------------------------------------------------------
          -- user type selection
          -- We only want users that are marked as "external"
          -- This removes any bots or internal QA accounts
          ------------------------------------------------------------------------
          AND user_type = 'external'
      )

      -- SELECT * FROM base_data

      ------------------------------------------------------------------------
      -- pre aggregate calculations from base data
      ------------------------------------------------------------------------

      , pre_aggregate_calculations_from_base_data AS (

        SELECT
          -------------------------------------------------
          -- Unique Fields
          -------------------------------------------------

          TIMESTAMP(DATE(timestamp_utc)) AS rdg_date
          , timestamp_trunc(timestamp_utc, hour) as rdg_date_hour

          , rdg_id

          -------------------------------------------------
          -- General player info
          -------------------------------------------------

          -- device_id
          , FIRST_VALUE(device_id) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) device_id

          -- advertising_id
          , FIRST_VALUE(advertising_id) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) advertising_id

          -- user_id
          , FIRST_VALUE(user_id) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) user_id

          -- platform
          , FIRST_VALUE(platform) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) platform

          -- country
          , FIRST_VALUE(country) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) country

          -- created_utc
          , FIRST_VALUE(created_at) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) created_utc

          -- created_date
          , FIRST_VALUE(DATE(created_at)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) created_date

        -- created_hour
        -- timestamp_trunc(current_timestamp, hour)
          , FIRST_VALUE(timestamp_trunc(created_at, hour)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) created_hour

          -- experiements
          -- uses LAST value rather than first value
          , LAST_VALUE(experiments) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) experiments

          -- display_name
          -- uses LAST value rather than first value
          , LAST_VALUE(display_name) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) display_name

          -- version
          -- uses LAST value rather than first value
          , LAST_VALUE(version) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) version

          -- install_version
          , FIRST_VALUE(install_version) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) install_version

          -------------------------------------------------
          -- Dollar Events
          -------------------------------------------------

          -- mtx purchase dollars
          , safe_cast(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_01' -- real dollars
              AND (
                JSON_EXTRACT_SCALAR(extra_json,"$.rvs_id") LIKE '%GPA%' -- check for valid transactions on Google Play
                OR JSON_EXTRACT_SCALAR(extra_json,"$.rvs_id") LIKE '%AppleAppStore%' -- check for valid transactions on Apple
                )
              THEN IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS NUMERIC) * 0.01 * 0.70 ,0) -- purchase amount + app store cut
              ELSE 0
              END AS NUMERIC) AS mtx_purchase_dollars

          -- ad view dollars
          , safe_cast(CASE
              WHEN event_name = 'ad'
              THEN
                IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.publisher_revenue_per_impression") AS NUMERIC),0) -- revenue per impression
                + IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.revenue") AS NUMERIC),0) -- revenue per impression
              ELSE 0
              END AS NUMERIC) AS ad_view_dollars

          -- ltv from data (for checking)
          , LAST_VALUE(ltv) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) mtx_ltv_from_data_in_cents

          -------------------------------------------------
          -- additional ads information
          -------------------------------------------------

          -- ad views
          , safe_cast(CASE
              WHEN event_name = 'ad'
              THEN 1 -- revenue per impression
              ELSE 0
              END AS INT64) AS ad_view_indicator

          -------------------------------------------------
          -- session/play info
          -------------------------------------------------

          -- session_id (for count distinct sessions played)
          , session_id

          -- cumulative session count
          , LAST_VALUE(session_count) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) cumulative_session_count

          -- cumulative engagement ticks
          , LAST_VALUE(engagement_ticks) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) cumulative_engagement_ticks

          -- round start events
          , safe_cast(CASE
              WHEN event_name = 'round_start'
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_start_events

          -- round end events
          , safe_cast(CASE
              WHEN event_name = 'round_end'
              THEN 1 -- count events
              ELSE 0
              END AS INT64) AS round_end_events

          -- Lowest Last level serial recorded
          , MIN(IFNULL(safe_cast(last_level_serial AS INT64),0)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              )
              AS lowest_last_level_serial

          -- Highest Last level serial recorded
          , MAX(IFNULL(safe_cast(last_level_serial AS INT64),0)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS highest_last_level_serial

          -- Highest quests completed recorded
          , MAX(safe_cast(quests_completed AS INT64)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS highest_quests_completed

          -------------------------------------------------
          -- currency spend info
          -------------------------------------------------

          -- gems_spend
          , safe_cast(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_02' -- gems
              THEN IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS gems_spend

          -- coins spend
          , safe_cast(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_03' -- coins currency
              THEN IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS coins_spend

          -- lives spend
          -- NOTE: I'm currently just estimating this using a round end at a loss
          -- This may be incorrect if the round end does not cost a life
          -- , CAST(CASE
          --     WHEN event_name = 'round_end'
          --     AND IFNULL(CAST(JSON_EXTRACT_SCALAR(extra_json,"$.proximity_to_completion") AS NUMERIC),1) < 1 -- Incomplete Round
          --     THEN 1
          --     ELSE 0
          --     END AS INT64) AS lives_spend

          -- star spend
          , CAST(CASE
              WHEN event_name = 'transaction'
              AND JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_currency") = 'CURRENCY_07' -- star currency
              THEN IFNULL(safe_cast(JSON_EXTRACT_SCALAR(extra_json,"$.transaction_purchase_amount") AS INT64),0) -- purchase amount
              ELSE 0
              END AS INT64) AS stars_spend

          -------------------------------------------------
          -- ending currency balances
          -------------------------------------------------

          -- ending_gems_balance
          , LAST_VALUE(IFNULL(safe_cast(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_02") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_gems_balance

          -- ending_coins_balance
          , LAST_VALUE(IFNULL(safe_cast(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_03") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_coins_balance

          -- ending_lives_balance
          , LAST_VALUE(IFNULL(safe_cast(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_04") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_lives_balance

          -- ending_stars_balance
          , LAST_VALUE(IFNULL(safe_cast(JSON_EXTRACT_SCALAR(currencies,"$.CURRENCY_07") AS NUMERIC),0)) OVER (
              PARTITION BY rdg_id, timestamp_trunc(timestamp_utc, hour)
              ORDER BY timestamp_utc ASC
              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
              ) AS ending_stars_balance

          -------------------------------------------------
          -- system info
          -------------------------------------------------

          , safe_cast(case
              when event_name = 'system_info'
              then hardware
              else null
              end as string) as hardware

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.processorType")
              else null
              end as string) as processor_type

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.graphicsDeviceName")
              else null
              end as string) as graphics_device_name

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.deviceModel")
              else null
              end as string) as device_model

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.systemMemorySize")
              else null
              end as int64) as system_memory_size

          , safe_cast(case
              when event_name = 'system_info'
              then json_extract_scalar(extra_json, "$.graphicsMemorySize")
              else null
              end as int64) as graphics_memory_size

          , (select
                string_agg(
                    safe_cast(json_extract_scalar(device_array, '$.screenWidth') as string)
                    , ' ,' )
                from
                    unnest(json_extract_array(devices)) device_array
                ) screen_width

          , (select
                string_agg(
                    safe_cast(json_extract_scalar(device_array, '$.screenHeight') as string)
                    , ' ,' )
                from
                    unnest(json_extract_array(devices)) device_array
                ) screen_height


        FROM
          base_data
      )

      ------------------------------------------------------------------------
      -- Summary
      ------------------------------------------------------------------------

      , summarize_data as (

          SELECT
          rdg_date
          , rdg_date_hour
          , rdg_id
          , MAX(device_id) AS device_id
          , MAX(advertising_id) AS advertising_id
          , MAX(user_id) AS user_id
          , max(display_name) as display_name
          , MAX(platform) AS platform
          , MAX(country) AS country
          , MAX(created_utc) AS created_utc
          , MAX(created_date) AS created_date
          , MAX(created_hour) as created_hour
          , MAX(experiments) AS experiments
          , MAX(version) AS version
          , MAX(install_version) AS install_version
          , SUM(mtx_purchase_dollars) AS mtx_purchase_dollars
          , SUM(ad_view_dollars) AS ad_view_dollars
          , MAX(CAST( ( mtx_ltv_from_data_in_cents * 0.01 * 0.70 )  AS NUMERIC)) AS mtx_ltv_from_data -- Includes app store adjustment
          , SUM(ad_view_indicator) AS ad_views
          , COUNT(DISTINCT session_id) AS count_sessions
          , MAX(cumulative_session_count) AS cumulative_session_count
          , MAX(cumulative_engagement_ticks) AS cumulative_engagement_ticks
          , SUM(round_start_events) AS round_start_events
          , SUM(round_end_events) AS round_end_events
          , MAX(lowest_last_level_serial) AS lowest_last_level_serial
          , MAX(highest_last_level_serial) AS highest_last_level_serial
          , MAX(highest_quests_completed) AS highest_quests_completed
          , SUM(gems_spend) AS gems_spend
          , SUM(coins_spend) AS coins_spend
          , SUM(stars_spend) AS stars_spend
          , MAX(ending_gems_balance) AS ending_gems_balance
          , MAX(ending_coins_balance) AS ending_coins_balance
          , MAX(ending_lives_balance) AS ending_lives_balance
          , MAX(ending_stars_balance) AS ending_stars_balance

          -- system_info
          , max( hardware ) as hardware
          , max( processor_type ) as processor_type
          , max( graphics_device_name ) as graphics_device_name
          , max( device_model ) as device_model
          , max( system_memory_size ) as system_memory_size
          , max( graphics_memory_size ) as graphics_memory_size
          , max( screen_width ) as screen_width
          , max( screen_height ) as screen_height

          from
          pre_aggregate_calculations_from_base_data
          group by
          1,2,3
      )

      ------------------------------------------------------------------------
      -- add on new player indicator
      ------------------------------------------------------------------------

      select
          *
          , case
              when rdg_date_hour = created_hour
              then rdg_id
              else null
              end as new_player_rdg_id
          , 0.5 * ( IFNULL(cumulative_engagement_ticks,0) ) AS cumulative_time_played_minutes
      from
          summarize_data




      ;;
    sql_trigger_value: select DATE_ADD(timestamp_trunc(current_timestamp, hour), INTERVAL -1 hour) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date_hour"]
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.rdg_date_hour
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Dimensions
####################################################################

  dimension: rdg_id {type: string}
  dimension: display_name {type: string}
  dimension: region {type:string sql:@{country_region};;}
  dimension: country {type:string}
  dimension: version {type: number}

  dimension: spender_flag {
    label: "IAP Spender Indicator"
    type: number
    sql: case when ${TABLE}.mtx_ltv_from_data > 0 then 1 else 0 end
    ;;
  }

  dimension: new_spender_flag {
    label: "New IAP Spender Indicator"
    type: number
    sql: case
          when
            round(${TABLE}.mtx_ltv_from_data,2) > 0
            and round(${TABLE}.mtx_ltv_from_data,2) = round(${TABLE}.mtx_purchase_dollars,2)
          then 1
          else 0
          end
      ;;
  }

  measure: max_highest_last_level_serial {
    type: number
    label: "Highest Level"
    sql: max(${TABLE}.highest_last_level_serial) ;;
  }

  measure: max_mtx_ltv_from_data {
    type: number
    label: "LTV - IAP"
    sql: max(${TABLE}.mtx_ltv_from_data) ;;
  }

  measure: max_minutes_played {
    type: number
    label: "Minutes Played"
    sql: max(${TABLE}.cumulative_engagement_ticks * 0.5) ;;
  }

  # # Define your dimensions and measures here, like this:
  dimension_group: rdg_date_analysis {
    group_label: "Time Frames"
    label: "Activity Hour"
    type: time
    timeframes: [hour, date, week, month, year]
    sql: ${TABLE}.rdg_date_hour ;;
  }
  # # Define your dimensions and measures here, like this:
  dimension_group: install_hour {
    group_label: "Time Frames"
    label: "Install Hour"
    type: time
    timeframes: [time_of_day, hour, date, week, month, year]
    sql: ${TABLE}.created_hour ;;
  }

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

  measure: count_distinct_new_spender_rdg_id {
    group_label: "Unique Player Counts"
    label: "New Spenders"
    type: number
    value_format_name: decimal_0
    drill_fields: [rdg_id, display_name]
    sql:
      count(distinct
        case
          when
            round(${TABLE}.mtx_ltv_from_data,2) > 0
            and round(${TABLE}.mtx_ltv_from_data,2) = round(${TABLE}.mtx_purchase_dollars,2)
          then ${TABLE}.rdg_id
          else null
          end
          );;
  }


  ## % to Reach Milestones
  measure: engagement_milestone_5_minutes {
    label: "5+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 5
          then ${TABLE}.new_player_rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.new_player_rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  ## % to Reach Milestones
  measure: engagement_milestone_15_minutes {
    label: "15+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 15
          then ${TABLE}.new_player_rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.new_player_rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

## % to Reach Milestones
  measure: engagement_milestone_30_minutes {
    label: "30+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 30
          then ${TABLE}.new_player_rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.new_player_rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: sum_mtx_purchase_dollars {
    label: "Sum IAP Dollars"
    group_label: "Dollars"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.mtx_purchase_dollars ;;
  }

  measure: sum_ad_view_dollars {
    label: "Sum IAA Dollars"
    group_label: "Dollars"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.ad_view_dollars ;;
  }

  parameter: selected_experiment {
    type: string
    suggestions:  [
      "$.dynamicDropBiasv2_20230423"
      ,"$.puzzleEventv2_20230421"
      ,"$.bigBombs_20230410"
      ,"$.boardClear_20230410"
      ,"$.iceCreamOrder_20230419"
      ,"$.diceGame_20230419"
      ,"$.fueUnlocks_20230419"
      ,"$.No_AB_Test_Split"
      ,"$.haptic_20230326"
      ,"$.dynamicDropBias_20230329"
      ,"$.moldBehavior_20230329"
      ,"$.strawSkills_20230331"
      ,"$.mustardSingleClear_20230329"
      ,"$.puzzleEvent_20230318"
      ,"$.extraMoves_20230313"
      ,"$.fastLifeTimer_20230313"
      ,"$.frameRate_20230302"
      ,"$.navBar_20230228"
      ,"$.altFUE2_20221011"
      ,"$.altFUE2v2_20221024"
      ,"$.altFUE2v3_20221031"
      ,"$.autoPurchase_20221017"
      ,"$.blockSymbols_20221017"
      ,"$.blockSymbolFrames_20221027"
      ,"$.blockSymbolFrames2_20221109"
      ,"$.boardColor_01122023"
      ,"$.collection_01192023"
      ,"$.difficultyStars_09202022"
      ,"$.dynamicRewards_20221018"
      ,"$.extraMovesCurrency_20221017"
      ,"$.flourFrenzy_20221215"
      ,"$.fueDismiss_20221010"
      ,"$.fue00_v3_01182023"
      ,"$.gridGravity_20221003"
      ,"$.gridGravity2_20221012"
      ,"$.livesTimer_01092023"
      ,"$.MMads_01052023"
      ,"$.mMStreaks_09302022"
      ,"$.mMStreaksv2_20221031"
      ,"$.newLevelPass_20220926"
      ,"$.pizzaTime_01192023"
      ,"$.seedTest_20221028"
      ,"$.storeUnlock_20221102"
      ,"$.treasureTrove_20221114"
      ,"$.u2aFUE20221115"
      ,"$.u2ap2_FUE20221209"
      ,"$.vfxReduce_20221017"
      ,"$.vfxReduce_2_20221024"
      ,"$.zoneOrder2_09302022"
      ,"$.zoneStarCosts_09222022"]
  }

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  dimension: ending_coins_balance {type: number}

}
