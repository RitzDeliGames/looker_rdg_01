#https://gist.github.com/adamawolf/3048717
constant: device_model_mapping {
  value: "CASE
          WHEN ${TABLE}.hardware = 'iPhone6,1' THEN 'iPhone 5S'
          WHEN ${TABLE}.hardware = 'iPhone6,2' THEN 'iPhone 5S'
          WHEN ${TABLE}.hardware = 'iPhone7,1' THEN 'iPhone 6 Plus'
          WHEN ${TABLE}.hardware = 'iPhone7,2' THEN 'iPhone 6'
          WHEN ${TABLE}.hardware = 'iPhone8,1' THEN 'iPhone 6s'
          WHEN ${TABLE}.hardware = 'iPhone8,2' THEN 'iPhone 6s Plus'
          WHEN ${TABLE}.hardware = 'iPhone8,4' THEN 'iPhone SE'
          WHEN ${TABLE}.hardware = 'iPhone9,1' THEN 'iPhone 7'
          WHEN ${TABLE}.hardware = 'iPhone9,2' THEN 'iPhone 7 Plus'
          WHEN ${TABLE}.hardware = 'iPhone9,3' THEN 'iPhone 7'
          WHEN ${TABLE}.hardware = 'iPhone9,4' THEN 'iPhone 7 Plus'
          WHEN ${TABLE}.hardware = 'iPhone10,1' THEN 'iPhone 8'
          WHEN ${TABLE}.hardware = 'iPhone10,2' THEN 'iPhone 8 Plus'
          WHEN ${TABLE}.hardware = 'iPhone10,3' THEN 'iPhone X'
          WHEN ${TABLE}.hardware = 'iPhone10,4' THEN 'iPhone 8'
          WHEN ${TABLE}.hardware = 'iPhone10,5' THEN 'iPhone 8 Plus'
          WHEN ${TABLE}.hardware = 'iPhone10,6' THEN 'iPhone X'
          WHEN ${TABLE}.hardware = 'iPhone11,2' THEN 'iPhone XS'
          WHEN ${TABLE}.hardware = 'iPhone11,4' THEN 'iPhone XS Max'
          WHEN ${TABLE}.hardware = 'iPhone11,6' THEN 'iPhone XS Max'
          WHEN ${TABLE}.hardware = 'iPhone11,8' THEN 'iPhone XR'
          WHEN ${TABLE}.hardware = 'iPhone12,1' THEN 'iPhone 11'
          WHEN ${TABLE}.hardware = 'iPhone12,3' THEN 'iPhone 11 Pro'
          WHEN ${TABLE}.hardware = 'iPhone12,5' THEN 'iPhone 11 Pro Max'
          WHEN ${TABLE}.hardware = 'iPhone12,8' THEN 'iPhone SE - 2nd Gen'
          WHEN ${TABLE}.hardware = 'iPad4,1' THEN 'iPad Air - 1st Gen'
          WHEN ${TABLE}.hardware = 'iPad5,3' THEN 'iPad Air - 2nd Gen'
          WHEN ${TABLE}.hardware = 'iPad11,3' THEN 'iPad Air - 3rd Gen'
          WHEN ${TABLE}.hardware = 'iPad6,3' THEN 'iPad Pro'
          WHEN ${TABLE}.hardware = 'iPad6,7' THEN 'iPad Pro'
          WHEN ${TABLE}.hardware = 'iPad7,3' THEN 'iPad Pro - 3rd Gen'
          WHEN ${TABLE}.hardware = 'iPad8,11' THEN 'iPad Pro - 4th Gen'
          WHEN ${TABLE}.hardware = 'iPad6,11' THEN 'iPad - 5th Gen'
          WHEN ${TABLE}.hardware = 'iPad7,5' THEN 'iPad - 6th Gen'
          WHEN ${TABLE}.hardware = 'iPad7,11' THEN 'iPad - 7th Gen'
          WHEN ${TABLE}.hardware = 'iPad5,1' THEN 'iPad Mini - 4th Gen'
          ELSE ${TABLE}.hardware
        END"
}

constant: device_manufacturer_mapping{
  value: "CASE
          WHEN ${TABLE}.hardware LIKE '%iPhone%' THEN 'Apple'
          WHEN ${TABLE}.hardware LIKE '%iPad%' THEN 'Apple'
          WHEN ${TABLE}.hardware LIKE '%Pixel%' THEN 'Google'
          WHEN ${TABLE}.hardware LIKE '%samsung%' THEN 'Samsung'
          WHEN ${TABLE}.hardware LIKE '%LG%' THEN 'LG'
          WHEN ${TABLE}.hardware LIKE '%moto%' THEN 'Motorola'
          WHEN ${TABLE}.hardware LIKE '%Huawei%' THEN 'Huawei'
          WHEN ${TABLE}.hardware LIKE '%Lenovo%' THEN 'Lenovo'
        END"
}

