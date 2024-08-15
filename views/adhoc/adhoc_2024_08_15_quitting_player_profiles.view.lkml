view: adhoc_2024_08_15_quitting_player_profiles {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      select
        rdg_id
        , safe_cast(
            floor( safe_divide(day_number-1,{% parameter day_number_bucket_size %}))*{% parameter day_number_bucket_size %}+1
            as int64
            ) day_number_bucket_order
        , safe_cast(
            floor( safe_divide(day_number-1,{% parameter day_number_bucket_size %}))*{% parameter day_number_bucket_size %}+1
            as string
            )
          || ' to '
          ||
          safe_cast(
            ceiling(safe_divide(day_number,{% parameter day_number_bucket_size %}))*{% parameter day_number_bucket_size %}
            as string
            ) as day_number_bucket
        , max(churn_indicator) as churn_indicator
        , max(1) as count_players
        , max(highest_last_level_serial) as highest_last_level_serial
        , min(lowest_last_level_serial) as lowest_last_level_serial
        , sum(round_end_events) as round_end_events
        , sum(round_end_events_movesmaster) as round_end_events_movesmaster
        , sum(round_end_events_puzzle) as round_end_events_puzzle
        , sum(round_end_events_gemquest) as round_end_events_gemquest
        , sum(round_end_events_gofish) as round_end_events_gofish
        , max(feature_participation_daily_reward) as feature_participation_daily_reward
        , max(feature_participation_pizza_time) as feature_participation_pizza_time
        , max(feature_participation_flour_frenzy) as feature_participation_flour_frenzy
        , max(feature_participation_lucky_dice) as feature_participation_lucky_dice
        , max(feature_participation_treasure_trove) as feature_participation_treasure_trove
        , max(feature_participation_battle_pass) as feature_participation_battle_pass
        , max(feature_participation_hot_dog_contest) as feature_participation_hot_dog_contest
        , max(feature_participation_food_truck) as feature_participation_food_truck
        , max(feature_participation_castle_climb) as feature_participation_castle_climb
        , max(feature_participation_donut_sprint) as feature_participation_donut_sprint
        , max(feature_participation_any_event) as feature_participation_any_event
        , max(ending_coins_balance) as highest_ending_coins_balance

      from
        ${player_daily_summary.SQL_TABLE_NAME}
      where
        day_number >= {% parameter day_number_low %}
        and day_number <= {% parameter day_number_high %}
        and date(rdg_date) >= date({% parameter start_date %})
        and date(rdg_date) <= date({% parameter end_date %})
      group by
        1,2,3

      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: my_primary_key {
    type: number
    sql:
    ${TABLE}.rdg_id
    || ${TABLE}.day_number_bucket_order
    || ${TABLE}.day_number_bucket
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

  parameter: start_date {
    label: "Start Date"
    type: date
    default_value: "2024-01-01"
  }

  parameter: end_date {
    label: "End Date"
    type: date
    default_value: "2024-01-01"
  }

  parameter: day_number_bucket_size {
    label: "Day Number Bucket Size"
    type: number
  }

  parameter: day_number_low {
    label: "Day Number (Low)"
    type: number
  }

  parameter: day_number_high {
    label: "Day Number (High)"
    type: number
  }

################################################################
## Dimensions
################################################################

  dimension: rdg_id {type:string}

  dimension: churn_group {
    label: "Churn Group"
    type: string
    sql: case when ${TABLE}.churn_indicator = 1 then 'Churned' else 'Not Churned' end  ;;
  }

  dimension: day_number_bucket {
    label: "Day Number Bucket"
    type:string
  }

  dimension: day_number_bucket_order {
    label: "Day Number Bucket Order"
    type: number
  }

################################################################
## Measures
################################################################

  dimension: count_distinct_players {
    label: "Count Distinct Players"
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }

  dimension: campaign_levels_advanced {
    label: "Campaign Levels Advanced"
    type: number
    value_format_name: decimal_0
    sql:
      safe_divide(
        sum( ${TABLE}.highest_last_level_serial - ${TABLE}.lowest_last_level_serial )
        ,
        sum( count_players )
      )
    ;;
  }

  dimension: mean_highest_campaign_level {
    label: "Mean Highest Campaign Level"
    type: number
    value_format_name: decimal_0
    sql:
    safe_divide(
      sum( ${TABLE}.highest_last_level_serial )
      ,
      sum( count_players )
    )
  ;;
  }

  dimension: mean_round_end_events {
    label: "Mean Round End Events"
    type: number
    value_format_name: decimal_0
    sql:
    safe_divide(
      sum( ${TABLE}.round_end_events )
      ,
      sum( count_players )
    )
  ;;
  }




}
