view: adhoc_2024_10_23_treasure_trove_weekly_comparison {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


      -- ccb_aggregate_update_tag
      -- update '2024-10-23'

      with

      daily_data as (

        select
          a.rdg_id
          , b.treasure_trove_event_start_date
          , min(a.day_number) as min_day_number
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary a
          -- left join eraser-blast.looker_scratch.LR_6YMIA1729705637007_live_ops_calendar b
            -- on date(a.rdg_date) = b.rdg_date
          ${player_daily_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        where
          b.treasure_trove_event_start_date is not null
        group by
          1,2
      )

      , mtx_data as (

        select
          a.rdg_id
          , b.treasure_trove_event_start_date
          , sum( case when a.iap_id_strings_grouped = 'Treasure Trove' then a.mtx_purchase_dollars else 0 end ) as mtx_treasure_trove
          , sum( case when a.iap_id_strings_grouped = 'Halloween: Treasure Trove' then a.mtx_purchase_dollars else 0 end ) as mtx_treasure_trove_halloween
        from
          -- eraser-blast.looker_scratch.LR_6YSDQ1729714591832_player_mtx_purchase_summary a
          -- left join eraser-blast.looker_scratch.LR_6YMIA1729705637007_live_ops_calendar b
            -- on date(a.rdg_date) = b.rdg_date
          ${player_mtx_purchase_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        group by
          1,2
      )

      , ads_data as (

        select
          a.rdg_id
          , b.treasure_trove_event_start_date
          , sum( case when a.ad_placement_mapping = 'Treasure Trove' then a.ad_view_dollars else 0 end ) as ad_dollars_treasure_trove
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary a
          -- left join eraser-blast.looker_scratch.LR_6YMIA1729705637007_live_ops_calendar b
            -- on date(a.rdg_date) = b.rdg_date
          ${player_ad_view_summary.SQL_TABLE_NAME} a
          left join ${live_ops_calendar.SQL_TABLE_NAME} b
            on date(a.rdg_date) = b.rdg_date
        group by
          1,2
      )

      select
        a.*
        , b.* except( rdg_id, treasure_trove_event_start_date )
        , c.* except( rdg_id, treasure_trove_event_start_date )
      from
        daily_data a
        left join mtx_data b
          on a.rdg_id = b.rdg_id
          and a.treasure_trove_event_start_date = b.treasure_trove_event_start_date
        left join ads_data c
          on a.rdg_id = c.rdg_id
          and a.treasure_trove_event_start_date = c.treasure_trove_event_start_date


      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp())*100 + extract( week from current_timestamp());;
    partition_keys: ["treasure_trove_event_start_date"]
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || ${TABLE}.treasure_trove_event_start_date
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: rdg_id {type: string}

  dimension_group: treasure_trove_event_start_date {
    label: "Treasure Trove Week Start"
    type: time
    timeframes: [date]
    sql: timestamp(${TABLE}.treasure_trove_event_start_date) ;;
  }

  dimension: treasure_trove_event_start_date_string {
    type: string
    sql:
      format_date('%F', ${TABLE}.treasure_trove_event_start_date )
     ;;
    }

################################################################
## Measures
################################################################

  measure: count_distinct_rdg_id {
    label: "Count Distinct Players"
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }

#   mtx_treasure_trove
# mtx_treasure_trove_halloween
# ad_dollars_treasure_trove

  measure:  mtx_treasure_trove_per_player {
    label: "IAP: Treasure Trove"
    type: number
    value_format_name: usd
    sql:
      safe_divide(
        sum(${TABLE}.mtx_treasure_trove)
        , count(distinct ${TABLE}.rdg_id)
      )
    ;;
  }

  measure:  mtx_treasure_trove_halloween_per_player {
    label: "IAP: Halloween Treasure Trove"
    type: number
    value_format_name: usd
    sql:
      safe_divide(
        sum(${TABLE}.mtx_treasure_trove_halloween)
        , count(distinct ${TABLE}.rdg_id)
      )
    ;;
  }

  measure:  ad_dollars_treasure_trove_per_player {
    label: "IAA: Treasure Trove"
    type: number
    value_format_name: usd
    sql:
      safe_divide(
        sum(${TABLE}.ad_dollars_treasure_trove)
        , count(distinct ${TABLE}.rdg_id)
      )
    ;;
  }


}
