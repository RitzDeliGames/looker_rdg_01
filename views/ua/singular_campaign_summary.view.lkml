view: singular_campaign_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-09-27'

      with

      -----------------------------------------------------------------------
      -- singular_campaign_summary
      -----------------------------------------------------------------------

      singular_campaign_summary as (

      select
      singular_campaign_id
      , singular_install_date
      , max( campaign_name ) campaign_name
      , sum( ifnull(singular_total_impressions,0) ) as singular_total_impressions
      , sum( ifnull(singular_total_cost,0) ) as singular_total_cost
      , sum( ifnull(singular_total_original_cost,0) ) as singular_total_original_cost
      , sum( ifnull(singular_total_installs,0) ) as singular_total_installs
      from
      ${singular_campaign_detail.SQL_TABLE_NAME}
      -- eraser-blast.looker_scratch.6Y_ritz_deli_games_singular_campaign_summary
      group by
      1,2
      )

      -----------------------------------------------------------------------
      -- add last install date for each campaign
      -----------------------------------------------------------------------
      select
        singular_campaign_id
        , singular_install_date
        , campaign_name
        , singular_total_impressions
        , singular_total_cost
        , singular_total_original_cost
        , singular_total_installs
        , min( singular_install_date ) over ( partition by singular_campaign_id ) as campaign_start_date

        -----------------------------------------------------------------------
        -- constants from manifest
        -----------------------------------------------------------------------

        , @{campaign_name_clean_update} as singular_campaign_name_clean

      from
        singular_campaign_summary

      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (2) + 2 )*( -10 ) minute)) ;;
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


####################################################################
## Campaign Name Clean
####################################################################

  dimension: singular_campaign_name_clean {
    group_label: "Singular Campaign Info"
    label: "Campaign Name (Clean)"
    type: string
  }

}
