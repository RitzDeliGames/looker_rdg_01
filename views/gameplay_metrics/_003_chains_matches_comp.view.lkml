include: "/views/**/events.view"

view: _003_chains_matches_comp {
  extends: [events]

  dimension: all_chains_packed {
    type: string
    sql: JSON_EXTRACT(${extra_json},'$.all_chains') ;;
  }

  # CHAINS AND MATCHES DIMENSIONS

  dimension: round_length {
    type: number
    sql: CAST(JSON_Value(${extra_json},'$.round_length') AS NUMERIC) / 1000  ;; ###this should probably be moved to the main events view
  }

  dimension: chain_length {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.total_chains') AS NUMERIC)  ;;
  }

  dimension: seconds_per_chain {
    type: number
    sql: 1.0*${round_length} / NULLIF(${chain_length},0) ;;
  }

  dimension: all_chains {
    type: number
    sql: all_chains ;;
  }

  ###MEASURES###

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  #####################_BOXPLOTS_#####################

  parameter: boxplot_ {
    type: string
    allowed_value: {
      label: "chain length"
      value: "chain length"
    }
    allowed_value: {
      label: "seconds per chain"
      value: "seconds per chain"
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
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
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
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
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
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
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
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
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
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
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
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
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
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
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
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
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
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
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
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }


###############

  set: detail {
    fields: [
      events.character_used,
      user_type,
      player_xp_level,
      events.platform,
      chain_length,
      seconds_per_chain,
      round_length,
      all_chains_packed,
    ]
  }
}


#      all_chains.all_chains,
