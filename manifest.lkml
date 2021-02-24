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
          WHEN ${TABLE}.hardware = 'samsung SM-A305GT' THEN 'Samsung Galaxy A30'
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
          WHEN ${TABLE}.hardware = 'samsung SM-J120M' THEN 'Samsung Galaxy J1'
          WHEN ${TABLE}.hardware = 'samsung SM-G532MT' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-J260M' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-G532M' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-J250M' THEN 'Samsung Galaxy J2'
          WHEN ${TABLE}.hardware = 'samsung SM-J260MU' THEN 'Samsung Galaxy J2'
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
          WHEN ${TABLE}.hardware = 'samsung SM-G610M' THEN 'Samsung Galaxy J7 Prime'
          WHEN ${TABLE}.hardware = 'samsung SM-G611MT' THEN 'Samsung Galaxy J7 Prime'
          WHEN ${TABLE}.hardware = 'samsung SM-J710MN' THEN 'Samsung Galaxy J7 Metal'
          WHEN ${TABLE}.hardware = 'samsung SM-J700M' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-J701M' THEN 'Samsung Galaxy J7 Neo'
          WHEN ${TABLE}.hardware = 'samsung SM-J701MT' THEN 'Samsung Galaxy J7 Neo'
          WHEN ${TABLE}.hardware = 'samsung SM-J730G' THEN 'Samsung Galaxy J7 Pro'
          WHEN ${TABLE}.hardware = 'samsung SM-J730GM' THEN 'Samsung Galaxy J7 Pro'
          WHEN ${TABLE}.hardware = 'samsung SM-J737T1' THEN 'Samsung Galaxy J7 Star'
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
          WHEN ${TABLE}.hardware LIKE '%Lenovo%' THEN 'Lenovo'
        END"
}

constant: device_os_version_mapping {
  value: "CASE
          WHEN ${TABLE}.platform LIKE '%iOS 13%' THEN 'iOS 14'
          WHEN ${TABLE}.platform LIKE '%iOS 13%' THEN 'iOS 13'
          WHEN ${TABLE}.platform LIKE '%iOS 12%' THEN 'iOS 12'
          WHEN ${TABLE}.platform LIKE '%iOS 11%' THEN 'iOS 11'
          WHEN ${TABLE}.platform LIKE '%iOS 10%' THEN 'iOS 10'
          WHEN ${TABLE}.platform LIKE '%iOS 10%' THEN 'iOS 10'
          WHEN ${TABLE}.platform LIKE '%Android OS 10%' THEN 'Android 11'
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
            WHEN ${TABLE}.version LIKE '1568' THEN '1.0'
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
        END"
}

constant: install_release_version_major {
  value: "CASE
            WHEN ${TABLE}.install_version LIKE '1568' THEN '1.0'
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
        END"
}

constant: release_version_minor {
  value: "CASE
            WHEN ${TABLE}.version LIKE '1568' THEN '1.0.001'
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
          END"
}

constant: install_release_version_minor {
  value: "CASE
            WHEN ${TABLE}.install_version LIKE '1568' THEN '1.0.001'
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
          END"
}

constant: experiment_ids {
  value: "CASE
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
            WHEN JSON_EXTRACT(${experiments},'$.earlyExitContent_20200909') != 'unassigned' THEN 'EarlyExit2'
            WHEN JSON_EXTRACT(${experiments},'$.earlyExit_20200828') != 'unassigned' THEN 'EarlyExit'
            WHEN JSON_EXTRACT(${experiments},'$.notifications_20200824') != 'unassigned' THEN 'Notifications'
            WHEN JSON_EXTRACT(${experiments},'$.lazyLoadOtherTabs_20200901') != 'unassigned' THEN 'LazyLoad'
            WHEN JSON_EXTRACT(${experiments},'$.tabFueTiming_20200825') != 'unassigned' THEN 'FUETiming'
            WHEN JSON_EXTRACT(${experiments},'$.bingoEasyEarlyVariants_20200608') != 'unassigned' THEN 'EasyEarlyBingoCardVariants'
            WHEN JSON_EXTRACT(${experiments},'$.lowPerformanceMode_20200803') != 'unassigned' THEN 'LowPerformanceMode'
          END"
}

