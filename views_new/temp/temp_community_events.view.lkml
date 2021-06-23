view: temp_community_events {
  derived_table: {
    sql:
      with community_event_by_player as (
      select
        rdg_id
        ,json_extract_scalar(extra_json,"$.event_id") event_id
        ,json_extract_scalar(extra_json,"$.team_id") team_id
        ,cast(json_extract_scalar(extra_json,"$.score") as int64) score
        ,cast(json_extract_scalar(extra_json,"$.player_rank") as int64) player_rank
      from game_data.events
      where event_name = 'community_event'
      and timestamp >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
      )
      select
        community_event_by_player.rdg_id
        ,community_event_by_player.event_id
        ,community_event_by_player.team_id
        ,max(community_event_by_player.score) score
        ,max(community_event_by_player.player_rank) player_rank
      from community_event_by_player
      group by 1,2,3
    ;;
    datagroup_trigger: change_3_hrs
  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_raw} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    hidden: yes
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,hour_of_day
      ,time
      ,date
      ,month
      ,year
    ]
  }
  dimension: event_id {
    label: "Event ID"
    sql: ${TABLE}.event_id ;;
  }
  dimension: team_id {
    label: "Team ID"
    sql: ${TABLE}.team_id ;;
  }
  dimension: score {
    label: "Score"
    hidden: yes
    type: number
    sql: ${TABLE}.score ;;
  }
  measure: score_sum {
    label: "Total Score"
    type: sum
    sql: ${score} ;;
  }
  dimension: player_rank {
    label: "Intra-Team Rank"
    type: number
    sql: ${TABLE}.player_rank ;;
  }
  measure: player_count {
    label: "Player Count"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
}
