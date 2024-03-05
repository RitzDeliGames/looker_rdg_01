view: player_summary_new {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2023-08-22'

      select
        rdg_id
        , last_played_date
        , latest_table_update
        , device_id
        , advertising_id
        , user_id
        , display_name
        , platform
        , country
        , created_date
        , max_available_day_number
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
        , retention_d46
        , retention_d60
        , retention_d61
        , retention_d90
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

      from
        -- eraser-blast.looker_scratch.LR_6YUJU1709664574784_player_summary_staging
        ${player_summary_staging.SQL_TABLE_NAME}

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (6) + 2 )*( -10 ) minute)) ;;
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
  dimension: firebase_advertising_id {group_label:"Player IDs" type:string}
  dimension: experiments {type: string}
  dimension: version_at_install {group_label:"Versions" label: "Install Version" type: string}
  dimension: version_d2 {group_label:"Versions" type: string}
  dimension: version_d7 {group_label:"Versions" type: string}
  dimension: version_d14 {group_label:"Versions" type: string}
  dimension: version_d30 {group_label:"Versions" type: string}
  dimension: version_d60 {group_label:"Versions" type: string}
  dimension: version_d90 {group_label:"Versions" type: string}
  dimension: version_current {group_label:"Versions" label: "Current Version" type: string}
  dimension: platform {type: string}
  dimension: country {type: string}
  dimension: region {type:string sql:@{country_region};;}
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
    sql: DATE_DIFF( DATE(${TABLE}.last_played_date) , DATE( ${TABLE}.created_date ), DAY) + 1 ;;
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
    sql: @{device_platform_mapping} ;;
  }

  dimension: device_platform_mapping_os {
    group_label: "System Info"
    type: string
    sql: @{device_platform_mapping_os} ;;
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
## Singular Campaign Mapping
######################################################################

  dimension: singular_device_id {
    group_label: "Singular Campaign Mapping"
    type:string}

  dimension: singular_partner_name {
    group_label: "Singular Campaign Mapping"
    type:string}

  dimension: singular_campaign_id {
    group_label: "Singular Campaign Mapping"
    type:string}

  dimension: singular_campaign_id_override {
    group_label: "Singular Campaign Mapping"
    type: string
    sql: @{singular_campaign_id_override} ;;
  }

  dimension: singular_created_date_override {
    group_label: "Singular Campaign Mapping"
    type: date
    sql: @{singular_created_date_override};;
  }

  dimension: singular_campaign_blended_window_override {
    group_label: "Singular Campaign Mapping"
    type: string
    sql: @{singular_campaign_blended_window_override} ;;
  }

  dimension: campaign_with_organics_estimate {
    group_label: "Singular Campaign Mapping"
    label: "Campaign with Organics (Estimate)"
    type: string
    sql: @{campaign_with_organics_estimate} ;;
  }

######################################################################
## Singular Creative Mapping
######################################################################

  dimension: singular_full_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
    sql: @{singular_full_ad_name} ;;
  }

  dimension: singular_creative_id {
    group_label: "Singular Creative Mapping"
    type: string
  }

  dimension: singular_grouped_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
    sql: @{singular_grouped_ad_name} ;;
  }

  dimension: singular_simple_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
    sql: @{singular_simple_ad_name} ;;
  }


######################################################################
## Expirements
######################################################################

  parameter: selected_experiment {
    type: string
    suggestions:  [
      "$.No_AB_Test_Split"

      , "$.hudOffers_20240228"
      , "$.movesMasterTune_20240227"
      , "$.dynamicEggs_20240223"
      , "$.altLevelOrder_20240220"

      , "$.swapTeamp2_20240209"
      , "$.goFishAds_20240208"
      , "$.dailyPopups_20240207"

      , "$.ExtraMoves1k_20240130"
      , "$.loAdMax_20240131"
      , "$.extendedQPO_20240131"

      , "$.blockColor_20240119"
      , "$.propBehavior_20240118"
      , "$.lv400500MovesTest_20240116"
      , "$.lv200300MovesTest_20240116"
      , "$.extraMovesOffering_20240111"

      ,"$.lv650800Moves_20240105"
      ,"$.lv100200Movesp2_20240103"
      ,"$.fueLevelsV3p2_20240102"
      ,"$.showLockedCharacters_20231215"
      ,"$.scrollableTT_20231213"
      ,"$.coinMultiplier_20231208"

      ,"$.lv100200Moves_20231207"
      ,"$.fueLevelsV3_20231207"
      ,"$.hapticv3_20231207"
      ,"$.swapTeam_20231206"
      ,"$.colorBoost_20231205"
      ,"$.lv300400MovesTest_20231207"

      ,"$.hudSquirrel_20231128"
      ,"$.blockSize_11152023"
      ,"$.lockedEvents_20231107"

      ,"$.coinPayout_20231108"

      ,"$.askForHelp_20231023"

      ,"$.coinPayout_20230824"

      ,"$.mustardPretzel_09262023"
      ,"$.chumPrompt_09262023"
      ,"$.dynamicRewardsRatio_20230922"
      ,"$.reducedMoves_20230919"
      ,"$.autoRestore_20230912"

      ,"$.goFish_20230915"

      ,"$.extraMoves_20230908"
      ,"$.spreadsheetMove_20230829"

      ,"$.steakSwap_20230823"
      ,"$.gravityTest_20230821"
      ,"$.colorballBehavior_20230828"

      ,"$.colorballBehavior_20230817"
      ,"$.askForHelp_20230816"
      ,"$.minigameGo_20230814"
      ,"$.puzzleLives_20230814"
      ,"$.propBehavior_20230814"
      ,"$.flourFrenzyRepeat_20230807"

      ,"$.dynamicDropBiasv4_20230802"
      ,"$.zonePayout_20230728"
      ,"$.propBehavior_20230726"

      ,"$.propBehavior_20230717"
      ,"$.zoneDrops_20230718"
      ,"$.zoneDrops_20230712"
      ,"$.hotdogContest_20230713"
      ,"$.fue1213_20230713"
      ,"$.magnifierRegen_20230711"
      ,"$.mMTiers_20230712"
      ,"$.dynamicDropBiasv3_20230627"
      ,"$.popupPri_20230628"
      ,"$.reactivationIAM_20230622"
      ,"$.playNext_20230612"
      ,"$.playNext_20230607"
      ,"$.playNext_20230503"
      ,"$.restoreBehavior_20230601"
      ,"$.moveTrim_20230601"
      ,"$.askForHelp_20230531"
      ,"$.hapticv2_20230524"
      ,"$.finalMoveAnim"
      ,"$.popUpManager_20230502"
      ,"$.fueSkip_20230425"
      ,"$.autoRestore_20230502"
      ,"$.playNext_20230503"
      ,"$.dynamicDropBiasv2_20230423"
      ,"$.puzzleEventv2_20230421"
      ,"$.bigBombs_20230410"
      ,"$.boardClear_20230410"
      ,"$.iceCreamOrder_20230419"
      ,"$.diceGame_20230419"
      ,"$.fueUnlocks_20230419"
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
    group_label: "Cumulative Conversion"
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







}
