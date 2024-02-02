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
          , sum(a.count_wins) as count_wins
          , sum(a.count_rounds) as count_rounds
          , sum(a.count_losses) as count_losses
          , max(a.churn_indicator) as churn_indicator
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




        group by
          1,2
        order by
          1,2
      )

      -------------------------------------------------------------------------------
      -- Count Stats in Last 100 levels
      -------------------------------------------------------------------------------

      , base_data_with_totals as (

      select
        *
        , sum( count_wins ) over ( partition by rdg_id order by level_serial ASC rows between {% parameter selected_rounds_to_look_back %} preceding and 0 following ) as count_wins_20
        , sum( count_rounds ) over ( partition by rdg_id order by level_serial ASC rows between {% parameter selected_rounds_to_look_back %} preceding and 0 following ) as count_rounds_20
        , sum( count_losses ) over ( partition by rdg_id order by level_serial ASC rows between {% parameter selected_rounds_to_look_back %} preceding and 0 following ) as count_losses_20
      from
        base_data
      )

      -------------------------------------------------------------------------------
      -- Summarize Churn
      -------------------------------------------------------------------------------

      select
        case
          when {% parameter start_date %} = 'recent_wins' then count_wins_20
          when {% parameter start_date %} = 'recent_losses' then count_lossess_20
          else 0 end as metric
        , sum(1) as count_levels
        , sum(churn_indicator) as churn_indicator
      from
        base_data_with_totals
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
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.count_levels);;
  }

  measure: count_churned {
    type: number
    value_format_name: decimal_0
    sql: sum(churn_indicator);;
  }

  measure: churn_rate {
    type: number
    value_format_name: percent_2
    sql: safe_divide(sum(churn_indicator), sum(${TABLE}.count_levels)) ;;
  }






}
