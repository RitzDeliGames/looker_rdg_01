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
                 rdg_id rdg_id
                ,event_name
                ,max(timestamp) last_ts
              from game_data.events
              where timestamp < timestamp(current_date())
              -- and timestamp >= timestamp(current_date() - 90)
              and rdg_id is not null
              and user_type = 'external'
              group by 1,2
            ) x
          )
          select distinct
            last_user_event.rdg_id
            ,events.experiments
            ,lower(events.hardware) device_model_number
            ,last_unlocked_card
            ,current_card
            ,cast(current_quest as int64) current_quest
          from last_user_event
          inner join game_data.events
            on last_user_event.rdg_id = events.rdg_id
            and last_user_event.last_ts = events.timestamp
            and last_user_event.event_name = events.event_name
            -- events.timestamp >= timestamp(current_date() - 90)
            and events.timestamp < timestamp(current_date())
            and events.user_type = 'external'
          where last_user_event.rnk = 1
        ;;
    datagroup_trigger: change_3_hrs
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
  dimension: device_model_number {
    hidden: yes
    type: string
    sql: ${TABLE}.device_model_number ;;
  }
  dimension: last_unlocked_card {
    group_label: "Card Dimensions"
    label: "Last Unlocked Card"
    type: string
    sql: ${TABLE}.last_unlocked_card ;;
  }
  dimension: last_unlocked_card_no {
    group_label: "Card Dimensions"
    label: "Last Unlocked Card Numbered"
    type: number
    value_format: "####"
    sql: @{last_unlocked_card_numbered};;
  }
  dimension: current_card {
    group_label: "Card Dimensions"
    label: "Current Card"
    type: string
    sql: ${TABLE}.current_card ;;
  }
  dimension: current_quest {
    group_label: "Card Dimensions"
    label: "Current Quest"
    type: number
    sql: ${TABLE}.current_quest ;;
  }
  dimension: current_card_no {
    group_label: "Card Dimensions"
    label: "Current Card Numbered"
    type: number
    value_format: "####"
    sql: @{current_card_numbered};;
  }
  dimension: current_card_quest {
    group_label: "Card Dimensions"
    label: "Current Card + Quest"
    type: number
    value_format: "####"
    sql: ${current_card_no} + ${current_quest};;
  }


  ###EXPERIMENT IDS - LIVE###

  dimension: experiment_altCard_002_20210830   {
    group_label: "Experiments - Live"
    label: "Alt Card_002_20210830"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_20210830'),'unassigned') ;;
  }
  dimension: experiment_altCard_003_a_20210903   {
    group_label: "Experiments - Live"
    label: "Alt Card_003_a_20210903 ('title')"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_003_a_20210903'),'unassigned') ;;
  }
  dimension: experiment_altCard_003_20210329_08_20210901   {
    group_label: "Experiments - Live"
    label: "Alt Card_003_20210329 / Tile 8"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_003_20210329_08_20210901'),'unassigned') ;;
  }
  dimension: rewardPreview_20210817   {
    group_label: "Experiments - Live"
    label: "Reward Preview v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.rewardPreview_20210817'),'unassigned') ;;
  }
  dimension: fue_infinitelives_20210806   {
    group_label: "Experiments - Live"
    label: "Infinite Lives v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.fue_infinitelives_20210806'),'unassigned') ;;
  }
  dimension: autoselecteraser_20210803   {
    group_label: "Experiments - Live"
    label: "Auto-Select v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.autoselecteraser_20210803'),'unassigned') ;;
  }
  dimension: altRewards20210811   {
    group_label: "Experiments - Live"
    label: "Alt Rewards v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altRewards20210811'),'unassigned') ;;
  }
  dimension: gachatimers_20210815   {
    group_label: "Experiments - Live"
    label: "Gacha Timers"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.gachatimers_20210815'),'unassigned') ;;
  }

  ###EXPERIMENT IDS - CLOSED###
  dimension: featureunlocks_20210804   {
    group_label: "Experiments - Closed"
    label: "Store Unlock v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.featureunlocks_20210804'),'unassigned') ;;
  }
  dimension: teamups_20210824   {
    group_label: "Experiments - Closed"
    label: "TeamUps v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.teamups_20210824'),'unassigned') ;;
  }
  dimension: loseLifeOnPlay_20210810   {
    group_label: "Experiments - Closed"
    label: "Lose Life v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.loseLifeOnPlay_20210810'),'unassigned') ;;
  }
  dimension: experiment_altCard_002_a_20210810   {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_a / Tile 18 v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_a_20210810'),'unassigned') ;;
  }
  dimension: altCard_002_20210816   {
    group_label: "Experiments - Closed"
    label: "Alt Card_002 (Olympic Reqs)"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_20210816'),'unassigned') ;;
  }
  dimension: altCard_002_a_17_20210811   {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_a / Tile 17 v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_a_17_20210811'),'unassigned') ;;
  }
  dimension: altCard_003_a_7_20210811  {
    group_label: "Experiments - Closed"
    label: "Alt Card_003_a / Tile 7 v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_003_a_7_20210811'),'unassigned') ;;
  }
  dimension: altCard_003_20210329_07_20210728  {
    group_label: "Experiments - Closed"
    label: "Alt Card_003 / Tile 7 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_003_20210329_07_20210728'),'unassigned') ;;
  }
  dimension: altCard_003_20210329_08_20210728  {
    group_label: "Experiments - Closed"
    label: "Alt Card_003 / Tile 8 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_003_20210329_08_20210728'),'unassigned') ;;
  }
  dimension: altCard_003_20210329_09_20210728  {
    group_label: "Experiments - Closed"
    label: "Alt Card_003 / Tile 9 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_003_20210329_09_20210728'),'unassigned') ;;
  }
  dimension: iconSurvey_20210729  {
    group_label: "Experiments - Closed"
    label: "Icon Survey v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.iconSurvey_20210729'),'unassigned') ;;
  }
  dimension: altCard_002_open_20210727   {
    group_label: "Experiments - Closed"
    label: "Alt Card_002 (No Reqs)"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_open_20210727'),'unassigned') ;;
  }
  dimension: altCard_002_b_07_20210728 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_b / Tile 7 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_b_07_20210728'),'unassigned') ;;
  }
  dimension: altCard_002_b_08_20210728   {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_b / Tile 8 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_b_08_20210728'),'unassigned') ;;
  }
  dimension: altCard_002_a_07_20210728   {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_a / Tile 7 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_a_07_20210728'),'unassigned') ;;
  }
  dimension: altCard_002_a_08_20210728   {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_a / Tile 8 v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_a_08_20210728'),'unassigned') ;;
  }
  dimension: altCard_003_a_07_20210728 {
    group_label: "Experiments - Closed"
    label: "Alt Card_003_a / Tile 7 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_003_a_07_20210728'),'unassigned') ;;
  }
  dimension: altCard_003_a_17_20210727 {
    group_label: "Experiments - Closed"
    label: "Alt Card_003_a / Tile 17 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_003_a_17_20210727'),'unassigned') ;;
  }
  dimension: totd_iam_003_a_9 {
    group_label: "Experiments - Closed"
    label: "ToTD Card_003_a / Tile 9 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.totd_iam_003_a_9'),'unassigned') ;;
  }
  dimension: totd_iam_002_a_9 {
    group_label: "Experiments - Closed"
    label: "ToTD Card_002_a / Tile 9 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.totd_iam_002_a_9'),'unassigned') ;;
  }
  dimension: listViewTest_20210713 {
    group_label: "Experiments - Closed"
    label: "List View v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.listViewTest_20210713'),'unassigned') ;;
  }
  dimension: listViewTest_20210630 {
    group_label: "Experiments - Closed"
    label: "List View v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.listViewTest_20210630'),'unassigned') ;;
  }
  dimension: bouncingArrow_20210526 {
    group_label: "Experiments - Closed"
    label: "Bouncing Arrow v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.bouncingArrow_20210526'),'unassigned') ;;
  }
  dimension: altCard_002_20210702 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002 / Tile 9 & 17 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_20210702'),'unassigned') ;;
  }
  dimension: altCard_002_a_13_20210722 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_a / Tile 13 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_a_13_20210722'),'unassigned') ;;
  }
  dimension: altCard_002_a_17_20210722 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_a / Tile 17 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard_002_a_17_20210722'),'unassigned') ;;
  }
  dimension: altCard002_9_20210528 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002 / Tile 9 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_9_20210528'),'unassigned') ;;
  }
  dimension: altCard002_13_20210528 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002 / Tile 13 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_13_20210528'),'unassigned') ;;
  }
  dimension: altCard002_18_20210528 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002 / Tile 18 v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_18_20210528'),'unassigned') ;;
  }
  dimension: altCard002_a_8_20210525 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_a / Tile 8 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_a_8_20210525'),'unassigned') ;;
  }
  dimension: altCard002_a_18_20210525 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002_a / Tile 18 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_a_18_20210525'),'unassigned') ;;
  }
  dimension: altCard003_a_18_20210525 {
    group_label: "Experiments - Closed"
    label: "Alt Card_003_a / Tile 18 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard003_a_18_20210525'),'unassigned') ;;
  }
  dimension: laterLinear_20210524 {
    group_label: "Experiments - Closed"
    label: "Later Linear v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.laterLinear_20210524'),'unassigned') ;;
  }
  dimension: worldMap_v2_20210413 {
    group_label: "Experiments - Closed"
    label: "World Map v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.worldMap_v2_20210413'),'unassigned') ;;
  }
  dimension: altCard003_b_20210517 {
    group_label: "Experiments - Closed"
    label: "Alt Card_003_b / Tile 9"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard003_b_20210517'),'unassigned') ;;
  }
  dimension: altCard002_20210517 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002 / Tile 18 v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_20210517'),'unassigned') ;;
  }
  dimension: altCard021_20210506 {
    group_label: "Experiments - Closed"
    label: "Card_021 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard021_20210506'),'unassigned') ;;
  }
  dimension: altCard008_20210423 {
    group_label: "Experiments - Closed"
    label: "Alt Card_008"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard008_20210423'),'unassigned') ;;
  }
  dimension: altCard007_20210423 {
    group_label: "Experiments - Closed"
    label: "Alt Card_007"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard007_20210423'),'unassigned') ;;
  }
  dimension: altCard006_20210417 {
    group_label: "Experiments - Closed"
    label: "Alt Card_006"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard006_20210417'),'unassigned') ;;
  }
  dimension: altCard005_20210417 {
    group_label: "Experiments - Closed"
    label: "Alt Card_005"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard005_20210417'),'unassigned') ;;
  }
  dimension: altCard002_20210505 {
    group_label: "Experiments - Closed"
    label: "Alt Card_002 / Tile 18 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard002_20210505'),'unassigned') ;;
  }
  dimension: ask_for_help_v1 {
    group_label: "Experiments - Closed"
    label: "AskForHelp v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.askForHelp_20210112'),'unassigned') ;;
  }
  dimension: laterLinear_20210517 {
    group_label: "Experiments - Closed"
    label: "Later Linear v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.laterLinear_20210517'),'unassigned') ;;
  }
  dimension: laterFiveToFour_20210517 {
    group_label: "Experiments - Closed"
    label: "Later 4-to-5 v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.laterFiveToFour_20210517'),'unassigned') ;;
  }
  dimension: boostShop_20210420 {
    group_label: "Experiments - Closed"
    label: "Boost Shop UX v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.boostShop_20210420'),'unassigned') ;;
  }
  dimension: boostShop_20210604 {
    group_label: "Experiments - Closed"
    label: "Boost Shop UX v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.boostShop_20210604'),'unassigned') ;;
  }
  dimension: lowCostIAP_20210426 {
    group_label: "Experiments - Closed"
    label: "Low Cost IAP v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.lowCostIAP_20210426'),'unassigned') ;;
  }
  dimension: boostSurvey_20210420 {
    group_label: "Experiments - Closed"
    label: "Boost Survey v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.boostSurvey_20210420'),'unassigned') ;;
  }
  dimension: bingo_rewards_v2 {
    group_label: "Experiments - Closed"
    label: "Bingo Rewards v2 (Characters)"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.rewards_v2_20210417'),'unassigned') ;;
  }
  dimension: alt_card_003_v1 {
    group_label: "Experiments - Closed"
    label: "Alt Card_003 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard003_20210329'),'unassigned') ;;
  }
  dimension: alt_card_004_v1 {
    group_label: "Experiments - Closed"
    label: "Alt Card_004 v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altCard004_20210329'),'unassigned') ;;
  }
  dimension: bingo_rewards_v1 {
    group_label: "Experiments - Closed"
    label: "Bingo Rewards v1 (Lives)"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.rewards_v1_20210415'),'unassigned') ;;
  }
  dimension: communityEvents_20200316 {
    group_label: "Experiments - Closed"
    label: "Community Event - 202106_a"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.communityEvents_20200316'),'unassigned') ;;
  }
  dimension: mini_game_ui_v1 {
    group_label: "Experiments - Closed"
    label: "Mini-Game UI v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.miniGame_v3_20210407'),'unassigned') ;;
  }
  dimension: early_exit3 {
    group_label: "Experiments - Closed"
    label: "Early Exit v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.earlyExitRedux_20210414'),'unassigned') ;;
  }
  dimension: rapid_progression_v1 {
    group_label: "Experiments - Closed"
    label: "Rapid Progression v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.rapidProgression_20200325'),'unassigned') ;;
  }
  dimension: disable_auto_select_v1 {
    group_label: "Experiments - Closed"
    label: "Disable Auto-Select v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.disableAutoSelect_20210330'),'unassigned') ;;
  }
  dimension: pre_game_v3 {
    group_label: "Experiments - Closed"
    label: "Pre-Game v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.v3PreGameScreen_20210316'),'unassigned') ;;
  }
  dimension: more_time_v3 {
    group_label: "Experiments - Closed"
    label: "More Time v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.moreTimeBingo_20210330'),'unassigned') ;;
  }
  dimension: more_time_v2 {
    group_label: "Experiments - Closed"
    label: "More Time v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.moreTimeBingo_20210322'),'unassigned') ;;
  }
  dimension: alt_407 {
    group_label: "Experiments - Closed"
    label: "Alt 407"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.card002_20210301'),'unassigned') ;;
  }
  dimension: alt_card4 {
    group_label: "Experiments - Closed"
    label: "Alt Card 4"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.card002_20210222'),'unassigned') ;;
  }
  dimension: new_ux_v4 {
    group_label: "Experiments - Closed"
    label: "New UX v4"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.newUX_20210223'),'unassigned') ;;
  }
  dimension: daily_rewards_v1 {
    group_label: "Experiments - Closed"
    label: "DailyRewards v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.dailyRewards_20210112'),'unassigned') ;;
  }
  dimension: daily_rewards_v2 { ## is this right?
    group_label: "Experiments - Closed"
    label: "DailyRewards v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.dailyRewards_20210302'),'unassigned') ;;
  }
  dimension: fue_story_v1 {
    group_label: "Experiments - Closed"
    label: "FUE/Story v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.fueStory_20210215'),'unassigned') ;;
  }
  dimension: storyFUE_v2_20210608 {
    group_label: "Experiments - Closed"
    label: "FUE/Story v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.storyFUE_v2_20210608'),'unassigned') ;;
  }
  dimension: altStory_20210705   {
    group_label: "Experiments - Closed"
    label: "FUE/Story v3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.altStory_20210705'),'unassigned') ;;
  }
  dimension: skill_reminder_v2 {
    group_label: "Experiments - Closed"
    label: "SkillReminder v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.skillReminder_20200204'),'unassigned') ;;
  }
  dimension: new_ux2 {
    group_label: "Experiments - Closed"
    label: "NewUX2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.newVsOld_20210108'),'unassigned') ;;
  }
  dimension: new_ux {
    group_label: "Experiments - Closed"
    label: "NewUX"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.newVsOld_20201218'),'unassigned') ;;
  }
  dimension: transition_timing {
    group_label: "Experiments - Closed"
    label: "TransitionTiming"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.transitionDelay_20201217'),'unassigned') ;;
  }
  dimension: new_eor {
    group_label: "Experiments - Closed"
    label: "NewEoR"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.endOfRound_20201204'),'unassigned') ;;
  }
  dimension: world_map {
    group_label: "Experiments - Closed"
    label: "WorldMap"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.worldmap_20201028'),'unassigned') ;;
  }
  dimension: early_content3 {
    group_label: "Experiments - Closed"
    label: "EarlyContent3"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.content_20201130'),'unassigned') ;;
  }
  dimension: later_linear {
    group_label: "Experiments - Closed"
    label: "LaterLinear"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.laterLinearTest_20201111'),'unassigned') ;;
  }
  dimension: early_content2 {
    group_label: "Experiments - Closed"
    label: "EarlyContent2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.content_20201106'),'unassigned') ;;
  }
  dimension: vfx_threshold {
    group_label: "Experiments - Closed"
    label: "VFXTreshold"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.vfx_threshold_20201102'),'unassigned') ;;
  }
  dimension: last_bonus {
    group_label: "Experiments - Closed"
    label: "LastBonus"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.last_bonus_20201105'),'unassigned') ;;
  }
  dimension: untimed_mode {
    group_label: "Experiments - Closed"
    label: "UntimedMode"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.untimed_20200918'),'unassigned') ;;
  }
  dimension: early_content {
    group_label: "Experiments - Closed"
    label: "EarlyContent"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.content_20201005'),'unassigned') ;;
  }
  dimension: seconds_per_found {
    group_label: "Experiments - Closed"
    label: "SecondsPerRound"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.secondsPerRound_20200922'),'unassigned') ;;
  }
  dimension: early_exit2 {
    group_label: "Experiments - Closed"
    label: "Early Exit v2"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.earlyExitContent_20200909'),'unassigned') ;;
  }
  dimension: early_exit {
    group_label: "Experiments - Closed"
    label: "Early Exit v1"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.earlyExit_20200828'),'unassigned') ;;
  }
  dimension: notifications {
    group_label: "Experiments - Closed"
    label: "Notifications"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.notifications_20200824'),'unassigned') ;;
  }
  dimension: lazy_load {
    group_label: "Experiments - Closed"
    label: "LazyLoad"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.lazyLoadOtherTabs_20200901'),'unassigned') ;;
  }
  dimension: fue_timing {
    group_label: "Experiments - Closed"
    label: "FUETiming"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.tabFueTiming_20200825'),'unassigned') ;;
  }
  dimension: easy_early_bingo_card_varients {
    group_label: "Experiments - Closed"
    label: "EasyEarlyBingoCardVariants"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.bingoEasyEarlyVariants_20200608'),'unassigned') ;;
  }
  dimension: low_performance_mode {
    group_label: "Experiments - Closed"
    label: "LowPerformanceMode"
    type: string
    sql: nullif(json_extract_scalar(${experiments},'$.lowPerformanceMode_20200803'),'unassigned') ;;
  }
}
