view: singular_campaign_detail {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-12-18'

      -- create or replace table tal_scratch.singular_campaign_summary as

      with

      -----------------------------------------------------------------------
      -- singular_country_code_helper
      -----------------------------------------------------------------------

      -- singular_country_code_helper as (

      -- select
      -- Alpha_3_code
      -- , max(country) as singular_country_name
      -- , max(Alpha_2_code) as singular_country
      -- from
      -- `eraser-blast.singular.country_codes`
      -- group by
      -- 1

      -- )

      -----------------------------------------------------------------------
      -- singular_campaign_summary
      -----------------------------------------------------------------------

      singular_campaign_summary as (

      select
      a.adn_campaign_id as singular_campaign_id
      , timestamp(a.date) as singular_install_date
      , a.source as singular_source
      , a.platform as singular_platform
      , a.adn_sub_adnetwork_name
      , case
          when a.platform = 'iOS' then 'Apple'
          when a.platform = 'Android' then 'Google'
          else 'Other'
          end as device_platform_mapping
      -- , b.singular_country_name as singular_country_name
      -- , b.singular_country as country

      , max( a.adn_campaign_name ) campaign_name
      , sum( cast(a.adn_impressions as int64)) as singular_total_impressions
      , sum( cast(a.adn_cost as float64)) as singular_total_cost
      , sum( cast(a.adn_original_cost as float64)) as singular_total_original_cost
      , sum( cast(a.adn_installs AS int64)) as singular_total_installs
      , sum( cast(a.adn_clicks AS int64)) as singular_total_clicks

      from
      `eraser-blast.singular.marketing_data` a
      -- left join singular_country_code_helper b
      -- on a.country_field = b.Alpha_3_code
      group by
      1,2,3,4,5,6
      )

      -----------------------------------------------------------------------
      -- add last install date for each campaign
      -----------------------------------------------------------------------

      -- select distinct singular_platform from singular_campaign_summary

      select
        singular_campaign_id
        , singular_install_date
        , singular_source
        , singular_platform
        , device_platform_mapping
        -- , singular_country_name
        -- , country
        , campaign_name
        , singular_total_impressions
        , singular_total_cost
        , singular_total_original_cost
        , singular_total_installs
        , singular_total_clicks
        , adn_sub_adnetwork_name
        , min( singular_install_date ) over ( partition by singular_campaign_id ) as campaign_start_date

        -----------------------------------------------------------------------
        -- constants from the manifest
        -----------------------------------------------------------------------

        -- , country_region as region
        , @{campaign_name_mapped} as singular_campaign_name_clean

      from
        singular_campaign_summary

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (1) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.singular_campaign_id
    || '_' || ${TABLE}.singular_install_date
    || '_' || ${TABLE}.singular_source
    || '_' || ${TABLE}.singular_platform
    || '_' || ${TABLE}.device_platform_mapping
    || '_' || ${TABLE}.singular_country_name
    || '_' || ${TABLE}.country
    || '_' || ${TABLE}.adn_sub_adnetwork_name

      ;;
    primary_key: yes
    hidden: yes
  }


####################################################################
## Date Groups
####################################################################

  dimension: singular_install_date {type: date}

  dimension_group: singular_install_date {
    label: "Install Date Group"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.singular_install_date ;;
  }

  dimension_group: campaign_start_date {
    label: "Campaign Start Date Group"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.campaign_start_date ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: singular_campaign_id {
    group_label: "Singular Campaign Info"
    type:string}
  dimension: campaign_name {
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
  dimension: singular_total_clicks {
    group_label: "Singular Campaign Info"
    type:number}

  dimension: singular_source {
    group_label: "Singular Campaign Info"
    type:string}
  dimension: singular_platform {
    group_label: "Singular Campaign Info"
    type:string}
  dimension: device_platform_mapping {
    group_label: "Singular Campaign Info"
    type:string}

  # dimension: singular_country_name {
  #   group_label: "Singular Campaign Info"
  #   type:string}
  # dimension: country {
  #   group_label: "Singular Campaign Info"
  #   type:string}
  # dimension: region {
  #   group_label: "Singular Campaign Info"
  #   type:string
  #   }

  dimension: singular_campaign_name_clean {
    group_label: "Singular Campaign Info"
    label: "Campaign Name (Clean)"
    type: string
  }

  dimension: adn_sub_adnetwork_name {
    group_label: "Singular Campaign Info"
    label: "Placement"
    type: string
  }

  dimension: placement_combined {
    group_label: "Singular Campaign Info"
    label: "Placement Group"
    type: string
    sql:
      case
        when ${TABLE}.adn_sub_adnetwork_name = 'Facebook' then 'Feeds (Facebook + Instagram)'
        when ${TABLE}.adn_sub_adnetwork_name = 'Facebook Audience Network' then 'Audience Network'
        when ${TABLE}.adn_sub_adnetwork_name = 'Instagram' then 'Feeds (Facebook + Instagram)'
        else 'Other'
        end

    ;;


  }


}
