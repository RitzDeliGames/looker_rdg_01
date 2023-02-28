view: player_ad_view_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- create or replace table tal_scratch.player_ad_view_summary as

      select

        -- All columns from player_ad_view_incremental
        *

        -- Player Age Information
        , timestamp(date(created_at)) as created_date -- Created Date
        , date_diff(date(rdg_date), date(created_at), day) as days_since_created -- Days Since Created
        , 1 + date_diff(date(rdg_date), date(created_at), day) as day_number -- Player Day Number

        -- Cumulative fields
        , sum(ifnull(ad_view_dollars,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_ad_view_dollars

        , sum(ifnull(count_ad_views,0)) over (
            partition by rdg_id
            order by timestamp_utc asc
            rows between unbounded preceding and current row
            ) cumulative_count_ad_views

      from
        `eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_incremental`


      ;;
    datagroup_trigger: dependent_on_player_ad_view_incremental
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

  ####################################################################
  ## Primary Key
  ####################################################################

  dimension: primary_key {
    type: string
    sql:
      ${TABLE}.rdg_id
      || '_' || ${TABLE}.rdg_date
      || '_' || ${TABLE}.timestamp_utc
      ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }
  dimension_group: created_date_timestamp {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  # Strings
  dimension: rdg_id {type:string}
  dimension: version {type:string}
  dimension: session_id {type:string}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: count_ad_views {type:number}
  dimension: source_id {type:string}
  dimension: ad_network {type:string}
  dimension: country {type:string}
  dimension: current_level_id {type:string}

  # Numbers
  dimension: current_level_serial {type:number}
  dimension: ad_view_dollars {type:number}
  dimension: currency_03_balance {type:number}
  dimension: currency_04_balance {type:number}
  dimension: currency_07_balance {type:number}
  dimension: days_since_created {type:number}
  dimension: day_number {type:number}
  dimension: cumulative_ad_view_dollars {type:number}
  dimension: cumulative_count_ad_views {type:number}




}
