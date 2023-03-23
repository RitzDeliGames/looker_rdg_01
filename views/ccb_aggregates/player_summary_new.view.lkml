view: player_summary_new {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-03-23'


      -- CREATE OR REPLACE TABLE `tal_scratch.player_summary` AS

      WITH

      -----------------------------------------------------------------------
      -- Get base data
      -----------------------------------------------------------------------

      latest_update_table AS (
        SELECT
          MAX(DATE(rdg_date)) AS latest_update

        FROM
          `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`

      )


      -----------------------------------------------------------------------
      -- Get values from player summary
      -----------------------------------------------------------------------

      , pre_aggregate_calculations_from_base_data AS (

      SELECT

          rdg_id
          , latest_update_table.latest_update
          , days_since_created
          , day_number
          , rdg_date
          , version
          , cumulative_mtx_purchase_dollars
          , cumulative_ad_view_dollars
          , cumulative_combined_dollars
          , mtx_ltv_from_data
          , highest_last_level_serial
          , cumulative_star_spend
          , cumulative_time_played_minutes

          -- device_id
          , last_value(device_id) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) device_id

          -- advertising_id
          , last_value(advertising_id) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) advertising_id

          -- user_id
          , first_value(user_id) over (
            partition by  rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) user_id

          -- display_name
          , last_value(display_name) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) display_name

          -- platform
          , last_value(platform) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) platform

          -- country
          , last_value(country) OVER (
            PARTITION BY rdg_id
            ORDER BY rdg_date ASC
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
            ) country

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

          -------------------------------------------------------------------
          -- system info
          -------------------------------------------------------------------

          , last_value(hardware) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) hardware

          , last_value(processor_type) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) processor_type

          , last_value(graphics_device_name) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) graphics_device_name

            , last_value(device_model) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) device_model

            , last_value(system_memory_size) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) system_memory_size

            , last_value(graphics_memory_size) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) graphics_memory_size

            , last_value(screen_width) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) screen_width

              , last_value(screen_height) over (
            partition by rdg_id
            order by rdg_date ASC
            rows between unbounded preceding and unbounded following
            ) screen_height


      FROM
        `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary`
        , latest_update_table

      )

      -----------------------------------------------------------------------
      -- Summarize Data
      -----------------------------------------------------------------------

      , summarize_data AS (

        select
            rdg_id
            , max(rdg_date) as last_played_date
            , max(latest_update) as latest_table_update
            , max(device_id) as device_id
            , max(advertising_id) as advertising_id
            , max(user_id) as user_id
            , max(display_name) as display_name
            , max(platform) as platform
            , max(country) as country
            , max(timestamp(created_date)) as created_date
            , max(date_diff(latest_update,created_date,DAY) + 1) as max_available_day_number
            , max(experiments) AS experiments
            , max(cumulative_time_played_minutes) as cumulative_time_played_minutes

            -- versions
            , max(install_version) AS version_at_install
            , max( case when day_number <= 2 then version else null end ) as version_d2
            , max( case when day_number <= 7 then version else null end ) as version_d7
            , max( case when day_number <= 14 then version else null end ) as version_d14
            , max( case when day_number <= 30 then version else null end ) as version_d30
            , max( case when day_number <= 60 then version else null end ) as version_d60
            , max( version ) as version_current

           -- mtx dollars
           , max( case when day_number <= 1 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d1
           , max( case when day_number <= 2 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d2
           , max( case when day_number <= 7 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d7
           , max( case when day_number <= 14 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d14
           , max( case when day_number <= 30 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d30
           , max( case when day_number <= 60 then cumulative_mtx_purchase_dollars else 0 end ) as cumulative_mtx_purchase_dollars_d60
           , max( cumulative_mtx_purchase_dollars ) as cumulative_mtx_purchase_dollars_current
           , max(mtx_ltv_from_data) as mtx_ltv_from_data

           -- ad view dollars
           , max( case when day_number <= 1 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d1
           , max( case when day_number <= 2 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d2
           , max( case when day_number <= 7 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d7
           , max( case when day_number <= 14 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d14
           , max( case when day_number <= 30 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d30
           , max( case when day_number <= 60 then cumulative_ad_view_dollars else 0 end ) as cumulative_ad_view_dollars_d60
           , max( cumulative_ad_view_dollars ) as cumulative_ad_view_dollars_current

           -- combined dollars
           , max( case when day_number <= 1 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d1
           , max( case when day_number <= 2 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d2
           , max( case when day_number <= 7 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d7
           , max( case when day_number <= 14 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d14
           , max( case when day_number <= 30 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d30
           , max( case when day_number <= 60 then cumulative_combined_dollars else 0 end ) as cumulative_combined_dollars_d60
           , max( cumulative_combined_dollars ) as cumulative_combined_dollars_current

           -- highest last level serial
           , max( case when day_number <= 1 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d1
           , max( case when day_number <= 2 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d2
           , max( case when day_number <= 7 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d7
           , max( case when day_number <= 14 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d14
           , max( case when day_number <= 30 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d30
           , max( case when day_number <= 60 then highest_last_level_serial else 0 end ) as highest_last_level_serial_d60
           , max( highest_last_level_serial ) as highest_last_level_serial_current

          -- retention
          , max( case when day_number = 2 then 1 else 0 end ) as retention_d2
          , max( case when day_number = 7 then 1 else 0 end ) as retention_d7
          , max( case when day_number = 14 then 1 else 0 end ) as retention_d14
          , max( case when day_number = 30 then 1 else 0 end ) as retention_d30
          , max( case when day_number = 60 then 1 else 0 end ) as retention_d60

          -- cumulative star spend
          , max( case when day_number <= 1 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d1
          , max( case when day_number <= 2 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d2
          , max( case when day_number <= 7 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d7
          , max( case when day_number <= 14 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d14
          , max( case when day_number <= 30 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d30
          , max( case when day_number <= 60 then cumulative_star_spend else 0 end ) as cumulative_star_spend_d60
          , max( cumulative_star_spend ) as cumulative_star_spend_current

          -- system_info
          , max( hardware ) as hardware
          , max( processor_type ) as processor_type
          , max( graphics_device_name ) as graphics_device_name
          , max( device_model ) as device_model
          , max( system_memory_size ) as system_memory_size
          , max( graphics_memory_size ) as graphics_memory_size
          , max( screen_width ) as screen_width
          , max( screen_height ) as screen_height

        FROM
          pre_aggregate_calculations_from_base_data
        GROUP BY
          1

      )

      -----------------------------------------------------------------------
      -- calculate spender percentile
      -----------------------------------------------------------------------

      , percentile_current_cumulative_mtx_purchase_dollars_table AS (

        SELECT
          rdg_id
          , FLOOR(100*CUME_DIST() OVER (
              ORDER BY cumulative_mtx_purchase_dollars_current
              )) cumulative_mtx_purchase_dollars_current_percentile
        FROM
          summarize_data
        WHERE
          cumulative_mtx_purchase_dollars_current > 0
      )

      -----------------------------------------------------------------------
      -- firebase player summary
      -----------------------------------------------------------------------

      , firebase_player_summary as (

        select
            firebase_user_id
            , max(last_played_date) as last_played_date
            , max(latest_table_update) as latest_table_update
            , max(firebase_advertising_id) as firebase_advertising_id
            , max(firebase_platform) as firebase_platform
            , max(firebase_created_date) as firebase_created_date

        FROM
          `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_summary`
        GROUP BY
          1

      )

      -----------------------------------------------------------------------
      -- singular_player_summary pre aggregate
      -----------------------------------------------------------------------

      , singular_player_summary_pre_aggregate as (

        select
          device_id as singular_device_id

          -- campaign_id
          , first_value(campaign_id) over (
            partition by  device_id
            order by event_timestamp ASC
            rows between unbounded preceding and unbounded following
            ) singular_campaign_id

          -- singular_partner_name
          , first_value(singular_partner_name) over (
            partition by  device_id
            order by event_timestamp ASC
            rows between unbounded preceding and unbounded following
            ) singular_partner_name
        from
          `eraser-blast.singular.user_level_attributions`
        where
          -- date(event_timestamp) between '2022-05-01' and current_date()
          -- date(etl_record_processing_hour_utc) between '2022-06-01' and current_date()
          -- campaign_id <> '' -- We want to include Unattibuted
          (
              is_reengagement is null
              or is_reengagement = false )


      )

      -----------------------------------------------------------------------
      -- singular_player_summary
      -----------------------------------------------------------------------

      , singular_player_summary as (

        select
          singular_device_id
          , max(singular_campaign_id) as singular_campaign_id
          , max(singular_partner_name) as singular_partner_name
        from
          singular_player_summary_pre_aggregate
        group by
          1
      )

      -----------------------------------------------------------------------
      -- singular_country_code_helper
      -----------------------------------------------------------------------

      , singular_country_code_helper as (

        select
          Alpha_3_code
          , max(country) as singular_country_name
          , max(Alpha_2_code) as singular_country
        from
          `eraser-blast.singular.country_codes`
        group by
          1

      )

      -----------------------------------------------------------------------
      -- singular_campaign_summary
      -----------------------------------------------------------------------

      , singular_campaign_summary as (

        select
          a.adn_campaign_id as singular_campaign_id
          , min( timestamp(a.date) ) as singular_campaign_min_date
          , max( a.adn_campaign_name ) singular_campaign_name
          , max( a.source ) as singular_source
          , max( a.platform ) as singular_platform
          , max( b.singular_country_name ) as singular_country_name
          , max( b.singular_country ) as singular_country
          , sum( cast(a.adn_impressions as int64)) as singular_total_impressions
          , sum( cast(a.adn_cost as float64)) as singular_total_cost
          , sum( cast(a.adn_original_cost as float64)) as singular_total_original_cost
          , sum( cast(a.adn_installs AS int64)) as singular_total_installs
          , safe_divide(
              sum( cast(a.adn_cost as float64))
              , sum( cast(a.adn_installs AS int64)) ) as singular_total_cost_per_install
        from
          `eraser-blast.singular.marketing_data` a
          left join singular_country_code_helper b
            on a.country_field = b.Alpha_3_code
        group by
          1
      )

      -----------------------------------------------------------------------
      -- add on singular data
      -----------------------------------------------------------------------

      -- -- select column_name from `eraser-blast`.tal_scratch.INFORMATION_SCHEMA.COLUMNS where table_name = 'test_player_summary' order by ordinal_position

      , add_on_mtx_percentile_and_singular_data as (

        select
          a.*
          , b.cumulative_mtx_purchase_dollars_current_percentile
          , c.firebase_advertising_id
          , d.singular_device_id
          , d.singular_partner_name
          , e.singular_campaign_id
          , e.singular_campaign_min_date
          , case
              when e.singular_campaign_name is not null then e.singular_campaign_name
              when
                e.singular_campaign_name is null
                and d.singular_device_id is not null then 'Unattributed'
              else null
              end as campaign_name
          , e.singular_source
          , e.singular_platform
          , e.singular_country_name
          , e.singular_country
          , e.singular_total_impressions
          , e.singular_total_cost
          , e.singular_total_original_cost
          , e.singular_total_installs
          , e.singular_total_cost_per_install
        from
          summarize_data A
          left join percentile_current_cumulative_mtx_purchase_dollars_table B
            on A.rdg_id = B.rdg_id
          left join firebase_player_summary c
            on a.user_id = c.firebase_user_id
          left join singular_player_summary d
            on c.firebase_advertising_id = d.singular_device_id
          left join singular_campaign_summary e
            on d.singular_campaign_id = e.singular_campaign_id

      )

      -----------------------------------------------------------------------
      -- Distribute Singular Campaign Costs - All Players
      -----------------------------------------------------------------------

      , singular_campaign_costs_all_players as (

      select
        *
        , sum( singular_total_cost_per_install ) over (
            partition by singular_campaign_id
            rows between unbounded preceding and unbounded following
          ) as total_players_attributed_to_singular_campaign

        , 1 /
          sum( 1 ) over (
            partition by singular_campaign_id
            rows between unbounded preceding and unbounded following
          ) as percentage_of_singular_campaign_cost_attributed

        , singular_total_cost_per_install as singular_campaign_cost_attributed
      from
        add_on_mtx_percentile_and_singular_data
      where
        singular_campaign_id is not null

      )

      -----------------------------------------------------------------------
      -- Add on Singular Stats to the data
      -----------------------------------------------------------------------

      , add_on_singular_stats as (

        select
          a.*
          , b.total_players_attributed_to_singular_campaign
          , b.percentage_of_singular_campaign_cost_attributed
          , b.singular_campaign_cost_attributed

        from
          add_on_mtx_percentile_and_singular_data a
          left join singular_campaign_costs_all_players b
            on a.rdg_id = b.rdg_id

      )

      -----------------------------------------------------------------------
      -- prepare supported_devices table
      -----------------------------------------------------------------------

      , supported_devices_table as (

        select
          retail_name || ' ' || model_name as device_model
          , max(retail_name) as retail_name
          , max(marketing_name) as marketing_name
          , max(device_name) as device_name
          , max(model_name) as model_name
        from
          `eraser-blast.game_data.supported_devices`
        where
          retail_name != "Retail Branding"
        group by
          1
      )

      -----------------------------------------------------------------------
      -- add on supported_devices
      -----------------------------------------------------------------------

      select
        a.*
        , b.retail_name as supported_devices_retail_name
        , b.marketing_name as supported_devices_marketing_name
        , b.device_name as supported_devices_device_name
        , b.model_name as supported_devices_model_name
      from
        add_on_singular_stats a
        left join supported_devices_table b
          on a.device_model = b.device_model




            ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -5 hour)) ;;
    publish_as_db_view: yes
    partition_keys: ["created_date"]

  }


####################################################################
## Primary Key
####################################################################

dimension: primary_key {
  type: string
  sql:
    ${TABLE}.rdg_id
    ;;
  primary_key: yes
  hidden: yes
}

################################################################
## Dimensions
################################################################

  # strings
  dimension: rdg_id {group_label:"Player IDs" type: string}
  dimension: device_id {group_label:"Player IDs" type: string}
  dimension: display_name {group_label:"Player IDs" type: string}
  dimension: advertising_id {group_label:"Player IDs" type: string}
  dimension: user_id {group_label:"Player IDs" type: string}
  dimension: experiments {type: string}
  dimension: version_at_install {type: string}
  dimension: version_d2 {type: string}
  dimension: version_d7 {type: string}
  dimension: version_d14 {type: string}
  dimension: version_d30 {type: string}
  dimension: version_d60 {type: string}
  dimension: version_current {type: string}
  dimension: platform {type: string}
  dimension: country {type: string}
  dimension: region {type:string sql:@{country_region};;}
  dimension: cumulative_time_played_minutes {label:"Minutes Played" value_format:"#,##0" type: number}

  # dates
  dimension_group: last_played_date {
    label: "Last Played"
    type: time
    timeframes: [date, week, month, year]
  }
  dimension_group: created_date {
    group_label: "Install Date"
    label: "Installed On"
    type: time
    timeframes: [date, week, month, year]
  }

  dimension_group: singular_campaign_min_date {
    type: time
    timeframes: [date, week, month, year]
  }

  dimension: highest_played_day_number  {
    type:  number
    sql: DATE_DIFF( DATE(${TABLE}.last_played_date) , DATE( ${TABLE}.created_date ), DAY) + 1 ;;
  }

  # numbers
  dimension: max_available_day_number {type: number}
  dimension: cumulative_mtx_purchase_dollars_d1 {group_label:"LTV - IAPs" type: number}
  dimension: cumulative_mtx_purchase_dollars_d2 {group_label:"LTV - IAPs" type: number}
  dimension: cumulative_mtx_purchase_dollars_d7 {group_label:"LTV - IAPs" type: number}
  dimension: cumulative_mtx_purchase_dollars_d14 {group_label:"LTV - IAPs" type: number}
  dimension: cumulative_mtx_purchase_dollars_d30 {group_label:"LTV - IAPs" type: number}
  dimension: cumulative_mtx_purchase_dollars_d60 {group_label:"LTV - IAPs" type: number}
  dimension: cumulative_mtx_purchase_dollars_current {group_label:"LTV - IAPs" label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_current_percentile {group_label:"LTV - IAPs" type: number}
  dimension: mtx_ltv_from_data {type: number}
  dimension: cumulative_ad_view_dollars_d1 {group_label:"LTV - Ads" type: number}
  dimension: cumulative_ad_view_dollars_d2 {group_label:"LTV - Ads" type: number}
  dimension: cumulative_ad_view_dollars_d7 {group_label:"LTV - Ads" type: number}
  dimension: cumulative_ad_view_dollars_d14 {group_label:"LTV - Ads" type: number}
  dimension: cumulative_ad_view_dollars_d30 {group_label:"LTV - Ads" type: number}
  dimension: cumulative_ad_view_dollars_d60 {group_label:"LTV - Ads" type: number}
  dimension: cumulative_ad_view_dollars_current {group_label:"LTV - Ads" label:"LTV - Ads" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d1 {group_label:"LTV - Cumulative" type: number}
  dimension: cumulative_combined_dollars_d2 {group_label:"LTV - Cumulative" type: number}
  dimension: cumulative_combined_dollars_d7 {group_label:"LTV - Cumulative" type: number}
  dimension: cumulative_combined_dollars_d14 {group_label:"LTV - Cumulative" type: number}
  dimension: cumulative_combined_dollars_d30 {group_label:"LTV - Cumulative" type: number}
  dimension: cumulative_combined_dollars_d60 {group_label:"LTV - Cumulative" type: number}
  dimension: cumulative_combined_dollars_current {group_label:"LTV - Cumulative" label:"LTV - Cumulative" value_format:"$0.00" type: number}
  dimension: highest_last_level_serial_d1 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d2 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d7 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d14 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d30 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d60 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_current {group_label:"Highest Level" label:"Highest Level" type: number}
  dimension: retention_d2 {group_label:"Retention" type: number}
  dimension: retention_d7 {group_label:"Retention" type: number}
  dimension: retention_d14 {group_label:"Retention" type: number}
  dimension: retention_d30 {group_label:"Retention" type: number}
  dimension: retention_d60 {group_label:"Retention" type: number}
  dimension: cumulative_star_spend_d1 {type: number}
  dimension: cumulative_star_spend_d2 {type: number}
  dimension: cumulative_star_spend_d7 {type: number}
  dimension: cumulative_star_spend_d14 {type: number}
  dimension: cumulative_star_spend_d30 {type: number}
  dimension: cumulative_star_spend_d60 {type: number}
  dimension: cumulative_star_spend_current {type: number}

  dimension: firebase_advertising_id {type:string}

  ## system_info
  dimension: hardware {
    group_label: "System Info"
    type: string
    }
  dimension: processor_type {
    group_label: "System Info"
    type: string
    }
  dimension: graphics_device_name {
    group_label: "System Info"
    type: string
    }
  dimension: device_model {
    group_label: "System Info"
    type: string
    }
  dimension: system_memory_size {
    group_label: "System Info"
    type: number
    }
  dimension: graphics_memory_size {
    group_label: "System Info"
    type: number
    }
  dimension: screen_width {
    group_label: "System Info"
    type: number
    }
  dimension: screen_height {
    group_label: "System Info"
    type: number
    }
  dimension: screen_dimensions {
    group_label: "System Info"
    type: string
    sql:
      safe_cast(${TABLE}.screen_width as string)
      || ' x '
      || safe_cast(${TABLE}.screen_height as string) ;;


  }

  # dimension: device_model_mapping {
  #   group_label: "System Info"
  #   type: string
  #   sql: @{device_model_mapping} ;;
  # }

  # dimension: device_manufacturer_mapping {
  #   group_label: "System Info"
  #   type: string
  #   sql: @{device_manufacturer_mapping} ;;
  # }

  # dimension: device_os_version_mapping {
  #   group_label: "System Info"
  #   type: string
  #   sql: @{device_os_version_mapping} ;;
  # }

  dimension: device_platform_mapping {
    group_label: "System Info"
    type: string
    sql: @{device_platform_mapping} ;;
  }

    dimension: supported_devices_retail_name {
      group_label: "System Info"
      type: string
    }
    dimension: supported_devices_marketing_name {
      group_label: "System Info"
      type: string
    }
    dimension: supported_devices_device_name {
      group_label: "System Info"
      type: string
    }
    dimension: supported_devices_model_name {
      group_label: "System Info"
      type: string
    }



################################################################
## Calculated Dimensions
################################################################

# dimension: paid_or_organic {
#   type: string
#   label: "Singluar Mapping"
#   sql:
#     case
#       when ${TABLE}.singular_campaign_id is not null then 'Singular Mapped'
#       when ${TABLE}.campaign_name is 'Unattributed' then 'Singular Mapped'
#       else 'Not Mapped To Singular'
#       end
#   ;;
# }

######################################################################
## Singular Campaign Info
######################################################################

dimension: singular_campaign_name_clean {
  group_label: "Singular Campaign Info"
  label: "Campaign Name (Clean)"
  type: string
  sql: @{campaign_name_clean} ;;
}

dimension: singular_partner_name {
  group_label: "Singular Campaign Info"
  type:string}

dimension: singular_device_id {
  group_label: "Singular Campaign Info"
  type:string}

dimension: singular_campaign_id {
  group_label: "Singular Campaign Info"
  type:string}

dimension: campaign_name {
  group_label: "Singular Campaign Info"
  type:string}

dimension: singular_source {
  group_label: "Singular Campaign Info"
  type:string}

dimension: singular_platform {
  group_label: "Singular Campaign Info"
  type:string}

dimension: singular_country_name {
  group_label: "Singular Campaign Info"
  type:string}

dimension: singular_country {
  group_label: "Singular Campaign Info"
  type:string}

dimension: singular_total_impressions {
  group_label: "Singular Campaign Info"
  type:number}

dimension: singular_total_cost {
  group_label: "Singular Campaign Info"
  type:number}

dimension: singular_total_original_cost {
  group_label: "Singular Campaign Info"
  type:number}

dimension: singular_total_installs {
  group_label: "Singular Campaign Info"
  type:number}

dimension: total_players_attributed_to_singular_campaign {
  group_label: "Singular Campaign Info"
  type:number}

dimension: percentage_of_singular_campaign_cost_attributed {
  group_label: "Singular Campaign Info"
  type:number}

dimension: singular_campaign_cost_attributed {
  group_label: "Singular Campaign Info"
  type:number}


######################################################################
## Expirements
######################################################################

  parameter: selected_experiment {
    type: string
    suggestions:  [
      "$.No_AB_Test_Split"
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

################################################################
## Available Total Revenue
################################################################

  measure: available_combined_dollars_d1 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_combined_dollars_d1
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d2 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_combined_dollars_d2
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d7 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_combined_dollars_d7
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d14 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.cumulative_combined_dollars_d14
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d30 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.cumulative_combined_dollars_d30
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d60 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.cumulative_combined_dollars_d60
          else 0
          end )
    ;;
    value_format_name: usd

  }
################################################################
## Revenue Per Install
################################################################

measure: revenue_per_install_d1 {
  group_label: "Revenue Per Install (RPI)"
  type: number
  sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_combined_dollars_d1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
  value_format_name: usd

}

  measure: revenue_per_install_d2 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_combined_dollars_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

measure: revenue_per_install_d7 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_combined_dollars_d7
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d14 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.cumulative_combined_dollars_d14
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d30 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.cumulative_combined_dollars_d30
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d60 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.cumulative_combined_dollars_d60
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

################################################################
## Retention
################################################################

  measure: average_retention_d2 {
    group_label: "Average Retention"
    label: "D2"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.retention_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: average_retention_d7 {
    group_label: "Average Retention"
    label: "D7"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.retention_d7
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: average_retention_d14 {
    group_label: "Average Retention"
    label: "D14"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.retention_d14
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: average_retention_d30 {
    group_label: "Average Retention"
    label: "D30"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.retention_d30
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: average_retention_d60 {
    group_label: "Average Retention"
    label: "D60"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.retention_d60
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

################################################################
## Return on Ad Spend (ROAS)
################################################################

  measure: return_on_ad_spend_d1 {
    group_label: "Return on Ad Spend (ROAS)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 1
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.cumulative_combined_dollars_d1
          else 0
          end )
      ,
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 1
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
    )
    ;;
    value_format_name: percent_1
  }
  measure: return_on_ad_spend_d2 {
    group_label: "Return on Ad Spend (ROAS)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 2
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.cumulative_combined_dollars_d2
          else 0
          end )
      ,
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 2
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
    )
    ;;
    value_format_name: percent_1
  }

  measure: return_on_ad_spend_d7 {
    group_label: "Return on Ad Spend (ROAS)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 7
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.cumulative_combined_dollars_d7
          else 0
          end )
      ,
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 7
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
    )
    ;;
    value_format_name: percent_1
  }

  measure: return_on_ad_spend_d14 {
    group_label: "Return on Ad Spend (ROAS)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 14
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.cumulative_combined_dollars_d14
          else 0
          end )
      ,
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 14
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
    )
    ;;
    value_format_name: percent_1
  }

  measure: return_on_ad_spend_d30 {
    group_label: "Return on Ad Spend (ROAS)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 30
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.cumulative_combined_dollars_d30
          else 0
          end )
      ,
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 30
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
    )
    ;;
    value_format_name: percent_1
  }

  measure: return_on_ad_spend_d60 {
    group_label: "Return on Ad Spend (ROAS)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 60
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.cumulative_combined_dollars_d60
          else 0
          end )
      ,
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 60
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
    )
    ;;
    value_format_name: percent_1
  }

################################################################
## Unique Player
################################################################

measure: count_distinct_players {
  group_label: "Unique Player Counts"
  label: "Count Distinct Players"
  type: number
  sql:
    count( distinct ${TABLE}.rdg_id )
  ;;
  value_format_name: decimal_0

}

################################################################
## Player Count By Day
################################################################

  measure: available_player_count_d1 {
    group_label: "Available  Player Count"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d2 {
    group_label: "Available  Player Count"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d7 {
    group_label: "Available  Player Count"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d14 {
    group_label: "Available  Player Count"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d30 {
    group_label: "Available  Player Count"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d60 {
    group_label: "Available  Player Count"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

################################################################
## Mean Cost to Acquire
################################################################

  measure: cost_to_acquire_d1 {
    group_label: "Cost to Acquire"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 1
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
      ,
      count( distinct
        case
          when
            ${TABLE}.max_available_day_number >= 1
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd
  }

  measure: cost_to_acquire_d2 {
    group_label: "Cost to Acquire"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 2
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
      ,
      count( distinct
        case
          when
            ${TABLE}.max_available_day_number >= 2
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd
  }

  measure: cost_to_acquire_d7 {
    group_label: "Cost to Acquire"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 7
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
      ,
      count( distinct
        case
          when
            ${TABLE}.max_available_day_number >= 7
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd
  }

  measure: cost_to_acquire_d14 {
    group_label: "Cost to Acquire"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 14
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
      ,
      count( distinct
        case
          when
            ${TABLE}.max_available_day_number >= 14
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd
  }

  measure: cost_to_acquire_d30 {
    group_label: "Cost to Acquire"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 30
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
      ,
      count( distinct
        case
          when
            ${TABLE}.max_available_day_number >= 30
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd
  }

  measure: cost_to_acquire_d60 {
    group_label: "Cost to Acquire"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when
            ${TABLE}.max_available_day_number >= 60
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.singular_campaign_cost_attributed
          else 0
          end )
      ,
      count( distinct
        case
          when
            ${TABLE}.max_available_day_number >= 60
            and ${TABLE}.singular_campaign_cost_attributed > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd
  }

################################################################
## Engagement Milestones
################################################################

  measure: engagement_milestone_5_minutes {
    label: "5+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 5
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_15_minutes {
    label: "15+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 15
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_30_minutes {
    label: "30+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 30
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_60_minutes {
    label: "60+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 60
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

  measure: engagement_milestone_120_minutes {
    label: "120+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 120
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

}
