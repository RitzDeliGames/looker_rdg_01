view: singular_creative_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-04-14'

      -- create or replace table tal_scratch.singular_creative_summary as

      with

      ----------------------------------------------------------------------
      -- singular creative data summarized
      ----------------------------------------------------------------------

      singular_creative_data as (
          select
            -- primary key
            date
            , adn_creative_id
            , country_field

            -- summarized fields
            , max(data_connector_source_name) as data_connector_source_name
            , max(source) as source
            , max(os) as os
            , max(platform) as platform
            , max(adn_campaign_id) as singular_campaign_id
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
          1,2,3
      )

      ----------------------------------------------------------------------
      -- linked meta data
      -- google sheets link: https://docs.google.com/spreadsheets/d/1bxt-VukA_jjp5sV-ySbQfgr35keJOznzvBdPf8ilb9k/edit?usp=share_link
      -- ask Rob or Tal for access
      ----------------------------------------------------------------------

      , linked_meta_data as (

        select
          adn_creative_id
          , full_ad_name
          , simple_ad_name
        from
          `eraser-blast.singular.creative_meta_data`
        where
          adn_creative_id is not null
          and full_ad_name is not null
          and simple_ad_name is not null
      )

      ----------------------------------------------------------------------
      -- join together
      ----------------------------------------------------------------------

      , join_data_together as (

        select
          a.*
          , b.full_ad_name
          , b.simple_ad_name
        from
          singular_creative_data a
          left join linked_meta_data b
            on a.adn_creative_id = b.adn_creative_id

      )


      ----------------------------------------------------------------------
      -- select data
      ----------------------------------------------------------------------

      select * from join_data_together
      order by date desc




      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    publish_as_db_view: yes

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.date
    || '_' || ${TABLE}.adn_creative_id
    || '_' || ${TABLE}.country_field
    ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Date Groups
####################################################################

  dimension_group: date {
    label: "Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.date ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: adn_creative_id {type:string}
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
