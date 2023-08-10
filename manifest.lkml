#https://gist.github.com/adamawolf/3048717
constant: device_model_mapping {
  value: "CASE
          when ${TABLE}.hardware = 'iPhone6,1' THEN 'iPhone 5S'
          when ${TABLE}.hardware = 'iPhone6,2' THEN 'iPhone 5S'
          when ${TABLE}.hardware = 'iPhone7,1' THEN 'iPhone 6 Plus'
          when ${TABLE}.hardware = 'iPhone7,2' THEN 'iPhone 6'
          when ${TABLE}.hardware = 'iPhone8,1' THEN 'iPhone 6s'
          when ${TABLE}.hardware = 'iPhone8,2' THEN 'iPhone 6s Plus'
          when ${TABLE}.hardware = 'iPhone8,4' THEN 'iPhone SE'
          when ${TABLE}.hardware = 'iPhone9,1' THEN 'iPhone 7'
          when ${TABLE}.hardware = 'iPhone9,2' THEN 'iPhone 7 Plus'
          when ${TABLE}.hardware = 'iPhone9,3' THEN 'iPhone 7'
          when ${TABLE}.hardware = 'iPhone9,4' THEN 'iPhone 7 Plus'
          when ${TABLE}.hardware = 'iPhone10,1' THEN 'iPhone 8'
          when ${TABLE}.hardware = 'iPhone10,2' THEN 'iPhone 8 Plus'
          when ${TABLE}.hardware = 'iPhone10,3' THEN 'iPhone X'
          when ${TABLE}.hardware = 'iPhone10,4' THEN 'iPhone 8'
          when ${TABLE}.hardware = 'iPhone10,5' THEN 'iPhone 8 Plus'
          when ${TABLE}.hardware = 'iPhone10,6' THEN 'iPhone X'
          when ${TABLE}.hardware = 'iPhone11,2' THEN 'iPhone XS'
          when ${TABLE}.hardware = 'iPhone11,4' THEN 'iPhone XS Max'
          when ${TABLE}.hardware = 'iPhone11,6' THEN 'iPhone XS Max'
          when ${TABLE}.hardware = 'iPhone11,8' THEN 'iPhone XR'
          when ${TABLE}.hardware = 'iPhone12,1' THEN 'iPhone 11'
          when ${TABLE}.hardware = 'iPhone12,3' THEN 'iPhone 11 Pro'
          when ${TABLE}.hardware = 'iPhone12,5' THEN 'iPhone 11 Pro Max'
          when ${TABLE}.hardware = 'iPhone12,8' THEN 'iPhone SE - 2nd Gen'
          when ${TABLE}.hardware = 'iPad4,1' THEN 'iPad Air - 1st Gen'
          when ${TABLE}.hardware = 'iPad5,3' THEN 'iPad Air - 2nd Gen'
          when ${TABLE}.hardware = 'iPad11,3' THEN 'iPad Air - 3rd Gen'
          when ${TABLE}.hardware = 'iPad6,3' THEN 'iPad Pro'
          when ${TABLE}.hardware = 'iPad6,7' THEN 'iPad Pro'
          when ${TABLE}.hardware = 'iPad7,3' THEN 'iPad Pro - 3rd Gen'
          when ${TABLE}.hardware = 'iPad8,11' THEN 'iPad Pro - 4th Gen'
          when ${TABLE}.hardware = 'iPad6,11' THEN 'iPad - 5th Gen'
          when ${TABLE}.hardware = 'iPad7,5' THEN 'iPad - 6th Gen'
          when ${TABLE}.hardware = 'iPad7,11' THEN 'iPad - 7th Gen'
          when ${TABLE}.hardware = 'iPad5,1' THEN 'iPad Mini - 4th Gen'
          ELSE ${TABLE}.hardware
        END"
}

constant: device_manufacturer_mapping{
  value: "case
            when ${TABLE}.hardware like '%iPhone%' THEN 'Apple'
            when ${TABLE}.hardware like '%iPad%' THEN 'Apple'
            when ${TABLE}.hardware like '%Pixel%' THEN 'Google'
            when ${TABLE}.hardware like '%samsung%' THEN 'Samsung'
            when ${TABLE}.hardware like '%LG%' THEN 'LG'
            when ${TABLE}.hardware like '%moto%' THEN 'Motorola'
            when ${TABLE}.hardware like '%Huawei%' THEN 'Huawei'
            when ${TABLE}.hardware like '%HUAWEI%' THEN 'Huawei'
            when ${TABLE}.hardware like '%Lenovo%' THEN 'Lenovo'
            when ${TABLE}.hardware like '%Xiaomi%' THEN 'Xiaomi'
            when ${TABLE}.hardware like '%ZTE%' THEN 'ZTE'
            when ${TABLE}.hardware like '%zte%' THEN 'ZTE'
            when ${TABLE}.hardware like '%ZUUM%' THEN 'ZUUM'
            when ${TABLE}.hardware like '%Asus%' THEN 'Asus'
            when ${TABLE}.hardware like '%asus%' THEN 'Asus'
            when ${TABLE}.hardware like '%Acer%' THEN 'Acer'
            when ${TABLE}.hardware like '%Sony%' THEN 'Sony'
            when ${TABLE}.hardware like '%Amazon%' THEN 'Amazon Shit Device'
            when ${TABLE}.hardware like '%TCL%' THEN 'TCL'
            when ${TABLE}.hardware like '%onn%' THEN 'OnePlus'
            when ${TABLE}.hardware like '%OnePlus%' THEN 'OnePlus'
            when ${TABLE}.hardware like '%OPPO%' THEN 'OPPO'
            when ${TABLE}.hardware like '%Alco%' THEN 'Alco'
            when ${TABLE}.hardware like '%BLU%' THEN 'BLU'
            when ${TABLE}.hardware like '%HMD%' THEN 'Nokia'
            when ${TABLE}.hardware like '%Nokia%' THEN 'Nokia'
            when ${TABLE}.hardware like '%Hisense%' THEN 'Hisense'
            when ${TABLE}.hardware like '%HTC%' THEN 'HTC'
            else ${TABLE}.hardware
          end"
}

constant: device_os_version_mapping {
  value: "CASE
          when ${TABLE}.platform like '%iOS 16%' THEN 'iOS 16'
          when ${TABLE}.platform like '%iOS 15%' THEN 'iOS 15'
          when ${TABLE}.platform like '%iOS 14%' THEN 'iOS 14'
          when ${TABLE}.platform like '%iOS 13%' THEN 'iOS 13'
          when ${TABLE}.platform like '%iOS 12%' THEN 'iOS 12'
          when ${TABLE}.platform like '%iOS 11%' THEN 'iOS 11'
          when ${TABLE}.platform like '%iOS 10%' THEN 'iOS 10'
          when ${TABLE}.platform like '%Android OS 12%' THEN 'Android 12'
          when ${TABLE}.platform like '%Android OS 11%' THEN 'Android 11'
          when ${TABLE}.platform like '%Android OS 10%' THEN 'Android 10'
          when ${TABLE}.platform like '%Android OS 9%' THEN 'Android 9'
          when ${TABLE}.platform like '%Android OS 8%' THEN 'Android 8'
          when ${TABLE}.platform like '%Android OS 7%' THEN 'Android 7'
          when ${TABLE}.platform like '%Android OS 6%' THEN 'Android 6'
          when ${TABLE}.platform like '%Android OS 5%' THEN 'Android 5'
          when ${TABLE}.platform like '%Android OS 4%' THEN 'Android 4'
        END"
  }

constant: device_platform_mapping {
  value: "case
            when ${TABLE}.platform like '%iOS%' then 'Apple'
            when ${TABLE}.platform like '%Android%' then 'Google'
            else 'Other'
          end"

}

