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
  value: "case
            when ${TABLE}.platform like '%iOS%' then 'Apple'
            when ${TABLE}.platform like '%Android%' then 'Google'
            else 'Other'
          end"

}

constant: device_internal_tester_mapping {
  value: "('596c5959-d64b-4b9a-92e2-02ac0da551db','052c6660-1668-40bc-938e-b35472d61d28','d766305b-e03b-433c-abe2-78fa6d4f827d','617c0432-a178-476c-b394-68abe694b54e')"
}

constant: purchase_exclusion_list {
  value: "('7721b79b-d8c6-4f6a-9ebb-d6afa43daed7'
            ,'7acaf400-0343-4cb8-be6c-8707dd8d1efa'
            ,'daf7c573-13dc-41b8-a173-915faf888c71'
            ,'891b3c15-9451-45d0-a7b8-1459e4252f6c'
            ,'9a804252-3902-43fb-8cab-9f1876420b5a'
            ,'8824596a-5182-4287-bcd9-9154c1c70514'
            ,'891b3c15-9451-45d0-a7b8-1459e4252f6c'
            ,'ce4e1795-6a2b-4642-94f2-36acc148853e'
            ,'1c54bae7-da32-4e68-b510-ef6e8c459ac8'
            ,'c0e75463-850c-4a25-829e-6c6324178622'
            ,'3f2eddee-3070-4966-8d51-495605ec2352'
            ,'e4590cf5-244c-425d-bf7e-4ebf0416e9c5'
            ,'c83b1dc7-24cd-40b8-931f-d73c69c949a9'
            ,'39786fde-b372-4814-a488-bfb1bf89af8a'
            ,'7f98585f-34ca-4322-beda-fa4ff51a8721'
            ,'e699b639-924f-4854-8856-54f3019ecca1'
            ,'397322b8-1459-4da7-a807-bc0d0404990d'
            ,'a8092c91-4a71-45f8-8366-0b198adf1219'
            ,'b045fdff-9f95-4c95-9421-5f676c11df13')"
}
constant: cheaters {
  value: "('')"
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
            WHEN ${TABLE}.version LIKE '9400' THEN '1.9'
            WHEN ${TABLE}.version LIKE '9500' THEN '1.9'
            WHEN ${TABLE}.version LIKE '10100' THEN '1.10'
            WHEN ${TABLE}.version LIKE '10200' THEN '1.10'
            WHEN ${TABLE}.version LIKE '10300' THEN '1.10'
            WHEN ${TABLE}.version LIKE '10400' THEN '1.10'
            WHEN ${TABLE}.version LIKE '10500' THEN '1.10'
            WHEN ${TABLE}.version LIKE '10600' THEN '1.10'
            WHEN ${TABLE}.version LIKE '10700' THEN '1.10'
            WHEN ${TABLE}.version LIKE '10800' THEN '1.10'
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
            WHEN ${TABLE}.install_version LIKE '9400' THEN '1.9'
            WHEN ${TABLE}.install_version LIKE '9500' THEN '1.9'
            WHEN ${TABLE}.install_version LIKE '10100' THEN '1.10'
            WHEN ${TABLE}.install_version LIKE '10200' THEN '1.10'
            WHEN ${TABLE}.install_version LIKE '10300' THEN '1.10'
            WHEN ${TABLE}.install_version LIKE '10400' THEN '1.10'
            WHEN ${TABLE}.install_version LIKE '10500' THEN '1.10'
            WHEN ${TABLE}.install_version LIKE '10600' THEN '1.10'
            WHEN ${TABLE}.install_version LIKE '10700' THEN '1.10'
            WHEN ${TABLE}.install_version LIKE '10800' THEN '1.10'
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
            WHEN ${TABLE}.version LIKE '9400' THEN '1.9.400'
            WHEN ${TABLE}.version LIKE '9500' THEN '1.9.500'
            WHEN ${TABLE}.version LIKE '10100' THEN '1.10.100'
            WHEN ${TABLE}.version LIKE '10200' THEN '1.10.200'
            WHEN ${TABLE}.version LIKE '10300' THEN '1.10.300'
            WHEN ${TABLE}.version LIKE '10400' THEN '1.10.400'
            WHEN ${TABLE}.version LIKE '10500' THEN '1.10.500'
            WHEN ${TABLE}.version LIKE '10600' THEN '1.10.600'
            WHEN ${TABLE}.version LIKE '10700' THEN '1.10.700'
            WHEN ${TABLE}.version LIKE '10800' THEN '1.10.800'
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
            WHEN ${TABLE}.install_version LIKE '9400' THEN '1.9.400'
            WHEN ${TABLE}.install_version LIKE '9500' THEN '1.9.500'
            WHEN ${TABLE}.install_version LIKE '10100' THEN '1.10.100'
            WHEN ${TABLE}.install_version LIKE '10200' THEN '1.10.200'
            WHEN ${TABLE}.install_version LIKE '10300' THEN '1.10.300'
            WHEN ${TABLE}.install_version LIKE '10400' THEN '1.10.400'
            WHEN ${TABLE}.install_version LIKE '10500' THEN '1.10.500'
            WHEN ${TABLE}.install_version LIKE '10600' THEN '1.10.600'
            WHEN ${TABLE}.install_version LIKE '10700' THEN '1.10.700'
            WHEN ${TABLE}.install_version LIKE '10800' THEN '1.10.800'
          END"
}

