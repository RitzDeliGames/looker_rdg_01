view: user_last_event {
# pulls the most recent event of the user to get current experiments, at the grain of the user
  view_label: "Users"
  derived_table: {
    sql:
      with last_user_event as (
        select
           user_id
          ,event_name
          ,last_ts
          ,rank() over (partition by user_id order by last_ts desc, event_name) rnk
        from (
          select
             rdg_id user_id
            ,event_name
            ,max(timestamp) last_ts
          from game_data.events
          where timestamp < timestamp(current_date())
          -- and timestamp >= timestamp(current_date() - 90)
          and rdg_id is not null
          and user_type = 'external'
          and rdg_id not in ('accf512f-6b54-4275-95dd-2b0dd7142e9e')
          group by 1,2
        ) x
      )
      select distinct
        last_user_event.user_id
        ,events.experiments
        ,lower(events.hardware) device_model_number
        ,last_unlocked_card
        ,current_card
      from last_user_event
      inner join game_data.events
        on last_user_event.user_id = events.rdg_id
        and last_user_event.last_ts = events.timestamp
        and last_user_event.event_name = events.event_name
        -- events.timestamp >= timestamp(current_date() - 90)
        and events.timestamp < timestamp(current_date())
        and events.user_type = 'external'
        and rdg_id not in ('accf512f-6b54-4275-95dd-2b0dd7142e9e')
      where last_user_event.rnk = 1
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
  }
  dimension: user_id {
    type: string
    sql: ${TABLE}.user_id ;;
    primary_key: yes
    hidden: yes
  }
  dimension: experiments {
    type: string
    sql: ${TABLE}.experiments ;;
    hidden: yes
  }
  dimension: device_model_number {
    hidden: yes
    type: string
    sql: ${TABLE}.device_model_number ;;
  }
  dimension: last_unlocked_card {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card"
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: last_unlocked_card_no {
    group_label: "Card Dimensions"
    label: "Player Last Unlocked Card (Numbered)"
    type: number
    value_format: "####"
    sql: @{last_unlocked_card_numbered};;
  }
  dimension: current_card {
    group_label: "Card Dimensions"
    label: "Player Current Card"
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: current_card_no {
    group_label: "Card Dimensions"
    label: "Player Current Card (Numbered)"
    type: number
    value_format: "####"
    sql: @{current_card_numbered};;
  }
  dimension: altCard002_9_20210528 {
    group_label: "Experiments"
    label: "Alt Card_002 / Tile 9 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_9_20210528'),'unassigned') ;;
  }
  dimension: altCard002_13_20210528 {
    group_label: "Experiments"
    label: "Alt Card_002 / Tile 13 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_13_20210528'),'unassigned') ;;
  }
  dimension: altCard002_18_20210528 {
    group_label: "Experiments"
    label: "Alt Card_002 / Tile 18 v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_18_20210528'),'unassigned') ;;
  }
  dimension: altCard002_a_8_20210525 {
    group_label: "Experiments"
    label: "Alt Card_002_a / Tile 8 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_a_8_20210525'),'unassigned') ;;
  }
  dimension: altCard002_a_18_20210525 {
    group_label: "Experiments"
    label: "Alt Card_002_a / Tile 18 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_a_18_20210525'),'unassigned') ;;
  }
  dimension: altCard003_a_18_20210525 {
    group_label: "Experiments"
    label: "Alt Card_003_a / Tile 18 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard003_a_18_20210525'),'unassigned') ;;
  }
  dimension: laterLinear_20210524 {
    group_label: "Experiments"
    label: "Later Linear v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.laterLinear_20210524'),'unassigned') ;;
  }
  dimension: worldMap_v2_20210413 {
    group_label: "Experiments"
    label: "World Map v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.worldMap_v2_20210413'),'unassigned') ;;
  }
  dimension: altCard003_b_20210517 {
    group_label: "Experiments"
    label: "Alt Card_003_b / Tile 9"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard003_b_20210517'),'unassigned') ;;
  }
  dimension: altCard002_20210517 {
    group_label: "Experiments"
    label: "Alt Card_002 / Tile 18 v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_20210517'),'unassigned') ;;
  }
  dimension: altCard021_20210506 {
    group_label: "Experiments"
    label: "Card_021 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard021_20210506'),'unassigned') ;;
  }
  dimension: altCard008_20210423 {
    group_label: "Experiments"
    label: "Alt Card_008"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard008_20210423'),'unassigned') ;;
  }
  dimension: altCard007_20210423 {
    group_label: "Experiments"
    label: "Alt Card_007"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard007_20210423'),'unassigned') ;;
  }
  dimension: altCard006_20210417 {
    group_label: "Experiments"
    label: "Alt Card_006"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard006_20210417'),'unassigned') ;;
  }
  dimension: altCard005_20210417 {
    group_label: "Experiments"
    label: "Alt Card_005"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard005_20210417'),'unassigned') ;;
  }
  dimension: altCard002_20210505 {
    group_label: "Experiments"
    label: "Alt Card_002 / Tile 18 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_20210505'),'unassigned') ;;
  }
  dimension: ask_for_help_v1 {
    group_label: "Experiments"
    label: "AskForHelp v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.askForHelp_20210112'),'unassigned') ;;
  }
  dimension: laterLinear_20210517 {
    group_label: "Experiments"
    label: "Later Linear v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.laterLinear_20210517'),'unassigned') ;;
  }
  dimension: laterFiveToFour_20210517 {
    group_label: "Experiments"
    label: "Later 4-to-5 v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.laterFiveToFour_20210517'),'unassigned') ;;
  }
  dimension: boostShop_20210420 {
    group_label: "Experiments"
    label: "Boost Shop UX v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.boostShop_20210420'),'unassigned') ;;
  }
  dimension: lowCostIAP_20210426 {
    group_label: "Experiments"
    label: "Low Cost IAP v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.lowCostIAP_20210426'),'unassigned') ;;
  }
  dimension: boostSurvey_20210420 {
    group_label: "Experiments"
    label: "Boost Survey v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.boostSurvey_20210420'),'unassigned') ;;
  }
  dimension: bingo_rewards_v2 {
    group_label: "Experiments"
    label: "Bingo Rewards v2 (Characters)"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.rewards_v2_20210417'),'unassigned') ;;
  }
  dimension: alt_card_003_v1 {
    group_label: "Experiments"
    label: "Alt Card_003 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard003_20210329'),'unassigned') ;;
  }
  dimension: alt_card_004_v1 {
    group_label: "Experiments"
    label: "Alt Card_004 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard004_20210329'),'unassigned') ;;
  }
  dimension: bingo_rewards_v1 {
    group_label: "Experiments"
    label: "Bingo Rewards v1 (Lives)"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.rewards_v1_20210415'),'unassigned') ;;
  }
  dimension: communityEvents_20200316 {
    group_label: "Experiments"
    label: "Community Event - 202106_a"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.communityEvents_20200316'),'unassigned') ;;
  }
  dimension: mini_game_ui_v1 {
    group_label: "Experiments"
    label: "Mini-Game UI v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.miniGame_v3_20210407'),'unassigned') ;;
  }
  dimension: early_exit3 {
    group_label: "Experiments"
    label: "Early Exit v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.earlyExitRedux_20210414'),'unassigned') ;;
  }
  dimension: rapid_progression_v1 {
    group_label: "Experiments"
    label: "Rapid Progression v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.rapidProgression_20200325'),'unassigned') ;;
  }
  dimension: disable_auto_select_v1 {
    group_label: "Experiments"
    label: "Disable Auto-Select v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.disableAutoSelect_20210330'),'unassigned') ;;
  }
  dimension: pre_game_v3 {
    group_label: "Experiments"
    label: "Pre-Game v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.v3PreGameScreen_20210316'),'unassigned') ;;
  }
  dimension: more_time_v3 {
    group_label: "Experiments"
    label: "More Time v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.moreTimeBingo_20210330'),'unassigned') ;;
  }
  dimension: more_time_v2 {
    group_label: "Experiments"
    label: "More Time v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.moreTimeBingo_20210322'),'unassigned') ;;
  }
  dimension: alt_407 {
    group_label: "Experiments"
    label: "Alt 407"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.card002_20210301'),'unassigned') ;;
  }
  dimension: alt_card4 {
    group_label: "Experiments"
    label: "Alt Card 4"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.card002_20210222'),'unassigned') ;;
  }
  dimension: new_ux_v4 {
    group_label: "Experiments"
    label: "New UX v4"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.newUX_20210223'),'unassigned') ;;
  }
  dimension: daily_rewards_v1 {
    group_label: "Experiments"
    label: "DailyRewards v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.dailyRewards_20210112'),'unassigned') ;;
  }
  dimension: daily_rewards_v2 { ## is this right?
    group_label: "Experiments"
    label: "DailyRewards v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.dailyRewards_20210302'),'unassigned') ;;
  }
  dimension: fue_story_v1 {
    group_label: "Experiments"
    label: "FUE/Story v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.fueStory_20210215'),'unassigned') ;;
  }
  dimension: storyFUE_v2_20210608 {
    group_label: "Experiments"
    label: "FUE/Story v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.storyFUE_v2_20210608'),'unassigned') ;;
  }
  dimension: skill_reminder_v2 {
    group_label: "Experiments"
    label: "SkillReminder v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.skillReminder_20200204'),'unassigned') ;;
  }
  dimension: new_ux2 {
    group_label: "Experiments"
    label: "NewUX2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.newVsOld_20210108'),'unassigned') ;;
  }
  dimension: new_ux {
    group_label: "Experiments"
    label: "NewUX"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.newVsOld_20201218'),'unassigned') ;;
  }
  dimension: transition_timing {
    group_label: "Experiments"
    label: "TransitionTiming"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.transitionDelay_20201217'),'unassigned') ;;
  }
  dimension: new_eor {
    group_label: "Experiments"
    label: "NewEoR"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.endOfRound_20201204'),'unassigned') ;;
  }
  dimension: world_map {
    group_label: "Experiments"
    label: "WorldMap"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.worldmap_20201028'),'unassigned') ;;
  }
  dimension: early_content3 {
    group_label: "Experiments"
    label: "EarlyContent3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.content_20201130'),'unassigned') ;;
  }
  dimension: later_linear {
    group_label: "Experiments"
    label: "LaterLinear"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.laterLinearTest_20201111'),'unassigned') ;;
  }
  dimension: early_content2 {
    group_label: "Experiments"
    label: "EarlyContent2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.content_20201106'),'unassigned') ;;
  }
  dimension: vfx_threshold {
    group_label: "Experiments"
    label: "VFXTreshold"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.vfx_threshold_20201102'),'unassigned') ;;
  }
  dimension: last_bonus {
    group_label: "Experiments"
    label: "LastBonus"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.last_bonus_20201105'),'unassigned') ;;
  }
  dimension: untimed_mode {
    group_label: "Experiments"
    label: "UntimedMode"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.untimed_20200918'),'unassigned') ;;
  }
  dimension: early_content {
    group_label: "Experiments"
    label: "EarlyContent"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.content_20201005'),'unassigned') ;;
  }
  dimension: seconds_per_found {
    group_label: "Experiments"
    label: "SecondsPerRound"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.secondsPerRound_20200922'),'unassigned') ;;
  }
  dimension: early_exit2 {
    group_label: "Experiments"
    label: "Early Exit v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.earlyExitContent_20200909'),'unassigned') ;;
  }
  dimension: early_exit {
    group_label: "Experiments"
    label: "Early Exit v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.earlyExit_20200828'),'unassigned') ;;
  }
  dimension: notifications {
    group_label: "Experiments"
    label: "Notifications"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.notifications_20200824'),'unassigned') ;;
  }
  dimension: lazy_load {
    group_label: "Experiments"
    label: "LazyLoad"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.lazyLoadOtherTabs_20200901'),'unassigned') ;;
  }
  dimension: fue_timing {
    group_label: "Experiments"
    label: "FUETiming"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.tabFueTiming_20200825'),'unassigned') ;;
  }
  dimension: easy_early_bingo_card_varients {
    group_label: "Experiments"
    label: "EasyEarlyBingoCardVariants"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.bingoEasyEarlyVariants_20200608'),'unassigned') ;;
  }
  dimension: low_performance_mode {
    group_label: "Experiments"
    label: "LowPerformanceMode"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.lowPerformanceMode_20200803'),'unassigned') ;;
  }
}
