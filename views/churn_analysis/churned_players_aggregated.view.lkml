view: churned_players_aggregated {
  derived_table: {
    sql: WITH churned_players AS (SELECT
        events.user_id  AS user_id,
        events.extra_json  AS extra_json,
        events.install_version  AS install_version,
        events.current_card  AS current_card,
        events.experiments  AS experiments,
        events.event_name  AS event_name,
        events.engagement_ticks  AS engagement_ticks,
        events.timestamp  AS timestamp,
        events.created_at  AS user_first_seen,
        CASE
                WHEN events.platform LIKE '%iOS%' THEN 'Apple'
                WHEN events.platform LIKE '%Android%' THEN 'Google'
                WHEN events.hardware LIKE '%Chrome%' AND events.user_id LIKE '%facebook%' THEN 'Facebook'
              END  AS platform,
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
        CASE
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  < 1 THEN '00'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 1 THEN '01'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 2 THEN '02'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 3 THEN '03'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 4 THEN '04'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 5 THEN '05'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 6 THEN '06'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 7 THEN '07'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 8 THEN '08'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 9 THEN '09'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 10 THEN '10'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 11 THEN '11'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 12 THEN '12'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 13 THEN '13'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 14 THEN '14'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 15 THEN '15'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 16 THEN '16'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 17 THEN '17'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 18 THEN '18'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 19 THEN '19'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 20 THEN '20'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 21 THEN '21'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 22 THEN '22'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 23 THEN '23'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  >= 24 THEN '24'
      ELSE '25'
      END AS events_24_hours_since_install__sort_,
        CASE
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  < 1 THEN 'Below 1'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 1 THEN '1'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 2 THEN '2'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 3 THEN '3'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 4 THEN '4'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 5 THEN '5'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 6 THEN '6'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 7 THEN '7'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 8 THEN '8'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 9 THEN '9'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 10 THEN '10'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 11 THEN '11'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 12 THEN '12'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 13 THEN '13'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 14 THEN '14'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 15 THEN '15'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 16 THEN '16'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 17 THEN '17'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 18 THEN '18'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 19 THEN '19'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 20 THEN '20'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 21 THEN '21'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 22 THEN '22'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  = 23 THEN '23'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , HOUR) AS INT64))  >= 24 THEN '24 or Above'
      ELSE 'Undefined'
      END AS `24_hours_since_install`,
        CASE
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 2 THEN '00'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 2 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 4 THEN '01'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 4 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 6 THEN '02'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 6 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 8 THEN '03'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 8 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 10 THEN '04'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 10 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 12 THEN '05'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 12 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 14 THEN '06'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 14 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 16 THEN '07'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 16 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 18 THEN '08'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 18 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 20 THEN '09'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 20 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 22 THEN '10'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 22 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 24 THEN '11'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 24 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 26 THEN '12'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 26 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 28 THEN '13'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 28 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 30 THEN '14'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 30 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 32 THEN '15'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 32 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 34 THEN '16'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 34 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 36 THEN '17'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 36 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 38 THEN '18'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 38 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 40 THEN '19'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 40 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 42 THEN '20'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 42 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 44 THEN '21'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 44 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 46 THEN '22'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 46 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 48 THEN '23'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 48 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 50 THEN '24'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 50 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 52 THEN '25'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 52 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 54 THEN '26'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 54 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 56 THEN '27'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 56 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 58 THEN '28'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 58 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 60 THEN '29'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 60 THEN '30'
      ELSE '31'
      END AS events_60_mins_since_install__sort_,
        CASE
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 2 THEN 'Below 2'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 2 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 4 THEN '2 to 3'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 4 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 6 THEN '4 to 5'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 6 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 8 THEN '6 to 7'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 8 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 10 THEN '8 to 9'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 10 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 12 THEN '10 to 11'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 12 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 14 THEN '12 to 13'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 14 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 16 THEN '14 to 15'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 16 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 18 THEN '16 to 17'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 18 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 20 THEN '18 to 19'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 20 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 22 THEN '20 to 21'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 22 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 24 THEN '22 to 23'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 24 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 26 THEN '24 to 25'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 26 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 28 THEN '26 to 27'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 28 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 30 THEN '28 to 29'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 30 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 32 THEN '30 to 31'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 32 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 34 THEN '32 to 33'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 34 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 36 THEN '34 to 35'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 36 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 38 THEN '36 to 37'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 38 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 40 THEN '38 to 39'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 40 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 42 THEN '40 to 41'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 42 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 44 THEN '42 to 43'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 44 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 46 THEN '44 to 45'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 46 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 48 THEN '46 to 47'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 48 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 50 THEN '48 to 49'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 50 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 52 THEN '50 to 51'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 52 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 54 THEN '52 to 53'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 54 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 56 THEN '54 to 55'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 56 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 58 THEN '56 to 57'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 58 AND (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  < 60 THEN '58 to 59'
      WHEN (CAST(TIMESTAMP_DIFF(events.timestamp  , events.created_at , MINUTE) AS INT64))  >= 60 THEN '60 or Above'
      ELSE 'Undefined'
      END AS `60_mins_since_install`,
        CAST(REPLACE(JSON_VALUE(events.extra_json,'$.round_id'),'"','') AS NUMERIC) AS round_id
      FROM `eraser-blast.game_data.events` AS events

      WHERE created_at  >= TIMESTAMP('2020-07-06 00:00:00')
          AND user_type = "external"
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19)
      SELECT
        churned_players.user_id AS churned_players_user_id,
        churned_players.experiment_names AS churned_players_experiment_names,
        churned_players.variants AS churned_players_variants,
        churned_players.install_version AS churned_players_install_version,
        MAX(churned_players.current_card_quest ) AS churned_players_max_current_card_quest,
        COUNT((JSON_EXTRACT_SCALAR(extra_json,"$.button_tag")))  AS churned_players_click_count,
        AVG((CAST(JSON_EXTRACT_SCALAR(extra_json,"$.load_time") AS INT64)) / 1000) AS churned_players_avg_load_time
      FROM churned_players

      WHERE (churned_players.install_version = '7200') AND (churned_players.experiment_names LIKE '%NewUX%') AND ((churned_players.variants IN ('control', 'variant_a')))
      GROUP BY 1,2,3, 4
      --HAVING (MAX(churned_players.consecutive_days) = 0) AND (MAX(churned_players.current_card_quest ) = 107)
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

  dimension: click_count {
    type: number
    sql: ${TABLE}.churned_players_click_count ;;
  }

  dimension: avg_load_time {
    type: number
    sql: ${TABLE}.churned_players_avg_load_time ;;
  }

  dimension: install_version {
    type: string
    sql: ${TABLE}.churned_players_install_version ;;
  }

  set: detail {
    fields: [
      user_id,
      experiment_names,
      variants,
      max_current_card_quest,
      click_count,
      avg_load_time
    ]
  }
}
