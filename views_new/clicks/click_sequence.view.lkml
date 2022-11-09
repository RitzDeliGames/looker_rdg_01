# If necessary, uncomment the line below to include explore_source.
# include: "ritz_deli_games.model.lkml"

view: click_sequence {
  derived_table: {
    explore_source: click_stream {
      column: button_tag {}
      column: button_tag_raw {}
      column: country {}
      column: event_time {}
      column: last_level_serial {}
      column: last_level_id {}
      column: engagement_minutes {}
      column: engagement_ticks {}
      column: rdg_id {}
      column: is_churned {}
      column: install_version {}
      column: experiments {}
      column: experiment_variant {}
      derived_column: click_sequence_num {
        sql: row_number() over (partition by rdg_id order by event_time) ;;
      }
    }
    datagroup_trigger: change_6_hrs
  }
  dimension: button_tag {}
  dimension: button_tag_raw {}
  dimension: event_time {
    type: date_time
  }
  dimension: click_sequence_num {
    type: number
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
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
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
      ,"$.difficultyStars_09202022"
      ,"$.dynamicRewards_20221018"
      ,"$.extraMovesCurrency_20221017"
      ,"$.fueDismiss_20221010"
      ,"$.gridGravity_20221003"
      ,"$.gridGravity2_20221012"
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
    sql: json_extract_scalar(${experiments},{% parameter experiment_id %}) ;;
  }
}
