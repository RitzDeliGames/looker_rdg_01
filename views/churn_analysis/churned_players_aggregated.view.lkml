view: churned_players_aggregated {
  derived_table: {
    sql: WITH churned_players AS (SELECT
        events.user_id  AS user_id,
        events.extra_json  AS extra_json,
        events.current_card  AS current_card,
        events.experiments  AS experiments,
        events.event_name  AS event_name,
        events.engagement_ticks  AS engagement_ticks,
        events.created_at  AS user_first_seen,
        events.install_version AS install_version,
        events.consecutive_days  AS consecutive_days,
        (CASE
          WHEN events.current_card = 'card_001_a' THEN 100
          WHEN events.current_card = 'card_001_untimed' THEN 100
          WHEN events.current_card = 'card_002_a' THEN 200
          WHEN events.current_card = 'card_002_untimed' THEN 200
          WHEN events.current_card = 'card_003_a' THEN 300
          WHEN events.current_card = 'card_003_untimed' THEN 300
          WHEN events.current_card = 'card_002' THEN 400
          WHEN events.current_card = 'card_039' THEN 400
          WHEN events.current_card = 'card_004_untimed' THEN 400
          WHEN events.current_card = 'card_003' THEN 500
          WHEN events.current_card = 'card_040' THEN 500
          WHEN events.current_card = 'card_005_untimed' THEN 500
          WHEN events.current_card = 'card_004' THEN 600
          WHEN events.current_card = 'card_041' THEN 600
          WHEN events.current_card = 'card_006_untimed' THEN 600
          WHEN events.current_card = 'card_005' THEN 700
          WHEN events.current_card = 'card_006' THEN 800
          WHEN events.current_card = 'card_007' THEN 900
          WHEN events.current_card = 'card_008' THEN 1000
          WHEN events.current_card = 'card_009' THEN 1100
          WHEN events.current_card = 'card_010' THEN 1200
          WHEN events.current_card = 'card_011' THEN 1300
          WHEN events.current_card = 'card_012' THEN 1400
          WHEN events.current_card = 'card_013' THEN 1500
          WHEN events.current_card = 'card_014' THEN 1600
          WHEN events.current_card = 'card_015' THEN 1700
          WHEN events.current_card = 'card_016' THEN 1800
          WHEN events.current_card = 'card_017' THEN 1900
          WHEN events.current_card = 'card_018' THEN 2000
      END) + (CAST(REPLACE(JSON_VALUE(events.extra_json,'$.current_quest'),'"','') AS NUMERIC)) AS current_card_quest,
        CASE
          WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
          WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
          WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
          WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
          WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
          WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
          WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
          WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
          WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
          WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
          WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
          WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
          WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
          WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
          WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
          WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
          WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
          WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
          WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
        END  AS experiment_names,
        REPLACE(CASE
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'NewUX' THEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'TransitionTiming' THEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'WorldMap' THEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'NewEoR' THEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'EarlyContent3' THEN JSON_EXTRACT(events.experiments,'$.content_20201130')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'LaterLinear' THEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'EarlyContent2' THEN JSON_EXTRACT(events.experiments,'$.content_20201106')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'VFXTreshold' THEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'LastBonus' THEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'UntimedMode' THEN JSON_EXTRACT(events.experiments,'$.untimed_20200918')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'EarlyContent' THEN JSON_EXTRACT(events.experiments,'$.content_20201005')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'SecondsPerRound' THEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'EarlyExit2' THEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'EarlyExit' THEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'Notifications' THEN JSON_EXTRACT(events.experiments,'$.notifications_20200824')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'LazyLoad' THEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'FUETiming' THEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'EasyEarlyBingoCardVariants' THEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
                  WHEN JSON_EXTRACT(events.experiments,'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
                  WHEN JSON_EXTRACT(events.experiments,'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
                  WHEN JSON_EXTRACT(events.experiments,'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
                  WHEN JSON_EXTRACT(events.experiments,'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
                  WHEN JSON_EXTRACT(events.experiments,'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
                  WHEN JSON_EXTRACT(events.experiments,'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                END) = 'LowPerformanceMode' THEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803')
                END,'"','')  AS variants,
        CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) AS round_id
      FROM `eraser-blast.game_data.events` AS events
      WHERE created_at  >= TIMESTAMP('2020-07-06 00:00:00')
          AND user_type = "external"
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11)
      SELECT
        churned_players.user_id AS churned_players_user_id,
        churned_players.experiment_names AS churned_players_experiment_names,
        churned_players.variants AS churned_players_variants,
        churned_players.install_version AS install_version,
        MAX(churned_players.current_card_quest) AS churned_players_max_current_card_quest,
        MAX(churned_players.engagement_ticks) AS churned_players_max_engagement_ticks,
        MAX((CAST(JSON_EXTRACT_SCALAR(extra_json,"$.rounds") AS INT64) - CAST(ARRAY_LENGTH(JSON_EXTRACT_ARRAY(extra_json,"$.card_state")) AS INT64)) ) AS churned_players_max_failed_attempts,
        COUNT((JSON_EXTRACT_SCALAR(extra_json,"$.button_tag")))  AS churned_players_click_count,
        AVG((CAST(JSON_EXTRACT_SCALAR(extra_json,"$.load_time") AS INT64)) / 1000) AS churned_players_avg_load_time
      FROM churned_players
      GROUP BY 1,2,3,4
      HAVING (MAX(churned_players.consecutive_days) = 0)
      ORDER BY 3 DESC
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_of_players {
    type: count_distinct
    sql: ${TABLE}.churned_players_user_id ;;
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.churned_players_user_id ;;
  }

  dimension: experiment_names {
    type: string
    sql: ${TABLE}.churned_players_experiment_names ;;
  }

  dimension: variants {
    type: string
    sql: ${TABLE}.churned_players_variants ;;
  }

  dimension: max_current_card_quest {
    type: number
    value_format: "####"
    sql: ${TABLE}.churned_players_max_current_card_quest ;;
  }

  dimension: max_current_card_quest_str {
    type: string
    sql: ${max_current_card_quest} ;;
  }

  dimension: max_engagement_ticks {
    type: number
    value_format: "####"
    sql: ${TABLE}.churned_players_max_engagement_ticks ;;
  }

  dimension: max_failed_attempts {
    type: number
    value_format: "####"
    sql: ${TABLE}.churned_players_max_failed_attempts ;;
  }

  measure: avg_failed_attempts {
    type: average
    value_format: "####"
    sql: ${max_failed_attempts} ;;
  }

  measure: max_max_failed_attempts {
    type: max
    value_format: "####"
    sql: ${max_failed_attempts} ;;
  }

  measure: min_max_failed_attempts {
    type: min
    value_format: "####"
    sql: ${max_failed_attempts} ;;
  }

  measure: med_max_failed_attempts {
    type: median
    value_format: "####"
    sql: ${max_failed_attempts} ;;
  }

  measure: quartile_2_max_failed_attempts {
    type: percentile
    percentile: 25
    value_format: "####"
    sql: ${max_failed_attempts} ;;
  }

  measure: quartile_3_max_failed_attempts {
    type: percentile
    percentile: 75
    value_format: "####"
    sql: ${max_failed_attempts} ;;
  }

  dimension: click_count {
    type: number
    sql: ${TABLE}.churned_players_click_count ;;
  }

  measure: click_count_min {
    type: min
    sql: ${click_count} ;;
  }

  measure: click_count_25th {
    type: percentile
    percentile: 25
    sql: ${click_count} ;;
  }

  measure: click_count_med {
    type: median
    sql: ${click_count} ;;
  }

  measure: click_count_75th {
    type: percentile
    percentile: 75
    sql: ${click_count} ;;
  }

  measure: click_count_max {
    type: max
    sql: ${click_count} ;;
  }

  dimension: avg_load_time {
    type: number
    sql: ${TABLE}.churned_players_avg_load_time ;;
  }

  measure: max_load_time {
    type: max
    value_format: "####"
    sql: ${avg_load_time} ;;
  }

  measure: min_load_time {
    type: min
    value_format: "####"
    sql: ${avg_load_time} ;;
  }

  measure: med_load_time {
    type: median
    value_format: "####"
    sql: ${avg_load_time} ;;
  }

  measure: quartile_2_load_time {
    type: percentile
    percentile: 25
    value_format: "####"
    sql: ${avg_load_time} ;;
  }

  measure: quartile_3_load_time {
    type: percentile
    percentile: 75
    value_format: "####"
    sql: ${avg_load_time} ;;
  }

  dimension: install_version {}

  dimension: install_release_version_minor {
    sql: @{install_release_version_minor};;
  }

  set: detail {
    fields: [
      user_id,
      experiment_names,
      variants,
      max_current_card_quest,
      max_failed_attempts,
      click_count,
      avg_load_time
    ]
  }
}
