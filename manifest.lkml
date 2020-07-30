constant: device_model_mapping {
  value: "CASE
          WHEN ${TABLE}.hardware = 'iPhone6,2' THEN 'iPhone 5s Global'
          WHEN ${TABLE}.hardware = 'iPhone7,1' THEN 'iPhone 6 Plus'
          WHEN ${TABLE}.hardware = 'iPhone7,2' THEN 'iPhone 6'
          WHEN ${TABLE}.hardware = 'iPhone8,1' THEN 'iPhone 6s'
          WHEN ${TABLE}.hardware = 'iPhone8,2' THEN 'iPhone 6s Plus'
          WHEN ${TABLE}.hardware = 'iPhone8,4' THEN 'iPhone SE GSM'
          WHEN ${TABLE}.hardware = 'iPhone9,1' THEN 'iPhone 7'
          WHEN ${TABLE}.hardware = 'iPhone9,2' THEN 'iPhone 7 Plus'
          WHEN ${TABLE}.hardware = 'iPhone9,3' THEN 'iPhone 7'
          WHEN ${TABLE}.hardware = 'iPhone9,4' THEN 'iPhone 7 Plus'
          WHEN ${TABLE}.hardware = 'iPhone10,1' THEN 'iPhone 8'
          WHEN ${TABLE}.hardware = 'iPhone10,2' THEN 'iPhone 8 Plus'
          WHEN ${TABLE}.hardware = 'iPhone10,3' THEN 'iPhone X Global'
          WHEN ${TABLE}.hardware = 'iPhone10,4' THEN 'iPhone 8'
          WHEN ${TABLE}.hardware = 'iPhone10,5' THEN 'iPhone 8 Plus'
          WHEN ${TABLE}.hardware = 'iPhone10,6' THEN 'iPhone X GSM'
          WHEN ${TABLE}.hardware = 'iPhone11,2' THEN 'iPhone XS'
          WHEN ${TABLE}.hardware = 'iPhone11,4' THEN 'iPhone XS Max'
          WHEN ${TABLE}.hardware = 'iPhone11,6' THEN 'iPhone XS Max Global'
          WHEN ${TABLE}.hardware = 'iPhone11,8' THEN 'iPhone XR'
          WHEN ${TABLE}.hardware = 'iPhone12,1' THEN 'iPhone 11'
          WHEN ${TABLE}.hardware = 'iPhone12,3' THEN 'iPhone 11 Pro'
          WHEN ${TABLE}.hardware = 'iPhone12,5' THEN 'iPhone 11 Pro Max'
          WHEN ${TABLE}.hardware = 'iPhone12,8' THEN 'iPhone SE - 2nd Gen'
          WHEN ${TABLE}.hardware = 'iPad4,1' THEN 'iPad Air - 1st Gen'
          WHEN ${TABLE}.hardware = 'iPad5,3' THEN 'iPad Air - 2nd Gen'
          WHEN ${TABLE}.hardware = 'iPad6,3' THEN 'iPad Pro - 9.7'
          WHEN ${TABLE}.hardware = 'iPad6,7' THEN 'iPad Pro - 12.9'
          WHEN ${TABLE}.hardware = 'iPad7,5' THEN 'iPad - 6th Gen'
          WHEN ${TABLE}.hardware = 'iPad7,11' THEN 'iPad - 7th Gen - 10.2'
          WHEN ${TABLE}.hardware = 'iPad8,11' THEN 'iPad Pro - 4th Gen - 12.9'
          WHEN ${TABLE}.hardware = 'iPad11,3' THEN 'iPad Air - 3rd Gen'
          WHEN ${TABLE}.hardware = 'samsung SM-A102U' THEN 'Samsung Galaxy A10'
          WHEN ${TABLE}.hardware = 'samsung SM-A105M' THEN 'Samsung Galaxy A10'
          WHEN ${TABLE}.hardware = 'samsung SM-A107M' THEN 'Samsung Galaxy A10'
          WHEN ${TABLE}.hardware = 'samsung SM-S102DL' THEN 'Samsung Galaxy A10'
          WHEN ${TABLE}.hardware = 'samsung SM-A207M' THEN 'Samsung Galaxy A20'
          WHEN ${TABLE}.hardware = 'samsung SM-A205U' THEN 'Samsung Galaxy A20'
          WHEN ${TABLE}.hardware = 'samsung SM-A205G' THEN 'Samsung Galaxy A20'
          WHEN ${TABLE}.hardware = 'samsung SM-A305GT' THEN 'Samsung Galaxy A20'
          WHEN ${TABLE}.hardware = 'samsung SM-A305G' THEN 'Samsung Galaxy A30'
          WHEN ${TABLE}.hardware = 'samsung SM-A307G' THEN 'Samsung Galaxy A30'
          WHEN ${TABLE}.hardware = 'samsung SM-A505G' THEN 'Samsung Galaxy A50'
          WHEN ${TABLE}.hardware = 'samsung SM-A505U' THEN 'Samsung Galaxy A50'
          WHEN ${TABLE}.hardware = 'samsung SM-M305F' THEN 'Samsung Galaxy M30'
          WHEN ${TABLE}.hardware = 'samsung SM-G935U' THEN 'Samsung Galaxy S7'
          WHEN ${TABLE}.hardware = 'samsung SM-G930V' THEN 'Samsung Galaxy S7'
          WHEN ${TABLE}.hardware = 'samsung SM-G950F' THEN 'Samsung Galaxy S8'
          WHEN ${TABLE}.hardware = 'samsung SM-G950U' THEN 'Samsung Galaxy S8'
          WHEN ${TABLE}.hardware = 'samsung SM-G955U' THEN 'Samsung Galaxy S8+'
          WHEN ${TABLE}.hardware = 'samsung SM-G960U1' THEN 'Samsung Galaxy S9'
          WHEN ${TABLE}.hardware = 'samsung SM-G960U' THEN 'Samsung Galaxy S9'
          WHEN ${TABLE}.hardware = 'samsung SM-G965U' THEN 'Samsung Galaxy S9+'
          WHEN ${TABLE}.hardware = 'samsung SM-G973U' THEN 'Samsung Galaxy S10'
          WHEN ${TABLE}.hardware = 'samsung SM-G970U' THEN 'Samsung Galaxy S10'
          WHEN ${TABLE}.hardware = 'samsung SM-G981U' THEN 'Samsung Galaxy S20'
          WHEN ${TABLE}.hardware = 'samsung SM-G986U' THEN 'Samsung Galaxy S20+'
          WHEN ${TABLE}.hardware = 'samsung SM-G532MT' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-J260M' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-G532M' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-J337AZ' THEN 'Samsung Galaxy J3'
          WHEN ${TABLE}.hardware = 'samsung SM-J400M' THEN 'Samsung Galaxy J4'
          WHEN ${TABLE}.hardware = 'samsung SM-J410G' THEN 'Samsung Galaxy J4'
          WHEN ${TABLE}.hardware = 'samsung SM-J415G' THEN 'Samsung Galaxy J4+'
          WHEN ${TABLE}.hardware = 'samsung SM-G570M' THEN 'Samsung Galaxy J5'
          WHEN ${TABLE}.hardware = 'samsung SM-J500M' THEN 'Samsung Galaxy J5'
          WHEN ${TABLE}.hardware = 'samsung SM-J600GT' THEN 'Samsung Galaxy J6'
          WHEN ${TABLE}.hardware = 'samsung SM-J610G' THEN 'Samsung Galaxy J6+'
          WHEN ${TABLE}.hardware = 'samsung SM-J737T1' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-G610M' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J710MN' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J700M' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J701M' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J701MT' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J810M' THEN 'Samsung Galaxy J8'
          WHEN ${TABLE}.hardware = 'samsung SM-N950U' THEN 'Samsung Galaxy Note8'
          WHEN ${TABLE}.hardware = 'samsung SM-N960U' THEN 'Samsung Galaxy Note9'
          WHEN ${TABLE}.hardware = 'samsung SM-N960U1' THEN 'Samsung Galaxy Note9'
          WHEN ${TABLE}.hardware = 'samsung SM-N975U' THEN 'Samsung Galaxy Note10+'
          WHEN ${TABLE}.hardware = 'samsung SM-N975U1' THEN 'Samsung Galaxy Note10+'
          WHEN ${TABLE}.hardware = 'samsung SM-T560NU' THEN 'Samsung Galaxy Tab 9.6'
          WHEN ${TABLE}.hardware = 'motorola Moto G (5) Plus' THEN 'Motorola Moto G5 Plus'
          WHEN ${TABLE}.hardware = 'motorola moto g(6) play' THEN 'Motorola moto g6 play'
          WHEN ${TABLE}.hardware = 'motorola moto g(7) play' THEN 'Motorola moto g7 play'
          WHEN ${TABLE}.hardware = 'LGE LG-LS777' THEN 'LGE Stylo 3'
          WHEN ${TABLE}.hardware = 'LGE LGMP450' THEN 'LGE Stylo Plus'
          WHEN ${TABLE}.hardware = 'LGE LM-X410(FG)' THEN 'LGE K30'
          WHEN ${TABLE}.hardware = 'LGE LGLK430' THEN 'LGE G Pad'
          WHEN ${TABLE}.hardware = 'Umx U693CL' THEN 'Assurance Wireless - Unimax 693CL'
          WHEN ${TABLE}.hardware = 'ANS L51' THEN 'Assurance Wireless - ANS L51'
          WHEN ${TABLE}.hardware = 'Yulong cp3705A' THEN 'Yulong Coolpad 3705A'
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
        END"
}

