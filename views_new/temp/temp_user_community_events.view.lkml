view: temp_user_community_events {
  derived_table: {
    sql:
      select
        rdg_id
        ,json_extract_scalar(extra_json,"$.event_id") event_id
        ,json_extract_scalar(extra_json,"$.team_id") team_id
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,max(cast(json_extract_scalar(extra_json,"$.score") as int64)) score
        ,max(cast(json_extract_scalar(extra_json,"$.player_rank") as int64)) player_rank
      from game_data.events
      where event_name = 'community_event'
      and timestamp >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
      group by 1,2,3,4,5,6
    ;;
    datagroup_trigger: change_3_hrs
  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_id} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    hidden: yes
  }
  dimension: current_card {
    hidden: yes
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: last_unlocked_card {
    hidden: no
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: card_id {
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_numbered {
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: current_quest {
    type: number
    sql: ${TABLE}.current_quest ;;
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
