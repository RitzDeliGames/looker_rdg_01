view: adhoc_2025_01_09_gem_quest_memory_change_over_session {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      with

      base_data as (

      select
        rdg_id
        , session_id
        , rdg_date
        , cumulative_rounds_this_session
        , cumulative_rounds_this_session - 1 as previous_cumulative_rounds_this_session
        , game_mode
        , used_memory_bytes
      from
        eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary
      where
        -- date(rdg_date) = '2024-01-01'
        date(rdg_date) between '2024-08-01' and '2025-01-07'

      )

      select
        a.*
        -- , b.*
        -- , b.used_memory_bytes as previous_used_memory_bytes
        , b.used_memory_bytes as previous_used_memory_bytes
        , a.used_memory_bytes - b.used_memory_bytes as change_in_used_memory_bytes
        , case
            when a.game_mode = 'gemQuest' then 'gemQuest'
            else 'Other Mode'
            end as gem_quest_or_other_mode

      from
        base_data a
        left join base_data b
          on a.rdg_id = b.rdg_id
          and a.rdg_date = b.rdg_date
          and a.session_id = b.session_id
          and a.previous_cumulative_rounds_this_session = b.cumulative_rounds_this_session
      where
        a.cumulative_rounds_this_session > 1


      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
    partition_keys: ["rdg_date"]
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || ${TABLE}.session_id
    || ${TABLE}.rdg_date
    || ${TABLE}.cumulative_rounds_this_session
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: rdg_id {type: string}
  dimension: session_id {type: string}
  dimension_group: rdg_date {
    group_label: "Activity Dates"
    label: "Activity"
    type: time
    timeframes: [date, week, month, year, day_of_week, day_of_week_index]
    sql: ${TABLE}.rdg_date ;;
  }
  dimension: cumulative_rounds_this_session {type: number}
  dimension: game_mode {type: string}
  dimension: gem_quest_or_other_mode {type: string}
  dimension: used_memory_bytes {type: number}
  dimension: previous_used_memory_bytes {type: number}
  dimension: change_in_used_memory_bytes {type: number}


################################################################
## Measures
################################################################

  measure: change_in_used_memory_bytes_10 {
    group_label: "Change In Used Memory Bytes"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.change_in_used_memory_bytes ;;
  }
  measure: change_in_used_memory_bytes_25 {
    group_label: "Change In Used Memory Bytes"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.change_in_used_memory_bytes ;;
  }
  measure: change_in_used_memory_bytes_50 {
    group_label: "Change In Used Memory Bytes"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.change_in_used_memory_bytes ;;
  }
  measure: change_in_used_memory_bytes_75 {
    group_label: "Change In Used Memory Bytes"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.change_in_used_memory_bytes ;;
  }
  measure: change_in_used_memory_bytes_95 {
    group_label: "Change In Used Memory Bytes"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.change_in_used_memory_bytes ;;
  }

}
