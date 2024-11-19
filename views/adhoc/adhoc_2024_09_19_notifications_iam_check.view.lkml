view: adhoc_2024_09_19_notifications_iam_check {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


      -- ccb_aggregate_update_tag
      -- update '2024-09-19'

      with

      -----------------------------------------------------------------------------------------
      -- list of recently installed players
      -----------------------------------------------------------------------------------------

      player_list as (

        select
          rdg_id
          , min(created_at) as created_date
          , min(install_version) as install_version
        from
          eraser-blast.game_data.events
        where
          date(timestamp) between '2024-07-01' and '2024-09-17'
          and date(created_at) between '2024-07-01' and '2024-09-17'
        group by
          1
      )

      -----------------------------------------------------------------------------------------
      -- list of players to get notification iam
      -----------------------------------------------------------------------------------------

      , list_of_players_to_get_notifications_iam as (

        select
          rdg_id
          , min(timestamp_utc) as first_seen_notifications_iam
          , min(cumulative_time_played_minutes) as cumulative_time_played_minutes
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_popup_and_iam_summary
          ${player_popup_and_iam_summary.SQL_TABLE_NAME}
        where
          date(rdg_date) between '2024-07-01' and '2024-09-17'
          and button_tag in (
            'Sheet_InAppMessaging_Notifications.IAM'
            ,'Sheet_InAppMessaging_Notifications.Close'
            ,'Sheet_InAppMessaging_Notifications.'
          )
        group by
          1
      )

      -----------------------------------------------------------------------------------------
      -- join tables
      -----------------------------------------------------------------------------------------

      select
        a.rdg_id
        , a.created_date
        , a.install_version
        , b.first_seen_notifications_iam
        , timestamp_diff(b.first_seen_notifications_iam, a.created_date, minute) as time_from_creation
        , b.cumulative_time_played_minutes
      from
        player_list a
        left join list_of_players_to_get_notifications_iam b
          on a.rdg_id = b.rdg_id

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

  dimension_group: created_date {
    label: "Install"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  dimension: install_version_number {type: number sql: safe_cast(${TABLE}.install_version as numeric);;}
  dimension: rdg_id {type: string}
  dimension: viewed_notifications_iam_indicator {
    label: "Viewed Notifications IAM"
    type: string
    sql:
      case
        when ${TABLE}.cumulative_time_played_minutes is null
        then 'Did Not Get Notifications IAM'
        else 'Got Notifications IAM'
        end

        ;;
  }

  dimension: viewed_notifications_iam_bucket {
    label: "Notifications IAM Bucket"
    type: string
    sql:
      case
        when ${TABLE}.cumulative_time_played_minutes is null then 'Did Not Get Notifications IAM'
        when ${TABLE}.cumulative_time_played_minutes <= 15 then '<15 Minutes'
        when ${TABLE}.cumulative_time_played_minutes <= 25 then '15-25 Minutes'
        when ${TABLE}.cumulative_time_played_minutes <= 35 then '25-35 Minutes'
        else '35+ Minutes'
        end

      ;;
  }

  dimension: viewed_notifications_iam_bucket_order {
    label: "Notifications IAM Bucket Order"
    type: string
    sql:
      case
        when ${TABLE}.cumulative_time_played_minutes is null then 1
        when ${TABLE}.cumulative_time_played_minutes <= 15 then 2
        when ${TABLE}.cumulative_time_played_minutes <= 25 then 3
        when ${TABLE}.cumulative_time_played_minutes <= 35 then 4
        else 5
        end

      ;;
  }


################################################################
## Measures
################################################################

  measure: count_distinct_rdg_id {
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }

  measure: time_diff_in_milliseconds_10 {
    group_label: "Cumulative Minutes Played at Notifications IAM"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: time_diff_in_milliseconds_25 {
    group_label: "Cumulative Minutes Played at Notifications IAM"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: time_diff_in_milliseconds_50 {
    group_label: "Cumulative Minutes Played at Notifications IAM"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }
  measure: time_diff_in_milliseconds_75 {
    group_label: "Cumulative Minutes Played at Notifications IAM"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }

  measure: time_diff_in_milliseconds_80 {
    group_label: "Cumulative Minutes Played at Notifications IAM"
    label: "80th Percentile"
    type: percentile
    percentile: 80
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }

  measure: time_diff_in_milliseconds_85 {
    group_label: "Cumulative Minutes Played at Notifications IAM"
    label: "85th Percentile"
    type: percentile
    percentile: 85
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }

  measure: time_diff_in_milliseconds_90 {
    group_label: "Cumulative Minutes Played at Notifications IAM"
    label: "90th Percentile"
    type: percentile
    percentile: 90
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }

  measure: time_diff_in_milliseconds_95 {
    group_label: "Cumulative Minutes Played at Notifications IAM"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.cumulative_time_played_minutes ;;
  }


}