constant: variant_ids {
  value: "CASE
            WHEN ${experiment_names} = 'AskForHelp v1' THEN JSON_EXTRACT(${experiments},'$.askForHelp_20210112')
            WHEN ${experiment_names} = 'DailyRewards v1' THEN JSON_EXTRACT(${experiments},'$.dailyRewards_20210112')
            WHEN ${experiment_names} = 'FUE/Story v1' THEN JSON_EXTRACT(${experiments},'$.fueStory_20210215')
            WHEN ${experiment_names} = 'SkillReminder v2' THEN JSON_EXTRACT(${experiments},'$.skillReminder_20200204')
            WHEN ${experiment_names} = 'NewUX2' THEN JSON_EXTRACT(${experiments},'$.newVsOld_20210108')
            WHEN ${experiment_names} = 'NewUX' THEN JSON_EXTRACT(${experiments},'$.newVsOld_20201218')
            WHEN ${experiment_names} = 'TransitionTiming' THEN JSON_EXTRACT(${experiments},'$.transitionDelay_20201217')
            WHEN ${experiment_names} = 'NewEoR' THEN JSON_EXTRACT(${experiments},'$.endOfRound_20201204')
            WHEN ${experiment_names} = 'WorldMap' THEN JSON_EXTRACT(${experiments},'$.worldmap_20201028')
            WHEN ${experiment_names} = 'EarlyContent3' THEN JSON_EXTRACT(${experiments},'$.content_20201130')
            WHEN ${experiment_names} = 'LaterLinear' THEN JSON_EXTRACT(${experiments},'$.laterLinearTest_20201111')
            WHEN ${experiment_names} = 'EarlyContent2' THEN JSON_EXTRACT(${experiments},'$.content_20201106')
            WHEN ${experiment_names} = 'VFXTreshold' THEN JSON_EXTRACT(${experiments},'$.vfx_threshold_20201102')
            WHEN ${experiment_names} = 'LastBonus' THEN JSON_EXTRACT(${experiments},'$.last_bonus_20201105')
            WHEN ${experiment_names} = 'UntimedMode' THEN JSON_EXTRACT(${experiments},'$.untimed_20200918')
            WHEN ${experiment_names} = 'EarlyContent' THEN JSON_EXTRACT(${experiments},'$.content_20201005')
            WHEN ${experiment_names} = 'SecondsPerRound' THEN JSON_EXTRACT(${experiments},'$.secondsPerRound_20200922')
            WHEN ${experiment_names} = 'EarlyExit2' THEN JSON_EXTRACT(${experiments},'$.earlyExitContent_20200909')
            WHEN ${experiment_names} = 'EarlyExit' THEN JSON_EXTRACT(${experiments},'$.earlyExit_20200828')
            WHEN ${experiment_names} = 'Notifications' THEN JSON_EXTRACT(${experiments},'$.notifications_20200824')
            WHEN ${experiment_names} = 'LazyLoad' THEN JSON_EXTRACT(${experiments},'$.lazyLoadOtherTabs_20200901')
            WHEN ${experiment_names} = 'FUETiming' THEN JSON_EXTRACT(${experiments},'$.tabFueTiming_20200825')
            WHEN ${experiment_names} = 'EasyEarlyBingoCardVariants' THEN JSON_EXTRACT(${experiments},'$.bingoEasyEarlyVariants_20200608')
            WHEN ${experiment_names} = 'LowPerformanceMode' THEN JSON_EXTRACT(${experiments},'$.lowPerformanceMode_20200803')
          END"
}