constant: device_os_version_mapping {
  value: "CASE
          WHEN ${TABLE}.platform LIKE '%iOS 14%' THEN 'iOS 14'
          WHEN ${TABLE}.platform LIKE '%iOS 13%' THEN 'iOS 13'
          WHEN ${TABLE}.platform LIKE '%iOS 12%' THEN 'iOS 12'
          WHEN ${TABLE}.platform LIKE '%iOS 11%' THEN 'iOS 11'
          WHEN ${TABLE}.platform LIKE '%iOS 10%' THEN 'iOS 10'
          WHEN ${TABLE}.platform LIKE '%iOS 10%' THEN 'iOS 10'
          WHEN ${TABLE}.platform LIKE '%Android OS 12%' THEN 'Android 12'
          WHEN ${TABLE}.platform LIKE '%Android OS 11%' THEN 'Android 11'
          WHEN ${TABLE}.platform LIKE '%Android OS 10%' THEN 'Android 10'
          WHEN ${TABLE}.platform LIKE '%Android OS 9%' THEN 'Android 9'
          WHEN ${TABLE}.platform LIKE '%Android OS 8%' THEN 'Android 8'
          WHEN ${TABLE}.platform LIKE '%Android OS 7%' THEN 'Android 7'
          WHEN ${TABLE}.platform LIKE '%Android OS 6%' THEN 'Android 6'
          WHEN ${TABLE}.platform LIKE '%Android OS 5%' THEN 'Android 5'
          WHEN ${TABLE}.platform LIKE '%Android OS 4%' THEN 'Android 4'
        END"
  }

constant: device_platform_mapping {
  value: "CASE
          WHEN ${TABLE}.platform LIKE '%iOS%' THEN 'Apple'
          WHEN ${TABLE}.platform LIKE '%Android%' THEN 'Google'
          ELSE 'Other'
        END"

}

constant: device_internal_tester_mapping {
  value: "CASE
          WHEN ${TABLE}.device_id LIKE 'fc4240714a08de28281c816896adf3cc' THEN 'Eric Jordan - Amazon Shitfire'
          WHEN ${TABLE}.device_id LIKE 'ab5d89e60aef9fa8e9349c42fdc3ac54' THEN 'Eric Jordan - Pixel 3a'
          WHEN ${TABLE}.device_id LIKE 'ab5d89e60aef9fa8e9349c42fdc3ac54' THEN 'Eric Jordan - Pixel 3a'
          WHEN ${TABLE}.device_id LIKE '5EE844B7-05F0-45B1-9EEB-C444CBBA5898' THEN 'Robert Einspruch - iPhone 11'
          WHEN ${TABLE}.device_id LIKE 'C4836C6F-23D4-4966-A7B6-E75E65264596' THEN 'Robert Einspruch - iPhone 11'
          WHEN ${TABLE}.device_id LIKE '0F0433FC-EF78-4D51-9ED3-218053E81641' THEN 'Robert Einspruch - iPhone 8'
          WHEN ${TABLE}.device_id LIKE '1514C433-1718-4621-BD18-2661CD888608' THEN 'Robert Einspruch - iPhone 8'
          WHEN ${TABLE}.device_id LIKE '645F4788-F440-4FAC-B0D8-A956CBE4D64C' THEN 'Robert Einspruch - iPhone 8'
          WHEN ${TABLE}.device_id LIKE '40361030-B80C-4615-8C57-4661C411F97F' THEN 'Robert Einspruch - iPhone 6'
          WHEN ${TABLE}.device_id LIKE 'db7bfa86d4eae7922496fb6c2c68253b' THEN 'RDG Samsung J2'
          WHEN ${TABLE}.device_id LIKE '69bb64b4e741e8e3d1eeba741a13d843' THEN 'Nicolas Sitas - Samsung J5'
        END"
}

constant: bingo_card_mapping_3x3 {
  value:"(CASE
    WHEN ${card_state_str} LIKE '[%7%,%8%,%9%]'
    THEN 'row_02'
    WHEN ${card_state_str} LIKE '[%1%2%,%1%3%]'
    THEN 'row_03'
    WHEN ${card_state_str} LIKE '[%1%6%,%1%7%,%1%8%]'
    THEN 'row_04'
    WHEN ${card_state_str} LIKE '[%7%,%1%2%,%1%6%]'
    THEN 'column_02'
    WHEN ${card_state_str} LIKE '[%8%,%1%7%]'
    THEN 'column_03'
    WHEN ${card_state_str} LIKE '[%9%,%1%3%,%1%8%]'
    THEN 'column_04'
    WHEN ${card_state_str} LIKE '[%7%,%1%8%]'
    THEN 'diagonal_01'
    WHEN ${card_state_str} LIKE '[%9%,%1%6%]'
    THEN 'diagonal_02'
  END)"
}

