view: starts_ends_awake_ratios {
  derived_table: {
    sql: SELECT hardware,
       COUNTIF(event_name = 'TitleScreenAwake') AS awakes,
       COUNTIF(event_name = 'round_start') AS starts,
       COUNTIF(event_name = 'round_end') AS ends,
       COUNTIF(event_name = 'round_start') / (COUNTIF(event_name = 'TitleScreenAwake') + 1) AS starts_per_awake,
       COUNTIF(event_name = 'round_end') / (COUNTIF(event_name = 'TitleScreenAwake') + 1) AS ends_per_awake
FROM events
WHERE user_type = 'external'
GROUP BY hardware
ORDER BY awakes DESC
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hardware {
    type: string
    sql: ${TABLE}.hardware ;;
  }

  dimension: awakes {
    type: number
    sql: ${TABLE}.awakes ;;
  }

  dimension: starts {
    type: number
    sql: ${TABLE}.starts ;;
  }

  dimension: ends {
    type: number
    sql: ${TABLE}.ends ;;
  }

  dimension: starts_per_awake {
    type: number
    sql: ${TABLE}.starts_per_awake ;;
  }

  dimension: ends_per_awake {
    type: number
    sql: ${TABLE}.ends_per_awake ;;
  }

  set: detail {
    fields: [
      hardware,
      awakes,
      starts,
      ends,
      starts_per_awake,
      ends_per_awake
    ]
  }
}
