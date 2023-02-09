view: churn_by_level_derived {
  derived_table: {
    sql:
      select
        a.*
        ,b.player_count_total
        ,b.round_length
      from
        (with unpivoted_churn_by_level as
          (select
            cast(churn_by_level_by_attempt.version as int64) version_no
            ,cast(churn_by_level_by_attempt.install_version as int64) install_version_no
            ,cast(churn_by_level_by_attempt.config_timestamp  as string) config_timestamp_string
            ,cast(churn_by_level_by_attempt.install_config as string) install_config
            ,churn_by_level_by_attempt.last_level_serial last_level_completed
            ,churn_by_level_by_attempt.last_level_id last_level_id
            ,if(churn_by_level_by_attempt.round_id < churn_by_level_by_attempt.greater_round_id,'played_again','stuck') churn
            ,count(distinct churn_by_level_by_attempt.rdg_id) player_count
          from `eraser-blast.looker_scratch.6Y_ritz_deli_games_churn_by_level_by_attempt` as churn_by_level_by_attempt
            left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_fact` as user_fact on churn_by_level_by_attempt.rdg_id = user_fact.rdg_id
            left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_last_event` as user_last_event on churn_by_level_by_attempt.rdg_id = user_last_event.rdg_id
          where {% condition variant_filter %} json_extract_scalar(user_last_event.experiments,{% parameter experiment %}) {% endcondition %}
            and {% condition install_version_filter %} cast(churn_by_level_by_attempt.install_version as int64) {% endcondition %}
            and {% condition version_filter %} cast(churn_by_level_by_attempt.version as int64) {% endcondition %}
            and {% condition config_timestamp_filter %} churn_by_level_by_attempt.config_timestamp {% endcondition %}
            and {% condition install_config_filter %} churn_by_level_by_attempt.install_config {% endcondition %}
          group by 1,2,3,4,5,6,7
          order by 1,2,3,4 desc)

        select * from unpivoted_churn_by_level
        pivot (
          sum(player_count) player_count
          for churn
          in ('stuck','played_again')
        )
      order by 1 asc) a
      left join
        (select
          cast(churn_by_level_by_attempt.version as int64) version_no
          ,cast(churn_by_level_by_attempt.install_version as int64) install_version_no
          ,cast(churn_by_level_by_attempt.config_timestamp  as string) config_timestamp_string
          ,cast(churn_by_level_by_attempt.install_config as string) install_config
          ,churn_by_level_by_attempt.last_level_serial last_level_completed
          ,churn_by_level_by_attempt.last_level_id last_level_id
          ,approx_quantiles(churn_by_level_by_attempt.round_length, 100) [offset(50)] round_length
          ,count(distinct churn_by_level_by_attempt.rdg_id) player_count_total
        from `eraser-blast.looker_scratch.6Y_ritz_deli_games_churn_by_level_by_attempt` as churn_by_level_by_attempt
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_fact` as user_fact on churn_by_level_by_attempt.rdg_id = user_fact.rdg_id
          left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_last_event` as user_last_event on churn_by_level_by_attempt.rdg_id = user_last_event.rdg_id
        where {% condition variant_filter %} json_extract_scalar(user_last_event.experiments,{% parameter experiment %}) {% endcondition %}
          and {% condition install_version_filter %} cast(churn_by_level_by_attempt.install_version as int64) {% endcondition %}
          and {% condition version_filter %} cast(churn_by_level_by_attempt.version as int64) {% endcondition %}
          and {% condition config_timestamp_filter %} churn_by_level_by_attempt.config_timestamp {% endcondition %}
          and {% condition install_config_filter %} churn_by_level_by_attempt.install_config {% endcondition %}
        group by 1,2,3,4,5,6
        order by 1,2,3) b
      on a.last_level_completed = b.last_level_completed
        and a.last_level_id = b.last_level_id
        and a.install_version_no = b.install_version_no
        and a.version_no = b.version_no
        and a.config_timestamp_string = b.config_timestamp_string
        and a.install_config = b.install_config
      order by a.last_level_completed asc
      ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
  }
  dimension: primary_key {
    type: string
    sql: ${last_level_completed} || ${last_level_id} || ${install_version_no} || ${version_no} || ${install_config_version_string} || ${config_timestamp_string};;
    primary_key: yes
    hidden: yes
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
      ,"$.boardColor_01122023"
      ,"$.collection_01192023"
      ,"$.difficultyStars_09202022"
      ,"$.dynamicRewards_20221018"
      ,"$.extraMovesCurrency_20221017"
      ,"$.flourFrenzy_20221215"
      ,"$.fueDismiss_20221010"
      ,"$.fue00_v3_01182023"
      ,"$.gridGravity_20221003"
      ,"$.gridGravity2_20221012"
      ,"$.livesTimer_01092023"
      ,"$.MMads_01052023"
      ,"$.mMStreaks_09302022"
      ,"$.mMStreaksv2_20221031"
      ,"$.newLevelPass_20220926"
      ,"$.pizzaTime_01192023"
      ,"$.seedTest_20221028"
      ,"$.storeUnlock_20221102"
      ,"$.treasureTrove_20221114"
      ,"$.u2aFUE20221115"
      ,"$.u2ap2_FUE20221209"
      ,"$.vfxReduce_20221017"
      ,"$.vfxReduce_2_20221024"
      ,"$.zoneOrder2_09302022"
      ,"$.zoneStarCosts_09222022"]
    }
  filter: variant_filter {
    type: string
    suggestions: ["control","variant_a","variant_b","variant_c"]
  }
  filter: install_version_filter {
    group_label: "Version Filters"
    label: "Install Version (Filter)"
    type: number
  }
  filter: version_filter {
    group_label: "Version Filters"
    label: "Release Version (Filter)"
    type: number
  }
  filter: config_timestamp_filter {
    group_label: "Version Filters"
    label: "Config Version - String (Filter)"
    type: string
  }
  filter: install_config_filter {
    group_label: "Version Filters"
    label: "Install Config Version - String (Filter)"
    type: string
  }
  dimension: version_no {
    group_label: "Version Dimensions"
    label: "Release Version"
    type: number
    value_format: "0"
    sql: ${TABLE}.version_no ;;
  }
  dimension: install_version_no {
    group_label: "Version Dimensions"
    label: "Install Version"
    type: number
    value_format: "0"
    sql: ${TABLE}.install_version_no ;;
  }
  dimension: config_timestamp_string {
    group_label: "Version Dimensions"
    label: "Config Version - String"
    type: string
    sql: ${TABLE}.config_timestamp_string ;;
  }
  dimension: install_config_version_string {
    group_label: "Version Dimensions"
    label: "Install Config Version - String"
    type: string
    sql: ${TABLE}.install_config ;;
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
    value_format: "#"
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
    label: "Player Count"
    type: sum
    sql: ${player_count_total} ;;
  }
  measure: churn_rate {
    label: "Churn"
    type: number
    value_format: "#.0%"
    sql:  ${player_count_stuck_total} / nullif(${player_count_total_sum},0) ;;
  }
  measure: churn_rate_per_min {
    label: "Churn per Minute"
    type: number
    value_format: "#.0%"
    sql:  (${player_count_stuck_total} / nullif(${player_count_total_sum},0)) / (${round_length_med} / 60) ;;
  }
  set: detail {
    fields: [last_level_completed, player_count_stuck, player_count_played_again, player_count_total]
  }
}