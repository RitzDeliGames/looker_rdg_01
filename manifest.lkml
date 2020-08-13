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
          WHEN ${TABLE}.hardware = 'samsung SM-A520F' THEN 'Samsung Galaxy A5'
          WHEN ${TABLE}.hardware = 'samsung SM-A750G' THEN 'Samsung Galaxy A7'
          WHEN ${TABLE}.hardware = 'samsung SM-A530F' THEN 'Samsung Galaxy A8'
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
          WHEN ${TABLE}.hardware = 'samsung SM-A307GT' THEN 'Samsung Galaxy A30'
          WHEN ${TABLE}.hardware = 'samsung SM-A505G' THEN 'Samsung Galaxy A50'
          WHEN ${TABLE}.hardware = 'samsung SM-A505U' THEN 'Samsung Galaxy A50'
          WHEN ${TABLE}.hardware = 'samsung SM-A505GT' THEN 'Samsung Galaxy A50'
          WHEN ${TABLE}.hardware = 'samsung SM-A515F' THEN 'Samsung Galaxy A51'
          WHEN ${TABLE}.hardware = 'samsung SM-A705MN' THEN 'Samsung Galaxy A70'
          WHEN ${TABLE}.hardware = 'samsung SM-A715F' THEN 'Samsung Galaxy A71'
          WHEN ${TABLE}.hardware = 'samsung SM-M305F' THEN 'Samsung Galaxy M30'
          WHEN ${TABLE}.hardware = 'samsung SM-G935U' THEN 'Samsung Galaxy S7'
          WHEN ${TABLE}.hardware = 'samsung SM-G930V' THEN 'Samsung Galaxy S7'
          WHEN ${TABLE}.hardware = 'samsung SM-G935F' THEN 'Samsung Galaxy S7'
          WHEN ${TABLE}.hardware = 'samsung SM-G950F' THEN 'Samsung Galaxy S8'
          WHEN ${TABLE}.hardware = 'samsung SM-G950U' THEN 'Samsung Galaxy S8'
          WHEN ${TABLE}.hardware = 'samsung SM-G955U' THEN 'Samsung Galaxy S8+'
          WHEN ${TABLE}.hardware = 'samsung SM-G955F' THEN 'Samsung Galaxy S8+'
          WHEN ${TABLE}.hardware = 'samsung SM-G960U1' THEN 'Samsung Galaxy S9'
          WHEN ${TABLE}.hardware = 'samsung SM-G960U' THEN 'Samsung Galaxy S9'
          WHEN ${TABLE}.hardware = 'samsung SM-G9600' THEN 'Samsung Galaxy S9'
          WHEN ${TABLE}.hardware = 'samsung SM-G965U' THEN 'Samsung Galaxy S9+'
          WHEN ${TABLE}.hardware = 'samsung SM-G9650' THEN 'Samsung Galaxy S9+'
          WHEN ${TABLE}.hardware = 'samsung SM-G973U' THEN 'Samsung Galaxy S10'
          WHEN ${TABLE}.hardware = 'samsung SM-G970U' THEN 'Samsung Galaxy S10'
          WHEN ${TABLE}.hardware = 'samsung SM-G975F' THEN 'Samsung Galaxy S10+'
          WHEN ${TABLE}.hardware = 'samsung SM-G981U' THEN 'Samsung Galaxy S20'
          WHEN ${TABLE}.hardware = 'samsung SM-G986U' THEN 'Samsung Galaxy S20+'
          WHEN ${TABLE}.hardware = 'samsung SM-J105B' THEN 'Samsung Galaxy J1'
          WHEN ${TABLE}.hardware = 'samsung SM-J111M' THEN 'Samsung Galaxy J1'
          WHEN ${TABLE}.hardware = 'samsung SM-J120H' THEN 'Samsung Galaxy J1'
          WHEN ${TABLE}.hardware = 'samsung SM-G532MT' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-J260M' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-G532M' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-J250M' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-J337AZ' THEN 'Samsung Galaxy J3'
          WHEN ${TABLE}.hardware = 'samsung SM-J320M' THEN 'Samsung Galaxy J3'
          WHEN ${TABLE}.hardware = 'samsung SM-J400M' THEN 'Samsung Galaxy J4'
          WHEN ${TABLE}.hardware = 'samsung SM-J410G' THEN 'Samsung Galaxy J4'
          WHEN ${TABLE}.hardware = 'samsung SM-J415G' THEN 'Samsung Galaxy J4+'
          WHEN ${TABLE}.hardware = 'samsung SM-G570M' THEN 'Samsung Galaxy J5'
          WHEN ${TABLE}.hardware = 'samsung SM-J500M' THEN 'Samsung Galaxy J5'
          WHEN ${TABLE}.hardware = 'samsung SM-J510MN' THEN 'Samsung Galaxy J5'
          WHEN ${TABLE}.hardware = 'samsung SM-J530G' THEN 'Samsung Galaxy J5'
          WHEN ${TABLE}.hardware = 'samsung SM-J600GT' THEN 'Samsung Galaxy J6'
          WHEN ${TABLE}.hardware = 'samsung SM-J600G' THEN 'Samsung Galaxy J6'
          WHEN ${TABLE}.hardware = 'samsung SM-J610G' THEN 'Samsung Galaxy J6+'
          WHEN ${TABLE}.hardware = 'samsung SM-G610M' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-G611MT' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J710MN' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J700M' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J701M' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J701MT' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J260MU' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J730G' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J730GM' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J737T1' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J810M' THEN 'Samsung Galaxy J8'
          WHEN ${TABLE}.hardware = 'samsung SM-N950U' THEN 'Samsung Galaxy Note8'
          WHEN ${TABLE}.hardware = 'samsung SM-N960U' THEN 'Samsung Galaxy Note9'
          WHEN ${TABLE}.hardware = 'samsung SM-N960U1' THEN 'Samsung Galaxy Note9'
          WHEN ${TABLE}.hardware = 'samsung SM-N975U' THEN 'Samsung Galaxy Note10+'
          WHEN ${TABLE}.hardware = 'samsung SM-N975U1' THEN 'Samsung Galaxy Note10+'
          WHEN ${TABLE}.hardware = 'samsung SM-T560NU' THEN 'Samsung Galaxy Tab 9.6'
          WHEN ${TABLE}.hardware = 'samsung SM-T113NU' THEN 'Samsung Galaxy Tab 3'
          WHEN ${TABLE}.hardware = 'samsung SM-G531H' THEN 'Samsung Grand Prime'
          WHEN ${TABLE}.hardware = 'samsung SM-G530H' THEN 'Samsung Grand Prime'
          WHEN ${TABLE}.hardware = 'motorola Moto G (5)' THEN 'Motorola moto g5'
          WHEN ${TABLE}.hardware = 'motorola Moto G (5) Plus' THEN 'Motorola Moto g5 Plus'
          WHEN ${TABLE}.hardware = 'motorola moto g(6) play' THEN 'Motorola moto g6 play'
          WHEN ${TABLE}.hardware = 'motorola moto g(7) play' THEN 'Motorola moto g7 play'
          WHEN ${TABLE}.hardware = 'motorola moto g(7) power' THEN 'Motorola moto g7 power'
          WHEN ${TABLE}.hardware = 'LGE LG-LS777' THEN 'LGE Stylo 3'
          WHEN ${TABLE}.hardware = 'LGE LGMP450' THEN 'LGE Stylo Plus'
          WHEN ${TABLE}.hardware = 'LGE LM-X410(FG)' THEN 'LGE K30'
          WHEN ${TABLE}.hardware = 'LGE LGLK430' THEN 'LGE G Pad'
          WHEN ${TABLE}.hardware = 'Umx U693CL' THEN 'Assurance Wireless - Unimax 693CL'
          WHEN ${TABLE}.hardware = 'ANS L51' THEN 'Assurance Wireless - ANS L51'
          WHEN ${TABLE}.hardware = 'Yulong cp3705A' THEN 'Yulong Coolpad 3705A'
          WHEN ${TABLE}.hardware = 'HUAWEI DRA-LX3' THEN 'Huawei Y5 2018'
          WHEN ${TABLE}.hardware = 'HUAWEI JKM-LX3' THEN 'Huawei Y9 2019'
          WHEN ${TABLE}.hardware = 'HUAWEI DUB-LX3' THEN 'Huawei Y7 2019'
          WHEN ${TABLE}.hardware = 'HUAWEI ANE-LX3' THEN 'Huawei P20 Lite'
          WHEN ${TABLE}.hardware = 'HUAWEI MAR-LX3A' THEN 'Huawei P30 Lite'
          WHEN ${TABLE}.hardware = 'HUAWEI STK-LX3' THEN 'Huawei Honor 9X'
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