constant: bingo_card_mapping_5x5 {
  value:"(CASE
    WHEN ${card_state_str} LIKE '[%1%,%2%,%3%,%4%,%5%]'
    THEN 'row_01'
    WHEN ${card_state_str} LIKE '[%6%,%7%,%8%,%9%,1%0]'
    THEN 'row_02'
    WHEN ${card_state_str} LIKE '[%1%1%,%1%2%,%1%3%,%1%4%]'
    THEN 'row_03'
    WHEN ${card_state_str} LIKE '[%1%5%,%1%6%,%1%7%,%1%8%,%1%9%]'
    THEN 'row_04'
    WHEN ${card_state_str} LIKE '[%2%0%,%2%1%,%2%2%,%2%3%,%2%4%]'
    THEN 'row_05'
    WHEN ${card_state_str} LIKE '[%1%,%6%,%1%1%,%1%5%,%2%0%]'
    THEN 'column_01'
    WHEN ${card_state_str} LIKE '[%2%,%7%,%1%2%,%1%6%,%2%1%]'
    THEN 'column_02'
    WHEN ${card_state_str} LIKE '[%3%,%8%,%1%7%,%2%2%]'
    THEN 'column_03'
    WHEN ${card_state_str} LIKE '[%4%,%9%,%1%3%,%1%8%,%2%3%]'
    THEN 'column_04'
    WHEN ${card_state_str} LIKE '[%5%,%1%0%,%1%4%,%1%9%,%2%4%]'
    THEN 'column_05'
    WHEN ${card_state_str} LIKE '[%1%,%7%,%1%8%,%2%4%]'
    THEN 'diagonal_01'
    WHEN ${card_state_str} LIKE '[%5%,%9%,%1%6%,%2%0%]'
    THEN 'diagonal_02'
  END)"
}

constant: bingo_card_mapping_5x5_X {
  value:"(CASE
  WHEN ${card_state_str} LIKE '[%1%,%5%]'
  THEN 'row_01'
  WHEN ${card_state_str} LIKE '[%7%,%9%]'
  THEN 'row_02'
  WHEN ${card_state_str} LIKE '[%1%6%,%1%8%]'
  THEN 'row_04'
  WHEN ${card_state_str} LIKE '[%2%0%,%2%4%]'
  THEN 'row_05'
  WHEN ${card_state_str} LIKE '[%1%,%2%0%]'
  THEN 'column_01'
  WHEN ${card_state_str} LIKE '[%7%,%1%6%]'
  THEN 'column_02'
  WHEN ${card_state_str} LIKE '[%9%,%1%8%]'
  THEN 'column_04'
  WHEN ${card_state_str} LIKE '[%5%,%2%4%]'
  THEN 'column_05'
  WHEN ${card_state_str} LIKE '[%1%,%7%,%1%8%,%2%4%]'
  THEN 'diagonal_01'
  WHEN ${card_state_str} LIKE '[%5%,%9%,%1%6%,%2%0%]'
  THEN 'diagonal_02'
  END)"
}

constant: release_version_major {
  value: "CASE
            WHEN ${TABLE}.version LIKE '1579' THEN '1.0'
            WHEN ${TABLE}.version LIKE '2047' THEN '1.1'
            WHEN ${TABLE}.version LIKE '2100' THEN '1.1'
            WHEN ${TABLE}.version LIKE '3028' THEN '1.2'
            WHEN ${TABLE}.version LIKE '3043' THEN '1.2'
            WHEN ${TABLE}.version LIKE '3100' THEN '1.2'
            WHEN ${TABLE}.version LIKE '4017' THEN '1.3'
            WHEN ${TABLE}.version LIKE '4100' THEN '1.3'
            WHEN ${TABLE}.version LIKE '5006' THEN '1.5'
            WHEN ${TABLE}.version LIKE '5100' THEN '1.5'
            WHEN ${TABLE}.version LIKE '6100' THEN '1.6'
            WHEN ${TABLE}.version LIKE '6200' THEN '1.6'
            WHEN ${TABLE}.version LIKE '6300' THEN '1.6'
            WHEN ${TABLE}.version LIKE '6400' THEN '1.6'
            WHEN ${TABLE}.version LIKE '7100' THEN '1.7'
            WHEN ${TABLE}.version LIKE '7200' THEN '1.7'
            WHEN ${TABLE}.version LIKE '7300' THEN '1.7'
            WHEN ${TABLE}.version LIKE '7400' THEN '1.7'
            WHEN ${TABLE}.version LIKE '7500' THEN '1.7'
            WHEN ${TABLE}.version LIKE '7600' THEN '1.7'
            WHEN ${TABLE}.version LIKE '8000' THEN '1.8'
            WHEN ${TABLE}.version LIKE '8100' THEN '1.8'
            WHEN ${TABLE}.version LIKE '8200' THEN '1.8'
            WHEN ${TABLE}.version LIKE '8300' THEN '1.8'
            WHEN ${TABLE}.version LIKE '8400' THEN '1.8'
            WHEN ${TABLE}.version LIKE '9100' THEN '1.9'
            WHEN ${TABLE}.version LIKE '9200' THEN '1.9'
            WHEN ${TABLE}.version LIKE '9300' THEN '1.9'
        END"
}

