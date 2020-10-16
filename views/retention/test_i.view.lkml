view: test_i {
  derived_table: {
    sql: SELECT
        CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp , 'America/Los_Angeles')) AS DATE) AS events_event_date,
        CAST(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')) AS DATE) AS events_user_first_seen_date,
        CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END  AS events_experiment_names,
        REPLACE(CASE
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'EarlyContent' THEN JSON_EXTRACT(events.experiments,'$.content_20201005')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'SecondsPerRound' THEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'EarlyExit2' THEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'EarlyExit' THEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'Notifications' THEN JSON_EXTRACT(events.experiments,'$.notifications_20200824')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'LazyLoad' THEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'FUETiming' THEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'EasyEarlyBingoCardVariants' THEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'LowPerformanceMode' THEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803')
                  WHEN (CASE
                  WHEN JSON_EXTRACT(events.experiments,'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
                  WHEN JSON_EXTRACT(events.experiments,'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
                  WHEN JSON_EXTRACT(events.experiments,'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
                  WHEN JSON_EXTRACT(events.experiments,'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
                  WHEN JSON_EXTRACT(events.experiments,'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
                  WHEN JSON_EXTRACT(events.experiments,'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
                  WHEN JSON_EXTRACT(events.experiments,'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
                  WHEN JSON_EXTRACT(events.experiments,'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
                  WHEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
                  WHEN JSON_EXTRACT(events.experiments,'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
                  WHEN JSON_EXTRACT(events.experiments,'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
                  WHEN JSON_EXTRACT(events.experiments,'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
                  WHEN JSON_EXTRACT(events.experiments,'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
                END) = 'LinearVsNonLinear' THEN JSON_EXTRACT(events.experiments,'$.linearFirstCards_20200723')
                END,'"','')  AS events_variants,
        CASE
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 2 THEN '00'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 2 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 4 THEN '01'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 4 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 6 THEN '02'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 6 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 8 THEN '03'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 8 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 10 THEN '04'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 10 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 12 THEN '05'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 12 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 14 THEN '06'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 14 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 16 THEN '07'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 16 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 18 THEN '08'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 18 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 20 THEN '09'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 20 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 22 THEN '10'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 22 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 24 THEN '11'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 24 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 26 THEN '12'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 26 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 28 THEN '13'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 28 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 30 THEN '14'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 30 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 32 THEN '15'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 32 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 34 THEN '16'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 34 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 36 THEN '17'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 36 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 38 THEN '18'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 38 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 40 THEN '19'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 40 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 42 THEN '20'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 42 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 44 THEN '21'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 44 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 46 THEN '22'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 46 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 48 THEN '23'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 48 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 50 THEN '24'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 50 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 52 THEN '25'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 52 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 54 THEN '26'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 54 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 56 THEN '27'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 56 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 58 THEN '28'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 58 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 60 THEN '29'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 60 THEN '30'
      ELSE '31'
      END AS events_60_mins_since_install__sort_,
        CASE
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 2 THEN 'Below 2'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 2 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 4 THEN '2 to 3'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 4 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 6 THEN '4 to 5'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 6 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 8 THEN '6 to 7'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 8 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 10 THEN '8 to 9'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 10 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 12 THEN '10 to 11'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 12 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 14 THEN '12 to 13'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 14 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 16 THEN '14 to 15'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 16 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 18 THEN '16 to 17'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 18 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 20 THEN '18 to 19'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 20 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 22 THEN '20 to 21'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 22 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 24 THEN '22 to 23'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 24 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 26 THEN '24 to 25'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 26 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 28 THEN '26 to 27'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 28 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 30 THEN '28 to 29'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 30 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 32 THEN '30 to 31'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 32 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 34 THEN '32 to 33'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 34 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 36 THEN '34 to 35'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 36 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 38 THEN '36 to 37'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 38 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 40 THEN '38 to 39'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 40 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 42 THEN '40 to 41'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 42 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 44 THEN '42 to 43'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 44 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 46 THEN '44 to 45'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 46 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 48 THEN '46 to 47'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 48 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 50 THEN '48 to 49'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 50 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 52 THEN '50 to 51'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 52 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 54 THEN '52 to 53'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 54 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 56 THEN '54 to 55'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 56 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 58 THEN '56 to 57'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 58 AND (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  < 60 THEN '58 to 59'
      WHEN (CAST(TIMESTAMP_DIFF(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.timestamp  , 'America/Los_Angeles')), TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', events.created_at , 'America/Los_Angeles')), MINUTE) AS INT64))  >= 60 THEN '60 or Above'
      ELSE 'Undefined'
      END AS events_60_mins_since_install,
        COUNT(DISTINCT events.user_id ) AS events_count_unique_person_id,
        COUNT(DISTINCT events.user_id)  AS events_churn_measure
      FROM `eraser-blast.game_data.events` AS events

      WHERE ((((events.created_at ) >= ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -6 DAY)), 'America/Los_Angeles'))) AND (events.created_at ) < ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)), 'America/Los_Angeles')))))) AND ((((events.timestamp ) >= ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -6 DAY)), 'America/Los_Angeles'))) AND (events.timestamp ) < ((TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(TIMESTAMP(FORMAT_TIMESTAMP('%F %H:%M:%E*S', CURRENT_TIMESTAMP(), 'America/Los_Angeles')), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)), 'America/Los_Angeles')))))) AND (user_type NOT IN ("internal_editor", "unit_test"))
      GROUP BY 1,2,3,4,5,6
      ORDER BY 3, 4 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: events_event_date {
    type: date
    datatype: date
    sql: ${TABLE}.events_event_date ;;
  }

  dimension: events_user_first_seen_date {
    type: date
    datatype: date
    sql: ${TABLE}.events_user_first_seen_date ;;
  }

  dimension: events_experiment_names {
    type: string
    sql: ${TABLE}.events_experiment_names ;;
  }

  dimension: events_variants {
    type: string
    sql: ${TABLE}.events_variants ;;
  }

  dimension: events_60_mins_since_install__sort_ {
    type: string
    sql: ${TABLE}.events_60_mins_since_install__sort_ ;;
  }

  dimension: events_60_mins_since_install {
    type: string
    sql: ${TABLE}.events_60_mins_since_install ;;
  }

  dimension: events_count_unique_person_id {
    type: number
    sql: ${TABLE}.events_count_unique_person_id ;;
  }

  dimension: events_churn_measure {
    type: number
    sql: ${TABLE}.events_churn_measure ;;
  }

  set: detail {
    fields: [
      events_event_date,
      events_user_first_seen_date,
      events_experiment_names,
      events_variants,
      events_60_mins_since_install__sort_,
      events_60_mins_since_install,
      events_count_unique_person_id,
      events_churn_measure
    ]
  }
}
