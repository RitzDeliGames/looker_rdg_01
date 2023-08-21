view: singular_creative_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-08-21'

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
      , a.platform
      , a.adn_campaign_id as singular_campaign_id
      , a.adn_creative_id
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
-- select data
----------------------------------------------------------------------

select * from join_metadata_by_creative_id

      ;;
    ## the hardcoded meta data table is scheduled for 1AM UTC
    ## So this will run at 2AM UTC
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
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
    sql: @{singular_creative_simplified_ad_name} ;;
    }
  dimension: singular_install_date {type: date}
  dimension: adn_creative_id {type: string}

####################################################################
## Campaign Name Clean
####################################################################

  dimension: singular_campaign_name_clean {
    group_label: "Singular Campaign Info"
    label: "Campaign Name (Clean)"
    type: string
    sql: @{campaign_name_clean_update} ;;
  }

}
