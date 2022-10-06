view: churn_by_level_derived {
  derived_table: {
    sql: select a.*, b.player_count_total
      from
        (with unpivoted_churn_by_level as
        (select
          churn_by_level_by_attempt.last_level_serial last_level_completed
          ,if(churn_by_level_by_attempt.round_id < churn_by_level_by_attempt.greater_round_id,'played_again','stuck') churn
          ,count(distinct churn_by_level_by_attempt.rdg_id) player_count
        from `eraser-blast.looker_scratch.6Y_ritz_deli_games_churn_by_level_by_attempt` as churn_by_level_by_attempt
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_fact` as user_fact on churn_by_level_by_attempt.rdg_id = user_fact.rdg_id
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_last_event` as user_last_event on churn_by_level_by_attempt.rdg_id = user_last_event.rdg_id
        where {% condition variant %} json_extract_scalar(user_last_event.experiments,{% parameter experiment %}) {% endcondition %}
          and {% condition install_version %} install_version {% endcondition %}
        group by 1,2
        order by 1,2 desc)

      select * from unpivoted_churn_by_level
      pivot (
        sum(player_count) player_count
        for churn
        in ('stuck','played_again')
      )
      order by 1 asc) a
      left join
      (select
        churn_by_level_by_attempt.last_level_serial last_level_completed
        ,count(distinct churn_by_level_by_attempt.rdg_id) player_count_total
      from `eraser-blast.looker_scratch.6Y_ritz_deli_games_churn_by_level_by_attempt` as churn_by_level_by_attempt
        left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_fact` as user_fact on churn_by_level_by_attempt.rdg_id = user_fact.rdg_id
        left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_last_event` as user_last_event on churn_by_level_by_attempt.rdg_id = user_last_event.rdg_id
      where {% condition variant %} json_extract_scalar(user_last_event.experiments,{% parameter experiment %}) {% endcondition %}
        and {% condition install_version %} install_version {% endcondition %}
      group by 1
      order by 1) b
      on a.last_level_completed = b.last_level_completed
      order by a.last_level_completed asc
      ;;
  }
  # dimension: primary_key {
  #   type: string
  #   sql: ${last_level_completed};;
  #   primary_key: yes
  #   hidden: yes
  # }
  filter: install_version {
    type: string
  }
  filter: variant {
    type: string
  }
  parameter: experiment {
    type: string
  }
  dimension: last_level_completed {
    type: number
    sql: ${TABLE}.last_level_completed ;;
  }
  dimension: player_count_stuck {
    type: number
    sql: ${TABLE}.player_count_stuck ;;
  }
  measure: player_count_stuck_total {
    type: sum
    sql: ${player_count_stuck};;
  }
  dimension: player_count_played_again {
    type: number
    sql: ${TABLE}.player_count_played_again ;;
  }
  dimension: player_count_total {
    type: number
    sql: ${TABLE}.player_count_total ;;
  }
  measure: player_count_total_sum {
    type: sum
    sql: ${player_count_total} ;;
  }
  measure: churn_rate {
    type: number
    value_format: "#%"
    sql:  ${player_count_stuck_total} / ${player_count_total_sum} ;;
  }
  set: detail {
    fields: [last_level_completed, player_count_stuck, player_count_played_again, player_count_total]
  }
}
