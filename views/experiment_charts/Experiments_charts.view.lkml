include: "/views/**/events.view"

view: experiments_charts {
  extends: [events]


  parameter: since_install_parameter {
    type: string
    allowed_value: {
      label: "Minutes_Since_Install"
      value: "Minutes_Since_Install"
    }
    allowed_value: {
      label: "Days_Since_Install"
      value: "Days_Since_Install"
    }
  }


  measure: 1_min_since_install {
    group_label: "Since_Install_measures"
    type: min
    sql: CASE
     WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
     THEN IF (CAST(${minutes_since_install} AS NUMERIC) >= 0,
        CAST(${minutes_since_install} AS NUMERIC),
        0)
     WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
    THEN IF (CAST(${days_since_install} AS NUMERIC) >= 0,
        CAST(${days_since_install} AS NUMERIC),
        0)
    END ;;
  }

  measure: 2_25th_since_install {
    group_label: "Since_Install_measures"
    type: percentile
    percentile: 25
    sql: CASE
     WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
     THEN CAST(${minutes_since_install} AS NUMERIC)
     WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
     THEN CAST(${days_since_install} AS NUMERIC)
    END ;;
  }

  measure: 3_median_since_install{
    group_label: "Since_Install_measures"
    type: median
    sql: CASE
     WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
     THEN CAST(${minutes_since_install} AS NUMERIC)
     WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
     THEN CAST(${days_since_install} AS NUMERIC)
    END ;;
  }

  measure: 4_75th_since_install {
    group_label: "Since_Install_measures"
    type: percentile
    percentile: 75
    sql: CASE
     WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
     THEN CAST(${minutes_since_install} AS NUMERIC)
     WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
     THEN CAST(${days_since_install} AS NUMERIC)
    END ;;
  }

  measure: 5_max_since_install{
    group_label: "Since_Install_measures"
    type: max
    sql: CASE
     WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
     THEN CAST(${minutes_since_install} AS NUMERIC)
     WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
     THEN CAST(${days_since_install} AS NUMERIC)
    END ;;
  }



# TEST min Since Install  HOLD: 30_mins_since_install


#   dimension: 30_mins_since {
#     group_label: "Install Date"
#     label: "First 30 Minutes of Play"
#     style: integer
#     type: tier
#     tiers: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
#     sql: ${minutes_since_install} ;;
#   }
#
#   measure: test_min {
#     group_label: "Since_Install_measures"
#     type: min
#     sql: CASE
#            WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
#            THEN CAST(${30_mins_since} AS NUMERIC)
#            WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
#            THEN CAST(${days_since_install} AS NUMERIC)
#           END ;;
#   }
#
#   measure: test_25th {
#     group_label: "Since_Install_measures"
#     type: percentile
#     percentile: 25
#     sql: CASE
#            WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
#            THEN CAST(${30_mins_since} AS NUMERIC)
#            WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
#            THEN CAST(${days_since_install} AS NUMERIC)
#           END ;;
#   }
#
#   measure: test_median {
#     group_label: "Since_Install_measures"
#     type: median
#     sql: CASE
#            WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
#            THEN CAST(${30_mins_since} AS NUMERIC)
#            WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
#            THEN CAST(${days_since_install} AS NUMERIC)
#           END ;;
#   }
#
#   measure: test_75th {
#     group_label: "Since_Install_measures"
#     type: percentile
#     percentile: 75
#     sql: CASE
#            WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
#            THEN CAST(${30_mins_since} AS NUMERIC)
#            WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
#            THEN CAST(${days_since_install} AS NUMERIC)
#           END ;;
#   }
#
#   measure: test_max {
#     group_label: "Since_Install_measures"
#     type: max
#     sql: CASE
#            WHEN {% parameter since_install_parameter %} = 'Minutes_Since_Install'
#            THEN CAST(${30_mins_since} AS NUMERIC)
#            WHEN {% parameter since_install_parameter %} = 'Days_Since_Install'
#            THEN CAST(${days_since_install} AS NUMERIC)
#           END ;;
#   }

}
