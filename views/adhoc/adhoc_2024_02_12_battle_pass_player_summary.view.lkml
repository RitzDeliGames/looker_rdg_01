view: adhoc_2024_02_12_battle_pass_player_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


     select
      rdg_id
      , case
          when date(a.rdg_date) >= '2023-08-03' and date(a.rdg_date) < '2023-09-01' then 'bp_2023_08'
          when date(a.rdg_date) >= '2023-09-03' and date(a.rdg_date) < '2023-10-01' then 'bp_2023_09'
          when date(a.rdg_date) >= '2023-10-02' and date(a.rdg_date) < '2023-11-01' then 'bp_2023_10'
          when date(a.rdg_date) >= '2023-11-02' and date(a.rdg_date) < '2023-12-01' then 'bp_2023_11'
          when date(a.rdg_date) >= '2023-12-02' and date(a.rdg_date) < '2024-01-01' then 'bp_2023_12'
          when date(a.rdg_date) >= '2024-01-02' and date(a.rdg_date) < '2024-02-01' then 'bp_2024_01'
          when date(a.rdg_date) >= '2024-02-02' and date(a.rdg_date) < '2024-03-01' then 'bp_2024_02'
          when date(a.rdg_date) >= '2024-03-02' and date(a.rdg_date) < '2024-04-01' then 'bp_2024_03'
          when date(a.rdg_date) >= '2024-04-02' and date(a.rdg_date) < '2024-05-01' then 'bp_2024_04'
          when date(a.rdg_date) >= '2024-05-02' and date(a.rdg_date) < '2024-06-01' then 'bp_2024_05'
          when date(a.rdg_date) >= '2024-06-02' and date(a.rdg_date) < '2024-07-01' then 'bp_2024_06'
          when date(a.rdg_date) >= '2024-07-02' and date(a.rdg_date) < '2024-08-01' then 'bp_2024_07'
          when date(a.rdg_date) >= '2024-08-02' and date(a.rdg_date) < '2024-09-01' then 'bp_2024_08'
          when date(a.rdg_date) >= '2024-09-02' and date(a.rdg_date) < '2024-10-01' then 'bp_2024_09'
          when date(a.rdg_date) >= '2024-10-02' and date(a.rdg_date) < '2024-11-01' then 'bp_2024_10'
          when date(a.rdg_date) >= '2024-11-02' and date(a.rdg_date) < '2024-12-01' then 'bp_2024_11'
          when date(a.rdg_date) >= '2024-12-02' and date(a.rdg_date) < '2025-01-01' then 'bp_2024_12'
          when date(a.rdg_date) >= '2025-01-02' and date(a.rdg_date) < '2025-02-01' then 'bp_2025_01'
          when date(a.rdg_date) >= '2025-02-02' and date(a.rdg_date) < '2025-03-01' then 'bp_2025_02'
          when date(a.rdg_date) >= '2025-03-02' and date(a.rdg_date) < '2025-04-01' then 'bp_2025_03'
          when date(a.rdg_date) >= '2025-04-02' and date(a.rdg_date) < '2025-05-01' then 'bp_2025_04'
          when date(a.rdg_date) >= '2025-05-02' and date(a.rdg_date) < '2025-06-01' then 'bp_2025_05'
          when date(a.rdg_date) >= '2025-06-02' and date(a.rdg_date) < '2025-07-01' then 'bp_2025_06'
          when date(a.rdg_date) >= '2025-07-02' and date(a.rdg_date) < '2025-08-01' then 'bp_2025_07'
          when date(a.rdg_date) >= '2025-08-02' and date(a.rdg_date) < '2025-09-01' then 'bp_2025_08'
          when date(a.rdg_date) >= '2025-09-02' and date(a.rdg_date) < '2025-10-01' then 'bp_2025_09'
          when date(a.rdg_date) >= '2025-10-02' and date(a.rdg_date) < '2025-11-01' then 'bp_2025_10'
          when date(a.rdg_date) >= '2025-11-02' and date(a.rdg_date) < '2025-12-01' then 'bp_2025_11'
          when date(a.rdg_date) >= '2025-12-02' and date(a.rdg_date) < '2026-01-01' then 'bp_2025_12'
          when date(a.rdg_date) >= '2026-01-02' and date(a.rdg_date) < '2026-02-01' then 'bp_2026_01'
          when date(a.rdg_date) >= '2026-02-02' and date(a.rdg_date) < '2026-03-01' then 'bp_2026_02'
          when date(a.rdg_date) >= '2026-03-02' and date(a.rdg_date) < '2026-04-01' then 'bp_2026_03'
          when date(a.rdg_date) >= '2026-04-02' and date(a.rdg_date) < '2026-05-01' then 'bp_2026_04'
          when date(a.rdg_date) >= '2026-05-02' and date(a.rdg_date) < '2026-06-01' then 'bp_2026_05'
          when date(a.rdg_date) >= '2026-06-02' and date(a.rdg_date) < '2026-07-01' then 'bp_2026_06'
          when date(a.rdg_date) >= '2026-07-02' and date(a.rdg_date) < '2026-08-01' then 'bp_2026_07'
          when date(a.rdg_date) >= '2026-08-02' and date(a.rdg_date) < '2026-09-01' then 'bp_2026_08'
          when date(a.rdg_date) >= '2026-09-02' and date(a.rdg_date) < '2026-10-01' then 'bp_2026_09'
          when date(a.rdg_date) >= '2026-10-02' and date(a.rdg_date) < '2026-11-01' then 'bp_2026_10'
          when date(a.rdg_date) >= '2026-11-02' and date(a.rdg_date) < '2026-12-01' then 'bp_2026_11'
          when date(a.rdg_date) >= '2026-12-02' and date(a.rdg_date) < '2027-01-01' then 'bp_2026_12'
          when date(a.rdg_date) >= '2027-01-02' and date(a.rdg_date) < '2027-02-01' then 'bp_2027_01'
          when date(a.rdg_date) >= '2027-02-02' and date(a.rdg_date) < '2027-03-01' then 'bp_2027_02'
          when date(a.rdg_date) >= '2027-03-02' and date(a.rdg_date) < '2027-04-01' then 'bp_2027_03'
          when date(a.rdg_date) >= '2027-04-02' and date(a.rdg_date) < '2027-05-01' then 'bp_2027_04'
          when date(a.rdg_date) >= '2027-05-02' and date(a.rdg_date) < '2027-06-01' then 'bp_2027_05'
          when date(a.rdg_date) >= '2027-06-02' and date(a.rdg_date) < '2027-07-01' then 'bp_2027_06'
          when date(a.rdg_date) >= '2027-07-02' and date(a.rdg_date) < '2027-08-01' then 'bp_2027_07'
          when date(a.rdg_date) >= '2027-08-02' and date(a.rdg_date) < '2027-09-01' then 'bp_2027_08'
          when date(a.rdg_date) >= '2027-09-02' and date(a.rdg_date) < '2027-10-01' then 'bp_2027_09'
          when date(a.rdg_date) >= '2027-10-02' and date(a.rdg_date) < '2027-11-01' then 'bp_2027_10'
          when date(a.rdg_date) >= '2027-11-02' and date(a.rdg_date) < '2027-12-01' then 'bp_2027_11'
          when date(a.rdg_date) >= '2027-12-02' and date(a.rdg_date) < '2028-01-01' then 'bp_2027_12'
          when date(a.rdg_date) >= '2028-01-02' and date(a.rdg_date) < '2028-02-01' then 'bp_2028_01'
          when date(a.rdg_date) >= '2028-02-02' and date(a.rdg_date) < '2028-03-01' then 'bp_2028_02'
          when date(a.rdg_date) >= '2028-03-02' and date(a.rdg_date) < '2028-04-01' then 'bp_2028_03'
          when date(a.rdg_date) >= '2028-04-02' and date(a.rdg_date) < '2028-05-01' then 'bp_2028_04'
          when date(a.rdg_date) >= '2028-05-02' and date(a.rdg_date) < '2028-06-01' then 'bp_2028_05'
          when date(a.rdg_date) >= '2028-06-02' and date(a.rdg_date) < '2028-07-01' then 'bp_2028_06'
          when date(a.rdg_date) >= '2028-07-02' and date(a.rdg_date) < '2028-08-01' then 'bp_2028_07'
          when date(a.rdg_date) >= '2028-08-02' and date(a.rdg_date) < '2028-09-01' then 'bp_2028_08'
          when date(a.rdg_date) >= '2028-09-02' and date(a.rdg_date) < '2028-10-01' then 'bp_2028_09'
          when date(a.rdg_date) >= '2028-10-02' and date(a.rdg_date) < '2028-11-01' then 'bp_2028_10'
          when date(a.rdg_date) >= '2028-11-02' and date(a.rdg_date) < '2028-12-01' then 'bp_2028_11'
          when date(a.rdg_date) >= '2028-12-02' and date(a.rdg_date) < '2029-01-01' then 'bp_2028_12'
          when date(a.rdg_date) >= '2029-01-02' and date(a.rdg_date) < '2029-02-01' then 'bp_2029_01'
          when date(a.rdg_date) >= '2029-02-02' and date(a.rdg_date) < '2029-03-01' then 'bp_2029_02'
          when date(a.rdg_date) >= '2029-03-02' and date(a.rdg_date) < '2029-04-01' then 'bp_2029_03'
          when date(a.rdg_date) >= '2029-04-02' and date(a.rdg_date) < '2029-05-01' then 'bp_2029_04'
          when date(a.rdg_date) >= '2029-05-02' and date(a.rdg_date) < '2029-06-01' then 'bp_2029_05'
          when date(a.rdg_date) >= '2029-06-02' and date(a.rdg_date) < '2029-07-01' then 'bp_2029_06'
          when date(a.rdg_date) >= '2029-07-02' and date(a.rdg_date) < '2029-08-01' then 'bp_2029_07'
          when date(a.rdg_date) >= '2029-08-02' and date(a.rdg_date) < '2029-09-01' then 'bp_2029_08'
          when date(a.rdg_date) >= '2029-09-02' and date(a.rdg_date) < '2029-10-01' then 'bp_2029_09'
          when date(a.rdg_date) >= '2029-10-02' and date(a.rdg_date) < '2029-11-01' then 'bp_2029_10'
          when date(a.rdg_date) >= '2029-11-02' and date(a.rdg_date) < '2029-12-01' then 'bp_2029_11'
          when date(a.rdg_date) >= '2029-12-02' and date(a.rdg_date) < '2030-01-01' then 'bp_2029_12'
        else 'Unmapped'
        end as battle_pass_number
    , a.battle_pass_reward_type
    , max( rdg_date ) as max_rdg_date
    , min( rdg_date ) as min_rdg_date
    , count(distinct rdg_date) as count_days_played_during_battle_pass
    , min( created_at ) as min_created_at
    , min(version) as min_version
    , max(version) as max_version
    , count(distinct session_id) as count_sessions_during_battle_pass
    , max(experiments) as experiments
    , max(battle_pass_level) as max_battle_pass_level
    , max(win_streak) max_win_streak
    , min(last_level_serial) min_last_level_serial
    , max(last_level_serial) max_last_level_serial

  from
    ${player_battle_pass_summary.SQL_TABLE_NAME} a
    -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_battle_pass_summary a
  group by
    1,2,3

      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: my_primary_key {
    type: number
    sql:
    ${TABLE}.rdg_id
    || ${TABLE}.battle_pass_number
    || ${TABLE}.battle_pass_reward_type
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: rdg_id {type: string}
  dimension: battle_pass_number {type: string}
  dimension: battle_pass_reward_type {type: string}


  dimension_group: max_activity_date {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.max_rdg_date ;;
  }

  dimension_group: min_activity_date {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.min_rdg_date ;;
  }

  dimension_group: install_date {
    type: time
    timeframes: [time, date, week, month, year]
    sql: ${TABLE}.min_created_at ;;
  }

  dimension: count_days_played_during_battle_pass {type: number}
  dimension: count_sessions_during_battle_pass {type: number}
  dimension: max_battle_pass_level {type: number}
  dimension: max_win_streak {type: number}
  dimension: min_last_level_serial {type: number}
  dimension: max_last_level_serial {type: number}

  dimension: min_version {type: string}
  dimension: max_version {type: string}
  dimension: experiments {type: string}


################################################################
## Measures
################################################################


  measure: count_instances {
    label: "Count Players"
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }







}
