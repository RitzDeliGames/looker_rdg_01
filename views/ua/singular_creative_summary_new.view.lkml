view: singular_creative_summary_new {
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
          , country_field
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

        -- summarized fields
        , sum(ifnull(adn_cost, 0)) as singular_total_cost
        , sum(ifnull(adn_impressions, 0)) as singular_total_impressions
        , sum(ifnull(adn_clicks, 0)) as singular_total_clicks
        , sum(ifnull(adn_installs, 0)) as singular_total_installs
      from
        `eraser-blast.singular.campaign_and_creative`
      where
        adn_cost is not null
      group by
        1,2,3,4,5,6,7,8,9,10,11,12,13
      )

      ----------------------------------------------------------------------
      -- singular creative data summarized
      ----------------------------------------------------------------------

      select
        *
        , @{new_singular_creative_name} as creative_name_mapped
      from
        singular_creative_data

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
  dimension: country_field {type:string}
  dimension: country {type:string}
  dimension: data_connector_source_name {type:string}
  dimension: source {type:string}
  dimension: os {type:string}
  dimension: platform {type:string}
  dimension: singular_campaign_id {type:string}
  dimension: campaign_name {type:string}
  dimension: creative_type {type:string}
  dimension: singular_total_cost {type:number}
  dimension: creative_day_number {type:number}
  dimension: singular_total_impressions {type:number}
  dimension: singular_total_clicks {type:number}
  dimension: singular_total_installs {type:number}
  dimension: full_ad_name {type:string}
  dimension: creative_name {type:string}
  dimension: creative_id {type:string}
  dimension: creative_name_mapped {type:string}

  dimension: simple_ad_name {
    type:string
    sql: ${TABLE}.singular_simple_ad_name ;;
  }
  dimension: singular_install_date {type: date}
  dimension: adn_creative_id {type: string}

  dimension: singular_grouped_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
  }

  dimension: singular_simple_ad_name {
    group_label: "Singular Creative Mapping"
    type: string
  }

####################################################################
## Campaign Name Clean
####################################################################

  dimension: singular_campaign_name_clean {
    group_label: "Singular Campaign Info"
    label: "Campaign Name (Clean)"
    type: string
  }

  dimension: install_category {
    label: "Install Category"
    type: string
    sql: @{campaign_install_category}  ;;
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
