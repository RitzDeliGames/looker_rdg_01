view: player_summary_new {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-09-26'

      with

      base_data as (

        select
          rdg_id
          , last_played_date
          , latest_table_update
          , device_id
          , advertising_id
          , user_id
          , latest_user_id
          , bfg_uid
          , display_name
          , platform
          , country
          , created_date
          , max_available_day_number
          , case
              when date_diff( date(last_played_date) , date( created_date ), day) + 1 < 1
              then 1
              else date_diff( date(last_played_date) , date( created_date ), day) + 1
              end as highest_played_day_number
          , experiments
          , latest_experiments
          , cumulative_time_played_minutes
          , version_at_install
          , version_d2
          , version_d7
          , version_d14
          , version_d30
          , version_d60
          , version_current
          , cumulative_mtx_purchase_dollars_d1
          , cumulative_mtx_purchase_dollars_d2
          , cumulative_mtx_purchase_dollars_d3
          , cumulative_mtx_purchase_dollars_d4
          , cumulative_mtx_purchase_dollars_d5
          , cumulative_mtx_purchase_dollars_d6
          , cumulative_mtx_purchase_dollars_d7
          , cumulative_mtx_purchase_dollars_d8
          , cumulative_mtx_purchase_dollars_d14
          , cumulative_mtx_purchase_dollars_d15
          , cumulative_mtx_purchase_dollars_d21
          , cumulative_mtx_purchase_dollars_d30
          , cumulative_mtx_purchase_dollars_d31
          , cumulative_mtx_purchase_dollars_d45
          , cumulative_mtx_purchase_dollars_d46
          , cumulative_mtx_purchase_dollars_d60
          , cumulative_mtx_purchase_dollars_d61
          , cumulative_mtx_purchase_dollars_d90
          , cumulative_mtx_purchase_dollars_d120
          , cumulative_mtx_purchase_dollars_d180
          , cumulative_mtx_purchase_dollars_d270
          , cumulative_mtx_purchase_dollars_d360
          , cumulative_mtx_purchase_dollars_current
          , mtx_ltv_from_data
          , cumulative_count_mtx_purchases_d1
          , cumulative_count_mtx_purchases_d2
          , cumulative_count_mtx_purchases_d7
          , cumulative_count_mtx_purchases_d8
          , cumulative_count_mtx_purchases_d14
          , cumulative_count_mtx_purchases_d30
          , cumulative_count_mtx_purchases_d60
          , cumulative_count_mtx_purchases_d90
          , cumulative_count_mtx_purchases_current
          , cumulative_ad_view_dollars_d1
          , cumulative_ad_view_dollars_d2
          , cumulative_ad_view_dollars_d3
          , cumulative_ad_view_dollars_d4
          , cumulative_ad_view_dollars_d5
          , cumulative_ad_view_dollars_d6
          , cumulative_ad_view_dollars_d7
          , cumulative_ad_view_dollars_d8
          , cumulative_ad_view_dollars_d14
          , cumulative_ad_view_dollars_d15
          , cumulative_ad_view_dollars_d21
          , cumulative_ad_view_dollars_d30
          , cumulative_ad_view_dollars_d31
          , cumulative_ad_view_dollars_d46
          , cumulative_ad_view_dollars_d60
          , cumulative_ad_view_dollars_d90
          , cumulative_ad_view_dollars_d120
          , cumulative_ad_view_dollars_d180
          , cumulative_ad_view_dollars_d270
          , cumulative_ad_view_dollars_d360
          , cumulative_ad_view_dollars_current
          , cumulative_ad_views_d1
          , cumulative_ad_views_d2
          , cumulative_ad_views_d7
          , cumulative_ad_views_d14
          , cumulative_ad_views_d15
          , cumulative_ad_views_d30
          , cumulative_ad_views_d60
          , cumulative_ad_views_d90
          , cumulative_ad_views_current
          , cumulative_combined_dollars_d1
          , cumulative_combined_dollars_d2
          , cumulative_combined_dollars_d3
          , cumulative_combined_dollars_d4
          , cumulative_combined_dollars_d5
          , cumulative_combined_dollars_d6
          , cumulative_combined_dollars_d7
          , cumulative_combined_dollars_d8
          , cumulative_combined_dollars_d14
          , cumulative_combined_dollars_d15
          , cumulative_combined_dollars_d21
          , cumulative_combined_dollars_d30
          , cumulative_combined_dollars_d31
          , cumulative_combined_dollars_d45
          , cumulative_combined_dollars_d46
          , cumulative_combined_dollars_d60
          , cumulative_combined_dollars_d61
          , cumulative_combined_dollars_d90
          , cumulative_combined_dollars_d120
          , cumulative_combined_dollars_d180
          , cumulative_combined_dollars_d270
          , cumulative_combined_dollars_d360
          , cumulative_combined_dollars_current
          , highest_last_level_serial_d1
          , highest_last_level_serial_d2
          , highest_last_level_serial_d7
          , highest_last_level_serial_d14
          , highest_last_level_serial_d30
          , highest_last_level_serial_d60
          , highest_last_level_serial_d90
          , highest_last_level_serial_current
          , retention_d2
          , retention_d3
          , retention_d4
          , retention_d5
          , retention_d6
          , retention_d7
          , retention_d8
          , retention_d9
          , retention_d10
          , retention_d11
          , retention_d12
          , retention_d13
          , retention_d14
          , retention_d15
          , retention_d21
          , retention_d28
          , retention_d30
          , retention_d31
          , retention_d45
          , retention_d46
          , retention_d60
          , retention_d61
          , retention_d90
          , retention_d91
          , retention_d120
          , retention_d180
          , retention_d360
          , retention_d365
          , cumulative_star_spend_d1
          , cumulative_star_spend_d2
          , cumulative_star_spend_d7
          , cumulative_star_spend_d14
          , cumulative_star_spend_d30
          , cumulative_star_spend_d60
          , cumulative_star_spend_current
          , cumulative_coins_spend_d1
          , cumulative_coins_spend_d2
          , cumulative_coins_spend_d7
          , cumulative_coins_spend_d14
          , cumulative_coins_spend_d30
          , cumulative_coins_spend_d60
          , cumulative_coins_spend_d90
          , cumulative_coins_spend_current
          , cumulative_total_chum_powerups_used_d1
          , cumulative_total_chum_powerups_used_d2
          , cumulative_total_chum_powerups_used_d7
          , cumulative_total_chum_powerups_used_d8
          , cumulative_total_chum_powerups_used_d14
          , cumulative_total_chum_powerups_used_d15
          , cumulative_total_chum_powerups_used_d21
          , cumulative_total_chum_powerups_used_d30
          , cumulative_total_chum_powerups_used_d31
          , cumulative_total_chum_powerups_used_d46
          , cumulative_total_chum_powerups_used_d60
          , cumulative_total_chum_powerups_used_d61
          , cumulative_total_chum_powerups_used_d90
          , cumulative_total_chum_powerups_used_d120
          , cumulative_total_chum_powerups_used_d180
          , cumulative_total_chum_powerups_used_d270
          , cumulative_total_chum_powerups_used_d360
          , cumulative_total_chum_powerups_current
          , hardware
          , processor_type
          , graphics_device_name
          , device_model
          , system_memory_size
          , graphics_memory_size
          , screen_width
          , screen_height
          , total_campaigin_round_time_in_minutes_to_first_end_of_content_levels
          , date_of_first_end_of_content_levels
          , day_number_of_first_end_of_content_levels
          , days_played_in_first_7_days
          , days_played_in_first_14_days
          , days_played_in_first_21_days
          , days_played_in_first_30_days
          , sessions_played_in_first_7_days
          , sessions_played_in_first_14_days
          , sessions_played_in_first_21_days
          , sessions_played_in_first_30_days
          , sessions_played_in_first_31_days
          , minutes_played_in_first_1_days
          , minutes_played_in_first_2_days
          , minutes_played_in_first_7_days
          , minutes_played_in_first_14_days
          , minutes_played_in_first_21_days
          , minutes_played_in_first_30_days
          , puzzle_rounds_played_in_first_1_days
          , puzzle_rounds_played_in_first_2_days
          , puzzle_rounds_played_in_first_7_days
          , puzzle_rounds_played_in_first_14_days
          , puzzle_rounds_played_in_first_21_days
          , puzzle_rounds_played_in_first_30_days
          , gofish_rounds_played_total
          , cumulative_mtx_purchase_dollars_current_percentile
          , firebase_advertising_id
          , singular_device_id
          , singular_campaign_id
          , singular_partner_name
          , singular_creative_id
          , full_ad_name
          , supported_devices_retail_name
          , supported_devices_marketing_name
          , supported_devices_device_name
          , appsflyer_campaign
          , appsflyer_campaign_type
          , appsflyer_media_source
          , appsflyer_id

          ----------------------------------------------------------
          -- Fields from the manifest
          ----------------------------------------------------------

          , @{country_region} as region
          , @{device_platform_mapping} as device_platform_mapping
          , @{device_platform_mapping_os} as device_platform_mapping_os
          , @{device_os_version_mapping} as device_os_version_mapping
          , @{singular_campaign_id_override} as singular_campaign_id_override
          , @{singular_created_date_override} as singular_created_date_override
          , @{singular_campaign_blended_window_override} as singular_campaign_blended_window_override
          , @{campaign_with_organics_estimate} as campaign_with_organics_estimate
          , @{singular_full_ad_name} as singular_full_ad_name
          , @{singular_grouped_ad_name} as singular_grouped_ad_name
          , @{singular_simple_ad_name} as singular_simple_ad_name

        from
          -- eraser-blast.looker_scratch.LR_6YUJU1709664574784_player_summary_staging
          ${player_summary_staging.SQL_TABLE_NAME}
        )


        ------------------------------------------------------------------------------------
        -- Campaign Name Clean (step 1)
        ------------------------------------------------------------------------------------

        , campaign_name_clean_by_singular_campaign_id_table as (

          select
            singular_campaign_id
            , max( singular_campaign_name_clean ) as singular_campaign_name_clean
          from
            ${singular_campaign_summary.SQL_TABLE_NAME}
          where
            singular_campaign_id is not null
            and singular_campaign_name_clean is not null
          group by
            1
          )

        ------------------------------------------------------------------------------------
        -- Campaign Name Clean (step 2)
        ------------------------------------------------------------------------------------

        , map_campaign_name_to_main_table as (

          select
            a.*
            , b.singular_campaign_name_clean as mapped_singular_campaign_name_start
          from
            base_data a
            left join campaign_name_clean_by_singular_campaign_id_table b
              on a.singular_campaign_id_override = b.singular_campaign_id
          )

        ------------------------------------------------------------------------------------
        -- Campaign Name Clean (step 3: Appsflyer )
        ------------------------------------------------------------------------------------

        , appsflyer_campaign_name_table as (

          select
            a.*
            , @{appsflyer_campaign_name} as mapped_singular_campaign_name_clean
          from
            map_campaign_name_to_main_table a

        )

        ------------------------------------------------------------------------------------
        -- Singular Total Cost By Campaign
        ------------------------------------------------------------------------------------

        , singular_total_cost_by_campaign_table as (

          select
            singular_campaign_name_clean
            , sum( singular_total_cost ) as singular_total_campaign_cost
            , safe_divide( sum( singular_total_cost ) , sum( singular_total_installs ) ) estimated_cpi
            , sum( singular_total_impressions ) as singular_total_impressions
            , safe_divide( sum( singular_total_impressions ) , sum( singular_total_installs ) ) estimated_impressions_per_install
          from
            ${singular_campaign_summary.SQL_TABLE_NAME}
          where
            singular_campaign_name_clean is not null
          group by
            1
          )

        ------------------------------------------------------------------------------------
        -- Singular Total Cost By Campaign and Install Date
        ------------------------------------------------------------------------------------

        , singular_total_cost_by_campaign_table_with_install_date as (

          select
            singular_campaign_name_clean
            , singular_install_date
            , safe_divide( sum( singular_total_cost ) , sum( singular_total_installs ) ) estimated_cpi
            , safe_divide( sum( singular_total_impressions ) , sum( singular_total_installs ) ) estimated_impressions_per_install
          from
            ${singular_campaign_summary.SQL_TABLE_NAME}
          where
            singular_campaign_name_clean is not null
          group by
            1,2
          )

        ------------------------------------------------------------------------------------
        -- Singular Cost by Creative, Campaign
        ------------------------------------------------------------------------------------

        , singular_total_cost_by_campaign_and_creative_table as (

          select
            singular_campaign_name_clean
            , singular_simple_ad_name
            , safe_divide( sum( singular_total_cost ) , sum( singular_total_installs ) ) estimated_cpi
            , safe_divide( sum( singular_total_impressions ) , sum( singular_total_installs ) ) estimated_impressions_per_install
          from
            ${singular_creative_summary.SQL_TABLE_NAME}
          where
            singular_campaign_name_clean is not null
            and singular_simple_ad_name is not null
          group by
            1,2
          )

        ------------------------------------------------------------------------------------
        -- Singular Cost by Creative, Campaign, and Install Date
        ------------------------------------------------------------------------------------

        , singular_total_cost_by_campaign_and_creative_table_with_install_date as (

          select
            singular_campaign_name_clean
            , singular_simple_ad_name
            , singular_install_date
            , safe_divide( sum( singular_total_cost ) , sum( singular_total_installs ) ) estimated_cpi
            , safe_divide( sum( singular_total_impressions ) , sum( singular_total_installs ) ) estimated_impressions_per_install
          from
            ${singular_creative_summary.SQL_TABLE_NAME}
          where
            singular_campaign_name_clean is not null
            and singular_simple_ad_name is not null
          group by
            1,2,3
          )

        ------------------------------------------------------------------------------------
        -- Best Guess CPI
        ------------------------------------------------------------------------------------

        , best_guess_cpi_table as (

          select
            a.*
            , b.singular_total_campaign_cost
            , b.singular_total_impressions
            , coalesce(
                e.estimated_cpi
                , d.estimated_cpi
                , c.estimated_cpi
                , b.estimated_cpi) as first_pass_cost_per_install
            , coalesce(
                e.estimated_impressions_per_install
                , d.estimated_impressions_per_install
                , c.estimated_impressions_per_install
                , b.estimated_impressions_per_install) as first_pass_impressions_per_install
          from
            appsflyer_campaign_name_table a

            left join singular_total_cost_by_campaign_table b
              on a.mapped_singular_campaign_name_clean = b.singular_campaign_name_clean

            left join singular_total_cost_by_campaign_and_creative_table c
              on a.mapped_singular_campaign_name_clean = c.singular_campaign_name_clean
              and a.singular_simple_ad_name = c.singular_simple_ad_name

            left join singular_total_cost_by_campaign_table_with_install_date d
              on a.mapped_singular_campaign_name_clean = d.singular_campaign_name_clean
              and a.singular_created_date_override = d.singular_install_date

            left join singular_total_cost_by_campaign_and_creative_table_with_install_date e
              on a.mapped_singular_campaign_name_clean = e.singular_campaign_name_clean
              and a.singular_simple_ad_name = e.singular_simple_ad_name
              and a.singular_created_date_override = e.singular_install_date

        )

        ------------------------------------------------------------------------------------
        -- Adjustment by Total Cost
        ------------------------------------------------------------------------------------

        , cpi_adjustment_for_total_cost_table as (

          select
            mapped_singular_campaign_name_clean
            , max( singular_total_campaign_cost ) - sum( first_pass_cost_per_install ) as my_difference_cost
            , max( singular_total_impressions ) - sum( first_pass_impressions_per_install ) as my_difference_impressions
          from
            best_guess_cpi_table
          group by
            1
        )

        ------------------------------------------------------------------------------------
        -- Calculate Adjustment for Singular
        ------------------------------------------------------------------------------------

        , singular_cost_adjustment_table as (

        select
          a.*

          -- Cost Adjustment
          , safe_divide(
              first_pass_cost_per_install
              ,
              sum( first_pass_cost_per_install ) over ( partition by a.mapped_singular_campaign_name_clean )
              )
              * my_difference_cost
              + first_pass_cost_per_install
              as singular_attributed_campaign_cost

          -- Impressions Adjustment
          , safe_divide(
              first_pass_impressions_per_install
              ,
              sum( first_pass_impressions_per_install ) over ( partition by a.mapped_singular_campaign_name_clean )
              )
              * my_difference_impressions
              + first_pass_impressions_per_install
              as singular_attributed_campaign_impressions
        from
          best_guess_cpi_table a
          left join cpi_adjustment_for_total_cost_table b
            on a.mapped_singular_campaign_name_clean = b.mapped_singular_campaign_name_clean

      )

      ------------------------------------------------------------------------------------
      -- Big Fish BFG ID One Time Override: Step 1
      ------------------------------------------------------------------------------------

      , bfg_id_overrides_step_1 as (

        select
          rdg_id
          , max( bfgudid ) as bfg_uid
        from
          eraser-blast.tal_scratch.2024_06_10_one_time_map_bfg_to_rdg_id_hardcoded
        group by
          1

      )

      ------------------------------------------------------------------------------------
      -- Big Fish BFG ID One Time Override: Step 2
      ------------------------------------------------------------------------------------

      , bfg_id_overrides_step_2 as (

        select
          a.* except ( bfg_uid )
          , coalesce( a.bfg_uid, b.bfg_uid ) as bfg_uid

        from
          singular_cost_adjustment_table a
          left join bfg_id_overrides_step_1 b
            on a.rdg_id = b.rdg_id

      )

      ------------------------------------------------------------------------------------
      -- Big Fish Attribution Step 1
      ------------------------------------------------------------------------------------

      , big_fish_attribution_table as (


        select
          bfgudid as bfg_uid
          , max( campaign ) as campaign
          , max( install_date ) as install_date
          , max( ad_name ) as ad_name
          , max( ad_id ) as ad_id
          , max( marketing_channel ) as marketing_channel
          , max( marketing_channel_category ) as marketing_channel_category
          , max( media_source ) as media_source
          , max( cpi  ) as cpi

        from
          eraser-blast.bfg_import.attribution_data
        where
          length(campaign) > 2
          and length(bfgudid) > 2
        group by
          1

      )

      ------------------------------------------------------------------------------------
      -- Map on Big Fish Information
      ------------------------------------------------------------------------------------

      , map_on_big_fish_information_table as (

      select
        a.*
        , b.campaign as bfg_campaign
        , @{bfg_campaign_name_mapping} as bfg_campaign_mapped
        , b.ad_name as bfg_ad_name
        , b.ad_name as bfg_ad_name_mapped -- TEMP: Will Need Mapping
        , b.ad_name as bfg_ad_name_mapped_grouped -- TEMP: Will Need Mapping
        , b.ad_id as bfg_ad_id
        , b.marketing_channel as bfg_marketing_channel
        , b.marketing_channel_category as bfg_marketing_channel_category
        , b.media_source as bfg_media_source
        , b.media_source as bfg_media_source_mapped -- TEMP: Will Need Mapping
        , b.cpi as bfg_cpi
      from
        bfg_id_overrides_step_2 a
        left join big_fish_attribution_table b
          on a.bfg_uid = b.bfg_uid

      )

      ------------------------------------------------------------------------------------
      -- BFG Impressions by Campaign/Date
      ------------------------------------------------------------------------------------

      , bfg_impression_by_campaign_date as (

        select
          lower(campaign_name) as campaign
          , registration_date
          , sum( total_spend ) as total_spend
          , sum( partner_impressions ) as partner_impressions
          , sum( total_regs ) as total_regs
        from
          eraser-blast.bfg_import.gogame_data
        where
          1=1
          and length(campaign_name) > 2
        group by
          1,2

      )

      ------------------------------------------------------------------------------------
      -- BFG Impressions by Campaign/Date Mapped
      ------------------------------------------------------------------------------------

      , bfg_impression_by_campaign_date_mapped as (

        select
          @{bfg_campaign_name_mapping} as bfg_campaign_mapped
          , date(b.registration_date) as registration_date
          , sum( total_spend ) as total_spend
          , sum( partner_impressions ) as partner_impressions
          , sum( total_regs ) as total_regs
        from
          bfg_impression_by_campaign_date b
        group by
          1,2

      )

      ------------------------------------------------------------------------------------
      -- BFG Impressions by Campaign Only
      ------------------------------------------------------------------------------------

      , bfg_impression_by_campaign_only as (

        select
          bfg_campaign_mapped
          , sum( total_spend ) as total_spend
          , sum( partner_impressions ) as partner_impressions
          , sum( total_regs ) as total_regs
        from
          bfg_impression_by_campaign_date_mapped b
        group by
          1
      )

      ------------------------------------------------------------------------------------
      -- Map on BFG Impressions
      ------------------------------------------------------------------------------------

      , map_on_bfg_impressions as (

        select
          a.*
          , coalesce(
              safe_divide( b.partner_impressions, b.total_regs )
              , safe_divide( c.partner_impressions, c.total_regs )
              ) as bfg_impressions
        from
          map_on_big_fish_information_table a
          left join bfg_impression_by_campaign_date_mapped b
            on a.bfg_campaign_mapped = b.bfg_campaign_mapped
            and date(a.created_date) = date(b.registration_date)
          left join bfg_impression_by_campaign_only c
            on a.bfg_campaign_mapped = c.bfg_campaign_mapped

      )


      ------------------------------------------------------------------------------------
      -- Combine BFG and Singular Campaign Info
      ------------------------------------------------------------------------------------

      , combine_bfg_and_singular_campaign_table as (

        select
          *
          , coalesce( mapped_singular_campaign_name_clean, bfg_campaign_mapped ) as campaign_name
          , coalesce( bfg_ad_name, singular_full_ad_name ) as ad_name_full
          -- , coalesce( singular_simple_ad_name, bfg_ad_name_mapped ) as ad_name_simple
          -- , coalesce( singular_grouped_ad_name, bfg_ad_name_mapped_grouped ) as ad_name_grouped
          , coalesce( singular_partner_name, bfg_media_source_mapped ) as partner_name
          , coalesce(
                case when singular_attributed_campaign_cost <= 0 then null else singular_attributed_campaign_cost end
                , case when bfg_cpi <= 0 then null else bfg_cpi end
                , 0
                ) as attributed_campaign_cost
          , coalesce( singular_attributed_campaign_impressions, bfg_impressions ) as attributed_campaign_impressions


        from map_on_bfg_impressions

      )

      ------------------------------------------------------------------------------------
      -- Map Simple and Grouped Campaign Names
      ------------------------------------------------------------------------------------

      select
        *
        , @{ad_name_simple} as ad_name_simple
        , @{ad_name_grouped} as ad_name_grouped
      from
        combine_bfg_and_singular_campaign_table



      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (10) + 2 )*( -10 ) minute)) ;;
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
  dimension: appsflyer_id {group_label:"Player IDs" type: string}
  dimension: device_id {group_label:"Player IDs" type: string}
  dimension: display_name {group_label:"Player IDs" type: string}
  dimension: advertising_id {group_label:"Player IDs" type: string}

  dimension: user_id {
    label: "First User ID"
    group_label:"Player IDs"
    type: string
    }
  dimension: latest_user_id {
    label: "Lastest User ID"
    group_label:"Player IDs"
    type: string
  }

  dimension: bfg_uid {group_label:"Player IDs" type: string}
  dimension: firebase_advertising_id {group_label:"Player IDs" type:string}
  dimension: experiments {type: string}
  dimension: version_at_install {group_label:"Versions" label: "Install Version" type: string}


  dimension: version_number_at_install {
    label: "Install Version Number"
    group_label:"Versions"
    type:number
    sql:
      safe_cast(${TABLE}.version_at_install as numeric)
      ;;
  }

  dimension: version_d2 {group_label:"Versions" type: string}
  dimension: version_d7 {group_label:"Versions" type: string}
  dimension: version_d14 {group_label:"Versions" type: string}
  dimension: version_d30 {group_label:"Versions" type: string}
  dimension: version_d60 {group_label:"Versions" type: string}
  dimension: version_d90 {group_label:"Versions" type: string}
  dimension: version_current {group_label:"Versions" label: "Current Version" type: string}
  dimension: platform {type: string}
  dimension: country {type: string}
  dimension: region {type:string}
  dimension: cumulative_time_played_minutes {label:"Minutes Played" value_format:"#,##0" type: number}

  ## minutes played in first x days
  dimension: minutes_played_in_first_1_days {type: number}
  dimension: minutes_played_in_first_2_days {type: number}
  dimension: minutes_played_in_first_7_days {type: number}
  dimension: minutes_played_in_first_14_days {type: number}
  dimension: minutes_played_in_first_21_days {type: number}
  dimension: minutes_played_in_first_30_days {type: number}


  dimension: gofish_rounds_played_total {
    group_label: "Go Fish Rounds"
    label: "GoFish Rounds Played"
    type: number
  }

  dimension: gofish_rounds_played_tiers {
    group_label: "Go Fish Rounds"
    label: "GoFish Rounds Played (Bins)"
    type: tier
    style: integer
    tiers: [0,1,4,7,10,13,16]
    sql: ${TABLE}.gofish_rounds_played_total  ;;
  }

  # dates
  dimension_group: last_played_date {
    label: "Last Played"
    type: time
    timeframes: [date, week, month, year]
  }

  # date_of_first_end_of_content_levels
  dimension_group: date_of_first_end_of_content_levels {
    group_label: "First End of Content Levels"
    type: time
    timeframes: [date, week, month, year]
  }

  dimension: created_date {type: date}
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
    sql: ${TABLE}.highest_played_day_number ;;
  }

  # numbers
  dimension: max_available_day_number {type: number}
  dimension: cumulative_mtx_purchase_dollars_d1 {label: "Cumulative IAP: D1" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d2 {label: "Cumulative IAP: D2" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d3 {label: "Cumulative IAP: D3" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d4 {label: "Cumulative IAP: D4" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d5 {label: "Cumulative IAP: D5" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d6 {label: "Cumulative IAP: D6" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d7 {label: "Cumulative IAP: D7" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d8 {label: "Cumulative IAP: D8" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d14 {label: "Cumulative IAP: D14" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d15 {label: "Cumulative IAP: D15" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d21 {label: "Cumulative IAP: D21" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d30 {label: "Cumulative IAP: D30" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d31 {label: "Cumulative IAP: D31" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d46 {label: "Cumulative IAP: D46" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d60 {label: "Cumulative IAP: D60" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d61 {label: "Cumulative IAP: D61" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d90 {label: "Cumulative IAP: D90" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d120 {label: "Cumulative IAP: D120" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d180 {label: "Cumulative IAP: D180" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d270 {label: "Cumulative IAP: D270" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_d360 {label: "Cumulative IAP: D360" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_current {label: "Cumulative IAP: Current" group_label:"LTV - IAP" value_format:"$0.00" type: number}
  dimension: cumulative_mtx_purchase_dollars_current_percentile {label: "Cumulative IAP: Current Percentile" group_label:"LTV - IAP" type: number}

  dimension: cumulative_count_mtx_purchases_d1 {label: "Cumulative IAP Purchases: D1" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d2 {label: "Cumulative IAP Purchases: D2" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d7 {label: "Cumulative IAP Purchases: D7" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d8 {label: "Cumulative IAP Purchases: D8" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d14 {label: "Cumulative IAP Purchases: D14" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d30 {label: "Cumulative IAP Purchases: D30" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_d60 {label: "Cumulative IAP Purchases: D60" group_label:"Cumulative IAP Purchases" type:number}
  dimension: cumulative_count_mtx_purchases_current {label: "Cumulative IAP Purchases: Current" group_label:"Cumulative IAP Purchases" type:number}

  dimension: mtx_ltv_from_data {type: number}
  dimension: cumulative_ad_view_dollars_d1 {label: "Cumulative IAA: D1" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d2 {label: "Cumulative IAA: D2" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d3 {label: "Cumulative IAA: D3" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d4 {label: "Cumulative IAA: D4" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d5 {label: "Cumulative IAA: D5" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d6 {label: "Cumulative IAA: D6" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d7 {label: "Cumulative IAA: D7" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d8 {label: "Cumulative IAA: D8" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d14 {label: "Cumulative IAA: D14" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d15 {label: "Cumulative IAA: D15" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d21 {label: "Cumulative IAA: D21" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d30 {label: "Cumulative IAA: D30" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d31 {label: "Cumulative IAA: D31" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d46 {label: "Cumulative IAA: D46" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d60 {label: "Cumulative IAA: D60" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d61 {label: "Cumulative IAA: D61" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d90 {label: "Cumulative IAA: D90" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d120 {label: "Cumulative IAA: D120" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d180 {label: "Cumulative IAA: D180" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d270 {label: "Cumulative IAA: D270" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_d360 {label: "Cumulative IAA: D360" group_label:"LTV - IAA" value_format:"$0.00" type: number}
  dimension: cumulative_ad_view_dollars_current {label: "Cumulative IAA: Current" group_label:"LTV - IAA" value_format:"$0.00" type: number}

  dimension: cumulative_combined_dollars_d1 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D1" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d2 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D2" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d3 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D3" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d4 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D4" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d5 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D5" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d6 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D6" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d7 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D7" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d8 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D8" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d14 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D14" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d15 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D15" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d21 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D21" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d30 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D30" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d31 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D31" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d46 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D46" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d60 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D60" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d61 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D61" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d90 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D90" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d120 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D120" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d180 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D180" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d270 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D270" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_d360 {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: D360" value_format:"$0.00" type: number}
  dimension: cumulative_combined_dollars_current {group_label:"LTV - Cumulative Net" label:"Cumulative Net LTV: Current" value_format:"$0.00" type: number}

  dimension: cumulative_gross_combined_dollars_d1 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D1" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d1}/0.70 + ${cumulative_ad_view_dollars_d1} ;;}
  dimension: cumulative_gross_combined_dollars_d2 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D2" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d2}/0.70 + ${cumulative_ad_view_dollars_d2} ;;}
  dimension: cumulative_gross_combined_dollars_d7 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D7" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d7}/0.70 + ${cumulative_ad_view_dollars_d7} ;;}
  dimension: cumulative_gross_combined_dollars_d8 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D8" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d8}/0.70 + ${cumulative_ad_view_dollars_d8} ;;}
  dimension: cumulative_gross_combined_dollars_d14 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D14" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d14}/0.70 + ${cumulative_ad_view_dollars_d14} ;;}
  dimension: cumulative_gross_combined_dollars_d15 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D15" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d15}/0.70 + ${cumulative_ad_view_dollars_d15} ;;}
  dimension: cumulative_gross_combined_dollars_d21 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D21" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d21}/0.70 + ${cumulative_ad_view_dollars_d21} ;;}
  dimension: cumulative_gross_combined_dollars_d30 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D30" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d30}/0.70 + ${cumulative_ad_view_dollars_d30} ;;}
  dimension: cumulative_gross_combined_dollars_d31 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D31" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d31}/0.70 + ${cumulative_ad_view_dollars_d31} ;;}
  dimension: cumulative_gross_combined_dollars_d46 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D46" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d46}/0.70 + ${cumulative_ad_view_dollars_d46} ;;}
  dimension: cumulative_gross_combined_dollars_d60 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D60" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d60}/0.70 + ${cumulative_ad_view_dollars_d60} ;;}
  dimension: cumulative_gross_combined_dollars_d61 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D61" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d61}/0.70 + ${cumulative_ad_view_dollars_d61} ;;}
  dimension: cumulative_gross_combined_dollars_d90 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D90" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d90}/0.70 + ${cumulative_ad_view_dollars_d90} ;;}
  dimension: cumulative_gross_combined_dollars_d120 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D120" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d120}/0.70 + ${cumulative_ad_view_dollars_d120} ;;}
  dimension: cumulative_gross_combined_dollars_d180 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D180" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d180}/0.70 + ${cumulative_ad_view_dollars_d180} ;;}
  dimension: cumulative_gross_combined_dollars_d270 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D270" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d270}/0.70 + ${cumulative_ad_view_dollars_d270} ;;}
  dimension: cumulative_gross_combined_dollars_d360 {group_label:"LTV - Cumulative Gross" label:"Cumulative Gross LTV: D360" value_format:"$0.00" type: number sql: ${cumulative_mtx_purchase_dollars_d360}/0.70 + ${cumulative_ad_view_dollars_d360} ;;}

  dimension: highest_last_level_serial_d1 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d2 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d7 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d14 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d30 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d60 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_d90 {group_label:"Highest Level" type: number}
  dimension: highest_last_level_serial_current {group_label:"Highest Level" label:"Highest Level" type: number}

  dimension: retention_d2 {group_label:"Retention" type: number}
  dimension: retention_d7 {group_label:"Retention" type: number}
  dimension: retention_d8 {group_label:"Retention" type: number}
  dimension: retention_d9 {group_label:"Retention" type: number}
  dimension: retention_d10 {group_label:"Retention" type: number}
  dimension: retention_d11 {group_label:"Retention" type: number}
  dimension: retention_d12 {group_label:"Retention" type: number}
  dimension: retention_d13 {group_label:"Retention" type: number}
  dimension: retention_d14 {group_label:"Retention" type: number}
  dimension: retention_d21 {group_label:"Retention" type: number}
  dimension: retention_d30 {group_label:"Retention" type: number}
  dimension: retention_d60 {group_label:"Retention" type: number}
  dimension: retention_d90 {group_label:"Retention" type: number}

  dimension: cumulative_star_spend_d1 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d2 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d7 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d14 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d30 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d60 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_d90 {group_label:"Cumulative Stars Spent" type: number}
  dimension: cumulative_star_spend_current {group_label:"Cumulative Stars Spent" type: number}

  dimension: cumulative_ad_views_d1 {label: "Cumulative IAA Views: D1" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d2 {label: "Cumulative IAA Views: D2" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d7 {label: "Cumulative IAA Views: D7" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d14 {label: "Cumulative IAA Views: D14" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d15 {label: "Cumulative IAA Views: D15" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d30 {label: "Cumulative IAA Views: D30" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d60 {label: "Cumulative IAA Views: D60" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_d90 {label: "Cumulative IAA Views: D90" group_label:"Cumulative IAA Views" type: number}
  dimension: cumulative_ad_views_current {label: "Cumulative IAA Views: Current" group_label:"Cumulative IAA Views" type: number}

  dimension: cumulative_coins_spend_d1 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d2 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d7 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d14 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d30 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d60 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_d90 {group_label:"Cumulative Coin Spend" type: number}
  dimension: cumulative_coins_spend_current {group_label:"Cumulative Coin Spend" type: number}



  ################################################################################################
  ## sessions per day
  ################################################################################################

  dimension: sessions_per_day_7 {
    group_label: "Sessions Per Day"
    label: "Average Sessions Per Day in First 7 Days"
    type: number
    value_format_name: decimal_0
    sql:
      round(
        safe_divide(
          ${TABLE}.sessions_played_in_first_7_days
          , ${TABLE}.days_played_in_first_7_days
        )
        , 0
      )
    ;;

  }

  ################################################################################################
  ## Install Category
  ################################################################################################

  dimension: install_category {
    label: "Install Category"
    type: string
    sql: @{campaign_install_category}  ;;
  }

  dimension: campaign_milestone_category {
    label: "Milestone Category"
    type: string
    sql: @{campaign_milestone_category}  ;;
  }

  ################################################################################################
  ## minutes per day
  ################################################################################################

  dimension: minutes_per_day_7 {
    group_label: "Minutes Per Day"
    label: "Average Minutes Per Day in First 7 Days"
    type: number
    value_format_name: decimal_0
    sql:
      round(
        safe_divide(
          ${TABLE}.minutes_played_in_first_7_days
          , ${TABLE}.days_played_in_first_7_days
        )
        , 0
      )
    ;;

    }


  ################################################################################################
  ## end of content
  ################################################################################################

  dimension: day_number_of_first_end_of_content_levels {type:number}
  dimension: day_group_for_end_of_content_levels {
    type: string
    sql:
      case
        when ${TABLE}.day_number_of_first_end_of_content_levels is null then 'Not Reached End of Content'
        when ${TABLE}.day_number_of_first_end_of_content_levels <= 7 then 'End of Content By D07'
        when ${TABLE}.day_number_of_first_end_of_content_levels <= 30 then 'End of Content By D30'
        when ${TABLE}.day_number_of_first_end_of_content_levels <= 60 then 'End of Content By D60'
        when ${TABLE}.day_number_of_first_end_of_content_levels is not null then 'End of Content By D61+'
        else 'Other'
        end
    ;;

  }
  measure: end_of_content_by_day_7 {
    group_label: "End of Content Groups"
    label: "End of Content by D7"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels <= 7 then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  measure: end_of_content_by_day_14 {
    group_label: "End of Content Groups"
    label: "End of Content by D14"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels <= 14 then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  measure: end_of_content_by_day_30 {
    group_label: "End of Content Groups"
    label: "End of Content by D30"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels <= 30 then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  measure: end_of_content_by_day_60 {
    group_label: "End of Content Groups"
    label: "End of Content by D60"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels <= 60 then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

  measure: end_of_content_by_day_61_plus {
    group_label: "End of Content Groups"
    label: "End of Content by D61+"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        count( distinct
          case
            when ${TABLE}.day_number_of_first_end_of_content_levels is not null then ${TABLE}.rdg_id
          else null
          end
          )
        ,
        count( distinct ${TABLE}.rdg_id )
        )
    ;;
  }

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


  dimension: system_memory_size_bin {
    group_label: "System Info"
    type: string
    sql:
      case
        when system_memory_size < 1000 then '< 1000'
        when system_memory_size between 1000 and 1999 then '1000 - 1999'
        when system_memory_size between 2000 and 2999 then '2000 - 2999'
        when system_memory_size between 3000 and 3999 then '3000 - 3999'
        when system_memory_size between 4000 and 4999 then '4000 - 4999'
        when system_memory_size between 5000 and 5999 then '5000 - 5999'
        when system_memory_size between 6000 and 6999 then '6000 - 6999'
        when system_memory_size between 7000 and 7999 then '7000 - 7999'
        when system_memory_size between 8000 and 8999 then '8000 - 8999'
        when system_memory_size between 9000 and 9999 then '9000 - 9999'
        when system_memory_size between 10000 and 10999 then '10000 - 10999'
        when system_memory_size between 11000 and 11999 then '11000 - 11999'
        when system_memory_size between 12000 and 12999 then '12000 - 12999'
        when system_memory_size > 13000 then '> 13000'
        else 'Undefined'
        end

    ;;
  }
  dimension: system_memory_size_bin_order {
    group_label: "System Info"
    type: number
    sql:
      case
        when system_memory_size < 1000 then 1
        when system_memory_size between 1000 and 1999 then 2
        when system_memory_size between 2000 and 2999 then 3
        when system_memory_size between 3000 and 3999 then 4
        when system_memory_size between 4000 and 4999 then 5
        when system_memory_size between 5000 and 5999 then 6
        when system_memory_size between 6000 and 6999 then 7
        when system_memory_size between 7000 and 7999 then 8
        when system_memory_size between 8000 and 8999 then 9
        when system_memory_size between 9000 and 9999 then 10
        when system_memory_size between 10000 and 10999 then 11
        when system_memory_size between 11000 and 11999 then 12
        when system_memory_size between 12000 and 12999 then 13
        when system_memory_size > 13000 then 14
        else 15
        end


    ;;
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

  dimension: aspect_ratio_9 {
    group_label: "System Info"
    type: string
    sql:
      cast( round(9 * safe_divide( ${TABLE}.screen_height , ${TABLE}.screen_width ),0) as string )
      || ':9'
    ;;

  }


  dimension: device_platform_mapping {
    group_label: "System Info"
    type: string
  }

  dimension: device_platform_mapping_os {
    group_label: "System Info"
    type: string
  }

  dimension: device_os_version_mapping {
    group_label: "System Info"
    type: string
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


######################################################################
## Combined Campaign Mapping
######################################################################

  dimension: mapped_singular_campaign_name_clean {
    label: "Campaign Name (Clean)"
    group_label: "Campaign Mapping"
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_name_clean_copy {
    label: "Campaign Name (Clean) 2"
    group_label: "Campaign Mapping"
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: singular_partner_name {
    group_label: "Campaign Mapping"
    sql: ${TABLE}.partner_name ;;
    type:string}

  dimension: paid_vs_organic {
    label: "Paid vs. Organic"
    group_label: "Campaign Mapping"
    type: string
    sql:
      case
        when ${TABLE}.campaign_name is not null
        then 'Paid'
        else 'Organic'
        end ;;
  }

  dimension: singular_full_ad_name {
    group_label: "Creative Mapping"
    label: "Full Ad Name"
    type: string
    sql: ${TABLE}.ad_name_full ;;
  }

  dimension: singular_grouped_ad_name {
    group_label: "Creative Mapping"
    label: "Grouped Ad Name"
    type: string
    sql: ${TABLE}.ad_name_grouped ;;
  }

  dimension: singular_simple_ad_name {
    group_label: "Creative Mapping"
    label: "Simple Ad Name"
    type: string
    sql: ${TABLE}.ad_name_simple ;;
  }

######################################################################
## BFG Campaign Mapping
######################################################################

  dimension: bfg_campaign {
    group_label: "BFG Campaign Mapping"
    type: string
  }
  dimension: bfg_ad_name {
    group_label: "BFG Campaign Mapping"
    type: string
  }
  dimension: bfg_media_source {
    group_label: "BFG Campaign Mapping"
    type: string
  }


######################################################################
## Singular Campaign Mapping
######################################################################


  dimension: singular_device_id {
    group_label: "Singular Campaign Mapping"
    type:string}

  dimension: singular_campaign_id {
    group_label: "Singular Campaign Mapping"
    type:string}

  dimension: singular_campaign_id_override {
    group_label: "Singular Campaign Mapping"
    type: string
  }

  dimension: singular_created_date_override {
    group_label: "Singular Campaign Mapping"
    type: date
  }

  dimension: singular_campaign_blended_window_override {
    group_label: "Singular Campaign Mapping"
    type: string
  }

  dimension: campaign_with_organics_estimate {
    group_label: "Singular Campaign Mapping"
    label: "Campaign with Organics (Estimate)"
    type: string
  }

######################################################################
## Cost Per Result
######################################################################

  parameter: selected_campaign_result {
    label: "Selected Campaign Result"
    type: string
    suggestions:  [
      "Transaction"
      , "Spender"
      , "Install"
      , "1 Minute"
      , "2 Minutes"
      , "3 Minutes"
      , "4 Minutes"
      , "5 Minutes"
      , "10 Minutes"
      , "15 Minutes"
      , "30 Minutes"
      , "60 Minutes"
      ]
  }

  measure: selected_cost_per_result {
    label: "Cost Per Result"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: usd
    sql:
      safe_divide(
        sum( ifnull( ${TABLE}.attributed_campaign_cost, 0 ) )
        ,
        sum(
          case
            when {% parameter selected_campaign_result %} = "Transaction"
              then ${TABLE}.cumulative_count_mtx_purchases_current
            when {% parameter selected_campaign_result %} = "Spender"
              then case when ${TABLE}.cumulative_mtx_purchase_dollars_current > 0 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "Install"
              then 1
            when {% parameter selected_campaign_result %} = "15 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 15 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "30 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 30 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "60 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 60 then 1 else 0 end

            when {% parameter selected_campaign_result %} = "1 Minute"
              then case when ${TABLE}.cumulative_time_played_minutes >= 1 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "2 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 2 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "3 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 3 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "4 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 4 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "5 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 5 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "10 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 10 then 1 else 0 end

            else 0
            end

            )
      )
    ;;
  }

  measure: selected_result_conversion {
    label: "Result Conversion"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: percent_1
    sql:
      safe_divide(
        sum(
          case
            when {% parameter selected_campaign_result %} = "Transaction"
              then case when ${TABLE}.cumulative_mtx_purchase_dollars_current > 0 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "Spender"
              then case when ${TABLE}.cumulative_mtx_purchase_dollars_current > 0 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "Install"
              then 1
            when {% parameter selected_campaign_result %} = "15 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 15 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "30 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 30 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "60 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 60 then 1 else 0 end

            when {% parameter selected_campaign_result %} = "1 Minute"
              then case when ${TABLE}.cumulative_time_played_minutes >= 1 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "2 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 2 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "3 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 3 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "4 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 4 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "5 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 5 then 1 else 0 end
            when {% parameter selected_campaign_result %} = "10 Minutes"
              then case when ${TABLE}.cumulative_time_played_minutes >= 10 then 1 else 0 end

      else 0
      end
      ),
      sum( 1 )
      )
      ;;
  }


######################################################################
## Singular Creative Mapping
######################################################################



  dimension: singular_creative_id {
    group_label: "Singular Creative Mapping"
    type: string
  }




######################################################################
## Expirements
######################################################################

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  dimension: latest_experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.latest_experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

  parameter: experiment_variant_1 {
    type: string
    suggestions:  [
      "control"
      ,"variant_a"
      ,"variant_b"
      ,"variant_c"
      ,"variant_d"]
  }

  dimension: experiment_variant_1_check {
    type: yesno
    sql:
      ${experiment_variant} = {% parameter experiment_variant_1 %}
      ;;
  }

  parameter: experiment_variant_2 {
    type: string
    suggestions:  [
      "control"
      ,"variant_a"
      ,"variant_b"
      ,"variant_c"
      ,"variant_c"]
  }

  dimension: experiment_variant_2_check {
    type: yesno
    sql:
      ${experiment_variant} = {% parameter experiment_variant_2 %}
      ;;
  }


  parameter: selected_significance_level {
    type: number
  }

  dimension: significance_level {
    type: number
    sql:
      {% parameter selected_significance_level %}
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

  measure: available_combined_dollars_d8 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_combined_dollars_d8
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

  measure: available_combined_dollars_d21 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.cumulative_combined_dollars_d21
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

  measure: available_combined_dollars_d90 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.cumulative_combined_dollars_d90
          else 0
          end )
    ;;
    value_format_name: usd

  }

  measure: available_combined_dollars_d120 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.cumulative_combined_dollars_d120
          else 0
          end )
    ;;
    value_format_name: usd

  }

################################################################
## Installs At Day X
################################################################

  measure: installs_at_d2 {
    group_label: "Installs At Day"
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

  measure: installs_at_d7 {
    group_label: "Installs At Day"
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

  measure: installs_at_d14 {
    group_label: "Installs At Day"
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

  measure: installs_at_d30 {
    group_label: "Installs At Day"
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

  measure: revenue_per_install_d8 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_combined_dollars_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
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

  measure: revenue_per_install_d15 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.cumulative_combined_dollars_d15
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d21 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.cumulative_combined_dollars_d21
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 21
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

  measure: revenue_per_install_d31 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 31
          then ${TABLE}.cumulative_combined_dollars_d31
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 31
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d45 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 45
          then ${TABLE}.cumulative_combined_dollars_d45
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 45
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d46 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 46
          then ${TABLE}.cumulative_combined_dollars_d46
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 46
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

  measure: revenue_per_install_d61 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 61
          then ${TABLE}.cumulative_combined_dollars_d61
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 61
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d90 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.cumulative_combined_dollars_d90
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: revenue_per_install_d120 {
    group_label: "Revenue Per Install (RPI)"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.cumulative_combined_dollars_d120
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

################################################################
## Cumulative Conversion
################################################################

  measure: cumulative_mtx_payers_current {
    label: "Sum IAP Spenders"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.cumulative_mtx_purchase_dollars_current > 0
          then 1
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: cumulative_mtx_conversion_current {
    label: "Cumulative IAP Conversion"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.cumulative_mtx_purchase_dollars_current > 0
          then 1
          else 0
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d1 {
    label: "Cumulative IAP Conversion: D1"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          and ${TABLE}.cumulative_mtx_purchase_dollars_d1 > 0
          then 1
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
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d2 {
    label: "Cumulative IAP Conversion: D2"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          and ${TABLE}.cumulative_mtx_purchase_dollars_d2 > 0
          then 1
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


  measure: cumulative_mtx_conversion_d7 {
    label: "Cumulative IAP Conversion: D7"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          and ${TABLE}.cumulative_mtx_purchase_dollars_d7 > 0
          then 1
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

  measure: cumulative_mtx_conversion_d8 {
    label: "Cumulative IAP Conversion: D8"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          and ${TABLE}.cumulative_mtx_purchase_dollars_d8 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d14 {
    label: "Cumulative IAP Conversion: D14"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          and ${TABLE}.cumulative_mtx_purchase_dollars_d14 > 0
          then 1
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

  measure: cumulative_mtx_conversion_d15 {
    label: "Cumulative IAP Conversion: D15"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 15
          and ${TABLE}.cumulative_mtx_purchase_dollars_d15 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d30 {
    label: "Cumulative IAP Conversion: D30"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          and ${TABLE}.cumulative_mtx_purchase_dollars_d30 > 0
          then 1
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

  measure: cumulative_mtx_conversion_d45 {
    label: "Cumulative IAP Conversion: D45"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 45
          and ${TABLE}.cumulative_mtx_purchase_dollars_d45 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 45
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }

  measure: cumulative_mtx_conversion_d60 {
    label: "Cumulative IAP Conversion: D60"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          and ${TABLE}.cumulative_mtx_purchase_dollars_d60 > 0
          then 1
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

  measure: cumulative_mtx_conversion_d90 {
    label: "Cumulative IAP Conversion: D90"
    group_label: "Cumulative IAP Conversion"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          and ${TABLE}.cumulative_mtx_purchase_dollars_d90 > 0
          then 1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1

  }


################################################################
## Transactions Per Payer
################################################################

  measure: transactions_per_payer_d1 {
    label: "IAP Transactions Per Payer: D1"
    group_label: "IAP Transactions Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_count_mtx_purchases_d1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          and ${TABLE}.cumulative_count_mtx_purchases_d1 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: decimal_1

  }

  measure: transactions_per_payer_d2 {
    label: "IAP Transactions Per Payer: D2"
    group_label: "IAP Transactions Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_count_mtx_purchases_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          and ${TABLE}.cumulative_count_mtx_purchases_d2 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: decimal_1

  }

  measure: transactions_per_payer_d7 {
    label: "IAP Transactions Per Payer: D7"
    group_label: "IAP Transactions Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_count_mtx_purchases_d7
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          and ${TABLE}.cumulative_count_mtx_purchases_d7 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: decimal_1

  }

  measure: transactions_per_payer_d8 {
    label: "IAP Transactions Per Payer: D8"
    group_label: "IAP Transactions Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_count_mtx_purchases_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          and ${TABLE}.cumulative_count_mtx_purchases_d8 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: decimal_1

  }

################################################################
## Average Revenue Per Transaction
################################################################

  measure: average_revenue_per_transaction_d1 {
    label: "IAP Revenue Per Transaction: D1"
    group_label: "IAP Revenue Per Transaction"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_mtx_purchase_dollars_d1
          else 0
          end )
      ,
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_count_mtx_purchases_d1
          else 0
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_revenue_per_transaction_d2 {
    label: "IAP Revenue Per Transaction: D2"
    group_label: "IAP Revenue Per Transaction"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_mtx_purchase_dollars_d2
          else 0
          end )
      ,
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_count_mtx_purchases_d2
          else 0
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_revenue_per_transaction_d7 {
    label: "IAP Revenue Per Transaction: D7"
    group_label: "IAP Revenue Per Transaction"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_mtx_purchase_dollars_d7
          else 0
          end )
      ,
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_count_mtx_purchases_d7
          else 0
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_revenue_per_transaction_d8 {
    label: "IAP Revenue Per Transaction: D8"
    group_label: "IAP Revenue Per Transaction"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_mtx_purchase_dollars_d8
          else 0
          end )
      ,
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_count_mtx_purchases_d8
          else 0
          end )
    )
    ;;
    value_format_name: usd

  }

################################################################
## Average Mtx Revenue Per Player
################################################################

  measure: average_mtx_revenue_per_player_d2 {
    label: "IAP Revenue Per Player: D2"
    group_label: "Average IAP Revenue Per Player"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_mtx_purchase_dollars_d2
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

  measure: average_mtx_revenue_per_player_d7 {
    label: "IAP Revenue Per Player: D7"
    group_label: "Average IAP Revenue Per Player"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_mtx_purchase_dollars_d7
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

  measure: average_mtx_revenue_per_player_d14 {
    label: "IAP Revenue Per Player: D14"
    group_label: "Average IAP Revenue Per Player"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.cumulative_mtx_purchase_dollars_d14
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

################################################################
## Average IAA Revenue Per Player
################################################################

  measure: average_iaa_revenue_per_player_d2 {
    label: "IAA Revenue Per Player: D2"
    group_label: "Average IAA Revenue Per Player"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_ad_view_dollars_d2
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

  measure: average_iaa_revenue_per_player_d7 {
    label: "IAA Revenue Per Player: D7"
    group_label: "Average IAA Revenue Per Player"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_ad_view_dollars_d7
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

  measure: average_iaa_revenue_per_player_d14 {
    label: "IAA Revenue Per Player: D14"
    group_label: "Average IAA Revenue Per Player"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.cumulative_ad_view_dollars_d14
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



################################################################
## Average Mtx Revenue Per Paying User
################################################################

  measure: average_mtx_revenue_per_paying_user_d1 {
    label: "IAP Revenue Per Payer: D1"
    group_label: "Average IAP Revenue Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 1
          then ${TABLE}.cumulative_mtx_purchase_dollars_d1
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 1
          and ${TABLE}.cumulative_count_mtx_purchases_d1 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_mtx_revenue_per_paying_user_d2 {
    label: "IAP Revenue Per Payer: D2"
    group_label: "Average IAP Revenue Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.cumulative_mtx_purchase_dollars_d2
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 2
          and ${TABLE}.cumulative_count_mtx_purchases_d2 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_mtx_revenue_per_paying_user_d7 {
    label: "IAP Revenue Per Payer: D7"
    group_label: "Average IAP Revenue Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.cumulative_mtx_purchase_dollars_d7
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 7
          and ${TABLE}.cumulative_count_mtx_purchases_d7 > 0
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: usd

  }

  measure: average_mtx_revenue_per_paying_user_d8 {
    label: "IAP Revenue Per Payer: D8"
    group_label: "Average IAP Revenue Per Payer"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.cumulative_mtx_purchase_dollars_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          and ${TABLE}.cumulative_count_mtx_purchases_d8 > 0
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
    drill_fields: [numerator_retention_d2,available_player_count_d2]
  }

  measure: average_retention_d3 {
    group_label: "Average Retention"
    label: "D3"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 3
          then ${TABLE}.retention_d3
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 3
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d3,available_player_count_d3]
  }

  measure: average_retention_d4 {
    group_label: "Average Retention"
    label: "D4"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 4
          then ${TABLE}.retention_d4
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 4
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d4,available_player_count_d4]
  }

  measure: average_retention_d5 {
    group_label: "Average Retention"
    label: "D5"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 5
          then ${TABLE}.retention_d5
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 5
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d5,available_player_count_d5]
  }

  measure: average_retention_d6 {
    group_label: "Average Retention"
    label: "D6"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 6
          then ${TABLE}.retention_d6
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 6
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d6,available_player_count_d6]
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
    drill_fields: [numerator_retention_d7,available_player_count_d7]
  }

  measure: average_retention_d8 {
    group_label: "Average Retention"
    label: "D8"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.retention_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d8,available_player_count_d8]
  }

  measure: average_retention_d9 {
    group_label: "Average Retention"
    label: "D9"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 9
          then ${TABLE}.retention_d9
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 9
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d9,available_player_count_d9]
  }

  measure: average_retention_d10 {
    group_label: "Average Retention"
    label: "D10"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 10
          then ${TABLE}.retention_d10
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 10
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d10,available_player_count_d10]
  }

  measure: average_retention_d11 {
    group_label: "Average Retention"
    label: "D11"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 11
          then ${TABLE}.retention_d11
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 11
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d11,available_player_count_d11]
  }

  measure: average_retention_d12 {
    group_label: "Average Retention"
    label: "D12"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 12
          then ${TABLE}.retention_d12
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 12
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d12,available_player_count_d12]
  }

  measure: average_retention_d13 {
    group_label: "Average Retention"
    label: "D13"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 13
          then ${TABLE}.retention_d13
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 13
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    #drill_fields: [numerator_retention_d13,available_player_count_d13]
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
    drill_fields: [numerator_retention_d14,available_player_count_d14]
  }

  measure: average_retention_d21 {
    group_label: "Average Retention"
    label: "D21"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.retention_d21
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d21,available_player_count_d21]
  }

  measure: average_retention_d28 {
    group_label: "Average Retention"
    label: "D28"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 28
          then ${TABLE}.retention_d28
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 28
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d21,available_player_count_d21]
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
    drill_fields: [numerator_retention_d30,available_player_count_d30]
  }

  measure: average_retention_d45 {
    group_label: "Average Retention"
    label: "D45"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 45
          then ${TABLE}.retention_d45
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 45
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
    drill_fields: [numerator_retention_d60,available_player_count_d60]
  }

  measure: average_retention_d90 {
    group_label: "Average Retention"
    label: "D90"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.retention_d90
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d90,available_player_count_d90]
  }

  measure: average_retention_d120 {
    group_label: "Average Retention"
    label: "D120"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.retention_d120
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: average_retention_d180 {
    group_label: "Average Retention"
    label: "D180"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 180
          then ${TABLE}.retention_d180
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 180
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: average_retention_d360 {
    group_label: "Average Retention"
    label: "D360"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 360
          then ${TABLE}.retention_d360
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 360
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: average_retention_d365 {
    group_label: "Average Retention"
    label: "D365"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 365
          then ${TABLE}.retention_d365
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 365
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

################################################################
## Big Fish Retention
################################################################

  measure: big_fish_retention_d1 {
    group_label: "Big Fish Retention"
    label: "Big Fish D1"
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
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d7 {
    group_label: "Big Fish Retention"
    label: "Big Fish D7"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.retention_d8
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d14 {
    group_label: "Big Fish Retention"
    label: "Big Fish D14"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.retention_d15
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 15
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d30 {
    group_label: "Big Fish Retention"
    label: "Big Fish D30"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 31
          then ${TABLE}.retention_d31
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 31
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d45 {
    group_label: "Big Fish Retention"
    label: "Big Fish D45"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 46
          then ${TABLE}.retention_d46
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 46
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d60 {
    group_label: "Big Fish Retention"
    label: "Big Fish D60"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 61
          then ${TABLE}.retention_d61
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 61
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }

  measure: big_fish_retention_d90 {
    group_label: "Big Fish Retention"
    label: "Big Fish D90"
    type: number
    sql:
    safe_divide(
      sum(
        case
          when ${TABLE}.max_available_day_number >= 91
          then ${TABLE}.retention_d91
          else 0
          end )
      ,
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 91
          then ${TABLE}.rdg_id
          else null
          end )
    )
    ;;
    value_format_name: percent_1
    # drill_fields: [numerator_retention_d120,available_player_count_d120]
  }


################################################################
## Retention On or After (Console Style)
################################################################

  measure: retention_on_or_after_d30 {
    group_label: "Retention On Or After"
    label: "On Or After D30"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.max_available_day_number >= 30
          and ${TABLE}.highest_played_day_number >= 30
          then ${TABLE}.rdg_id
          else null
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

################################################################
## Big Fish Combined Dollars
################################################################

  measure: big_fish_net_combined_dollars_d7 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D7"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d8;;
  }

  measure: big_fish_net_combined_dollars_d14 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D14"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d15;;
  }

  measure: big_fish_net_combined_dollars_d30 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D30"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d31;;
  }

  measure: big_fish_net_combined_dollars_d45 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D45"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d46;;
  }

  measure: big_fish_net_combined_dollars_d60 {
    group_label:"Big Fish LTV - Cumulative Net"
    label: "Big Fish LTV: D60"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_combined_dollars_d61;;
  }

################################################################
## Big Fish Net Mtx Dollars
################################################################

  measure: big_fish_net_mtx_dollars_d7 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D7"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d8;;
  }

  measure: big_fish_net_mtx_dollars_d14 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D14"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d15;;
  }

  measure: big_fish_net_mtx_dollars_d30 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D30"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d31;;
  }

  measure: big_fish_net_mtx_dollars_d45 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D45"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d46;;
  }

  measure: big_fish_net_mtx_dollars_d60 {
    group_label: "Big Fish Net IAP"
    label: "Big Fish IAP: D60"
    type: sum
    value_format_name: usd
    sql: ${TABLE}.cumulative_mtx_purchase_dollars_d61;;
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
    group_label: "Average Retention"
    label: "Total Installs"
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
    group_label: "Average Retention"
    label: "Retention Denominator D2"
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

  measure: available_player_count_d3 {
    group_label: "Average Retention"
    label: "Retention Denominator D3"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 3
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }
  measure: available_player_count_d4 {
    group_label: "Average Retention"
    label: "Retention Denominator D4"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 4
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }
  measure: available_player_count_d5 {
    group_label: "Average Retention"
    label: "Retention Denominator D5"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 5
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }
  measure: available_player_count_d6 {
    group_label: "Average Retention"
    label: "Retention Denominator D6"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 6
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }
  measure: available_player_count_d7 {
    group_label: "Average Retention"
    label: "Retention Denominator D7"
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
  measure: available_player_count_d8 {
    group_label: "Average Retention"
    label: "Retention Denominator D8"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }
  measure: available_player_count_d14 {
    group_label: "Average Retention"
    label: "Retention Denominator D14"
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

  measure: available_player_count_d21 {
    group_label: "Average Retention"
    label: "Retention Denominator D21"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d30 {
    group_label: "Average Retention"
    label: "Retention Denominator D30"
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
    group_label: "Average Retention"
    label: "Retention Denominator D60"
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

  measure: available_player_count_d90 {
    group_label: "Average Retention"
    label: "Retention Denominator D90"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: available_player_count_d120 {
    group_label: "Average Retention"
    label: "Retention Denominator D120"
    type: number
    sql:
    count( distinct
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0

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

  measure: engagement_milestone_10_minutes {
    label: "10+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 10
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

  measure: engagement_milestone_20_minutes {
    label: "20+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 20
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

  measure: engagement_milestone_45_minutes {
    label: "45+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 45
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

  measure: engagement_milestone_90_minutes {
    label: "90+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 90
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

  measure: engagement_milestone_360_minutes {
    label: "360+ Min"
    group_label: "Engagement Milestones"
    type: number
    sql:
    safe_divide(
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 360
          then ${TABLE}.rdg_id
          else null
          end )
      ,
      count( distinct ${TABLE}.rdg_id )
    )
    ;;
    value_format_name: percent_0
  }

################################################################
## Engagement Milestones Numerator
################################################################

  measure: numerator_engagement_milestone_5_minutes {
    label: "5+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 5
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_15_minutes {
    label: "15+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 15
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_30_minutes {
    label: "30+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 30
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_60_minutes {
    label: "60+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 60
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_90_minutes {
    label: "90+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 90
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_120_minutes {
    label: "120+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 120
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_engagement_milestone_360_minutes {
    label: "360+ Min Numerator"
    group_label: "Engagement Milestones"
    type: number
    sql:
      count( distinct
        case
          when ${TABLE}.cumulative_time_played_minutes >= 360
          then ${TABLE}.rdg_id
          else null
          end )
    ;;
    value_format_name: decimal_0
  }

################################################################
## Retention Numerator
################################################################

  measure: numerator_retention_d2 {
    group_label: "Average Retention"
    label: "Retention Numerator D2"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 2
          then ${TABLE}.retention_d2
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d3 {
    group_label: "Average Retention"
    label: "Retention Numerator D3"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 3
          then ${TABLE}.retention_d3
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d4 {
    group_label: "Average Retention"
    label: "Retention Numerator D4"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 4
          then ${TABLE}.retention_d4
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d5 {
    group_label: "Average Retention"
    label: "Retention Numerator D5"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 5
          then ${TABLE}.retention_d5
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d6 {
    group_label: "Average Retention"
    label: "Retention Numerator D6"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 6
          then ${TABLE}.retention_d6
          else 0
          end )
    ;;
    value_format_name: decimal_0
  }

  measure: numerator_retention_d7 {
    group_label: "Average Retention"
    label: "Retention Numerator D7"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 7
          then ${TABLE}.retention_d7
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d8 {
    group_label: "Average Retention"
    label: "Retention Numerator D7"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 8
          then ${TABLE}.retention_d8
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d14 {
    group_label: "Average Retention"
    label: "Retention Numerator D14"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 14
          then ${TABLE}.retention_d14
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d21 {
    group_label: "Average Retention"
    label: "Retention Numerator D21"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 21
          then ${TABLE}.retention_d21
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d30 {
    group_label: "Average Retention"
    label: "Retention Numerator D30"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 30
          then ${TABLE}.retention_d30
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d60 {
    group_label: "Average Retention"
    label: "Retention Numerator D60"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 60
          then ${TABLE}.retention_d60
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d90 {
    group_label: "Average Retention"
    label: "Retention Numerator D90"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 90
          then ${TABLE}.retention_d90
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }

  measure: numerator_retention_d120 {
    group_label: "Average Retention"
    label: "Retention Numerator D120"
    type: number
    sql:
      sum(
        case
          when ${TABLE}.max_available_day_number >= 120
          then ${TABLE}.retention_d120
          else 0
          end )
    ;;
    value_format_name: decimal_0

  }


  measure: average_total_campaigin_round_time_in_minutes_to_first_end_of_content_levels {
    group_label: "First End of Content Levels"
    label: "Average Campaign Minutes to First End of Content"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.total_campaigin_round_time_in_minutes_to_first_end_of_content_levels)
        ,
        count( distinct
          case
            when ${TABLE}.total_campaigin_round_time_in_minutes_to_first_end_of_content_levels is not null
            then ${TABLE}.rdg_id
            else null
            end
            )
      )
    ;;
    value_format_name: decimal_0
  }

  measure: count_players_to_ever_reach_end_of_content {
    group_label: "First End of Content Levels"
    label: "Count Players to Ever Reach End of Content"
    type: number
    sql:
      count( distinct
          case
            when ${TABLE}.total_campaigin_round_time_in_minutes_to_first_end_of_content_levels is not null
            then ${TABLE}.rdg_id
            else null
            end
            )
    ;;
    value_format_name: decimal_0
  }


  measure: count_players_to_have_not_played_in_at_least_14_days {
    group_label: "Churn"
    label: "Count Players to Have Not Played In 14+ Days "
    type: number
    sql:
      count( distinct
          case
            when date_diff(date(${TABLE}.latest_table_update),date(${TABLE}.last_played_date), day ) >= 14
            then ${TABLE}.rdg_id
            else null
            end
            )
    ;;
    value_format_name: decimal_0
  }

  measure: average_time_played_until_not_played_in_at_least_14_days {
    group_label: "Churn"
    label: "Average Minutes Played Until Churned for 14+ Days"
    type: number
    sql:
      safe_divide(
        sum(
          case
            when date_diff(date(${TABLE}.latest_table_update),date(${TABLE}.last_played_date), day ) >= 14
            then ${TABLE}.cumulative_time_played_minutes
            else null
            end
            )
        ,
        count( distinct
          case
            when date_diff(date(${TABLE}.latest_table_update),date(${TABLE}.last_played_date), day ) >= 14
            then ${TABLE}.rdg_id
            else null
            end
            )
        )

      ;;
    value_format_name: decimal_0
  }

################################################################
## Player Level ROAS Estimate
################################################################

  measure: player_estimated_cost_per_install {
    label: "Attributed Cost"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: usd_0
    sql:
      sum( ifnull( ${TABLE}.attributed_campaign_cost, 0 ) )
    ;;
  }

  measure: attributed_campaign_impressions {
    label: "Attributed Impressions"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: decimal_0
    sql:
      sum( ifnull( ${TABLE}.attributed_campaign_impressions, 0 ) )
    ;;
  }

  measure: attributed_cost_per_1000_impressions {
    label: "CPM"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: usd
    sql:
      safe_divide(
        sum( ifnull( ${TABLE}.attributed_campaign_cost, 0 ) )
        ,
        safe_divide( sum( ifnull( ${TABLE}.attributed_campaign_impressions, 0 ) ) , 1000 )
      )
    ;;
  }

  measure: attributed_cost_per_install {
    label: "CPI"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: usd
    sql:
      safe_divide(
        sum( ifnull( ${TABLE}.attributed_campaign_cost, 0 ) )
        ,
        count(distinct ${TABLE}.rdg_id )
      )
    ;;
  }


  measure: attributed_installs_per_1000_impressions {
    label: "IPM"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: decimal_1
    sql:
      safe_divide(
        count(distinct ${TABLE}.rdg_id )
        ,
        safe_divide( sum( ifnull( ${TABLE}.attributed_campaign_impressions, 0 ) ) , 1000 )
      )
    ;;
  }

  measure: attributed_cost_per_transaction {
    label: "Cost Per Transaction"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: usd
    sql:
      safe_divide(
        sum( ifnull( ${TABLE}.attributed_campaign_cost, 0 ) )
        ,
        sum( ${TABLE}.cumulative_count_mtx_purchases_current )
      )
    ;;
  }

  measure: attributed_cost_per_transaction_d7 {
    label: "Cost Per Transaction D7"
    group_label: "Campaign Analysis Stats"
    type: number
    value_format_name: usd
    sql:
      safe_divide(
        sum( ifnull( ${TABLE}.attributed_campaign_cost, 0 ) )
        ,
        sum( ${TABLE}.cumulative_count_mtx_purchases_d7 )
      )
    ;;
  }

measure: player_level_roas_estimate_d1 {
  label: "D1 ROAS"
  group_label: "Campaign ROAS"
  type: number
  value_format_name: percent_1
  sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d1)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
}

measure: player_level_roas_estimate_d2 {
    label: "D2 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d2)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d7 {
    label: "D7 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d7)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d8 {
    label: "D8 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d8)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d14 {
    label: "D14 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d14)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d15 {
    label: "D15 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d15)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d21 {
    label: "D21 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d21)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d30 {
    label: "D30 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d30)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d31 {
    label: "D31 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d31)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d46 {
    label: "D46 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d46)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d60 {
    label: "D60 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d60)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d61 {
    label: "D61 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d61)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d90 {
    label: "D90 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d90)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d120 {
    label: "D120 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d120)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d180 {
    label: "D180 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d180)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d270 {
    label: "D270 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d270)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_roas_estimate_d360 {
    label: "D360 ROAS"
    group_label: "Campaign ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_combined_dollars_d360)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

################################################################
## Player Level IAP ROAS Estimate
################################################################

  measure: player_level_iap_roas_estimate_d1 {
    label: "D1 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d1)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d2 {
    label: "D2 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d2)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d3 {
    label: "D3 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d3)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d4 {
    label: "D4 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d4)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d5 {
    label: "D5 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d5)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d6 {
    label: "D6 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d6)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d7 {
    label: "D7 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d7)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d8 {
    label: "D8 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d8)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }
  measure: player_level_iap_roas_estimate_d14 {
    label: "D14 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d14)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d15 {
    label: "D15 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d15)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d30 {
    label: "D30 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d30)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d31 {
    label: "D31 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d31)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d45 {
    label: "D45 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d45)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d46 {
    label: "D46 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d46)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d60 {
    label: "D60 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d60)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iap_roas_estimate_d61 {
    label: "D61 IAP ROAS"
    group_label: "IAP ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_mtx_purchase_dollars_d61)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

################################################################
## Player Level IAP ROAS Estimate
################################################################

  measure: player_level_iaa_roas_estimate_d1 {
    label: "D1 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d1)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }
  measure: player_level_iaa_roas_estimate_d2 {
    label: "D2 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d2)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d3 {
    label: "D3 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d3)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d4 {
    label: "D4 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d4)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d5 {
    label: "D5 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d5)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d6 {
    label: "D6 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d6)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d7 {
    label: "D7 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d7)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d8 {
    label: "D8 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d8)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d14 {
    label: "D14 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d14)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d15 {
    label: "D15 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d15)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d30 {
    label: "D30 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d30)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d31 {
    label: "D31 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d31)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d45 {
    label: "D45 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d45)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d46 {
    label: "D46 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d46)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d60 {
    label: "D60 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d60)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }

  measure: player_level_iaa_roas_estimate_d61 {
    label: "D61 IAA ROAS"
    group_label: "IAA ROAS"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum(${TABLE}.cumulative_ad_view_dollars_d61)
      ,
      sum(${TABLE}.attributed_campaign_cost)
    )
    ;;
  }


}