constant: install_release_version_major {
  value: "CASE
            WHEN ${TABLE}.install_version LIKE '1579' THEN '1.0'
            WHEN ${TABLE}.install_version LIKE '2047' THEN '1.1'
            WHEN ${TABLE}.install_version LIKE '2100' THEN '1.1'
            WHEN ${TABLE}.install_version LIKE '3028' THEN '1.2'
            WHEN ${TABLE}.install_version LIKE '3043' THEN '1.2'
            WHEN ${TABLE}.install_version LIKE '3100' THEN '1.2'
            WHEN ${TABLE}.install_version LIKE '4017' THEN '1.3'
            WHEN ${TABLE}.install_version LIKE '4100' THEN '1.3'
            WHEN ${TABLE}.install_version LIKE '5006' THEN '1.5'
            WHEN ${TABLE}.install_version LIKE '5100' THEN '1.5'
            WHEN ${TABLE}.install_version LIKE '6100' THEN '1.6'
            WHEN ${TABLE}.install_version LIKE '6200' THEN '1.6'
            WHEN ${TABLE}.install_version LIKE '6300' THEN '1.6'
            WHEN ${TABLE}.install_version LIKE '6400' THEN '1.6'
            WHEN ${TABLE}.install_version LIKE '7100' THEN '1.7'
            WHEN ${TABLE}.install_version LIKE '7200' THEN '1.7'
            WHEN ${TABLE}.install_version LIKE '7300' THEN '1.7'
            WHEN ${TABLE}.install_version LIKE '7400' THEN '1.7'
            WHEN ${TABLE}.install_version LIKE '7500' THEN '1.7'
            WHEN ${TABLE}.install_version LIKE '7600' THEN '1.7'
            WHEN ${TABLE}.install_version LIKE '8000' THEN '1.8'
            WHEN ${TABLE}.install_version LIKE '8100' THEN '1.8'
            WHEN ${TABLE}.install_version LIKE '8200' THEN '1.8'
            WHEN ${TABLE}.install_version LIKE '8300' THEN '1.8'
            WHEN ${TABLE}.install_version LIKE '8400' THEN '1.8'
            WHEN ${TABLE}.install_version LIKE '9100' THEN '1.9'
            WHEN ${TABLE}.install_version LIKE '9200' THEN '1.9'
            WHEN ${TABLE}.install_version LIKE '9300' THEN '1.9'
        END"
}

constant: release_version_minor {
  value: "CASE
            WHEN ${TABLE}.version LIKE '1579' THEN '1.0.100'
            WHEN ${TABLE}.version LIKE '2047' THEN '1.1.001'
            WHEN ${TABLE}.version LIKE '2100' THEN '1.1.100'
            WHEN ${TABLE}.version LIKE '3028' THEN '1.2.028'
            WHEN ${TABLE}.version LIKE '3043' THEN '1.2.043'
            WHEN ${TABLE}.version LIKE '3100' THEN '1.2.100'
            WHEN ${TABLE}.version LIKE '4017' THEN '1.3.017'
            WHEN ${TABLE}.version LIKE '4100' THEN '1.3.100'
            WHEN ${TABLE}.version LIKE '5006' THEN '1.5.006'
            WHEN ${TABLE}.version LIKE '5100' THEN '1.5.100'
            WHEN ${TABLE}.version LIKE '6100' THEN '1.6.100'
            WHEN ${TABLE}.version LIKE '6200' THEN '1.6.200'
            WHEN ${TABLE}.version LIKE '6300' THEN '1.6.300'
            WHEN ${TABLE}.version LIKE '6400' THEN '1.6.400'
            WHEN ${TABLE}.version LIKE '7100' THEN '1.7.100'
            WHEN ${TABLE}.version LIKE '7200' THEN '1.7.200'
            WHEN ${TABLE}.version LIKE '7300' THEN '1.7.300'
            WHEN ${TABLE}.version LIKE '7400' THEN '1.7.400'
            WHEN ${TABLE}.version LIKE '7500' THEN '1.7.500'
            WHEN ${TABLE}.version LIKE '7600' THEN '1.7.600'
            WHEN ${TABLE}.version LIKE '8000' THEN '1.8.000'
            WHEN ${TABLE}.version LIKE '8100' THEN '1.8.100'
            WHEN ${TABLE}.version LIKE '8200' THEN '1.8.200'
            WHEN ${TABLE}.version LIKE '8300' THEN '1.8.300'
            WHEN ${TABLE}.version LIKE '8400' THEN '1.8.400'
            WHEN ${TABLE}.version LIKE '9100' THEN '1.9.100'
            WHEN ${TABLE}.version LIKE '9200' THEN '1.9.200'
            WHEN ${TABLE}.version LIKE '9300' THEN '1.9.300'
          END"
}

