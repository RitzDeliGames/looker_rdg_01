view: stats_by_creative_name {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-10-28'

      with

      ----------------------------------------------------------------
      -- Creative Go Game Data
      ----------------------------------------------------------------

      creative_data as (

        select
          singular_simple_ad_name as ad_name_simple
          , safe_cast(round( sum( singular_total_impressions ), 0) as int64) as partner_impressions
          , safe_cast(round( sum( singular_total_installs ), 0) as int64) as partner_installs
          , min( rdg_date ) as min_rdg_date
          , round(1000 *
              safe_divide(
                sum( singular_total_installs )
                , sum( singular_total_impressions )
              ), 2 ) as IPM
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_singular_creative_summary
          ${singular_creative_summary.SQL_TABLE_NAME}
        where
          singular_total_impressions > 0
          and singular_simple_ad_name <> 'Unmapped'
          -- and singular_campaign_name_clean = '20240830 - Android - Meta - USA - 60 Min'
          and rdg_date > '2024-05-01'
          and lower(singular_campaign_name_clean) like '%min%'
        group by
          1

      )

      ----------------------------------------------------------------
      -- Mapped Player Data
      ----------------------------------------------------------------

      , mapped_player_data as (

        select
          ad_name_simple
          , count( distinct rdg_id ) as count_mapped_players
          , round( safe_divide(
              count( distinct
                case
                  when cumulative_time_played_minutes >= 5
                  then rdg_id
                  else null
                  end )
              ,
              count( distinct rdg_id )
            ),3) as engagement_5_minutes
          , round( safe_divide(
              count( distinct
                case
                  when cumulative_time_played_minutes >= 15
                  then rdg_id
                  else null
                  end )
              ,
              count( distinct rdg_id )
            ),3) as engagement_15_minutes
          , round( safe_divide(
              count( distinct
                case
                  when cumulative_time_played_minutes >= 30
                  then rdg_id
                  else null
                  end )
              ,
              count( distinct rdg_id )
            ),3) as engagement_30_minutes
        , round( safe_divide(
              count( distinct
                case
                  when cumulative_time_played_minutes >= 60
                  then rdg_id
                  else null
                  end )
              ,
              count( distinct rdg_id )
            ),3) as engagement_60_minutes
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_summary_new
          ${player_summary_new.SQL_TABLE_NAME}
        where
          1=1
          -- and campaign_name = '20240830 - Android - Meta - USA - 60 Min'
          and date(created_date) >= '2024-05-01'
          and lower(campaign_name) like '%min%'
        group by
          1

      )

      ----------------------------------------------------------------
      -- Combined
      ----------------------------------------------------------------

      select
        a.*
        , b.* except( ad_name_simple )
      from
        creative_data a
        inner join mapped_player_data b
          on a.ad_name_simple = b.ad_name_simple
      where
        partner_installs > 200


      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["min_rdg_date"]

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql: ${TABLE}.ad_name_simple ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: ad_name_simple { type:string }
  dimension: partner_impressions { type:number }
  dimension: partner_installs { type:number }
  dimension: min_rdg_date { type:date }
  dimension: IPM { type:number }
  dimension: count_mapped_players { type:number }
  dimension: engagement_5_minutes { type:number }
  dimension: engagement_15_minutes { type:number }
  dimension: engagement_30_minutes { type:number }
  dimension: engagement_60_minutes { type:number }

}
