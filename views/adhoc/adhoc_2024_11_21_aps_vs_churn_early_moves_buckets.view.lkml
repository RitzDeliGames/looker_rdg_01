view: adhoc_2024_11_21_aps_vs_churn_early_moves_buckets {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    select
      a.level_serial
      , safe_cast(
          floor( safe_divide(c.moves_made_percentile,25))*25
          as string
          )
        || ' to '
        ||
        safe_cast(
          ceiling(safe_divide(c.moves_made_percentile+1,25))*25-1
          as string
          )
         AS player_bucket_by_first_10_levels_moves_made_percentile_bucket
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
      inner join ${player_summary_new.SQL_TABLE_NAME} b
        on a.rdg_id = b.rdg_id
      inner join ${player_bucket_by_first_10_levels.SQL_TABLE_NAME} c
        on a.rdg_id = c.rdg_id
    where
      -- Country Filter
      -- b.country = 'US'

      -- Date Filters
      date(rdg_date) >= '2024-07-23'
      and date(rdg_date) <= date_add(current_date(), interval -1 DAY)

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
      1,2

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

  dimension: player_bucket_by_first_10_levels_moves_made_percentile_bucket {type: string label: "Early Moves Bucket"}

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
    safe_cast(
      floor( safe_divide(${TABLE}.level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as string
      )
    || ' to '
    ||
    safe_cast(
      ceiling(safe_divide(${TABLE}.level_serial+1,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}-1
      as string
      )
    ;;
  }

  dimension: dynamic_level_bucket_order {
    label: "Dynamic Level Bucket Order"
    type:number
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as int64
      )
    ;;
  }

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

  measure: count_rounds {
    type: number
    sql: sum(${TABLE}.count_rounds) ;;
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
