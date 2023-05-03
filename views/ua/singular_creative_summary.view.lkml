view: singular_creative_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-04-28'

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

            -- summarized fields
            , max(adn_creative_id) as adn_creative_id
            , max(data_connector_source_name) as data_connector_source_name
            , max(source) as source
            , max(os) as os
            , max(adn_campaign_name) as campaign_name
            , max(creative_type) as creative_type
            , sum(ifnull(adn_cost, 0)) as singular_total_cost
            , sum(ifnull(adn_impressions, 0)) as singular_total_impressions
            , sum(ifnull(adn_clicks, 0)) as singular_total_clicks
            , sum(ifnull(adn_installs, 0)) as singular_total_installs
        from
          `eraser-blast.singular.campaign_and_creative`
        where
          adn_cost is not null
        group by
          1,2,3,4,5
      )

      ----------------------------------------------------------------------
      -- linked meta data
      -- google sheets link: https://docs.google.com/spreadsheets/d/1bxt-VukA_jjp5sV-ySbQfgr35keJOznzvBdPf8ilb9k/edit?usp=share_link
      -- sheet name: hardcoded
      -- ask Rob or Tal for access
      ----------------------------------------------------------------------

      , linked_metadata_by_asset_name as (

        select distinct
          asset_name
          , full_ad_name
          , full_name_with_id
          , simple_ad_name
        from
          `eraser-blast.singular.creative_metadata_by_asset_name_hardcoded`
        where
          asset_name is not null
          and full_name_with_id is not null
          and full_ad_name is not null
          and simple_ad_name is not null
      )

      ----------------------------------------------------------------------
      -- join together
      ----------------------------------------------------------------------

      , join_metadata_by_asset_name as (

        select
          a.*
          , b.full_ad_name
          , b.simple_ad_name
          , b.full_name_with_id
        from
          singular_creative_data a
          left join linked_metadata_by_asset_name b
            on a.asset_name = b.asset_name

      )

      ----------------------------------------------------------------------
      -- linked meta data by creative id
      -- google sheets link: https://docs.google.com/spreadsheets/d/1bxt-VukA_jjp5sV-ySbQfgr35keJOznzvBdPf8ilb9k/edit?usp=share_link
      -- sheet name: hardcoded
      -- ask Rob or Tal for access
      ----------------------------------------------------------------------

      , linked_metadata_by_creative_id as (

        select distinct
          adn_creative_id
          , full_ad_name
          , simple_ad_name
        from
          `eraser-blast.singular.creative_metadata_by_creative_id_hardcoded`
        where
          adn_creative_id is not null
          and full_ad_name is not null
          and simple_ad_name is not null
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
          left join linked_metadata_by_creative_id b
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

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_date
    || '_' || ${TABLE}.asset_name
    || '_' || ${TABLE}.country_field
    || '_' || ${TABLE}.platform
    || '_' || ${TABLE}.adn_campaign_id
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
  dimension: simple_ad_name {type:string}
  dimension: full_name_with_id {type:string}
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