constant: release_version_minor {
  value: "case
            when ${TABLE}.version = '1579' then'1.0.100'
            when ${TABLE}.version = '2047' then'1.1.001'
            when ${TABLE}.version = '2100' then'1.1.100'
            when ${TABLE}.version = '3028' then'1.2.028'
            when ${TABLE}.version = '3043' then'1.2.043'
            when ${TABLE}.version = '3100' then'1.2.100'
            when ${TABLE}.version = '4017' then'1.3.017'
            when ${TABLE}.version = '4100' then'1.3.100'
            when ${TABLE}.version = '5006' then'1.5.006'
            when ${TABLE}.version = '5100' then'1.5.100'
            when ${TABLE}.version = '6100' then'1.6.100'
            when ${TABLE}.version = '6200' then'1.6.200'
            when ${TABLE}.version = '6300' then'1.6.300'
            when ${TABLE}.version = '6400' then'1.6.400'
            when ${TABLE}.version = '7100' then'1.7.100'
            when ${TABLE}.version = '7200' then'1.7.200'
            when ${TABLE}.version = '7300' then'1.7.300'
            when ${TABLE}.version = '7400' then'1.7.400'
            when ${TABLE}.version = '7500' then'1.7.500'
            when ${TABLE}.version = '7600' then'1.7.600'
            when ${TABLE}.version = '8000' then'1.8.000'
            when ${TABLE}.version = '8100' then'1.8.100'
            when ${TABLE}.version = '8200' then'1.8.200'
            when ${TABLE}.version = '8300' then'1.8.300'
            when ${TABLE}.version = '8400' then'1.8.400'
            when ${TABLE}.version = '9100' then'1.9.100'
            when ${TABLE}.version = '9200' then'1.9.200'
            when ${TABLE}.version = '9300' then'1.9.300'
            when ${TABLE}.version = '9400' then'1.9.400'
            when ${TABLE}.version = '9500' then'1.9.500'
            when ${TABLE}.version = '10100' then'1.10.100'
            when ${TABLE}.version = '10200' then'1.10.200'
            when ${TABLE}.version = '10300' then'1.10.300'
            when ${TABLE}.version = '10400' then'1.10.400'
            when ${TABLE}.version = '10500' then'1.10.500'
            when ${TABLE}.version = '10600' then'1.10.600'
            when ${TABLE}.version = '10800' then'1.10.800'
            when ${TABLE}.version = '10900' then'1.10.900'
            when ${TABLE}.version = '10950' then'1.10.950'
            when ${TABLE}.version = '11100' then'1.11.100'
            when ${TABLE}.version = '11200' then'1.11.200'
            when ${TABLE}.version = '11300' then'1.11.300'
            when ${TABLE}.version = '11400' then'1.11.400'
            when ${TABLE}.version = '11500' then'1.11.500'
            when ${TABLE}.version = '11600' then'1.11.600'
            when ${TABLE}.version = '11800' then'1.11.800'
            when ${TABLE}.version = '11860' then'1.11.860'
            when ${TABLE}.version = '11870' then'1.11.870'
            when ${TABLE}.version = '12200' then'1.12.200'
            when ${TABLE}.version = '12300' then'1.12.300'
            when ${TABLE}.version = '12400' then'1.12.400'
            when ${TABLE}.version = '12500' then'1.12.500'
            when ${TABLE}.version = '12700' then'1.12.700'
            when ${TABLE}.version = '12840' then'1.12.840'
            when ${TABLE}.version = '12850' then'1.12.850'
            when ${TABLE}.version = '12870' then'1.12.870'
            when ${TABLE}.version = '12906' then'1.12.906'
            when ${TABLE}.version = '12911' then'1.12.911'
            when ${TABLE}.version = '12920' then'1.12.920'
            when ${TABLE}.version = '12934' then'1.12.934'
            when ${TABLE}.version = '12940' then'1.12.940'
            when ${TABLE}.version = '12952' then'1.12.952'
            when ${TABLE}.version = '12956' then'1.12.956'
            when ${TABLE}.version = '12961' then'1.12.961'
            when ${TABLE}.version = '12971' then'1.12.971'
            when ${TABLE}.version = '13002' then'1.13.002'
            when ${TABLE}.version = '13012' then'1.13.012'
            when ${TABLE}.version = '13021' then'1.13.021'
            when ${TABLE}.version = '13030' then'1.13.030'
            when ${TABLE}.version = '13031' then'1.13.031'
            when ${TABLE}.version = '13044' then'1.13.044'
            when ${TABLE}.version = '13050' then'1.13.050'
            when ${TABLE}.version = '13052' then'1.13.052'
            when ${TABLE}.version = '13053' then'1.13.053'
            when ${TABLE}.version = '13075' then'1.13.075'
            when ${TABLE}.version = '13083' then'1.13.083'
            when ${TABLE}.version = '13084' then'1.13.084'
            when ${TABLE}.version = '13092' then'1.13.092'
            when ${TABLE}.version = '13093' then'1.13.093'
            when ${TABLE}.version = '13101' then'1.13.101'
            when ${TABLE}.version = '13114' then'1.13.114'
            when ${TABLE}.version = '13115' then'1.13.115'
            when ${TABLE}.version = '13116' then'1.13.116'
            when ${TABLE}.version = '13117' then'1.13.117'
            when ${TABLE}.version = '13131' then'1.13.131'
            else ''
          end"
}

constant: install_release_version_minor {
  value: "case
            when coalesce(${TABLE}.install_version,${TABLE}.version) = '1579' then'1.0.100'
            when coalesce(${TABLE}.install_version,${TABLE}.version) = '2047' then'1.1.001'
            when coalesce(${TABLE}.install_version,${TABLE}.version) = '2100' then'1.1.100'
            when coalesce(${TABLE}.install_version,${TABLE}.version) = '3028' then'1.2.028'
            when coalesce(${TABLE}.install_version,${TABLE}.version) = '3043' then'1.2.043'
            when coalesce(${TABLE}.install_version,${TABLE}.version) = '3100' then'1.2.100'
            when coalesce(${TABLE}.install_version,${TABLE}.version) = '4017' then'1.3.017'
            when coalesce(${TABLE}.install_version,${TABLE}.version) = '4100' then'1.3.100'
            when ${TABLE}.install_version = '5006' then'1.5.006'
            when ${TABLE}.install_version = '5100' then'1.5.100'
            when ${TABLE}.install_version = '6100' then'1.6.100'
            when ${TABLE}.install_version = '6200' then'1.6.200'
            when ${TABLE}.install_version = '6300' then'1.6.300'
            when ${TABLE}.install_version = '6400' then'1.6.400'
            when ${TABLE}.install_version = '7100' then'1.7.100'
            when ${TABLE}.install_version = '7200' then'1.7.200'
            when ${TABLE}.install_version = '7300' then'1.7.300'
            when ${TABLE}.install_version = '7400' then'1.7.400'
            when ${TABLE}.install_version = '7500' then'1.7.500'
            when ${TABLE}.install_version = '7600' then'1.7.600'
            when ${TABLE}.install_version = '8000' then'1.8.000'
            when ${TABLE}.install_version = '8100' then'1.8.100'
            when ${TABLE}.install_version = '8200' then'1.8.200'
            when ${TABLE}.install_version = '8300' then'1.8.300'
            when ${TABLE}.install_version = '8400' then'1.8.400'
            when ${TABLE}.install_version = '9100' then'1.9.100'
            when ${TABLE}.install_version = '9200' then'1.9.200'
            when ${TABLE}.install_version = '9300' then'1.9.300'
            when ${TABLE}.install_version = '9400' then'1.9.400'
            when ${TABLE}.install_version = '9500' then'1.9.500'
            when ${TABLE}.install_version = '10100' then'1.10.100'
            when ${TABLE}.install_version = '10200' then'1.10.200'
            when ${TABLE}.install_version = '10300' then'1.10.300'
            when ${TABLE}.install_version = '10400' then'1.10.400'
            when ${TABLE}.install_version = '10500' then'1.10.500'
            when ${TABLE}.install_version = '10600' then'1.10.600'
            when ${TABLE}.install_version = '10800' then'1.10.800'
            when ${TABLE}.install_version = '10900' then'1.10.900'
            when ${TABLE}.install_version = '10950' then'1.10.950'
            when ${TABLE}.install_version = '11100' then'1.11.100'
            when ${TABLE}.install_version = '11200' then'1.11.200'
            when ${TABLE}.install_version = '11300' then'1.11.300'
            when ${TABLE}.install_version = '11400' then'1.11.400'
            when ${TABLE}.install_version = '11500' then'1.11.500'
            when ${TABLE}.install_version = '11600' then'1.11.600'
            when ${TABLE}.install_version = '11800' then'1.11.800'
            when ${TABLE}.install_version = '11860' then'1.11.860'
            when ${TABLE}.install_version = '11870' then'1.11.870'
            when ${TABLE}.install_version = '12200' then'1.12.200'
            when ${TABLE}.install_version = '12300' then'1.12.300'
            when ${TABLE}.install_version = '12400' then'1.12.400'
            when ${TABLE}.install_version = '12500' then'1.12.500'
            when ${TABLE}.install_version = '12700' then'1.12.700'
            when ${TABLE}.install_version = '12840' then'1.12.840'
            when ${TABLE}.install_version = '12850' then'1.12.850'
            when ${TABLE}.install_version = '12870' then'1.12.870'
            when ${TABLE}.install_version = '12906' then'1.12.906'
            when ${TABLE}.install_version = '12911' then'1.12.911'
            when ${TABLE}.install_version = '12920' then'1.12.920'
            when ${TABLE}.install_version = '12934' then'1.12.934'
            when ${TABLE}.install_version = '12940' then'1.12.940'
            when ${TABLE}.install_version = '12952' then'1.12.952'
            when ${TABLE}.install_version = '12956' then'1.12.956'
            when ${TABLE}.install_version = '12961' then'1.12.961'
            when ${TABLE}.install_version = '12971' then'1.12.971'
            when ${TABLE}.install_version = '13002' then'1.13.002'
            when ${TABLE}.install_version = '13012' then'1.13.012'
            when ${TABLE}.install_version = '13021' then'1.13.021'
            when ${TABLE}.install_version = '13030' then'1.13.030'
            when ${TABLE}.install_version = '13031' then'1.13.031'
            when ${TABLE}.install_version = '13044' then'1.13.044'
            when ${TABLE}.install_version = '13050' then'1.13.050'
            when ${TABLE}.install_version = '13052' then'1.13.052'
            when ${TABLE}.install_version = '13053' then'1.13.053'
            when ${TABLE}.install_version = '13075' then'1.13.075'
            when ${TABLE}.install_version = '13083' then'1.13.083'
            when ${TABLE}.install_version = '13084' then'1.13.084'
            when ${TABLE}.install_version = '13092' then'1.13.092'
            when ${TABLE}.install_version = '13093' then'1.13.093'
            when ${TABLE}.install_version = '13101' then'1.13.101'
            when ${TABLE}.install_version = '13114' then'1.13.114'
            when ${TABLE}.install_version = '13115' then'1.13.115'
            when ${TABLE}.install_version = '13116' then'1.13.116'
            when ${TABLE}.install_version = '13117' then'1.13.117'
            when ${TABLE}.install_version = '13131' then'1.13.131'
            else ''
          end"
}