constant: device_os_version_mapping {
  value: "CASE
          WHEN ${TABLE}.platform LIKE '%iOS 13%' THEN 'iOS 13'
          WHEN ${TABLE}.platform LIKE '%iOS 12%' THEN 'iOS 12'
          WHEN ${TABLE}.platform LIKE '%iOS 11%' THEN 'iOS 11'
          WHEN ${TABLE}.platform LIKE '%iOS 10%' THEN 'iOS 10'
          WHEN ${TABLE}.platform LIKE '%iOS 10%' THEN 'iOS 10'
          WHEN ${TABLE}.platform LIKE '%Android OS 10%' THEN 'Android 10'
          WHEN ${TABLE}.platform LIKE '%Android OS 9%' THEN 'Android 9'
          WHEN ${TABLE}.platform LIKE '%Android OS 8%' THEN 'Android 8'
          WHEN ${TABLE}.platform LIKE '%Android OS 7%' THEN 'Android 7'
        END"
  }

constant: device_platform_mapping {
  value: "CASE
          WHEN ${TABLE}.platform LIKE '%iOS%' THEN 'Apple'
          WHEN ${TABLE}.platform LIKE '%Android%' THEN 'Google'
          WHEN ${TABLE}.hardware LIKE '%Chrome%' AND ${TABLE}.user_id LIKE '%facebook%' THEN 'Facebook'
        END"

}

