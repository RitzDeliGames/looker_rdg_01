view: temp_in_app_messages {
  derived_table: {
    sql:
      select
        rdg_id
        ,event_name
        ,timestamp
        ,json_extract_scalar(extra_json,'$.campaign_id') campaign_id
        ,json_extract_scalar(extra_json,'$.campaign_name') campaign_name
        ,json_extract_scalar(extra_json,'$.template_id') template_id
        ,json_extract_scalar(extra_json,'$.ui_action') ui_action
        ,extra_json
      from `eraser-blast.game_data.events`
      where event_name = 'InAppMessaging'
      order by 1 desc;;
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${rdg_id} || ${event_name} || ${iam_raw} ;;
  }
  dimension: rdg_id {
    hidden: yes
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: event_name {
    hidden: yes
    type: string
    sql: ${TABLE}.event_name ;;
  }
  dimension_group: iam {
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
  dimension: campaign_id {}
  dimension: campaign_name {}
  dimension: template_id {}
  dimension: ui_action {}
  measure: iam_views {
    label: "Views"
    type: count_distinct
    sql: ${iam_raw} ;;
  }
  measure: iam_players {
    label: "Players"
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  dimension: iam_ui_actions { ##review...should this be flattened?
    sql: @{iam_ui_actions} ;;
  }
}