constant: install_release_version_minor {
  value: "CASE
            WHEN ${TABLE}.install_version LIKE '1579' THEN '1.0.100'
            WHEN ${TABLE}.install_version LIKE '2047' THEN '1.1.001'
            WHEN ${TABLE}.install_version LIKE '2100' THEN '1.1.100'
            WHEN ${TABLE}.install_version LIKE '3028' THEN '1.2.028'
            WHEN ${TABLE}.install_version LIKE '3043' THEN '1.2.043'
            WHEN ${TABLE}.install_version LIKE '3100' THEN '1.2.100'
            WHEN ${TABLE}.install_version LIKE '4017' THEN '1.3.017'
            WHEN ${TABLE}.install_version LIKE '4100' THEN '1.3.100'
            WHEN ${TABLE}.install_version LIKE '5006' THEN '1.5.006'
            WHEN ${TABLE}.install_version LIKE '5100' THEN '1.5.100'
            WHEN ${TABLE}.install_version LIKE '6100' THEN '1.6.100'
            WHEN ${TABLE}.install_version LIKE '6200' THEN '1.6.200'
            WHEN ${TABLE}.install_version LIKE '6300' THEN '1.6.300'
            WHEN ${TABLE}.install_version LIKE '6400' THEN '1.6.400'
            WHEN ${TABLE}.install_version LIKE '7100' THEN '1.7.100'
            WHEN ${TABLE}.install_version LIKE '7200' THEN '1.7.200'
            WHEN ${TABLE}.install_version LIKE '7300' THEN '1.7.300'
            WHEN ${TABLE}.install_version LIKE '7400' THEN '1.7.400'
            WHEN ${TABLE}.install_version LIKE '7500' THEN '1.7.500'
            WHEN ${TABLE}.install_version LIKE '7600' THEN '1.7.600'
            WHEN ${TABLE}.install_version LIKE '8000' THEN '1.8.000'
            WHEN ${TABLE}.install_version LIKE '8100' THEN '1.8.100'
            WHEN ${TABLE}.install_version LIKE '8200' THEN '1.8.200'
            WHEN ${TABLE}.install_version LIKE '8300' THEN '1.8.300'
            WHEN ${TABLE}.install_version LIKE '8400' THEN '1.8.400'
            WHEN ${TABLE}.install_version LIKE '9100' THEN '1.9.100'
            WHEN ${TABLE}.install_version LIKE '9200' THEN '1.9.200'
            WHEN ${TABLE}.install_version LIKE '9300' THEN '1.9.300'
          END"
}

