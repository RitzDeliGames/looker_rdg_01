view: singular_creative_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-08-28'

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
    1,2,3,4,5,6,7,8,9,10,11
)


----------------------------------------------------------------------------
-- meta data step 1
-- find mp4 position in the impage_video_slideshow_field
-- NOTE: this data is hardcoded from a linked table: eraser-blast.singular.creative_meta_data_export_linked
------ data for linked table is found at:
------ https://docs.google.com/spreadsheets/d/1bxt-VukA_jjp5sV-ySbQfgr35keJOznzvBdPf8ilb9k/edit?usp=sharing
------ ask Rob or Tal for access
----------------------------------------------------------------------------

, my_find_mp4_position_table as (

  select
    ad_id
    , ad_name
    , image_video_slideshow
    , safe.regexp_instr(image_video_slideshow,'.mp4') as find_mp4_position
  from
    eraser-blast.singular.creative_meta_data_export

)

----------------------------------------------------------------------------
-- meta data step 2
-- find parenthesis for asset name
----------------------------------------------------------------------------

, my_find_start_and_end_parenthesis as (

  select
      ad_id
      , ad_name
      , image_video_slideshow
      , find_mp4_position
      , safe.regexp_instr(image_video_slideshow,'[(]',find_mp4_position) as find_start_parenthesis
      , safe.regexp_instr(image_video_slideshow,'[)]',find_mp4_position) as find_end_parenthesis
  from
    my_find_mp4_position_table

)


----------------------------------------------------------------------------
-- meta data step 3
-- derive full ad name and asset_name
----------------------------------------------------------------------------

, my_singular_meta_data as (

  select
    ad_id
    , ad_name
    , image_video_slideshow
    , find_mp4_position
    , find_start_parenthesis
    , find_end_parenthesis
    , case
        when find_mp4_position = 0 then null
        when find_mp4_position is null then null
        else substr(image_video_slideshow,0,find_mp4_position+3)
        end as full_ad_name
    , case
        when find_mp4_position = 0 then null
        when find_mp4_position is null then null
        when find_start_parenthesis is null then null
        when find_end_parenthesis is null then null
        else substr(image_video_slideshow,find_start_parenthesis+1,find_end_parenthesis-find_start_parenthesis-1)
        end as asset_name

  from
    my_find_start_and_end_parenthesis
)

----------------------------------------------------------------------
-- meta_data by asset name
----------------------------------------------------------------------

, my_metadata_by_asset_name as (

  select
    asset_name
    , max(full_ad_name) as full_ad_name
    , max(image_video_slideshow) as full_name_with_id
    , '' as simple_ad_name
  from
    my_singular_meta_data
  where
    asset_name is not null
    and image_video_slideshow is not null
    and full_ad_name is not null
    -- and simple_ad_name is not null
  group by
    1
)

----------------------------------------------------------------------
-- meta_data by asset name (with actual asset name)
----------------------------------------------------------------------

, my_metadata_by_asset_name_actual_asset_name as (

  select
    full_ad_name
    , max(image_video_slideshow) as full_name_with_id
    , '' as simple_ad_name
  from
    my_singular_meta_data
  where
    asset_name is not null
    and image_video_slideshow is not null
    and full_ad_name is not null
    -- and simple_ad_name is not null
  group by
    1
)

----------------------------------------------------------------------
-- join together
----------------------------------------------------------------------

, join_metadata_by_asset_name as (

  select
    a.*
    , case
        when b.full_ad_name is null
        then c.full_ad_name
        else b.full_ad_name end as full_ad_name
    ,
      case
        when b.simple_ad_name is null
        then c.simple_ad_name
        else b.simple_ad_name end as simple_ad_name
    ,
      case
        when b.full_name_with_id is null
        then c.full_name_with_id
        else b.full_name_with_id end as full_name_with_id
  from
    singular_creative_data a
    left join my_metadata_by_asset_name b
      on a.asset_name = b.asset_name
    left join my_metadata_by_asset_name_actual_asset_name c
      on a.asset_name = c.full_ad_name

)

----------------------------------------------------------------------
-- meta data by creative id (ad id)
----------------------------------------------------------------------

, my_metadata_by_creative_id as (

  select
    ad_id as adn_creative_id
    , max(full_ad_name) as full_ad_name
    , '' as simple_ad_name
  from
    my_singular_meta_data
  where
    ad_id is not null
    and full_ad_name is not null
    -- and simple_ad_name is not null
  group by
    1
)

