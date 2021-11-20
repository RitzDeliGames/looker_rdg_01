view: fps {
  derived_table: {
  sql:
    select
      rdg_id
      ,timestamp
      ,sum(cast(frame_time_histogram as int64)) as frame_count
        ,offset as ms_per_frame
      ,event_name
    from game_data.events
    cross join unnest(split(json_extract_scalar(extra_json,'$.frame_time_histogram_values'))) as frame_time_histogram with offset
    where timestamp >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
   group by 1,2,4,5
   order by ms_per_frame asc
  ;;
  datagroup_trigger: change_3_hrs
  }

  dimension: primary_key {
    hidden: yes
    type: string
    sql: ${rdg_id} || ${event_raw} ;;
  }
  dimension: rdg_id {}
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
  dimension: event_name {}
  dimension: ms_per_frame {
    type: number
    hidden: yes
    sql: ${TABLE}.ms_per_frame ;;
  }
  dimension: under_22_ms_per_frame {
    type: string
    sql: case
          when ${ms_per_frame} <= 22 then 'under_22'
          else 'over_22'
        end;;
  }
  dimension: frame_count {
    type: number
    sql: ${TABLE}.frame_count ;;
  }
  measure: frame_count_sum {
    type: sum
    sql: ${frame_count} ;;
  }
}
