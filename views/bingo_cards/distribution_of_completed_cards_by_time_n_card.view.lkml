explore: distribution_of_completed_cards_by_time_n_card {}

view: distribution_of_completed_cards_by_time_n_card {
  derived_table: {
    sql: SELECT
        CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', _000_bingo_cards_comp.created_at , 'America/Los_Angeles')) AS DATE) AS _000_bingo_cards_comp_user_first_seen_date,
        CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', _000_bingo_cards_comp.timestamp , 'America/Los_Angeles')) AS DATE) AS _000_bingo_cards_comp_event_date,
        _000_bingo_cards_comp.current_card  AS _000_bingo_cards_comp_current_card,
        CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', _000_bingo_cards_comp.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', _000_bingo_cards_comp.created_at , 'America/Los_Angeles')), DAY) AS INT64) AS _000_bingo_cards_comp_days_since_install,
        COUNT(DISTINCT (CAST(JSON_EXTRACT(extra_json, '$.card_end_time') AS INT64)))  AS _000_bingo_cards_comp_card_end_measure
      FROM `eraser-blast.game_data.events` AS _000_bingo_cards_comp
      CROSS JOIN UNNEST([
            (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%,%5%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%,%2%,%3%,%4%,%5%'
                    THEN 'row_01' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%7%,%8%,%9%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%6%,%7%,%8%,%9%,1%0'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%7%,%9%'
                    THEN 'row_02' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%2%,%1%3%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%1%,%1%2%,%1%3%,%1%4%'
                    THEN 'row_03' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%6%,%1%7%,%1%8%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%5%,%1%6%,%1%7%,%1%8%,%1%9%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%6%,%1%8%'
                    THEN 'row_04' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%2%0%,%2%4%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%2%0%,%2%1%,%2%2%,%2%3%,%2%4%'
                    THEN 'row_05' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%,%6%,%1%1%,%1%5%,%2%0%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%,%2%0%'
                    THEN 'column_1' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%7%,%1%2%,%1%6%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%2%,%7%,%1%2%,%1%6%,%2%1%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%7%,%1%6%'
                    THEN 'column_2' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%3%,%8%,%1%7%,%2%2%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%8%,%1%7%'
                    THEN 'column_3' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%9%,%1%3%,%1%8%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%5%,%1%6%,%1%7%,%1%8%,%1%9%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%9%,%1%8%'
                    THEN 'column_4' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%5%,%2%4%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%5%,%1%0%,%1%4%,%1%9%,%2%4%'
                    THEN 'column_5' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%7%,%1%8%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%,%7%,%1%8%,%2%4%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%1%,%7%,%1%8%,%2%4%'
                    THEN 'diagonal_01' END)
            , (CASE WHEN (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%5%,%9%,%1%6%,%2%0%'
                    OR (JSON_EXTRACT(extra_json, '$.card_state')) LIKE '%9%,%1%6%'
                    THEN 'diagonal_02' END)
            ]) as card_id

      WHERE _000_bingo_cards_comp.event_name IN ("cards")
        AND _000_bingo_cards_comp.user_type NOT IN ("internal_editor", "unit_test")
      GROUP BY 1,2,3,4
      ORDER BY 2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: _000_bingo_cards_comp_user_first_seen_date {
    type: date
    datatype: date
    sql: ${TABLE}._000_bingo_cards_comp_user_first_seen_date ;;
  }

  dimension: _000_bingo_cards_comp_event_date {
    type: date
    datatype: date
    sql: ${TABLE}._000_bingo_cards_comp_event_date ;;
  }

  dimension: _000_bingo_cards_comp_current_card {
    type: string
    sql: ${TABLE}._000_bingo_cards_comp_current_card ;;
  }

  dimension: _000_bingo_cards_comp_days_since_install {
    type: number
    sql: ${TABLE}._000_bingo_cards_comp_days_since_install ;;
  }

  dimension: card_end_measure {
    type: number
    sql: ${TABLE}._000_bingo_cards_comp_card_end_measure ;;
  }

  measure: 1_min {
    group_label: "Since_Install_measures"
    type: min
    sql: ${card_end_measure} ;;
  }

  measure: 2_25th {
    group_label: "Since_Install_measures"
    type: percentile
    percentile: 25
    sql: ${card_end_measure} ;;
  }

  measure: 3_median {
    group_label: "Since_Install_measures"
    type: median
    sql: ${card_end_measure} ;;
  }

  measure: 4_75th {
    group_label: "Since_Install_measures"
    type: percentile
    percentile: 75
    sql: ${card_end_measure} ;;
  }

  measure: 5_max {
    group_label: "Since_Install_measures"
    type: max
    sql: ${card_end_measure} ;;
  }

  set: detail {
    fields: [_000_bingo_cards_comp_user_first_seen_date, _000_bingo_cards_comp_event_date, _000_bingo_cards_comp_current_card, _000_bingo_cards_comp_days_since_install, card_end_measure]
  }
}
