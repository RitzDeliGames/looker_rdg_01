view: derived_install_version_players {
  derived_table: {
    sql: SELECT
      DISTINCT user_id,
      created_at AS derived_created_at,
      install_version,
      --version,
      MIN(version) AS derived_install_version,
      CASE
            WHEN MIN(version) LIKE '1568' THEN 'r1.0.001'
            WHEN MIN(version) LIKE '1579' THEN 'r1.0.100'
            WHEN MIN(version) LIKE '2047' THEN 'r1.1.001'
            WHEN MIN(version) LIKE '2100' THEN 'r1.1.100'
            WHEN MIN(version) LIKE '3028' THEN 'r1.2.028'
            WHEN MIN(version) LIKE '3043' THEN 'r1.2.043'
            WHEN MIN(version) LIKE '3100' THEN 'r1.2.100'
            WHEN MIN(version) LIKE '4017' THEN 'r1.3.017'
            WHEN MIN(version) LIKE '4100' THEN 'r1.3.100'
          END AS derived_install_release_version_minor
      FROM `eraser-blast.game_data.events`
      WHERE install_version IS NULL
      AND user_type = "external"
      AND user_id != "user_id_not_set"
      GROUP BY 1, 2, 3--, 4
      --HAVING derived_install_version IN ('1579', '2047', '2100', '3028', '3043', '3100', '4017', '4100')
      ORDER BY 4 ASC, 2 ASC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension_group: derived_created_at {
    type: time
    sql: ${TABLE}.derived_created_at ;;
  }

  dimension_group: user_first_seen {
    type: time
    group_label: "Install Date"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.derived_created_at ;;
  }

  dimension: derived_install_version {
    type: string
    sql: ${TABLE}.derived_install_version ;;
  }

  dimension: derived_install_release_version_minor {
    type: string
    sql: ${TABLE}.derived_install_release_version_minor ;;
  }

  set: detail {
    fields: [user_id, derived_created_at_time, derived_install_version]
  }
}
