view: adhoc_2024_09_20_check_time_to_join_flour_frenzy {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


      -- ccb_aggregate_update_tag
      -- update '2024-09-19'

      with

      base_data as (

        select
          rdg_id
          , timestamp(date(timestamp)) as rdg_date
          , timestamp as timestamp_utc
          , event_name
          , safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) as button_tag
          , safe_cast(json_extract_scalar( extra_json , "$.event_id") as string) as event_id
        from
          -- eraser-blast.tal_scratch.2024_09_17_tal_full_data_this_day
          eraser-blast.game_data.events
        where
          1=1
          and date(timestamp) between '2024-02-01' and '2024-09-18'
          and (
            ( event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Panel_ZoneHome.FlourFrenzy%'
            )
            or
            ( event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_PM_FlourFrenzy.Continue%'
            )
            or
            ( event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_ChangeName.Save%'
            )
            or
            ( event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_ChangeName.RandomizeName%'
            )
            or
            ( event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_CollectionEvent_Preview.StartFF%'
            )
            -- Sheet_Avatar.Save
            or
            ( event_name = 'ButtonClicked'
              and safe_cast(json_extract_scalar( extra_json , "$.button_tag") as string) like 'Sheet_Avatar.Save%'
            )
            or
            (
              event_name = 'SimpleEventJoin'
              and safe_cast(json_extract_scalar( extra_json , "$.event_id") as string) like 'ff%'
            )


          )
      )

      , lead_functions_table as (

        select
          *
          , lead(event_name) over (partition by rdg_id order by timestamp_utc ) as next_event_name
          , lead(timestamp_utc) over (partition by rdg_id order by timestamp_utc ) as next_timestamp_utc
        from
          base_data

      )

      select
        *
        , timestamp_diff(next_timestamp_utc, timestamp_utc, second) as seconds_to_join_event
      from
        lead_functions_table
      where
        event_name = 'ButtonClicked'
        and next_event_name = 'SimpleEventJoin'


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
  dimension: seconds_to_join_event {type: number}


################################################################
## Measures
################################################################

  measure: count_distinct_rdg_id {
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }

  measure: seconds_to_join_event_10 {
    group_label: "Time To Join Event (Seconds)"
    label: "10th Percentile"
    type: percentile
    percentile: 10
    sql: ${TABLE}.seconds_to_join_event ;;
  }
  measure: seconds_to_join_event_25 {
    group_label: "Time To Join Event (Seconds)"
    label: "25th Percentile"
    type: percentile
    percentile: 25
    sql: ${TABLE}.seconds_to_join_event ;;
  }
  measure: seconds_to_join_event_50 {
    group_label: "Time To Join Event (Seconds)"
    label: "Median"
    type: percentile
    percentile: 50
    sql: ${TABLE}.seconds_to_join_event ;;
  }
  measure: seconds_to_join_event_75 {
    group_label: "Time To Join Event (Seconds)"
    label: "75th Percentile"
    type: percentile
    percentile: 75
    sql: ${TABLE}.seconds_to_join_event ;;
  }

  measure: seconds_to_join_event_80 {
    group_label: "Time To Join Event (Seconds)"
    label: "80th Percentile"
    type: percentile
    percentile: 80
    sql: ${TABLE}.seconds_to_join_event ;;
  }

  measure: seconds_to_join_event_85 {
    group_label: "Time To Join Event (Seconds)"
    label: "85th Percentile"
    type: percentile
    percentile: 85
    sql: ${TABLE}.seconds_to_join_event ;;
  }

  measure: seconds_to_join_event_90 {
    group_label: "Time To Join Event (Seconds)"
    label: "90th Percentile"
    type: percentile
    percentile: 90
    sql: ${TABLE}.seconds_to_join_event ;;
  }

  measure: seconds_to_join_event_95 {
    group_label: "Time To Join Event (Seconds)"
    label: "95th Percentile"
    type: percentile
    percentile: 95
    sql: ${TABLE}.seconds_to_join_event ;;
  }

  measure: seconds_to_join_event_99 {
    group_label: "Time To Join Event (Seconds)"
    label: "99th Percentile"
    type: percentile
    percentile: 99
    sql: ${TABLE}.seconds_to_join_event ;;
  }

}