constant: country_region {
  value: "CASE
            WHEN ${TABLE}.country LIKE 'ZZ' THEN 'N/A'
            WHEN ${TABLE}.country IN ('AR','BO', 'CO','MX', 'PE', 'UY', 'VE', 'NI', 'PY', 'CR', 'SV', 'CL', 'BZ', 'HN', 'GT', 'EC', 'PA') THEN 'LATAM-ES'
            WHEN ${TABLE}.country LIKE 'BR' THEN 'LATAM-BR'
            WHEN ${TABLE}.country IN ('GB', 'IE', 'ES') THEN 'UK-EU'
            ELSE 'OTHER'
          END"
}

constant: current_card_numbered {
  value: "CASE
              WHEN ${TABLE}.current_card = 'card_001_a' THEN 100
              WHEN ${TABLE}.current_card = 'card_001_untimed' THEN 100
              WHEN ${TABLE}.current_card = 'card_002_a' THEN 200
              WHEN ${TABLE}.current_card = 'card_002_untimed' THEN 200
              WHEN ${TABLE}.current_card = 'card_003_a' THEN 300
              WHEN ${TABLE}.current_card = 'card_003_untimed' THEN 300
              WHEN ${TABLE}.current_card = 'card_002' THEN 400
              WHEN ${TABLE}.current_card = 'card_039' THEN 400
              WHEN ${TABLE}.current_card = 'card_004_untimed' THEN 400
              WHEN ${TABLE}.current_card = 'card_003' THEN 500
              WHEN ${TABLE}.current_card = 'card_040' THEN 500
              WHEN ${TABLE}.current_card = 'card_005_untimed' THEN 500
              WHEN ${TABLE}.current_card = 'card_004' THEN 600
              WHEN ${TABLE}.current_card = 'card_041' THEN 600
              WHEN ${TABLE}.current_card = 'card_006_untimed' THEN 600
              WHEN ${TABLE}.current_card = 'card_005' THEN 700
              WHEN ${TABLE}.current_card = 'card_006' THEN 800
              WHEN ${TABLE}.current_card = 'card_007' THEN 900
              WHEN ${TABLE}.current_card = 'card_008' THEN 1000
              WHEN ${TABLE}.current_card = 'card_009' THEN 1100
              WHEN ${TABLE}.current_card = 'card_010' THEN 1200
              WHEN ${TABLE}.current_card = 'card_011' THEN 1300
              WHEN ${TABLE}.current_card = 'card_012' THEN 1400
              WHEN ${TABLE}.current_card = 'card_013' THEN 1500
              WHEN ${TABLE}.current_card = 'card_014' THEN 1600
              WHEN ${TABLE}.current_card = 'card_015' THEN 1700
              WHEN ${TABLE}.current_card = 'card_016' THEN 1800
              WHEN ${TABLE}.current_card = 'card_017' THEN 1900
              WHEN ${TABLE}.current_card = 'card_018' THEN 2000
              WHEN ${TABLE}.current_card = 'card_019' THEN 2100
              WHEN ${TABLE}.current_card = 'card_020' THEN 2200
          END"
}


constant: request_card_numbered {
  value: "CASE
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_001_a' THEN 100
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_001_untimed' THEN 100
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_002_a' THEN 200
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_002_untimed' THEN 200
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_003_a' THEN 300
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_003_untimed' THEN 300
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_002' THEN 400
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_039' THEN 400
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = = 'card_004_untimed' THEN 400
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = = 'card_003' THEN 500
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_040' THEN 500
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_005_untimed' THEN 500
            WHEN JSON_EXTRACT_SCALAR(extra_json_afh,'$.request_card_id') = 'card_004' THEN 600
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
              ELSE 'OTHER'
          END"
}

constant: purchase_iap_strings {
  value: "CASE
              WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_008' THEN 'Peewee Gem Capsule'
              WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_009' THEN 'Small Gem Capsule'
              WHEN JSON_EXTRACT_SCALAR(${TABLE}.extra_json,'$.sheet_id') LIKE '%item_010' THEN 'Medium Gem Capsule'
              ELSE 'OTHER'
          END"
}
