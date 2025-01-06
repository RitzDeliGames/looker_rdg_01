view: adhoc_2025_01_06_high_memory_usage {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      with

base_list_of_ids as (

  select
    a.rdg_id
  from
    eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary a
    left join eraser-blast.looker_scratch.6Y_ritz_deli_games_player_summary_new b
      on a.rdg_id = b.rdg_id
  where
    a.used_memory_bytes >= 400000000
    and date(a.rdg_date) between '2024-08-01' and '2025-01-07'
    and a.version in ('13606', '13616', '13618', '13620')
    and a.cumulative_rounds_this_session >= 72
  group by
    1

)

-- use existing player_round_summary in `eraser-blast.looker_scratch.LR_6YHSM1736125639995_player_round_summary`
SELECT
    player_round_summary_cumulative_rounds_this_session,
    player_round_summary_used_memory_bytes_10,
    player_round_summary_used_memory_bytes_25,
    player_round_summary_used_memory_bytes_50,
    player_round_summary_used_memory_bytes_75,
    player_round_summary_used_memory_bytes_95,
    sum_of_count_rounds
FROM
    (SELECT
            player_round_summary.cumulative_rounds_this_session AS player_round_summary_cumulative_rounds_this_session,
            CASE WHEN COUNT(player_round_summary.used_memory_bytes) <= 10000 THEN (ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.1 - 0.0000001) AS INT64))] + ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.1) AS INT64))]) / 2 ELSE APPROX_QUANTILES(player_round_summary.used_memory_bytes,1000)[OFFSET(100)] END AS player_round_summary_used_memory_bytes_10,
            CASE WHEN COUNT(player_round_summary.used_memory_bytes) <= 10000 THEN (ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.25 - 0.0000001) AS INT64))] + ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.25) AS INT64))]) / 2 ELSE APPROX_QUANTILES(player_round_summary.used_memory_bytes,1000)[OFFSET(250)] END AS player_round_summary_used_memory_bytes_25,
            CASE WHEN COUNT(player_round_summary.used_memory_bytes) <= 10000 THEN (ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.5 - 0.0000001) AS INT64))] + ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.5) AS INT64))]) / 2 ELSE APPROX_QUANTILES(player_round_summary.used_memory_bytes,1000)[OFFSET(500)] END AS player_round_summary_used_memory_bytes_50,
            CASE WHEN COUNT(player_round_summary.used_memory_bytes) <= 10000 THEN (ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.75 - 0.0000001) AS INT64))] + ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.75) AS INT64))]) / 2 ELSE APPROX_QUANTILES(player_round_summary.used_memory_bytes,1000)[OFFSET(750)] END AS player_round_summary_used_memory_bytes_75,
            CASE WHEN COUNT(player_round_summary.used_memory_bytes) <= 10000 THEN (ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.95 - 0.0000001) AS INT64))] + ARRAY_AGG(player_round_summary.used_memory_bytes IGNORE NULLS ORDER BY player_round_summary.used_memory_bytes LIMIT 10000)[OFFSET(CAST(FLOOR(COUNT(player_round_summary.used_memory_bytes) * 0.95) AS INT64))]) / 2 ELSE APPROX_QUANTILES(player_round_summary.used_memory_bytes,1000)[OFFSET(950)] END AS player_round_summary_used_memory_bytes_95,
            COALESCE(SUM(CAST( player_round_summary.count_rounds  AS NUMERIC)), 0) AS sum_of_count_rounds,
            COUNT(DISTINCT player_round_summary.rdg_id ) AS player_round_summary_count_distinct_active_users
        FROM eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary AS player_round_summary
          inner join base_list_of_ids b
            on player_round_summary.rdg_id = b.rdg_id
        WHERE ((( player_round_summary.rdg_date  ) >= (TIMESTAMP('2024-08-01 00:00:00')) AND ( player_round_summary.rdg_date  ) < (TIMESTAMP('2025-01-07 00:00:00')))) AND (player_round_summary.version) = '13620' AND (((( player_round_summary.cumulative_rounds_this_session ) >= 1 AND ( player_round_summary.cumulative_rounds_this_session ) <= 100)))
        GROUP BY
            1
        HAVING player_round_summary_count_distinct_active_users > 10) AS t3
ORDER BY
    player_round_summary_cumulative_rounds_this_session DESC
LIMIT 500


      ;;
    publish_as_db_view: yes
    sql_trigger_value: select extract( year from current_timestamp());;
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.player_round_summary_cumulative_rounds_this_session
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: player_round_summary_cumulative_rounds_this_session {type: number}


################################################################
## Measures
################################################################

  measure: player_round_summary_used_memory_bytes_10 { type: sum value_format_name: decimal_0 }
  measure: player_round_summary_used_memory_bytes_25 { type: sum value_format_name: decimal_0 }
  measure: player_round_summary_used_memory_bytes_50 { type: sum value_format_name: decimal_0 }
  measure: player_round_summary_used_memory_bytes_75 { type: sum value_format_name: decimal_0 }
  measure: player_round_summary_used_memory_bytes_95 { type: sum value_format_name: decimal_0 }
  measure: sum_of_count_rounds { type: sum value_format_name: decimal_0 }

}