constant: country_region {
  value: "case
            when ${TABLE}.country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE') then 'LATAM-ES'
            when ${TABLE}.country = 'BR' then 'LATAM-BR'
            when ${TABLE}.country in ('SE','DK','FI','IS','NO','SE') then 'Scandinavia'
            when ${TABLE}.country in ('GB','AT','BE','BG','CH','CY','CZ','ES','EE','FR','DE','GR','HR','HU','IE','IT','LV','LT','LU','MT','NL','PL','PT','RO','SK','SI','TR') then 'UK-EU'
            when ${TABLE}.country in ('US','CA') then 'USA & Canada'
            when ${TABLE}.country in ('JP','HK','KR','TW') then 'East Asia xChina'
            when ${TABLE}.country in ('ID','IN','MY','PH','SG','TH','VN') then 'SE Asia & India'
            when ${TABLE}.country in ('AU', 'NZ') then 'AU-NZ'
            else 'OTHER'
          end"
}

constant: iap_id_strings {
  value: "case
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_001' then 'Free Ticket Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_017' then 'Free Coin Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_018' then 'Free Boost Machine'
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
            when json_extract_scalar(extra_json,'$.iap_id') = 'COLOR_BALL' then 'Color Ball Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'BOMB' then 'Bomb Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'ROCKET' then 'Rocket Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'clear_cell' then 'Clear Cell Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'clear_vertical' then '1x Clear Vertical Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'clear_horizontal' then '1x Clear Horizontal Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_clear_cell' then '1x Clear Cell Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_clear_cell_bulk' then '5x Clear Cell Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_clear_horizontal' then '1x Clear Horizontal Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_clear_horizontal_bulk' then '5x Clear Horizontal Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_clear_vertical' then '1x Clear Vertical Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_clear_vertical_bulk' then '5x Clear Vertical Skill'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_rocket' then '1x Rocket Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_rocket_bulk' then '8x Rocket Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_color_ball' then '1x Color Ball Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_color_ball_bulk' then '5x Color Ball Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_bomb' then '1x Bomb Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_bomb_bulk' then '6x Bomb Boost'
            when json_extract_scalar(extra_json,'$.iap_id') = 'extra_moves_5' then '5x Extra Moves'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_051' then 'Giant Power Up Pack!'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_052' then 'Hammer Chum Chums & Coins Special!'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_054' then 'Vertical Chum Chums & Coins Special!'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_055' then 'Few More Coins'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_056' then 'More Coins'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_057' then 'A Lot of Coins!'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_058' then 'Few More Lives'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_059' then 'More Lives'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_060' then 'A Lot of Lives!'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_063' then 'Treasure Trove (XS)'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_066' then 'Treasure Trove (S)'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_069' then 'Treasure Trove (M)'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_072' then 'Treasure Trove (L)'
            else json_extract_scalar(extra_json,'$.iap_id')
          end"
}

constant: iap_id_strings_grouped {
  value: "case
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_001' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_017' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_018' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_004' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_005' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_006' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_007' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_020' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_021' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_057' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_008' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_026' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_009' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_010' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_011' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_012' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_013' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_023' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_014' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_015' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_016' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_024' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_025' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_028' then '24h Infinite Lives'
            when json_extract_scalar(extra_json,'$.iap_id') = 'item_037' then 'Lives & Coins Bundle'
            when json_extract_scalar(extra_json,'$.iap_id') = 'boost_001' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') = 'boost_002' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') = 'boost_003' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') = 'boost_004' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') = 'boost_005' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') = 'boost_006' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') = 'box_000' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') = 'box_004' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') = 'box_005' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like '%clear_cell%' then 'Chum Chum Skills'
            when json_extract_scalar(extra_json,'$.iap_id') like '%clear_horizontal%' then 'Chum Chum Skills'
            when json_extract_scalar(extra_json,'$.iap_id') like '%clear_vertical%' then 'Chum Chum Skills'
            when json_extract_scalar(extra_json,'$.iap_id') like '%bomb%' then 'Pre-Game Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like '%rocket%' then 'Pre-Game Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like '%color_ball%' then 'Pre-Game Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like '%zone%' then 'Zone Restoration'
            when json_extract_scalar(extra_json,'$.iap_id') like '%extra_moves%' then 'Extra Moves'
            else json_extract_scalar(extra_json,'$.iap_id')
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
            when json_extract_scalar(extra_json,'$.ui_action') = 'btn_positive' then 'Rate Us'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Rate Us%' then 'Rate Us'
            when json_extract_scalar(extra_json,'$.ui_action') like '%tarde%' then 'Later'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Luego%' then 'Later'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Depois%' then 'Later'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Permitir%' then 'Enable'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Habilitar%' then 'Enable'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Si%' then 'Yes'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Sí%' then 'Yes'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Sim%' then 'Yes'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Não%' then 'No'
            when json_extract_scalar(extra_json,'$.ui_action') like '%No%' then 'No'
            when json_extract_scalar(extra_json,'$.ui_action') = 'Ok' then 'Yes'
            when json_extract_scalar(extra_json,'$.ui_action') like '%Yes%' then 'Yes'
            when json_extract_scalar(extra_json,'$.ui_action') = '¡Juega ahora!' then 'Play Now'
            when json_extract_scalar(extra_json,'$.ui_action') = 'Jogue agora!' then 'Play Now'
            when json_extract_scalar(extra_json,'$.ui_action') = 'item_035' then 'Purchase - 24 Hours Infinite Lives'
            when json_extract_scalar(extra_json,'$.ui_action') = 'item_037' then 'Purchase - CE 202109_a - Lives & Coins Bundle'
            when json_extract_scalar(extra_json,'$.ui_action') = 'Actualizar' then 'Update'
            when json_extract_scalar(extra_json,'$.ui_action') = 'Atualizar' then 'Update'
            when json_extract_scalar(extra_json,'$.ui_action') = 'close' then 'Close'
            when json_extract_scalar(extra_json,'$.ui_action') = 'OverlayClose' then 'Close'
            else json_extract_scalar(extra_json,'$.ui_action')
          end"
}

constant: button_tags {
  value: "case
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneHome.Tasks' then 'Zones Home - Open'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneHome.Play' then 'Zones Home - Play'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneHome.NewZone' then 'Zones Home - New Zone'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_Zones.Restore' then 'Zone Task List - Restore'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_Zones.Close' then 'Zone Task List - Close'
            when json_extract_scalar(extra_json,'$.button_tag') like '%Panel_ZoneExplorer.Zone.%' then 'Zone Explorer'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndOfRound_Success.Collect' then 'Mini-Game - EoR - Collect'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndOfRound_Failure.TryAgain' then 'Mini-Game - EoR - Try Again'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndOfRound_Success.WatchAd' then 'Mini-Game - EoR - Watch Ad'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndOfRound_BuyExtra.Continue' then 'Mini-Game - Extra Moves - Continue'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndOfRound_BuyExtra.Close' then 'Mini-Game - Extra Moves - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_FirstComboPowerup.Continue' then 'Mini-Game - FUE - First Combo'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_StreakBonusInfo.PlayFromQuest' then 'Mini-Game - EoR - Streak Bonus - Continue'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_PreGame.Close' then 'Mini-Game - Pre-Game - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_PreGame.Play' then 'Mini-Game - Pre-Game - Play'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_PreGame.Bomb' then 'Mini-Game - Pre-Game - Boost'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_PreGame.Rocket' then 'Mini-Game - Pre-Game - Boost'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_PreGame.ColorBall' then 'Mini-Game - Pre-Game - Boost'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_PreGame.PlayFromQuest' then 'Zone Task List - Play'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Pause.' then 'Mini-Game - Pause'
            when json_extract_scalar(extra_json,'$.button_tag') = 'EndlessTreasure.' then 'Treasure Trove - Open'
            when json_extract_scalar(extra_json,'$.button_tag') like 'EndlessTreasure.et%' then 'Treasure Trove - Open'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndlessTreasure.endless_treasure' then 'Treasure Trove - Free'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndlessTreasure.Close' then 'Treasure Trove - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_RewardClaim.Collect.endless_treasure' then 'Treasure Trove - Collect'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndlessTreasure.endless_treasure.item_061' then 'Treasure Trove - #1 (Free)'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndlessTreasure.endless_treasure.item_062' then 'Treasure Trove - #2 (Free)'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndlessTreasure.endless_treasure.item_063' then 'Treasure Trove - #3 (Paid)'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndlessTreasure.endless_treasure.item_064' then 'Treasure Trove - #4 (Free)'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndlessTreasure.endless_treasure.item_065' then 'Treasure Trove - #5 (Free)'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndlessTreasure.endless_treasure.item_066' then 'Treasure Trove - #6 (Paid)'
            when json_extract_scalar(extra_json,'$.button_tag') = 'DailyRewards' then 'Daily Rewards - Open'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_DailyRewards.Claim' then 'Daily Rewards - Claim'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_DailyRewards.ClaimDailyReward' then 'Daily Rewards - Claim'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_DailyRewards.Close' then 'Daily Rewards - Close'
            when json_extract_scalar(extra_json,'$.button_tag') like 'FlourFrenzy.ff_event%' then 'Flour Frenzy - Preview'
            when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_FlourFrenzy_Preview%' then 'Flour Frenzy - Start'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_FlourFrenzy_Leaderboard.PlayFromFeature' then 'Flour Frenzy - Play'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_FlourFrenzy_Leaderboard.CloseInfo' then 'Flour Frenzy - Info - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_FlourFrenzy_Leaderboard.Close' then 'Flour Frenzy - Leaderboard - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_CharacterUnlock.Continue' then 'Collection - Character Unlock - Continue'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_PreGame.EditCollection' then 'Collection - Edit Collection'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Collection.CharacterCard.shuffle' then 'Collection - Edit Collection - Use'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Collection.Try' then 'Collection - Edit Collection - Try'
            when json_extract_scalar(extra_json,'$.button_tag') like 'MovesChallenge.mc_event_id_%' then 'Moves Master - Open'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_MovesChallenge_Preview.Continue' then 'Moves Master - Start'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_MovesChallenge_Leaderboard.' then 'Moves Master - Play'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_MovesChallenge_Leaderboard.Close' then 'Moves Master - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_MovesChallenge_Leaderboard.MovesMasterInfo' then 'Moves Master - Info'
            else json_extract_scalar(extra_json,'$.button_tag')
          end"
}

