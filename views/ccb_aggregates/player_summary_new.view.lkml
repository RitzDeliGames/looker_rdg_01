view: player_summary_new {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      WITH

            -----------------------------------------------------------------------
            -- Get base data
            -----------------------------------------------------------------------

            base_data AS (
              SELECT
                *
                , MAX(DATE(rdg_date)) OVER (
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                ) latest_update

              FROM
                `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`

            )


            -----------------------------------------------------------------------
            -- Get values from player summary
            -----------------------------------------------------------------------

            , pre_aggregate_calculations_from_base_data AS (

            SELECT

                rdg_id

                , latest_update

                -- device_id
                , FIRST_VALUE(device_id) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) device_id

                -- advertising_id
                , FIRST_VALUE(advertising_id) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) advertising_id

                -- user_id
                , FIRST_VALUE(user_id) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) user_id

                -- platform
                , FIRST_VALUE(platform) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) platform

                -- country
                , FIRST_VALUE(country) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) country

                -- created_utc
                , FIRST_VALUE(created_utc) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) created_utc

                -- created_date
                , FIRST_VALUE(created_date) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) created_date

                -- experiments
                , FIRST_VALUE(experiments) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) experiments

                -- install_version
                , FIRST_VALUE(install_version) OVER (
                  PARTITION BY rdg_id
                  ORDER BY rdg_date ASC
                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                  ) install_version

                -- d0_cumulative_mtx_purchase_dollars
                , MAX( CASE
                        WHEN DATE_DIFF(latest_update,created_date,DAY) >= 0
                        AND days_since_created <= 0
                        THEN cumulative_mtx_purchase_dollars
                        ELSE NULL END ) OVER (
                    PARTITION BY rdg_id
                    ORDER BY rdg_date ASC
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) AS d0_cumulative_mtx_purchase_dollars

                -- d1_cumulative_mtx_purchase_dollars
                , MAX( CASE
                        WHEN DATE_DIFF(latest_update,created_date,DAY) >= 1
                        AND days_since_created <= 1
                        THEN cumulative_mtx_purchase_dollars
                        ELSE NULL END ) OVER (
                    PARTITION BY rdg_id
                    ORDER BY rdg_date ASC
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) AS d1_cumulative_mtx_purchase_dollars

                -- d7_cumulative_mtx_purchase_dollars
                , MAX( CASE
                        WHEN DATE_DIFF(latest_update,created_date,DAY) >= 7
                        AND days_since_created <= 7
                        THEN cumulative_mtx_purchase_dollars
                        ELSE NULL END ) OVER (
                    PARTITION BY rdg_id
                    ORDER BY rdg_date ASC
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) AS d7_cumulative_mtx_purchase_dollars

                -- d14_cumulative_mtx_purchase_dollars
                , MAX( CASE
                        WHEN DATE_DIFF(latest_update,created_date,DAY) >= 14
                        AND days_since_created <= 14
                        THEN cumulative_mtx_purchase_dollars
                        ELSE NULL END ) OVER (
                    PARTITION BY rdg_id
                    ORDER BY rdg_date ASC
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) AS d14_cumulative_mtx_purchase_dollars

                -- d30_cumulative_mtx_purchase_dollars
                , MAX( CASE
                        WHEN DATE_DIFF(latest_update,created_date,DAY) >= 30
                        AND days_since_created <= 30
                        THEN cumulative_mtx_purchase_dollars
                        ELSE NULL END ) OVER (
                    PARTITION BY rdg_id
                    ORDER BY rdg_date ASC
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) AS d30_cumulative_mtx_purchase_dollars

                -- d60_cumulative_mtx_purchase_dollars
                , MAX( CASE
                        WHEN DATE_DIFF(latest_update,created_date,DAY) >= 60
                        AND days_since_created <= 60
                        THEN cumulative_mtx_purchase_dollars
                        ELSE NULL END ) OVER (
                    PARTITION BY rdg_id
                    ORDER BY rdg_date ASC
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) AS d60_cumulative_mtx_purchase_dollars

                -- current_cumulative_mtx_purchase_dollars
                , MAX( cumulative_mtx_purchase_dollars ) OVER (
                    PARTITION BY rdg_id
                    ORDER BY rdg_date ASC
                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                    ) AS current_cumulative_mtx_purchase_dollars

               -- d0_cumulative_ad_view_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 0
                       AND days_since_created <= 0
                       THEN cumulative_ad_view_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d0_cumulative_ad_view_dollars

               -- d1_cumulative_ad_view_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 1
                       AND days_since_created <= 1
                       THEN cumulative_ad_view_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d1_cumulative_ad_view_dollars


               -- d7_cumulative_ad_view_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 7
                       AND days_since_created <= 7
                       THEN cumulative_ad_view_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d7_cumulative_ad_view_dollars


               -- d14_cumulative_ad_view_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 14
                       AND days_since_created <= 14
                       THEN cumulative_ad_view_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d14_cumulative_ad_view_dollars


               -- d30_cumulative_ad_view_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 30
                       AND days_since_created <= 30
                       THEN cumulative_ad_view_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d30_cumulative_ad_view_dollars


               -- d60_cumulative_ad_view_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 60
                       AND days_since_created <= 60
                       THEN cumulative_ad_view_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d60_cumulative_ad_view_dollars


               -- current_cumulative_ad_view_dollars
               , MAX( cumulative_ad_view_dollars ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS current_cumulative_ad_view_dollars

              -- d0_cumulative_combined_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 0
                       AND days_since_created <= 0
                       THEN cumulative_combined_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d0_cumulative_combined_dollars

               -- d1_cumulative_combined_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 1
                       AND days_since_created <= 1
                       THEN cumulative_combined_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d1_cumulative_combined_dollars


               -- d7_cumulative_combined_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 7
                       AND days_since_created <= 7
                       THEN cumulative_combined_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d7_cumulative_combined_dollars


               -- d14_cumulative_combined_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 14
                       AND days_since_created <= 14
                       THEN cumulative_combined_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d14_cumulative_combined_dollars


               -- d30_cumulative_combined_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 30
                       AND days_since_created <= 30
                       THEN cumulative_combined_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d30_cumulative_combined_dollars


               -- d60_cumulative_combined_dollars
               , MAX( CASE
                       WHEN DATE_DIFF(latest_update,created_date,DAY) >= 60
                       AND days_since_created <= 60
                       THEN cumulative_combined_dollars
                       ELSE NULL END ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS d60_cumulative_combined_dollars


               -- current_cumulative_combined_dollars
               , MAX( cumulative_combined_dollars ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS current_cumulative_combined_dollars

               -- current_cumulative_combined_dollars
               , MAX( mtx_ltv_from_data ) OVER (
                   PARTITION BY rdg_id
                   ORDER BY rdg_date ASC
                   ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
                   ) AS mtx_ltv_from_data


            FROM
              base_data

            )

            -----------------------------------------------------------------------
            -- Summarize Data
            -----------------------------------------------------------------------

            , summarize_data AS (

              SELECT
                  rdg_id
                  , MAX(latest_update) AS latest_update
                  , MAX(device_id) AS device_id
                  , MAX(advertising_id) AS advertising_id
                  , MAX(user_id) AS user_id
                  , MAX(platform) AS platform
                  , MAX(country) AS country
                  , MAX(created_utc) AS created_utc
                  , MAX(created_date) AS created_date
                  , MAX(experiments) AS experiments
                  , MAX(install_version) AS install_version
                  , MAX(d0_cumulative_mtx_purchase_dollars) AS d0_cumulative_mtx_purchase_dollars
                  , MAX(d1_cumulative_mtx_purchase_dollars) AS d1_cumulative_mtx_purchase_dollars
                  , MAX(d7_cumulative_mtx_purchase_dollars) AS d7_cumulative_mtx_purchase_dollars
                  , MAX(d14_cumulative_mtx_purchase_dollars) AS d14_cumulative_mtx_purchase_dollars
                  , MAX(d30_cumulative_mtx_purchase_dollars) AS d30_cumulative_mtx_purchase_dollars
                  , MAX(d60_cumulative_mtx_purchase_dollars) AS d60_cumulative_mtx_purchase_dollars
                  , MAX(current_cumulative_mtx_purchase_dollars) AS current_cumulative_mtx_purchase_dollars
                  , MAX(d0_cumulative_ad_view_dollars) AS d0_cumulative_ad_view_dollars
                  , MAX(d1_cumulative_ad_view_dollars) AS d1_cumulative_ad_view_dollars
                  , MAX(d7_cumulative_ad_view_dollars) AS d7_cumulative_ad_view_dollars
                  , MAX(d14_cumulative_ad_view_dollars) AS d14_cumulative_ad_view_dollars
                  , MAX(d30_cumulative_ad_view_dollars) AS d30_cumulative_ad_view_dollars
                  , MAX(d60_cumulative_ad_view_dollars) AS d60_cumulative_ad_view_dollars
                  , MAX(current_cumulative_ad_view_dollars) AS current_cumulative_ad_view_dollars
                  , MAX(d0_cumulative_combined_dollars) AS d0_cumulative_combined_dollars
                  , MAX(d1_cumulative_combined_dollars) AS d1_cumulative_combined_dollars
                  , MAX(d7_cumulative_combined_dollars) AS d7_cumulative_combined_dollars
                  , MAX(d14_cumulative_combined_dollars) AS d14_cumulative_combined_dollars
                  , MAX(d30_cumulative_combined_dollars) AS d30_cumulative_combined_dollars
                  , MAX(d60_cumulative_combined_dollars) AS d60_cumulative_combined_dollars
                  , MAX(current_cumulative_combined_dollars) AS current_cumulative_combined_dollars
                  , MAX(mtx_ltv_from_data) AS mtx_ltv_from_data
              FROM
                pre_aggregate_calculations_from_base_data
              GROUP BY
                1

            )

            -----------------------------------------------------------------------
            -- Select output
            -----------------------------------------------------------------------

            SELECT
              *
            FROM
              summarize_data
            ;;
    datagroup_trigger: dependent_on_player_daily_incremental
    publish_as_db_view: yes
    partition_keys: ["created_date"]

  }

################################################################
## Dimensions
################################################################

  dimension_group: created_date_analysis {
    description: "date as defined by rdg_date function"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  dimension: created_date {
    type: date
  }

# MAX(install_version) AS install_version
  dimension: install_version {
    type: string
    sql: ${TABLE}.install_version
      ;;
  }

################################################################
## Measures
################################################################

  #####################################
  ## Sum Dollars
  #####################################

  # d0_cumulative_mtx_purchase_dollars
  measure: sum_d0_cumulative_mtx_purchase_dollars {
    description: "Sum of MTX dollars"
    type: sum
    sql: ${TABLE}.sum_d0_cumulative_mtx_purchase_dollars ;;
  }

  #####################################
  ## Player Counts
  #####################################

  measure: count_distinct_players {
    description: "Use this for counting unique players"
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }


}
