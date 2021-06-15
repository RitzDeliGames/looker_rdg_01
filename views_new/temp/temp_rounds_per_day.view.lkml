view: temp_rounds_per_day {
  derived_table: {
    sql:
      with rounds_played_per_player as (select
        rdg_id
        ,timestamp
        ,count(timestamp) rounds_played
      from game_data.events
      where event_name = 'round_end'
        and timestamp >= timestamp(current_date() - 90)
        and timestamp < timestamp(current_date())
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
      group by 1,2)

      select
        rdg_id
        ,date(timestamp) day_played
        ,sum(rounds_played) total_rounds_played
      from rounds_played_per_player
      group by 1,2
      order by 1,2
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
  }
  dimension: rdg_id {}
  # dimension: primary_key {
  #   type: string
  #   sql: ${rdg_id} || '_' || ${event_raw} ;;
  #   primary_key: yes
  #   hidden: yes
  # }
  # dimension_group: event {
  #   type: time
  #   sql: ${TABLE}.timestamp ;;
  #   timeframes: [
  #     raw
  #     ,time
  #     ,date
  #     ,month
  #     ,year
  #   ]
  # }
  dimension: day_played {
    type: date
    sql: ${TABLE}.day_played ;;
  }
  dimension: total_rounds_played {
    type: number
  }
  measure: rounds_played_025 {
    label: "Rounds Played - 2.5%"
    value_format: "0"
    type: percentile
    percentile: 2.5
    sql: ${total_rounds_played} ;;
    drill_fields: [rdg_id,total_rounds_played]
  }
  measure: rounds_played_25 {
    label: "Rounds Played - 25%"
    value_format: "0"
    type: percentile
    percentile: 25
    sql: ${total_rounds_played} ;;
  }
  measure: rounds_played_med {
    label: "Rounds Played - Med"
    value_format: "0"
    type: median
    sql: ${total_rounds_played} ;;
    drill_fields: [rdg_id,total_rounds_played]
  }
  measure: rounds_played_95 {
    label: "Rounds Played - 75%"
    value_format: "0"
    type: percentile
    percentile: 75
    sql: ${total_rounds_played} ;;
  }
  measure: rounds_played_975 {
    label: "Rounds Played - 97.5%"
    value_format: "0"
    type: percentile
    percentile: 97.5
    sql: ${total_rounds_played} ;;
    drill_fields: [rdg_id,total_rounds_played]
  }

}
