view: attempts_per_level {
  derived_table: {
    explore_source: gameplay {
      column: rdg_id {}
      column: last_level_id {}
      column: max_attempts {}
      column: proximity_to_completion_int_avg {}
    }
  }
  dimension: pk {
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${last_level_id} ;;
  }
  dimension: rdg_id {
    hidden: yes
  }
  dimension: last_level_id {
    hidden: no
  }
  dimension: max_attempts {
    hidden: no
  }
  dimension: proximity_to_completion_int_avg {
    hidden: yes
  }
  measure:  proximity_to_completion_int_avg_med {
    group_label: "Proximity to Completion"
    label: "Proximity to Completion - Median"
    type: percentile
    percentile: 50
    sql: ${proximity_to_completion_int_avg} ;;
  }
  measure: attempts_per_day_025 {
    group_label: "Max Attempts per Level"
    label: "Max Attempts per Level - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${max_attempts} ;;
  }
  measure: attempts_per_day_25 {
    group_label: "Max Attempts per Level"
    label: "Max Attempts per Level - 25%"
    type: percentile
    percentile: 25
    sql: ${max_attempts} ;;
  }
  measure: attempts_per_day_med {
    group_label: "Max Attempts per Level"
    label: "Max Attempts per Level - Median"
    type: percentile
    percentile: 50
    sql: ${max_attempts} ;;
  }
  measure: attempts_per_day_75 {
    group_label: "Max Attempts per Level"
    label: "Max Attempts per Level - 75%"
    type: percentile
    percentile: 75
    sql: ${max_attempts} ;;
  }
  measure: attempts_per_day_975 {
    group_label: "Max Attempts per Level"
    label: "Max Attempts per Level - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${max_attempts} ;;
  }

  measure: attempts_per_day_mean {
    group_label: "Max Attempts per Level"
    label: "Max Attempts per Level - Mean"
    type: average
    value_format: "#0.00"
    sql: ${max_attempts} ;;
  }

  # dimension_group: event {
  #   type: time
  #   sql: ${TABLE}.timestamp ;;
  #   timeframes: [
  #     raw
  #     ,time
  #     ,date
  #     ,week
  #     ,month
  #     ,quarter
  #     ,year
  #   ]
  # }
  # dimension: round_end_count {
  #   hidden: yes
  #   type: number
  # }
  drill_fields: [rdg_id,max_attempts]
}