constant: experiment_ids {
  value: "CASE
            WHEN JSON_EXTRACT(${experiments},'$.rewards_v1_20210415') != 'unassigned' THEN 'Bingo Rewards v1 (Lives)'
            WHEN JSON_EXTRACT(${experiments},'$.miniGame_v3_20210407') != 'unassigned' THEN 'Mini-Game UI v1'
            WHEN JSON_EXTRACT(${experiments},'$.earlyExitRedux_20210414') != 'unassigned' THEN 'Early Exit v3'
            WHEN JSON_EXTRACT(${experiments},'$.moreTimeBingo_20210330') != 'unassigned' THEN 'More Time v3'
            WHEN JSON_EXTRACT(${experiments},'$.rapidProgression_20200325') != 'unassigned' THEN 'Rapid Progression v1'
            WHEN JSON_EXTRACT(${experiments},'$.disableAutoSelect_20210330') != 'unassigned' THEN 'Disable Auto-Select v1'
            WHEN JSON_EXTRACT(${experiments},'$.v3PreGameScreen_20210316') != 'unassigned' THEN 'Pre-Game v3'
            WHEN JSON_EXTRACT(${experiments},'$.moreTimeBingo_20210322') != 'unassigned' THEN 'More Time v2'
            WHEN JSON_EXTRACT(${experiments},'$.dailyRewards_20210302') != 'unassigned' THEN 'DailyRewards v2'
            WHEN JSON_EXTRACT(${experiments},'$.card002_20210301') != 'unassigned' THEN 'Alt 407'
            WHEN JSON_EXTRACT(${experiments},'$.card002_20210222') != 'unassigned' THEN 'Alt Card 4'
            WHEN JSON_EXTRACT(${experiments},'$.newUX_20210223') != 'unassigned' THEN 'New UX v4'
            WHEN JSON_EXTRACT(${experiments},'$.askForHelp_20210112') != 'unassigned' THEN 'AskForHelp v1'
            WHEN JSON_EXTRACT(${experiments},'$.dailyRewards_20210112') != 'unassigned' THEN 'DailyRewards v1'
            WHEN JSON_EXTRACT(${experiments},'$.fueStory_20210215') != 'unassigned' THEN 'FUE/Story v1'
            WHEN JSON_EXTRACT(${experiments},'$.skillReminder_20200204') != 'unassigned' THEN 'SkillReminder v2'
            WHEN JSON_EXTRACT(${experiments},'$.newVsOld_20210108') != 'unassigned' THEN 'NewUX2'
            WHEN JSON_EXTRACT(${experiments},'$.newVsOld_20201218') != 'unassigned' THEN 'NewUX'
            WHEN JSON_EXTRACT(${experiments},'$.transitionDelay_20201217') != 'unassigned' THEN 'TransitionTiming'
            WHEN JSON_EXTRACT(${experiments},'$.endOfRound_20201204') != 'unassigned' THEN 'NewEoR'
            WHEN JSON_EXTRACT(${experiments},'$.worldmap_20201028') != 'unassigned' THEN 'WorldMap'
            WHEN JSON_EXTRACT(${experiments},'$.content_20201130') != 'unassigned' THEN 'EarlyContent3'
            WHEN JSON_EXTRACT(${experiments},'$.laterLinearTest_20201111') != 'unassigned' THEN 'LaterLinear'
            WHEN JSON_EXTRACT(${experiments},'$.content_20201106') != 'unassigned' THEN 'EarlyContent2'
            WHEN JSON_EXTRACT(${experiments},'$.vfx_threshold_20201102') != 'unassigned' THEN 'VFXTreshold'
            WHEN JSON_EXTRACT(${experiments},'$.last_bonus_20201105') != 'unassigned' THEN 'LastBonus'
            WHEN JSON_EXTRACT(${experiments},'$.untimed_20200918') != 'unassigned' THEN 'UntimedMode'
            WHEN JSON_EXTRACT(${experiments},'$.content_20201005') != 'unassigned' THEN 'EarlyContent'
            WHEN JSON_EXTRACT(${experiments},'$.secondsPerRound_20200922') != 'unassigned' THEN 'SecondsPerRound'
            WHEN JSON_EXTRACT(${experiments},'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit v2'
            WHEN JSON_EXTRACT(${experiments},'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit v1'
            WHEN JSON_EXTRACT(${experiments},'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
            WHEN JSON_EXTRACT(${experiments},'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
            WHEN JSON_EXTRACT(${experiments},'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
            WHEN JSON_EXTRACT(${experiments},'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
            WHEN JSON_EXTRACT(${experiments},'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
          END"
}

constant: variant_ids {
  value: "CASE
            WHEN ${experiment_names} = 'Bingo Rewards v1 (Lives)' THEN JSON_EXTRACT_SCALAR(${experiments},'$.rewards_v1_20210415')
            WHEN ${experiment_names} = 'Mini-Game UI v1' THEN JSON_EXTRACT_SCALAR(${experiments},'$.miniGame_v3_20210407')
            WHEN ${experiment_names} = 'Early Exit v3' THEN JSON_EXTRACT_SCALAR(${experiments},'$.earlyExitRedux_20210414')
            WHEN ${experiment_names} = 'More Time v3' THEN JSON_EXTRACT_SCALAR(${experiments},'$.moreTimeBingo_20210330')
            WHEN ${experiment_names} = 'Rapid Progression v1' THEN JSON_EXTRACT_SCALAR(${experiments},'$.rapidProgression_20200325')
            WHEN ${experiment_names} = 'Disable Auto-Select v1' THEN JSON_EXTRACT_SCALAR(${experiments},'$.disableAutoSelect_20210330')
            WHEN ${experiment_names} = 'Pre-Game v3' THEN JSON_EXTRACT_SCALAR(${experiments},'$.v3PreGameScreen_20210316')
            WHEN ${experiment_names} = 'More Time v2' THEN JSON_EXTRACT_SCALAR(${experiments},'$.moreTimeBingo_20210322')
            WHEN ${experiment_names} = 'DailyRewards v2' THEN JSON_EXTRACT_SCALAR(${experiments},'$.dailyRewards_20210302')
            WHEN ${experiment_names} = 'Alt 407' THEN JSON_EXTRACT_SCALAR(${experiments},'$.card002_20210301')
            WHEN ${experiment_names} = 'Alt Card 4' THEN JSON_EXTRACT_SCALAR(${experiments},'$.card002_20210222')
            WHEN ${experiment_names} = 'New UX v4' THEN JSON_EXTRACT_SCALAR(${experiments},'$.newUX_20210223')
            WHEN ${experiment_names} = 'AskForHelp v1' THEN JSON_EXTRACT_SCALAR(${experiments},'$.askForHelp_20210112')
            WHEN ${experiment_names} = 'DailyRewards v1' THEN JSON_EXTRACT_SCALAR(${experiments},'$.dailyRewards_20210112')
            WHEN ${experiment_names} = 'FUE/Story v1' THEN JSON_EXTRACT_SCALAR(${experiments},'$.fueStory_20210215')
            WHEN ${experiment_names} = 'SkillReminder v2' THEN JSON_EXTRACT_SCALAR(${experiments},'$.skillReminder_20200204')
            WHEN ${experiment_names} = 'NewUX2' THEN JSON_EXTRACT_SCALAR(${experiments},'$.newVsOld_20210108')
            WHEN ${experiment_names} = 'NewUX' THEN JSON_EXTRACT_SCALAR(${experiments},'$.newVsOld_20201218')
            WHEN ${experiment_names} = 'TransitionTiming' THEN JSON_EXTRACT_SCALAR(${experiments},'$.transitionDelay_20201217')
            WHEN ${experiment_names} = 'NewEoR' THEN JSON_EXTRACT_SCALAR(${experiments},'$.endOfRound_20201204')
            WHEN ${experiment_names} = 'WorldMap' THEN JSON_EXTRACT_SCALAR(${experiments},'$.worldmap_20201028')
            WHEN ${experiment_names} = 'EarlyContent3' THEN JSON_EXTRACT_SCALAR(${experiments},'$.content_20201130')
            WHEN ${experiment_names} = 'LaterLinear' THEN JSON_EXTRACT_SCALAR(${experiments},'$.laterLinearTest_20201111')
            WHEN ${experiment_names} = 'EarlyContent2' THEN JSON_EXTRACT_SCALAR(${experiments},'$.content_20201106')
            WHEN ${experiment_names} = 'VFXTreshold' THEN JSON_EXTRACT_SCALAR(${experiments},'$.vfx_threshold_20201102')
            WHEN ${experiment_names} = 'LastBonus' THEN JSON_EXTRACT_SCALAR(${experiments},'$.last_bonus_20201105')
            WHEN ${experiment_names} = 'UntimedMode' THEN JSON_EXTRACT_SCALAR(${experiments},'$.untimed_20200918')
            WHEN ${experiment_names} = 'EarlyContent' THEN JSON_EXTRACT_SCALAR(${experiments},'$.content_20201005')
            WHEN ${experiment_names} = 'SecondsPerRound' THEN JSON_EXTRACT_SCALAR(${experiments},'$.secondsPerRound_20200922')
            WHEN ${experiment_names} = 'Early Exit v2' THEN JSON_EXTRACT_SCALAR(${experiments},'$.earlyExitContent_20200909')
            WHEN ${experiment_names} = 'Early Exit v1' THEN JSON_EXTRACT_SCALAR(${experiments},'$.earlyExit_20200828')
            WHEN ${experiment_names} = 'Notifications' THEN JSON_EXTRACT_SCALAR(${experiments},'$.notifications_20200824')
            WHEN ${experiment_names} = 'LazyLoad' THEN JSON_EXTRACT_SCALAR(${experiments},'$.lazyLoadOtherTabs_20200901')
            WHEN ${experiment_names} = 'FUETiming' THEN JSON_EXTRACT_SCALAR(${experiments},'$.tabFueTiming_20200825')
            WHEN ${experiment_names} = 'EasyEarlyBingoCardVariants' THEN JSON_EXTRACT_SCALAR(${experiments},'$.bingoEasyEarlyVariants_20200608')
            WHEN ${experiment_names} = 'LowPerformanceMode' THEN JSON_EXTRACT_SCALAR(${experiments},'$.lowPerformanceMode_20200803')
          END"
}

constant: country_region {
  value: "CASE
            WHEN ${TABLE}.country LIKE 'ZZ' THEN 'N/A'
            WHEN ${TABLE}.country IN ('AR','BO', 'CO','MX', 'PE', 'UY', 'VE', 'NI', 'PY', 'CR', 'SV', 'CL', 'BZ', 'HN', 'GT', 'EC', 'PA') THEN 'LATAM-ES'
            WHEN ${TABLE}.country LIKE 'BR' THEN 'LATAM-BR'
            WHEN ${TABLE}.country IN ('SE', 'NO', 'DK','SE', 'NO', 'IS','FI') THEN 'Scandinavia'
            WHEN ${TABLE}.country IN ('GB', 'IE', 'ES') THEN 'UK-EU'
            ELSE 'OTHER'
          END"
}

constant: current_card_numbered {
  value: "CASE
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_a' THEN 100
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_untimed' THEN 100
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_b' THEN 120
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_b' THEN 150
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_a' THEN 200
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_untimed' THEN 200
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_a' THEN 300
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_untimed' THEN 300
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002' THEN 400
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_inverted' THEN 400
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_039' THEN 400
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_004_untimed' THEN 400
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003' THEN 500
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_20210329' THEN 500
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_040' THEN 500
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_005_untimed' THEN 500
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_004' THEN 600
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_004_20210329' THEN 600
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_041' THEN 600
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_006_untimed' THEN 600
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_005' THEN 700
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_006' THEN 800
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_007' THEN 900
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_008' THEN 1000
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_009' THEN 1100
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_010' THEN 1200
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_011' THEN 1300
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_012' THEN 1400
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_013' THEN 1500
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_014' THEN 1600
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_015' THEN 1700
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_016' THEN 1800
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_017' THEN 1900
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_018' THEN 2000
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_019' THEN 2100
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_020' THEN 2200
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_b' THEN 100
          END"
}


constant: request_card_numbered {
  value: "CASE
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_001_a' THEN 100
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_001_untimed' THEN 100
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_001_b' THEN 100
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_002_b' THEN 120
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_003_b' THEN 150
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_002_a' THEN 200
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_003_a' THEN 300
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_003_untimed' THEN 300
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_002' THEN 400
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_002_inverted' THEN 400
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_039' THEN 400
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_004_untimed' THEN 400
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_003' THEN 500
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_003_20210329' THEN 500
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_040' THEN 500
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_005_untimed' THEN 500
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_004' THEN 600
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_004_20210329' THEN 600
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_041' THEN 600
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_006_untimed' THEN 600
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_005' THEN 700
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_006' THEN 800
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_007' THEN 900
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_008' THEN 1000
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_009' THEN 1100
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_010' THEN 1200
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_011' THEN 1300
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_012' THEN 1400
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_013' THEN 1500
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_014' THEN 1600
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_015' THEN 1700
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_016' THEN 1800
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_017' THEN 1900
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_018' THEN 2000
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_019' THEN 2100
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_020' THEN 2200
        END"
}

constant: purchase_source {
  value: "CASE
              WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.source_id') LIKE 'Sheet_ManageLives.QuickPurchase.%' THEN 'Lives Quick Purchase Sheet'
              WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.source_id') LIKE 'Sheet_CurrencyPack.QuickPurchase.%' THEN 'Coins Quick Purchase Sheet'
              WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.source_id') LIKE 'Panel_Store.Purchase.%' THEN 'Store'
              WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.source_id') LIKE '%BuyMoreTime%' THEN 'Mini-Game'
              ELSE 'OTHER'
          END"
}

constant: purchase_iap_strings {
  value: "CASE
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_001%' THEN 'Free Ticket Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_017%' THEN 'Free Coin Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_018%' THEN 'Free Boost Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_002%' THEN 'Housepets Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_003%' THEN 'Fun Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_019%' THEN 'Super Fun Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_022%' THEN 'Jumbo Fun Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_004%' THEN 'Peewee Coin Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_005%' THEN 'Small Coin Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_006%' THEN 'Medium Coin Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_007%' THEN 'Large Coin Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_020%' THEN 'Huge Coin Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_021%' THEN 'Jumbo Coin Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_008%' THEN 'Peewee Gem Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_009%' THEN 'Small Gem Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_010%' THEN 'Medium Gem Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_011%' THEN 'Large Gem Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_012%' THEN 'Huge Gem Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_013%' THEN 'Jumbo Gem Capsule'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_023%' THEN 'Peewee Life Pack'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_014%' THEN 'Small Life Pack'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_015%' THEN 'Medium Life Pack'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_016%' THEN 'Large Life Pack'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_024%' THEN 'Huge Life Pack'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_025%' THEN 'Jumbo Life Pack'
            WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%BuyMoreTime%' THEN 'More Time'
            ELSE 'OTHER'
          END"
}

constant: iap_id_strings {
  value: "case
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_001' then 'Free Ticket Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_017' then 'Free Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_018' then 'Free Boost Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_002' then 'Housepets Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_003' then 'Fun Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_019' then 'Super Fun Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_022' then 'Jumbo Fun Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_004' then 'Peewee Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_005' then 'Small Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_006' then 'Medium Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_007' then 'Large Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_020' then 'Huge Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_021' then 'Jumbo Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_008' then 'Peewee Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_026' then 'Peewee Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_009' then 'Small Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_010' then 'Medium Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_011' then 'Large Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_012' then 'Huge Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_013' then 'Jumbo Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_023' then 'Peewee Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_014' then 'Small Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_015' then 'Medium Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_016' then 'Large Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_024' then 'Huge Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_025' then 'Jumbo Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'more_time_highscore' then 'More Time - Score'
            when json_extract_scalar(extra_json,'$.iap_id') like 'more_time_quest' then 'More Time - Quest'
          else 'other'
          end"
}

  constant:  iam_ui_actions {
    value: "CASE
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Conecte%' THEN 'Connect'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Conéctate%' THEN 'Connect'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Connect%' THEN 'Connect'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%MISSING%' THEN 'Connect'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Califícanos%' THEN 'Rate Us'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Avalie-nos%' THEN 'Rate Us'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Rate Us%' THEN 'Rate Us'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%tarde%' THEN 'Later'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Luego%' THEN 'Later'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Depois%' THEN 'Later'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Permitir%' THEN 'Enable'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Habilitar%' THEN 'Enable'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Si%' THEN 'Yes'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.ui_action') LIKE '%Sim%' THEN 'Yes'
              ELSE JSON_EXTRACT_SCALAR(extra_json,'$.ui_action')
          END"
}

  constant: button_tags {
    value: "CASE
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.button_tag') LIKE 'Panel_BuyMoreTime_V3.Confirm' THEN 'BuyMoreTime - Confirm'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.button_tag') LIKE 'Sheet_BuyMoreTime.Confirm' THEN 'BuyMoreTime - Confirm'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.button_tag') LIKE 'Panel_BuyMoreTime_V3.Close' THEN 'BuyMoreTime - Close'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.button_tag') LIKE 'Sheet_BuyMoreTime.Close' THEN 'BuyMoreTime - Close'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.button_tag') LIKE 'Panel_PreGame_V3.PlayFromQuest' THEN 'PlayFromQuest'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.button_tag') LIKE 'Sheet_BingoQuestDetails.PlayFromQuest' THEN 'PlayFromQuest'
              WHEN JSON_EXTRACT_SCALAR(extra_json,'$.button_tag') LIKE 'Sheet_BingoQuestDetails_Legacy.PlayFromQuest' THEN 'PlayFromQuest'
              ELSE JSON_EXTRACT_SCALAR(extra_json,'$.button_tag')
            END"
  }
