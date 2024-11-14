view: singular_player_attribution {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-10-25'

      with

      -----------------------------------------------------------------------
      -- firebase player summary
      -----------------------------------------------------------------------

      firebase_player_summary as (

        select
          firebase_user_id
          , max(firebase_advertising_id) as firebase_advertising_id
        from
          -- `eraser-blast.looker_scratch.6Y_ritz_deli_games_firebase_player_summary`
          ${firebase_player_summary.SQL_TABLE_NAME}
        group by
          1

      )

      -----------------------------------------------------------------------
      -- singular_player_summary pre aggregate
      -----------------------------------------------------------------------

      , singular_player_summary_pre_aggregate as (

        select
          device_id
          , creative_id
          , creative_name
          , country
          , first_value(date(event_timestamp)) over (
              partition by  device_id
              order by event_timestamp ASC
              rows between unbounded preceding and unbounded following
            ) first_date
          , first_value(campaign_id) over (
              partition by  device_id
              order by event_timestamp ASC
              rows between unbounded preceding and unbounded following
            ) campaign_id
          , first_value(campaign_name) over (
              partition by  device_id
              order by event_timestamp ASC
              rows between unbounded preceding and unbounded following
            ) campaign_name
          , first_value(singular_partner_name) over (
              partition by  device_id
              order by event_timestamp ASC
              rows between unbounded preceding and unbounded following
              ) partner_name

        from
          `eraser-blast.singular.user_level_attributions`
        where
          is_reengagement is null
          or is_reengagement = false

      )

      -----------------------------------------------------------------------
      -- singular_player_summary
      -----------------------------------------------------------------------

      , singular_player_summary as (

        select
          device_id
          , max(campaign_name) as campaign_name
          , max(campaign_id) as campaign_id
          , max(partner_name) as partner_name
          , max(creative_id) as creative_id
          , max(creative_name) as creative_name
          , max(country) country
          , max(first_date) as first_date
        from
          singular_player_summary_pre_aggregate
        group by
          1
      )

      -----------------------------------------------------------------------
      -- firebase player level summary
      -----------------------------------------------------------------------

      , summary_by_firebase_user_id as (

        select
          a.firebase_user_id as user_id
          , max(b.partner_name) as partner_name
          , max(b.campaign_id) as campaign_id
          , max(b.campaign_name) as campaign_name
          , max(b.creative_id) as creative_id
          , max(b.creative_name) as creative_name
          , max(b.country) country
          , max(b.first_date) as rdg_date
        from
          firebase_player_summary a
          left join singular_player_summary b
            on a.firebase_advertising_id = b.device_id
        group by
          1
      )

      -----------------------------------------------------------------------
      -- map on creative and campaign
      -----------------------------------------------------------------------

      select
        *
        , @{creative_name_mapping} as creative_name_mapped
        , @{campaign_name_mapped} as campaign_name_mapped

      from
        summary_by_firebase_user_id



      ;;
    ## the hardcoded meta data table is scheduled for 1AM UTC
    ## So this will run at 2AM UTC
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -2 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (3) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql: ${TABLE}.user_id;;
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
    sql: ${TABLE}.rdg_date ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: partner_name {type:string}
  dimension: campaign_id {type:string}
  dimension: campaign_name {type:string}
  dimension: creative_id {type:string}
  dimension: creative_name {type:string}
  dimension: country {type:string}
  dimension: creative_name_mapped {type:string}
  dimension: campaign_name_mapped {type:string}
  dimension: user_id {type:string}

####################################################################
## Measures
####################################################################

  measure: count_distinct_players {
    label: "Count Distinct Users"
    type: number
    value_format_name: decimal_0
    sql: count( distinct ${TABLE}.user_id ) ;;
  }

}
