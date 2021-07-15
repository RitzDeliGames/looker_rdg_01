view: system_value_aggregated {
  derived_table: {
    sql: -- use existing system_value in `eraser-blast.looker_scratch.LR_6YPD91626324537280_system_value`
      SELECT
          system_value.rdg_id as system_value_rdg_id,
          system_value.current_card as current_card,
          COALESCE(SUM(( cast(case
                    when system_value.reward_type = 'CURRENCY_02' then '600'
                    when system_value.reward_type = 'CURRENCY_03' then '1'
                    when system_value.reward_type = 'CURRENCY_04' then '600'
                    when system_value.reward_type = 'CURRENCY_05' then '600'
                    when system_value.reward_type = 'boost_001' then '500'
                    when system_value.reward_type = 'boost_002' then '500'
                    when system_value.reward_type = 'boost_003' then '500'
                    when system_value.reward_type = 'boost_004' then '1000'
                    when system_value.reward_type = 'boost_005' then '1500'
                    when system_value.reward_type = 'boost_006' then '1800'
                    when system_value.reward_type = 'LEVEL' then '6000'
                    when system_value.reward_type = 'SKILL' then '30000'
                  end as int64) * system_value.reward_amount ) ), 0) AS system_value_system_value_sum
      FROM `eraser-blast.looker_scratch.LR_6YPD91626324537280_system_value` AS system_value
      GROUP BY
          1,
          2
      ORDER BY
          2
       ;;
    datagroup_trigger: change_3_hrs
  }

  dimension: system_value_rdg_id {
    hidden: yes
    type: string
    sql: ${TABLE}.system_value_rdg_id ;;
  }

  dimension: current_card {
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: system_value_current_card_numbered {
    type: number
    value_format: "####"
    sql: @{current_card_numbered} ;;
  }
  dimension: system_value_system_value_sum {
    hidden: yes
    type: number
    sql: ${TABLE}.system_value_system_value_sum ;;
  }

  measure:  system_value_025 {
    group_label: "System Value"
    label: "System Value - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${system_value_system_value_sum} ;;
  }
  measure:  system_value_25 {
    group_label: "System Value"
    label: "System Value - 25%"
    type: percentile
    percentile: 25
    sql: ${system_value_system_value_sum} ;;
  }
  measure:  system_value_med {
    group_label: "System Value"
    label: "System Value - Median"
    type: median
    sql: ${system_value_system_value_sum} ;;
  }
  measure:  system_value_75 {
    group_label: "System Value"
    label: "System Value - 75%"
    type: percentile
    percentile: 75
    sql: ${system_value_system_value_sum} ;;
  }
  measure:  system_value_975 {
    group_label: "System Value"
    label: "System Value - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${system_value_system_value_sum} ;;
  }
  set: detail {
    fields: [system_value_rdg_id, current_card, system_value_system_value_sum]
  }
}
