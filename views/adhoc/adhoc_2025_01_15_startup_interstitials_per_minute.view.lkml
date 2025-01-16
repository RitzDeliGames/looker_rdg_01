view: adhoc_2025_01_15_startup_interstitials_per_minute {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      with

      my_player_list as (

      select
        rdg_id
        , sum(count_ad_views ) AS count_startup_interstitials_viewed
      from
        eraser-blast.looker_scratch.6Y_ritz_deli_games_player_ad_view_summary
      where
        date(rdg_date) between '2024-09-01' and '2024-12-30'
        and ad_placement = 'Startup Interstitial'
      group by
        1

      )

      , all_player_time_played_after_day_3 as (

        select
          a.rdg_id
          , sum(a.round_length_minutes) as round_length_minutes_after_day_3
          , sum(1) as count_rounds_after_day_3
        from
          eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary a
        where
          a.day_number >= 3
          and date(a.rdg_date) between '2024-09-01' and '2024-12-30'
          and date(a.created_at) >= '2024-09-01'
        group by
          1
      )

      , my_combined_data as (

        select
          a.*
          , b.* except ( rdg_id )
        from
          all_player_time_played_after_day_3 a
          inner join my_player_list b
            on a.rdg_id = b.rdg_id

      )


      select
        *
        , safe_divide( count_startup_interstitials_viewed , round_length_minutes_after_day_3 ) as interstitial_per_minute_played_after_day_3
        , safe_divide( count_rounds_after_day_3 , round_length_minutes_after_day_3 ) as interstitial_per_round_played_after_day_3
      from
        my_combined_data



      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: rdg_id {type: string}
  dimension: count_startup_interstitials_viewed {type: number}
  dimension: round_length_minutes_after_day_3 {type: number}
  dimension: count_rounds_after_day_3 {type: number}

################################################################
## Measures
################################################################

  measure: interstitial_per_minute_played_after_day_3_10 {
    group_label: "Interstitials Per Minute"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.interstitial_per_minute_played_after_day_3 ;;
    value_format_name: decimal_3
  }
  measure: interstitial_per_minute_played_after_day_3_25 {
    group_label: "Interstitials Per Minute"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.interstitial_per_minute_played_after_day_3 ;;
    value_format_name: decimal_3
  }
  measure: interstitial_per_minute_played_after_day_3_50 {
    group_label: "Interstitials Per Minute"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.interstitial_per_minute_played_after_day_3 ;;
    value_format_name: decimal_3
  }
  measure: interstitial_per_minute_played_after_day_3_75 {
    group_label: "Interstitials Per Minute"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.interstitial_per_minute_played_after_day_3 ;;
    value_format_name: decimal_3
  }
  measure: interstitial_per_minute_played_after_day_3_95 {
    group_label: "Interstitials Per Minute"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.interstitial_per_minute_played_after_day_3 ;;
    value_format_name: decimal_3
  }




}
