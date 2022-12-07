view: fps {
  derived_table: {
  sql:
    select
      rdg_id
      ,timestamp
      ,cast(last_level_serial as int64) last_level_serial
      ,sum(cast(frame_time_histogram as int64)) as frame_count
        ,offset as ms_per_frame
      ,event_name
      ,json_extract_scalar(extra_json, "$.transition_from") scene_transition_from
      ,last_level_id
    from game_data.events
    cross join unnest(split(json_extract_scalar(extra_json,'$.frame_time_histogram_values'))) as frame_time_histogram with offset
    where timestamp >= '2022-06-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
      and event_name in ('round_end','transition')
   group by 1,2,3,5,6,7,8
   order by ms_per_frame asc
  ;;
    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
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
  dimension: scene_transition_from {}
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
  dimension: under_40_ms_per_frame {
    type: string
    sql: case
          when ${ms_per_frame} <= 40 then 'under_40'
          else 'over_40'
        end;;
  }
  dimension: frame_count {
    type: number
    sql: ${TABLE}.frame_count ;;
  }
  measure: frame_count_sum {
    type: sum
    sql: ${frame_count} ;;
    drill_fields: [rdg_id]
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
  }
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
  }
  dimension: last_level_serial_offset {
    group_label: "Level Dimensions"
    label: "Current Level"
    type: number
    sql: ${last_level_serial} + 1 ;;
  }
}