constant: reward_types {
  value: "case
            when ${TABLE}.reward_type = 'CURRENCY_02' then 'Gems'
            when ${TABLE}.reward_type = 'CURRENCY_03' then 'Coins'
            when ${TABLE}.reward_type = 'CURRENCY_04' then 'Lives'
          end"
}

constant: campaign_name_clean_update {
  value: "case
            when
              ${TABLE}.campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/ES_N/A'
              and date(${TABLE}.singular_install_date) between '2023-04-11' and '2023-04-13'
              then 'AAA - LATAM/ES - 15 Min - 20230413'
            when ${TABLE}.campaign_name = 'Android_AAA_MAI_US_20230705' then 'AAA - USA - Install - 20230705'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_Purchase_Women&Men_US_N/A' then 'AAA - USA - Purchase - 20230131'
            when ${TABLE}.campaign_name = 'Android_AAA_Purchase_US_20230523' then 'AAA - USA - Purchase - 20230523'
            when ${TABLE}.campaign_name = 'Android_AAA+_Purchase_US_20230808' then 'AAA+ - USA - Purchase - 20230808'
            when ${TABLE}.campaign_name = 'Android_AAA+_Purchase_US_20230809' then 'AAA+ - USA - Purchase - 20230808'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_US_N/A' then 'AAA - USA - 15 Min - 20230308'
            when ${TABLE}.campaign_name = 'Android_AAA_15_Minutes_US_20230427' then 'AAA - USA - 15 Min - 20230427'
            when ${TABLE}.campaign_name = 'Android_AAA_30_Minutes_US_20230710' then 'AAA - USA - 30 Min - 20230710'
            when ${TABLE}.campaign_name = 'Android_AAA+_30_Minutes_US_20230721' then 'AAA+ - USA - 30 Min - 20230721'
            when ${TABLE}.campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - No Event'
            when ${TABLE}.campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_LATAM/ES_N/A v2' then 'AAA - LATAM/ES - No Event'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_5_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - 5 Min'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - 15 Min'
            when ${TABLE}.campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230413' then 'AAA - LATAM/ES - 15 Min - 20230413'
            when ${TABLE}.campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230510' then 'AAA - LATAM/ES - 15 Min - 20230510'
            when ${TABLE}.campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230523' then 'AAA - LATAM/ES - 15 Min - 20230523'
            when ${TABLE}.campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230607' then 'AAA - LATAM/ES - 15 Min - 20230607'
            when ${TABLE}.campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230807' then 'AAA - LATAM/ES - 15 Min - 20230807'
            when ${TABLE}.campaign_name = 'Android_AAA_30_Minutes_LATAM/ES_20230717' then 'AAA - LATAM/ES - 30 Min - 20230717'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/PTBR_N/A' then 'AAA - LATAM/BR - 15 Min'
            when ${TABLE}.campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_Scan_N/A' then'AAA - Scandinavia - No Event'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_Scan_N/A' then'AAA - Scandinavia - 15 Min'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_Purchases_Women&Men_Scandinavia_N/A' then 'AAA - Scandinavia - Purchase'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_30_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - 30 Min'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_30_Minutes_Women&Men_LATAM/BR_N/A' then 'AAA - LATAM/BR - 30 Min'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/PTBR_N/A' then 'AAA - LATAM/BR - Purchase'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/PTBR_N/A_v2' then 'AAA - LATAM/BR - Purchase'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - Purchase'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/ES_N/A_v2' then 'AAA - LATAM/ES - Purchase'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_Purchase_Women&Men_Chile_N/A' then 'AAA - Chile - Purchase'
            when ${TABLE}.campaign_name = 'Art_Test_Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - No Event - Puzzle Games'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - No Event - Puzzle Games'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - 5 Min - Puzzle Games'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - 15 Min - Puzzle Games'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - 30 Min - Puzzle Games'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Candy Crush' then 'MAI - No Event - Candy Crush'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Candy Crush' then 'MAI - 5 Min - Candy Crush'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Candy Crush' then 'MAI - 15 Min - Candy Crush'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle & Decorate' then 'MAI - No Event - Puzzle & Decorate'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle&Decorate' then 'MAI - No Event - Puzzle & Decorate'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Puzzle & Decorate' then 'MAI - 5 Min - Puzzle & Decorate'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Puzzle & Decorate' then 'MAI - 15 Min - Puzzle & Decorate'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Coin_Master' then 'MAI - No Event - Coin Master'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Coin Master' then 'MAI - 5 Min - Coin Master'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Coin Master' then 'MAI - 15 Min - Coin Master'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_LATAM/MX - LAL - 1% - L7D_4+' then 'MAI - No Event - 4 of 7 Days'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_LATAM/MX - LAL - 1% - L7D_4+' then 'MAI - 5 Min - 4 of 7 Days'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_LATAM/ES - LAL - 1% - Initiate Checkout' then 'MAI - No Event - Start Checkout'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES - LAL - 1% - Like Page' then 'MAI - 5 Min - Like Page'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_LATAM/ES - LAL - 1% - Initiate Checkout' then 'MAI - 5 Min - Start Checkout'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Bubble Shooter' then 'MAI - No Event - Bubble Shooter'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'MAI - 5 Min - Bubble Shooter'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'MAI - 15 Min - Bubble Shooter'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'MAI - 30 Min - Bubble Shooter'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Tile Blast' then 'MAI - No Event - Tile Blast'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'MAI - 5 Min - Tile Blast'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'MAI - 15 Min - Tile Blast'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'MAI - 30 Min - Tile Blast'
            when ${TABLE}.campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Blitz' then 'MAI - No Event - Blitz'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Blitz' then 'MAI - 5 Min - Blitz'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Blitz' then 'MAI - 15 Min - Blitz'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Walmart' then 'MAI - 5 Min - Walmart'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Walmart' then 'MAI - 15 Min - Walmart'
            when ${TABLE}.campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Walmart' then 'MAI - 30 Min - Walmart'
            else ${TABLE}.campaign_name
          end"
}

