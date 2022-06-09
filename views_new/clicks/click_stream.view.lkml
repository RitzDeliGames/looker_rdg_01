view: click_stream {
  derived_table: {
    sql:
      select
        rdg_id
        ,install_version
        ,timestamp
        ,event_name
        ,engagement_ticks
        ,current_card
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_02") as numeric) currency_02_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_05") as numeric) currency_05_balance
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,cast(quests_completed as int64) quests_completed
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,"$.button_tag") button_tag
        ,experiments
        ,extra_json
        ,lag(timestamp)
            over (partition by rdg_id order by timestamp desc) greater_quests_completed
      from `eraser-blast.game_data.events`
      where
        event_name = 'ButtonClicked'
        and timestamp >= '2019-01-01'
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17
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
    hidden: no
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
  dimension: greater_quests_completed {}#RENAME!!!
  dimension: is_churned {
    type: yesno
    sql: ${greater_quests_completed} is null ;;
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
  dimension: current_card {
    group_label: "Card Dimensions"
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: current_card_numbered {
    group_label: "Card Dimensions"
    type: number
    sql: @{current_card_numbered} ;;
    value_format: "####"
  }
  dimension: card_id {
    group_label: "Card Dimensions"
    type: string
    sql: coalesce(${last_unlocked_card},${current_card}) ;;
  }
  dimension: current_card_quest {
    group_label: "Card Dimensions"
    label: "Current Card + Quest"
    type: number
    sql: ${current_card_numbered} + ${current_quest};;
    value_format: "####"
  }
  dimension: last_unlocked_card {
    group_label: "Card Dimensions"
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: last_unlocked_card_numbered {
    group_label: "Card Dimensions"
    type: number
    sql: @{last_unlocked_card_numbered} ;;
    value_format: "####"
  }
  dimension: current_quest {
    group_label: "Card Dimensions"
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: quests_completed {
    type: number
    sql: ${TABLE}.quests_completed ;;
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
  measure: player_count {
    label: "Count of Players"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  # dimension: click_count {}
  measure: button_clicks {
    label: "Count of Clicks"
    type: count
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  dimension: worldMap_20211007_p4   {
    group_label: "Experiments - Closed"
    label: "World Map v4"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.worldMap_20211007_p4'),'unassigned') ;;
  }
  dimension: characterUnlockSequence_20211005_p3   {
    group_label: "Experiments - Closed"
    label: "Character Unlock Sequence v3"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.characterUnlockSequence_20211005_p3'),'unassigned') ;;
  }
  dimension: listViewTest_20211027_v3   {
    group_label: "Experiments - Closed"
    label: "List View v3"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.listViewTest_20211027_v3'),'unassigned') ;;
  }
  dimension: storySkip_20211031   {
    group_label: "Experiments - Closed"
    label: "Story - Skip v1"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.StorySkip_20211031'),'unassigned') ;;
  }
  dimension: altPacing_20211123   {
    group_label: "Experiments - Closed"
    label: "Early Game Pacing - v1"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.altPacing_20211123'),'unassigned') ;;
  }
  dimension: gridMode_20211213   {
    group_label: "Experiments - Closed"
    label: "Grid Mode - v1"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.gridMode_20211213'),'unassigned') ;;
  }
  dimension: directPlay_20211202   {
    group_label: "Experiments - Closed"
    label: "Direct Play - v1"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.directPlay_20211202'),'unassigned') ;;
  }
  dimension: zones_20220316   {
    group_label: "Experiments - Closed"
    label: "Zones v1"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.zones_20220316'),'unassigned') ;;
  }
  dimension: zones_20220329   {
    group_label: "Experiments - Closed"
    label: "Zones v2"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.zones_20220329'),'unassigned') ;;
  }
  dimension: fullminigame_20220427   {
    group_label: "Experiments - Closed"
    label: "Minigame v1"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.fullminigame_20220427'),'unassigned') ;;
  }
  dimension: fullminigame_20220517   {
    group_label: "Experiments - Live"
    label: "Minigame v2"
    type: string
    sql: nullif(json_extract_scalar(${TABLE}.experiments,'$.fullminigame_20220517'),'unassigned') ;;
  }
}
