view: adhoc_2024_09_18_rate_us_IAM_per_player_per_day {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    select
        timestamp(date(rdg_date)) as rdg_date
        , rdg_id
        , sum( 1 ) as count_instances
      from
        -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_iam_incremental
        ${player_iam_incremental.SQL_TABLE_NAME}
      where
        --date(rdg_date) between '2024-01-01' and '2024-09-17'
        button_tag in (
          'Sheet_InAppMessaging_RateUs.'
          , 'Sheet_InAppMessaging_RateUs.Close'
          , 'Sheet_InAppMessaging_RateUs.IAM'
        )
      group by
        1,2
    ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
  }

####################################################################
## Primary Key
####################################################################

  dimension: my_primary_key {
    type: number
    sql:
    ${TABLE}.rdg_date
    || ${TABLE}.count_instances
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  # dates
  dimension_group: rdg_date {
    group_label: "Activity Dates"
    label: "Activity"
    type: time
    timeframes: [date, week, month, year, day_of_week, day_of_week_index]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: count_instances {type: number}
  dimension: rdg_id {type: string}

################################################################
## Measures
################################################################

  measure: count_players {
    label: "Count Distinct Players"
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }

}