constant: experiment_ids {
  value: "CASE
            WHEN JSON_EXTRACT(${experiments},'$.altCard002_20210505') != 'unassigned' THEN 'Alt Card_002 / Tile 18'
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
            WHEN ${experiment_names} = 'Alt Card_002 / Tile 18' THEN JSON_EXTRACT_SCALAR(${experiments},'$.altCard002_20210505')
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

constant: current_card_numbered_coalesced {
  value: "CASE
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_a' THEN 100
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_b' THEN 100
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
              WHEN coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_021' THEN 2300
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'ce_001_card_001' then 20210601
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'ce_001_card_002' then 20210602
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'ce_001_card_003' then 20210603
          END"
}
constant: current_card_numbered {
  value: "case
            when ${TABLE}.current_card = 'card_001_a' then 100
            when ${TABLE}.current_card = 'card_001_b' then 100
            when ${TABLE}.current_card = 'card_001_untimed' then 100
            when ${TABLE}.current_card = 'card_002_b' then 120
            when ${TABLE}.current_card = 'card_003_b' then 150
            when ${TABLE}.current_card = 'card_002_a' then 200
            when ${TABLE}.current_card = 'card_002_untimed' then 200
            when ${TABLE}.current_card = 'card_003_a' then 300
            when ${TABLE}.current_card = 'card_003_untimed' then 300
            when ${TABLE}.current_card = 'card_002' then 400
            when ${TABLE}.current_card = 'card_002_inverted' then 400
            when ${TABLE}.current_card = 'card_039' then 400
            when ${TABLE}.current_card = 'card_004_untimed' then 400
            when ${TABLE}.current_card = 'card_003' then 500
            when ${TABLE}.current_card = 'card_003_20210329' then 500
            when ${TABLE}.current_card = 'card_040' then 500
            when ${TABLE}.current_card = 'card_005_untimed' then 500
            when ${TABLE}.current_card = 'card_004' then 600
            when ${TABLE}.current_card = 'card_004_20210329' then 600
            when ${TABLE}.current_card = 'card_041' then 600
            when ${TABLE}.current_card = 'card_006_untimed' then 600
            when ${TABLE}.current_card = 'card_005' then 700
            when ${TABLE}.current_card = 'card_006' then 800
            when ${TABLE}.current_card = 'card_007' then 900
            when ${TABLE}.current_card = 'card_008' then 1000
            when ${TABLE}.current_card = 'card_009' then 1100
            when ${TABLE}.current_card = 'card_010' then 1200
            when ${TABLE}.current_card = 'card_011' then 1300
            when ${TABLE}.current_card = 'card_012' then 1400
            when ${TABLE}.current_card = 'card_013' then 1500
            when ${TABLE}.current_card = 'card_014' then 1600
            when ${TABLE}.current_card = 'card_015' then 1700
            when ${TABLE}.current_card = 'card_016' then 1800
            when ${TABLE}.current_card = 'card_017' then 1900
            when ${TABLE}.current_card = 'card_018' then 2000
            when ${TABLE}.current_card = 'card_019' then 2100
            when ${TABLE}.current_card = 'card_020' then 2200
            when ${TABLE}.current_card = 'card_021' then 2300
            when ${TABLE}.current_card = 'ce_001_card_001' then 20210601
            when ${TABLE}.current_card = 'ce_001_card_002' then 20210602
            when ${TABLE}.current_card = 'ce_001_card_003' then 20210603
            when ${TABLE}.current_card = 'ce_002_card_001' then 20210701
            when ${TABLE}.current_card = 'ce_002_card_002' then 20210702
            when ${TABLE}.current_card = 'ce_002_card_003' then 20210703
            when ${TABLE}.current_card = 'ce_003_card_001' then 20210711
            when ${TABLE}.current_card = 'ce_003_card_002' then 20210712
            when ${TABLE}.current_card = 'ce_003_card_003' then 20210713
            when ${TABLE}.current_card = 'tu_001_card_001' then 30210801
          end"
}

constant: last_unlocked_card_numbered {
  value: "case
            when ${TABLE}.last_unlocked_card = 'card_001_a' then 100
            when ${TABLE}.last_unlocked_card = 'card_001_b' then 100
            when ${TABLE}.last_unlocked_card = 'card_001_untimed' then 100
            when ${TABLE}.last_unlocked_card = 'card_002_b' then 120
            when ${TABLE}.last_unlocked_card = 'card_003_b' then 150
            when ${TABLE}.last_unlocked_card = 'card_002_a' then 200
            when ${TABLE}.last_unlocked_card = 'card_002_untimed' then 200
            when ${TABLE}.last_unlocked_card = 'card_003_a' then 300
            when ${TABLE}.last_unlocked_card = 'card_003_untimed' then 300
            when ${TABLE}.last_unlocked_card = 'card_002' then 400
            when ${TABLE}.last_unlocked_card = 'card_002_inverted' then 400
            when ${TABLE}.last_unlocked_card = 'card_039' then 400
            when ${TABLE}.last_unlocked_card = 'card_004_untimed' then 400
            when ${TABLE}.last_unlocked_card = 'card_003' then 500
            when ${TABLE}.last_unlocked_card = 'card_003_20210329' then 500
            when ${TABLE}.last_unlocked_card = 'card_040' then 500
            when ${TABLE}.last_unlocked_card = 'card_005_untimed' then 500
            when ${TABLE}.last_unlocked_card = 'card_004' then 600
            when ${TABLE}.last_unlocked_card = 'card_004_20210329' then 600
            when ${TABLE}.last_unlocked_card = 'card_041' then 600
            when ${TABLE}.last_unlocked_card = 'card_006_untimed' then 600
            when ${TABLE}.last_unlocked_card = 'card_005' then 700
            when ${TABLE}.last_unlocked_card = 'card_006' then 800
            when ${TABLE}.last_unlocked_card = 'card_007' then 900
            when ${TABLE}.last_unlocked_card = 'card_008' then 1000
            when ${TABLE}.last_unlocked_card = 'card_009' then 1100
            when ${TABLE}.last_unlocked_card = 'card_010' then 1200
            when ${TABLE}.last_unlocked_card = 'card_011' then 1300
            when ${TABLE}.last_unlocked_card = 'card_012' then 1400
            when ${TABLE}.last_unlocked_card = 'card_013' then 1500
            when ${TABLE}.last_unlocked_card = 'card_014' then 1600
            when ${TABLE}.last_unlocked_card = 'card_015' then 1700
            when ${TABLE}.last_unlocked_card = 'card_016' then 1800
            when ${TABLE}.last_unlocked_card = 'card_017' then 1900
            when ${TABLE}.last_unlocked_card = 'card_018' then 2000
            when ${TABLE}.last_unlocked_card = 'card_019' then 2100
            when ${TABLE}.last_unlocked_card = 'card_020' then 2200
            when ${TABLE}.last_unlocked_card = 'card_021' then 2300
          end"
}

constant: request_card_numbered {
  value: "case
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_001_a' then 100
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_001_b' then 100
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_001_untimed' then 100
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_001_b' then 100
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_b' then 120
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_b' then 150
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_a' then 200
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_a' then 300
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_untimed' then 300
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_inverted' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_039' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_004_untimed' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_20210329' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_040' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_005_untimed' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_004' then 600
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_004_20210329' then 600
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_041' then 600
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_006_untimed' then 600
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_005' then 700
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_006' then 800
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_007' then 900
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_008' then 1000
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_009' then 1100
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_010' then 1200
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_011' then 1300
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_012' then 1400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_013' then 1500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_014' then 1600
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_015' then 1700
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_016' then 1800
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_017' then 1900
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_018' then 2000
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_019' then 2100
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_020' then 2200
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_021' then 2300
    end"
}

constant: purchase_source {
  value: "CASE
              WHEN json_extract_scalar(${TABLE}.extra_json,'$.source_id') LIKE 'Sheet_ManageLives.QuickPurchase.%' THEN 'Lives Quick Purchase Sheet'
              WHEN json_extract_scalar(${TABLE}.extra_json,'$.source_id') LIKE 'Sheet_CurrencyPack.QuickPurchase.%' THEN 'Coins Quick Purchase Sheet'
              WHEN json_extract_scalar(${TABLE}.extra_json,'$.source_id') LIKE 'Panel_Store.Purchase.%' THEN 'Store'
              WHEN json_extract_scalar(${TABLE}.extra_json,'$.source_id') LIKE 'Panel_QuickPurchase.Purchase.%' THEN 'Quick Purchase'
              WHEN json_extract_scalar(${TABLE}.extra_json,'$.source_id') LIKE '%BuyMoreTime%' THEN 'Mini-Game'
              ELSE 'OTHER'
          END"
}

constant: purchase_iap_strings {
  value: "case
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_001%' then 'Free Ticket Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_017%' then 'Free Coin Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_018%' then 'Free Boost Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_002%' then 'Housepets Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_003%' then 'Fun Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_019%' then 'Super Fun Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_022%' then 'Jumbo Fun Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_004%' then 'Peewee Coin Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_005%' then 'Small Coin Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_006%' then 'Medium Coin Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_007%' then 'Large Coin Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_020%' then 'Huge Coin Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_021%' then 'Jumbo Coin Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_008%' then 'Peewee Gem Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_009%' then 'Small Gem Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_010%' then 'Medium Gem Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_011%' then 'Large Gem Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_012%' then 'Huge Gem Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_013%' then 'Jumbo Gem Capsule'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_023%' then 'Peewee Life Pack'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_014%' then 'Small Life Pack'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_015%' then 'Medium Life Pack'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_016%' then 'Large Life Pack'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_024%' then 'Huge Life Pack'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_025%' then 'Jumbo Life Pack'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_028%' then '24h Infinite Lives'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_029%' then 'More Time for 24 Hours'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_030%' then 'More Time - High Score'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_031%' then 'More Time - Quest'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%BuyMoreTime%' then 'More Time'
          else 'OTHER'
          end"
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
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_028' then '24h Infinite Lives'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_029' then 'More Time for 24 Hours'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_030' then 'More Time - High Score'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_031' then 'More Time - Quest'
            when json_extract_scalar(extra_json,'$.iap_id') like 'more_time_highscore' then 'More Time - Score'
            when json_extract_scalar(extra_json,'$.iap_id') like 'more_time_quest' then 'More Time - Quest'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_001' then 'Score Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_002' then 'Coin Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_003' then 'XP Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_004' then 'Time Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_005' then 'Bubble Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_006' then '5-to-4 Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_000' then 'Free Ticket Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_001' then 'Fun Capsule Ticket'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_002' then 'Super Fun Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_004' then 'Free Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_005' then 'Free Boost Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_006' then 'Jumbo Fun Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_007' then 'Housepets Capsule Ticket'
          else 'other'
          end"
}

  constant:  iam_ui_actions {
    value: "case
              when json_extract_scalar(extra_json,'$.ui_action') like '%Conectar%' then 'Connect'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Conecte%' then 'Connect'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Conéctate%' then 'Connect'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Connect%' then 'Connect'
              when json_extract_scalar(extra_json,'$.ui_action') like '%MISSING%' then 'Connect'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Califícanos%' then 'Rate Us'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Avalie-nos%' then 'Rate Us'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Rate Us%' then 'Rate Us'
              when json_extract_scalar(extra_json,'$.ui_action') like '%tarde%' then 'Later'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Luego%' then 'Later'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Depois%' then 'Later'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Permitir%' then 'Enable'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Habilitar%' then 'Enable'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Si%' then 'Yes'
              when json_extract_scalar(extra_json,'$.ui_action') like '%Sim%' then 'Yes'
              when json_extract_scalar(extra_json,'$.ui_action') = 'Ok' then 'Yes'
              when json_extract_scalar(extra_json,'$.ui_action') = '¡Juega ahora!' then 'Play Now'
              when json_extract_scalar(extra_json,'$.ui_action') = 'Jogue agora!' then 'Play Now'
              else json_extract_scalar(extra_json,'$.ui_action')
            end"
}

  constant: ce_ui_actions {
    value: "case
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_SelectTeam.CommunityTeamOk' then '01. How To Play / Tap OK'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_SelectTeam.CommunityTeamSelect%' then '02a. Choose Team / Select Team'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_SelectTeam.NoTeamSelected%' then '02b. Choose Team / Join Team (No Team Selected)'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_SelectTeam.CommunityEventInfo%' then '02c. Choose Team / Tap Event Info'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_SelectTeam.CommunityTeamJoin%' then '03. Choose Team / Tap OK'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_Leaderboards.CommunityEventPlay' then '04. Leaderboard / Tap Play'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_CommunityEvents_Bingo.QuestNode.ce_%' then '05. Bingo Card / Tap Bingo Card Tile'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_CommunityEvents_Bingo.TileProgress.ce_%' then '05. Bingo Card / Tap Bingo Card Tile'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_CollectCommunityEvent.Collect' then '06. Bingo Card / Collect Item'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_Leaderboards.CommunityEventIndividualClaim' then '08. Claim Reward / Player'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_Leaderboards.CommunityEventTeamsClaim' then '09. Claim Reward / Teams'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_Leaderboards.CommunityEventTeamClaim' then '10. Claim Reward / Team'
              else json_extract_scalar(extra_json,'$.button_tag')
            end"
}

  constant: button_tags {
    value: "case
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V3.Confirm' then 'MG - Buy More Time - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V3.Confirm.quest' then 'MG - Buy More Time - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V3.Close' then 'MG - Buy More Time - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BuyMoreTime.Confirm' then 'MG - Buy More Time - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V4.Confirm' then 'MG - Buy More Time - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BuyMoreTime.V4.Close' then 'MG - Buy More Time - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V4.Close' then 'MG - Buy More Time - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BuyMoreTime.Close' then 'MG - Buy More Time - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_legacy.TryAgain' then 'EoR - Try Again'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_legacy.Back' then 'EoR - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_legacy.Continue' then 'EoR - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_v3.Continue' then 'EoR - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_v3.TryAgain' then 'EoR - Try Again'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndOfRoundReward_V3.Close' then 'EoR - Reward - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EraserReward.Continue' then 'EoR - Reward - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CollectHelpRequest.TryAgain' then 'EoR - AFH - Try Again'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CollectHelpRequest.Back' then 'EoR - AFH - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CollectHelpRequest.Collect' then 'EoR - AFH - Collect Token'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_v3.Back' then 'EoR - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BingoQuestDetails_Legacy.PlayFromQuest' then 'PG - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.PlayFromQuest' then 'PG - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.EmptyTeam' then 'PG - Play (No Eraser Selected)'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.Boosts' then 'PG - Open Boost Shop'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Boosts_V3.OverlayClose' then 'PG - Close Boost Shop'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BingoQuestDetails.PlayFromQuest' then 'PG - Play'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_PreGame_V3.QuestEraserSelection%' then 'PG - Select / Deselect Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Boosts_V3.Close' then 'PG - Close Boost Dialog'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CameraScroller_Fixed-TopDown.WorldTapDispatcher' then 'WM - Tap Map'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CameraScroller_Fixed-TopDown.PlayNavigation' then 'WM - Play'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_BingoHome_V3.QuestNode%' then 'WM - Tap Bingo Card Tile'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_Home.QuestNode.%' then 'WM - Tap Bingo Card Tile'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.RequestHelp' then 'PG - AFH'
              when json_extract_scalar(extra_json,'$.button_tag') like 'UseHeroPower.character_%' then 'MG - Eraser Skill'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Pause' then 'MG - Pause'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Pause_V2.Close' then 'MG - Pause - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Pause_V2.Quit' then 'MG - Pause - Quit'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_QuitConfirm_V2.Close' then 'MG - Pause - Close'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_QuickPurchase.Close' then 'QP - Close'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_QuickPurchase.Purchase%' then 'QP - Select IAP'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_Purchase.Close' then 'QP - Close Purchase Panel'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_BingoHome_V3.TileProgress.Free%' then 'WM - Tap Free Bingo Card Tile'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_Character_Dialogue%' then 'WM - Dialog'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_AddEraser_V3.QuestEraserSelection.%' then 'PG - Add Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_EraserDetail.Use.character_%' then 'PG - Use Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_EraserDetail.Remove.character_%' then 'PG - Remove Eraser'

              else json_extract_scalar(extra_json,'$.button_tag')
            end"
  }
  constant: event_names {
    value: "case
              when json_extract_scalar(${TABLE}.extra_json,'$.event_id') = 'event_id_202106_a' then 'Spring'
              when json_extract_scalar(${TABLE}.extra_json,'$.event_id') = 'event_id_202107_a' then 'Summer'
              when json_extract_scalar(${TABLE}.extra_json,'$.event_id') = 'event_id_202107_b' then 'Olympics'
              else json_extract_scalar(${TABLE}.extra_json,'$.event_id')
            end"
  }
  constant: event_team_names {
    value: "case
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_007' then 'Team 1'
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_008' then 'Team 2'
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_009' then 'Team 3'
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_010' then 'Team BBQ - Ned'
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_011' then 'Team Beach - Frank'
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_012' then 'Team Pool - Claire'
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_013' then 'Team Clarke'
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_014' then 'Team Maria'
              when json_extract_scalar(${TABLE}.extra_json,'$.team_id') = 'team_015' then 'Team Francey'
              else json_extract_scalar(${TABLE}.extra_json,'$.team_id')
          end"
  }
  constant: system_value_conversion {
    value: "case
              when ${TABLE}.reward_type = 'CURRENCY_02' then '600'
              when ${TABLE}.reward_type = 'CURRENCY_03' then '1'
              when ${TABLE}.reward_type = 'CURRENCY_04' then '600'
              when ${TABLE}.reward_type = 'CURRENCY_05' then '600'
              when ${TABLE}.reward_type = 'boost_001' then '500'
              when ${TABLE}.reward_type = 'boost_002' then '500'
              when ${TABLE}.reward_type = 'boost_003' then '500'
              when ${TABLE}.reward_type = 'boost_004' then '1000'
              when ${TABLE}.reward_type = 'boost_005' then '1500'
              when ${TABLE}.reward_type = 'boost_006' then '1800'
              when ${TABLE}.reward_type = 'LEVEL' then '6000'
              when ${TABLE}.reward_type = 'SKILL' then '30000'
              when ${TABLE}.reward_type = 'character_001' then '15000'
              when ${TABLE}.reward_type = 'character_002' then '15000'
              when ${TABLE}.reward_type = 'character_003' then '15000'
              when ${TABLE}.reward_type = 'character_004' then '15000'
              when ${TABLE}.reward_type = 'character_005' then '15000'
              when ${TABLE}.reward_type = 'character_006' then '15000'
              when ${TABLE}.reward_type = 'character_007' then '15000'
              when ${TABLE}.reward_type = 'character_008' then '15000'
              when ${TABLE}.reward_type = 'character_009' then '15000'
              when ${TABLE}.reward_type = 'character_010' then '15000'
              when ${TABLE}.reward_type = 'character_011' then '15000'
              when ${TABLE}.reward_type = 'character_012' then '15000'
              when ${TABLE}.reward_type = 'character_013' then '15000'
              when ${TABLE}.reward_type = 'character_014' then '15000'
              when ${TABLE}.reward_type = 'character_015' then '30000'
              when ${TABLE}.reward_type = 'character_016' then '30000'
              when ${TABLE}.reward_type = 'character_017' then '30000'
              when ${TABLE}.reward_type = 'character_018' then '30000'
              when ${TABLE}.reward_type = 'character_019' then '30000'
              when ${TABLE}.reward_type = 'character_020' then '30000'
              when ${TABLE}.reward_type = 'character_021' then '30000'
              when ${TABLE}.reward_type = 'character_022' then '30000'
              when ${TABLE}.reward_type = 'character_023' then '30000'
              when ${TABLE}.reward_type = 'character_024' then '30000'
              when ${TABLE}.reward_type = 'character_025' then '30000'
              when ${TABLE}.reward_type = 'character_026' then '30000'
              when ${TABLE}.reward_type = 'character_027' then '30000'
              when ${TABLE}.reward_type = 'character_028' then '30000'
              when ${TABLE}.reward_type = 'character_029' then '30000'
              when ${TABLE}.reward_type = 'character_030' then '30000'
              when ${TABLE}.reward_type = 'character_031' then '30000'
              when ${TABLE}.reward_type = 'character_032' then '30000'
              when ${TABLE}.reward_type = 'character_033' then '30000'
              when ${TABLE}.reward_type = 'character_034' then '30000'
              when ${TABLE}.reward_type = 'character_035' then '30000'
              when ${TABLE}.reward_type = 'character_036' then '30000'
              when ${TABLE}.reward_type = 'character_037' then '30000'
              when ${TABLE}.reward_type = 'character_038' then '30000'
              when ${TABLE}.reward_type = 'character_039' then '30000'
              when ${TABLE}.reward_type = 'character_040' then '30000'
              when ${TABLE}.reward_type = 'character_041' then '30000'
              when ${TABLE}.reward_type = 'character_042' then '30000'
              when ${TABLE}.reward_type = 'character_043' then '30000'
              when ${TABLE}.reward_type = 'character_044' then '30000'
              when ${TABLE}.reward_type = 'character_045' then '30000'
              when ${TABLE}.reward_type = 'character_046' then '30000'
              when ${TABLE}.reward_type = 'character_047' then '30000'
              when ${TABLE}.reward_type = 'character_048' then '30000'
            end"
  }
  constant: reward_types {
    value: "case
              when ${TABLE}.reward_type = 'CURRENCY_02' then 'Gems'
              when ${TABLE}.reward_type = 'CURRENCY_03' then 'Coins'
              when ${TABLE}.reward_type = 'CURRENCY_04' then 'Lives'
              when ${TABLE}.reward_type = 'CURRENCY_05' then 'AFH Tokens'
              when ${TABLE}.reward_type = 'boost_001' then 'Score Boost'
              when ${TABLE}.reward_type = 'boost_002' then 'Coin Boost'
              when ${TABLE}.reward_type = 'boost_003' then 'XP Boost'
              when ${TABLE}.reward_type = 'boost_004' then 'Time Boost'
              when ${TABLE}.reward_type = 'boost_005' then 'Bubble Boost'
              when ${TABLE}.reward_type = 'boost_006' then '5-to-4 Boost'
              when ${TABLE}.reward_type = 'LEVEL' then 'Level Ticket'
              when ${TABLE}.reward_type = 'SKILL' then 'Skill Ticket'
            end"
  }
constant: reward_events {
    value: "case
              when ${TABLE}.reward_event like '%initial%' then 'Initial Reward'
              when ${TABLE}.reward_event like '%level%' then 'Level Up'
              when ${TABLE}.reward_event = 'bingo_reward_COMP' then 'Bingo Card Completion'
              when ${TABLE}.reward_event like '%bingo_reward_C%' then 'Bingo Card Column'
              when ${TABLE}.reward_event like '%bingo_reward_R%' then 'Bingo Card Row'
              when ${TABLE}.reward_event like '%bingo_reward_D%' then 'Bingo Card Diagonal'
              when ${TABLE}.reward_event = 'round_end' then 'Round End'
              when ${TABLE}.reward_event = 'facebook_connect' then 'Facebook Connect'
              when ${TABLE}.reward_event = 'global_leaderboard' then 'Global Leaderboard Reward'
              when ${TABLE}.reward_event = 'gacha_box_000' then 'Free Ticket Capsule'
              when ${TABLE}.reward_event = 'gacha_box_004' then 'Free Coin Capsule'
              when ${TABLE}.reward_event = 'gacha_box_005' then 'Free Boost Capsule'
              else ${TABLE}.reward_event
            end"
}
