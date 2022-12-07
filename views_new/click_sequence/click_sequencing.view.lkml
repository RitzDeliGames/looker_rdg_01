# If necessary, uncomment the line below to include explore_source.
# include: "ritz_deli_games.model.lkml"

# Purpose: Places events from the click_stream in chronological order by player (rdg_id)

view: click_sequencing {
  derived_table: {
    explore_source: click_stream {
      column: button_tag {}
      column: button_tag_raw {}
      column: event_time {}
      column: last_level_serial {}
      column: engagement_minutes {}
      column: engagement_ticks {}
      column: rdg_id {}
      column: is_churned {}
      column: install_version {}
      derived_column: click_sequence_num {
        sql: row_number() over (partition by rdg_id order by event_time) ;;
      }
    }
    datagroup_trigger: change_6_hrs
  }

  dimension: click_sequence_num {
    type: number
  }
  dimension: button_tag {
    type: string
    description: "Normalized version of button_tag_raw, identifies the specific button pressed in game"
  }
  dimension: button_tag_raw {
    type: string
    description: "Specific button that was pressed in game"
  }
  dimension: event_time {
    type: date_time
  }
  dimension: last_level_serial {
    type: number
  }
  dimension: engagement_minutes {
    type: number
  }
  dimension: engagement_ticks {
    type: number
  }
  dimension: rdg_id {}
  dimension: is_churned {
    label: "Click Stream Testing Is Churned (Yes / No)"
    type: yesno
  }
  dimension: install_version {}
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
