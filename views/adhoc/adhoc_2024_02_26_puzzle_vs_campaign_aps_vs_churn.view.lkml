view: adhoc_2024_02_26_puzzle_vs_campaign_aps_vs_churn {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    select
      a.level_serial
      , 'campaign' as game_mode
      , 'Any' as level_id
      , sum(a.count_rounds) as count_rounds
      , sum(a.count_wins) as count_wins
      , count(distinct a.rdg_id) as count_distinct_players
      , count(distinct a.churn_rdg_id) as count_distinct_churned_players
      , count( distinct
          case
            when
              a.count_wins = 0
              and a.churn_indicator = 1
            then a.churn_rdg_id
            else null
            end ) as count_distinct_churned_players_on_loss
      , count( distinct
          case
            when
              a.count_wins = 1
              and a.churn_indicator = 1
            then a.churn_rdg_id
            else null
            end ) as count_distinct_churned_players_on_win
      , safe_divide(
          sum( a.count_rounds )
          , sum( a.count_wins )
          ) as attempts_per_success
      , safe_divide(
          count(distinct a.churn_rdg_id )
          , count(distinct a.rdg_id )
          ) as churn_rate
    from
      ${player_round_summary.SQL_TABLE_NAME} a
    where
      -- Date Filters
      date(rdg_date) >= date({% parameter start_date %})
      and date(rdg_date) <= date({% parameter end_date %})

      and a.game_mode = 'campaign'
      and a.level_serial >= 1

      -- Level Filter (start)
      {% if start_level_serial._is_filtered %}
      and a.level_serial >= {% parameter start_level_serial %}
      {% endif %}

      -- Level Filter (end)
      {% if end_level_serial._is_filtered %}
      and a.level_serial <= {% parameter end_level_serial %}
      {% endif %}

      group by
      1

  union all

  select
      0 as level_serial
      , 'puzzle' as game_mode
      , level_id
      , sum(a.count_rounds) as count_rounds
      , sum(a.count_wins) as count_wins
      , count(distinct a.rdg_id) as count_distinct_players
      , count(distinct a.churn_rdg_id) as count_distinct_churned_players
      , count( distinct
          case
            when
              a.count_wins = 0
              and a.churn_indicator = 1
            then a.churn_rdg_id
            else null
            end ) as count_distinct_churned_players_on_loss
      , count( distinct
          case
            when
              a.count_wins = 1
              and a.churn_indicator = 1
            then a.churn_rdg_id
            else null
            end ) as count_distinct_churned_players_on_win
      , safe_divide(
          sum( a.count_rounds )
          , sum( a.count_wins )
          ) as attempts_per_success
      , safe_divide(
          count(distinct a.churn_rdg_id )
          , count(distinct a.rdg_id )
          ) as churn_rate
    from
      ${player_puzzle_level_summary.SQL_TABLE_NAME} a
      -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_puzzle_level_summary a
    where
      -- Date Filters
      date(first_played_rdg_date) >= date({% parameter start_date %})
      and date(first_played_rdg_date) <= date({% parameter end_date %})

      -- date(first_played_rdg_date) >= '2024-02-01'
      -- and date(first_played_rdg_date) <= '2024-02-01'

    group by
      3



      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: level_serial_key {
    type: number
    sql:
    ${TABLE}.level_serial
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

  parameter: start_date {
    type: date
    default_value: "2024-01-01"
  }

  parameter: end_date {
    type: date
    default_value: "2024-01-01"
  }

  parameter: dynamic_level_bucket_size {
    group_label: "Level Buckets"
    type: number
  }

  parameter: start_level_serial {
    type: number
  }

  parameter: end_level_serial {
    type: number
  }

  parameter: churn_rate_type {
    type: string
    default_value: "churn_rate"
    suggestions:  [
      "churn_rate"
      , "excess_churn_rate"
    ]
  }

################################################################
## Dimensions
################################################################

  dimension: level_serial {type: number}

  dimension: attempts_per_success {
    type: number
    sql: round(${TABLE}.attempts_per_success,1) ;;
  }

  dimension: dynamic_level_bucket {
    group_label: "Level Buckets"
    label: "Dynamic Level Bucket"
    type:string
    sql:
    case
      when game_mode = 'puzzle'
      then 'Puzzle'
      else
        'Campaign: ' || safe_cast(
          floor( safe_divide(${TABLE}.level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
          as string
          )
        || ' to '
        ||
        safe_cast(
          ceiling(safe_divide(${TABLE}.level_serial+1,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}-1
          as string
          )
      end
    ;;
  }

  # dimension: dynamic_level_bucket {
  #   group_label: "Level Buckets"
  #   label: "Dynamic Level Bucket"
  #   type:string
  #   sql:
  #   safe_cast(
  #     floor( safe_divide(${TABLE}.level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
  #     as string
  #     )
  #   || ' to '
  #   ||
  #   safe_cast(
  #     ceiling(safe_divide(${TABLE}.level_serial+1,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}-1
  #     as string
  #     )
  #   ;;
  # }

  dimension: level_id {type: string}
  dimension: game_mode {type:string}

################################################################
## Measures
################################################################

  measure: churn_rate {
    type: number
    sql:
        safe_divide(
          case
            when {% parameter churn_rate_type %} = 'churn_rate'
            then sum(${TABLE}.count_distinct_churned_players)
            when {% parameter churn_rate_type %} = 'excess_churn_rate'
            then sum(${TABLE}.count_distinct_churned_players_on_loss) - sum(${TABLE}.count_distinct_churned_players_on_win)
            else sum(0)
            end
          , sum(${TABLE}.count_distinct_players)
          )

      ;;
    value_format_name: percent_3
  }

  measure: count_distinct_players {
    type: number
    sql: sum(${TABLE}.count_distinct_players) ;;
  }

  measure: churn_rate_by_level {
    type: number
    sql:
        safe_divide(
          case
            when {% parameter churn_rate_type %} = 'churn_rate'
            then sum(${TABLE}.count_distinct_churned_players)
            when {% parameter churn_rate_type %} = 'excess_churn_rate'
            then sum(${TABLE}.count_distinct_churned_players_on_loss) - sum(${TABLE}.count_distinct_churned_players_on_win)
            else sum(0)
            end
          , sum(${TABLE}.count_distinct_players)
          )

      ;;
    html:
    <ul>
    <li> churn_rate: {{ rendered_value }} </li>
    <li> level_serial: {{ level_serial }} </li>
    <li> count_distinct_players: {{ count_distinct_players }} </li>
    </ul> ;;
    value_format_name: percent_3
  }






}
