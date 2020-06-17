include: "/views/**/events.view"


view: player_analysis_view {
   extends: [events]

#   derived_table: {
#     sql: SELECT CAST(JSON_VALUE(extra_json, '$.round_id') AS NUMERIC) as round_id,
#           coins,
#           gems,
#           player_level_xp AS player_xp,
#           player_xp_level AS xp_player,
#       FROM
#       events
#       WHERE event_name = 'round_end'
#       AND JSON_EXTRACT(extra_json,'$.team_slot_0') IS NOT NULL
#        ;;
#   }

#   measure: count {
#     type: count
#     drill_fields: [detail*]
#   }
#

  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }

  dimension: coins {
    type: number
    sql: ${TABLE}.coins ;;
  }

  dimension: gems {
    type: number
    sql: ${TABLE}.gems ;;
  }

#   dimension: player_xp {
#     type: number
#     sql: ${TABLE}.player_xp ;;
#   }
#
#   dimension: xp_player {
#     type: number
#     sql: ${TABLE}.xp_player ;;
#   }




  parameter: line_charts {
    type: string
    allowed_value: {
      label: "coins balance"
      value: "coins balance"
    }
    allowed_value: {
      label: "gems"
      value: "gems"
    }
  }



###_LINE_CHARTS_###

##_MEASURES_##


  measure: 1_min_ {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: min
    sql: CASE
      WHEN {% parameter line_charts %} = 'coins balance'
      --THEN CAST(${TABLE}.coins AS NUMERIC)
      THEN ${coins}
      WHEN {% parameter line_charts %} = 'gems'
      --THEN CAST(${TABLE}.gems AS NUMERIC)
      THEN ${gems}
    END ;;
  }


  measure: 5_max_ {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: max
    sql: CASE
      WHEN {% parameter line_charts %} = 'coins balance'
      --THEN CAST(${TABLE}.coins AS NUMERIC)
      THEN ${coins}
      WHEN {% parameter line_charts %} = 'gems'
      --THEN CAST(${TABLE}.gems AS NUMERIC)
      THEN ${gems}
    END ;;
  }


  measure: 3_median_ {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: median
    sql: CASE
      WHEN {% parameter line_charts %} = 'coins balance'
      --THEN CAST(${TABLE}.coins AS NUMERIC)
      THEN ${coins}
      WHEN {% parameter line_charts %} = 'gems'
      --THEN CAST(${TABLE}.gems AS NUMERIC)
      THEN ${gems}
    END ;;
  }


  measure: 2_25th_ {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: percentile
    percentile: 25
    sql: CASE
      WHEN {% parameter line_charts %} = 'coins balance'
      --THEN CAST(${TABLE}.coins AS NUMERIC)
      THEN ${coins}
      WHEN {% parameter line_charts %} = 'gems'
      --THEN CAST(${TABLE}.gems AS NUMERIC)
      THEN ${gems}
    END ;;
  }


  measure: 4_75th_ {
#     drill_fields: [detail*]
#     link: {
#       label: "Drill and sort by COINS balance"
#       url: "{{ link }}&sorts=player_analysis.coins+desc"
#     }
#     link: {
#       label: "Drill and sort by XP PLAYER balance"
#       url: "{{ link }}&sorts=player_analysis.gems+desc"
#     }
    group_label: "TEST"
    type: percentile
    percentile: 75
    sql: CASE
      WHEN {% parameter line_charts %} = 'coins balance'
      --THEN CAST(${TABLE}.coins AS NUMERIC)
      THEN ${coins}
      WHEN {% parameter line_charts %} = 'gems'
      --THEN CAST(${TABLE}.gems AS NUMERIC)
      THEN ${gems}
    END ;;
  }




  set: detail {
    fields: [round_id, coins, gems]
  }
}
