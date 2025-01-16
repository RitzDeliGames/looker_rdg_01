view: adhoc_2025_01_16_puzzle_iam_rounds_played {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      with

      ------------------------------------------------
      -- puzzle round data
      ------------------------------------------------

      puzzle_round_data as (

        select
          rdg_id
          , rdg_date
          , sum( count_rounds ) as count_rounds_puzzle
        from
          eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary
        where
          1=1
          -- and date(rdg_date) between '2025-01-01' and '2025-01-02'
          and date(rdg_date) between '2024-12-01' and '2025-01-15'
          and game_mode = 'puzzle'
        group by
          1,2

      )

      ------------------------------------------------
      -- puzzle iam data
      ------------------------------------------------

      , puzzle_iam_data as (

        select
          rdg_id
          , rdg_date
          , max(1) as count_puzzle_iam
          , max( iam_conversion ) as count_puzzle_conversion
        from
          eraser-blast.looker_scratch.6Y_ritz_deli_games_player_popup_and_iam_summary
        where
          1=1
          -- and date(rdg_date) between '2025-01-01' and '2025-01-02'
          and date(rdg_date) between '2024-12-01' and '2025-01-15'
          and iam_group = 'Puzzle'
        group by
          1,2
      )

      ------------------------------------------------
      -- combine
      ------------------------------------------------

      select
        a.*
        , ifnull( b.count_puzzle_iam , 0 ) as count_puzzle_iam
        , ifnull( b.count_puzzle_conversion , 0 ) as count_puzzle_conversion
        , case
            when b.count_puzzle_conversion = 1 then 'Puzzle IAM Conversion'
            when b.count_puzzle_iam = 1 then 'Puzzle IAM View Only'
            when b.count_puzzle_iam is null then 'No Puzzle IAM'
            else 'Other'
            end as puzzle_iam_category
        , case
            when b.count_puzzle_conversion = 1 then 3
            when b.count_puzzle_iam = 1 then 2
            when b.count_puzzle_iam is null then 1
            else 4
            end as puzzle_iam_category_order
      from
        puzzle_round_data a
        left join puzzle_iam_data b
          on a.rdg_id = b.rdg_id
          and a.rdg_date = b.rdg_date




      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
    partition_keys: ["rdg_date"]
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
  dimension_group: rdg_date {
    group_label: "Activity Dates"
    label: "Activity"
    type: time
    timeframes: [date, week, month, year, day_of_week, day_of_week_index]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: count_puzzle_iam {type: number}
  dimension: count_puzzle_conversion {type: number}
  dimension: count_rounds_puzzle {type: number}
  dimension: puzzle_iam_category {type: string}
  dimension: puzzle_iam_category_order {type: number}

################################################################
## Measures
################################################################

  measure: count_rounds_puzzle_10 {
    group_label: "Count Rounds In Puzzle"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.count_rounds_puzzle ;;
    value_format_name: decimal_0
  }
  measure: count_rounds_puzzle_25 {
    group_label: "Count Rounds In Puzzle"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.count_rounds_puzzle ;;
    value_format_name: decimal_0
  }
  measure: count_rounds_puzzle_50 {
    group_label: "Count Rounds In Puzzle"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.count_rounds_puzzle ;;
    value_format_name: decimal_0
  }
  measure: count_rounds_puzzle_75 {
    group_label: "Count Rounds In Puzzle"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.count_rounds_puzzle ;;
    value_format_name: decimal_0
  }
  measure: count_rounds_puzzle_95 {
    group_label: "Count Rounds In Puzzle"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.count_rounds_puzzle ;;
    value_format_name: decimal_0
  }




}