constant: singular_campaign_id_override {
  value: "
    case
      when
        ${TABLE}.singular_partner_name = 'Unattributed'
        and ${TABLE}.singular_campaign_id = ''
        and ${TABLE}.country = 'US'
        and date(${TABLE}.created_date) between '2023-01-30' and '2023-02-14'
        then '6289277953122'

      when
        ${TABLE}.singular_partner_name = 'Unattributed'
        and ${TABLE}.singular_campaign_id = ''
        and ${TABLE}.country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
        and date(${TABLE}.created_date) between '2023-04-11' and '2023-04-13'
        then '6250035906122'

      when
        ${TABLE}.singular_partner_name = 'Unattributed'
        and ${TABLE}.singular_campaign_id = ''
        and ${TABLE}.country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
        and date(${TABLE}.created_date) between '2023-04-14' and '2023-04-23'
        then '6299378813122'

      when
        ${TABLE}.singular_partner_name = 'Unattributed'
        and ${TABLE}.singular_campaign_id = ''
        and ${TABLE}.country in ('US','CA')
        and date(${TABLE}.created_date) between '2023-04-28' and '2023-05-04'
        then '6301194225922'

      when
        ${TABLE}.singular_partner_name = 'Unattributed'
        and ${TABLE}.singular_campaign_id = ''
        and ${TABLE}.country in ('US','CA')
        and date(${TABLE}.created_date) between '2023-05-24' and '2023-06-05'
        then '6302530846522'

      when
        ${TABLE}.singular_partner_name = 'Unattributed'
        and ${TABLE}.singular_campaign_id = ''
        and ${TABLE}.country in ('US','CA')
        and date(${TABLE}.created_date) between '2023-07-11' and '2023-07-12'
        then '6342654069322'

      when
        ${TABLE}.singular_partner_name = 'Unattributed'
        and ${TABLE}.singular_campaign_id = ''
        and ${TABLE}.country in ('US','CA')
        and date(${TABLE}.created_date) between '2023-07-21' and '2023-07-25'
        then '6353426252722'

      else ${TABLE}.singular_campaign_id
    end
  "
}

constant: singular_created_date_override {
  value: "
  case
  when
    ${TABLE}.singular_campaign_id = '6250035906122'
    and date(${TABLE}.created_date) > '2023-04-13'
    then timestamp(date('2023-04-13'))

  when
    ${TABLE}.singular_campaign_id = '6299378813122'
    and date(${TABLE}.created_date) > '2023-04-17'
    then timestamp(date('2023-04-17'))

  when
    ${TABLE}.singular_partner_name = 'Unattributed'
    and ${TABLE}.singular_campaign_id = ''
    and ${TABLE}.country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
    and date(${TABLE}.created_date) > '2023-04-17'
    then timestamp(date('2023-04-17'))

  else ${TABLE}.created_date
  end
  "
}

constant: creative_name_clean {
    value: "case
            when ${TABLE}.creative_name like 'Art Test - Playrix Style%' then 'Cottage Scene (Playrix)'
            when ${TABLE}.creative_name like 'Art Test - Royal Match Style%' then 'Cottage Scene (Royal Match)'
            when ${TABLE}.creative_name like 'Art Test - Toy Style%' then 'Cottage Scene (Toy)'
            when ${TABLE}.creative_name like 'Art_Test_Toy_Style%' then 'Cottage Scene (Toy)'
            when ${TABLE}.creative_name like 'Art Test - Current Style%' then 'Cottage Scene (Current)'
            when ${TABLE}.creative_name like 'Art_Test_Current_Style%' then 'Cottage Scene (Current)'
            when ${TABLE}.creative_name like '%TTC%' then 'Tap-to-Collapse Gameplay v1'
            when ${TABLE}.creative_name like 'Zen%' then 'Tap-to-Collapse Zen Gameplay v1'
            when ${TABLE}.creative_name like '%Level Progression%' then 'Level Progression'
            when ${TABLE}.creative_name like '%Simulated Play%' then 'Simulated Play'
            when ${TABLE}.creative_name like '%Spiral Win (Grid Mode)%' then 'Spiral Win (Grid)'
            when ${TABLE}.creative_name like '%Spiral Win (Tap to Collapse)%' then 'Spiral Win (TTC)'
            else ${TABLE}.creative_name
          end"
}

constant: game_mode_consolidated {
  value: "case
            when ${TABLE}.game_mode = 'CAMPAIGN' then 'Campaign'
            when ${TABLE}.game_mode = 'campaign' then 'Campaign'
            when ${TABLE}.game_mode = 'challenge' then 'MovesMaster'
            when ${TABLE}.game_mode = 'movesMaster' then 'MovesMaster'
            else ${TABLE}.game_mode
          end"
}

constant: ad_placements_clean {
  value: "case
            when ${TABLE}.source_id like '%DailyReward' then 'Daily Reward'
            when ${TABLE}.source_id like '%Moves_Master%' then 'Moves Master'
            when ${TABLE}.source_id like '%Pizza%' then 'Pizza'
            when ${TABLE}.source_id like '%Lucky_Dice%' then 'Lucky Dice'
            when ${TABLE}.source_id like '%RequestHelp%' then 'Ask For Help'
            when ${TABLE}.source_id like '%Battle_Pass%' then 'Battle Pass'
            when ${TABLE}.source_id like '%Rewarded' then 'Generic Reward'
            else ${TABLE}.source_id
          end"
}

constant: max_highest_last_level_serial_override {
  value:
    "case
      when ${TABLE}.version = '99999999999' THEN 0
      else ${TABLE}.max_highest_last_level_serial
      end"
}

constant: max_cumulative_star_spend_override {
  value:
  "case
    when ${TABLE}.version = '99999999999' THEN 0
    else ${TABLE}.max_cumulative_star_spend
    end"
}

###################################################################
# IAP Names
###################################################################

constant: iap_id_strings_new {
  value: "
  case
    when ${TABLE}.iap_id like 'item_001' then 'Free Ticket Machine'
    when ${TABLE}.iap_id like 'item_017' then 'Free Coin Machine'
    when ${TABLE}.iap_id like 'item_018' then 'Free Boost Machine'
    when ${TABLE}.iap_id like 'item_004' then 'Peewee Coin Capsule'
    when ${TABLE}.iap_id like 'item_005' then 'Small Coin Capsule'
    when ${TABLE}.iap_id like 'item_006' then 'Medium Coin Capsule'
    when ${TABLE}.iap_id like 'item_007' then 'Large Coin Capsule'
    when ${TABLE}.iap_id like 'item_020' then 'Huge Coin Capsule'
    when ${TABLE}.iap_id like 'item_021' then 'Jumbo Coin Capsule'
    when ${TABLE}.iap_id like 'item_008' then 'Peewee Gem Capsule'
    when ${TABLE}.iap_id like 'item_026' then 'Peewee Gem Capsule'
    when ${TABLE}.iap_id like 'item_009' then 'Small Gem Capsule'
    when ${TABLE}.iap_id like 'item_010' then 'Medium Gem Capsule'
    when ${TABLE}.iap_id like 'item_011' then 'Large Gem Capsule'
    when ${TABLE}.iap_id like 'item_012' then 'Huge Gem Capsule'
    when ${TABLE}.iap_id like 'item_013' then 'Jumbo Gem Capsule'
    when ${TABLE}.iap_id like 'item_023' then 'Peewee Life Pack'
    when ${TABLE}.iap_id like 'item_014' then 'Small Life Pack'
    when ${TABLE}.iap_id like 'item_015' then 'Medium Life Pack'
    when ${TABLE}.iap_id like 'item_016' then 'Large Life Pack'
    when ${TABLE}.iap_id like 'item_024' then 'Huge Life Pack'
    when ${TABLE}.iap_id like 'item_025' then 'Jumbo Life Pack'
    when ${TABLE}.iap_id like 'item_028' then '24h Infinite Lives'
    when ${TABLE}.iap_id = 'COLOR_BALL' then 'Color Ball Boost'
    when ${TABLE}.iap_id = 'BOMB' then 'Bomb Boost'
    when ${TABLE}.iap_id = 'ROCKET' then 'Rocket Boost'
    when ${TABLE}.iap_id = 'clear_cell' then 'Clear Cell Skill'
    when ${TABLE}.iap_id = 'clear_vertical' then '1x Clear Vertical Skill'
    when ${TABLE}.iap_id = 'clear_horizontal' then '1x Clear Horizontal Skill'
    when ${TABLE}.iap_id = 'item_clear_cell' then '1x Clear Cell Skill'
    when ${TABLE}.iap_id = 'item_clear_cell_bulk' then '5x Clear Cell Skill'
    when ${TABLE}.iap_id = 'item_clear_horizontal' then '1x Clear Horizontal Skill'
    when ${TABLE}.iap_id = 'item_clear_horizontal_bulk' then '5x Clear Horizontal Skill'
    when ${TABLE}.iap_id = 'item_clear_vertical' then '1x Clear Vertical Skill'
    when ${TABLE}.iap_id = 'item_clear_vertical_bulk' then '5x Clear Vertical Skill'
    when ${TABLE}.iap_id = 'item_rocket' then '1x Rocket Boost'
    when ${TABLE}.iap_id = 'item_rocket_bulk' then '8x Rocket Boost'
    when ${TABLE}.iap_id = 'item_color_ball' then '1x Color Ball Boost'
    when ${TABLE}.iap_id = 'item_color_ball_bulk' then '5x Color Ball Boost'
    when ${TABLE}.iap_id = 'item_bomb' then '1x Bomb Boost'
    when ${TABLE}.iap_id = 'item_bomb_bulk' then '6x Bomb Boost'
    when ${TABLE}.iap_id = 'extra_moves_5' then '5x Extra Moves'

    when ${TABLE}.iap_id = 'item_051' then 'Giant Power Up Pack!'

    when ${TABLE}.iap_id = 'item_052' then 'Hammer Chum Chums & Coins Special!'
    when ${TABLE}.iap_id = 'item_054' then 'Vertical Chum Chums & Coins Special!'
    when ${TABLE}.iap_id = 'item_053' then 'Horizontal Chum Chums & Coins Special!'
    when ${TABLE}.iap_id = 'item_075' then 'Shuffle Chum Chums & Coins Special!'

    when ${TABLE}.iap_id = 'item_055' then 'Coins (S)'
    when ${TABLE}.iap_id = 'item_056' then 'Coins (M)'
    when ${TABLE}.iap_id = 'item_057' then 'Coins (L)'

    when ${TABLE}.iap_id = 'item_058' then 'Lives (S)'
    when ${TABLE}.iap_id = 'item_059' then 'Lives (M)'
    when ${TABLE}.iap_id = 'item_060' then 'Lives (L)'

    when ${TABLE}.iap_id = 'item_063' then 'Treasure Trove (XS)'
    when ${TABLE}.iap_id = 'item_066' then 'Treasure Trove (S)'
    when ${TABLE}.iap_id = 'item_069' then 'Treasure Trove (M)'
    when ${TABLE}.iap_id = 'item_072' then 'Treasure Trove (L)'

    when ${TABLE}.iap_id = 'item_076' then 'Magnifiers (S)'
    when ${TABLE}.iap_id = 'item_077' then 'Magnifiers (M)'
    when ${TABLE}.iap_id = 'item_078' then 'Magnifiers (L)'

    when ${TABLE}.iap_id = 'item_089' then 'Level Bundle (100)'
    when ${TABLE}.iap_id = 'item_090' then 'Level Bundle (200)'
    when ${TABLE}.iap_id = 'item_091' then 'Level Bundle (300)'
    when ${TABLE}.iap_id = 'item_092' then 'Level Bundle (400)'

    else ${TABLE}.iap_id
  end"
}

