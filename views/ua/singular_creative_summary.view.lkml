view: singular_creative_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-09-27'

      -- create or replace table tal_scratch.singular_creative_summary as

      with

      ----------------------------------------------------------------------
      -- singular creative data summarized
      ----------------------------------------------------------------------

      singular_creative_data as (

      select
      -- primary key
      timestamp(date) as rdg_date
      , asset_name
      , country_field as alfa_3_country_code
      , platform
      , adn_campaign_id
      , adn_creative_id
      , data_connector_source_name
      , source
      , os
      , adn_campaign_name as campaign_name
      , creative_type
      , adn_creative_name as creative_name
      , adn_creative_id as creative_id
      , asset_id

      -- summarized fields
      , sum(ifnull(adn_cost, 0)) as singular_total_cost
      , sum(ifnull(adn_impressions, 0)) as singular_total_impressions
      , sum(ifnull(adn_clicks, 0)) as singular_total_clicks
      , sum(ifnull(adn_installs, 0)) as singular_total_installs
      from
      `eraser-blast.singular.campaign_and_creative`
      where
      adn_cost is not null
      and date(timestamp(date)) <= '2024-07-17' -- last date for singular data
      group by
      1,2,3,4,5,6,7,8,9,10,11,12,13,14

      union all

      select
      timestamp(REGISTRATION_DATE) as rdg_date
      , publisher as asset_name
      , COUNTRY_CODE as country_field
      , PLATFORM as platform
      , '' as singular_campaign_id
      , publisher_id as adn_creative_id
      , AFFILIATE_NAME as data_connector_source_name
      , AFFILIATE_NAME as source
      , PLATFORM as os
      , lower(CAMPAIGN_NAME) as campaign_name
      , '' as creative_type
      , PUBLISHER as creative_name
      , publisher_id as creative_id
      , publisher_id as asset_id
      , sum(TOTAL_SPEND) as singular_total_cost
      , sum(PARTNER_IMPRESSIONS) as singular_total_impressions
      , sum(PARTNER_CLICKS) as singular_total_clicks
      , sum(PARTNER_INSTALLS) as singular_total_installs

      from
      eraser-blast.bfg_import.gogame_data
      where
      GAME = 'Chum Chum Blast'
      and date(timestamp(REGISTRATION_DATE)) > '2024-07-17' -- picking up where singular leaves off
      and PARTNER_IMPRESSIONS is not null -- no nulls!
      and publisher is not null -- no nulls!
      and length(publisher) > 2 -- filtering out \N values
      group by
      1,2,3,4,5,6,7,8,9,10,11,12,13,14

      )

      ----------------------------------------------------------------------
      -- apply mapping
      ----------------------------------------------------------------------

      , my_apply_mapping_table as (

      select
      *
      , @{creative_name_mapping} as creative_name_mapped
      , @{campaign_name_mapped} as campaign_name_mapped
      , @{map_3_digit_country_code_to_3_digit_country_code} as country
      from
      singular_creative_data

      )

      ----------------------------------------------------------------------
      -- get first date for creative day number
      ----------------------------------------------------------------------

      , get_first_date_for_creative_day_number_table as (

      select
      creative_name_mapped
      , min(rdg_date) as first_creative_date
      from
      my_apply_mapping_table
      where
      creative_name_mapped is not null
      group by
      1

      )

      ----------------------------------------------------------------------
      -- add on creative day number
      ----------------------------------------------------------------------

      select
      a.*
      , b.first_creative_date
      , 1 + date_diff(date(a.rdg_date), date(b.first_creative_date), day) as creative_day_number
      , a.campaign_name_mapped as singular_campaign_name_clean
      , a.creative_name_mapped as singular_simple_ad_name
      , a.rdg_date as singular_install_date

      from
      my_apply_mapping_table a
      left join get_first_date_for_creative_day_number_table b
      on a.creative_name_mapped = b.creative_name_mapped


      ;;
    ## the hardcoded meta data table is scheduled for 1AM UTC
    ## So this will run at 2AM UTC
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (2) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_date
    || '_' || ${TABLE}.asset_name
    || '_' || ${TABLE}.country_field
    || '_' || ${TABLE}.platform
    || '_' || ${TABLE}.adn_campaign_id
    || '_' || ${TABLE}.adn_creative_id
    || '_' || ${TABLE}.data_connector_source_name
    || '_' || ${TABLE}.source
    || '_' || ${TABLE}.os
    || '_' || ${TABLE}.campaign_name
    || '_' || ${TABLE}.creative_type
    || '_' || ${TABLE}.adn_creative_name
    || '_' || ${TABLE}.adn_creative_id
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Date Groups
####################################################################

  dimension_group: date {
    label: "Creative Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension_group: first_creative_date {
    label: "First Creative"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_creative_date ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: asset_name {type:string}
  dimension: country_field {type:string sql: ${TABLE}.alfa_3_country_code ;;}
  dimension: country {type:string}
  dimension: data_connector_source_name {type:string}
  dimension: source {type:string}
  dimension: os {type:string}
  dimension: platform {type:string}
  dimension: campaign_name {type:string}
  dimension: creative_type {type:string}
  dimension: singular_total_cost {type:number}
  dimension: creative_day_number {type:number}
  dimension: singular_total_impressions {type:number}
  dimension: singular_total_clicks {type:number}
  dimension: singular_total_installs {type:number}
  dimension: creative_name {type:string}
  dimension: creative_id {type:string}
  dimension: creative_name_mapped {type:string}
  dimension: full_ad_name {type:string sql:${TABLE}.creative_name;;}
  dimension: asset_id {type:string}

  dimension: simple_ad_name {
    type:string
    sql: ${TABLE}.creative_name_mapped ;;
  }
  dimension: singular_install_date {type: date}
  dimension: adn_creative_id {type: string}

  dimension: singular_grouped_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
    sql: '' ;;
  }

  dimension: singular_simple_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
    sql: ${TABLE}.creative_name_mapped ;;
  }

