view: user_last_event {
  # pulls the most recent event of the user to get current experiments, at the grain of the user
  view_label: "Users"
  derived_table: {
    sql:
          with last_user_event as (
            select
               rdg_id
              ,event_name
              ,last_ts
              ,rank() over (partition by rdg_id order by last_ts desc, event_name) rnk
            from (
              select
                 rdg_id
                ,event_name
                ,max(timestamp) last_ts
              from game_data.events
              where date(timestamp) between '2022-06-01'and current_date()
                and rdg_id is not null
                and user_type = 'external'
              group by 1,2
            ) x
          )
          select distinct
            last_user_event.rdg_id
            ,events.experiments
            ,last_level_id
            ,cast(last_level_serial as int64) last_level_serial
          from last_user_event
          inner join game_data.events
            on last_user_event.rdg_id = events.rdg_id
            and last_user_event.last_ts = events.timestamp
            and last_user_event.event_name = events.event_name
            and date(events.timestamp) between '2022-06-01'and current_date()
            and events.user_type = 'external'
          where last_user_event.rnk = 1
        ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    primary_key: yes
    hidden: yes
  }
  dimension: experiments {
    type: string
    sql: ${TABLE}.experiments ;;
    hidden: yes
  }
  parameter: experiment {
    type: string
    suggestions:  ["$.altFUE2_20221011"
                  ,"$.altFUE2v2_20221024"
                  ,"$.altFUE2v3_20221031"
                  ,"$.autoPurchase_20221017"
                  ,"$.blockSymbols_20221017"
                  ,"$.blockSymbolFrames_20221027"
                  ,"$.blockSymbolFrames2_20221109"
                  ,"$.difficultyStars_09202022"
                  ,"$.dynamicRewards_20221018"
                  ,"$.extraMovesCurrency_20221017"
                  ,"$.fueDismiss_20221010"
                  ,"$.gridGravity_20221003"
                  ,"$.gridGravity2_20221012"
                  ,"$.mMStreaks_09302022"
                  ,"$.mMStreaksv2_20221031"
                  ,"$.newLevelPass_20220926"
                  ,"$.seedTest_20221028"
                  ,"$.storeUnlock_20221102"
                  ,"$.treasureTrove_20221114"
                  ,"$.vfxReduce_20221017"
                  ,"$.vfxReduce_2_20221024"
                  ,"$.zoneOrder2_09302022"
                  ,"$.zoneStarCosts_09222022"]
  }
  dimension: experiment_id {
    label: "Experiment Variant"
    type: string
    suggestions: ["control"
      ,"variant_a"
      ,"variant_b"
      ,"variant_c"
      ,"variant_d"]
    sql: json_extract_scalar(${experiments},{% parameter experiment %}) ;;
  }
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
  }

  ###EXPERIMENT IDS - LIVE###
  dimension: newLevelPass_20220926   {
    group_label: "Experiments - Live"
    label: "New Level Pass v4"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.newLevelPass_20220926'),'unassigned') ;;
  }
  dimension: mMStreaks_09302022   {
    group_label: "Experiments - Live"
    label: "Moves Master v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.mMStreaks_09302022'),'unassigned') ;;
  }
  dimension: movesMaster_09202022   {
    group_label: "Experiments - Closed"
    label: "Moves Master v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.movesMaster_09202022'),'unassigned') ;;
  }
  dimension: difficultyStars_09202022   {
    group_label: "Experiments - Live"
    label: "Star Payout v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.difficultyStars_09202022'),'unassigned') ;;
  }
}
