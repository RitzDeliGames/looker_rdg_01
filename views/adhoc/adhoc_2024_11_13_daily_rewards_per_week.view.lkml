view: adhoc_2024_11_13_daily_rewards_per_week {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      select
        timestamp_trunc(rdg_date, week(monday)) as week_start_date
        , rdg_id
        , min(rdg_date) as first_played_date_in_week
        , min( safe_cast(json_extract_scalar(experiments,'$.dailyRewardsBig_20240923') as string)  ) as variant
        , min(day_number) as starting_day_number
        , sum(feature_participation_daily_reward) as feature_participation_daily_reward
      from
        eraser-blast.looker_scratch.6Y_ritz_deli_games_player_daily_summary
      where
        safe_cast(json_extract_scalar(experiments,'$.dailyRewardsBig_20240923') as string) is not null
      group by
        1,2

      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
    partition_keys: ["week_start_date"]
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.week_start_date
    || ${TABLE}.rdg_id
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension_group: activity_date {
    label: "Activity"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.week_start_date ;;
  }

  dimension: rdg_id {type: string}
  dimension: feature_participation_daily_reward {type:number}
  dimension: check_for_started_week_on_day_one {
    type: yesno
    sql: first_played_date_in_week = week_start_date  ;;
  }
  dimension: variant {type:string}


################################################################
## Measures
################################################################

  measure: count_distinct_rdg_id {
    label: "Count Distinct Players"
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }





}
