# If necessary, uncomment the line below to include explore_source.
# include: "ritz_deli_games.model.lkml"

view: click_sequence {
  derived_table: {
    explore_source: click_stream {
      column: button_tag {}
      column: button_tag_raw {}
      column: event_time {}
      column: card_id {}
      column: current_card_numbered {}
      column: current_card {}
      column: current_card_quest {}
      column: current_quest {}
      column: engagement_minutes {}
      column: engagement_ticks {}
      column: last_unlocked_card {}
      column: last_unlocked_card_numbered {}
      column: quests_completed {}
      column: rdg_id {}
      column: is_churned {}
      column: install_version {}
      column: worldMap_20211007_p4 {}
      column: characterUnlockSequence_20211005_p3 {}
      column: listViewTest_20211027_v3 {}
      column: storySkip_20211031 {}
      column: altPacing_20211123 {}
      column: gridMode_20211213 {}
      column: directPlay_20211202 {}
      column: zones_20220316 {}
      column: zones_20220329 {}
      column: fullminigame_20220427 {}
      derived_column: click_sequence_num {
        sql: row_number() over (partition by rdg_id order by event_time) ;;
      }
    }
    datagroup_trigger: change_at_midnight
  }
  dimension: button_tag {
  }
  dimension: button_tag_raw {}
  dimension: event_time {
    type: date_time
  }
  dimension: card_id {}
  dimension: click_sequence_num {
    type: number
  }
  dimension: current_card_numbered {
    value_format: "####"
    type: number
  }
  dimension: current_card {}
  dimension: current_card_quest {
    value_format: "####"
    type: number
  }
  dimension: current_quest {
    type: number
  }
  dimension: engagement_minutes {
    type: number
  }
  dimension: engagement_ticks {
    type: number
  }
  dimension: last_unlocked_card {}
  dimension: last_unlocked_card_numbered {
    value_format: "####"
    type: number
  }
  dimension: quests_completed {
    type: number
  }
  dimension: rdg_id {}
  dimension: is_churned {
    label: "Click Stream Testing Is Churned (Yes / No)"
    type: yesno
  }
  dimension: install_version {}
  dimension: worldMap_20211007_p4 {
    group_label: "Experiments - Closed"
    label: "World Map v4"
  }
  dimension: characterUnlockSequence_20211005_p3 {
    group_label: "Experiments - Closed"
    label: "Character Unlock Sequence"
  }
  dimension: listViewTest_20211027_v3 {
    group_label: "Experiments - Closed"
    label: "List View v3"
  }
  dimension: storySkip_20211031 {
    group_label: "Experiments - Closed"
    label: "Story - Skip v1"
  }
  dimension: altPacing_20211123   {
    group_label: "Experiments - Closed"
    label: "Early Game Pacing - v1"
  }
  dimension: gridMode_20211213   {
    group_label: "Experiments - Closed"
    label: "Grid Mode - v1"
  }
  dimension: directPlay_20211202   {
    group_label: "Experiments - Closed"
    label: "Direct Play - v1"
  }
  dimension: zones_20220316   {
    group_label: "Experiments - Closed"
    label: "Zones v1"
  }
  dimension: zones_20220329   {
    group_label: "Experiments - Closed"
    label: "Zones v2"
  }
  dimension: fullminigame_20220427 {
    group_label: "Experiments - Closed"
    label: "Minigame v1"
  }
  dimension: fullminigame_20220517 {
    group_label: "Experiments - Live"
    label: "Minigame v2"
  }
  measure: count {
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [
      rdg_id,
      button_tag,
      button_tag_raw,
      event_time]
  }
}
