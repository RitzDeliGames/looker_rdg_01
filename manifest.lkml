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
          WHEN ${TABLE}.hardware = 'samsung SM-M305F' THEN 'Samsung Galaxy M30'
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
          WHEN ${TABLE}.hardware = 'samsung SM-J400M' THEN 'Samsung Galaxy J4'
          WHEN ${TABLE}.hardware = 'samsung SM-N960U' THEN 'Samsung Galaxy Note9'
          WHEN ${TABLE}.hardware = 'samsung SM-N975U' THEN 'Samsung Galaxy Note10+'
          WHEN ${TABLE}.hardware = 'samsung SM-N975U1' THEN 'Samsung Galaxy Note10+'
          WHEN ${TABLE}.hardware = 'samsung SM-T560NU' THEN 'Samsung Galaxy Tab 9.6'
          WHEN ${TABLE}.hardware = 'motorola Moto G (5) Plus' THEN 'Motorola Moto G5 Plus'
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

constant: bingo_card_mapping_3x3 {
  value:"CASE
    WHEN ${card_state_str} LIKE '[%7%,%8%,%9%]'
    THEN 'row_02'
    WHEN ${card_state_str} LIKE '[%1%2%,%1%3%]'
    THEN 'row_03'
    WHEN ${card_state_str} LIKE '[%1%6%,%1%7%,%1%8%]'

    WHEN ${card_state_str} LIKE '[%7%,%1%2%,%1%6%]'
    THEN 'column_02'
    WHEN ${card_state_str} LIKE '[%8%,%1%7%]'
    THEN 'column_03'
    WHEN ${card_state_str} LIKE '[%9%,%1%3%,%1%8%]'
    THEN 'column_04'_

    WHEN ${card_state_str} LIKE '[%7%,%1%8%]'
    THEN 'diagonal_01'
    WHEN ${card_state_str} LIKE '[%9%,%1%6%]'
    THEN 'diagonal_02'
  END"
}

constant: bingo_card_mapping_5x5 {
  value:"CASE
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
  END"
}

constant: bingo_card_mapping_5x5_X {
  value:"CASE
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
  END"
}
