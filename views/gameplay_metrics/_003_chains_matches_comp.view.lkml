include: "/views/**/events.view"

view: _003_chains_matches_comp {
  extends: [events]
  derived_table: {
    sql: SELECT extra_json,
                user_type,
                platform,
                timestamp_insert
      FROM events
      WHERE event_name = 'round_end'
      AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: all_chains_packed {
    type: string
    sql: JSON_EXTRACT(${extra_json},'$.all_chains') ;;
  }


  dimension: extra_json {
    type: string
    hidden: yes
    suggest_explore: events
    suggest_dimension: events.extra_json
    sql: ${TABLE}.extra_json ;;
  }

  dimension: character {
    type: string
    sql: JSON_EXTRACT_SCALAR(${extra_json},'$.team_slot_0') ;;
  }

#   dimension: user_type {
#     type: string
#     suggest_explore: events
#     suggest_dimension: events.user_type
#     sql: ${TABLE}.user_type ;;
#   }

  dimension_group: timestamp_insert {
    type: time
    hidden: yes
    sql: ${TABLE}.timestamp_insert ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: platform_type {
    type: string
    sql: CASE
      WHEN ${TABLE}.platform LIKE '%Android%' THEN 'mobile'
      WHEN ${TABLE}.platform LIKE '%iOS%' THEN 'mobile'
      ELSE 'desktop (web)'
      END ;;
  }


  # CHAINS AND MATCHES DIMENSIONS

  dimension: round_length {
    type: number
    sql: CAST(JSON_Value(${extra_json},'$.round_length') AS NUMERIC) / 1000  ;;
  }

  dimension: chain_length {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.total_chains') AS NUMERIC)  ;;
  }

  dimension: chains_per_second {
    type: number
    sql: 1.0*${round_length} / NULLIF(${chain_length},0) ;;
  }

  dimension: all_chains {
    type: number
    sql: all_chains ;;
  }


  #####################_BOXPLOTS_#####################


  parameter: boxplot_ {
    type: string
    allowed_value: {
      label: "chain length"
      value: "chain length"
    }
    allowed_value: {
      label: "chains per second"
      value: "chains per second"
    }
    allowed_value: {
      label: "chains made"
      value: "chains made"
    }
  }


  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Chain Length"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN ${chain_length}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Chain Length"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN ${chain_length}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Chain Length"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN ${chain_length}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Chain Length"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN ${chain_length}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Chain Length"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN ${chain_length}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }


###############

  set: detail {
    fields: [character,
      user_type,
      platform,
      chain_length,
      chains_per_second,
      round_length,
      all_chains_packed,
    ]
  }
}


#      all_chains.all_chains,
