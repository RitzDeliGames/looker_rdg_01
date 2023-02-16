view: click_stream {
  derived_table: {
    sql:
      select
        rdg_id
        ,country
        ,install_version
        ,timestamp
        ,event_name
        ,engagement_ticks
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_02") as numeric) currency_02_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_05") as numeric) currency_05_balance
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,"$.button_tag") button_tag
        ,experiments
        ,extra_json
        ,last_level_id
        ,lag(timestamp)
            over (partition by rdg_id order by timestamp desc) greater_level_completed
      from `eraser-blast.game_data.events`
      where event_name = 'ButtonClicked'
        and date(timestamp) between '2022-06-01' and current_date()
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
      ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes

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
    hidden: no
  }
  dimension: country {
    group_label: "Device & OS Dimensions"
    label: "Device Country"
    type: string
  }
  dimension: region {
    group_label: "Device & OS Dimensions"
    label: "Device Region"
    type: string
    sql: @{country_region} ;;
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,week
      ,year
    ]
  }
  dimension: greater_level_completed {}
  dimension: is_churned {
    type: yesno
    sql: ${greater_level_completed} is null ;;
  }
  dimension: install_version {}
  dimension: event_name {}
  dimension: engagement_ticks {
    type: number
    sql: ${TABLE}.engagement_ticks ;;
  }
  dimension: engagement_minutes {
    type: number
    sql: ${TABLE}.engagement_ticks / 2 ;;
  }
  dimension: currency_02_balance {
    group_label: "Currencies"
    label: "Gems"
    type: number
  }
  dimension: currency_03_balance {
    group_label: "Currencies"
    label: "Coins"
    type: number
  }
  dimension: currency_04_balance {
    group_label: "Currencies"
    label: "Lives"
    type: number
  }
  dimension:  currency_04_balance_tiers {
    group_label: "Currencies"
    label: "Lives Tiers"
    tiers: [0,1,2,3,4,5]
    style: integer
    sql: ${currency_04_balance} ;;
  }
  dimension: currency_05_balance {
    group_label: "Currencies"
    label: "AFH Tokens"
    type: number
  }
  measure: engagement_minutes_med {
    label: "Engagement Minutes - Median"
    type: median
    sql:  ${engagement_minutes};;
  }
  dimension: last_level_id {
    label: "Last Level - Id"
  }
  dimension: last_level_serial {
    label: "Last Level"
    type: number
    sql: ${TABLE}.last_level_serial ;;
  }
  dimension: extra_json {
    hidden: yes
  }
  dimension: button_tag_raw {
    sql: ${TABLE}.button_tag ;;
  }
  dimension: button_tag {
    sql: @{button_tags} ;;
  }
  parameter: player_button_tag_filter {
    label: "Player Count Button Tag Filter"
    suggest_dimension: button_tag
  }
  measure: player_count {
    label: "Player Count"
    type: count_distinct
    sql: ${rdg_id};;
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  measure: filtered_player_count {
    label: "Player Count (Filtered)"
    type: count_distinct
    sql:
        case
          when
            {% condition player_button_tag_filter %} ${button_tag} {% endcondition %}
          then ${rdg_id}
        end
      ;;
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  measure: button_clicks {
    label: "Click Count"
    type: count
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  measure: filtered_click_count {
    label: "Click Count (Filtered)"
    type: count_distinct
    sql:
        case
          when
            {% condition player_button_tag_filter %} ${button_tag} {% endcondition %}
          then ${primary_key}
        end
      ;;
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  dimension: experiments {
    type: string
    sql: ${TABLE}.experiments ;;
    hidden: no
  }
  parameter: experiment_id {
    type: string
    suggestions:  ["$.altFUE2_20221011"
      ,"$.altFUE2v2_20221024"
      ,"$.autoPurchase_20221017"
      ,"$.blockSymbols_20221017"
      ,"$.collection_01192023"
      ,"$.difficultyStars_09202022"
      ,"$.dynamicRewards_20221018"
      ,"$.extraMovesCurrency_20221017"
      ,"$.fueDismiss_20221010"
      ,"$.gridGravity_20221003"
      ,"$.gridGravity2_20221012"
      ,"$.livesTimer_01092023"
      ,"$.mMStreaks_09302022"
      ,"$.newLevelPass_20220926"
      ,"$.vfxReduce_20221017"
      ,"$.vfxReduce_2_20221024"
      ,"$.zoneOrder2_09302022"
      ,"$.zoneStarCosts_09222022"]
  }
  dimension: experiment_variant {
    label: "Experiment Variant"
    type: string
    suggestions: ["control"
      ,"variant_a"
      ,"variant_b"
      ,"variant_c"
      ,"variant_d"]
    # sql: json_extract_scalar(${experiments},{% parameter experiment_id %}) ;;
    sql: json_extract_scalar(${experiments},"$.altFUE2v2_20221024") ;;
  }
}
