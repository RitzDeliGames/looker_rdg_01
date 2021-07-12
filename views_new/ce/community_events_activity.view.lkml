view: community_events_activity {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,json_extract_scalar(extra_json,"$.event_id") event_id
        ,json_extract_scalar(extra_json,"$.team_id") team_id
        --,cast(json_extract_scalar(extra_json,"$.score") as int64) score
        --,cast(json_extract_scalar(extra_json,"$.player_rank") as int64) player_rank
        ,extra_json
        ,count(timestamp) rounds_played
      from game_data.events
      where event_name = 'community_event'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
      group by 1,2,3,4,5
    ;;
    datagroup_trigger: change_3_hrs
  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_id} ||timestamp;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    hidden: yes
  }
  dimension: event_id {
    label: "Event ID"
    sql: ${TABLE}.event_id ;;
  }
  dimension: event_names {
    label: "Event"
    sql: @{event_names} ;;
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,year
    ]
  }
  dimension: team_id {
    label: "Team ID"
    sql: ${TABLE}.team_id ;;
  }
  dimension: team_names {
    label: "Team Names"
    sql: @{event_team_names} ;;
  }
  # dimension: score {
  #   label: "Score"
  #   hidden: yes
  #   type: number
  #   sql: ${TABLE}.score ;;
  # }
  # measure: score_sum {
  #   label: "Total Score"
  #   type: sum
  #   sql: ${score} ;;
  # }
  # dimension: player_rank {
  #   label: "Intra-Team Rank"
  #   type: number
  #   sql: ${TABLE}.player_rank ;;
  # }
  measure: player_count {
    label: "Player Count"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  dimension: rounds_played {
    type: number
    sql: ${TABLE}.rounds_played ;;
    hidden: yes
  }
  measure: rounds_played_sum {
    label: "Rounds Played"
    type: sum
    sql: ${rounds_played} ;;
  }
  dimension: extra_json {
    hidden: yes
  }
}