constant: release_version_major {
  value: "CASE
            WHEN ${TABLE}.version LIKE '1568' THEN 'Release 1.0'
            WHEN ${TABLE}.version LIKE '1579' THEN 'Release 1.0'
            WHEN ${TABLE}.version LIKE '2047' THEN 'Release 1.1'
            WHEN ${TABLE}.version LIKE '2100' THEN 'Release 1.1'
            WHEN ${TABLE}.version LIKE '3028' THEN 'Release 1.2'
        END"
}

constant: release_version_minor {
  value: "CASE
            WHEN ${TABLE}.version LIKE '1568' THEN 'Release 1.0'
            WHEN ${TABLE}.version LIKE '1579' THEN 'Release 1.0.100'
            WHEN ${TABLE}.version LIKE '2047' THEN 'Release 1.1'
            WHEN ${TABLE}.version LIKE '2100' THEN 'Release 1.1.100'
            WHEN ${TABLE}.version LIKE '3028' THEN 'Release 1.2.28'
          END"
}

constant: experiment_ids {
  value: "CASE
            WHEN JSON_EXTRACT(${experiments},'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
            WHEN JSON_EXTRACT(${experiments},'$.linearFirstCards_20200723') != 'unassigned' THEN 'LinearVsNonLinear'
            WHEN JSON_EXTRACT(${experiments},'$.helper_bias_20200707') != 'unassigned' THEN 'HelperBias'
            WHEN JSON_EXTRACT(${experiments},'$.skill_reminder_20200707') != 'unassigned' THEN 'SkillReminder'
            WHEN JSON_EXTRACT(${experiments},'$.more_time_reminder_20200708') != 'unassigned' THEN 'MoreTime'
            WHEN JSON_EXTRACT(${experiments},'$.roundsForFiveToFour_20200720') != 'unassigned' THEN 'Rounds5to4'
          END"
}

constant: variant_ids {
  value: "CASE
            WHEN REPLACE(JSON_EXTRACT(${experiments},'$.linearFirstCards_20200723'),'\"','') LIKE '%_control' THEN 'Control'
            WHEN REPLACE(JSON_EXTRACT(${experiments},'$.linearFirstCards_20200723'),'\"','') LIKE '%_a' THEN 'Variant A'
            WHEN REPLACE(JSON_EXTRACT(${experiments},'$.linearFirstCards_20200723'),'\"','') LIKE '%_b' THEN 'Variant B'
            WHEN REPLACE(JSON_EXTRACT(${experiments},'$.linearFirstCards_20200723'),'\"','') LIKE '%_c' THEN 'Variant C'
            WHEN REPLACE(JSON_EXTRACT(${experiments},'$.lowPerformanceMode_20200803'),'\"','') LIKE '%_control' THEN 'Control'
            WHEN REPLACE(JSON_EXTRACT(${experiments},'$.lowPerformanceMode_20200803'),'\"','') LIKE '%_a' THEN 'Variant A'
            WHEN REPLACE(JSON_EXTRACT(${experiments},'$.lowPerformanceMode_20200803'),'\"','') LIKE '%_b' THEN 'Variant B'
            WHEN REPLACE(JSON_EXTRACT(${experiments},'$.lowPerformanceMode_20200803'),'\"','') LIKE '%_c' THEN 'Variant C'
          END"
}


constant: country_region {
  value: "CASE
            WHEN ${TABLE}.country LIKE 'ZZ' THEN 'N/A'
            WHEN ${TABLE}.country IN ('MX', 'PE', 'UY', 'VE', 'NI', 'PY', 'CR', 'SV', 'CL', 'BZ', 'BO', 'AR', 'CO', 'HN', 'GT', 'EC', 'PA') THEN 'LATAM-ES'
            WHEN ${TABLE}.country LIKE 'BR' THEN 'LATAM-BR'
            ELSE 'OTHER'
          END"
}

constant: minutes_since_install {
  value: "CASE
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 0 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 1 THEN '01'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 1 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 2 THEN '02'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 2 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 3 THEN '03'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 3 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 4 THEN '04'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 4 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 5 THEN '05'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 5 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 6 THEN '06'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 6 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 7 THEN '07'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 7 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 8 THEN '08'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 8 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 9 THEN '09'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 9 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 10 THEN '10'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 10 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 11 THEN '11'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 11 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 12 THEN '12'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 12 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 13 THEN '13'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 13 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 14 THEN '14'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 14 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 15 THEN '15'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 15 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 16 THEN '16'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 16 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 17 THEN '17'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 17 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 18 THEN '18'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 18 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 19 THEN '19'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 19 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 20 THEN '20'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 20 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 21 THEN '21'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 21 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 22 THEN '22'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 22 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 23 THEN '23'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 23 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 24 THEN '24'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 24 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 25 THEN '25'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 25 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 26 THEN '26'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 26 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 27 THEN '27'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 27 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 28 THEN '28'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 28 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 29 THEN '29'
            WHEN FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) > 29 and FLOOR(TIME_DIFF(TIME(timestamp), TIME(created_at), MINUTE)) <= 30 THEN '30'
            ELSE 'Min 30+'
        END"
}
