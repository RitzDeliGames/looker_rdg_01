include: "/views/**/events.view"

view: _003_chains_matches_comp {
  extends: [events]



#####DIMENSIONS#####

  dimension: chains_made {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.total_chains') AS NUMERIC) ;;
  }

  dimension: chain_length_packed {
    type: string
    sql: CASE
          WHEN JSON_EXTRACT(${extra_json},'$.chain_length') <> ''
          THEN JSON_EXTRACT(${extra_json},'$.chain_length')
          END;;
  }

  dimension: seconds_per_chain {
    type: number
    sql: 1.0*${round_length} / NULLIF(${chains_made},0) ;;
  }

  dimension: chain_length {
    type: number
    sql: chain_length ;;
  }


#####MEASURES#####

  measure: count {
    type: count
    drill_fields: [detail*]
  }


#####CHAIN & MATCHES BOXPLOTS#####

  parameter: boxplot_ {
    type: string
    allowed_value: {
      label: "chains made"
      value: "chains made"
    }
    allowed_value: {
      label: "seconds per chain"
      value: "seconds per chain"
    }
    allowed_value: {
      label: "chain length"
      value: "chain length"
    }
  }

  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by chains made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_made+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN CAST(if(${chain_length.chain_length} = '' , '0', ${chain_length.chain_length}) AS NUMERIC)
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by chains made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_made+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN CAST(if(${chain_length.chain_length} = '' , '0', ${chain_length.chain_length}) AS NUMERIC)
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by chains made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_made+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN CAST(if(${chain_length.chain_length} = '' , '0', ${chain_length.chain_length}) AS NUMERIC)
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by chains made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_made+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN CAST(if(${chain_length.chain_length} = '' , '0', ${chain_length.chain_length}) AS NUMERIC)
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by chains made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_made+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chain_length+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chain length'
      THEN CAST(if(${chain_length.chain_length} = '' , '0', ${chain_length.chain_length}) AS NUMERIC)
    END  ;;
  }


###############

  set: detail {
    fields: [
      character_used,
      user_type,
      player_xp_level,
      device_platform,
      chains_made,
      seconds_per_chain,
      round_length,
      chain_length_packed,
      chain_length
    ]
  }
}
