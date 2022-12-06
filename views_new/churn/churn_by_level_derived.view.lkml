view: churn_by_level_derived {
  derived_table: {
    sql: select a.*, b.player_count_total, b.round_length
      from
        (with unpivoted_churn_by_level as
        (select
          churn_by_level_by_attempt.last_level_serial last_level_completed
          ,churn_by_level_by_attempt.last_level_id last_level_id
          ,if(churn_by_level_by_attempt.round_id < churn_by_level_by_attempt.greater_round_id,'played_again','stuck') churn
          ,count(distinct churn_by_level_by_attempt.rdg_id) player_count
        from `eraser-blast.looker_scratch.6Y_ritz_deli_games_churn_by_level_by_attempt` as churn_by_level_by_attempt
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_fact` as user_fact on churn_by_level_by_attempt.rdg_id = user_fact.rdg_id
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_last_event` as user_last_event on churn_by_level_by_attempt.rdg_id = user_last_event.rdg_id
        where {% condition variant %} json_extract_scalar(user_last_event.experiments,{% parameter experiment %}) {% endcondition %}
          and {% condition install_version %} cast(install_version as int64) {% endcondition %}
          and {% condition config_timestamp %} churn_by_level_by_attempt.config_timestamp {% endcondition %}
        group by 1,2,3
        order by 1,2,3 desc)

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
        ,churn_by_level_by_attempt.last_level_id last_level_id
        ,approx_quantiles(churn_by_level_by_attempt.round_length, 100) [offset(50)] round_length
        ,count(distinct churn_by_level_by_attempt.rdg_id) player_count_total
      from `eraser-blast.looker_scratch.6Y_ritz_deli_games_churn_by_level_by_attempt` as churn_by_level_by_attempt
        left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_fact` as user_fact on churn_by_level_by_attempt.rdg_id = user_fact.rdg_id
        left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_last_event` as user_last_event on churn_by_level_by_attempt.rdg_id = user_last_event.rdg_id
      where {% condition variant %} json_extract_scalar(user_last_event.experiments,{% parameter experiment %}) {% endcondition %}
        and {% condition install_version %} cast(install_version as int64) {% endcondition %}
        and {% condition config_timestamp %} churn_by_level_by_attempt.config_timestamp {% endcondition %}
      group by 1,2
      order by 1,2) b
      on a.last_level_completed = b.last_level_completed
        and a.last_level_id = b.last_level_id
      order by a.last_level_completed asc
      ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    type: string
    sql: ${last_level_completed} || ${last_level_id} ;;
    primary_key: yes
    hidden: yes
  }
  filter: install_version {
    group_label: "Version Dimensions"
    label: "Install Version"
    type: number
  }
  filter: config_timestamp {
    group_label: "Version Dimensions"
    label: "Config Version - String"
    type: string
  }
  parameter: experiment {
    type: string
    suggestions:  ["$.altFUE2_20221011"
      ,"$.altFUE2v2_20221024"
      ,"$.altFUE2v3_20221031"
      ,"$.autoPurchase_20221017"
      ,"$.blockSymbols_20221017"
      ,"$.blockSymbolFrames_20221027"
      ,"$.blockSymbolFrames2_20221109"
      ,"$.difficultyStars_09202022"
      ,"$.dynamicRewards_20221018"
      ,"$.extraMovesCurrency_20221017"
      ,"$.fueDismiss_20221010"
      ,"$.gridGravity_20221003"
      ,"$.gridGravity2_20221012"
      ,"$.mMStreaks_09302022"
      ,"$.mMStreaksv2_20221031"
      ,"$.newLevelPass_20220926"
      ,"$.seedTest_20221028"
      ,"$.storeUnlock_20221102"
      ,"$.treasureTrove_20221114"
      ,"$.vfxReduce_20221017"
      ,"$.vfxReduce_2_20221024"
      ,"$.zoneOrder2_09302022"
      ,"$.zoneStarCosts_09222022"]
  }
  filter: variant {
    type: string
    suggestions: ["control","variant_a","variant_b","variant_c"]
  }
  dimension: last_level_completed {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
    sql: ${TABLE}.last_level_completed ;;
  }
  dimension: last_level_serial_offset {
    group_label: "Level Dimensions"
    label: "Current Level"
    type: number
    sql: ${last_level_completed} + 1 ;;
  }
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
    sql: ${TABLE}.last_level_id ;;
  }
  dimension: round_length {
    type: number
    sql: ${TABLE}.round_length ;;
  }
  dimension: round_length_num {
    type: number
    sql: ${TABLE}.round_length / 1000;;
  }
  measure: round_length_med {
    label: "Round Length - Median"
    type: median
    sql: ${round_length_num} ;;
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
    label: "Churn"
    type: number
    value_format: "#%"
    sql:  ${player_count_stuck_total} / nullif(${player_count_total_sum},0) ;;
  }
  measure: churn_rate_per_min {
    label: "Churn per Minute"
    type: number
    value_format: "#%"
    sql:  (${player_count_stuck_total} / nullif(${player_count_total_sum},0)) / (${round_length_med} / 60) ;;
  }
  set: detail {
    fields: [last_level_completed, player_count_stuck, player_count_played_again, player_count_total]
  }
}
