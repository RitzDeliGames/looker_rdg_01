view: adhoc_20240202_churn_by_recent_wins_losses {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


      with

      -------------------------------------------------------------------------------
      -- Player Level Campaign Data
      -------------------------------------------------------------------------------

      base_data as (

        select
          a.rdg_id
          , a.level_serial
          , a.round_start_timestamp_utc
          , a.count_wins
          , a.count_rounds
          , a.count_losses
          , a.churn_indicator
        from
          eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary a
          left join eraser-blast.looker_scratch.6Y_ritz_deli_games_player_summary_new b
            on a.rdg_id = b.rdg_id
        where
          a.game_mode = 'campaign'
          -- and b.display_name = 'Amborz'
          and a.level_serial > 0

          -- Date Filters
          and date(a.rdg_date) >= date({% parameter start_date %})
          and date(a.rdg_date) <= date({% parameter end_date %})

          -- Level Filter (start)
          {% if start_level_serial._is_filtered %}
          and a.level_serial >= {% parameter start_level_serial %}
          {% endif %}

          -- Level Filter (end)
          {% if end_level_serial._is_filtered %}
          and a.level_serial <= {% parameter end_level_serial %}
          {% endif %}

      )

      -------------------------------------------------------------------------------
      -- Count Stats in Last 100 Rounds
      -------------------------------------------------------------------------------

      , base_data_with_totals as (

      select
        *
        , sum( count_wins ) over ( partition by rdg_id order by round_start_timestamp_utc ASC rows between {% parameter selected_rounds_to_look_back %} preceding and 0 following ) as count_wins_20
        , sum( count_rounds ) over ( partition by rdg_id order by round_start_timestamp_utc ASC rows between {% parameter selected_rounds_to_look_back %} preceding and 0 following ) as count_rounds_20
        , sum( count_losses ) over ( partition by rdg_id order by round_start_timestamp_utc ASC rows between {% parameter selected_rounds_to_look_back %} preceding and 0 following ) as count_losses_20
      from
        base_data
      )

      -------------------------------------------------------------------------------
      -- Summarize Churn by Player
      -------------------------------------------------------------------------------

      , churn_by_player as (

      select
        rdg_id
        , max( case
          when {% parameter select_metric %} = 'recent_wins' then count_wins_20
          when {% parameter select_metric %} = 'recent_losses' then count_losses_20
          else 0 end ) as metric
        , max(1) as count_players
        , max(churn_indicator) as count_churned_players
      from
        base_data_with_totals
      group by
        1

      )

      -------------------------------------------------------------------------------
      -- Churn By Metric
      -------------------------------------------------------------------------------

      select
        metric
        , sum( count_players ) as count_players
        , sum( count_churned_players ) as count_churned_players
      from
        churn_by_player
      group by
        1


      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: level_bucket_order_key {
    type: number
    sql:
    ${TABLE}.level_bucket_order
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

  parameter: start_level_serial {
    type: number
  }

  parameter: end_level_serial {
    type: number
  }

  parameter: dynamic_level_bucket_size {
    type: number
  }

  parameter: selected_country {
    type: string
    suggestions:  [
      "US"
    ]
  }

  parameter: select_metric {
    type: string
    suggestions:  [
      "recent_wins"
      , "recent_losses"

    ]
  }

  parameter: selected_rounds_to_look_back {
    type: number
  }

################################################################
## Dimensions
################################################################

  dimension: metric {
    type: number}

################################################################
## Measures
################################################################


  measure: count_instances {
    label: "Count Players"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.count_players);;
  }

  measure: count_churned {
    label: "Count Churned Players"
    type: number
    value_format_name: decimal_0
    sql: sum(count_churned_players);;
  }

  measure: churn_rate {
    label: "Churn Rate"
    type: number
    value_format_name: percent_2
    sql: safe_divide(sum(count_churned_players), sum(${TABLE}.count_players)) ;;
  }






}