####################################################################
## Campaign Name Clean
####################################################################

  dimension: singular_campaign_name_clean {
    label: "Campaign Name (Clean)"
    type: string
    sql: ${TABLE}.campaign_name_mapped;;
  }

  dimension: install_category {
    label: "Install Category"
    type: string
    sql: @{campaign_install_category_mapped}  ;;
  }



####################################################################
## Measures
####################################################################

  measure: sum_of_singular_total_cost {
    group_label: "Summary Metrics"
    label: "Cost"
    type: number
    sql: sum( ${TABLE}.singular_total_cost ) ;;
    value_format_name: usd_0
  }

  measure: sum_of_singular_total_impressions {
    group_label: "Summary Metrics"
    label: "Impressions"
    type: number
    sql: sum( ${TABLE}.singular_total_impressions ) ;;
    value_format_name: decimal_0
  }

  measure: sum_of_singular_total_clicks {
    group_label: "Summary Metrics"
    label: "Clicks"
    type: number
    sql: sum( ${TABLE}.singular_total_clicks ) ;;
    value_format_name: decimal_0
  }

  measure: sum_of_singular_total_installs {
    group_label: "Summary Metrics"
    label: "Installs"
    type: number
    sql: sum( ${TABLE}.singular_total_installs ) ;;
    value_format_name: decimal_0
  }

  measure: cost_per_thousand_impressions {
    group_label: "Summary Metrics"
    label: "CPM"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.singular_total_cost )
        ,
        sum( ${TABLE}.singular_total_impressions )
      )
      *
      1000

      ;;
    value_format_name: usd
  }

  measure: installs_per_thousand_impressions {
    group_label: "Summary Metrics"
    label: "IPM"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.singular_total_installs )
        ,
        sum( ${TABLE}.singular_total_impressions )
      )
      *
      1000

      ;;
    value_format_name: decimal_1
  }

  measure: cost_per_install {
    group_label: "Summary Metrics"
    label: "CPI"
    type: number
    sql:
      safe_divide(
        sum( ${TABLE}.singular_total_cost )
        ,
        sum( ${TABLE}.singular_total_installs )
      )
     ;;
    value_format_name: usd
  }



}