constant: iap_id_strings_grouped_new {
  value: "
    case
      when ${TABLE}.iap_id = 'item_001' then 'Free Machine'
      when ${TABLE}.iap_id = 'item_017' then 'Free Machine'
      when ${TABLE}.iap_id = 'item_018' then 'Free Machine'
      when ${TABLE}.iap_id = 'item_004' then 'Coin Capsule'
      when ${TABLE}.iap_id = 'item_005' then 'Coin Capsule'
      when ${TABLE}.iap_id = 'item_006' then 'Coin Capsule'
      when ${TABLE}.iap_id = 'item_007' then 'Coin Capsule'
      when ${TABLE}.iap_id = 'item_020' then 'Coin Capsule'
      when ${TABLE}.iap_id = 'item_021' then 'Coin Capsule'
      when ${TABLE}.iap_id = 'item_057' then 'Coin Capsule'
      when ${TABLE}.iap_id = 'item_008' then 'Gem Capsule'
      when ${TABLE}.iap_id = 'item_026' then 'Gem Capsule'
      when ${TABLE}.iap_id = 'item_009' then 'Gem Capsule'
      when ${TABLE}.iap_id = 'item_010' then 'Gem Capsule'
      when ${TABLE}.iap_id = 'item_011' then 'Gem Capsule'
      when ${TABLE}.iap_id = 'item_012' then 'Gem Capsule'
      when ${TABLE}.iap_id = 'item_013' then 'Gem Capsule'
      when ${TABLE}.iap_id = 'item_023' then 'Life Pack'
      when ${TABLE}.iap_id = 'item_014' then 'Life Pack'
      when ${TABLE}.iap_id = 'item_015' then 'Life Pack'
      when ${TABLE}.iap_id = 'item_016' then 'Life Pack'
      when ${TABLE}.iap_id = 'item_024' then 'Life Pack'
      when ${TABLE}.iap_id = 'item_025' then 'Life Pack'
      when ${TABLE}.iap_id = 'item_028' then '24h Infinite Lives'
      when ${TABLE}.iap_id = 'item_037' then 'Lives & Coins Bundle'
      when ${TABLE}.iap_id = 'boost_001' then 'Boosts'
      when ${TABLE}.iap_id = 'boost_002' then 'Boosts'
      when ${TABLE}.iap_id = 'boost_003' then 'Boosts'
      when ${TABLE}.iap_id = 'boost_004' then 'Boosts'
      when ${TABLE}.iap_id = 'boost_005' then 'Boosts'
      when ${TABLE}.iap_id = 'boost_006' then 'Boosts'
      when ${TABLE}.iap_id = 'box_000' then 'Free Machine'
      when ${TABLE}.iap_id = 'box_004' then 'Free Machine'
      when ${TABLE}.iap_id = 'box_005' then 'Free Machine'
      when ${TABLE}.iap_id like '%clear_cell%' then 'Chum Chum Skills'
      when ${TABLE}.iap_id like '%clear_horizontal%' then 'Chum Chum Skills'
      when ${TABLE}.iap_id like '%clear_vertical%' then 'Chum Chum Skills'
      when ${TABLE}.iap_id like '%bomb%' then 'Pre-Game Boosts'
      when ${TABLE}.iap_id like '%rocket%' then 'Pre-Game Boosts'
      when ${TABLE}.iap_id like '%color_ball%' then 'Pre-Game Boosts'
      when ${TABLE}.iap_id like '%zone%' then 'Zone Restoration'
      when ${TABLE}.iap_id like '%extra_moves%' then 'Extra Moves'

      when ${TABLE}.iap_id = 'item_051' then 'Giant Power Up Pack!'

      when ${TABLE}.iap_id = 'item_052' then 'Chum Chums & Coins'
      when ${TABLE}.iap_id = 'item_054' then 'Chum Chums & Coins'
      when ${TABLE}.iap_id = 'item_053' then 'Chum Chums & Coins'
      when ${TABLE}.iap_id = 'item_075' then 'Chum Chums & Coins'


      when ${TABLE}.iap_id = 'item_055' then 'Coins'
      when ${TABLE}.iap_id = 'item_056' then 'Coins'
      when ${TABLE}.iap_id = 'item_057' then 'Coins'

      when ${TABLE}.iap_id = 'item_058' then 'Lives'
      when ${TABLE}.iap_id = 'item_059' then 'Lives'
      when ${TABLE}.iap_id = 'item_060' then 'Lives'

      when ${TABLE}.iap_id = 'item_063' then 'Treasure Trove'
      when ${TABLE}.iap_id = 'item_066' then 'Treasure Trove'
      when ${TABLE}.iap_id = 'item_069' then 'Treasure Trove'
      when ${TABLE}.iap_id = 'item_072' then 'Treasure Trove'

      when ${TABLE}.iap_id = 'item_076' then 'Magnifiers'
      when ${TABLE}.iap_id = 'item_077' then 'Magnifiers'
      when ${TABLE}.iap_id = 'item_078' then 'Magnifiers'

      when ${TABLE}.iap_id = 'item_089' then 'Level Bundle'
      when ${TABLE}.iap_id = 'item_090' then 'Level Bundle'
      when ${TABLE}.iap_id = 'item_091' then 'Level Bundle'
      when ${TABLE}.iap_id = 'item_092' then 'Level Bundle'

      else ${TABLE}.iap_id
  end"
}

constant: ad_reward_id_strings {
  value: "
    case
      when ${TABLE}.ad_reward_source_id = 'quick_boost_rocket' then 'Rocket'
      when ${TABLE}.ad_reward_source_id = 'quick_lives' then 'Lives'
      when ${TABLE}.ad_reward_source_id = 'quick_magnifiers' then 'Magnifiers'
      when ${TABLE}.ad_reward_source_id = 'treasure_trove' then 'Treasure Trove'
      else ${TABLE}.ad_reward_source_id
    end"
}

###################################################################
# In App Messenging
###################################################################

constant: iam_group {
  value: "
  case
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging.' then 'InAppMessage'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging.Close' then 'InAppMessage'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_CE.' then 'CE'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Generic.' then 'Generic'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer.' then 'MTXOffer'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer.Close' then 'MTXOffer'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_NameChange.' then 'NameChange'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Notifications.' then 'Notifications'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Notifications.Close' then 'Notifications'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_RateUs.' then 'RateUs'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_RateUs.Close' then 'RateUs'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_RateUs.IAM' then 'RateUs'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_TOTD.' then 'TOTD'
  else 'UnMapped'
  end"
}

constant: iam_conversion {
  value: "
  case
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging.' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_CE.' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Generic.' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer.' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_NameChange.' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Notifications.' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Notifications.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_RateUs.' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_RateUs.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_RateUs.IAM' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_TOTD.' then 0
  else 0
  end"
}

###################################################################
# Coin Source Amounts and Naming
# Built here
# https://docs.google.com/spreadsheets/d/1cyAp3FG_nUTJ23NDNtqnv5zA_yR2zklUTLgMiOmozkc/edit?usp=sharing
# Ask Tal Kreuch for access
###################################################################

constant: coin_source_amount_override {
  value: "
    case
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_037' then 6000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_043' then 6000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_044' then 10000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_052' then 20000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_053' then 20000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_054' then 20000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_075' then 20000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_088' then 20000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_089' then 6000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_090' then 12000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_091' then 40000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_092' then 80000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_061' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_062' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_063' then 6000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_064' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_065' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_066' then 12000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_067' then 2000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_068' then 2000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_069' then 40000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_070' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_071' then 2000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_072' then 100000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_073' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_074' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_079' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_080' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_081' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_082' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_083' then 2000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_084' then 2000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_085' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_087' then 1000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_093' then 10000
       when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_094' then 40000
  else ${TABLE}.coin_source_amount
  end
  "
 }

