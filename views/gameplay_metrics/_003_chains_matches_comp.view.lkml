view: _003_chains_matches_comp {
  derived_table: {
    sql: SELECT extra_json,
                user_type,
                platform,
      FROM events
      WHERE event_name = 'round_end'
      AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

#   dimension: all_chains {
#     type: string
#     sql: ${TABLE}.all_chains ;;
#   }

  dimension: extra_json {
    type: string
    sql: ${TABLE}.extra_json ;;
  }

  dimension: eraser {
    type: string
    sql: JSON_EXTRACT_SCALAR(${extra_json},'$.team_slot_0') ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.user_type ;;
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

  dimension: total_chains {
    type: number
    sql: CAST(JSON_Value(extra_json,'$.total_chains') AS NUMERIC)  ;;
  }

  dimension: chains_per_second {
    type: number
    sql: 1.0*${round_length} / NULLIF(${total_chains},0) ;;
  }

  dimension: all_chains {
    type: number
    sql: all_chains ;;
  }


  #####################_BOXPLOTS_#####################


  parameter: boxplot_ {
    type: string
    allowed_value: {
      label: "total chains"
      value: "total chains"
    }
    allowed_value: {
      label: "chains per second"
      value: "chains per second"
    }
    allowed_value: {
      label: "all chains"
      value: "all chains"
    }
  }


  measure: 1_min_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by All Chains"
      # the use can't see "All chains sorted". Needs better implementation
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: min
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'total chains'
      THEN ${total_chains}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'all chains'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 5_max_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by All Chains"
      # the use can't see "All chains sorted". Needs better implementation
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: max
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'total chains'
      THEN ${total_chains}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'all chains'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 3_median_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by All Chains"
      # the use can't see "All chains sorted". Needs better implementation
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: median
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'total chains'
      THEN ${total_chains}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'all chains'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 2_25th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by All Chains"
      # the use can't see "All chains sorted". Needs better implementation
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'total chains'
      THEN ${total_chains}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'all chains'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }

  measure: 4_75th_boxplot {
    drill_fields: [detail*]
    link: {
      label: "Drill and sort by Total Chains"
      url: "{{ link }}&sorts=_003_chains_matches_comp.total_chains+desc"
    }
    link: {
      label: "Drill and sort by Chains per Second"
      url: "{{ link }}&sorts=_003_chains_matches_comp.chains_per_second+desc"
    }
    link: {
      label: "Drill and sort by All Chains"
      # the use can't see "All chains sorted". Needs better implementation
      url: "{{ link }}&sorts=_003_chains_matches_comp.all_chains+desc"
    }
    group_label: "BoxPlot"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN  {% parameter boxplot_ %} = 'total chains'
      THEN ${total_chains}
      WHEN  {% parameter boxplot_ %} = 'chains per second'
      THEN ${chains_per_second}
      WHEN  {% parameter boxplot_ %} = 'all chains'
      THEN CAST(if(${all_chains.all_chains} = '' , '0', ${all_chains.all_chains}) AS NUMERIC)
    END  ;;
  }


###############

  set: detail {
    fields: [eraser,
      user_type,
      total_chains,
      chains_per_second,
      all_chains.all_chains,
      platform,
      round_length
    ]
  }
}
