view: new_iam {
  derived_table: {
    sql:
      select
        rdg_id
        ,timestamp
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,'$.campaign_id') campaign_id
        ,json_extract_scalar(extra_json,'$.campaign_name') campaign_name
        ,json_extract_scalar(extra_json,'$.template_id') template_id
        ,json_extract_scalar(extra_json,'$.ui_action') ui_action
        ,extra_json
      from game_data.events
      where event_name = 'InAppMessaging'
        and timestamp >= '2022-06-01'
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_8_hrs
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
      ,time
      ,date
      ,month
      ,year
    ]
  }
  dimension: extra_json {
    hidden: yes
  }
  dimension: last_level_serial {
    label: "Last Level Played"
    type: number
    sql: ${TABLE}.last_level_serial ;;
  }
  dimension: campaign_id {}
  dimension: campaign_name {}
  dimension: ui_action {
    hidden: no
  }
  dimension: iam_ui_actions {
    label: "IAM Actions"
    sql: @{iam_ui_actions} ;;
  }
  measure: players {
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  measure: views {
    type: count_distinct
    sql: ${event_raw} ;;
  }

}
