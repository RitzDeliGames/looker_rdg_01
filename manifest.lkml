
constant: playtest_group_mapping {
  value: "CASE
          WHEN ${TABLE}.device_id = '06216fe866eae677d0e2414832cd4008' THEN '1478 - 5 min'
          WHEN ${TABLE}.device_id = 'ef1dab4a1e82c50e1f3c23a6470bbbe2' THEN '1478 - 5 min'
          WHEN ${TABLE}.device_id = '0abe5bd2070a76ad05d34392b3b979be' THEN '1478 - 5 min'
          WHEN ${TABLE}.device_id = '432982c0f6a929ec3c5d427e5029ace5' THEN '1478 - 5 min'
          WHEN ${TABLE}.device_id = '469bfe58eca72d95bd308575b3df391f' THEN '1478 - 5 min'
          WHEN ${TABLE}.device_id = '35b4f1eda1136e395f33ad1f304f44ac' THEN '1478 - 5 min'
          WHEN ${TABLE}.device_id = '30dcb64c20d58f540620a490215235e0' THEN '1478 - 5 min'
          WHEN ${TABLE}.device_id = '89d7c389a8f63080aaa7e3c9c4647873' THEN '1478 - 5 min'
          WHEN ${TABLE}.device_id = 'c597b3a398f36d73b74f4e5400bf9b1d' THEN '1478 - 15 min'
          WHEN ${TABLE}.device_id = '826a20afa2bd53788a562fc3391ee7f3' THEN '1478 - 15 min'
          WHEN ${TABLE}.device_id = '06c7e98542841467847f5e38fb580cb0' THEN '1478 - 15 min'
          WHEN ${TABLE}.device_id = '2e5045324af7639cb233d0d6a0369166' THEN '1478 - 15 min'
          WHEN ${TABLE}.device_id = '44d1dc8607e0178c6f806c85e67fe9cd' THEN '1478 - 15 min'
          WHEN ${TABLE}.device_id = '0067557eac0c44a4c6b17a50afea0e8b' THEN '1478 - 15 min'
          WHEN ${TABLE}.device_id = '229c61f57795b350cca4aaf7c559c150' THEN '1478 - 15 min'
          WHEN ${TABLE}.device_id = 'ede71f9a6c8ffcc6f593c6ec19c157f9' THEN '1478 - 15 min'
          ELSE 'No Assigned Playtest Group'
        END"
}

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
          WHEN ${TABLE}.hardware = 'samsung SM-S102DL' THEN 'Samsung Galaxy A10'
          WHEN ${TABLE}.hardware = 'samsung SM-A205U' THEN 'Samsung Galaxy A20'
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
          WHEN ${TABLE}.hardware = 'samsung SM-J337AZ' THEN 'Samsung Galaxy J3'
          WHEN ${TABLE}.hardware = 'samsung SM-J400M' THEN 'Samsung Galaxy J4'
          WHEN ${TABLE}.hardware = 'samsung SM-J737T1' THEN 'Samsung Galaxy J7'
          WHEN ${TABLE}.hardware = 'samsung SM-N950U' THEN 'Samsung Galaxy Note8'
          WHEN ${TABLE}.hardware = 'samsung SM-N960U' THEN 'Samsung Galaxy Note9'
          WHEN ${TABLE}.hardware = 'samsung SM-N960U1' THEN 'Samsung Galaxy Note9'
          WHEN ${TABLE}.hardware = 'samsung SM-N975U' THEN 'Samsung Galaxy Note10+'
          WHEN ${TABLE}.hardware = 'samsung SM-N975U1' THEN 'Samsung Galaxy Note10+'
          WHEN ${TABLE}.hardware = 'samsung SM-T560NU' THEN 'Samsung Galaxy Tab 9.6'
          WHEN ${TABLE}.hardware = 'motorola Moto G (5) Plus' THEN 'Motorola Moto G5 Plus'
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