constant: coin_source_name {
  value: "
  case

     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'zone_restore' then 'Zone Restore'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'initial_reward' then 'Initial Reward'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'lucky_dice' then 'Lucky Dice'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'incetivized_ads' then 'Pizza Time'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'daily_reward' then 'Daily Reward'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'global_leaderboard' then 'Legacy: Global Leaderboard'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R2' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_D1' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'gacha_box_004' then 'Legacy: Gacha Box'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_D2' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R4' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C3' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R5' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C2' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C5' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R1' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R3' then 'Legacy: Bingo'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C4' then 'Legacy: Bingo'

     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_campaign' then 'Campaign'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_movesMaster' then 'Moves Master'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_CAMPAIGN' then 'Campaign'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_puzzle' then 'Puzzle'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_challenge' then 'Challenge'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_showcase' then 'Showcase'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_helpRequest' then 'Help Request'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_LEADERBOARD' then 'Leaderboard'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_none' then 'None'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_cheat' then 'Cheat'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_CHEAT' then 'Cheat'

     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_057' then 'Coins (L)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_056' then 'Coins (M)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_055' then 'Coins (S)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_063' then 'Treasure Trove (XS)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_072' then 'Treasure Trove (L)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_066' then 'Treasure Trove (S)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_069' then 'Treasure Trove (M)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_092' then 'Level Bundle (400)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_053' then 'Horizontal Chum Chums & Coins Special!'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_054' then 'Vertical Chum Chums & Coins Special!'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_091' then 'Level Bundle (300)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_056' then 'Coins (M)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_052' then 'Hammer Chum Chums & Coins Special!'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_055' then 'Coins (S)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_075' then 'Shuffle Chum Chums & Coins Special!'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_066' then 'Treasure Trove (S)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_063' then 'Treasure Trove (XS)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_089' then 'Level Bundle (100)'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_090' then 'Level Bundle (200)'

     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'Daily Rewards' then 'Daily Reward'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C1' then 'Legacy: Bingo'

    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'treasure_trove' then 'Treasure Trove (Free)'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'puzzle' then 'Puzzle (End)'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'flour_frenzy' then 'Flour Frenzy (End)'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'hotdog_contest' then 'Hotdog Contest (End)'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'moves_master' then 'Moves Master (End)'



    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source = 'round_end' then 'Round End'
    else 'Unmapped'
  end
  "
}

constant: coin_source_name_group {
  value: "
  case

     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'zone_restore' then 'Zone Restore'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'initial_reward' then 'Initial Reward'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'lucky_dice' then 'Live Ops'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'incetivized_ads' then 'Live Ops'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'daily_reward' then 'Live Ops'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'global_leaderboard' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R2' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_D1' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'gacha_box_004' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_D2' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R4' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C3' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R5' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C2' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C5' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R1' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_R3' then 'Legacy'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C4' then 'Legacy'

     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_campaign' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_movesMaster' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_CAMPAIGN' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_puzzle' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_challenge' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_showcase' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_helpRequest' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_LEADERBOARD' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_none' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_cheat' then 'Round End'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'round_end_CHEAT' then 'Round End'

     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_057' then 'Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_056' then 'Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_055' then 'Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_063' then 'Treasure Trove'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_072' then 'Treasure Trove'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_066' then 'Treasure Trove'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_069' then 'Treasure Trove'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_092' then 'Level Bundle'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_053' then 'Chum Chums & Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_054' then 'Chum Chums & Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_091' then 'Level Bundle'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_056' then 'Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_052' then 'Chum Chums & Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_055' then 'Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_075' then 'Chum Chums & Coins'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_066' then 'Treasure Trove'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_063' then 'Treasure Trove'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_089' then 'Level Bundle'
     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_090' then 'Level Bundle'

     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'Daily Rewards' then 'Live Ops'
     when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'bingo_reward_C1' then 'Legacy'

    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'treasure_trove' then 'Treasure Trove'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'puzzle' then 'Live Ops'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'flour_frenzy' then 'Live Ops'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'hotdog_contest' then 'Live Ops'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'moves_master' then 'Live Ops'



    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source = 'round_end' then 'Round End'
  else 'Unmapped'
  end
  "
}

###################################################################
# Coin Spend Naming
# Built here
# https://docs.google.com/spreadsheets/d/1PPapHlIj-Nc9CQ0vhNCLJvQADUpXMmw8bWc0BTBhGJc/edit?usp=sharing
# Ask Tal Kreuch for access
###################################################################

constant: coin_spend_name {
  value: "
  case
   when ${TABLE}.source_id = 'extra_moves_5' and ${TABLE}.iap_id = 'extra_moves_5' then 'Extra Moves'
   when ${TABLE}.source_id = 'quick_lives' and ${TABLE}.iap_id = 'item_059' then 'Lives'
   when ${TABLE}.source_id = 'quick_lives' and ${TABLE}.iap_id = 'item_058' then 'Lives'
   when ${TABLE}.source_id = 'quick_lives' and ${TABLE}.iap_id = 'item_060' then 'Lives'
   when ${TABLE}.source_id = 'quick_skill_clear_cell' and ${TABLE}.iap_id = 'item_clear_cell' then 'Clear Cell'
   when ${TABLE}.source_id = 'quick_skill_clear_vertical' and ${TABLE}.iap_id = 'item_clear_vertical' then 'Clear Verticle'
   when ${TABLE}.source_id = 'quick_skill_clear_horizontal' and ${TABLE}.iap_id = 'item_clear_horizontal' then 'Clear Horizontal'
   when ${TABLE}.source_id = 'quick_skill_clear_vertical' and ${TABLE}.iap_id = 'item_clear_vertical_bulk' then 'Clear Verticle'
   when ${TABLE}.source_id = 'quick_magnifiers' and ${TABLE}.iap_id = 'item_077' then 'Magnifiers'
   when ${TABLE}.source_id = 'quick_skill_clear_horizontal' and ${TABLE}.iap_id = 'item_clear_horizontal_bulk' then 'Clear Horizontal'
   when ${TABLE}.source_id = 'quick_boost_color_ball' and ${TABLE}.iap_id = 'item_color_ball_bulk' then 'Color Ball'
   when ${TABLE}.source_id = 'quick_skill_clear_cell' and ${TABLE}.iap_id = 'item_clear_cell_bulk' then 'Clear Cell'
   when ${TABLE}.source_id = 'quick_boost_color_ball' and ${TABLE}.iap_id = 'item_color_ball' then 'Color Ball'
   when ${TABLE}.source_id = 'quick_boost_bomb' and ${TABLE}.iap_id = 'item_bomb' then 'Bomb'
   when ${TABLE}.source_id = 'quick_boost_bomb' and ${TABLE}.iap_id = 'item_bomb_bulk' then 'Bomb'
   when ${TABLE}.source_id = 'quick_magnifiers' and ${TABLE}.iap_id = 'item_078' then 'Magnifiers'
   when ${TABLE}.source_id = 'quick_boost_rocket' and ${TABLE}.iap_id = 'item_rocket' then 'Rocket'
   when ${TABLE}.source_id = 'quick_skill_shuffle' and ${TABLE}.iap_id = 'item_shuffle' then 'Shuffle'
   when ${TABLE}.source_id = 'quick_boost_rocket' and ${TABLE}.iap_id = 'item_rocket_bulk' then 'Rocket'
   when ${TABLE}.source_id = 'quick_skill_shuffle' and ${TABLE}.iap_id = 'item_shuffle_bulk' then 'Shuffle'
   when ${TABLE}.source_id = 'character' and ${TABLE}.iap_id = 'item_chopsticks_unlock' then 'Chopsticks'
   when ${TABLE}.source_id = 'quick_magnifiers' and ${TABLE}.iap_id = 'item_076' then 'Magnifiers'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_clear_vertical' then 'Clear Verticle'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_clear_horizontal' then 'Clear Horizontal'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_clear_cell' then 'Clear Cell'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_color_ball' then 'Color Ball'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_rocket' then 'Rocket'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_003' and ${TABLE}.iap_id = 'box_001' then 'Legacy'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_bomb' then 'Bomb'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'box_007' then 'Legacy'
   when ${TABLE}.source_id = 'COLOR_BALL' and ${TABLE}.iap_id = '' then 'Color Ball'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.FIVE_TO_FOUR' and ${TABLE}.iap_id = 'boost_006' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_019' and ${TABLE}.iap_id = 'box_002' then 'Legacy'
   when ${TABLE}.source_id = 'BOMB' and ${TABLE}.iap_id = '' then 'Bomb'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.BUBBLE' and ${TABLE}.iap_id = 'boost_005' then 'Legacy'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'clear_vertical' then 'Clear Verticle'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'clear_horizontal' then 'Clear Horizontal'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'box_006' then 'Legacy'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'COLOR_BALL' then 'Color Ball'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'clear_cell' then 'Clear Cell'
   when ${TABLE}.source_id = 'ROCKET' and ${TABLE}.iap_id = '' then 'Rocket'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.TIME' and ${TABLE}.iap_id = 'boost_004' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.EXP' and ${TABLE}.iap_id = 'boost_003' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.COIN' and ${TABLE}.iap_id = 'boost_002' then 'Legacy'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'ROCKET' then 'Rocket'
   when ${TABLE}.source_id = 'clear_cell' and ${TABLE}.iap_id = '' then 'Clear Cell'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.SCORE' and ${TABLE}.iap_id = 'boost_001' then 'Legacy'
   when ${TABLE}.source_id = 'clear_horizontal' and ${TABLE}.iap_id = '' then 'Clear Horizontal'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'BOMB' then 'Bomb'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'box_006' then 'Legacy'
   when ${TABLE}.source_id = 'clear_vertical' and ${TABLE}.iap_id = '' then 'Clear Verticle'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'box_002' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'box_002' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'box_006' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'item_019' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'box_002' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'box_007' then 'Legacy'
   when ${TABLE}.source_id = 'BUBBLE' and ${TABLE}.iap_id = '' then 'Legacy'
   when ${TABLE}.source_id = 'FIVE_TO_FOUR' and ${TABLE}.iap_id = '' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'box_001' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'box_007' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'item_003' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'item_003' then 'Legacy'
   when ${TABLE}.source_id = 'TIME' and ${TABLE}.iap_id = '' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'item_002' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_018' and ${TABLE}.iap_id = 'box_007' then 'Legacy'
   when ${TABLE}.source_id = 'FIVE_TO_FOUR' and ${TABLE}.iap_id = 'boost_006' then 'Legacy'
   when ${TABLE}.source_id = 'BUBBLE' and ${TABLE}.iap_id = 'boost_005' then 'Legacy'
   when ${TABLE}.source_id = 'TIME' and ${TABLE}.iap_id = 'boost_004' then 'Legacy'

  else 'Unmapped'
  end
  "
}