----------------------------------------------------------------------
-- join together
----------------------------------------------------------------------

, join_metadata_by_creative_id as (

  select
      a.rdg_date
      , a.rdg_date as singular_install_date
      , a.asset_name
      , a.country_field
      , a.country_field as alfa_3_country_code
      , a.platform
      , a.adn_campaign_id as singular_campaign_id
      , a.adn_creative_id
      , a.adn_creative_id as singular_creative_id
      , a.data_connector_source_name
      , a.source
      , a.os
      , a.campaign_name
      , a.creative_type
      , case
          when asset_name = ''
          and a.full_ad_name is null
          then b.full_ad_name
          else a.full_ad_name
          end as full_ad_name
      , case
          when asset_name = ''
          and a.simple_ad_name is null
          then b.simple_ad_name
          else a.simple_ad_name
          end as simple_ad_name
      , a.singular_total_cost
      , a.singular_total_impressions
      , a.singular_total_clicks
      , a.singular_total_installs
  from
    join_metadata_by_asset_name a
    left join my_metadata_by_creative_id b
      on a.adn_creative_id = b.adn_creative_id

)

  ----------------------------------------------------------------------
  -- combine with go game creative data
  ----------------------------------------------------------------------

  , my_combined_with_go_game_creative_data_step as (

    select
      rdg_date
      , singular_install_date
      , asset_name
      , country_field
      , alfa_3_country_code
      , platform
      , singular_campaign_id
      , adn_creative_id
      , singular_creative_id
      , data_connector_source_name
      , source
      , os
      , campaign_name
      , creative_type
      , full_ad_name
      , simple_ad_name
      , singular_total_cost
      , singular_total_impressions
      , singular_total_clicks
      , singular_total_installs

    from
      join_metadata_by_creative_id
    where
      date(rdg_date) <= '2024-07-17' -- last date for singular data

    union all

    select
      timestamp(REGISTRATION_DATE) as rdg_date
      , timestamp(REGISTRATION_DATE) as singular_install_date
      , publisher as asset_name
      , COUNTRY_CODE as country_field
      , COUNTRY_CODE as alfa_3_country_code
      , PLATFORM as platform
      , '' as singular_campaign_id
      , publisher_id as adn_creative_id
      , publisher_id as singular_creative_id
      , AFFILIATE_NAME as data_connector_source_name
      , AFFILIATE_NAME as source
      , PLATFORM as os
      , lower(CAMPAIGN_NAME) as campaign_name
      , '' as creative_type
      , PUBLISHER as full_ad_name
      , PUBLISHER as simple_ad_name
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
      1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

  )

  ----------------------------------------------------------------------
  -- select data
  ----------------------------------------------------------------------

  , select_data_from_join as (

    select
      rdg_date
      , singular_install_date
      , asset_name
      , country_field
      , alfa_3_country_code
      , platform
      , singular_campaign_id
      , adn_creative_id
      , singular_creative_id
      , data_connector_source_name
      , source
      , os
      , campaign_name
      , creative_type
      , full_ad_name
      , simple_ad_name
      , singular_total_cost
      , singular_total_impressions
      , singular_total_clicks
      , singular_total_installs

      ----------------------------------------------------------------------
      -- constants from manifest
      ----------------------------------------------------------------------

      , @{map_3_digit_country_code_to_3_digit_country_code} as country
      , @{singular_grouped_ad_name} as singular_grouped_ad_name
      , @{singular_simple_ad_name} as singular_simple_ad_name
      , @{campaign_name_clean_update} as campaign

    from
      my_combined_with_go_game_creative_data_step

    )

  ----------------------------------------------------------------------
  -- fix for campaign name
  ----------------------------------------------------------------------

  select
    b.* except ( campaign )
    , @{bfg_campaign_name_mapping} as singular_campaign_name_clean
  from
    select_data_from_join b





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

  # timestamp(date) as rdg_date
  # , asset_name
  # , country_field
  # , platform
  # , adn_campaign_id
  # , adn_creative_id
  # , data_connector_source_name
  # , source
  # , os
  # , adn_campaign_name as campaign_name
  # , creative_type

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
  dimension: singular_total_impressions {type:number}
  dimension: singular_total_clicks {type:number}
  dimension: singular_total_installs {type:number}
  dimension: full_ad_name {type:string}
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