constant: device_internal_tester_mapping {
  value: "CASE
          WHEN ${TABLE}.device_id LIKE 'fc4240714a08de28281c816896adf3cc' THEN 'Eric Jordan - Amazon Shitfire'
          WHEN ${TABLE}.device_id LIKE 'ab5d89e60aef9fa8e9349c42fdc3ac54' THEN 'Eric Jordan - Pixel 3a'
          WHEN ${TABLE}.device_id LIKE 'ab5d89e60aef9fa8e9349c42fdc3ac54' THEN 'Eric Jordan - Pixel 3a'
          WHEN ${TABLE}.device_id LIKE '9C204FCA-2B22-41CD-A2F0-F4FCCE08672B' THEN 'Robert Einspruch - iPhone 11'
          WHEN ${TABLE}.device_id LIKE '1514C433-1718-4621-BD18-2661CD888608' THEN 'Robert Einspruch - iPhone 8'
          WHEN ${TABLE}.device_id LIKE '40361030-B80C-4615-8C57-4661C411F97F' THEN 'Robert Einspruch - iPhone 6'
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

constant: release_version {
  value: "CASE
          WHEN ${TABLE}.version LIKE '1568' THEN 'Release 1.0'
          WHEN ${TABLE}.version LIKE '1579' THEN 'Release 1.0'
          WHEN ${TABLE}.version LIKE '2047' THEN 'Release 1.1'
        END"
}

constant: experiments {
  value: "CASE
  WHEN JSON_EXTRACT({TABLE}.experiments,'$.linearFirstCards_20200723') THEN 'LinearVsNonLinear'
  WHEN JSON_EXTRACT({TABLE}.experiments,'$.helper_bias_20200707') THEN 'HelperBiast'
  WHEN JSON_EXTRACT({TABLE}.experiments,'$.skill_reminder_20200707') THEN 'SkillReminder'
  WHEN JSON_EXTRACT({TABLE}.experiments,'$.more_time_reminder_20200708') THEN 'MoreTime'
  WHEN JSON_EXTRACT({TABLE}.experiments,'$.roundsForFiveToFour_20200720') THEN 'Rounds5to4'
  END"
}