constant: coin_spend_name_group {
  value: "
  case
   when ${TABLE}.source_id = 'extra_moves_5' and ${TABLE}.iap_id = 'extra_moves_5' then 'Extra Moves'
   when ${TABLE}.source_id = 'quick_lives' and ${TABLE}.iap_id = 'item_059' then 'Lives'
   when ${TABLE}.source_id = 'quick_lives' and ${TABLE}.iap_id = 'item_058' then 'Lives'
   when ${TABLE}.source_id = 'quick_lives' and ${TABLE}.iap_id = 'item_060' then 'Lives'
   when ${TABLE}.source_id = 'quick_skill_clear_cell' and ${TABLE}.iap_id = 'item_clear_cell' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'quick_skill_clear_vertical' and ${TABLE}.iap_id = 'item_clear_vertical' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'quick_skill_clear_horizontal' and ${TABLE}.iap_id = 'item_clear_horizontal' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'quick_skill_clear_vertical' and ${TABLE}.iap_id = 'item_clear_vertical_bulk' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'quick_magnifiers' and ${TABLE}.iap_id = 'item_077' then 'Magnifiers'
   when ${TABLE}.source_id = 'quick_skill_clear_horizontal' and ${TABLE}.iap_id = 'item_clear_horizontal_bulk' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'quick_boost_color_ball' and ${TABLE}.iap_id = 'item_color_ball_bulk' then 'Boost'
   when ${TABLE}.source_id = 'quick_skill_clear_cell' and ${TABLE}.iap_id = 'item_clear_cell_bulk' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'quick_boost_color_ball' and ${TABLE}.iap_id = 'item_color_ball' then 'Boost'
   when ${TABLE}.source_id = 'quick_boost_bomb' and ${TABLE}.iap_id = 'item_bomb' then 'Boost'
   when ${TABLE}.source_id = 'quick_boost_bomb' and ${TABLE}.iap_id = 'item_bomb_bulk' then 'Boost'
   when ${TABLE}.source_id = 'quick_magnifiers' and ${TABLE}.iap_id = 'item_078' then 'Magnifiers'
   when ${TABLE}.source_id = 'quick_boost_rocket' and ${TABLE}.iap_id = 'item_rocket' then 'Boost'
   when ${TABLE}.source_id = 'quick_skill_shuffle' and ${TABLE}.iap_id = 'item_shuffle' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'quick_boost_rocket' and ${TABLE}.iap_id = 'item_rocket_bulk' then 'Boost'
   when ${TABLE}.source_id = 'quick_skill_shuffle' and ${TABLE}.iap_id = 'item_shuffle_bulk' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'character' and ${TABLE}.iap_id = 'item_chopsticks_unlock' then 'New Chum Chum'
   when ${TABLE}.source_id = 'quick_magnifiers' and ${TABLE}.iap_id = 'item_076' then 'Magnifiers'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_clear_vertical' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_clear_horizontal' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_clear_cell' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_color_ball' then 'Boost'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_rocket' then 'Boost'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_003' and ${TABLE}.iap_id = 'box_001' then 'Legacy'
   when ${TABLE}.source_id = 'auto_purchase' and ${TABLE}.iap_id = 'item_bomb' then 'Boost'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'box_007' then 'Legacy'
   when ${TABLE}.source_id = 'COLOR_BALL' and ${TABLE}.iap_id = '' then 'Boost'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.FIVE_TO_FOUR' and ${TABLE}.iap_id = 'boost_006' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_019' and ${TABLE}.iap_id = 'box_002' then 'Legacy'
   when ${TABLE}.source_id = 'BOMB' and ${TABLE}.iap_id = '' then 'Boost'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.BUBBLE' and ${TABLE}.iap_id = 'boost_005' then 'Legacy'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'clear_vertical' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'clear_horizontal' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'box_006' then 'Legacy'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'COLOR_BALL' then 'Boost'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'clear_cell' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'ROCKET' and ${TABLE}.iap_id = '' then 'Boost'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.TIME' and ${TABLE}.iap_id = 'boost_004' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.EXP' and ${TABLE}.iap_id = 'boost_003' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.COIN' and ${TABLE}.iap_id = 'boost_002' then 'Legacy'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'ROCKET' then 'Boost'
   when ${TABLE}.source_id = 'clear_cell' and ${TABLE}.iap_id = '' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'Panel_Boosts_V3.BoostUI.SCORE' and ${TABLE}.iap_id = 'boost_001' then 'Legacy'
   when ${TABLE}.source_id = 'clear_horizontal' and ${TABLE}.iap_id = '' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'Sheet_Boost_Purchase' and ${TABLE}.iap_id = 'BOMB' then 'Boost'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'box_006' then 'Legacy'
   when ${TABLE}.source_id = 'clear_vertical' and ${TABLE}.iap_id = '' then 'Chum Chum Skill'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'box_002' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'box_002' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'box_006' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'item_019' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'box_002' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'box_007' then 'Legacy'
   when ${TABLE}.source_id = 'BUBBLE' and ${TABLE}.iap_id = '' then 'Legacy'
   when ${TABLE}.source_id = 'FIVE_TO_FOUR' and ${TABLE}.iap_id = '' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'box_001' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'box_007' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'item_003' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'item_003' then 'Legacy'
   when ${TABLE}.source_id = 'TIME' and ${TABLE}.iap_id = '' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'item_002' then 'Legacy'
   when ${TABLE}.source_id = 'Panel_Store.Purchase.item_018' and ${TABLE}.iap_id = 'box_007' then 'Legacy'
   when ${TABLE}.source_id = 'FIVE_TO_FOUR' and ${TABLE}.iap_id = 'boost_006' then 'Legacy'
   when ${TABLE}.source_id = 'BUBBLE' and ${TABLE}.iap_id = 'boost_005' then 'Legacy'
   when ${TABLE}.source_id = 'TIME' and ${TABLE}.iap_id = 'boost_004' then 'Legacy'


  else 'Unmapped'
  end
  "
}


###################################################################
# Visualization JS...KEEP AT THE BOTTOM
###################################################################

visualization: {
  id: "pivoted_boxplot"
  label: "Pivoted Boxplot"
  dependencies: ["https://code.highcharts.com/highcharts.js", "https://code.highcharts.com/highcharts-more.js"]
  file: "visualizations/pivoted_boxplot.js"
}

visualization: {
  id: "2d_boxplot"
  label: "2D Boxplot"
  dependencies: ["https://code.highcharts.com/highcharts.js", "https://code.highcharts.com/highcharts-more.js"]
  file: "visualizations/2d_boxplot.js"
}

visualization: {
  id: "2d_line"
  label: "2D Line"
  dependencies: ["https://code.highcharts.com/highcharts.js"]
  file: "visualizations/2d_line.js"
}

visualization: {
  id: "2d_column"
  label: "2D Column"
  dependencies: ["https://code.highcharts.com/highcharts.js"]
  file: "visualizations/2d_column.js"
}

visualization: {
  id: "scatter"
  label: "Scatter"
  dependencies: ["https://code.highcharts.com/highcharts.js"]
  file: "visualizations/scatter.js"
}
