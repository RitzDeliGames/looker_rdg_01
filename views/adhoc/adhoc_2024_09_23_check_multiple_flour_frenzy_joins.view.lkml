view: adhoc_2024_09_23_check_multiple_flour_frenzy_joins {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


      -- ccb_aggregate_update_tag
      -- update '2024-09-23'

      select
        rdg_id
        , safe_cast(json_extract_scalar( extra_json , "$.event_id") as string) as event_id
        , min(rdg_date) as rdg_date
        , sum(1) as count_event_joins
      from
        -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_simple_event_incremental
        ${player_simple_event_incremental.SQL_TABLE_NAME}
      where
        safe_cast(json_extract_scalar( extra_json , "$.event_id") as string) like 'ff%'
        and event_name = 'SimpleEventJoin'
      group by
        1,2

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
    || ${TABLE}.timestamp_utc
    || ${TABLE}.event_name
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension_group: activity_date {
    label: "Activity"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: rdg_id {type: string}
  dimension: count_event_joins {type: number}
  dimension: event_id {type: string}
  dimension: multiple_join_indicator {
    label: "Multiple Join Indicator"
    type: string
    sql:
      case
        when ${TABLE}.count_event_joins > 1
        then 'Player Joined Event Multiple Times'
        else 'Normal Join'
        end
    ;;

  }

################################################################
## Measures
################################################################

  measure: count_distinct_rdg_id {
    label: "Count Distinct Players"
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }



}
