include: "/views/**/events.view"

view: _003_chains_matches_comp {
  extends: [events]

  dimension: all_chains_packed {
    type: string
    sql: CASE
    WHEN JSON_EXTRACT(${extra_json},'$.all_chains') <> ''
    THEN JSON_EXTRACT(${extra_json},'$.all_chains')
    END;;
  }

  # CHAINS AND MATCHES DIMENSIONS

#   dimension: round_length {
#     type: number
#     sql: CAST(JSON_Value(${extra_json},'$.round_length') AS NUMERIC) / 1000  ;; ###this should probably be moved to the main events view
#   }

  dimension: chains_made {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.total_chains') AS NUMERIC) ;;
  }


  dimension: seconds_per_chain {
    type: number
    sql: 1.0*${round_length} / NULLIF(${chains_made},0) ;;
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
      label: "total chains"
      value: "total chains"
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
      label: "Drill and sort by total chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by total chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by total chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
      url: "{{ link }}&sorts=_003_chains_matches_comp.seconds_per_chain+desc"
    }
    link: {
      label: "Drill and sort by Chains Made"
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by total chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
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
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by total chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Seconds per Chain"
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
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN ${chains_made}
      WHEN  {% parameter boxplot_ %} = 'seconds per chain'
      THEN ${seconds_per_chain}
      WHEN  {% parameter boxplot_ %} = 'chains made'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
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
      all_chains_packed,
    ]
  }
}


#      all_chains.all_chains,
