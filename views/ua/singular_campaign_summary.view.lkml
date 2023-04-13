view: singular_campaign_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2023-04-13'

      -- create or replace table tal_scratch.singular_campaign_summary as

      with

      -----------------------------------------------------------------------
      -- singular_country_code_helper
      -----------------------------------------------------------------------

      singular_country_code_helper as (

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
          , timestamp(a.date) as singular_install_date
          , max( a.adn_campaign_name ) campaign_name
          , max( a.source ) as singular_source
          , max( a.platform ) as singular_platform
          , max( b.singular_country_name ) as singular_country_name
          , max( b.singular_country ) as singular_country
          , sum( cast(a.adn_impressions as int64)) as singular_total_impressions
          , sum( cast(a.adn_cost as float64)) as singular_total_cost
          , sum( cast(a.adn_original_cost as float64)) as singular_total_original_cost
          , sum( cast(a.adn_installs AS int64)) as singular_total_installs
        from
          `eraser-blast.singular.marketing_data` a
          left join singular_country_code_helper b
            on a.country_field = b.Alpha_3_code
        group by
          1,2
      )


      select * from singular_campaign_summary


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
    ${TABLE}.singular_campaign_id;;
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
    sql: ${TABLE}.rdg_date ;;
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
