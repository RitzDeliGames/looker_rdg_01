view: bfg_player_attribution {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-11-13'

      with

      -----------------------------------------------------------------------
      -- bfg player summary
      -----------------------------------------------------------------------

      bfg_player_summary as (

        select
          bfgudid as bfg_uid
          , max( campaign ) as campaign
          , max( timestamp(install_date) ) as install_date
          , max( ad_name ) as creative_name
          , max( ad_id ) as creative_id
          , max( marketing_channel ) as marketing_channel
          , max( marketing_channel_category ) as marketing_channel_category
          , max( media_source ) as media_source
          , max( cpi  ) as cpi

        from
          eraser-blast.bfg_import.attribution_data
        where
          length(campaign) > 2
          and length(bfgudid) > 2
        group by
          1

      )

      -----------------------------------------------------------------------
      -- add mapping
      -----------------------------------------------------------------------

      select
      *
      , @{new_singular_creative_name} as creative_name_mapped

      from
      bfg_player_summary



      ;;
    ## the hardcoded meta data table is scheduled for 1AM UTC
    ## So this will run at 2AM UTC
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (3) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["install_date"]
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql: ${TABLE}.bfg_uid;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Date Groups
####################################################################

  dimension_group: date {
    label: "Install"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.install_date ;;
  }

####################################################################
## Other Dimensions
####################################################################

dimension: bfg_uid {type:string}
dimension: campaign {type:string}
dimension: creative_name {type:string}
dimension: creative_id {type:string}
dimension: marketing_channel {type:string}
dimension: marketing_channel_category {type:string}
dimension: media_source {type:string}
dimension: cpi {type:number}
dimension: creative_name_mapped{type:string}


####################################################################
## Measures
####################################################################

  measure: count_distinct_players {
    label: "Count Distinct Users"
    type: number
    value_format_name: decimal_0
    sql: count( distinct ${TABLE}.bfg_uid ) ;;
  }

}
