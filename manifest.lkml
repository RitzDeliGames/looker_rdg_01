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
            when platform like '%Android OS 10%' THEN 'Android OS 10'
            when platform like '%Android OS 11%' THEN 'Android OS 11'
            when platform like '%Android OS 12%' THEN 'Android OS 12'
            when platform like '%Android OS 13%' THEN 'Android OS 13'
            when platform like '%Android OS 14%' THEN 'Android OS 14'
            when platform like '%Android OS 15%' THEN 'Android OS 15'
            when platform like '%Android OS 4%' THEN 'Android OS 04'
            when platform like '%Android OS 5%' THEN 'Android OS 05'
            when platform like '%Android OS 6%' THEN 'Android OS 06'
            when platform like '%Android OS 7%' THEN 'Android OS 07'
            when platform like '%Android OS 8%' THEN 'Android OS 08'
            when platform like '%Android OS 9%' THEN 'Android OS 09'
            when platform like '%Android OS dt%' THEN 'Android OS dt'
            when platform like '%Linux%' THEN 'Linux'
            when platform like '%Mac OS%' THEN 'Mac OS'
            when platform like '%MacOS%' THEN 'Mac OS'
            when platform like '%Windows%' THEN 'Windows'
            when platform like '%iOS 10%' THEN 'iOS 10'
            when platform like '%iOS 11%' THEN 'iOS 11'
            when platform like '%iOS 12%' THEN 'iOS 12'
            when platform like '%iOS 13%' THEN 'iOS 13'
            when platform like '%iOS 14%' THEN 'iOS 14'
            when platform like '%iOS 15%' THEN 'iOS 15'
            when platform like '%iOS 16%' THEN 'iOS 16'
            when platform like '%iOS 17%' THEN 'iOS 17'
            when platform like '%iOS 18%' THEN 'iOS 18'
            when platform like '%iPadOS 15%' THEN 'iPadOS 15'
            when platform like '%iPadOS 16%' THEN 'iPadOS 16'
            when platform like '%iPadOS 17%' THEN 'iPadOS 17'
            when platform like '%iPadOS 18%' THEN 'iPadOS 18'
            else 'Unmapped'
        END"
  }

constant: device_platform_mapping {
  value: "case
            when platform like '%iOS%' then 'Apple'
            when platform like '%Android%' then 'Google'
            else 'Other'
          end"
}

constant: device_platform_mapping_os {
  value: "case
            when platform like '%iOS%' then 'iOS'
            when platform like '%Android%' then 'Android'
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
            when country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE') then 'LATAM-ES'
            when country = 'BR' then 'LATAM-BR'
            when country in ('SE','DK','FI','IS','NO','SE') then 'Scandinavia'
            when country in ('GB','AT','BE','BG','CH','CY','CZ','ES','EE','FR','DE','GR','HR','HU','IE','IT','LV','LT','LU','MT','NL','PL','PT','RO','SK','SI','TR') then 'UK-EU'
            when country in ('US','CA') then 'USA & Canada'
            when country in ('JP','HK','KR','TW') then 'East Asia xChina'
            when country in ('ID','IN','MY','PH','SG','TH','VN') then 'SE Asia & India'
            when country in ('AU', 'NZ') then 'AU-NZ'
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

constant: appsflyer_campaign_name_backup {
  value: "
  case

  when
  appsflyer_campaign_type = 'ua'
  and date(created_date) between '2024-04-08' and '2024-04-19'
  then
  '20240412 - Facebook - LATAM/ES - MAI'

  else mapped_singular_campaign_name_start
  end
  "
}

constant: appsflyer_campaign_name {
  value: "
    mapped_singular_campaign_name_start
      "
}

constant: campaign_name_clean_update {
  value: "case
            when
              campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/ES_N/A'
              and date(singular_install_date) between '2023-04-11' and '2023-04-13'
              then '20230413 - Facebook - LATAM/ES - 15 Min'


            when campaign_name = 'CHUM|Facebook|Android|US|AA+|20240307' then '20240307 - Facebook - USA - Purchase'

            when campaign_name = 'CHUM|Facebook|Android|LATAM-ES|AA+|Mar03' then '20240303 - Facebook - LATAM/ES - 30 Min'

            when campaign_name = 'CHUM|Facebook|Android|US|AA+|Jan24' then '20240103 - Facebook - USA - Purchase'

            when campaign_name = 'Android_AAA+_30_Minutes_MX_20231214' then '20231214 - Facebook - MX - 30 Min'

            when campaign_name = 'Android_AAA+_30_Minutes_MX_20231129' then '20231129 - Facebook - MX - 30 Min'

            when campaign_name = 'Android_AAA+_MAI_US_20231110' then '20231110 - Facebook - USA - Install'
            when campaign_name = 'Android_AAA+TutorialComplete_US_20231030' then '20231030 - Facebook - USA - Tutorial Complete'

            when campaign_name = 'Android_AAA+_30_Minutes_LATAM/ES_20231019' then '20231019 - Facebook - LATAM/ES - 30 Min'
            when campaign_name = 'iOS_AAA+_Install_LATAM/ES_20231019' then '20231019 - Facebook - LATAM/ES - 30 Min'

            when campaign_name = 'Android_AAA+_30_Minutes_US_20230828' then '20230828 - Facebook - USA - 30 Min'
            when campaign_name = 'Android_AAA+_60_Minutes_US_20230825' then '20230825 - Facebook - USA - 60 Min'
            when campaign_name = 'Android_AAA_MAI_US_20230705' then '20230705 - Facebook - USA - Install'
            when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_US_N/A' then '20230131 - Facebook - USA - Purchase'
            when campaign_name = 'Android_AAA_Purchase_US_20230523' then '20230523 - Facebook - USA - Purchase'
            when campaign_name = 'Android_AAA+_Purchase_US_20230808' then '20230808 - Facebook - USA - Purchase'
            when campaign_name = 'Android_AAA+_Purchase_US_20230809' then '20230808 - Facebook - USA - Purchase'
            when campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_US_N/A' then '20230308 - Facebook - USA - 15 Min'
            when campaign_name = 'Android_AAA_15_Minutes_US_20230427' then '20230427 - Facebook - USA - 15 Min'
            when campaign_name = 'Android_AAA_30_Minutes_US_20230710' then '20230710 - Facebook - USA - 30 Min'
            when campaign_name = 'Android_AAA+_30_Minutes_US_20230721' then '20230721 - Facebook - USA - 30 Min'
            when campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - No Event'
            when campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_LATAM/ES_N/A v2' then 'AAA - LATAM/ES - No Event'
            when campaign_name = 'Android_AAA_Events_5_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - 5 Min'
            when campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - 15 Min'
            when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230413' then '20230413 - Facebook - LATAM/ES - 15 Min'
            when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230510' then '20230510 - Facebook - LATAM/ES - 15 Min'
            when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230523' then '20230523 - Facebook - LATAM/ES - 15 Min'
            when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230607' then '20230607 - Facebook - LATAM/ES - 15 Min'
            when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230807' then '20230807 - Facebook - LATAM/ES - 15 Min'
            when campaign_name = 'Android_AAA_30_Minutes_LATAM/ES_20230717' then '20230717 - Facebook - LATAM/ES - 30 Min'
            when campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/PTBR_N/A' then 'AAA - LATAM/BR - 15 Min'
            when campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_Scan_N/A' then'AAA - Scandinavia - No Event'
            when campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_Scan_N/A' then'AAA - Scandinavia - 15 Min'
            when campaign_name = 'Android_AAA_Events_Purchases_Women&Men_Scandinavia_N/A' then 'AAA - Scandinavia - Purchase'
            when campaign_name = 'Android_AAA_Events_30_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - 30 Min'
            when campaign_name = 'Android_AAA_Events_30_Minutes_Women&Men_LATAM/BR_N/A' then 'AAA - LATAM/BR - 30 Min'
            when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/PTBR_N/A' then 'AAA - LATAM/BR - Purchase'
            when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/PTBR_N/A_v2' then 'AAA - LATAM/BR - Purchase'
            when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/ES_N/A' then 'AAA - LATAM/ES - Purchase'
            when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/ES_N/A_v2' then 'AAA - LATAM/ES - Purchase'
            when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_Chile_N/A' then 'AAA - Chile - Purchase'
            when campaign_name = 'Art_Test_Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - No Event - Puzzle Games'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - No Event - Puzzle Games'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - 5 Min - Puzzle Games'
            when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - 15 Min - Puzzle Games'
            when campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'MAI - 30 Min - Puzzle Games'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Candy Crush' then 'MAI - No Event - Candy Crush'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Candy Crush' then 'MAI - 5 Min - Candy Crush'
            when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Candy Crush' then 'MAI - 15 Min - Candy Crush'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle & Decorate' then 'MAI - No Event - Puzzle & Decorate'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle&Decorate' then 'MAI - No Event - Puzzle & Decorate'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Puzzle & Decorate' then 'MAI - 5 Min - Puzzle & Decorate'
            when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Puzzle & Decorate' then 'MAI - 15 Min - Puzzle & Decorate'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Coin_Master' then 'MAI - No Event - Coin Master'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Coin Master' then 'MAI - 5 Min - Coin Master'
            when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Coin Master' then 'MAI - 15 Min - Coin Master'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_LATAM/MX - LAL - 1% - L7D_4+' then 'MAI - No Event - 4 of 7 Days'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_LATAM/MX - LAL - 1% - L7D_4+' then 'MAI - 5 Min - 4 of 7 Days'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_LATAM/ES - LAL - 1% - Initiate Checkout' then 'MAI - No Event - Start Checkout'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES - LAL - 1% - Like Page' then 'MAI - 5 Min - Like Page'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_LATAM/ES - LAL - 1% - Initiate Checkout' then 'MAI - 5 Min - Start Checkout'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Bubble Shooter' then 'MAI - No Event - Bubble Shooter'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'MAI - 5 Min - Bubble Shooter'
            when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'MAI - 15 Min - Bubble Shooter'
            when campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'MAI - 30 Min - Bubble Shooter'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Tile Blast' then 'MAI - No Event - Tile Blast'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'MAI - 5 Min - Tile Blast'
            when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'MAI - 15 Min - Tile Blast'
            when campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'MAI - 30 Min - Tile Blast'
            when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Blitz' then 'MAI - No Event - Blitz'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Blitz' then 'MAI - 5 Min - Blitz'
            when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Blitz' then 'MAI - 15 Min - Blitz'
            when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Walmart' then 'MAI - 5 Min - Walmart'
            when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Walmart' then 'MAI - 15 Min - Walmart'
            when campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Walmart' then 'MAI - 30 Min - Walmart'
            else campaign_name
          end"
}

constant: bfg_campaign_name_mapping {
  value: "
    case
      when lower(b.campaign) = 'ccb|fb|rdg|android|us|aeo|purchase|2024.08.06_1535953' then '20240806 - Facebook - USA - Purchase'
      when lower(b.campaign) = 'ccb|fb|rdg|android|us|aeo|tutorialcomplete|2024.08.02|_1535951' then '20240802 - Facebook - USA - Tutorial Complete'
      when lower(b.campaign) = 'ccb|rdg|facebook|creativetest|android|us|mai|rdgapp|jul24_1533998' then '20240801 - Facebook - USA - Creative Test'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|rdgapp|localized|jul24_1534808' then '20240801 - Facebook - LATAM - Tutorial Complete'
      when lower(b.campaign) = 'ccb|rdg|facebook|install|android|us|mai|rdgapp|jul24_1534693' then '20240731 - Facebook - USA - MAI'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|rdgapp|jul24_1532599' then '20240725 - Facebook - LATAM - Tutorial Complete'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|latam|aa+|aeo|engagement60|jul24_1526475' then '20240710 - Facebook - LATAM - 60 Min'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|jul24_1526471' then '20240710 - Facebook - LATAM - Tutorial Complete'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|jul24_1526879' then '20240710 - Facebook - LATAM - Tutorial Complete'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|us|aa+|aeo|tutorial|jul24_1522313' then '20240703 - Facebook - USA - Tutorial Complete'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|jun24_1520208' then '20240624 - Facebook - LATAM - Tutorial Complete'
      when lower(b.campaign) = 'ccb|android|facebook|us|charactermarketability|linkclick|cell1|may24_1507641' then '20240524 - Facebook - USA - Marketability'
      when lower(b.campaign) = 'ccb|android|facebook|us|charactermarketability|linkclick|cell2|may24_1507648' then '20240524 - Facebook - USA - Marketability'
      when lower(b.campaign) = 'ccb|android|facebook|us|charactermarketability|linkclick|cell3|may24_1507652' then '20240524 - Facebook - USA - Marketability'
      when lower(b.campaign) = 'chum|facebook|android|latam|aa+|mai|apr24_137769' then '20240424 - Facebook - LATAM - MAI'
      when lower(b.campaign) = 'chum|facebook|android|us|aa+|aeo|apr24_1500678' then '20240424 - Facebook - USA - Purchase'
      when lower(b.campaign) = 'chum|facebook|android|us|aa+|aeo|may24_1506781' then '20240524 - Facebook - USA - Purchase'
      when lower(b.campaign) = 'chum|facebook|creativetest|android|us|mai|may24_1508328' then '20240524 - Facebook - USA - Creative Test'
      when lower(b.campaign) = 'mistplay-ccb-android-os12-us-roasopti-all18_137763' then '20240424 - Mistplay - USA - ROAS'
      when lower(b.campaign) = 'ccb|facebook|android|us|aa+|mai|may24_1510798' then '20240524 - Facebook - USA - MAI'
      when lower(b.campaign) = 'chum|facebook|ios|latam|aa+|mai|apr24_137765' then '20240424 - Facebook - LATAM - MAI'
      when lower(b.campaign) = 'chum|facebook|creativetest|android|us|aa+|mai|may24_1508328' then '20240524 - Facebook - USA - Creative Test'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|us|aa+|aeo|tutorialcomplete|may24_1510911' then '20240530 - Facebook - USA - Tutorial Complete'
      when lower(b.campaign) = 'ccb|rdg|facebook|creativetest|android|us|mai|may24_1510912' then '20240530 - Facebook - USA - Creative Test'
      when lower(b.campaign) = 'ccb|rdg|facebook|android|us|aa+|aeo|purchase|may24_1510988' then '20240605 - Facebook - USA - Purchase'
      else b.campaign
    end"
}

constant: campaign_with_organics_estimate {
  value: "case
    when
      country = 'US'
      and date(created_date) between '2024-01-03' and '2024-01-24'
      then '20240103 - AA+ - USA - Purchase - With Organics'
    when
      country = 'US'
      and date(created_date) between '2023-08-09' and '2023-08-22'
      then '20230808 - AAA+ - USA - Purchase - With Organics'
    when
      country = 'US'
      and date(created_date) between '2023-05-24' and '2023-06-02'
      then '20230523 - AAA - USA - Purchase - With Organics'
    when
      country = 'US'
      and date(created_date) between '2023-01-31' and '2023-02-15'
      then '20230131 - AAA - USA - Purchase - With Organics'
  end"
}

constant: campaign_name_clean_update_backup {
  value: "case
  when
  ${TABLE}.campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/ES_N/A'
  and date(${TABLE}.singular_install_date) between '2023-04-11' and '2023-04-13'
  then 'AAA - LATAM/ES - 15 Min - 20230413'
  when ${TABLE}.campaign_name = 'Android_AAA+_30_Minutes_MX_20231129' then 'AAA - MX - 30 Min - 20231129'
  when ${TABLE}.campaign_name = 'Android_AAA_MAI_US_20230705' then 'AAA - USA - Install - 20230705'
  when ${TABLE}.campaign_name = 'Android_AAA+_MAI_US_20231110' then '20231110 - AAA+ - USA - Install'
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
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country = 'US'
        and date(created_date) between '2024-03-04' and '2024-03-27'
        then '6528145729122'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country = 'US'
        and date(created_date) between '2024-01-03' and '2024-01-24'
        then '6500848734722'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country = 'US'
        and date(created_date) between '2023-11-10' and '2023-11-14'
        then '6451988225922'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country = 'US'
        and date(created_date) between '2023-10-30' and '2023-11-04'
        then '6448215765722'

      when
        singular_partner_name is null
        and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
        and platform like '%iOS%'
        and date(created_date) between '2023-10-19' and '2023-10-24'
        then '6442174773322'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country = 'US'
        and date(created_date) between '2023-01-30' and '2023-02-14'
        then '6289277953122'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
        and date(created_date) between '2023-04-11' and '2023-04-13'
        then '6250035906122'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
        and date(created_date) between '2023-04-14' and '2023-04-23'
        then '6299378813122'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country in ('US','CA')
        and date(created_date) between '2023-04-28' and '2023-05-04'
        then '6301194225922'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country in ('US','CA')
        and date(created_date) between '2023-05-24' and '2023-06-05'
        then '6302530846522'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country in ('US','CA')
        and date(created_date) between '2023-07-11' and '2023-07-12'
        then '6342654069322'

      when
        singular_partner_name = 'Unattributed'
        and singular_campaign_id = ''
        and country in ('US','CA')
        and date(created_date) between '2023-07-21' and '2023-07-25'
        then '6353426252722'

      else singular_campaign_id
    end
  "
}

constant: singular_campaign_id_override_without_table {
  value: "
  case

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2024-01-03' and '2024-01-24'
  then '6500848734722'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2023-11-10' and '2023-11-14'
  then '6451988225922'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2023-10-30' and '2023-11-04'
  then '6448215765722'

  when
  singular_partner_name is null
  and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
  and platform like '%iOS%'
  and date(created_date) between '2023-10-19' and '2023-10-24'
  then '6442174773322'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2023-01-30' and '2023-02-14'
  then '6289277953122'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
  and date(created_date) between '2023-04-11' and '2023-04-13'
  then '6250035906122'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
  and date(created_date) between '2023-04-14' and '2023-04-23'
  then '6299378813122'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('US','CA')
  and date(created_date) between '2023-04-28' and '2023-05-04'
  then '6301194225922'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('US','CA')
  and date(created_date) between '2023-05-24' and '2023-06-05'
  then '6302530846522'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('US','CA')
  and date(created_date) between '2023-07-11' and '2023-07-12'
  then '6342654069322'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('US','CA')
  and date(created_date) between '2023-07-21' and '2023-07-25'
  then '6353426252722'

  else singular_campaign_id
  end
  "
}

constant: singular_campaign_blended_window_override {
  value: "
  case
  when
    country in ('US','CA')
    and date(created_date) between '2023-01-30' and '2023-02-18'
  then '20230131 - AAA - USA - Purchase'

  when
    country in ('US','CA')
    and date(created_date) between '2023-05-24' and '2023-06-05'
  then '20230523 - AAA - USA - Purchase'

  when
    country in ('US','CA')
    and date(created_date) between '2023-07-05' and '2023-07-07'
  then '20230705 - AAA - USA - Install'

  when
    country in ('US','CA')
    and date(created_date) between '2023-07-10' and '2023-07-15'
  then '20230710 - AAA - USA - 30 Min'

  when
    country in ('US','CA')
    and date(created_date) between '2023-07-20' and '2023-08-02'
  then '20230721 - AAA+ - USA - 30 Min'

  when
    country in ('US','CA')
    and date(created_date) between '2023-08-09' and '2023-08-21'
  then '20230808 - AAA+ - USA - Purchase'

  when
    country in ('US','CA')
    and date(created_date) between '2023-08-25' and '2023-08-28'
  then '20230825 - AAA+ - USA - 60 Min'

  when
    country in ('US','CA')
    and date(created_date) between '2023-08-28' and '2023-09-04'
  then '20230825 - AAA+ - USA - 30 Min'

  else 'Unmapped'
  end
  "
}

constant: singular_created_date_override {
  value: "
  case
  when
    singular_campaign_id = '6250035906122'
    and date(created_date) > '2023-04-13'
    then timestamp(date('2023-04-13'))

  when
    singular_campaign_id = '6299378813122'
    and date(created_date) > '2023-04-17'
    then timestamp(date('2023-04-17'))

  when
    singular_partner_name = 'Unattributed'
    and singular_campaign_id = ''
    and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
    and date(created_date) > '2023-04-17'
    then timestamp(date('2023-04-17'))

  else created_date
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
            when ${TABLE}.source_id like '%Puzzles%' then 'Puzzles'
            when ${TABLE}.source_id like '%Go_Fish%' then 'Go Fish'
            when ${TABLE}.source_id like '%Gem_Quest%' then 'Gem Quest'

            when ${TABLE}.source_id like '%DefaultRewardedVideo' then 'Generic Reward'
            when ${TABLE}.source_id like '%Rewarded' then 'Generic Reward'

            else ${TABLE}.source_id
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
# Ads Mapping
###################################################################

constant: ad_placements_clean {
  value: "case
  when ${TABLE}.source_id like '%DailyReward' then 'Daily Reward'
  when ${TABLE}.source_id like '%Moves_Master%' then 'Moves Master'
  when ${TABLE}.source_id like '%Pizza%' then 'Pizza'
  when ${TABLE}.source_id like '%Lucky_Dice%' then 'Lucky Dice'
  when ${TABLE}.source_id like '%RequestHelp%' then 'Ask For Help'
  when ${TABLE}.source_id like '%Battle_Pass%' then 'Battle Pass'
  when ${TABLE}.source_id like '%Puzzles%' then 'Puzzles'
  when ${TABLE}.source_id like '%Go_Fish%' then 'Go Fish'
  when ${TABLE}.source_id like '%Gem_Quest%' then 'Gem Quest'

  when ${TABLE}.source_id like '%DefaultRewardedVideo' then 'Generic Reward'
  when ${TABLE}.source_id like '%Rewarded' then 'Generic Reward'

  when ${TABLE}.source_id = 'quick_boost_rocket' then 'Rocket'
  when ${TABLE}.source_id = 'quick_lives' then 'Lives'

  else ${TABLE}.source_id
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

constant: ad_placements {
  value: "case
  when ${TABLE}.source_id like '%DailyReward' then 'Daily Reward'
  when ${TABLE}.source_id like '%Moves_Master%' then 'Moves Master'
  when ${TABLE}.source_id like '%Pizza%' then 'Pizza'
  when ${TABLE}.source_id like '%Lucky_Dice%' then 'Lucky Dice'
  when ${TABLE}.source_id like '%RequestHelp%' then 'Ask For Help'
  when ${TABLE}.source_id like '%Battle_Pass%' then 'Battle Pass'
  when ${TABLE}.source_id like '%Puzzles%' then 'Puzzles'
  when ${TABLE}.source_id like '%Go_Fish%' then 'Go Fish'
  when ${TABLE}.source_id like '%Gem_Quest%' then 'Gem Quest'

  when ${TABLE}.ad_reward_source_id = 'quick_boost_rocket' then 'Rocket'
  when ${TABLE}.ad_reward_source_id = 'quick_lives' then 'Lives'
  when ${TABLE}.ad_reward_source_id = 'quick_magnifiers' then 'Magnifiers'
  when ${TABLE}.ad_reward_source_id = 'treasure_trove' then 'Treasure Trove'

  else 'Unmapped'
  end"
}

constant: ad_placements_for_ad_summary {
  value: "case
  when source_id like '%DailyReward' then 'Daily Reward'
  when source_id like '%Moves_Master%' then 'Moves Master'
  when source_id like '%Pizza%' then 'Pizza'
  when source_id like '%Lucky_Dice%' then 'Lucky Dice'
  when source_id like '%RequestHelp%' then 'Ask For Help'
  when source_id like '%Battle_Pass%' then 'Battle Pass'
  when source_id like '%Puzzles%' then 'Puzzles'
  when source_id like '%Go_Fish%' then 'Go Fish'
  when source_id like '%Gem_Quest%' then 'Gem Quest'

  when ad_reward_source_id = 'quick_boost_rocket' then 'Rocket'
  when ad_reward_source_id = 'quick_lives' then 'Lives'
  when ad_reward_source_id = 'quick_magnifiers' then 'Magnifiers'
  when ad_reward_source_id = 'treasure_trove' then 'Treasure Trove'
  when ad_reward_source_id = 'castle_climb_rescue' then 'Castle Climb'
  when ad_reward_source_id = 'quick_torches' then 'Gem Quest'

  else 'Unmapped'
  end"
}

constant: ad_placements_for_tickets_spend {
  value: "case
  when source_id like '%DailyReward' then 'Daily Reward'
  when source_id like '%Moves_Master%' then 'Moves Master'
  when source_id like '%Pizza%' then 'Pizza'
  when source_id like '%Lucky_Dice%' then 'Lucky Dice'
  when source_id like '%RequestHelp%' then 'Ask For Help'
  when source_id like '%Battle_Pass%' then 'Battle Pass'
  when source_id like '%Puzzles%' then 'Puzzles'
  when source_id like '%Go_Fish%' then 'Go Fish'
  when source_id like '%Gem_Quest%' then 'Gem Quest'

  when source_id like '%DefaultRewardedVideo' then 'Generic Reward'
  when source_id like '%Rewarded' then 'Generic Reward'

  when source_id = 'quick_boost_rocket' then 'Rocket'
  when source_id = 'quick_lives' then 'Lives'
  when source_id = 'treasure_trove' then 'Treasure Trove'
  when source_id = 'quick_torches' then 'Gem Quest'
  when source_id = 'castle_climb_rescue' then 'Castle Climb'

  else source_id
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
    when ${TABLE}.iap_id = 'item_shuffle' then '1x Shuffle Skill'
    when ${TABLE}.iap_id = 'item_shuffle_bulk' then '5x Shuffle Skill'
    when ${TABLE}.iap_id = 'item_chopsticks_bulk' then '5x Chopsticks Skill'
    when ${TABLE}.iap_id = 'item_skillet' then '1x Skillet Skill'
    when ${TABLE}.iap_id = 'item_skillet_bulk' then '5x Skillet Skill'
    when ${TABLE}.iap_id = 'item_disc' then '1x Disco Skill'
    when ${TABLE}.iap_id = 'item_disco_bulk' then '5x Disco Skill'

    when ${TABLE}.iap_id = 'item_disco_unlock' then 'Chum Chum Unlock: Karma Chameleon'

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
    when ${TABLE}.iap_id = 'item_095' then 'Skillet Chum Chums & Coins Special!'
    when ${TABLE}.iap_id = 'item_105' then 'Chopsticks Chum Chums & Coins Special!'
    when ${TABLE}.iap_id = 'item_088' then 'Karma Chum Chums & Coins Special!'

    when ${TABLE}.iap_id = 'item_055' then 'Coins (S)'
    when ${TABLE}.iap_id = 'item_056' then 'Coins (M)'
    when ${TABLE}.iap_id = 'item_057' then 'Coins (L)'
    when ${TABLE}.iap_id = 'item_097' then 'Coins (XL)'


    when ${TABLE}.iap_id = 'item_058' then 'Lives (S)'
    when ${TABLE}.iap_id = 'item_059' then 'Lives (M)'
    when ${TABLE}.iap_id = 'item_060' then 'Lives (L)'

    when ${TABLE}.iap_id = 'item_063' then 'Treasure Trove (XS)'
    when ${TABLE}.iap_id = 'item_066' then 'Treasure Trove (S)'
    when ${TABLE}.iap_id = 'item_069' then 'Treasure Trove (M)'
    when ${TABLE}.iap_id = 'item_072' then 'Treasure Trove (L)'
    when ${TABLE}.iap_id = 'item_099' then 'Treasure Trove (XL)'

    when ${TABLE}.iap_id = 'item_076' then 'Magnifiers (S)'
    when ${TABLE}.iap_id = 'item_077' then 'Magnifiers (M)'
    when ${TABLE}.iap_id = 'item_078' then 'Magnifiers (L)'

    when ${TABLE}.iap_id = 'item_089' then 'Level Bundle (100)'
    when ${TABLE}.iap_id = 'item_090' then 'Level Bundle (200)'
    when ${TABLE}.iap_id = 'item_091' then 'Level Bundle (300)'
    when ${TABLE}.iap_id = 'item_092' then 'Level Bundle (400)'
    when ${TABLE}.iap_id = 'item_098' then 'Level Bundle (500)'

    when ${TABLE}.iap_id = 'battle_pass' then 'Premium Battle Pass'

    when ${TABLE}.iap_id = 'item_ticket_basic' then 'Tickets (S)'
    when ${TABLE}.iap_id = 'item_ticket_premium' then 'Tickets (M)'
    when ${TABLE}.iap_id = 'item_ticket_mega' then 'Tickets (L)'

    when ${TABLE}.iap_id = 'item_bundle_100k5tick' then 'Item Bundle: 100K Coins 5 Tickets'
    when ${TABLE}.iap_id = 'item_bundle_3chums' then 'Item Bundle: 3 Chums'
    when ${TABLE}.iap_id = 'item_bundle_062024' then 'Item Bundle: Extra Moves, Coins, Tickets'
    when ${TABLE}.iap_id = 'item_chopsticks' then 'Chopsticks'


    else ${TABLE}.iap_id
  end"
}

constant: iap_id_strings_grouped_new {
  value: "
    case
      when ${TABLE}.iap_id = 'item_001' then 'Free Machine'
      when ${TABLE}.iap_id = 'item_017' then 'Free Machine'
      when ${TABLE}.iap_id = 'item_018' then 'Free Machine'
      when ${TABLE}.iap_id = 'item_004' then 'Coins'
      when ${TABLE}.iap_id = 'item_005' then 'Coins'
      when ${TABLE}.iap_id = 'item_006' then 'Coins'
      when ${TABLE}.iap_id = 'item_007' then 'Coins'
      when ${TABLE}.iap_id = 'item_020' then 'Coins'
      when ${TABLE}.iap_id = 'item_021' then 'Coins'
      when ${TABLE}.iap_id = 'item_057' then 'Coins'
      when ${TABLE}.iap_id = 'item_097' then 'Coins'
      when ${TABLE}.iap_id = 'item_008' then 'Gems'
      when ${TABLE}.iap_id = 'item_026' then 'Gems'
      when ${TABLE}.iap_id = 'item_009' then 'Gems'
      when ${TABLE}.iap_id = 'item_010' then 'Gems'
      when ${TABLE}.iap_id = 'item_011' then 'Gems'
      when ${TABLE}.iap_id = 'item_012' then 'Gems'
      when ${TABLE}.iap_id = 'item_013' then 'Gems'
      when ${TABLE}.iap_id = 'item_023' then 'Lives'
      when ${TABLE}.iap_id = 'item_014' then 'Lives'
      when ${TABLE}.iap_id = 'item_015' then 'Lives'
      when ${TABLE}.iap_id = 'item_016' then 'Lives'
      when ${TABLE}.iap_id = 'item_024' then 'Lives'
      when ${TABLE}.iap_id = 'item_025' then 'Lives'
      when ${TABLE}.iap_id = 'item_028' then 'Lives'
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
      when ${TABLE}.iap_id = 'item_shuffle' then 'Chum Chum Skills'
      when ${TABLE}.iap_id = 'item_shuffle_bulk' then 'Chum Chum Skills'
      when ${TABLE}.iap_id = 'item_chopsticks_bulk' then 'Chum Chum Skills'
      when ${TABLE}.iap_id = 'item_skillet' then 'Chum Chum Skills'
      when ${TABLE}.iap_id = 'item_skillet_bulk' then 'Chum Chum Skills'
      when ${TABLE}.iap_id = 'item_disc' then 'Chum Chum Skills'
      when ${TABLE}.iap_id = 'item_disco_bulk' then 'Chum Chum Skills'

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
      when ${TABLE}.iap_id = 'item_095' then 'Chum Chums & Coins'
      when ${TABLE}.iap_id = 'item_105' then 'Chum Chums & Coins'
      when ${TABLE}.iap_id = 'item_088' then 'Chum Chums & Coins'

      when ${TABLE}.iap_id = 'item_055' then 'Coins'
      when ${TABLE}.iap_id = 'item_056' then 'Coins'
      when ${TABLE}.iap_id = 'item_057' then 'Coins'
      when ${TABLE}.iap_id = 'item_097' then 'Coins'

      when ${TABLE}.iap_id = 'item_058' then 'Lives'
      when ${TABLE}.iap_id = 'item_059' then 'Lives'
      when ${TABLE}.iap_id = 'item_060' then 'Lives'

      when ${TABLE}.iap_id = 'item_063' then 'Treasure Trove'
      when ${TABLE}.iap_id = 'item_066' then 'Treasure Trove'
      when ${TABLE}.iap_id = 'item_069' then 'Treasure Trove'
      when ${TABLE}.iap_id = 'item_072' then 'Treasure Trove'
      when ${TABLE}.iap_id = 'item_099' then 'Treasure Trove'

      when ${TABLE}.iap_id = 'item_076' then 'Magnifiers'
      when ${TABLE}.iap_id = 'item_077' then 'Magnifiers'
      when ${TABLE}.iap_id = 'item_078' then 'Magnifiers'

      when ${TABLE}.iap_id = 'item_089' then 'Level Bundle'
      when ${TABLE}.iap_id = 'item_090' then 'Level Bundle'
      when ${TABLE}.iap_id = 'item_091' then 'Level Bundle'
      when ${TABLE}.iap_id = 'item_092' then 'Level Bundle'
      when ${TABLE}.iap_id = 'item_098' then 'Level Bundle'

      when ${TABLE}.iap_id = 'battle_pass' then 'Premium Battle Pass'

      when ${TABLE}.iap_id = 'item_ticket_basic' then 'Tickets'
      when ${TABLE}.iap_id = 'item_ticket_premium' then 'Tickets'
      when ${TABLE}.iap_id = 'item_ticket_mega' then 'Tickets'

      when ${TABLE}.iap_id = 'item_disco_unlock' then 'Chum Chum Unlock'

    when ${TABLE}.iap_id = 'item_bundle_100k5tick' then 'Item Bundles'
    when ${TABLE}.iap_id = 'item_bundle_3chums' then 'Item Bundles'
    when ${TABLE}.iap_id = 'item_bundle_062024' then 'Item Bundles'
    when ${TABLE}.iap_id = 'item_chopsticks' then 'Chum Chum Skills'

      else ${TABLE}.iap_id
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

     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_097' then 'Coins (XL)'
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
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'battle_pass' then 'Battle Pass'



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

     when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_097' then 'Coins'
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
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'battle_pass' then 'Battle Pass'



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

    when ${TABLE}.source_id = 'castle_climb_rescue' and ${TABLE}.iap_id = 'item_rescue' then 'Castle Climb Rescue'
    when ${TABLE}.source_id = 'character' and ${TABLE}.iap_id = 'item_moves_unlock' then 'Moves Bunny Unlock'
    when ${TABLE}.source_id = 'extra_moves_12' and ${TABLE}.iap_id = 'extra_moves_12' then 'Extra Moves'
    when ${TABLE}.source_id = 'extra_moves_15' and ${TABLE}.iap_id = 'extra_moves_15' then 'Extra Moves'
    when ${TABLE}.source_id = 'extra_moves_9' and ${TABLE}.iap_id = 'extra_moves_9' then 'Extra Moves'
    when ${TABLE}.source_id = 'gem_quest' and ${TABLE}.iap_id = 'item_torch' then 'Gem Quest Torch'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'item_002' then 'Legacy'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_019' and ${TABLE}.iap_id = 'item_019' then 'Extra Moves'
    when ${TABLE}.source_id = 'quick_skill_disco' and ${TABLE}.iap_id = 'item_disco' then 'Disco Chameleon'
    when ${TABLE}.source_id = 'quick_skill_disco' and ${TABLE}.iap_id = 'item_disco_bulk' then 'Disco Chameleon'
    when ${TABLE}.source_id = 'quick_skill_moves' and ${TABLE}.iap_id = 'item_moves' then 'Moves Bunny'
    when ${TABLE}.source_id = 'quick_skill_moves' and ${TABLE}.iap_id = 'item_moves_bulk' then 'Moves Bunny'

    when ${TABLE}.source_id = 'extra_moves_7' and ${TABLE}.iap_id = 'extra_moves_7' then 'Extra Moves'
    when ${TABLE}.source_id = 'character' and ${TABLE}.iap_id = 'item_skillet_unlock' then 'Skillet'
    when ${TABLE}.source_id = 'extra_moves_10' and ${TABLE}.iap_id = 'extra_moves_10' then 'Extra Moves'
    when ${TABLE}.source_id = 'quick_skill_skillet' and ${TABLE}.iap_id = 'item_skillet_bulk' then 'Skillet'
    when ${TABLE}.source_id = 'quick_skill_chopsticks' and ${TABLE}.iap_id = 'item_chopsticks_bulk' then 'Chopsticks'
    when ${TABLE}.source_id = 'quick_skill_chopsticks' and ${TABLE}.iap_id = 'item_chopsticks' then 'Chopsticks'
    when ${TABLE}.source_id = 'request_help' and ${TABLE}.iap_id = 'request_help' then 'Request Help'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'item_022' then 'Legacy'
    when ${TABLE}.source_id = 'quick_skill_skillet' and ${TABLE}.iap_id = 'item_skillet' then 'Skillet'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'item_003' then 'Legacy'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'item_002' then 'Legacy'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_003' and ${TABLE}.iap_id = 'item_003' then 'Legacy'
    when ${TABLE}.source_id is null and ${TABLE}.iap_id = 'item_clear_cell' then 'Clear Cell'
    when ${TABLE}.source_id is null and ${TABLE}.iap_id = 'item_clear_horizontal' then 'Clear Horizontal'

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

    when ${TABLE}.source_id = 'castle_climb_rescue' and ${TABLE}.iap_id = 'item_rescue' then 'Castle Climb'
    when ${TABLE}.source_id = 'character' and ${TABLE}.iap_id = 'item_moves_unlock' then 'New Chum Chum'
    when ${TABLE}.source_id = 'extra_moves_12' and ${TABLE}.iap_id = 'extra_moves_12' then 'Extra Moves'
    when ${TABLE}.source_id = 'extra_moves_15' and ${TABLE}.iap_id = 'extra_moves_15' then 'Extra Moves'
    when ${TABLE}.source_id = 'extra_moves_9' and ${TABLE}.iap_id = 'extra_moves_9' then 'Extra Moves'
    when ${TABLE}.source_id = 'gem_quest' and ${TABLE}.iap_id = 'item_torch' then 'Gem Quest'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_001' and ${TABLE}.iap_id = 'item_002' then 'Legacy'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_019' and ${TABLE}.iap_id = 'item_019' then 'Extra Moves'
    when ${TABLE}.source_id = 'quick_skill_disco' and ${TABLE}.iap_id = 'item_disco' then 'Chum Chum Skill'
    when ${TABLE}.source_id = 'quick_skill_disco' and ${TABLE}.iap_id = 'item_disco_bulk' then 'Chum Chum Skill'
    when ${TABLE}.source_id = 'quick_skill_moves' and ${TABLE}.iap_id = 'item_moves' then 'Chum Chum Skill'
    when ${TABLE}.source_id = 'quick_skill_moves' and ${TABLE}.iap_id = 'item_moves_bulk' then 'Chum Chum Skill'

    when ${TABLE}.source_id = 'extra_moves_7' and ${TABLE}.iap_id = 'extra_moves_7' then 'Extra Moves'
    when ${TABLE}.source_id = 'character' and ${TABLE}.iap_id = 'item_skillet_unlock' then 'New Chum Chum'
    when ${TABLE}.source_id = 'extra_moves_10' and ${TABLE}.iap_id = 'extra_moves_10' then 'Extra Moves'
    when ${TABLE}.source_id = 'quick_skill_skillet' and ${TABLE}.iap_id = 'item_skillet_bulk' then 'Chum Chum Skill'
    when ${TABLE}.source_id = 'quick_skill_chopsticks' and ${TABLE}.iap_id = 'item_chopsticks_bulk' then 'Chum Chum Skill'
    when ${TABLE}.source_id = 'quick_skill_chopsticks' and ${TABLE}.iap_id = 'item_chopsticks' then 'Chum Chum Skill'
    when ${TABLE}.source_id = 'request_help' and ${TABLE}.iap_id = 'request_help' then 'Ask For Help'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_017' and ${TABLE}.iap_id = 'item_022' then 'Legacy'
    when ${TABLE}.source_id = 'quick_skill_skillet' and ${TABLE}.iap_id = 'item_skillet' then 'Chum Chum Skill'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'item_003' then 'Legacy'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_002' and ${TABLE}.iap_id = 'item_002' then 'Legacy'
    when ${TABLE}.source_id = 'Panel_Store.Purchase.item_003' and ${TABLE}.iap_id = 'item_003' then 'Legacy'
    when ${TABLE}.source_id is null and ${TABLE}.iap_id = 'item_clear_cell' then 'Chum Chum Skill'
    when ${TABLE}.source_id is null and ${TABLE}.iap_id = 'item_clear_horizontal' then 'Chum Chum Skill'

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
# Singular Creative Mapping
# Simplified Ad Name
###################################################################

constant: singular_creative_simplified_ad_name {
  value: "
  case

    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_16x9_EN.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_16x9_ES.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_16x9_ptBR.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_3x4_EN.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_3x4_ES.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_3x4_ptBR.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_9x16_EN.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_9x16_ES.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_9x16_ptBR.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_9x19-5_EN.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_9x19-5_ES.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'ASOTrailer_30s_9x19-5_ptBR.mp4' then 'ASO Trailer'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-AsianBaby_25s_1x1_EN.mp4' then 'AsianBaby'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-AsianBaby_25s_9x16_EN.mp4' then 'AsianBaby'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-GirlWithCats_25s_1x1_EN.mp4' then 'GirlWithCats'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-GirlWithCats_25s_9x16_EN.mp4' then 'GirlWithCats'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-HandsomeMan-v01_25s_1x1_EN.mp4' then 'HansomeMan_001'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-HandsomeMan-v01_25s_9x16_EN.mp4' then 'HansomeMan_001'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-HandsomeMan-v02_25s_1x1_EN.mp4' then 'HansomeMan_002'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-HandsomeMan-v02_25s_9x16_EN.mp4' then 'HansomeMan_002'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-LadyBossWithCats_25s_1x1_EN.mp4' then 'LadyBossWithCats'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-LadyBossWithCats_25s_9x16_EN.mp4' then 'LadyBossWithCats'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-LadyBossWithDogs_25s_1x1_EN.mp4' then 'LadyBossWithDogs'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-LadyBossWithDogs_25s_9x16_EN.mp4' then 'LadyBossWithDogs'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-LoungingWithCats_25s_1x1_EN.mp4' then 'LoungingWithCats'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-LoungingWithCats_25s_9x16_EN.mp4' then 'LoungingWithCats'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-LoungingWithSheep_25s_1x1_EN.mp4' then 'LoungingWithSheep'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-LoungingWithSheep_25s_9x16_EN.mp4' then 'LoungingWithSheep'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-ManOnHorse_25s_1x1_EN.mp4' then 'ManOnHorse'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-ManOnHorse_25s_9x16_EN.mp4' then 'ManOnHorse'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-ManWithHorse_25s_1x1_EN.mp4' then 'ManWithHorse'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-ManWithHorse_25s_9x16_EN.mp4' then 'ManWithHorse'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-PunkAsianGrandma-v01_25s_9x16_EN.mp4' then 'PunkAsianGrandma_001'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-PunkAsianGrandma-v02_25s_9x16_EN.mp4' then 'PunkAsianGrandma_002'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-SpinWithKoala_25s_9x16_EN.mp4' then 'SpinWithKoala'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-SpinWithSloth_25s_1x1_EN.mp4' then 'SpinWithSloth'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-SpinWithSloth_25s_9x16_EN.mp4' then 'SpinWithSloth'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-YogaWithSloth-v01_25s_1x1_EN.mp4' then 'YogaWithSloth_001'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-YogaWithSloth-v01_25s_9x16_EN.mp4' then 'YogaWithSloth_001'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-YogaWithSloth-v02_25s_1x1_EN.mp4' then 'YogaWithSloth_002'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-YogaWithSloth-v02_25s_9x16_EN.mp4' then 'YogaWithSloth_002'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-v01_25s_1x1_EN.mp4' then 'TestimonialAI-v01'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI-v02_25s_1x1_EN.mp4' then 'TestimonialAI-v02'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_TestimonialAI_25s_1x1_EN.mp4' then 'Testimonial'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_Testimonial_30s_16x9_EN.mp4' then 'Testimonial'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_Testimonial_30s_16x9_ES.mp4' then 'Testimonial'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_Testimonial_30s_1x1_EN.mp4' then 'Testimonial'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_Testimonial_30s_1x1_ES.mp4' then 'Testimonial'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_Testimonial_30s_4x5_ES.mp4' then 'Testimonial'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_Testimonial_30s_9x16_EN.mp4' then 'Testimonial'
    when ${TABLE}.full_ad_name = 'CCB_Airtraffic_Testimonial_30s_9x16_ES.mp4' then 'Testimonial'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_APVUpdate_30s_16x9_EN.mp4' then 'APVUpdate'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_APVUpdate_30s_16x9_ES.mp4' then 'APVUpdate'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_APVUpdate_30s_3x4_EN.mp4' then 'APVUpdate'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_APVUpdate_30s_3x4_ES.mp4' then 'APVUpdate'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_APVUpdate_30s_9x16_EN.mp4' then 'APVUpdate'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_APVUpdate_30s_9x16_ES.mp4' then 'APVUpdate'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_APVUpdate_30s_9x19.5_ES.mp4' then 'APVUpdate'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_16x9_EN.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_16x9_ES.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_16x9_PTBR.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_1x1_EN.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_1x1_ES.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_1x1_PTBR.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_4x5_EN.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_4x5_ES.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_4x5_PTBR.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_9x16_EN.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_9x16_ES.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_Chef_26s_9x16_PTBR.mp4' then 'Chef'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_ElevatorDangerous_30s_16x9_EN.mp4' then 'ElevatorDangerous'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_ElevatorDangerous_30s_1x1_EN.mp4' then 'ElevatorDangerous'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_ElevatorDangerous_30s_9x16_EN.mp4' then 'ElevatorDangerous'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_16x9_EN.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_16x9_ES.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_16x9_PTBR.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_1x1_EN.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_1x1_ES.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_1x1_PTBR.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_4x5_EN.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_4x5_ES.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_4x5_PTBR.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_9x16_EN.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_9x16_ES.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_SassyDog_30s_9x16_PTBR.mp4' then 'SassyDog'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_TiltingTable_25s_16x9_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_TiltingTable_25s_1x1_EN.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_TiltingTable_25s_1x1_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_TiltingTable_25s_9x16_EN.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_Airtraffic_TiltingTable_25s_9x16_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_SimpleMatch_1080x1080_23s_ES.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'EB_SimpleMatch_1080x1080_23s_PTBR.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'EB_SimpleMatch_1080x1350_23s_ES.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'EB_SimpleMatch_1080x1350_23s_PTBR.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'EB_SimpleMatch_1080x1920_23s_ES.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'EB_SimpleMatch_1080x1920_23s_PTBR.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'EB_SimpleMatch_1920x1080_23s_ES.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'EB_SimpleMatch_1920x1080_23s_PTBR.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'EB_TTC_1080_1080.mp4' then 'TTC'
    when ${TABLE}.full_ad_name = 'EB_TTC_1080_1080_BR.mp4' then 'TTC'
    when ${TABLE}.full_ad_name = 'EB_TTC_1080_1350.mp4' then 'TTC'
    when ${TABLE}.full_ad_name = 'EB_TTC_1080_1350_BR.mp4' then 'TTC'
    when ${TABLE}.full_ad_name = 'EB_TTC_1080_1920.mp4' then 'TTC'
    when ${TABLE}.full_ad_name = 'EB_TTC_1080_1920_BR.mp4' then 'TTC'
    when ${TABLE}.full_ad_name = 'EB_TTC_1920_1080.mp4' then 'TTC'
    when ${TABLE}.full_ad_name = 'EB_TTC_1920_1080_BR.mp4' then 'TTC'
    when ${TABLE}.full_ad_name = 'EB_TiltingTable_25s_16x9_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_TiltingTable_25s_16x9_PT-BR.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_TiltingTable_25s_1x1_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_TiltingTable_25s_1x1_PT-BR.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_TiltingTable_25s_4x5_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_TiltingTable_25s_4x5_PT-BR.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_TiltingTable_25s_9x16_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_TiltingTable_25s_9x16_PT-BR.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'EB_Zen_1080_1080_30.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'EB_Zen_1080_1080_BR.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'EB_Zen_1080_1350_30.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'EB_Zen_1080_1350_BR.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'EB_Zen_1080_1920_30.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'EB_Zen_1080_1920_BR.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'EB_Zen_1920_1080_30.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'EB_Zen_1920_1080_BR.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Elevator_30s_16x9_EN.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_16x9_ES.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_16x9_ptBR.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_1x1_EN.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_1x1_ES.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_1x1_ptBR.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_4x5_EN.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_4x5_ES.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_4x5_ptBR.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_9x16_EN.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_9x16_ES.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Elevator_30s_9x16_ptBR.mp4' then 'Elevator'
    when ${TABLE}.full_ad_name = 'Match3_1080_1080_BR.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1080_1080_EN.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1080_1080_ES.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1080_1350_BR.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1080_1350_EN.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1080_1350_ES.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1080_1920_BR.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1080_1920_EN.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1080_1920_ES.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1920_1080_BR.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1920_1080_EN.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'Match3_1920_1080_ES.mp4' then 'Match3'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_16x9_EN.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_16x9_ES.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_16x9_ptBR.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_1x1_EN.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_1x1_ES.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_1x1_ptBR.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_4x5_EN.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_4x5_ES.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_4x5_ptBR.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_9x16_EN.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_9x16_ES.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleBlast_30s_9x16_ptBR.mp4' then 'SimpleBlast'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_16x9_EN.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_16x9_ES.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_16x9_ptBR.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_1x1_EN.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_1x1_ES.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_1x1_ptBR.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_4x5_EN.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_4x5_ES.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_4x5_ptBR.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_9x16_EN.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_9x16_ES.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'SimpleMatch_23s_9x16_ptBR.mp4' then 'SimpleMatch'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_16x9_EN.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_16x9_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_16x9_ptBR.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_1x1_EN.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_1x1_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_1x1_ptBR.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_4x5_EN.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_4x5_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_4x5_ptBR.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_9x16_EN.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_9x16_ES.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'TiltingTable_25s_9x16_ptBR.mp4' then 'TiltingTable'
    when ${TABLE}.full_ad_name = 'WeirdTeddyBear_EN.mp4' then 'WeirdTeddyBear'
    when ${TABLE}.full_ad_name = 'WeirdTeddyBear_ES.mp4' then 'WeirdTeddyBear'
    when ${TABLE}.full_ad_name = 'WeirdTeddyDog_ES.mp4' then 'WeirdTeddyDog'
    when ${TABLE}.full_ad_name = 'WeirdTreats_ES.mp4' then 'WeirdTreats'
    when ${TABLE}.full_ad_name = 'Zen_1080_1080_BR.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1080_1080_EN.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1080_1080_ES.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1080_1350_BR.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1080_1350_EN.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1080_1350_ES.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1080_1920_BR.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1080_1920_EN.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1080_1920_ES.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1920_1080_BR.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1920_1080_EN.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'Zen_1920_1080_ES.mp4' then 'Zen'
    when ${TABLE}.full_ad_name = 'cropped_1X1_(x, y)_(0, 342)_width_2048px_height_2048px_EB_Airtraffic_APVUpdate_30s_3x4_ES.mp4' then 'APVUpdate'



  else 'Unmapped'
  end
  "
}

###################################################################
# Battle Pass Number
###################################################################

# Created using this file
# Ask Tal Kreuch for access
# https://docs.google.com/spreadsheets/d/1IkAchnFFhkoxvtLkTmTVN023P6P0pUcNPOcToNBZVHU/edit?usp=sharing

constant: battle_pass_number {
  value: "
  case

    when date(${TABLE}.rdg_date) >= '2023-08-03' and date(${TABLE}.rdg_date) < '2023-09-01' then 'bp_2023_08'
    when date(${TABLE}.rdg_date) >= '2023-09-03' and date(${TABLE}.rdg_date) < '2023-10-01' then 'bp_2023_09'
    when date(${TABLE}.rdg_date) >= '2023-10-02' and date(${TABLE}.rdg_date) < '2023-11-01' then 'bp_2023_10'
    when date(${TABLE}.rdg_date) >= '2023-11-02' and date(${TABLE}.rdg_date) < '2023-12-01' then 'bp_2023_11'
    when date(${TABLE}.rdg_date) >= '2023-12-02' and date(${TABLE}.rdg_date) < '2024-01-01' then 'bp_2023_12'
    when date(${TABLE}.rdg_date) >= '2024-01-02' and date(${TABLE}.rdg_date) < '2024-02-01' then 'bp_2024_01'
    when date(${TABLE}.rdg_date) >= '2024-02-02' and date(${TABLE}.rdg_date) < '2024-03-01' then 'bp_2024_02'
    when date(${TABLE}.rdg_date) >= '2024-03-02' and date(${TABLE}.rdg_date) < '2024-04-01' then 'bp_2024_03'
    when date(${TABLE}.rdg_date) >= '2024-04-02' and date(${TABLE}.rdg_date) < '2024-05-01' then 'bp_2024_04'
    when date(${TABLE}.rdg_date) >= '2024-05-02' and date(${TABLE}.rdg_date) < '2024-06-01' then 'bp_2024_05'
    when date(${TABLE}.rdg_date) >= '2024-06-02' and date(${TABLE}.rdg_date) < '2024-07-01' then 'bp_2024_06'
    when date(${TABLE}.rdg_date) >= '2024-07-02' and date(${TABLE}.rdg_date) < '2024-08-01' then 'bp_2024_07'
    when date(${TABLE}.rdg_date) >= '2024-08-02' and date(${TABLE}.rdg_date) < '2024-09-01' then 'bp_2024_08'
    when date(${TABLE}.rdg_date) >= '2024-09-02' and date(${TABLE}.rdg_date) < '2024-10-01' then 'bp_2024_09'
    when date(${TABLE}.rdg_date) >= '2024-10-02' and date(${TABLE}.rdg_date) < '2024-11-01' then 'bp_2024_10'
    when date(${TABLE}.rdg_date) >= '2024-11-02' and date(${TABLE}.rdg_date) < '2024-12-01' then 'bp_2024_11'
    when date(${TABLE}.rdg_date) >= '2024-12-02' and date(${TABLE}.rdg_date) < '2025-01-01' then 'bp_2024_12'
    when date(${TABLE}.rdg_date) >= '2025-01-02' and date(${TABLE}.rdg_date) < '2025-02-01' then 'bp_2025_01'
    when date(${TABLE}.rdg_date) >= '2025-02-02' and date(${TABLE}.rdg_date) < '2025-03-01' then 'bp_2025_02'
    when date(${TABLE}.rdg_date) >= '2025-03-02' and date(${TABLE}.rdg_date) < '2025-04-01' then 'bp_2025_03'
    when date(${TABLE}.rdg_date) >= '2025-04-02' and date(${TABLE}.rdg_date) < '2025-05-01' then 'bp_2025_04'
    when date(${TABLE}.rdg_date) >= '2025-05-02' and date(${TABLE}.rdg_date) < '2025-06-01' then 'bp_2025_05'
    when date(${TABLE}.rdg_date) >= '2025-06-02' and date(${TABLE}.rdg_date) < '2025-07-01' then 'bp_2025_06'
    when date(${TABLE}.rdg_date) >= '2025-07-02' and date(${TABLE}.rdg_date) < '2025-08-01' then 'bp_2025_07'
    when date(${TABLE}.rdg_date) >= '2025-08-02' and date(${TABLE}.rdg_date) < '2025-09-01' then 'bp_2025_08'
    when date(${TABLE}.rdg_date) >= '2025-09-02' and date(${TABLE}.rdg_date) < '2025-10-01' then 'bp_2025_09'
    when date(${TABLE}.rdg_date) >= '2025-10-02' and date(${TABLE}.rdg_date) < '2025-11-01' then 'bp_2025_10'
    when date(${TABLE}.rdg_date) >= '2025-11-02' and date(${TABLE}.rdg_date) < '2025-12-01' then 'bp_2025_11'
    when date(${TABLE}.rdg_date) >= '2025-12-02' and date(${TABLE}.rdg_date) < '2026-01-01' then 'bp_2025_12'
    when date(${TABLE}.rdg_date) >= '2026-01-02' and date(${TABLE}.rdg_date) < '2026-02-01' then 'bp_2026_01'
    when date(${TABLE}.rdg_date) >= '2026-02-02' and date(${TABLE}.rdg_date) < '2026-03-01' then 'bp_2026_02'
    when date(${TABLE}.rdg_date) >= '2026-03-02' and date(${TABLE}.rdg_date) < '2026-04-01' then 'bp_2026_03'
    when date(${TABLE}.rdg_date) >= '2026-04-02' and date(${TABLE}.rdg_date) < '2026-05-01' then 'bp_2026_04'
    when date(${TABLE}.rdg_date) >= '2026-05-02' and date(${TABLE}.rdg_date) < '2026-06-01' then 'bp_2026_05'
    when date(${TABLE}.rdg_date) >= '2026-06-02' and date(${TABLE}.rdg_date) < '2026-07-01' then 'bp_2026_06'
    when date(${TABLE}.rdg_date) >= '2026-07-02' and date(${TABLE}.rdg_date) < '2026-08-01' then 'bp_2026_07'
    when date(${TABLE}.rdg_date) >= '2026-08-02' and date(${TABLE}.rdg_date) < '2026-09-01' then 'bp_2026_08'
    when date(${TABLE}.rdg_date) >= '2026-09-02' and date(${TABLE}.rdg_date) < '2026-10-01' then 'bp_2026_09'
    when date(${TABLE}.rdg_date) >= '2026-10-02' and date(${TABLE}.rdg_date) < '2026-11-01' then 'bp_2026_10'
    when date(${TABLE}.rdg_date) >= '2026-11-02' and date(${TABLE}.rdg_date) < '2026-12-01' then 'bp_2026_11'
    when date(${TABLE}.rdg_date) >= '2026-12-02' and date(${TABLE}.rdg_date) < '2027-01-01' then 'bp_2026_12'
    when date(${TABLE}.rdg_date) >= '2027-01-02' and date(${TABLE}.rdg_date) < '2027-02-01' then 'bp_2027_01'
    when date(${TABLE}.rdg_date) >= '2027-02-02' and date(${TABLE}.rdg_date) < '2027-03-01' then 'bp_2027_02'
    when date(${TABLE}.rdg_date) >= '2027-03-02' and date(${TABLE}.rdg_date) < '2027-04-01' then 'bp_2027_03'
    when date(${TABLE}.rdg_date) >= '2027-04-02' and date(${TABLE}.rdg_date) < '2027-05-01' then 'bp_2027_04'
    when date(${TABLE}.rdg_date) >= '2027-05-02' and date(${TABLE}.rdg_date) < '2027-06-01' then 'bp_2027_05'
    when date(${TABLE}.rdg_date) >= '2027-06-02' and date(${TABLE}.rdg_date) < '2027-07-01' then 'bp_2027_06'
    when date(${TABLE}.rdg_date) >= '2027-07-02' and date(${TABLE}.rdg_date) < '2027-08-01' then 'bp_2027_07'
    when date(${TABLE}.rdg_date) >= '2027-08-02' and date(${TABLE}.rdg_date) < '2027-09-01' then 'bp_2027_08'
    when date(${TABLE}.rdg_date) >= '2027-09-02' and date(${TABLE}.rdg_date) < '2027-10-01' then 'bp_2027_09'
    when date(${TABLE}.rdg_date) >= '2027-10-02' and date(${TABLE}.rdg_date) < '2027-11-01' then 'bp_2027_10'
    when date(${TABLE}.rdg_date) >= '2027-11-02' and date(${TABLE}.rdg_date) < '2027-12-01' then 'bp_2027_11'
    when date(${TABLE}.rdg_date) >= '2027-12-02' and date(${TABLE}.rdg_date) < '2028-01-01' then 'bp_2027_12'
    when date(${TABLE}.rdg_date) >= '2028-01-02' and date(${TABLE}.rdg_date) < '2028-02-01' then 'bp_2028_01'
    when date(${TABLE}.rdg_date) >= '2028-02-02' and date(${TABLE}.rdg_date) < '2028-03-01' then 'bp_2028_02'
    when date(${TABLE}.rdg_date) >= '2028-03-02' and date(${TABLE}.rdg_date) < '2028-04-01' then 'bp_2028_03'
    when date(${TABLE}.rdg_date) >= '2028-04-02' and date(${TABLE}.rdg_date) < '2028-05-01' then 'bp_2028_04'
    when date(${TABLE}.rdg_date) >= '2028-05-02' and date(${TABLE}.rdg_date) < '2028-06-01' then 'bp_2028_05'
    when date(${TABLE}.rdg_date) >= '2028-06-02' and date(${TABLE}.rdg_date) < '2028-07-01' then 'bp_2028_06'
    when date(${TABLE}.rdg_date) >= '2028-07-02' and date(${TABLE}.rdg_date) < '2028-08-01' then 'bp_2028_07'
    when date(${TABLE}.rdg_date) >= '2028-08-02' and date(${TABLE}.rdg_date) < '2028-09-01' then 'bp_2028_08'
    when date(${TABLE}.rdg_date) >= '2028-09-02' and date(${TABLE}.rdg_date) < '2028-10-01' then 'bp_2028_09'
    when date(${TABLE}.rdg_date) >= '2028-10-02' and date(${TABLE}.rdg_date) < '2028-11-01' then 'bp_2028_10'
    when date(${TABLE}.rdg_date) >= '2028-11-02' and date(${TABLE}.rdg_date) < '2028-12-01' then 'bp_2028_11'
    when date(${TABLE}.rdg_date) >= '2028-12-02' and date(${TABLE}.rdg_date) < '2029-01-01' then 'bp_2028_12'
    when date(${TABLE}.rdg_date) >= '2029-01-02' and date(${TABLE}.rdg_date) < '2029-02-01' then 'bp_2029_01'
    when date(${TABLE}.rdg_date) >= '2029-02-02' and date(${TABLE}.rdg_date) < '2029-03-01' then 'bp_2029_02'
    when date(${TABLE}.rdg_date) >= '2029-03-02' and date(${TABLE}.rdg_date) < '2029-04-01' then 'bp_2029_03'
    when date(${TABLE}.rdg_date) >= '2029-04-02' and date(${TABLE}.rdg_date) < '2029-05-01' then 'bp_2029_04'
    when date(${TABLE}.rdg_date) >= '2029-05-02' and date(${TABLE}.rdg_date) < '2029-06-01' then 'bp_2029_05'
    when date(${TABLE}.rdg_date) >= '2029-06-02' and date(${TABLE}.rdg_date) < '2029-07-01' then 'bp_2029_06'
    when date(${TABLE}.rdg_date) >= '2029-07-02' and date(${TABLE}.rdg_date) < '2029-08-01' then 'bp_2029_07'
    when date(${TABLE}.rdg_date) >= '2029-08-02' and date(${TABLE}.rdg_date) < '2029-09-01' then 'bp_2029_08'
    when date(${TABLE}.rdg_date) >= '2029-09-02' and date(${TABLE}.rdg_date) < '2029-10-01' then 'bp_2029_09'
    when date(${TABLE}.rdg_date) >= '2029-10-02' and date(${TABLE}.rdg_date) < '2029-11-01' then 'bp_2029_10'
    when date(${TABLE}.rdg_date) >= '2029-11-02' and date(${TABLE}.rdg_date) < '2029-12-01' then 'bp_2029_11'
    when date(${TABLE}.rdg_date) >= '2029-12-02' and date(${TABLE}.rdg_date) < '2030-01-01' then 'bp_2029_12'

  else 'Unmapped'
  end
  "
}


###################################################################
# Singular Full Name Ad Mapping
# Built here
# https://docs.google.com/spreadsheets/d/1E7LtLtz_SzYiBrCzsT-lNvjPMI9RC_r5FybUTVk2GVo/edit?usp=sharing
# Ask Tal Kreuch for access
###################################################################

constant: singular_full_ad_name {
  value: "
  case

    when
      full_ad_name is not null
      and full_ad_name <> ''
      then full_ad_name

       when singular_creative_id = '6301194227322' then 'AppStoreTrailer_EN.mp4'
       when singular_creative_id = '6350278560322' then 'Tilting Table 001 (ES)'
       when singular_creative_id = '6353426254522' then 'Spin Girl 001'
       when singular_creative_id = '6289278657922' then 'ASOTrailer_30s_9x19-5_EN.mp4'
       when singular_creative_id = '6442181207722' then 'TiltingTableDangerous'
       when singular_creative_id = '6294267214122' then 'ASOTrailer_30s_9x19-5_EN.mp4'
       when singular_creative_id = '6460902469922' then 'SpinWithSloth'
       when singular_creative_id = '6444529394922' then 'TiltingTable'
       when singular_creative_id = '6442222790122' then 'HandsomeMan 002'
       when singular_creative_id = '6334482486722' then 'Testimonial 001'
       when singular_creative_id = '6442174775522' then 'Testimonial 001 (ES)'
       when singular_creative_id = '6350253635722' then 'Simple Blast 001 (ES)'
       when singular_creative_id = '6442177688922' then 'ManWithHorse'
       when singular_creative_id = '6366321673122' then 'Spin Girl 001'
       when singular_creative_id = '6460902468722' then 'HandsomeMan 002'
       when singular_creative_id = '6302530847122' then 'AppStoreTrailer_EN.mp4'
       when singular_creative_id = '6460902470922' then 'HandsomeMan 001'
       when singular_creative_id = '6350258071722' then 'App Store Trailer 001 (ES)'
       when singular_creative_id = '6451988225122' then 'Handsome Man w/Horse 001'
       when singular_creative_id = '6460902468522' then 'TiltingTableDangerous'
       when singular_creative_id = '6460902469722' then 'ManWithHorse'
       when singular_creative_id = '6353426253122' then 'Punk Grandma 002'
       when singular_creative_id = '6302530845722' then 'Testimonial_EN'
       when singular_creative_id = '6353426254722' then 'Handsome Man w/Horse 001'
       when singular_creative_id = '6448215766322' then 'Yoga Girl 001'
       when singular_creative_id = '6448215766122' then 'Yoga Girl 002'
       when singular_creative_id = '6366321674322' then 'Handsome Man w/Horse 001'
       when singular_creative_id = '6334481546522' then 'Handsome Man 002'
       when singular_creative_id = '6366321674122' then 'Handsome Man 002'
       when singular_creative_id = '6350216316922' then 'Testimonial 001 (ES)'
       when singular_creative_id = '6442181207522' then 'Zen'
       when singular_creative_id = '6366321673522' then 'Punk Grandma 002'
       when singular_creative_id = '6448215768922' then 'Handsome Man 002'
       when singular_creative_id = '6366321673922' then 'Yoga Girl 002'
       when singular_creative_id = '6334481915922' then 'Handsome Man w/Horse 001'
       when singular_creative_id = '6451988227722' then 'Lady Boss 001'
       when singular_creative_id = '6451988226522' then 'Handsome Man 002'
       when singular_creative_id = '6448215768722' then 'Punk Grandma 002'
       when singular_creative_id = '6334482296722' then 'Spin Girl 001'
       when singular_creative_id = '6301194230722' then 'PlayableLeadInVideo_EN'
       when singular_creative_id = '6353426253522' then 'Lady Boss 002'
       when singular_creative_id = '6442177688522' then 'SpinWithSloth'
       when singular_creative_id = '6353426255722' then 'Handsome Man 002'
       when singular_creative_id = '6448215766522' then 'Handsome Man 001'
       when singular_creative_id = '6460902469122' then 'Zen'
       when singular_creative_id = '6289278673122' then 'EB_221104_PlayableLead-InVideo_5s_AL_1080x1350.mp4'
       when singular_creative_id = '6442177688722' then 'YogaWithSloth'
       when singular_creative_id = '6460902470722' then 'SpinWithKoala'
       when singular_creative_id = '6334481714722' then 'Lady Boss 003'
       when singular_creative_id = '6451988226922' then 'Yoga Girl 002'
       when singular_creative_id = '6460902470122' then 'LadyBossWithCats'
       when singular_creative_id = '6301581265322' then 'Testimonial_EN'
       when singular_creative_id = '6448215768522' then 'Spin Girl 001'
       when singular_creative_id = '6460902469322' then 'LadyBossWithDogs'
       when singular_creative_id = '6334482125722' then 'Punk Grandma 002'
       when singular_creative_id = '6350246649322' then 'Tilting Table - Dangerous 001 (ES)'
       when singular_creative_id = '6451988224722' then 'Punk Grandma 002'
       when singular_creative_id = '6294267211322' then 'TiltingTable_25s_4x5_EN.mp4'
       when singular_creative_id = '6442177689122' then 'HandsomeMan 001'
       when singular_creative_id = '6301409044322' then 'ElevatorDangerous_EN'
       when singular_creative_id = '6444574033522' then 'TiltingTableDangerous'
       when singular_creative_id = '6334482342722' then 'Spin Girl 002'
       when singular_creative_id = '6451988224922' then 'Spin Girl 001'
       when singular_creative_id = '6294267212722' then 'EB_221104_PlayableLead-InVideo_5s_AL_1080x1350.mp4'
       when singular_creative_id = '6365784367122' then 'Spin Girl 001'
       when singular_creative_id = '6294267215722' then 'ASOTrailer_30s_3x4_EN.mp4'
       when singular_creative_id = '6451988228122' then 'Lady Boss 002'
       when singular_creative_id = '6460902469522' then 'ManOnHorse'
       when singular_creative_id = '6301194229922' then 'SimpleBlast_EN'
       when singular_creative_id = '6444529395722' then 'ManWithHorse'
       when singular_creative_id = '6444529395522' then 'LadyBossWithCats'
       when singular_creative_id = '6442180318122' then 'APVUpdate'
       when singular_creative_id = '6448215769322' then 'Handsome Man w/Horse 001'
       when singular_creative_id = '6301194231522' then 'Zen_EN'
       when singular_creative_id = '6353426255122' then 'Punk Grandma 001'
       when singular_creative_id = '6442177687722' then 'LadyBossWithCats'
       when singular_creative_id = '6334481675522' then 'Lady Boss 002'
       when singular_creative_id = '6350252548722' then 'Zen 001 (ES)'
       when singular_creative_id = '6444529396322' then 'LadyBossWithDogs'
       when singular_creative_id = '6460902470322' then 'YogaWithSloth'
       when singular_creative_id = '6302530847922' then 'PlayableLeadInVideo_EN'
       when singular_creative_id = '6442177688122' then 'LadyBossWithDogs'
       when singular_creative_id = '6302530847722' then 'Zen_EN'
       when singular_creative_id = '6460902471122' then 'Testimonial 001 (ES)'
       when singular_creative_id = '6448215766922' then 'Lady Boss 003'
       when singular_creative_id = '6288920745122' then 'ASOTrailer_30s_9x16_ptBR.mp4'
       when singular_creative_id = '6334482436322' then 'Yoga Girl 002'
       when singular_creative_id = '6451988227522' then 'Asian Baby 001'
       when singular_creative_id = '6294267210522' then 'Zen_1080_1350_EN.mp4'
       when singular_creative_id = '6289278662922' then 'Elevator_30s_4x5_EN.mp4'
       when singular_creative_id = '6301194231722' then 'TiltingTable_EN'
       when singular_creative_id = '6442177687922' then 'SpinWithKoala'
       when singular_creative_id = '6444529394522' then 'SpinWithKoala'
       when singular_creative_id = '6334477095122' then 'Asian Baby 001'
       when singular_creative_id = '6294267217522' then 'EB_Airtraffic_Chef_26s_16x9_EN.mp4'
       when singular_creative_id = '6334481838922' then 'Lady Boss 004'
       when singular_creative_id = '6442177688322' then 'ManOnHorse'
       when singular_creative_id = '6366321672922' then 'Lady Boss 003'
       when singular_creative_id = '6334482035922' then 'Punk Grandma 001'
       when singular_creative_id = '6448215767922' then 'Spin Girl 002'
       when singular_creative_id = '6444529394722' then 'HandsomeMan 002'
       when singular_creative_id = '6334482394722' then 'Yoga Girl 001'
       when singular_creative_id = '6289278675322' then 'Zen_1080_1920_EN.mp4'
       when singular_creative_id = '6444526679522' then 'APVUpdate'
       when singular_creative_id = '6444529395322' then 'HandsomeMan'
       when singular_creative_id = '6334481617522' then 'Lady Boss 001'
       when singular_creative_id = '6444529396122' then 'Zen'
       when singular_creative_id = '6365784366522' then 'Handsome Man w/Horse 001'
       when singular_creative_id = '6448215767522' then 'Lady Boss 001'
       when singular_creative_id = '6301194226922' then 'SimpleMatch_EN'
       when singular_creative_id = '6302530847522' then 'SimpleBlast_EN'
       when singular_creative_id = '6289278675722' then 'Zen_1080_1350_EN.mp4'
       when singular_creative_id = '6365784366922' then 'Handsome Man 002'
       when singular_creative_id = '6365784368122' then 'Lady Boss 003'
       when singular_creative_id = '6365784368322' then 'Punk Grandma 002'
       when singular_creative_id = '6289278666722' then 'EB_Airtraffic_SassyDog_30s_4x5_EN.mp4'
       when singular_creative_id = '6334481952522' then 'Handsome Man w/Horse 002'
       when singular_creative_id = '6353426253722' then 'Lady Boss 003'
       when singular_creative_id = '6302530846122' then 'ElevatorDangerous_EN'
       when singular_creative_id = '6334481405522' then 'Handsome Man 001'
       when singular_creative_id = '6444529394122' then 'SpinWithSloth'
       when singular_creative_id = '6460902470522' then 'APVUpdate'
       when singular_creative_id = '6289494924122' then 'EB_221107_PlayableLead-InVideo_5s_AL_1080x1350_ES.mp4'
       when singular_creative_id = '6365784368922' then 'Yoga Girl 001'
       when singular_creative_id = '6294267214522' then 'Match3_1080_1920_EN.mp4'
       when singular_creative_id = '6366321675122' then 'Punk Grandma 001'
       when singular_creative_id = '6448215765922' then 'Lady Boss 002'
       when singular_creative_id = '6444529394322' then 'YogaWithSloth'
       when singular_creative_id = '6366321672322' then 'Handsome Man 001'
       when singular_creative_id = '6366321674522' then 'Yoga Girl 001'
       when singular_creative_id = '6288922442922' then 'Zen_1080_1920_ES.mp4'
       when singular_creative_id = '6294267217322' then 'Elevator_30s_4x5_EN.mp4'
       when singular_creative_id = '6444529395122' then 'Testimonial 001'
       when singular_creative_id = '6366321673322' then 'Lady Boss 002'
       when singular_creative_id = '6451988225522' then 'Punk Grandma 001'
       when singular_creative_id = '6294267212322' then 'SimpleBlast_30s_9x16_EN.mp4'
       when singular_creative_id = '6353426254322' then 'Yoga Girl 001'
       when singular_creative_id = '6360326687122' then 'App Store Trailer 001'
       when singular_creative_id = '6294267213522' then 'SimpleBlast_30s_4x5_EN.mp4'
       when singular_creative_id = '6448215767122' then 'Asian Baby 001'
       when singular_creative_id = '6365784367522' then 'Lady Boss 002'
       when singular_creative_id = '6448215767722' then 'Punk Grandma 001'
       when singular_creative_id = '6360043117122' then 'Lady Boss 003'
       when singular_creative_id = '6365784368522' then 'Handsome Man 001'
       when singular_creative_id = '6451988226322' then 'Handsome Man 001'
       when singular_creative_id = '6353426252522' then 'Yoga Girl 002'
       when singular_creative_id = '6288920762122' then 'EB_221107_PlayableLead-InVideo_5s_AL_1080x1350_PT.mp4'
       when singular_creative_id = '6451988226122' then 'Lady Boss 003'
       when singular_creative_id = '6294267211122' then 'TiltingTable_25s_9x16_EN.mp4'
       when singular_creative_id = '6365784367322' then 'Asian Baby 001'
       when singular_creative_id = '6294267215922' then 'ASOTrailer_30s_9x16_EN.mp4'
       when singular_creative_id = '6301395801322' then 'TiltingTableDangerous_EN'
       when singular_creative_id = '6365784368722' then 'Yoga Girl 002'
       when singular_creative_id = '6289278658122' then 'ASOTrailer_30s_3x4_EN.mp4'
       when singular_creative_id = '6294267214722' then 'EB_Airtraffic_Chef_26s_9x16_EN.mp4'
       when singular_creative_id = '6301446608522' then 'WeirdTeddyBear_EN'
       when singular_creative_id = '6288922447722' then 'EB_221107_PlayableLead-InVideo_5s_AL_1080x1350_ES.mp4'
       when singular_creative_id = '6451988227922' then 'Yoga Girl 001'
       when singular_creative_id = '6302530848322' then 'Match3_EN'
       when singular_creative_id = '6289494919122' then 'ASOTrailer_30s_9x16_ES.mp4'
       when singular_creative_id = '6451988225322' then 'Lady Boss 004'
       when singular_creative_id = '6294267213322' then 'SimpleMatch_23s_4x5_EN.mp4'
       when singular_creative_id = '6444529395922' then 'ManOnHorse'
       when singular_creative_id = '6366321674722' then 'Lady Boss 001'
       when singular_creative_id = '6353426255522' then 'Handsome Man w/Horse 002'
       when singular_creative_id = '6289278668322' then 'SimpleBlast_30s_4x5_EN.mp4'
       when singular_creative_id = '6360043117522' then 'Punk Grandma 001'
       when singular_creative_id = '6288922443522' then 'EB_Airtraffic_SassyDog_30s_9x16_ES.mp4'
       when singular_creative_id = '6302530846922' then 'SimpleMatch_EN'
       when singular_creative_id = '6366321672722' then 'Asian Baby 001'
       when singular_creative_id = '6360043118522' then 'Handsome Man 001'
       when singular_creative_id = '6294267210922' then 'Zen_1080_1080_EN.mp4'
       when singular_creative_id = '6353426254122' then 'Asian Baby 001'
       when singular_creative_id = '6451988226722' then 'Handsome Man w/Horse 002'
       when singular_creative_id = '6360043119122' then 'Yoga Girl 002'
       when singular_creative_id = '6294267213922' then 'Match3_1080_1350_EN.mp4'
       when singular_creative_id = '6301194228322' then 'Elevator_EN.mp4'
       when singular_creative_id = '6302530848122' then 'TiltingTable_EN'
       when singular_creative_id = '6289278666922' then 'EB_Airtraffic_SassyDog_30s_1x1_EN.mp4'
       when singular_creative_id = '6288920747922' then 'Elevator_30s_9x16_ptBR.mp4'
       when singular_creative_id = '6342654069122' then 'Spin Girl 001'
       when singular_creative_id = '6294267211522' then 'SimpleMatch_23s_9x16_EN.mp4'
       when singular_creative_id = '6289278673722' then 'Zen_1080_1080_EN.mp4'
       when singular_creative_id = '6342654068522' then 'Punk Grandma 001'
       when singular_creative_id = '6365784367922' then 'Punk Grandma 001'
       when singular_creative_id = '6366321675522' then 'Lady Boss 004'
       when singular_creative_id = '6342654068922' then 'Handsome Man w/Horse 001'
       when singular_creative_id = '6294267210122' then 'Zen_1080_1920_EN.mp4'
       when singular_creative_id = '6301194230122' then 'Match3_EN'
       when singular_creative_id = '6294267216322' then 'Match3_1080_1080_EN.mp4'
       when singular_creative_id = '6294267215322' then 'Elevator_30s_1x1_EN.mp4'
       when singular_creative_id = '6289278668922' then 'SimpleBlast_30s_9x16_EN.mp4'
       when singular_creative_id = '6342654070322' then 'Lady Boss 002'
       when singular_creative_id = '6448215768322' then 'Lady Boss 004'
       when singular_creative_id = '6360043118122' then 'Punk Grandma 002'
       when singular_creative_id = '6451988227322' then 'Spin Girl 002'
       when singular_creative_id = '6342654068722' then 'Lady Boss 004'
       when singular_creative_id = '6289278666522' then 'Match3_1080_1350_EN.mp4'
       when singular_creative_id = '6289494917922' then 'SimpleBlast_30s_1x1_ES.mp4'
       when singular_creative_id = '6294267216122' then 'EB_Airtraffic_Chef_26s_4x5_EN.mp4'
       when singular_creative_id = '6289278662722' then 'Match3_1080_1080_EN.mp4'
       when singular_creative_id = '6289278673322' then 'TiltingTable_25s_4x5_EN.mp4'
       when singular_creative_id = '6294267210722' then 'Zen_1920_1080_EN.mp4'
       when singular_creative_id = '6289278659922' then 'EB_Airtraffic_Chef_26s_9x16_EN.mp4'
       when singular_creative_id = '6448215767322' then 'Handsome Man w/Horse 002'
       when singular_creative_id = '6366321674922' then 'Handsome Man w/Horse 002'
       when singular_creative_id = '6365784369322' then 'Spin Girl 002'
       when singular_creative_id = '6294267214922' then 'EB_Airtraffic_SassyDog_30s_16x9_EN.mp4'
       when singular_creative_id = '6366321675322' then 'Spin Girl 002'
       when singular_creative_id = '6342654068322' then 'Handsome Man w/Horse 002'
       when singular_creative_id = '6365784367722' then 'Lady Boss 001'
       when singular_creative_id = '6365784366322' then 'Lady Boss 004'
       when singular_creative_id = '6288922452922' then 'TiltingTable_25s_9x16_ES.mp4'
       when singular_creative_id = '6289494923722' then 'TiltingTable_25s_9x16_ES.mp4'
       when singular_creative_id = '6288920744922' then 'ASOTrailer_30s_9x19-5_ptBR.mp4'
       when singular_creative_id = '6342654069522' then 'Yoga Girl 001'
       when singular_creative_id = '6288920764122' then 'Zen_1080_1920_BR.mp4'
       when singular_creative_id = '6360043119322' then 'Spin Girl 001'
       when singular_creative_id = '6288920761922' then 'TiltingTable_25s_4x5_ptBR.mp4'
       when singular_creative_id = '6294267213722' then 'EB_Airtraffic_SassyDog_30s_4x5_EN.mp4'
       when singular_creative_id = '6288922440922' then 'EB_Airtraffic_Chef_26s_9x16_ES.mp4'
       when singular_creative_id = '6342654071122' then 'Yoga Girl 002'
       when singular_creative_id = '6342654070722' then 'Punk Grandma 002'
       when singular_creative_id = '6288920751922' then 'Match3_1920_1080_BR.mp4'
       when singular_creative_id = '6342654068122' then 'Handsome Man 002'
       when singular_creative_id = '6342654069722' then 'Asian Baby 001'
       when singular_creative_id = '6294267216722' then 'SimpleMatch_23s_1x1_EN.mp4'
       when singular_creative_id = '6342654070122' then 'Lady Boss 003'
       when singular_creative_id = '6342654067922' then 'Handsome Man 001'
       when singular_creative_id = '6289494922322' then 'EB_Airtraffic_Chef_26s_16x9_ES.mp4'
       when singular_creative_id = '6288920762522' then 'Zen_1080_1350_BR.mp4'
       when singular_creative_id = '6288920749722' then 'Match3_1080_1920_BR.mp4'
       when singular_creative_id = '6288922448122' then 'TiltingTable_25s_16x9_ES.mp4'
       when singular_creative_id = '6289494921722' then 'EB_Airtraffic_SassyDog_30s_9x16_ES.mp4'
       when singular_creative_id = '6288920747322' then 'EB_Airtraffic_Chef_26s_9x16_PTBR.mp4'
       when singular_creative_id = '6288922448322' then 'TiltingTable_25s_1x1_ES.mp4'
       when singular_creative_id = '6289278671522' then 'SimpleMatch_23s_9x16_EN.mp4'
       when singular_creative_id = '6289278657322' then 'ASOTrailer_30s_16x9_EN.mp4'
       when singular_creative_id = '6289278671322' then 'SimpleMatch_23s_4x5_EN.mp4'
       when singular_creative_id = '6289278657722' then 'ASOTrailer_30s_9x16_EN.mp4'
       when singular_creative_id = '6288920746522' then 'ASOTrailer_30s_3x4_ptBR.mp4'
       when singular_creative_id = '6289494920922' then 'Zen_1080_1080_ES.mp4'
       when singular_creative_id = '6288920758522' then 'SimpleBlast_30s_9x16_ptBR.mp4'
       when singular_creative_id = '6288922452322' then 'SimpleMatch_23s_1x1_ES.mp4'
       when singular_creative_id = '6294267215522' then 'Elevator_30s_9x16_EN.mp4'
       when singular_creative_id = '6288920749522' then 'Match3_1080_1350_BR.mp4'
       when singular_creative_id = '6289278663122' then 'Match3_1080_1920_EN.mp4'
       when singular_creative_id = '6288922446322' then 'Match3_1080_1080_ES.mp4'
       when singular_creative_id = '6288922458322' then 'SimpleBlast_30s_9x16_ES.mp4'
       when singular_creative_id = '6289278659522' then 'EB_Airtraffic_Chef_26s_4x5_EN.mp4'
       when singular_creative_id = '6288920762322' then 'TiltingTable_25s_16x9_ptBR.mp4'
       when singular_creative_id = '6302530845922' then 'TiltingTableDangerous_EN'
       when singular_creative_id = '6302530847322' then 'Elevator_EN.mp4'
       when singular_creative_id = '6289494921922' then 'Zen_1080_1350_ES.mp4'
       when singular_creative_id = '6288922455522' then 'ASOTrailer_30s_9x19-5_ES.mp4'
       when singular_creative_id = '6288920747722' then 'EB_Airtraffic_Chef_26s_16x9_PTBR.mp4'
       when singular_creative_id = '6288920759722' then 'SimpleMatch_23s_9x16_ptBR.mp4'
       when singular_creative_id = '6289278657522' then 'EB_Airtraffic_Chef_26s_16x9_EN.mp4'
       when singular_creative_id = '6289494924922' then 'Zen_1080_1920_ES.mp4'
       when singular_creative_id = '6353426254922' then 'Lady Boss 004'
       when singular_creative_id = '6288920749922' then 'Elevator_30s_1x1_ptBR.mp4'
       when singular_creative_id = '6289278666322' then 'EB_Airtraffic_SassyDog_30s_9x16_EN.mp4'
       when singular_creative_id = '6289494924322' then 'Match3_1080_1080_ES.mp4'
       when singular_creative_id = '6289494923522' then 'TiltingTable_25s_16x9_ES.mp4'
       when singular_creative_id = '6288922456922' then 'Elevator_30s_9x16_ES.mp4'
       when singular_creative_id = '6289494923122' then 'EB_Airtraffic_Chef_26s_9x16_ES.mp4'
       when singular_creative_id = '6288920759922' then 'SimpleMatch_23s_1x1_ptBR.mp4'
       when singular_creative_id = '6289278670922' then 'TiltingTable_25s_16x9_EN.mp4'
       when singular_creative_id = '6288920745322' then 'ASOTrailer_30s_16x9_ptBR.mp4'
       when singular_creative_id = '6288922446122' then 'Match3_1080_1350_ES.mp4'
       when singular_creative_id = '6288920745522' then 'EB_Airtraffic_Chef_26s_4x5_PTBR.mp4'
       when singular_creative_id = '6288922456322' then 'Elevator_30s_16x9_ES.mp4'
       when singular_creative_id = '6288920747522' then 'Elevator_30s_16x9_ptBR.mp4'
       when singular_creative_id = '6353426253322' then 'Spin Girl 002'
       when singular_creative_id = '6288922443122' then 'EB_Airtraffic_SassyDog_30s_1x1_ES.mp4'
       when singular_creative_id = '6288922445922' then 'Zen_1920_1080_ES.mp4'
       when singular_creative_id = '6289494918322' then 'Elevator_30s_9x16_ES.mp4'
       when singular_creative_id = '6289494917522' then 'SimpleBlast_30s_9x16_ES.mp4'
       when singular_creative_id = '6302530846722' then 'WeirdTeddyBear_EN'
       when singular_creative_id = '6289278662522' then 'Elevator_30s_16x9_EN.mp4'
       when singular_creative_id = '6288920749322' then 'Match3_1080_1080_BR.mp4'
       when singular_creative_id = '6288922443322' then 'Zen_1080_1350_ES.mp4'
       when singular_creative_id = '6288920762722' then 'Zen_1080_1080_BR.mp4'
       when singular_creative_id = '6289278659722' then 'Elevator_30s_1x1_EN.mp4'
       when singular_creative_id = '6288922447922' then 'TiltingTable_25s_4x5_ES.mp4'
       when singular_creative_id = '6289494923922' then 'TiltingTable_25s_4x5_ES.mp4'
       when singular_creative_id = '6288922454722' then 'ASOTrailer_30s_9x16_ES.mp4'
       when singular_creative_id = '6289494920522' then 'TiltingTable_25s_1x1_ES.mp4'
       when singular_creative_id = '6288922458722' then 'SimpleBlast_30s_1x1_ES.mp4'
       when singular_creative_id = '6288920747122' then 'EB_Airtraffic_Chef_26s_1x1_PTBR.mp4'
       when singular_creative_id = '6360043117322' then 'Lady Boss 002'
       when singular_creative_id = '6288920760322' then 'TiltingTable_25s_9x16_ptBR.mp4'
       when singular_creative_id = '6289494918722' then 'Elevator_30s_4x5_ES.mp4'
       when singular_creative_id = '6288922456522' then 'Elevator_30s_4x5_ES.mp4'
       when singular_creative_id = '6288920754922' then 'SimpleBlast_30s_1x1_ptBR.mp4'
       when singular_creative_id = '6288920752122' then 'EB_Airtraffic_SassyDog_30s_4x5_PTBR.mp4'
       when singular_creative_id = '6289494919522' then 'SimpleMatch_23s_9x16_ES.mp4'
       when singular_creative_id = '6288920751722' then 'EB_Airtraffic_SassyDog_30s_1x1_PTBR.mp4'
       when singular_creative_id = '6289278671122' then 'TiltingTable_25s_1x1_EN.mp4'
       when singular_creative_id = '6288922441122' then 'EB_Airtraffic_Chef_26s_4x5_ES.mp4'
       when singular_creative_id = '6289494923322' then 'Elevator_30s_1x1_ES.mp4'
       when singular_creative_id = '6289278659322' then 'EB_Airtraffic_Chef_26s_1x1_EN.mp4'
       when singular_creative_id = '6360043119722' then 'Testimonial 001'
       when singular_creative_id = '6288920760122' then 'TiltingTable_25s_1x1_ptBR.mp4'
       when singular_creative_id = '6289494921122' then 'Match3_1080_1350_ES.mp4'
       when singular_creative_id = '6289278666122' then 'EB_Airtraffic_SassyDog_30s_16x9_EN.mp4'
       when singular_creative_id = '6288920750122' then 'Elevator_30s_4x5_ptBR.mp4'
       when singular_creative_id = '6289494919922' then 'SimpleMatch_23s_4x5_ES.mp4'
       when singular_creative_id = '6342654070522' then 'Spin Girl 002'
       when singular_creative_id = '6288922448522' then 'Zen_1080_1080_ES.mp4'
       when singular_creative_id = '6288920754722' then 'SimpleBlast_30s_16x9_ptBR.mp4'
       when singular_creative_id = '6289494920722' then 'SimpleMatch_23s_1x1_ES.mp4'
       when singular_creative_id = '6289494919722' then 'ASOTrailer_30s_9x19-5_ES.mp4'
       when singular_creative_id = '6288920754522' then 'SimpleMatch_23s_4x5_ptBR.mp4'
       when singular_creative_id = '6288922447122' then 'Match3_1080_1920_ES.mp4'
       when singular_creative_id = '6288922455722' then 'ASOTrailer_30s_16x9_ES.mp4'
       when singular_creative_id = '6360043117922' then 'Handsome Man 002'
       when singular_creative_id = '6288922456722' then 'SimpleBlast_30s_4x5_ES.mp4'
       when singular_creative_id = '6289278672922' then 'TiltingTable_25s_9x16_EN.mp4'
       when singular_creative_id = '6289494921522' then 'EB_Airtraffic_SassyDog_30s_4x5_ES.mp4'
       when singular_creative_id = '6289494918522' then 'SimpleBlast_30s_4x5_ES.mp4'
       when singular_creative_id = '6288920753322' then 'EB_Airtraffic_SassyDog_30s_9x16_PTBR.mp4'
       when singular_creative_id = '6288922441722' then 'EB_Airtraffic_Chef_26s_16x9_ES.mp4'

       when singular_creative_id = '6500848734322' then 'CCB_TestimonialAI-YogaWithSloth-v01_25s_1x1_EN'
       when singular_creative_id = '6501692039722' then 'CCB_Zen_30s_EN'
       when singular_creative_id = '6501685619922' then 'CCB_MeetChumChumsPort_22s_EN'
       when singular_creative_id = '6500851107322' then 'CCB_APVUpdate_30s_9x16_EN'
       when singular_creative_id = '6500850962922' then 'CCB_TestimonialAI-ManWithHorse_25s_1x1_EN'
       when singular_creative_id = '6501746012122' then 'CCB_ChumChumsPainting_22s_EN'

       when singular_creative_id = '6527221708322' then 'SpinWithSloth'
       when singular_creative_id = '6527221707522' then 'TiltingTableDangerous'
       when singular_creative_id = '6527221709122' then 'LadyBossWithCats'
       when singular_creative_id = '6527221707922' then 'HandsomeMan 001'
       when singular_creative_id = '6527221708522' then 'YogaWithSloth'
       when singular_creative_id = '6528146732722' then 'CCB_Airtraffic_Testimonial_30s'
       when singular_creative_id = '6527221709522' then 'Testimonial 001 (ES)'
       when singular_creative_id = '6527221708922' then 'LadyBossWithDogs'
       when singular_creative_id = '6528145729922' then 'CCB_Zen_30s_EN'
       when singular_creative_id = '6528145729722' then 'CCB_MeetChumChumsPort_22s_EN'
       when singular_creative_id = '6527221709322' then 'ManOnHorse'
       when singular_creative_id = '6527221706722' then 'HandsomeMan 002'
       when singular_creative_id = '6527221708722' then 'SpinWithKoala'
       when singular_creative_id = '6527221708122' then 'ManWithHorse'
       when singular_creative_id = '6527221707122' then 'Zen'
       when singular_creative_id = '6528145730322' then 'CCB_APVUpdate_30s_9x16_EN'
       when singular_creative_id = '6527221707722' then 'APVUpdate'
       when singular_creative_id = '6528145730122' then 'CCB_TestimonialAI-ManWithHorse_25s_1x1_EN'
       when singular_creative_id = '6528145730522' then 'CCB_TestimonialAI-YogaWithSloth-v01_25s_1x1_EN'

    else 'Unmapped'

  end
  "
}

###################################################################
# Ad Name Simple
# Built here
# https://docs.google.com/spreadsheets/d/1E7LtLtz_SzYiBrCzsT-lNvjPMI9RC_r5FybUTVk2GVo/edit?usp=sharing
# Ask Tal Kreuch for access
###################################################################

constant: ad_name_simple {
  value: "
  case

    when ad_name_full like '%MinuteCombo%' then 'Minute Combo'
    when ad_name_full like '%Meet chum chums%' then 'Meet the Chum Chums'
    when ad_name_full like '%meet chum chums%' then 'Meet the Chum Chums'
    when ad_name_full like '%FillTheOrders%' then 'Fill The Orders'
    when ad_name_full like '%Multiboard%' then 'Multiboard'
    when ad_name_full like '%MultipleGameplayBright%' then 'Multiple Gameplay Bright'
    when ad_name_full like '%MultipleGameplay%' then 'Multiple Gameplay'
    when ad_name_full like '%LevelProgression%' then 'Level Progression'
    when ad_name_full like '%DesignYourLevel%' then 'Design Your Level'
    when ad_name_full like '%ImpressiveCascade%' then 'Impressive Cascade'
    when ad_name_full like '%PostWorkout%' then 'Post Workout'
    when ad_name_full like '%8BitFoodStart%' then '8Bit Food Start'
    when ad_name_full like '%MomtoMom%' then 'Mom to Mom'
    when ad_name_full like '%LongGameplay%' then 'Long Gameplay'
    when ad_name_full like '%8BitChum%' then '8Bit Chum'
    when ad_name_full like '%GiantTV%' then 'Giant TV'
    when ad_name_full like '%WomanToWoman%' then 'Woman To Woman'
    when ad_name_full like '%cuteness_overload%' then 'Cuteness Overload'
    when ad_name_full like '%TruthorDare%' then 'Truth or Dare'
    when ad_name_full like '%ExcuseMe%' then 'Excuse Me'


    when ad_name_full = 'Bear' then 'CCB Marketability Test - Bear'
    when ad_name_full = 'Bull' then 'CCB Marketability Test - Bull'
    when ad_name_full = 'Cat' then 'CCB Marketability Test - Cat'
    when ad_name_full = 'Chameleon' then 'CCB Marketability Test - Chameleon'
    when ad_name_full = 'Dog' then 'CCB Marketability Test - Dog'
    when ad_name_full = 'Fox' then 'CCB Marketability Test - Fox'
    when ad_name_full = 'Octopus' then 'CCB Marketability Test - Octopus'
    when ad_name_full = 'Squirrel' then 'CCB Marketability Test - Squirrel'
    when ad_name_full = 'MultiCharacter1' then 'CCB Marketability Test - MultiCharacter1'
    when ad_name_full = 'MultiCharacter2' then 'CCB Marketability Test - MultiCharacter2'
    when ad_name_full = 'MultiCharacter3' then 'CCB Marketability Test - MultiCharacter3'

    when ad_name_full like '%ApvUpdate%' then 'ApvUpdate'
    when ad_name_full like '%ChumChumPainting%' then 'ChumChumPainting'
    when ad_name_full like '%ComboVideo%' then 'ComboVideo'
    when ad_name_full like '%DropTheCharacters%' then 'DropTheCharacters'
    when ad_name_full like '%CutenessOverload%' then 'CutenessOverload'
    when ad_name_full like '%FullBoard%' then 'FullBoard'
    when ad_name_full like '%MeetNewChumChum%' then 'MeetNewChumChum'
    when ad_name_full like '%Multiboard%' then 'Multiboard'
    when ad_name_full like '%Mistplay%' then 'Mistplay'

    when ad_name_full like '%AppStoreTrailer%' then 'App Store Trailer'
 when ad_name_full like '%APVUpdate%' then 'App Store Trailer'
 when ad_name_full like '%Asian Baby%' then 'Asian Baby'
 when ad_name_full like '%ASOTrailer%' then 'App Store Trailer'
 when ad_name_full like '%Chef%' then 'Chef'
 when ad_name_full like '%Elevator%' then 'Elevator'
 when ad_name_full like '%HandsomeMan%' then 'Handsome Man'
 when ad_name_full like '%Handsome Man%' then 'Handsome Man'
 when ad_name_full like '%Lady Boss%' then 'Lady Boss'
 when ad_name_full like '%LadyBoss%' then 'Lady Boss'
 when ad_name_full like '%ManOnHorse%' then 'Man With Horse'
 when ad_name_full like '%ManWithHorse%' then 'Man With Horse'
 when ad_name_full like '%Match3%' then 'Match3'
 when ad_name_full like '%Playable%' then 'Playable'
 when ad_name_full like '%Punk Grandma%' then 'Punk Grandma'
 when ad_name_full like '%Simple Blast%' then 'Simple Blast'
 when ad_name_full like '%SimpleBlast%' then 'Simple Blast'
 when ad_name_full like '%Spin Girl%' then 'Spin Girl'
 when ad_name_full like '%SpinWithKoala%' then 'Spin With Koala'
 when ad_name_full like '%SpinWithSloth%' then 'Spin With Sloth'
 when ad_name_full like '%Tilting Table%' then 'Tilting Table'
 when ad_name_full like '%TiltingTable%' then 'Tilting Table'
 when ad_name_full like '%WeirdTeddyBear%' then 'WeirdTeddyBear'
 when ad_name_full like '%Yoga Girl%' then 'Yoga Girl'
 when ad_name_full like '%YogaWithSloth%' then 'YogaWithSloth'
 when ad_name_full like '%Zen%' then 'Zen'
 when ad_name_full like '%App Store Trailer%' then 'App Store Trailer'
 when ad_name_full like '%SimpleMatch%' then 'SimpleMatch'
 when ad_name_full like '%SassyDog%' then 'Sassy Dog'
 when ad_name_full like '%WeirdTreats%' then 'WeirdTreats'
 when ad_name_full like '%WeirdTeddy%' then 'WeirdTeddyBear'
 when ad_name_full like '%TTC%' then 'Tilting Table'
 when ad_name_full like '%GirlWithCats%' then 'Girl With Cats'
 when ad_name_full like '%AsianBaby%' then 'Asian Baby'
 when ad_name_full like '%PunkAsianGrandma%' then 'Punk Asian Grandma'
 when ad_name_full like '%LoungingWithCats%' then 'Lounging With Cats'
 when ad_name_full like '%LoungingWithSheep%' then 'Lounging With Sheep'
 when ad_name_full like '%MeetChum%' then 'Meet the Chum Chums'
 when ad_name_full like '%ChumsPainting%' then 'Chum Chums Painting'
 when ad_name_full like '%TestimonialAI%' then 'Testimonial (Unmapped AI)'
 when ad_name_full like '%Testimonial%' then 'Testimonial'

  else 'Unmapped'

  end
  "
}

###################################################################
# Ad Name Grouped
# Built here
# https://docs.google.com/spreadsheets/d/1E7LtLtz_SzYiBrCzsT-lNvjPMI9RC_r5FybUTVk2GVo/edit?usp=sharing
# Ask Tal Kreuch for access
###################################################################

constant: ad_name_grouped {
  value: "
  case

    when ad_name_full = 'Bear' then 'CCB Marketability Test'
    when ad_name_full = 'Bull' then 'CCB Marketability Test'
    when ad_name_full = 'Cat' then 'CCB Marketability Test'
    when ad_name_full = 'Chameleon' then 'CCB Marketability Test'
    when ad_name_full = 'Dog' then 'CCB Marketability Test'
    when ad_name_full = 'Fox' then 'CCB Marketability Test'
    when ad_name_full = 'Octopus' then 'CCB Marketability Test'
    when ad_name_full = 'Squirrel' then 'CCB Marketability Test'
    when ad_name_full = 'MultiCharacter1' then 'CCB Marketability Test'
    when ad_name_full = 'MultiCharacter2' then 'CCB Marketability Test'
    when ad_name_full = 'MultiCharacter3' then 'CCB Marketability Test'

    when ad_name_full like '%ApvUpdate%' then 'ApvUpdate'
    when ad_name_full like '%ChumChumPainting%' then 'ChumChumPainting'
    when ad_name_full like '%ComboVideo%' then 'ComboVideo'
    when ad_name_full like '%DropTheCharacters%' then 'DropTheCharacters'
    when ad_name_full like '%CutenessOverload%' then 'CutenessOverload'
    when ad_name_full like '%FullBoard%' then 'FullBoard'
    when ad_name_full like '%MeetNewChumChum%' then 'MeetNewChumChum'
    when ad_name_full like '%Multiboard%' then 'Multiboard'
    when ad_name_full like '%Mistplay%' then 'Mistplay'

      when ad_name_full like '%AppStoreTrailer%' then 'App Store Trailer'
     when ad_name_full like '%APVUpdate%' then 'App Store Trailer'
     when ad_name_full like '%Asian Baby%' then 'AI'
     when ad_name_full like '%ASOTrailer%' then 'App Store Trailer'
     when ad_name_full like '%Chef%' then 'AirTraffic'
     when ad_name_full like '%Elevator%' then 'AirTraffic'
     when ad_name_full like '%HandsomeMan%' then 'AI'
     when ad_name_full like '%Handsome Man%' then 'AI'
     when ad_name_full like '%Lady Boss%' then 'AI'
     when ad_name_full like '%LadyBoss%' then 'AI'
     when ad_name_full like '%ManOnHorse%' then 'AI'
     when ad_name_full like '%ManWithHorse%' then 'AI'
     when ad_name_full like '%Match3%' then 'Match3'
     when ad_name_full like '%Playable%' then 'Playable'
     when ad_name_full like '%Punk Grandma%' then 'AI'
     when ad_name_full like '%Simple Blast%' then 'Simple Blast'
     when ad_name_full like '%SimpleBlast%' then 'Simple Blast'
     when ad_name_full like '%Spin Girl%' then 'AI'
     when ad_name_full like '%SpinWithKoala%' then 'AI'
     when ad_name_full like '%SpinWithSloth%' then 'AI'
     when ad_name_full like '%Tilting Table%' then 'Tilting Table'
     when ad_name_full like '%TiltingTable%' then 'Tilting Table'
     when ad_name_full like '%WeirdTeddyBear%' then 'AI'
     when ad_name_full like '%Yoga Girl%' then 'AI'
     when ad_name_full like '%YogaWithSloth%' then 'AI'
     when ad_name_full like '%Zen%' then 'Zen'
     when ad_name_full like '%App Store Trailer%' then 'App Store Trailer'
     when ad_name_full like '%SimpleMatch%' then 'SimpleMatch'
     when ad_name_full like '%SassyDog%' then 'AirTraffic'
     when ad_name_full like '%WeirdTreats%' then 'AI'
     when ad_name_full like '%WeirdTeddy%' then 'AI'
     when ad_name_full like '%TTC%' then 'Tilting Table'
     when ad_name_full like '%GirlWithCats%' then 'AI'
     when ad_name_full like '%AsianBaby%' then 'AI'
     when ad_name_full like '%PunkAsianGrandma%' then 'AI'
     when ad_name_full like '%LoungingWithCats%' then 'AI'
     when ad_name_full like '%LoungingWithSheep%' then 'AI'
     when ad_name_full like '%MeetChum%' then 'Meet the Chum Chums'
     when ad_name_full like '%ChumsPainting%' then 'Chum Chums Painting'
     when ad_name_full like '%TestimonialAI%' then 'AI'
     when ad_name_full like '%Testimonial%' then 'Testimonial'

  else 'Unmapped'

  end
  "
}

constant: singular_simple_ad_name {
  value: "
  case

    when asset_name like '%MinuteCombo%' then 'Minute Combo'
    when asset_name like '%Meet chum chums%' then 'Meet the Chum Chums'
    when asset_name like '%meet chum chums%' then 'Meet the Chum Chums'
    when asset_name like '%FillTheOrders%' then 'Fill The Orders'
    when asset_name like '%Multiboard%' then 'Multiboard'
    when asset_name like '%MultipleGameplayBright%' then 'Multiple Gameplay Bright'
    when asset_name like '%MultipleGameplay%' then 'Multiple Gameplay'
    when asset_name like '%LevelProgression%' then 'Level Progression'
    when asset_name like '%DesignYourLevel%' then 'Design Your Level'
    when asset_name like '%ImpressiveCascade%' then 'Impressive Cascade'
    when asset_name like '%PostWorkout%' then 'Post Workout'
    when asset_name like '%8BitFoodStart%' then '8Bit Food Start'
    when asset_name like '%MomtoMom%' then 'Mom to Mom'
    when asset_name like '%LongGameplay%' then 'Long Gameplay'
    when asset_name like '%8BitChum%' then '8Bit Chum'
    when asset_name like '%GiantTV%' then 'Giant TV'
    when asset_name like '%WomanToWoman%' then 'Woman To Woman'
    when asset_name like '%cuteness_overload%' then 'Cuteness Overload'
    when asset_name like '%TruthorDare%' then 'Truth or Dare'
    when asset_name like '%ExcuseMe%' then 'Excuse Me'


    when asset_name = 'Bear' then 'CCB Marketability Test - Bear'
    when asset_name = 'Bull' then 'CCB Marketability Test - Bull'
    when asset_name = 'Cat' then 'CCB Marketability Test - Cat'
    when asset_name = 'Chameleon' then 'CCB Marketability Test - Chameleon'
    when asset_name = 'Dog' then 'CCB Marketability Test - Dog'
    when asset_name = 'Fox' then 'CCB Marketability Test - Fox'
    when asset_name = 'Octopus' then 'CCB Marketability Test - Octopus'
    when asset_name = 'Squirrel' then 'CCB Marketability Test - Squirrel'
    when asset_name = 'MultiCharacter1' then 'CCB Marketability Test - MultiCharacter1'
    when asset_name = 'MultiCharacter2' then 'CCB Marketability Test - MultiCharacter2'
    when asset_name = 'MultiCharacter3' then 'CCB Marketability Test - MultiCharacter3'

    when asset_name like '%ApvUpdate%' then 'ApvUpdate'
    when asset_name like '%ChumChumPainting%' then 'ChumChumPainting'
    when asset_name like '%ComboVideo%' then 'ComboVideo'
    when asset_name like '%DropTheCharacters%' then 'DropTheCharacters'
    when asset_name like '%CutenessOverload%' then 'CutenessOverload'
    when asset_name like '%FullBoard%' then 'FullBoard'
    when asset_name like '%MeetNewChumChum%' then 'MeetNewChumChum'
    when asset_name like '%Multiboard%' then 'Multiboard'
    when asset_name like '%Mistplay%' then 'Mistplay'

when asset_name like '%AppStoreTrailer%' then 'App Store Trailer'
      when asset_name like '%APVUpdate%' then 'App Store Trailer'
      when asset_name like '%Asian Baby%' then 'Asian Baby'
      when asset_name like '%ASOTrailer%' then 'App Store Trailer'
      when asset_name like '%Chef%' then 'Chef'
      when asset_name like '%Elevator%' then 'Elevator'
      when asset_name like '%HandsomeMan%' then 'Handsome Man'
      when asset_name like '%Handsome Man%' then 'Handsome Man'
      when asset_name like '%Lady Boss%' then 'Lady Boss'
      when asset_name like '%LadyBoss%' then 'Lady Boss'
      when asset_name like '%ManOnHorse%' then 'Man With Horse'
      when asset_name like '%ManWithHorse%' then 'Man With Horse'
      when asset_name like '%Match3%' then 'Match3'
      when asset_name like '%Playable%' then 'Playable'
      when asset_name like '%Punk Grandma%' then 'Punk Grandma'
      when asset_name like '%Simple Blast%' then 'Simple Blast'
      when asset_name like '%SimpleBlast%' then 'Simple Blast'
      when asset_name like '%Spin Girl%' then 'Spin Girl'
      when asset_name like '%SpinWithKoala%' then 'Spin With Koala'
      when asset_name like '%SpinWithSloth%' then 'Spin With Sloth'
      when asset_name like '%Tilting Table%' then 'Tilting Table'
      when asset_name like '%TiltingTable%' then 'Tilting Table'
      when asset_name like '%WeirdTeddyBear%' then 'WeirdTeddyBear'
      when asset_name like '%Yoga Girl%' then 'Yoga Girl'
      when asset_name like '%YogaWithSloth%' then 'YogaWithSloth'
      when asset_name like '%Zen%' then 'Zen'
      when asset_name like '%App Store Trailer%' then 'App Store Trailer'
      when asset_name like '%SimpleMatch%' then 'SimpleMatch'
      when asset_name like '%SassyDog%' then 'Sassy Dog'
      when asset_name like '%WeirdTreats%' then 'WeirdTreats'
      when asset_name like '%WeirdTeddy%' then 'WeirdTeddyBear'
      when asset_name like '%TTC%' then 'Tilting Table'
      when asset_name like '%GirlWithCats%' then 'Girl With Cats'
      when asset_name like '%AsianBaby%' then 'Asian Baby'
      when asset_name like '%PunkAsianGrandma%' then 'Punk Asian Grandma'
      when asset_name like '%LoungingWithCats%' then 'Lounging With Cats'
      when asset_name like '%LoungingWithSheep%' then 'Lounging With Sheep'
      when asset_name like '%MeetChum%' then 'Meet the Chum Chums'
      when asset_name like '%ChumsPainting%' then 'Chum Chums Painting'
      when asset_name like '%TestimonialAI%' then 'Testimonial (Unmapped AI)'
      when asset_name like '%Testimonial%' then 'Testimonial'

      when full_ad_name like '%AppStoreTrailer%' then 'App Store Trailer'
      when full_ad_name like '%APVUpdate%' then 'App Store Trailer'
      when full_ad_name like '%Asian Baby%' then 'Asian Baby'
      when full_ad_name like '%ASOTrailer%' then 'App Store Trailer'
      when full_ad_name like '%Chef%' then 'Chef'
      when full_ad_name like '%Elevator%' then 'Elevator'
      when full_ad_name like '%HandsomeMan%' then 'Handsome Man'
      when full_ad_name like '%Handsome Man%' then 'Handsome Man'
      when full_ad_name like '%Lady Boss%' then 'Lady Boss'
      when full_ad_name like '%LadyBoss%' then 'Lady Boss'
      when full_ad_name like '%ManOnHorse%' then 'Man With Horse'
      when full_ad_name like '%ManWithHorse%' then 'Man With Horse'
      when full_ad_name like '%Match3%' then 'Match3'
      when full_ad_name like '%Playable%' then 'Playable'
      when full_ad_name like '%Punk Grandma%' then 'Punk Grandma'
      when full_ad_name like '%Simple Blast%' then 'Simple Blast'
      when full_ad_name like '%SimpleBlast%' then 'Simple Blast'
      when full_ad_name like '%Spin Girl%' then 'Spin Girl'
      when full_ad_name like '%SpinWithKoala%' then 'Spin With Koala'
      when full_ad_name like '%SpinWithSloth%' then 'Spin With Sloth'
      when full_ad_name like '%Tilting Table%' then 'Tilting Table'
      when full_ad_name like '%TiltingTable%' then 'Tilting Table'
      when full_ad_name like '%WeirdTeddyBear%' then 'WeirdTeddyBear'
      when full_ad_name like '%Yoga Girl%' then 'Yoga Girl'
      when full_ad_name like '%YogaWithSloth%' then 'YogaWithSloth'
      when full_ad_name like '%Zen%' then 'Zen'
      when full_ad_name like '%App Store Trailer%' then 'App Store Trailer'
      when full_ad_name like '%SimpleMatch%' then 'SimpleMatch'
      when full_ad_name like '%SassyDog%' then 'Sassy Dog'
      when full_ad_name like '%WeirdTreats%' then 'WeirdTreats'
      when full_ad_name like '%WeirdTeddy%' then 'WeirdTeddyBear'
      when full_ad_name like '%TTC%' then 'Tilting Table'
      when full_ad_name like '%GirlWithCats%' then 'Girl With Cats'
      when full_ad_name like '%AsianBaby%' then 'Asian Baby'
      when full_ad_name like '%PunkAsianGrandma%' then 'Punk Asian Grandma'
      when full_ad_name like '%LoungingWithCats%' then 'Lounging With Cats'
      when full_ad_name like '%LoungingWithSheep%' then 'Lounging With Sheep'
      when full_ad_name like '%MeetChum%' then 'Meet the Chum Chums'
      when full_ad_name like '%ChumsPainting%' then 'Chum Chums Painting'
      when full_ad_name like '%TestimonialAI%' then 'Testimonial (Unmapped AI)'
      when full_ad_name like '%Testimonial%' then 'Testimonial'

      when singular_creative_id = '6301194227322' then 'App Store Trailer'
      when singular_creative_id = '6350278560322' then 'Tilting Table'
      when singular_creative_id = '6353426254522' then 'Spin Girl'
      when singular_creative_id = '6289278657922' then 'App Store Trailer'
      when singular_creative_id = '6442181207722' then 'Tilting Table'
      when singular_creative_id = '6294267214122' then 'App Store Trailer'
      when singular_creative_id = '6460902469922' then 'Spin With Sloth'
      when singular_creative_id = '6444529394922' then 'Tilting Table'
      when singular_creative_id = '6442222790122' then 'Handsome Man'
      when singular_creative_id = '6334482486722' then 'Testimonial'
      when singular_creative_id = '6442174775522' then 'Testimonial'
      when singular_creative_id = '6350253635722' then 'Simple Blast'
      when singular_creative_id = '6442177688922' then 'Man With Horse'
      when singular_creative_id = '6366321673122' then 'Spin Girl'
      when singular_creative_id = '6460902468722' then 'Handsome Man'
      when singular_creative_id = '6302530847122' then 'App Store Trailer'
      when singular_creative_id = '6460902470922' then 'Handsome Man'
      when singular_creative_id = '6350258071722' then 'App Store Trailer'
      when singular_creative_id = '6451988225122' then 'Handsome Man'
      when singular_creative_id = '6460902468522' then 'Tilting Table'
      when singular_creative_id = '6460902469722' then 'Man With Horse'
      when singular_creative_id = '6353426253122' then 'Punk Grandma'
      when singular_creative_id = '6302530845722' then 'Testimonial'
      when singular_creative_id = '6353426254722' then 'Handsome Man'
      when singular_creative_id = '6448215766322' then 'Yoga Girl'
      when singular_creative_id = '6448215766122' then 'Yoga Girl'
      when singular_creative_id = '6366321674322' then 'Handsome Man'
      when singular_creative_id = '6334481546522' then 'Handsome Man'
      when singular_creative_id = '6366321674122' then 'Handsome Man'
      when singular_creative_id = '6350216316922' then 'Testimonial'
      when singular_creative_id = '6442181207522' then 'Zen'
      when singular_creative_id = '6366321673522' then 'Punk Grandma'
      when singular_creative_id = '6448215768922' then 'Handsome Man'
      when singular_creative_id = '6366321673922' then 'Yoga Girl'
      when singular_creative_id = '6334481915922' then 'Handsome Man'
      when singular_creative_id = '6451988227722' then 'Lady Boss'
      when singular_creative_id = '6451988226522' then 'Handsome Man'
      when singular_creative_id = '6448215768722' then 'Punk Grandma'
      when singular_creative_id = '6334482296722' then 'Spin Girl'
      when singular_creative_id = '6301194230722' then 'Playable'
      when singular_creative_id = '6353426253522' then 'Lady Boss'
      when singular_creative_id = '6442177688522' then 'Spin With Sloth'
      when singular_creative_id = '6353426255722' then 'Handsome Man'
      when singular_creative_id = '6448215766522' then 'Handsome Man'
      when singular_creative_id = '6460902469122' then 'Zen'
      when singular_creative_id = '6289278673122' then 'Playable'
      when singular_creative_id = '6442177688722' then 'YogaWithSloth'
      when singular_creative_id = '6460902470722' then 'Spin With Koala'
      when singular_creative_id = '6334481714722' then 'Lady Boss'
      when singular_creative_id = '6451988226922' then 'Yoga Girl'
      when singular_creative_id = '6460902470122' then 'Lady Boss'
      when singular_creative_id = '6301581265322' then 'Testimonial'
      when singular_creative_id = '6448215768522' then 'Spin Girl'
      when singular_creative_id = '6460902469322' then 'Lady Boss'
      when singular_creative_id = '6334482125722' then 'Punk Grandma'
      when singular_creative_id = '6350246649322' then 'Tilting Table'
      when singular_creative_id = '6451988224722' then 'Punk Grandma'
      when singular_creative_id = '6294267211322' then 'Tilting Table'
      when singular_creative_id = '6442177689122' then 'Handsome Man'
      when singular_creative_id = '6301409044322' then 'Elevator'
      when singular_creative_id = '6444574033522' then 'Tilting Table'
      when singular_creative_id = '6334482342722' then 'Spin Girl'
      when singular_creative_id = '6451988224922' then 'Spin Girl'
      when singular_creative_id = '6294267212722' then 'Playable'
      when singular_creative_id = '6365784367122' then 'Spin Girl'
      when singular_creative_id = '6294267215722' then 'App Store Trailer'
      when singular_creative_id = '6451988228122' then 'Lady Boss'
      when singular_creative_id = '6460902469522' then 'Man With Horse'
      when singular_creative_id = '6301194229922' then 'Simple Blast'
      when singular_creative_id = '6444529395722' then 'Man With Horse'
      when singular_creative_id = '6444529395522' then 'Lady Boss'
      when singular_creative_id = '6442180318122' then 'App Store Trailer'
      when singular_creative_id = '6448215769322' then 'Handsome Man'
      when singular_creative_id = '6301194231522' then 'Zen'
      when singular_creative_id = '6353426255122' then 'Punk Grandma'
      when singular_creative_id = '6442177687722' then 'Lady Boss'
      when singular_creative_id = '6334481675522' then 'Lady Boss'
      when singular_creative_id = '6350252548722' then 'Zen'
      when singular_creative_id = '6444529396322' then 'Lady Boss'
      when singular_creative_id = '6460902470322' then 'YogaWithSloth'
      when singular_creative_id = '6302530847922' then 'Playable'
      when singular_creative_id = '6442177688122' then 'Lady Boss'
      when singular_creative_id = '6302530847722' then 'Zen'
      when singular_creative_id = '6460902471122' then 'Testimonial'
      when singular_creative_id = '6448215766922' then 'Lady Boss'
      when singular_creative_id = '6288920745122' then 'App Store Trailer'
      when singular_creative_id = '6334482436322' then 'Yoga Girl'
      when singular_creative_id = '6451988227522' then 'Asian Baby'
      when singular_creative_id = '6294267210522' then 'Zen'
      when singular_creative_id = '6289278662922' then 'Elevator'
      when singular_creative_id = '6301194231722' then 'Tilting Table'
      when singular_creative_id = '6442177687922' then 'Spin With Koala'
      when singular_creative_id = '6444529394522' then 'Spin With Koala'
      when singular_creative_id = '6334477095122' then 'Asian Baby'
      when singular_creative_id = '6294267217522' then 'Chef'
      when singular_creative_id = '6334481838922' then 'Lady Boss'
      when singular_creative_id = '6442177688322' then 'Man With Horse'
      when singular_creative_id = '6366321672922' then 'Lady Boss'
      when singular_creative_id = '6334482035922' then 'Punk Grandma'
      when singular_creative_id = '6448215767922' then 'Spin Girl'
      when singular_creative_id = '6444529394722' then 'Handsome Man'
      when singular_creative_id = '6334482394722' then 'Yoga Girl'
      when singular_creative_id = '6289278675322' then 'Zen'
      when singular_creative_id = '6444526679522' then 'App Store Trailer'
      when singular_creative_id = '6444529395322' then 'Handsome Man'
      when singular_creative_id = '6334481617522' then 'Lady Boss'
      when singular_creative_id = '6444529396122' then 'Zen'
      when singular_creative_id = '6365784366522' then 'Handsome Man'
      when singular_creative_id = '6448215767522' then 'Lady Boss'
      when singular_creative_id = '6301194226922' then 'SimpleMatch'
      when singular_creative_id = '6302530847522' then 'Simple Blast'
      when singular_creative_id = '6289278675722' then 'Zen'
      when singular_creative_id = '6365784366922' then 'Handsome Man'
      when singular_creative_id = '6365784368122' then 'Lady Boss'
      when singular_creative_id = '6365784368322' then 'Punk Grandma'
      when singular_creative_id = '6289278666722' then 'Sassy Dog'
      when singular_creative_id = '6334481952522' then 'Handsome Man'
      when singular_creative_id = '6353426253722' then 'Lady Boss'
      when singular_creative_id = '6302530846122' then 'Elevator'
      when singular_creative_id = '6334481405522' then 'Handsome Man'
      when singular_creative_id = '6444529394122' then 'Spin With Sloth'
      when singular_creative_id = '6460902470522' then 'App Store Trailer'
      when singular_creative_id = '6289494924122' then 'Playable'
      when singular_creative_id = '6365784368922' then 'Yoga Girl'
      when singular_creative_id = '6294267214522' then 'Match3'
      when singular_creative_id = '6366321675122' then 'Punk Grandma'
      when singular_creative_id = '6448215765922' then 'Lady Boss'
      when singular_creative_id = '6444529394322' then 'YogaWithSloth'
      when singular_creative_id = '6366321672322' then 'Handsome Man'
      when singular_creative_id = '6366321674522' then 'Yoga Girl'
      when singular_creative_id = '6288922442922' then 'Zen'
      when singular_creative_id = '6294267217322' then 'Elevator'
      when singular_creative_id = '6444529395122' then 'Testimonial'
      when singular_creative_id = '6366321673322' then 'Lady Boss'
      when singular_creative_id = '6451988225522' then 'Punk Grandma'
      when singular_creative_id = '6294267212322' then 'Simple Blast'
      when singular_creative_id = '6353426254322' then 'Yoga Girl'
      when singular_creative_id = '6360326687122' then 'App Store Trailer'
      when singular_creative_id = '6294267213522' then 'Simple Blast'
      when singular_creative_id = '6448215767122' then 'Asian Baby'
      when singular_creative_id = '6365784367522' then 'Lady Boss'
      when singular_creative_id = '6448215767722' then 'Punk Grandma'
      when singular_creative_id = '6360043117122' then 'Lady Boss'
      when singular_creative_id = '6365784368522' then 'Handsome Man'
      when singular_creative_id = '6451988226322' then 'Handsome Man'
      when singular_creative_id = '6353426252522' then 'Yoga Girl'
      when singular_creative_id = '6288920762122' then 'Playable'
      when singular_creative_id = '6451988226122' then 'Lady Boss'
      when singular_creative_id = '6294267211122' then 'Tilting Table'
      when singular_creative_id = '6365784367322' then 'Asian Baby'
      when singular_creative_id = '6294267215922' then 'App Store Trailer'
      when singular_creative_id = '6301395801322' then 'Tilting Table'
      when singular_creative_id = '6365784368722' then 'Yoga Girl'
      when singular_creative_id = '6289278658122' then 'App Store Trailer'
      when singular_creative_id = '6294267214722' then 'Chef'
      when singular_creative_id = '6301446608522' then 'WeirdTeddyBear'
      when singular_creative_id = '6288922447722' then 'Playable'
      when singular_creative_id = '6451988227922' then 'Yoga Girl'
      when singular_creative_id = '6302530848322' then 'Match3'
      when singular_creative_id = '6289494919122' then 'App Store Trailer'
      when singular_creative_id = '6451988225322' then 'Lady Boss'
      when singular_creative_id = '6294267213322' then 'SimpleMatch'
      when singular_creative_id = '6444529395922' then 'Man With Horse'
      when singular_creative_id = '6366321674722' then 'Lady Boss'
      when singular_creative_id = '6353426255522' then 'Handsome Man'
      when singular_creative_id = '6289278668322' then 'Simple Blast'
      when singular_creative_id = '6360043117522' then 'Punk Grandma'
      when singular_creative_id = '6288922443522' then 'Sassy Dog'
      when singular_creative_id = '6302530846922' then 'SimpleMatch'
      when singular_creative_id = '6366321672722' then 'Asian Baby'
      when singular_creative_id = '6360043118522' then 'Handsome Man'
      when singular_creative_id = '6294267210922' then 'Zen'
      when singular_creative_id = '6353426254122' then 'Asian Baby'
      when singular_creative_id = '6451988226722' then 'Handsome Man'
      when singular_creative_id = '6360043119122' then 'Yoga Girl'
      when singular_creative_id = '6294267213922' then 'Match3'
      when singular_creative_id = '6301194228322' then 'Elevator'
      when singular_creative_id = '6302530848122' then 'Tilting Table'
      when singular_creative_id = '6289278666922' then 'Sassy Dog'
      when singular_creative_id = '6288920747922' then 'Elevator'
      when singular_creative_id = '6342654069122' then 'Spin Girl'
      when singular_creative_id = '6294267211522' then 'SimpleMatch'
      when singular_creative_id = '6289278673722' then 'Zen'
      when singular_creative_id = '6342654068522' then 'Punk Grandma'
      when singular_creative_id = '6365784367922' then 'Punk Grandma'
      when singular_creative_id = '6366321675522' then 'Lady Boss'
      when singular_creative_id = '6342654068922' then 'Handsome Man'
      when singular_creative_id = '6294267210122' then 'Zen'
      when singular_creative_id = '6301194230122' then 'Match3'
      when singular_creative_id = '6294267216322' then 'Match3'
      when singular_creative_id = '6294267215322' then 'Elevator'
      when singular_creative_id = '6289278668922' then 'Simple Blast'
      when singular_creative_id = '6342654070322' then 'Lady Boss'
      when singular_creative_id = '6448215768322' then 'Lady Boss'
      when singular_creative_id = '6360043118122' then 'Punk Grandma'
      when singular_creative_id = '6451988227322' then 'Spin Girl'
      when singular_creative_id = '6342654068722' then 'Lady Boss'
      when singular_creative_id = '6289278666522' then 'Match3'
      when singular_creative_id = '6289494917922' then 'Simple Blast'
      when singular_creative_id = '6294267216122' then 'Chef'
      when singular_creative_id = '6289278662722' then 'Match3'
      when singular_creative_id = '6289278673322' then 'Tilting Table'
      when singular_creative_id = '6294267210722' then 'Zen'
      when singular_creative_id = '6289278659922' then 'Chef'
      when singular_creative_id = '6448215767322' then 'Handsome Man'
      when singular_creative_id = '6366321674922' then 'Handsome Man'
      when singular_creative_id = '6365784369322' then 'Spin Girl'
      when singular_creative_id = '6294267214922' then 'Sassy Dog'
      when singular_creative_id = '6366321675322' then 'Spin Girl'
      when singular_creative_id = '6342654068322' then 'Handsome Man'
      when singular_creative_id = '6365784367722' then 'Lady Boss'
      when singular_creative_id = '6365784366322' then 'Lady Boss'
      when singular_creative_id = '6288922452922' then 'Tilting Table'
      when singular_creative_id = '6289494923722' then 'Tilting Table'
      when singular_creative_id = '6288920744922' then 'App Store Trailer'
      when singular_creative_id = '6342654069522' then 'Yoga Girl'
      when singular_creative_id = '6288920764122' then 'Zen'
      when singular_creative_id = '6360043119322' then 'Spin Girl'
      when singular_creative_id = '6288920761922' then 'Tilting Table'
      when singular_creative_id = '6294267213722' then 'Sassy Dog'
      when singular_creative_id = '6288922440922' then 'Chef'
      when singular_creative_id = '6342654071122' then 'Yoga Girl'
      when singular_creative_id = '6342654070722' then 'Punk Grandma'
      when singular_creative_id = '6288920751922' then 'Match3'
      when singular_creative_id = '6342654068122' then 'Handsome Man'
      when singular_creative_id = '6342654069722' then 'Asian Baby'
      when singular_creative_id = '6294267216722' then 'SimpleMatch'
      when singular_creative_id = '6342654070122' then 'Lady Boss'
      when singular_creative_id = '6342654067922' then 'Handsome Man'
      when singular_creative_id = '6289494922322' then 'Chef'
      when singular_creative_id = '6288920762522' then 'Zen'
      when singular_creative_id = '6288920749722' then 'Match3'
      when singular_creative_id = '6288922448122' then 'Tilting Table'
      when singular_creative_id = '6289494921722' then 'Sassy Dog'
      when singular_creative_id = '6288920747322' then 'Chef'
      when singular_creative_id = '6288922448322' then 'Tilting Table'
      when singular_creative_id = '6289278671522' then 'SimpleMatch'
      when singular_creative_id = '6289278657322' then 'App Store Trailer'
      when singular_creative_id = '6289278671322' then 'SimpleMatch'
      when singular_creative_id = '6289278657722' then 'App Store Trailer'
      when singular_creative_id = '6288920746522' then 'App Store Trailer'
      when singular_creative_id = '6289494920922' then 'Zen'
      when singular_creative_id = '6288920758522' then 'Simple Blast'
      when singular_creative_id = '6288922452322' then 'SimpleMatch'
      when singular_creative_id = '6294267215522' then 'Elevator'
      when singular_creative_id = '6288920749522' then 'Match3'
      when singular_creative_id = '6289278663122' then 'Match3'
      when singular_creative_id = '6288922446322' then 'Match3'
      when singular_creative_id = '6288922458322' then 'Simple Blast'
      when singular_creative_id = '6289278659522' then 'Chef'
      when singular_creative_id = '6288920762322' then 'Tilting Table'
      when singular_creative_id = '6302530845922' then 'Tilting Table'
      when singular_creative_id = '6302530847322' then 'Elevator'
      when singular_creative_id = '6289494921922' then 'Zen'
      when singular_creative_id = '6288922455522' then 'App Store Trailer'
      when singular_creative_id = '6288920747722' then 'Chef'
      when singular_creative_id = '6288920759722' then 'SimpleMatch'
      when singular_creative_id = '6289278657522' then 'Chef'
      when singular_creative_id = '6289494924922' then 'Zen'
      when singular_creative_id = '6353426254922' then 'Lady Boss'
      when singular_creative_id = '6288920749922' then 'Elevator'
      when singular_creative_id = '6289278666322' then 'Sassy Dog'
      when singular_creative_id = '6289494924322' then 'Match3'
      when singular_creative_id = '6289494923522' then 'Tilting Table'
      when singular_creative_id = '6288922456922' then 'Elevator'
      when singular_creative_id = '6289494923122' then 'Chef'
      when singular_creative_id = '6288920759922' then 'SimpleMatch'
      when singular_creative_id = '6289278670922' then 'Tilting Table'
      when singular_creative_id = '6288920745322' then 'App Store Trailer'
      when singular_creative_id = '6288922446122' then 'Match3'
      when singular_creative_id = '6288920745522' then 'Chef'
      when singular_creative_id = '6288922456322' then 'Elevator'
      when singular_creative_id = '6288920747522' then 'Elevator'
      when singular_creative_id = '6353426253322' then 'Spin Girl'
      when singular_creative_id = '6288922443122' then 'Sassy Dog'
      when singular_creative_id = '6288922445922' then 'Zen'
      when singular_creative_id = '6289494918322' then 'Elevator'
      when singular_creative_id = '6289494917522' then 'Simple Blast'
      when singular_creative_id = '6302530846722' then 'WeirdTeddyBear'
      when singular_creative_id = '6289278662522' then 'Elevator'
      when singular_creative_id = '6288920749322' then 'Match3'
      when singular_creative_id = '6288922443322' then 'Zen'
      when singular_creative_id = '6288920762722' then 'Zen'
      when singular_creative_id = '6289278659722' then 'Elevator'
      when singular_creative_id = '6288922447922' then 'Tilting Table'
      when singular_creative_id = '6289494923922' then 'Tilting Table'
      when singular_creative_id = '6288922454722' then 'App Store Trailer'
      when singular_creative_id = '6289494920522' then 'Tilting Table'
      when singular_creative_id = '6288922458722' then 'Simple Blast'
      when singular_creative_id = '6288920747122' then 'Chef'
      when singular_creative_id = '6360043117322' then 'Lady Boss'
      when singular_creative_id = '6288920760322' then 'Tilting Table'
      when singular_creative_id = '6289494918722' then 'Elevator'
      when singular_creative_id = '6288922456522' then 'Elevator'
      when singular_creative_id = '6288920754922' then 'Simple Blast'
      when singular_creative_id = '6288920752122' then 'Sassy Dog'
      when singular_creative_id = '6289494919522' then 'SimpleMatch'
      when singular_creative_id = '6288920751722' then 'Sassy Dog'
      when singular_creative_id = '6289278671122' then 'Tilting Table'
      when singular_creative_id = '6288922441122' then 'Chef'
      when singular_creative_id = '6289494923322' then 'Elevator'
      when singular_creative_id = '6289278659322' then 'Chef'
      when singular_creative_id = '6360043119722' then 'Testimonial'
      when singular_creative_id = '6288920760122' then 'Tilting Table'
      when singular_creative_id = '6289494921122' then 'Match3'
      when singular_creative_id = '6289278666122' then 'Sassy Dog'
      when singular_creative_id = '6288920750122' then 'Elevator'
      when singular_creative_id = '6289494919922' then 'SimpleMatch'
      when singular_creative_id = '6342654070522' then 'Spin Girl'
      when singular_creative_id = '6288922448522' then 'Zen'
      when singular_creative_id = '6288920754722' then 'Simple Blast'
      when singular_creative_id = '6289494920722' then 'SimpleMatch'
      when singular_creative_id = '6289494919722' then 'App Store Trailer'
      when singular_creative_id = '6288920754522' then 'SimpleMatch'
      when singular_creative_id = '6288922447122' then 'Match3'
      when singular_creative_id = '6288922455722' then 'App Store Trailer'
      when singular_creative_id = '6360043117922' then 'Handsome Man'
      when singular_creative_id = '6288922456722' then 'Simple Blast'
      when singular_creative_id = '6289278672922' then 'Tilting Table'
      when singular_creative_id = '6289494921522' then 'Sassy Dog'
      when singular_creative_id = '6289494918522' then 'Simple Blast'
      when singular_creative_id = '6288920753322' then 'Sassy Dog'
      when singular_creative_id = '6288922441722' then 'Chef'

      when singular_creative_id = '6500848734322' then 'YogaWithSloth'
      when singular_creative_id = '6501692039722' then 'Zen'
      when singular_creative_id = '6501685619922' then 'Meet the Chum Chums'
      when singular_creative_id = '6500851107322' then 'App Store Trailer'
      when singular_creative_id = '6500850962922' then 'Man With Horse'
      when singular_creative_id = '6501746012122' then 'Chum Chums Painting'

      when singular_creative_id = '6527221708322' then 'Spin With Sloth'
      when singular_creative_id = '6527221707522' then 'Tilting Table'
      when singular_creative_id = '6527221709122' then 'Lady Boss'
      when singular_creative_id = '6527221707922' then 'Handsome Man'
      when singular_creative_id = '6527221708522' then 'YogaWithSloth'
      when singular_creative_id = '6528146732722' then 'Testimonial'
      when singular_creative_id = '6527221709522' then 'Testimonial'
      when singular_creative_id = '6527221708922' then 'Lady Boss'
      when singular_creative_id = '6528145729922' then 'Zen'
      when singular_creative_id = '6528145729722' then 'Meet the Chum Chums'
      when singular_creative_id = '6527221709322' then 'Man With Horse'
      when singular_creative_id = '6527221706722' then 'Handsome Man'
      when singular_creative_id = '6527221708722' then 'Spin With Koala'
      when singular_creative_id = '6527221708122' then 'Man With Horse'
      when singular_creative_id = '6527221707122' then 'Zen'
      when singular_creative_id = '6528145730322' then 'App Store Trailer'
      when singular_creative_id = '6527221707722' then 'App Store Trailer'
      when singular_creative_id = '6528145730122' then 'Man With Horse'
      when singular_creative_id = '6528145730522' then 'YogaWithSloth'


  else 'Unmapped'

  end
  "
}

constant: singular_simple_ad_name_without_table {
  value: "
  case

  when full_ad_name like '%AppStoreTrailer%' then 'App Store Trailer'
  when full_ad_name like '%APVUpdate%' then 'App Store Trailer'
  when full_ad_name like '%Asian Baby%' then 'Asian Baby'
  when full_ad_name like '%ASOTrailer%' then 'App Store Trailer'
  when full_ad_name like '%Chef%' then 'Chef'
  when full_ad_name like '%Elevator%' then 'Elevator'
  when full_ad_name like '%HandsomeMan%' then 'Handsome Man'
  when full_ad_name like '%Handsome Man%' then 'Handsome Man'
  when full_ad_name like '%Lady Boss%' then 'Lady Boss'
  when full_ad_name like '%LadyBoss%' then 'Lady Boss'
  when full_ad_name like '%ManOnHorse%' then 'Man With Horse'
  when full_ad_name like '%ManWithHorse%' then 'Man With Horse'
  when full_ad_name like '%Match3%' then 'Match3'
  when full_ad_name like '%Playable%' then 'Playable'
  when full_ad_name like '%Punk Grandma%' then 'Punk Grandma'
  when full_ad_name like '%Simple Blast%' then 'Simple Blast'
  when full_ad_name like '%SimpleBlast%' then 'Simple Blast'
  when full_ad_name like '%Spin Girl%' then 'Spin Girl'
  when full_ad_name like '%SpinWithKoala%' then 'Spin With Koala'
  when full_ad_name like '%SpinWithSloth%' then 'Spin With Sloth'
  when full_ad_name like '%Tilting Table%' then 'Tilting Table'
  when full_ad_name like '%TiltingTable%' then 'Tilting Table'
  when full_ad_name like '%WeirdTeddyBear%' then 'WeirdTeddyBear'
  when full_ad_name like '%Yoga Girl%' then 'Yoga Girl'
  when full_ad_name like '%YogaWithSloth%' then 'YogaWithSloth'
  when full_ad_name like '%Zen%' then 'Zen'
  when full_ad_name like '%App Store Trailer%' then 'App Store Trailer'
  when full_ad_name like '%SimpleMatch%' then 'SimpleMatch'
  when full_ad_name like '%SassyDog%' then 'Sassy Dog'
  when full_ad_name like '%WeirdTreats%' then 'WeirdTreats'
  when full_ad_name like '%WeirdTeddy%' then 'WeirdTeddyBear'
  when full_ad_name like '%TTC%' then 'Tilting Table'
  when full_ad_name like '%GirlWithCats%' then 'Girl With Cats'
  when full_ad_name like '%AsianBaby%' then 'Asian Baby'
  when full_ad_name like '%PunkAsianGrandma%' then 'Punk Asian Grandma'
  when full_ad_name like '%LoungingWithCats%' then 'Lounging With Cats'
  when full_ad_name like '%LoungingWithSheep%' then 'Lounging With Sheep'
  when full_ad_name like '%MeetChum%' then 'Meet the Chum Chums'
  when full_ad_name like '%ChumsPainting%' then 'Chum Chums Painting'
  when full_ad_name like '%TestimonialAI%' then 'Testimonial (Unmapped AI)'
  when full_ad_name like '%Testimonial%' then 'Testimonial'

  when singular_creative_id = '6301194227322' then 'App Store Trailer'
  when singular_creative_id = '6350278560322' then 'Tilting Table'
  when singular_creative_id = '6353426254522' then 'Spin Girl'
  when singular_creative_id = '6289278657922' then 'App Store Trailer'
  when singular_creative_id = '6442181207722' then 'Tilting Table'
  when singular_creative_id = '6294267214122' then 'App Store Trailer'
  when singular_creative_id = '6460902469922' then 'Spin With Sloth'
  when singular_creative_id = '6444529394922' then 'Tilting Table'
  when singular_creative_id = '6442222790122' then 'Handsome Man'
  when singular_creative_id = '6334482486722' then 'Testimonial'
  when singular_creative_id = '6442174775522' then 'Testimonial'
  when singular_creative_id = '6350253635722' then 'Simple Blast'
  when singular_creative_id = '6442177688922' then 'Man With Horse'
  when singular_creative_id = '6366321673122' then 'Spin Girl'
  when singular_creative_id = '6460902468722' then 'Handsome Man'
  when singular_creative_id = '6302530847122' then 'App Store Trailer'
  when singular_creative_id = '6460902470922' then 'Handsome Man'
  when singular_creative_id = '6350258071722' then 'App Store Trailer'
  when singular_creative_id = '6451988225122' then 'Handsome Man'
  when singular_creative_id = '6460902468522' then 'Tilting Table'
  when singular_creative_id = '6460902469722' then 'Man With Horse'
  when singular_creative_id = '6353426253122' then 'Punk Grandma'
  when singular_creative_id = '6302530845722' then 'Testimonial'
  when singular_creative_id = '6353426254722' then 'Handsome Man'
  when singular_creative_id = '6448215766322' then 'Yoga Girl'
  when singular_creative_id = '6448215766122' then 'Yoga Girl'
  when singular_creative_id = '6366321674322' then 'Handsome Man'
  when singular_creative_id = '6334481546522' then 'Handsome Man'
  when singular_creative_id = '6366321674122' then 'Handsome Man'
  when singular_creative_id = '6350216316922' then 'Testimonial'
  when singular_creative_id = '6442181207522' then 'Zen'
  when singular_creative_id = '6366321673522' then 'Punk Grandma'
  when singular_creative_id = '6448215768922' then 'Handsome Man'
  when singular_creative_id = '6366321673922' then 'Yoga Girl'
  when singular_creative_id = '6334481915922' then 'Handsome Man'
  when singular_creative_id = '6451988227722' then 'Lady Boss'
  when singular_creative_id = '6451988226522' then 'Handsome Man'
  when singular_creative_id = '6448215768722' then 'Punk Grandma'
  when singular_creative_id = '6334482296722' then 'Spin Girl'
  when singular_creative_id = '6301194230722' then 'Playable'
  when singular_creative_id = '6353426253522' then 'Lady Boss'
  when singular_creative_id = '6442177688522' then 'Spin With Sloth'
  when singular_creative_id = '6353426255722' then 'Handsome Man'
  when singular_creative_id = '6448215766522' then 'Handsome Man'
  when singular_creative_id = '6460902469122' then 'Zen'
  when singular_creative_id = '6289278673122' then 'Playable'
  when singular_creative_id = '6442177688722' then 'YogaWithSloth'
  when singular_creative_id = '6460902470722' then 'Spin With Koala'
  when singular_creative_id = '6334481714722' then 'Lady Boss'
  when singular_creative_id = '6451988226922' then 'Yoga Girl'
  when singular_creative_id = '6460902470122' then 'Lady Boss'
  when singular_creative_id = '6301581265322' then 'Testimonial'
  when singular_creative_id = '6448215768522' then 'Spin Girl'
  when singular_creative_id = '6460902469322' then 'Lady Boss'
  when singular_creative_id = '6334482125722' then 'Punk Grandma'
  when singular_creative_id = '6350246649322' then 'Tilting Table'
  when singular_creative_id = '6451988224722' then 'Punk Grandma'
  when singular_creative_id = '6294267211322' then 'Tilting Table'
  when singular_creative_id = '6442177689122' then 'Handsome Man'
  when singular_creative_id = '6301409044322' then 'Elevator'
  when singular_creative_id = '6444574033522' then 'Tilting Table'
  when singular_creative_id = '6334482342722' then 'Spin Girl'
  when singular_creative_id = '6451988224922' then 'Spin Girl'
  when singular_creative_id = '6294267212722' then 'Playable'
  when singular_creative_id = '6365784367122' then 'Spin Girl'
  when singular_creative_id = '6294267215722' then 'App Store Trailer'
  when singular_creative_id = '6451988228122' then 'Lady Boss'
  when singular_creative_id = '6460902469522' then 'Man With Horse'
  when singular_creative_id = '6301194229922' then 'Simple Blast'
  when singular_creative_id = '6444529395722' then 'Man With Horse'
  when singular_creative_id = '6444529395522' then 'Lady Boss'
  when singular_creative_id = '6442180318122' then 'App Store Trailer'
  when singular_creative_id = '6448215769322' then 'Handsome Man'
  when singular_creative_id = '6301194231522' then 'Zen'
  when singular_creative_id = '6353426255122' then 'Punk Grandma'
  when singular_creative_id = '6442177687722' then 'Lady Boss'
  when singular_creative_id = '6334481675522' then 'Lady Boss'
  when singular_creative_id = '6350252548722' then 'Zen'
  when singular_creative_id = '6444529396322' then 'Lady Boss'
  when singular_creative_id = '6460902470322' then 'YogaWithSloth'
  when singular_creative_id = '6302530847922' then 'Playable'
  when singular_creative_id = '6442177688122' then 'Lady Boss'
  when singular_creative_id = '6302530847722' then 'Zen'
  when singular_creative_id = '6460902471122' then 'Testimonial'
  when singular_creative_id = '6448215766922' then 'Lady Boss'
  when singular_creative_id = '6288920745122' then 'App Store Trailer'
  when singular_creative_id = '6334482436322' then 'Yoga Girl'
  when singular_creative_id = '6451988227522' then 'Asian Baby'
  when singular_creative_id = '6294267210522' then 'Zen'
  when singular_creative_id = '6289278662922' then 'Elevator'
  when singular_creative_id = '6301194231722' then 'Tilting Table'
  when singular_creative_id = '6442177687922' then 'Spin With Koala'
  when singular_creative_id = '6444529394522' then 'Spin With Koala'
  when singular_creative_id = '6334477095122' then 'Asian Baby'
  when singular_creative_id = '6294267217522' then 'Chef'
  when singular_creative_id = '6334481838922' then 'Lady Boss'
  when singular_creative_id = '6442177688322' then 'Man With Horse'
  when singular_creative_id = '6366321672922' then 'Lady Boss'
  when singular_creative_id = '6334482035922' then 'Punk Grandma'
  when singular_creative_id = '6448215767922' then 'Spin Girl'
  when singular_creative_id = '6444529394722' then 'Handsome Man'
  when singular_creative_id = '6334482394722' then 'Yoga Girl'
  when singular_creative_id = '6289278675322' then 'Zen'
  when singular_creative_id = '6444526679522' then 'App Store Trailer'
  when singular_creative_id = '6444529395322' then 'Handsome Man'
  when singular_creative_id = '6334481617522' then 'Lady Boss'
  when singular_creative_id = '6444529396122' then 'Zen'
  when singular_creative_id = '6365784366522' then 'Handsome Man'
  when singular_creative_id = '6448215767522' then 'Lady Boss'
  when singular_creative_id = '6301194226922' then 'SimpleMatch'
  when singular_creative_id = '6302530847522' then 'Simple Blast'
  when singular_creative_id = '6289278675722' then 'Zen'
  when singular_creative_id = '6365784366922' then 'Handsome Man'
  when singular_creative_id = '6365784368122' then 'Lady Boss'
  when singular_creative_id = '6365784368322' then 'Punk Grandma'
  when singular_creative_id = '6289278666722' then 'Sassy Dog'
  when singular_creative_id = '6334481952522' then 'Handsome Man'
  when singular_creative_id = '6353426253722' then 'Lady Boss'
  when singular_creative_id = '6302530846122' then 'Elevator'
  when singular_creative_id = '6334481405522' then 'Handsome Man'
  when singular_creative_id = '6444529394122' then 'Spin With Sloth'
  when singular_creative_id = '6460902470522' then 'App Store Trailer'
  when singular_creative_id = '6289494924122' then 'Playable'
  when singular_creative_id = '6365784368922' then 'Yoga Girl'
  when singular_creative_id = '6294267214522' then 'Match3'
  when singular_creative_id = '6366321675122' then 'Punk Grandma'
  when singular_creative_id = '6448215765922' then 'Lady Boss'
  when singular_creative_id = '6444529394322' then 'YogaWithSloth'
  when singular_creative_id = '6366321672322' then 'Handsome Man'
  when singular_creative_id = '6366321674522' then 'Yoga Girl'
  when singular_creative_id = '6288922442922' then 'Zen'
  when singular_creative_id = '6294267217322' then 'Elevator'
  when singular_creative_id = '6444529395122' then 'Testimonial'
  when singular_creative_id = '6366321673322' then 'Lady Boss'
  when singular_creative_id = '6451988225522' then 'Punk Grandma'
  when singular_creative_id = '6294267212322' then 'Simple Blast'
  when singular_creative_id = '6353426254322' then 'Yoga Girl'
  when singular_creative_id = '6360326687122' then 'App Store Trailer'
  when singular_creative_id = '6294267213522' then 'Simple Blast'
  when singular_creative_id = '6448215767122' then 'Asian Baby'
  when singular_creative_id = '6365784367522' then 'Lady Boss'
  when singular_creative_id = '6448215767722' then 'Punk Grandma'
  when singular_creative_id = '6360043117122' then 'Lady Boss'
  when singular_creative_id = '6365784368522' then 'Handsome Man'
  when singular_creative_id = '6451988226322' then 'Handsome Man'
  when singular_creative_id = '6353426252522' then 'Yoga Girl'
  when singular_creative_id = '6288920762122' then 'Playable'
  when singular_creative_id = '6451988226122' then 'Lady Boss'
  when singular_creative_id = '6294267211122' then 'Tilting Table'
  when singular_creative_id = '6365784367322' then 'Asian Baby'
  when singular_creative_id = '6294267215922' then 'App Store Trailer'
  when singular_creative_id = '6301395801322' then 'Tilting Table'
  when singular_creative_id = '6365784368722' then 'Yoga Girl'
  when singular_creative_id = '6289278658122' then 'App Store Trailer'
  when singular_creative_id = '6294267214722' then 'Chef'
  when singular_creative_id = '6301446608522' then 'WeirdTeddyBear'
  when singular_creative_id = '6288922447722' then 'Playable'
  when singular_creative_id = '6451988227922' then 'Yoga Girl'
  when singular_creative_id = '6302530848322' then 'Match3'
  when singular_creative_id = '6289494919122' then 'App Store Trailer'
  when singular_creative_id = '6451988225322' then 'Lady Boss'
  when singular_creative_id = '6294267213322' then 'SimpleMatch'
  when singular_creative_id = '6444529395922' then 'Man With Horse'
  when singular_creative_id = '6366321674722' then 'Lady Boss'
  when singular_creative_id = '6353426255522' then 'Handsome Man'
  when singular_creative_id = '6289278668322' then 'Simple Blast'
  when singular_creative_id = '6360043117522' then 'Punk Grandma'
  when singular_creative_id = '6288922443522' then 'Sassy Dog'
  when singular_creative_id = '6302530846922' then 'SimpleMatch'
  when singular_creative_id = '6366321672722' then 'Asian Baby'
  when singular_creative_id = '6360043118522' then 'Handsome Man'
  when singular_creative_id = '6294267210922' then 'Zen'
  when singular_creative_id = '6353426254122' then 'Asian Baby'
  when singular_creative_id = '6451988226722' then 'Handsome Man'
  when singular_creative_id = '6360043119122' then 'Yoga Girl'
  when singular_creative_id = '6294267213922' then 'Match3'
  when singular_creative_id = '6301194228322' then 'Elevator'
  when singular_creative_id = '6302530848122' then 'Tilting Table'
  when singular_creative_id = '6289278666922' then 'Sassy Dog'
  when singular_creative_id = '6288920747922' then 'Elevator'
  when singular_creative_id = '6342654069122' then 'Spin Girl'
  when singular_creative_id = '6294267211522' then 'SimpleMatch'
  when singular_creative_id = '6289278673722' then 'Zen'
  when singular_creative_id = '6342654068522' then 'Punk Grandma'
  when singular_creative_id = '6365784367922' then 'Punk Grandma'
  when singular_creative_id = '6366321675522' then 'Lady Boss'
  when singular_creative_id = '6342654068922' then 'Handsome Man'
  when singular_creative_id = '6294267210122' then 'Zen'
  when singular_creative_id = '6301194230122' then 'Match3'
  when singular_creative_id = '6294267216322' then 'Match3'
  when singular_creative_id = '6294267215322' then 'Elevator'
  when singular_creative_id = '6289278668922' then 'Simple Blast'
  when singular_creative_id = '6342654070322' then 'Lady Boss'
  when singular_creative_id = '6448215768322' then 'Lady Boss'
  when singular_creative_id = '6360043118122' then 'Punk Grandma'
  when singular_creative_id = '6451988227322' then 'Spin Girl'
  when singular_creative_id = '6342654068722' then 'Lady Boss'
  when singular_creative_id = '6289278666522' then 'Match3'
  when singular_creative_id = '6289494917922' then 'Simple Blast'
  when singular_creative_id = '6294267216122' then 'Chef'
  when singular_creative_id = '6289278662722' then 'Match3'
  when singular_creative_id = '6289278673322' then 'Tilting Table'
  when singular_creative_id = '6294267210722' then 'Zen'
  when singular_creative_id = '6289278659922' then 'Chef'
  when singular_creative_id = '6448215767322' then 'Handsome Man'
  when singular_creative_id = '6366321674922' then 'Handsome Man'
  when singular_creative_id = '6365784369322' then 'Spin Girl'
  when singular_creative_id = '6294267214922' then 'Sassy Dog'
  when singular_creative_id = '6366321675322' then 'Spin Girl'
  when singular_creative_id = '6342654068322' then 'Handsome Man'
  when singular_creative_id = '6365784367722' then 'Lady Boss'
  when singular_creative_id = '6365784366322' then 'Lady Boss'
  when singular_creative_id = '6288922452922' then 'Tilting Table'
  when singular_creative_id = '6289494923722' then 'Tilting Table'
  when singular_creative_id = '6288920744922' then 'App Store Trailer'
  when singular_creative_id = '6342654069522' then 'Yoga Girl'
  when singular_creative_id = '6288920764122' then 'Zen'
  when singular_creative_id = '6360043119322' then 'Spin Girl'
  when singular_creative_id = '6288920761922' then 'Tilting Table'
  when singular_creative_id = '6294267213722' then 'Sassy Dog'
  when singular_creative_id = '6288922440922' then 'Chef'
  when singular_creative_id = '6342654071122' then 'Yoga Girl'
  when singular_creative_id = '6342654070722' then 'Punk Grandma'
  when singular_creative_id = '6288920751922' then 'Match3'
  when singular_creative_id = '6342654068122' then 'Handsome Man'
  when singular_creative_id = '6342654069722' then 'Asian Baby'
  when singular_creative_id = '6294267216722' then 'SimpleMatch'
  when singular_creative_id = '6342654070122' then 'Lady Boss'
  when singular_creative_id = '6342654067922' then 'Handsome Man'
  when singular_creative_id = '6289494922322' then 'Chef'
  when singular_creative_id = '6288920762522' then 'Zen'
  when singular_creative_id = '6288920749722' then 'Match3'
  when singular_creative_id = '6288922448122' then 'Tilting Table'
  when singular_creative_id = '6289494921722' then 'Sassy Dog'
  when singular_creative_id = '6288920747322' then 'Chef'
  when singular_creative_id = '6288922448322' then 'Tilting Table'
  when singular_creative_id = '6289278671522' then 'SimpleMatch'
  when singular_creative_id = '6289278657322' then 'App Store Trailer'
  when singular_creative_id = '6289278671322' then 'SimpleMatch'
  when singular_creative_id = '6289278657722' then 'App Store Trailer'
  when singular_creative_id = '6288920746522' then 'App Store Trailer'
  when singular_creative_id = '6289494920922' then 'Zen'
  when singular_creative_id = '6288920758522' then 'Simple Blast'
  when singular_creative_id = '6288922452322' then 'SimpleMatch'
  when singular_creative_id = '6294267215522' then 'Elevator'
  when singular_creative_id = '6288920749522' then 'Match3'
  when singular_creative_id = '6289278663122' then 'Match3'
  when singular_creative_id = '6288922446322' then 'Match3'
  when singular_creative_id = '6288922458322' then 'Simple Blast'
  when singular_creative_id = '6289278659522' then 'Chef'
  when singular_creative_id = '6288920762322' then 'Tilting Table'
  when singular_creative_id = '6302530845922' then 'Tilting Table'
  when singular_creative_id = '6302530847322' then 'Elevator'
  when singular_creative_id = '6289494921922' then 'Zen'
  when singular_creative_id = '6288922455522' then 'App Store Trailer'
  when singular_creative_id = '6288920747722' then 'Chef'
  when singular_creative_id = '6288920759722' then 'SimpleMatch'
  when singular_creative_id = '6289278657522' then 'Chef'
  when singular_creative_id = '6289494924922' then 'Zen'
  when singular_creative_id = '6353426254922' then 'Lady Boss'
  when singular_creative_id = '6288920749922' then 'Elevator'
  when singular_creative_id = '6289278666322' then 'Sassy Dog'
  when singular_creative_id = '6289494924322' then 'Match3'
  when singular_creative_id = '6289494923522' then 'Tilting Table'
  when singular_creative_id = '6288922456922' then 'Elevator'
  when singular_creative_id = '6289494923122' then 'Chef'
  when singular_creative_id = '6288920759922' then 'SimpleMatch'
  when singular_creative_id = '6289278670922' then 'Tilting Table'
  when singular_creative_id = '6288920745322' then 'App Store Trailer'
  when singular_creative_id = '6288922446122' then 'Match3'
  when singular_creative_id = '6288920745522' then 'Chef'
  when singular_creative_id = '6288922456322' then 'Elevator'
  when singular_creative_id = '6288920747522' then 'Elevator'
  when singular_creative_id = '6353426253322' then 'Spin Girl'
  when singular_creative_id = '6288922443122' then 'Sassy Dog'
  when singular_creative_id = '6288922445922' then 'Zen'
  when singular_creative_id = '6289494918322' then 'Elevator'
  when singular_creative_id = '6289494917522' then 'Simple Blast'
  when singular_creative_id = '6302530846722' then 'WeirdTeddyBear'
  when singular_creative_id = '6289278662522' then 'Elevator'
  when singular_creative_id = '6288920749322' then 'Match3'
  when singular_creative_id = '6288922443322' then 'Zen'
  when singular_creative_id = '6288920762722' then 'Zen'
  when singular_creative_id = '6289278659722' then 'Elevator'
  when singular_creative_id = '6288922447922' then 'Tilting Table'
  when singular_creative_id = '6289494923922' then 'Tilting Table'
  when singular_creative_id = '6288922454722' then 'App Store Trailer'
  when singular_creative_id = '6289494920522' then 'Tilting Table'
  when singular_creative_id = '6288922458722' then 'Simple Blast'
  when singular_creative_id = '6288920747122' then 'Chef'
  when singular_creative_id = '6360043117322' then 'Lady Boss'
  when singular_creative_id = '6288920760322' then 'Tilting Table'
  when singular_creative_id = '6289494918722' then 'Elevator'
  when singular_creative_id = '6288922456522' then 'Elevator'
  when singular_creative_id = '6288920754922' then 'Simple Blast'
  when singular_creative_id = '6288920752122' then 'Sassy Dog'
  when singular_creative_id = '6289494919522' then 'SimpleMatch'
  when singular_creative_id = '6288920751722' then 'Sassy Dog'
  when singular_creative_id = '6289278671122' then 'Tilting Table'
  when singular_creative_id = '6288922441122' then 'Chef'
  when singular_creative_id = '6289494923322' then 'Elevator'
  when singular_creative_id = '6289278659322' then 'Chef'
  when singular_creative_id = '6360043119722' then 'Testimonial'
  when singular_creative_id = '6288920760122' then 'Tilting Table'
  when singular_creative_id = '6289494921122' then 'Match3'
  when singular_creative_id = '6289278666122' then 'Sassy Dog'
  when singular_creative_id = '6288920750122' then 'Elevator'
  when singular_creative_id = '6289494919922' then 'SimpleMatch'
  when singular_creative_id = '6342654070522' then 'Spin Girl'
  when singular_creative_id = '6288922448522' then 'Zen'
  when singular_creative_id = '6288920754722' then 'Simple Blast'
  when singular_creative_id = '6289494920722' then 'SimpleMatch'
  when singular_creative_id = '6289494919722' then 'App Store Trailer'
  when singular_creative_id = '6288920754522' then 'SimpleMatch'
  when singular_creative_id = '6288922447122' then 'Match3'
  when singular_creative_id = '6288922455722' then 'App Store Trailer'
  when singular_creative_id = '6360043117922' then 'Handsome Man'
  when singular_creative_id = '6288922456722' then 'Simple Blast'
  when singular_creative_id = '6289278672922' then 'Tilting Table'
  when singular_creative_id = '6289494921522' then 'Sassy Dog'
  when singular_creative_id = '6289494918522' then 'Simple Blast'
  when singular_creative_id = '6288920753322' then 'Sassy Dog'
  when singular_creative_id = '6288922441722' then 'Chef'

  when singular_creative_id = '6500848734322' then 'YogaWithSloth'
  when singular_creative_id = '6501692039722' then 'Zen'
  when singular_creative_id = '6501685619922' then 'Meet the Chum Chums'
  when singular_creative_id = '6500851107322' then 'App Store Trailer'
  when singular_creative_id = '6500850962922' then 'Man With Horse'
  when singular_creative_id = '6501746012122' then 'Chum Chums Painting'

  else 'Unmapped'

  end
  "
}


constant: singular_grouped_ad_name {
  value: "
  case

    when full_ad_name like '%AppStoreTrailer%' then 'App Store Trailer'
    when full_ad_name like '%APVUpdate%' then 'App Store Trailer'
    when full_ad_name like '%Asian Baby%' then 'AI'
    when full_ad_name like '%ASOTrailer%' then 'App Store Trailer'
    when full_ad_name like '%Chef%' then 'AirTraffic'
    when full_ad_name like '%Elevator%' then 'AirTraffic'
    when full_ad_name like '%HandsomeMan%' then 'AI'
    when full_ad_name like '%Handsome Man%' then 'AI'
    when full_ad_name like '%Lady Boss%' then 'AI'
    when full_ad_name like '%LadyBoss%' then 'AI'
    when full_ad_name like '%ManOnHorse%' then 'AI'
    when full_ad_name like '%ManWithHorse%' then 'AI'
    when full_ad_name like '%Match3%' then 'Match3'
    when full_ad_name like '%Playable%' then 'Playable'
    when full_ad_name like '%Punk Grandma%' then 'AI'
    when full_ad_name like '%Simple Blast%' then 'Simple Blast'
    when full_ad_name like '%SimpleBlast%' then 'Simple Blast'
    when full_ad_name like '%Spin Girl%' then 'AI'
    when full_ad_name like '%SpinWithKoala%' then 'AI'
    when full_ad_name like '%SpinWithSloth%' then 'AI'
    when full_ad_name like '%Tilting Table%' then 'Tilting Table'
    when full_ad_name like '%TiltingTable%' then 'Tilting Table'
    when full_ad_name like '%WeirdTeddyBear%' then 'AI'
    when full_ad_name like '%Yoga Girl%' then 'AI'
    when full_ad_name like '%YogaWithSloth%' then 'AI'
    when full_ad_name like '%Zen%' then 'Zen'
    when full_ad_name like '%App Store Trailer%' then 'App Store Trailer'
    when full_ad_name like '%SimpleMatch%' then 'SimpleMatch'
    when full_ad_name like '%SassyDog%' then 'AirTraffic'
    when full_ad_name like '%WeirdTreats%' then 'AI'
    when full_ad_name like '%WeirdTeddy%' then 'AI'
    when full_ad_name like '%TTC%' then 'Tilting Table'
    when full_ad_name like '%GirlWithCats%' then 'AI'
    when full_ad_name like '%AsianBaby%' then 'AI'
    when full_ad_name like '%PunkAsianGrandma%' then 'AI'
    when full_ad_name like '%LoungingWithCats%' then 'AI'
    when full_ad_name like '%LoungingWithSheep%' then 'AI'
    when full_ad_name like '%MeetChum%' then 'Meet the Chum Chums'
    when full_ad_name like '%ChumsPainting%' then 'Chum Chums Painting'
    when full_ad_name like '%TestimonialAI%' then 'AI'
    when full_ad_name like '%Testimonial%' then 'Testimonial'

    when singular_creative_id = '6301194227322' then 'App Store Trailer'
    when singular_creative_id = '6350278560322' then 'Tilting Table'
    when singular_creative_id = '6353426254522' then 'AI'
    when singular_creative_id = '6289278657922' then 'App Store Trailer'
    when singular_creative_id = '6442181207722' then 'Tilting Table'
    when singular_creative_id = '6294267214122' then 'App Store Trailer'
    when singular_creative_id = '6460902469922' then 'AI'
    when singular_creative_id = '6444529394922' then 'Tilting Table'
    when singular_creative_id = '6442222790122' then 'AI'
    when singular_creative_id = '6334482486722' then 'Testimonial'
    when singular_creative_id = '6442174775522' then 'Testimonial'
    when singular_creative_id = '6350253635722' then 'Simple Blast'
    when singular_creative_id = '6442177688922' then 'AI'
    when singular_creative_id = '6366321673122' then 'AI'
    when singular_creative_id = '6460902468722' then 'AI'
    when singular_creative_id = '6302530847122' then 'App Store Trailer'
    when singular_creative_id = '6460902470922' then 'AI'
    when singular_creative_id = '6350258071722' then 'App Store Trailer'
    when singular_creative_id = '6451988225122' then 'AI'
    when singular_creative_id = '6460902468522' then 'Tilting Table'
    when singular_creative_id = '6460902469722' then 'AI'
    when singular_creative_id = '6353426253122' then 'AI'
    when singular_creative_id = '6302530845722' then 'Testimonial'
    when singular_creative_id = '6353426254722' then 'AI'
    when singular_creative_id = '6448215766322' then 'AI'
    when singular_creative_id = '6448215766122' then 'AI'
    when singular_creative_id = '6366321674322' then 'AI'
    when singular_creative_id = '6334481546522' then 'AI'
    when singular_creative_id = '6366321674122' then 'AI'
    when singular_creative_id = '6350216316922' then 'Testimonial'
    when singular_creative_id = '6442181207522' then 'Zen'
    when singular_creative_id = '6366321673522' then 'AI'
    when singular_creative_id = '6448215768922' then 'AI'
    when singular_creative_id = '6366321673922' then 'AI'
    when singular_creative_id = '6334481915922' then 'AI'
    when singular_creative_id = '6451988227722' then 'AI'
    when singular_creative_id = '6451988226522' then 'AI'
    when singular_creative_id = '6448215768722' then 'AI'
    when singular_creative_id = '6334482296722' then 'AI'
    when singular_creative_id = '6301194230722' then 'Playable'
    when singular_creative_id = '6353426253522' then 'AI'
    when singular_creative_id = '6442177688522' then 'AI'
    when singular_creative_id = '6353426255722' then 'AI'
    when singular_creative_id = '6448215766522' then 'AI'
    when singular_creative_id = '6460902469122' then 'Zen'
    when singular_creative_id = '6289278673122' then 'Playable'
    when singular_creative_id = '6442177688722' then 'AI'
    when singular_creative_id = '6460902470722' then 'AI'
    when singular_creative_id = '6334481714722' then 'AI'
    when singular_creative_id = '6451988226922' then 'AI'
    when singular_creative_id = '6460902470122' then 'AI'
    when singular_creative_id = '6301581265322' then 'Testimonial'
    when singular_creative_id = '6448215768522' then 'AI'
    when singular_creative_id = '6460902469322' then 'AI'
    when singular_creative_id = '6334482125722' then 'AI'
    when singular_creative_id = '6350246649322' then 'Tilting Table'
    when singular_creative_id = '6451988224722' then 'AI'
    when singular_creative_id = '6294267211322' then 'Tilting Table'
    when singular_creative_id = '6442177689122' then 'AI'
    when singular_creative_id = '6301409044322' then 'AirTraffic'
    when singular_creative_id = '6444574033522' then 'Tilting Table'
    when singular_creative_id = '6334482342722' then 'AI'
    when singular_creative_id = '6451988224922' then 'AI'
    when singular_creative_id = '6294267212722' then 'Playable'
    when singular_creative_id = '6365784367122' then 'AI'
    when singular_creative_id = '6294267215722' then 'App Store Trailer'
    when singular_creative_id = '6451988228122' then 'AI'
    when singular_creative_id = '6460902469522' then 'AI'
    when singular_creative_id = '6301194229922' then 'Simple Blast'
    when singular_creative_id = '6444529395722' then 'AI'
    when singular_creative_id = '6444529395522' then 'AI'
    when singular_creative_id = '6442180318122' then 'App Store Trailer'
    when singular_creative_id = '6448215769322' then 'AI'
    when singular_creative_id = '6301194231522' then 'Zen'
    when singular_creative_id = '6353426255122' then 'AI'
    when singular_creative_id = '6442177687722' then 'AI'
    when singular_creative_id = '6334481675522' then 'AI'
    when singular_creative_id = '6350252548722' then 'Zen'
    when singular_creative_id = '6444529396322' then 'AI'
    when singular_creative_id = '6460902470322' then 'AI'
    when singular_creative_id = '6302530847922' then 'Playable'
    when singular_creative_id = '6442177688122' then 'AI'
    when singular_creative_id = '6302530847722' then 'Zen'
    when singular_creative_id = '6460902471122' then 'Testimonial'
    when singular_creative_id = '6448215766922' then 'AI'
    when singular_creative_id = '6288920745122' then 'App Store Trailer'
    when singular_creative_id = '6334482436322' then 'AI'
    when singular_creative_id = '6451988227522' then 'AI'
    when singular_creative_id = '6294267210522' then 'Zen'
    when singular_creative_id = '6289278662922' then 'AirTraffic'
    when singular_creative_id = '6301194231722' then 'Tilting Table'
    when singular_creative_id = '6442177687922' then 'AI'
    when singular_creative_id = '6444529394522' then 'AI'
    when singular_creative_id = '6334477095122' then 'AI'
    when singular_creative_id = '6294267217522' then 'AirTraffic'
    when singular_creative_id = '6334481838922' then 'AI'
    when singular_creative_id = '6442177688322' then 'AI'
    when singular_creative_id = '6366321672922' then 'AI'
    when singular_creative_id = '6334482035922' then 'AI'
    when singular_creative_id = '6448215767922' then 'AI'
    when singular_creative_id = '6444529394722' then 'AI'
    when singular_creative_id = '6334482394722' then 'AI'
    when singular_creative_id = '6289278675322' then 'Zen'
    when singular_creative_id = '6444526679522' then 'App Store Trailer'
    when singular_creative_id = '6444529395322' then 'AI'
    when singular_creative_id = '6334481617522' then 'AI'
    when singular_creative_id = '6444529396122' then 'Zen'
    when singular_creative_id = '6365784366522' then 'AI'
    when singular_creative_id = '6448215767522' then 'AI'
    when singular_creative_id = '6301194226922' then 'SimpleMatch'
    when singular_creative_id = '6302530847522' then 'Simple Blast'
    when singular_creative_id = '6289278675722' then 'Zen'
    when singular_creative_id = '6365784366922' then 'AI'
    when singular_creative_id = '6365784368122' then 'AI'
    when singular_creative_id = '6365784368322' then 'AI'
    when singular_creative_id = '6289278666722' then 'AirTraffic'
    when singular_creative_id = '6334481952522' then 'AI'
    when singular_creative_id = '6353426253722' then 'AI'
    when singular_creative_id = '6302530846122' then 'AirTraffic'
    when singular_creative_id = '6334481405522' then 'AI'
    when singular_creative_id = '6444529394122' then 'AI'
    when singular_creative_id = '6460902470522' then 'App Store Trailer'
    when singular_creative_id = '6289494924122' then 'Playable'
    when singular_creative_id = '6365784368922' then 'AI'
    when singular_creative_id = '6294267214522' then 'Match3'
    when singular_creative_id = '6366321675122' then 'AI'
    when singular_creative_id = '6448215765922' then 'AI'
    when singular_creative_id = '6444529394322' then 'AI'
    when singular_creative_id = '6366321672322' then 'AI'
    when singular_creative_id = '6366321674522' then 'AI'
    when singular_creative_id = '6288922442922' then 'Zen'
    when singular_creative_id = '6294267217322' then 'AirTraffic'
    when singular_creative_id = '6444529395122' then 'Testimonial'
    when singular_creative_id = '6366321673322' then 'AI'
    when singular_creative_id = '6451988225522' then 'AI'
    when singular_creative_id = '6294267212322' then 'Simple Blast'
    when singular_creative_id = '6353426254322' then 'AI'
    when singular_creative_id = '6360326687122' then 'App Store Trailer'
    when singular_creative_id = '6294267213522' then 'Simple Blast'
    when singular_creative_id = '6448215767122' then 'AI'
    when singular_creative_id = '6365784367522' then 'AI'
    when singular_creative_id = '6448215767722' then 'AI'
    when singular_creative_id = '6360043117122' then 'AI'
    when singular_creative_id = '6365784368522' then 'AI'
    when singular_creative_id = '6451988226322' then 'AI'
    when singular_creative_id = '6353426252522' then 'AI'
    when singular_creative_id = '6288920762122' then 'Playable'
    when singular_creative_id = '6451988226122' then 'AI'
    when singular_creative_id = '6294267211122' then 'Tilting Table'
    when singular_creative_id = '6365784367322' then 'AI'
    when singular_creative_id = '6294267215922' then 'App Store Trailer'
    when singular_creative_id = '6301395801322' then 'Tilting Table'
    when singular_creative_id = '6365784368722' then 'AI'
    when singular_creative_id = '6289278658122' then 'App Store Trailer'
    when singular_creative_id = '6294267214722' then 'AirTraffic'
    when singular_creative_id = '6301446608522' then 'WeirdTeddyBear'
    when singular_creative_id = '6288922447722' then 'Playable'
    when singular_creative_id = '6451988227922' then 'AI'
    when singular_creative_id = '6302530848322' then 'Match3'
    when singular_creative_id = '6289494919122' then 'App Store Trailer'
    when singular_creative_id = '6451988225322' then 'AI'
    when singular_creative_id = '6294267213322' then 'SimpleMatch'
    when singular_creative_id = '6444529395922' then 'AI'
    when singular_creative_id = '6366321674722' then 'AI'
    when singular_creative_id = '6353426255522' then 'AI'
    when singular_creative_id = '6289278668322' then 'Simple Blast'
    when singular_creative_id = '6360043117522' then 'AI'
    when singular_creative_id = '6288922443522' then 'AirTraffic'
    when singular_creative_id = '6302530846922' then 'SimpleMatch'
    when singular_creative_id = '6366321672722' then 'AI'
    when singular_creative_id = '6360043118522' then 'AI'
    when singular_creative_id = '6294267210922' then 'Zen'
    when singular_creative_id = '6353426254122' then 'AI'
    when singular_creative_id = '6451988226722' then 'AI'
    when singular_creative_id = '6360043119122' then 'AI'
    when singular_creative_id = '6294267213922' then 'Match3'
    when singular_creative_id = '6301194228322' then 'AirTraffic'
    when singular_creative_id = '6302530848122' then 'Tilting Table'
    when singular_creative_id = '6289278666922' then 'AirTraffic'
    when singular_creative_id = '6288920747922' then 'AirTraffic'
    when singular_creative_id = '6342654069122' then 'AI'
    when singular_creative_id = '6294267211522' then 'SimpleMatch'
    when singular_creative_id = '6289278673722' then 'Zen'
    when singular_creative_id = '6342654068522' then 'AI'
    when singular_creative_id = '6365784367922' then 'AI'
    when singular_creative_id = '6366321675522' then 'AI'
    when singular_creative_id = '6342654068922' then 'AI'
    when singular_creative_id = '6294267210122' then 'Zen'
    when singular_creative_id = '6301194230122' then 'Match3'
    when singular_creative_id = '6294267216322' then 'Match3'
    when singular_creative_id = '6294267215322' then 'AirTraffic'
    when singular_creative_id = '6289278668922' then 'Simple Blast'
    when singular_creative_id = '6342654070322' then 'AI'
    when singular_creative_id = '6448215768322' then 'AI'
    when singular_creative_id = '6360043118122' then 'AI'
    when singular_creative_id = '6451988227322' then 'AI'
    when singular_creative_id = '6342654068722' then 'AI'
    when singular_creative_id = '6289278666522' then 'Match3'
    when singular_creative_id = '6289494917922' then 'Simple Blast'
    when singular_creative_id = '6294267216122' then 'AirTraffic'
    when singular_creative_id = '6289278662722' then 'Match3'
    when singular_creative_id = '6289278673322' then 'Tilting Table'
    when singular_creative_id = '6294267210722' then 'Zen'
    when singular_creative_id = '6289278659922' then 'AirTraffic'
    when singular_creative_id = '6448215767322' then 'AI'
    when singular_creative_id = '6366321674922' then 'AI'
    when singular_creative_id = '6365784369322' then 'AI'
    when singular_creative_id = '6294267214922' then 'AirTraffic'
    when singular_creative_id = '6366321675322' then 'AI'
    when singular_creative_id = '6342654068322' then 'AI'
    when singular_creative_id = '6365784367722' then 'AI'
    when singular_creative_id = '6365784366322' then 'AI'
    when singular_creative_id = '6288922452922' then 'Tilting Table'
    when singular_creative_id = '6289494923722' then 'Tilting Table'
    when singular_creative_id = '6288920744922' then 'App Store Trailer'
    when singular_creative_id = '6342654069522' then 'AI'
    when singular_creative_id = '6288920764122' then 'Zen'
    when singular_creative_id = '6360043119322' then 'AI'
    when singular_creative_id = '6288920761922' then 'Tilting Table'
    when singular_creative_id = '6294267213722' then 'AirTraffic'
    when singular_creative_id = '6288922440922' then 'AirTraffic'
    when singular_creative_id = '6342654071122' then 'AI'
    when singular_creative_id = '6342654070722' then 'AI'
    when singular_creative_id = '6288920751922' then 'Match3'
    when singular_creative_id = '6342654068122' then 'AI'
    when singular_creative_id = '6342654069722' then 'AI'
    when singular_creative_id = '6294267216722' then 'SimpleMatch'
    when singular_creative_id = '6342654070122' then 'AI'
    when singular_creative_id = '6342654067922' then 'AI'
    when singular_creative_id = '6289494922322' then 'AirTraffic'
    when singular_creative_id = '6288920762522' then 'Zen'
    when singular_creative_id = '6288920749722' then 'Match3'
    when singular_creative_id = '6288922448122' then 'Tilting Table'
    when singular_creative_id = '6289494921722' then 'AirTraffic'
    when singular_creative_id = '6288920747322' then 'AirTraffic'
    when singular_creative_id = '6288922448322' then 'Tilting Table'
    when singular_creative_id = '6289278671522' then 'SimpleMatch'
    when singular_creative_id = '6289278657322' then 'App Store Trailer'
    when singular_creative_id = '6289278671322' then 'SimpleMatch'
    when singular_creative_id = '6289278657722' then 'App Store Trailer'
    when singular_creative_id = '6288920746522' then 'App Store Trailer'
    when singular_creative_id = '6289494920922' then 'Zen'
    when singular_creative_id = '6288920758522' then 'Simple Blast'
    when singular_creative_id = '6288922452322' then 'SimpleMatch'
    when singular_creative_id = '6294267215522' then 'AirTraffic'
    when singular_creative_id = '6288920749522' then 'Match3'
    when singular_creative_id = '6289278663122' then 'Match3'
    when singular_creative_id = '6288922446322' then 'Match3'
    when singular_creative_id = '6288922458322' then 'Simple Blast'
    when singular_creative_id = '6289278659522' then 'AirTraffic'
    when singular_creative_id = '6288920762322' then 'Tilting Table'
    when singular_creative_id = '6302530845922' then 'Tilting Table'
    when singular_creative_id = '6302530847322' then 'AirTraffic'
    when singular_creative_id = '6289494921922' then 'Zen'
    when singular_creative_id = '6288922455522' then 'App Store Trailer'
    when singular_creative_id = '6288920747722' then 'AirTraffic'
    when singular_creative_id = '6288920759722' then 'SimpleMatch'
    when singular_creative_id = '6289278657522' then 'AirTraffic'
    when singular_creative_id = '6289494924922' then 'Zen'
    when singular_creative_id = '6353426254922' then 'AI'
    when singular_creative_id = '6288920749922' then 'AirTraffic'
    when singular_creative_id = '6289278666322' then 'AirTraffic'
    when singular_creative_id = '6289494924322' then 'Match3'
    when singular_creative_id = '6289494923522' then 'Tilting Table'
    when singular_creative_id = '6288922456922' then 'AirTraffic'
    when singular_creative_id = '6289494923122' then 'AirTraffic'
    when singular_creative_id = '6288920759922' then 'SimpleMatch'
    when singular_creative_id = '6289278670922' then 'Tilting Table'
    when singular_creative_id = '6288920745322' then 'App Store Trailer'
    when singular_creative_id = '6288922446122' then 'Match3'
    when singular_creative_id = '6288920745522' then 'AirTraffic'
    when singular_creative_id = '6288922456322' then 'AirTraffic'
    when singular_creative_id = '6288920747522' then 'AirTraffic'
    when singular_creative_id = '6353426253322' then 'AI'
    when singular_creative_id = '6288922443122' then 'AirTraffic'
    when singular_creative_id = '6288922445922' then 'Zen'
    when singular_creative_id = '6289494918322' then 'AirTraffic'
    when singular_creative_id = '6289494917522' then 'Simple Blast'
    when singular_creative_id = '6302530846722' then 'WeirdTeddyBear'
    when singular_creative_id = '6289278662522' then 'AirTraffic'
    when singular_creative_id = '6288920749322' then 'Match3'
    when singular_creative_id = '6288922443322' then 'Zen'
    when singular_creative_id = '6288920762722' then 'Zen'
    when singular_creative_id = '6289278659722' then 'AirTraffic'
    when singular_creative_id = '6288922447922' then 'Tilting Table'
    when singular_creative_id = '6289494923922' then 'Tilting Table'
    when singular_creative_id = '6288922454722' then 'App Store Trailer'
    when singular_creative_id = '6289494920522' then 'Tilting Table'
    when singular_creative_id = '6288922458722' then 'Simple Blast'
    when singular_creative_id = '6288920747122' then 'AirTraffic'
    when singular_creative_id = '6360043117322' then 'AI'
    when singular_creative_id = '6288920760322' then 'Tilting Table'
    when singular_creative_id = '6289494918722' then 'AirTraffic'
    when singular_creative_id = '6288922456522' then 'AirTraffic'
    when singular_creative_id = '6288920754922' then 'Simple Blast'
    when singular_creative_id = '6288920752122' then 'AirTraffic'
    when singular_creative_id = '6289494919522' then 'SimpleMatch'
    when singular_creative_id = '6288920751722' then 'AirTraffic'
    when singular_creative_id = '6289278671122' then 'Tilting Table'
    when singular_creative_id = '6288922441122' then 'AirTraffic'
    when singular_creative_id = '6289494923322' then 'AirTraffic'
    when singular_creative_id = '6289278659322' then 'AirTraffic'
    when singular_creative_id = '6360043119722' then 'Testimonial'
    when singular_creative_id = '6288920760122' then 'Tilting Table'
    when singular_creative_id = '6289494921122' then 'Match3'
    when singular_creative_id = '6289278666122' then 'AirTraffic'
    when singular_creative_id = '6288920750122' then 'AirTraffic'
    when singular_creative_id = '6289494919922' then 'SimpleMatch'
    when singular_creative_id = '6342654070522' then 'AI'
    when singular_creative_id = '6288922448522' then 'Zen'
    when singular_creative_id = '6288920754722' then 'Simple Blast'
    when singular_creative_id = '6289494920722' then 'SimpleMatch'
    when singular_creative_id = '6289494919722' then 'App Store Trailer'
    when singular_creative_id = '6288920754522' then 'SimpleMatch'
    when singular_creative_id = '6288922447122' then 'Match3'
    when singular_creative_id = '6288922455722' then 'App Store Trailer'
    when singular_creative_id = '6360043117922' then 'AI'
    when singular_creative_id = '6288922456722' then 'Simple Blast'
    when singular_creative_id = '6289278672922' then 'Tilting Table'
    when singular_creative_id = '6289494921522' then 'AirTraffic'
    when singular_creative_id = '6289494918522' then 'Simple Blast'
    when singular_creative_id = '6288920753322' then 'AirTraffic'
    when singular_creative_id = '6288922441722' then 'AirTraffic'

    when singular_creative_id = '6500848734322' then 'AI'
    when singular_creative_id = '6501692039722' then 'Zen'
    when singular_creative_id = '6501685619922' then 'Meet the Chum Chums'
    when singular_creative_id = '6500851107322' then 'App Store Trailer'
    when singular_creative_id = '6500850962922' then 'AI'
    when singular_creative_id = '6501746012122' then 'Chum Chums Painting'

    when singular_creative_id = '6527221708322' then 'AI'
    when singular_creative_id = '6527221707522' then 'Tilting Table'
    when singular_creative_id = '6527221709122' then 'AI'
    when singular_creative_id = '6527221707922' then 'AI'
    when singular_creative_id = '6527221708522' then 'AI'
    when singular_creative_id = '6528146732722' then 'Testimonial'
    when singular_creative_id = '6527221709522' then 'Testimonial'
    when singular_creative_id = '6527221708922' then 'AI'
    when singular_creative_id = '6528145729922' then 'Zen'
    when singular_creative_id = '6528145729722' then 'Meet the Chum Chums'
    when singular_creative_id = '6527221709322' then 'AI'
    when singular_creative_id = '6527221706722' then 'AI'
    when singular_creative_id = '6527221708722' then 'AI'
    when singular_creative_id = '6527221708122' then 'AI'
    when singular_creative_id = '6527221707122' then 'Zen'
    when singular_creative_id = '6528145730322' then 'App Store Trailer'
    when singular_creative_id = '6527221707722' then 'App Store Trailer'
    when singular_creative_id = '6528145730122' then 'AI'
    when singular_creative_id = '6528145730522' then 'AI'


  else 'Unmapped'

  end
  "
}

###################################################################
## Map Alfa 3 (3 Digit) Country Code to 2 Digit Country Code
## Mapping table Link:
## https://docs.google.com/spreadsheets/d/1bo2YEoElScnqyX4TzVOtf8jJjWlJhcmDTx6eGqfT_5Q/edit?usp=sharing
## Ask Tal Kreuch For Access
###################################################################

constant: map_3_digit_country_code_to_3_digit_country_code {
  value: "
  case
    when alfa_3_country_code = 'AFG' then 'AF'
    when alfa_3_country_code = 'ALA' then 'AX'
    when alfa_3_country_code = 'ALB' then 'AL'
    when alfa_3_country_code = 'DZA' then 'DZ'
    when alfa_3_country_code = 'ASM' then 'AS'
    when alfa_3_country_code = 'AND' then 'AD'
    when alfa_3_country_code = 'AGO' then 'AO'
    when alfa_3_country_code = 'AIA' then 'AI'
    when alfa_3_country_code = 'ATA' then 'AQ'
    when alfa_3_country_code = 'ATG' then 'AG'
    when alfa_3_country_code = 'ARG' then 'AR'
    when alfa_3_country_code = 'ARM' then 'AM'
    when alfa_3_country_code = 'ABW' then 'AW'
    when alfa_3_country_code = 'AUS' then 'AU'
    when alfa_3_country_code = 'AUT' then 'AT'
    when alfa_3_country_code = 'AZE' then 'AZ'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'BHS' then 'BS'
    when alfa_3_country_code = 'BHR' then 'BH'
    when alfa_3_country_code = 'BGD' then 'BD'
    when alfa_3_country_code = 'BRB' then 'BB'
    when alfa_3_country_code = 'BLR' then 'BY'
    when alfa_3_country_code = 'BEL' then 'BE'
    when alfa_3_country_code = 'BLZ' then 'BZ'
    when alfa_3_country_code = 'BEN' then 'BJ'
    when alfa_3_country_code = 'BMU' then 'BM'
    when alfa_3_country_code = 'BTN' then 'BT'
    when alfa_3_country_code = 'BOL' then 'BO'
    when alfa_3_country_code = 'BIH' then 'BA'
    when alfa_3_country_code = 'BWA' then 'BW'
    when alfa_3_country_code = 'BVT' then 'BV'
    when alfa_3_country_code = 'BRA' then 'BR'
    when alfa_3_country_code = 'VGB' then 'VG'
    when alfa_3_country_code = 'IOT' then 'IO'
    when alfa_3_country_code = 'BRN' then 'BN'
    when alfa_3_country_code = 'BGR' then 'BG'
    when alfa_3_country_code = 'BFA' then 'BF'
    when alfa_3_country_code = 'BDI' then 'BI'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'KHM' then 'KH'
    when alfa_3_country_code = 'CMR' then 'CM'
    when alfa_3_country_code = 'CAN' then 'CA'
    when alfa_3_country_code = 'CPV' then 'CV'
    when alfa_3_country_code = 'CYM' then 'KY'
    when alfa_3_country_code = 'CAF' then 'CF'
    when alfa_3_country_code = 'TCD' then 'TD'
    when alfa_3_country_code = 'CHL' then 'CL'
    when alfa_3_country_code = 'CHN' then 'CN'
    when alfa_3_country_code = 'HKG' then 'HK'
    when alfa_3_country_code = 'MAC' then 'MO'
    when alfa_3_country_code = 'CXR' then 'CX'
    when alfa_3_country_code = 'CCK' then 'CC'
    when alfa_3_country_code = 'COL' then 'CO'
    when alfa_3_country_code = 'COM' then 'KM'
    when alfa_3_country_code = 'COG' then 'CG'
    when alfa_3_country_code = 'COD' then 'CD'
    when alfa_3_country_code = 'COK' then 'CK'
    when alfa_3_country_code = 'CRI' then 'CR'
    when alfa_3_country_code = 'CIV' then 'CI'
    when alfa_3_country_code = 'HRV' then 'HR'
    when alfa_3_country_code = 'CUB' then 'CU'
    when alfa_3_country_code = 'CYP' then 'CY'
    when alfa_3_country_code = 'CZE' then 'CZ'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'DNK' then 'DK'
    when alfa_3_country_code = 'DJI' then 'DJ'
    when alfa_3_country_code = 'DMA' then 'DM'
    when alfa_3_country_code = 'DOM' then 'DO'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'ECU' then 'EC'
    when alfa_3_country_code = 'EGY' then 'EG'
    when alfa_3_country_code = 'SLV' then 'SV'
    when alfa_3_country_code = 'GNQ' then 'GQ'
    when alfa_3_country_code = 'ERI' then 'ER'
    when alfa_3_country_code = 'EST' then 'EE'
    when alfa_3_country_code = 'ETH' then 'ET'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'FLK' then 'FK'
    when alfa_3_country_code = 'FRO' then 'FO'
    when alfa_3_country_code = 'FJI' then 'FJ'
    when alfa_3_country_code = 'FIN' then 'FI'
    when alfa_3_country_code = 'FRA' then 'FR'
    when alfa_3_country_code = 'GUF' then 'GF'
    when alfa_3_country_code = 'PYF' then 'PF'
    when alfa_3_country_code = 'ATF' then 'TF'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'GAB' then 'GA'
    when alfa_3_country_code = 'GMB' then 'GM'
    when alfa_3_country_code = 'GEO' then 'GE'
    when alfa_3_country_code = 'DEU' then 'DE'
    when alfa_3_country_code = 'GHA' then 'GH'
    when alfa_3_country_code = 'GIB' then 'GI'
    when alfa_3_country_code = 'GRC' then 'GR'
    when alfa_3_country_code = 'GRL' then 'GL'
    when alfa_3_country_code = 'GRD' then 'GD'
    when alfa_3_country_code = 'GLP' then 'GP'
    when alfa_3_country_code = 'GUM' then 'GU'
    when alfa_3_country_code = 'GTM' then 'GT'
    when alfa_3_country_code = 'GGY' then 'GG'
    when alfa_3_country_code = 'GIN' then 'GN'
    when alfa_3_country_code = 'GNB' then 'GW'
    when alfa_3_country_code = 'GUY' then 'GY'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'HTI' then 'HT'
    when alfa_3_country_code = 'HMD' then 'HM'
    when alfa_3_country_code = 'VAT' then 'VA'
    when alfa_3_country_code = 'HND' then 'HN'
    when alfa_3_country_code = 'HUN' then 'HU'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'ISL' then 'IS'
    when alfa_3_country_code = 'IND' then 'IN'
    when alfa_3_country_code = 'IDN' then 'ID'
    when alfa_3_country_code = 'IRN' then 'IR'
    when alfa_3_country_code = 'IRQ' then 'IQ'
    when alfa_3_country_code = 'IRL' then 'IE'
    when alfa_3_country_code = 'IMN' then 'IM'
    when alfa_3_country_code = 'ISR' then 'IL'
    when alfa_3_country_code = 'ITA' then 'IT'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'JAM' then 'JM'
    when alfa_3_country_code = 'JPN' then 'JP'
    when alfa_3_country_code = 'JEY' then 'JE'
    when alfa_3_country_code = 'JOR' then 'JO'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'KAZ' then 'KZ'
    when alfa_3_country_code = 'KEN' then 'KE'
    when alfa_3_country_code = 'KIR' then 'KI'
    when alfa_3_country_code = 'PRK' then 'KP'
    when alfa_3_country_code = 'KOR' then 'KR'
    when alfa_3_country_code = 'KWT' then 'KW'
    when alfa_3_country_code = 'KGZ' then 'KG'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'LAO' then 'LA'
    when alfa_3_country_code = 'LVA' then 'LV'
    when alfa_3_country_code = 'LBN' then 'LB'
    when alfa_3_country_code = 'LSO' then 'LS'
    when alfa_3_country_code = 'LBR' then 'LR'
    when alfa_3_country_code = 'LBY' then 'LY'
    when alfa_3_country_code = 'LIE' then 'LI'
    when alfa_3_country_code = 'LTU' then 'LT'
    when alfa_3_country_code = 'LUX' then 'LU'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'MKD' then 'MK'
    when alfa_3_country_code = 'MDG' then 'MG'
    when alfa_3_country_code = 'MWI' then 'MW'
    when alfa_3_country_code = 'MYS' then 'MY'
    when alfa_3_country_code = 'MDV' then 'MV'
    when alfa_3_country_code = 'MLI' then 'ML'
    when alfa_3_country_code = 'MLT' then 'MT'
    when alfa_3_country_code = 'MHL' then 'MH'
    when alfa_3_country_code = 'MTQ' then 'MQ'
    when alfa_3_country_code = 'MRT' then 'MR'
    when alfa_3_country_code = 'MUS' then 'MU'
    when alfa_3_country_code = 'MYT' then 'YT'
    when alfa_3_country_code = 'MEX' then 'MX'
    when alfa_3_country_code = 'FSM' then 'FM'
    when alfa_3_country_code = 'MDA' then 'MD'
    when alfa_3_country_code = 'MCO' then 'MC'
    when alfa_3_country_code = 'MNG' then 'MN'
    when alfa_3_country_code = 'MNE' then 'ME'
    when alfa_3_country_code = 'MSR' then 'MS'
    when alfa_3_country_code = 'MAR' then 'MA'
    when alfa_3_country_code = 'MOZ' then 'MZ'
    when alfa_3_country_code = 'MMR' then 'MM'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'NAM' then 'NA'
    when alfa_3_country_code = 'NRU' then 'NR'
    when alfa_3_country_code = 'NPL' then 'NP'
    when alfa_3_country_code = 'NLD' then 'NL'
    when alfa_3_country_code = 'ANT' then 'AN'
    when alfa_3_country_code = 'NCL' then 'NC'
    when alfa_3_country_code = 'NZL' then 'NZ'
    when alfa_3_country_code = 'NIC' then 'NI'
    when alfa_3_country_code = 'NER' then 'NE'
    when alfa_3_country_code = 'NGA' then 'NG'
    when alfa_3_country_code = 'NIU' then 'NU'
    when alfa_3_country_code = 'NFK' then 'NF'
    when alfa_3_country_code = 'MNP' then 'MP'
    when alfa_3_country_code = 'NOR' then 'NO'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'OMN' then 'OM'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'PAK' then 'PK'
    when alfa_3_country_code = 'PLW' then 'PW'
    when alfa_3_country_code = 'PSE' then 'PS'
    when alfa_3_country_code = 'PAN' then 'PA'
    when alfa_3_country_code = 'PNG' then 'PG'
    when alfa_3_country_code = 'PRY' then 'PY'
    when alfa_3_country_code = 'PER' then 'PE'
    when alfa_3_country_code = 'PHL' then 'PH'
    when alfa_3_country_code = 'PCN' then 'PN'
    when alfa_3_country_code = 'POL' then 'PL'
    when alfa_3_country_code = 'PRT' then 'PT'
    when alfa_3_country_code = 'PRI' then 'PR'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'QAT' then 'QA'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'REU' then 'RE'
    when alfa_3_country_code = 'ROU' then 'RO'
    when alfa_3_country_code = 'RUS' then 'RU'
    when alfa_3_country_code = 'RWA' then 'RW'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'BLM' then 'BL'
    when alfa_3_country_code = 'SHN' then 'SH'
    when alfa_3_country_code = 'KNA' then 'KN'
    when alfa_3_country_code = 'LCA' then 'LC'
    when alfa_3_country_code = 'MAF' then 'MF'
    when alfa_3_country_code = 'SPM' then 'PM'
    when alfa_3_country_code = 'VCT' then 'VC'
    when alfa_3_country_code = 'WSM' then 'WS'
    when alfa_3_country_code = 'SMR' then 'SM'
    when alfa_3_country_code = 'STP' then 'ST'
    when alfa_3_country_code = 'SAU' then 'SA'
    when alfa_3_country_code = 'SEN' then 'SN'
    when alfa_3_country_code = 'SRB' then 'RS'
    when alfa_3_country_code = 'SYC' then 'SC'
    when alfa_3_country_code = 'SLE' then 'SL'
    when alfa_3_country_code = 'SGP' then 'SG'
    when alfa_3_country_code = 'SVK' then 'SK'
    when alfa_3_country_code = 'SVN' then 'SI'
    when alfa_3_country_code = 'SLB' then 'SB'
    when alfa_3_country_code = 'SOM' then 'SO'
    when alfa_3_country_code = 'ZAF' then 'ZA'
    when alfa_3_country_code = 'SGS' then 'GS'
    when alfa_3_country_code = 'SSD' then 'SS'
    when alfa_3_country_code = 'ESP' then 'ES'
    when alfa_3_country_code = 'LKA' then 'LK'
    when alfa_3_country_code = 'SDN' then 'SD'
    when alfa_3_country_code = 'SUR' then 'SR'
    when alfa_3_country_code = 'SJM' then 'SJ'
    when alfa_3_country_code = 'SWZ' then 'SZ'
    when alfa_3_country_code = 'SWE' then 'SE'
    when alfa_3_country_code = 'CHE' then 'CH'
    when alfa_3_country_code = 'SYR' then 'SY'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'TWN' then 'TW'
    when alfa_3_country_code = 'TJK' then 'TJ'
    when alfa_3_country_code = 'TZA' then 'TZ'
    when alfa_3_country_code = 'THA' then 'TH'
    when alfa_3_country_code = 'TLS' then 'TL'
    when alfa_3_country_code = 'TGO' then 'TG'
    when alfa_3_country_code = 'TKL' then 'TK'
    when alfa_3_country_code = 'TON' then 'TO'
    when alfa_3_country_code = 'TTO' then 'TT'
    when alfa_3_country_code = 'TUN' then 'TN'
    when alfa_3_country_code = 'TUR' then 'TR'
    when alfa_3_country_code = 'TKM' then 'TM'
    when alfa_3_country_code = 'TCA' then 'TC'
    when alfa_3_country_code = 'TUV' then 'TV'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'UGA' then 'UG'
    when alfa_3_country_code = 'UKR' then 'UA'
    when alfa_3_country_code = 'ARE' then 'AE'
    when alfa_3_country_code = 'GBR' then 'GB'
    when alfa_3_country_code = 'USA' then 'US'
    when alfa_3_country_code = 'UMI' then 'UM'
    when alfa_3_country_code = 'URY' then 'UY'
    when alfa_3_country_code = 'UZB' then 'UZ'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'VUT' then 'VU'
    when alfa_3_country_code = 'VEN' then 'VE'
    when alfa_3_country_code = 'VNM' then 'VN'
    when alfa_3_country_code = 'VIR' then 'VI'
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = '' then ''
    when alfa_3_country_code = 'WLF' then 'WF'
    when alfa_3_country_code = 'ESH' then 'EH'


  else alfa_3_country_code

  end
  "
}

###################################################################
## Adhoc - Map Level Serial To a Level Bucket
## 2024/01/01
##    - This is part of a churn analysis by level bucket
##    - Mapping levels into buckets to estimate what the churn should be in each bucket
##    - https://docs.google.com/spreadsheets/d/1mAFJMFrugs1DgPvwS1T_byTCAGHMXlVNliqLQSekn60/edit?usp=drive_link
###################################################################

constant: adhoc_level_buckets_for_churn_analysis_50th_pct {
  value: "
  case

when ${TABLE}.level_serial between 1 and 9 then 'bucket_0001_0009'
when ${TABLE}.level_serial between 9 and 43 then 'bucket_0009_0043'
when ${TABLE}.level_serial between 43 and 65 then 'bucket_0043_0065'
when ${TABLE}.level_serial between 65 and 84 then 'bucket_0065_0084'
when ${TABLE}.level_serial between 84 and 103 then 'bucket_0084_0103'
when ${TABLE}.level_serial between 103 and 122 then 'bucket_0103_0122'
when ${TABLE}.level_serial between 122 and 135 then 'bucket_0122_0135'
when ${TABLE}.level_serial between 135 and 152 then 'bucket_0135_0152'
when ${TABLE}.level_serial between 152 and 162 then 'bucket_0152_0162'
when ${TABLE}.level_serial between 162 and 179 then 'bucket_0162_0179'
when ${TABLE}.level_serial between 179 and 190 then 'bucket_0179_0190'
when ${TABLE}.level_serial between 190 and 204 then 'bucket_0190_0204'
when ${TABLE}.level_serial between 204 and 217 then 'bucket_0204_0217'
when ${TABLE}.level_serial between 217 and 224 then 'bucket_0217_0224'
when ${TABLE}.level_serial between 224 and 234 then 'bucket_0224_0234'
when ${TABLE}.level_serial between 234 and 254 then 'bucket_0234_0254'
when ${TABLE}.level_serial between 254 and 265 then 'bucket_0254_0265'
when ${TABLE}.level_serial between 265 and 276 then 'bucket_0265_0276'
when ${TABLE}.level_serial between 276 and 281 then 'bucket_0276_0281'
when ${TABLE}.level_serial between 281 and 291 then 'bucket_0281_0291'
when ${TABLE}.level_serial between 291 and 296 then 'bucket_0291_0296'
when ${TABLE}.level_serial between 296 and 308 then 'bucket_0296_0308'
when ${TABLE}.level_serial between 308 and 313 then 'bucket_0308_0313'
when ${TABLE}.level_serial between 313 and 321 then 'bucket_0313_0321'
when ${TABLE}.level_serial between 321 and 343 then 'bucket_0321_0343'
when ${TABLE}.level_serial between 343 and 349 then 'bucket_0343_0349'
when ${TABLE}.level_serial between 349 and 352 then 'bucket_0349_0352'
when ${TABLE}.level_serial between 352 and 363 then 'bucket_0352_0363'
when ${TABLE}.level_serial between 363 and 371 then 'bucket_0363_0371'
when ${TABLE}.level_serial between 371 and 382 then 'bucket_0371_0382'
when ${TABLE}.level_serial between 382 and 386 then 'bucket_0382_0386'
when ${TABLE}.level_serial between 386 and 410 then 'bucket_0386_0410'
when ${TABLE}.level_serial between 410 and 410 then 'bucket_0410_0410'
when ${TABLE}.level_serial between 410 and 410 then 'bucket_0410_0410'
when ${TABLE}.level_serial between 410 and 419 then 'bucket_0410_0419'
when ${TABLE}.level_serial between 419 and 426 then 'bucket_0419_0426'
when ${TABLE}.level_serial between 426 and 430 then 'bucket_0426_0430'
when ${TABLE}.level_serial between 430 and 441 then 'bucket_0430_0441'
when ${TABLE}.level_serial between 441 and 461 then 'bucket_0441_0461'
when ${TABLE}.level_serial between 461 and 491 then 'bucket_0461_0491'
when ${TABLE}.level_serial between 491 and 474 then 'bucket_0491_0474'
when ${TABLE}.level_serial between 474 and 495 then 'bucket_0474_0495'
when ${TABLE}.level_serial between 495 and 494 then 'bucket_0495_0494'
when ${TABLE}.level_serial between 494 and 509 then 'bucket_0494_0509'
when ${TABLE}.level_serial between 509 and 480 then 'bucket_0509_0480'
when ${TABLE}.level_serial between 480 and 514 then 'bucket_0480_0514'
when ${TABLE}.level_serial between 514 and 539 then 'bucket_0514_0539'
when ${TABLE}.level_serial between 539 and 550 then 'bucket_0539_0550'
when ${TABLE}.level_serial between 550 and 557 then 'bucket_0550_0557'
when ${TABLE}.level_serial between 557 and 559 then 'bucket_0557_0559'
when ${TABLE}.level_serial between 559 and 558 then 'bucket_0559_0558'
when ${TABLE}.level_serial between 558 and 588 then 'bucket_0558_0588'
when ${TABLE}.level_serial between 588 and 609 then 'bucket_0588_0609'
when ${TABLE}.level_serial between 609 and 592 then 'bucket_0609_0592'
when ${TABLE}.level_serial between 592 and 621 then 'bucket_0592_0621'
when ${TABLE}.level_serial between 621 and 621 then 'bucket_0621_0621'
when ${TABLE}.level_serial between 621 and 598 then 'bucket_0621_0598'
when ${TABLE}.level_serial between 598 and 626 then 'bucket_0598_0626'
when ${TABLE}.level_serial between 626 and 635 then 'bucket_0626_0635'
when ${TABLE}.level_serial between 635 and 634 then 'bucket_0635_0634'
when ${TABLE}.level_serial between 634 and 635 then 'bucket_0634_0635'
when ${TABLE}.level_serial between 635 and 677 then 'bucket_0635_0677'
when ${TABLE}.level_serial between 677 and 708 then 'bucket_0677_0708'
when ${TABLE}.level_serial between 708 and 646 then 'bucket_0708_0646'
when ${TABLE}.level_serial between 646 and 662 then 'bucket_0646_0662'
when ${TABLE}.level_serial between 662 and 707 then 'bucket_0662_0707'
when ${TABLE}.level_serial between 707 and 722 then 'bucket_0707_0722'
when ${TABLE}.level_serial between 722 and 717 then 'bucket_0722_0717'
when ${TABLE}.level_serial between 717 and 707 then 'bucket_0717_0707'
when ${TABLE}.level_serial between 707 and 665 then 'bucket_0707_0665'
when ${TABLE}.level_serial between 665 and 730 then 'bucket_0665_0730'
when ${TABLE}.level_serial between 730 and 712 then 'bucket_0730_0712'
when ${TABLE}.level_serial between 712 and 703 then 'bucket_0712_0703'
when ${TABLE}.level_serial between 703 and 726 then 'bucket_0703_0726'
when ${TABLE}.level_serial between 726 and 734 then 'bucket_0726_0734'
when ${TABLE}.level_serial between 734 and 735 then 'bucket_0734_0735'
when ${TABLE}.level_serial between 735 and 693 then 'bucket_0735_0693'
when ${TABLE}.level_serial between 693 and 717 then 'bucket_0693_0717'
when ${TABLE}.level_serial between 717 and 728 then 'bucket_0717_0728'
when ${TABLE}.level_serial between 728 and 755 then 'bucket_0728_0755'
when ${TABLE}.level_serial between 755 and 764 then 'bucket_0755_0764'
when ${TABLE}.level_serial between 764 and 713 then 'bucket_0764_0713'
when ${TABLE}.level_serial between 713 and 748 then 'bucket_0713_0748'
when ${TABLE}.level_serial between 748 and 759 then 'bucket_0748_0759'
when ${TABLE}.level_serial between 759 and 773 then 'bucket_0759_0773'
when ${TABLE}.level_serial between 773 and 721 then 'bucket_0773_0721'
when ${TABLE}.level_serial between 721 and 764 then 'bucket_0721_0764'
when ${TABLE}.level_serial between 764 and 764 then 'bucket_0764_0764'
when ${TABLE}.level_serial between 764 and 759 then 'bucket_0764_0759'
when ${TABLE}.level_serial between 759 and 732 then 'bucket_0759_0732'

  else 'other'

  end
  "
}

constant: adhoc_target_churn_by_level_buckets_for_churn_analysis_50th_pct {
  value: "
  case

when ${TABLE}.level_serial between 1 and 9 then 0.55
when ${TABLE}.level_serial between 9 and 43 then 0.229
when ${TABLE}.level_serial between 43 and 65 then 0.133
when ${TABLE}.level_serial between 65 and 84 then 0.116
when ${TABLE}.level_serial between 84 and 103 then 0.06
when ${TABLE}.level_serial between 103 and 122 then 0.076
when ${TABLE}.level_serial between 122 and 135 then 0.048
when ${TABLE}.level_serial between 135 and 152 then 0.077
when ${TABLE}.level_serial between 152 and 162 then 0.059
when ${TABLE}.level_serial between 162 and 179 then 0.047
when ${TABLE}.level_serial between 179 and 190 then 0.044
when ${TABLE}.level_serial between 190 and 204 then 0.029
when ${TABLE}.level_serial between 204 and 217 then 0.03
when ${TABLE}.level_serial between 217 and 224 then 0.024
when ${TABLE}.level_serial between 224 and 234 then 0.025
when ${TABLE}.level_serial between 234 and 254 then 0.026
when ${TABLE}.level_serial between 254 and 265 then 0.026
when ${TABLE}.level_serial between 265 and 276 then 0.02
when ${TABLE}.level_serial between 276 and 281 then 0.021
when ${TABLE}.level_serial between 281 and 291 then 0.021
when ${TABLE}.level_serial between 291 and 296 then 0.022
when ${TABLE}.level_serial between 296 and 308 then 0.015
when ${TABLE}.level_serial between 308 and 313 then 0.015
when ${TABLE}.level_serial between 313 and 321 then 0.023
when ${TABLE}.level_serial between 321 and 343 then 0.016
when ${TABLE}.level_serial between 343 and 349 then 0.016
when ${TABLE}.level_serial between 349 and 352 then 0.016
when ${TABLE}.level_serial between 352 and 363 then 0.008
when ${TABLE}.level_serial between 363 and 371 then 0
when ${TABLE}.level_serial between 371 and 382 then 0.016
when ${TABLE}.level_serial between 382 and 386 then 0.058
when ${TABLE}.level_serial between 386 and 410 then 0.018
when ${TABLE}.level_serial between 410 and 410 then 0.009
when ${TABLE}.level_serial between 410 and 410 then 0.009
when ${TABLE}.level_serial between 410 and 419 then 0.009
when ${TABLE}.level_serial between 419 and 426 then 0.009
when ${TABLE}.level_serial between 426 and 430 then 0
when ${TABLE}.level_serial between 430 and 441 then 0.019
when ${TABLE}.level_serial between 441 and 461 then 0.01
when ${TABLE}.level_serial between 461 and 491 then 0.029
when ${TABLE}.level_serial between 491 and 474 then 0
when ${TABLE}.level_serial between 474 and 495 then 0.01
when ${TABLE}.level_serial between 495 and 494 then 0.01
when ${TABLE}.level_serial between 494 and 509 then 0.01
when ${TABLE}.level_serial between 509 and 480 then 0.01
when ${TABLE}.level_serial between 480 and 514 then 0
when ${TABLE}.level_serial between 514 and 539 then 0.01
when ${TABLE}.level_serial between 539 and 550 then 0
when ${TABLE}.level_serial between 550 and 557 then 0.01
when ${TABLE}.level_serial between 557 and 559 then 0.011
when ${TABLE}.level_serial between 559 and 558 then 0.021
when ${TABLE}.level_serial between 558 and 588 then 0
when ${TABLE}.level_serial between 588 and 609 then 0.022
when ${TABLE}.level_serial between 609 and 592 then 0
when ${TABLE}.level_serial between 592 and 621 then 0.022
when ${TABLE}.level_serial between 621 and 621 then 0.011
when ${TABLE}.level_serial between 621 and 598 then 0
when ${TABLE}.level_serial between 598 and 626 then 0.011
when ${TABLE}.level_serial between 626 and 635 then 0.012
when ${TABLE}.level_serial between 635 and 634 then 0
when ${TABLE}.level_serial between 634 and 635 then 0.024
when ${TABLE}.level_serial between 635 and 677 then 0
when ${TABLE}.level_serial between 677 and 708 then 0
when ${TABLE}.level_serial between 708 and 646 then 0.012
when ${TABLE}.level_serial between 646 and 662 then 0.012
when ${TABLE}.level_serial between 662 and 707 then 0
when ${TABLE}.level_serial between 707 and 722 then 0
when ${TABLE}.level_serial between 722 and 717 then 0.012
when ${TABLE}.level_serial between 717 and 707 then 0.013
when ${TABLE}.level_serial between 707 and 665 then 0
when ${TABLE}.level_serial between 665 and 730 then 0
when ${TABLE}.level_serial between 730 and 712 then 0
when ${TABLE}.level_serial between 712 and 703 then 0.013
when ${TABLE}.level_serial between 703 and 726 then 0
when ${TABLE}.level_serial between 726 and 734 then 0
when ${TABLE}.level_serial between 734 and 735 then 0
when ${TABLE}.level_serial between 735 and 693 then 0.013
when ${TABLE}.level_serial between 693 and 717 then 0
when ${TABLE}.level_serial between 717 and 728 then 0
when ${TABLE}.level_serial between 728 and 755 then 0
when ${TABLE}.level_serial between 755 and 764 then 0
when ${TABLE}.level_serial between 764 and 713 then 0
when ${TABLE}.level_serial between 713 and 748 then 0.013
when ${TABLE}.level_serial between 748 and 759 then 0
when ${TABLE}.level_serial between 759 and 773 then 0
when ${TABLE}.level_serial between 773 and 721 then 0
when ${TABLE}.level_serial between 721 and 764 then 0
when ${TABLE}.level_serial between 764 and 764 then 0.013
when ${TABLE}.level_serial between 764 and 759 then 0
when ${TABLE}.level_serial between 759 and 732 then 0

  else 0

  end
  "
}

constant: adhoc_level_buckets_for_churn_analysis_75th_pct {
  value: "
  case

 when ${TABLE}.level_serial between 1 and 27 then 'bucket_0001_0027'
when ${TABLE}.level_serial between 27 and 85 then 'bucket_0027_0085'
when ${TABLE}.level_serial between 85 and 130 then 'bucket_0085_0130'
when ${TABLE}.level_serial between 130 and 167 then 'bucket_0130_0167'
when ${TABLE}.level_serial between 167 and 204 then 'bucket_0167_0204'
when ${TABLE}.level_serial between 204 and 232 then 'bucket_0204_0232'
when ${TABLE}.level_serial between 232 and 254 then 'bucket_0232_0254'
when ${TABLE}.level_serial between 254 and 276 then 'bucket_0254_0276'
when ${TABLE}.level_serial between 276 and 295 then 'bucket_0276_0295'
when ${TABLE}.level_serial between 295 and 318 then 'bucket_0295_0318'
when ${TABLE}.level_serial between 318 and 330 then 'bucket_0318_0330'
when ${TABLE}.level_serial between 330 and 349 then 'bucket_0330_0349'
when ${TABLE}.level_serial between 349 and 377 then 'bucket_0349_0377'
when ${TABLE}.level_serial between 377 and 386 then 'bucket_0377_0386'
when ${TABLE}.level_serial between 386 and 416 then 'bucket_0386_0416'
when ${TABLE}.level_serial between 416 and 437 then 'bucket_0416_0437'
when ${TABLE}.level_serial between 437 and 463 then 'bucket_0437_0463'
when ${TABLE}.level_serial between 463 and 470 then 'bucket_0463_0470'
when ${TABLE}.level_serial between 470 and 500 then 'bucket_0470_0500'
when ${TABLE}.level_serial between 500 and 510 then 'bucket_0500_0510'
when ${TABLE}.level_serial between 510 and 524 then 'bucket_0510_0524'
when ${TABLE}.level_serial between 524 and 549 then 'bucket_0524_0549'
when ${TABLE}.level_serial between 549 and 576 then 'bucket_0549_0576'
when ${TABLE}.level_serial between 576 and 582 then 'bucket_0576_0582'
when ${TABLE}.level_serial between 582 and 619 then 'bucket_0582_0619'
when ${TABLE}.level_serial between 619 and 637 then 'bucket_0619_0637'
when ${TABLE}.level_serial between 637 and 646 then 'bucket_0637_0646'
when ${TABLE}.level_serial between 646 and 667 then 'bucket_0646_0667'
when ${TABLE}.level_serial between 667 and 673 then 'bucket_0667_0673'
when ${TABLE}.level_serial between 673 and 692 then 'bucket_0673_0692'
when ${TABLE}.level_serial between 692 and 697 then 'bucket_0692_0697'
when ${TABLE}.level_serial between 697 and 715 then 'bucket_0697_0715'
when ${TABLE}.level_serial between 715 and 730 then 'bucket_0715_0730'
when ${TABLE}.level_serial between 730 and 754 then 'bucket_0730_0754'
when ${TABLE}.level_serial between 754 and 759 then 'bucket_0754_0759'
when ${TABLE}.level_serial between 759 and 759 then 'bucket_0759_0759'
when ${TABLE}.level_serial between 759 and 764 then 'bucket_0759_0764'
when ${TABLE}.level_serial between 764 and 764 then 'bucket_0764_0764'
when ${TABLE}.level_serial between 764 and 774 then 'bucket_0764_0774'
when ${TABLE}.level_serial between 774 and 779 then 'bucket_0774_0779'
when ${TABLE}.level_serial between 779 and 775 then 'bucket_0779_0775'
when ${TABLE}.level_serial between 775 and 781 then 'bucket_0775_0781'
when ${TABLE}.level_serial between 781 and 784 then 'bucket_0781_0784'
when ${TABLE}.level_serial between 784 and 791 then 'bucket_0784_0791'
when ${TABLE}.level_serial between 791 and 789 then 'bucket_0791_0789'
when ${TABLE}.level_serial between 789 and 794 then 'bucket_0789_0794'
when ${TABLE}.level_serial between 794 and 794 then 'bucket_0794_0794'
when ${TABLE}.level_serial between 794 and 799 then 'bucket_0794_0799'
when ${TABLE}.level_serial between 799 and 801 then 'bucket_0799_0801'
when ${TABLE}.level_serial between 801 and 799 then 'bucket_0801_0799'
when ${TABLE}.level_serial between 799 and 803 then 'bucket_0799_0803'
when ${TABLE}.level_serial between 803 and 804 then 'bucket_0803_0804'
when ${TABLE}.level_serial between 804 and 809 then 'bucket_0804_0809'
when ${TABLE}.level_serial between 809 and 810 then 'bucket_0809_0810'
when ${TABLE}.level_serial between 810 and 811 then 'bucket_0810_0811'
when ${TABLE}.level_serial between 811 and 813 then 'bucket_0811_0813'
when ${TABLE}.level_serial between 813 and 814 then 'bucket_0813_0814'
when ${TABLE}.level_serial between 814 and 814 then 'bucket_0814_0814'
when ${TABLE}.level_serial between 814 and 818 then 'bucket_0814_0818'
when ${TABLE}.level_serial between 818 and 819 then 'bucket_0818_0819'
when ${TABLE}.level_serial between 819 and 819 then 'bucket_0819_0819'
when ${TABLE}.level_serial between 819 and 824 then 'bucket_0819_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 814 then 'bucket_0824_0814'
when ${TABLE}.level_serial between 814 and 818 then 'bucket_0814_0818'
when ${TABLE}.level_serial between 818 and 824 then 'bucket_0818_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 827 then 'bucket_0824_0827'
when ${TABLE}.level_serial between 827 and 824 then 'bucket_0827_0824'
when ${TABLE}.level_serial between 824 and 819 then 'bucket_0824_0819'
when ${TABLE}.level_serial between 819 and 824 then 'bucket_0819_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 821 then 'bucket_0824_0821'
when ${TABLE}.level_serial between 821 and 824 then 'bucket_0821_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 829 then 'bucket_0824_0829'
when ${TABLE}.level_serial between 829 and 825 then 'bucket_0829_0825'
when ${TABLE}.level_serial between 825 and 824 then 'bucket_0825_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 833 then 'bucket_0824_0833'
when ${TABLE}.level_serial between 833 and 824 then 'bucket_0833_0824'
when ${TABLE}.level_serial between 824 and 824 then 'bucket_0824_0824'
when ${TABLE}.level_serial between 824 and 829 then 'bucket_0824_0829'
when ${TABLE}.level_serial between 829 and 828 then 'bucket_0829_0828'
when ${TABLE}.level_serial between 828 and 824 then 'bucket_0828_0824'

  else 'other'

  end
  "
}

constant: adhoc_target_churn_by_level_buckets_for_churn_analysis_75th_pct {
  value: "
  case

  when ${TABLE}.level_serial between 1 and 27 then 0.55
when ${TABLE}.level_serial between 27 and 85 then 0.229
when ${TABLE}.level_serial between 85 and 130 then 0.133
when ${TABLE}.level_serial between 130 and 167 then 0.116
when ${TABLE}.level_serial between 167 and 204 then 0.06
when ${TABLE}.level_serial between 204 and 232 then 0.076
when ${TABLE}.level_serial between 232 and 254 then 0.048
when ${TABLE}.level_serial between 254 and 276 then 0.077
when ${TABLE}.level_serial between 276 and 295 then 0.059
when ${TABLE}.level_serial between 295 and 318 then 0.047
when ${TABLE}.level_serial between 318 and 330 then 0.044
when ${TABLE}.level_serial between 330 and 349 then 0.029
when ${TABLE}.level_serial between 349 and 377 then 0.03
when ${TABLE}.level_serial between 377 and 386 then 0.024
when ${TABLE}.level_serial between 386 and 416 then 0.025
when ${TABLE}.level_serial between 416 and 437 then 0.026
when ${TABLE}.level_serial between 437 and 463 then 0.026
when ${TABLE}.level_serial between 463 and 470 then 0.02
when ${TABLE}.level_serial between 470 and 500 then 0.021
when ${TABLE}.level_serial between 500 and 510 then 0.021
when ${TABLE}.level_serial between 510 and 524 then 0.022
when ${TABLE}.level_serial between 524 and 549 then 0.015
when ${TABLE}.level_serial between 549 and 576 then 0.015
when ${TABLE}.level_serial between 576 and 582 then 0.023
when ${TABLE}.level_serial between 582 and 619 then 0.016
when ${TABLE}.level_serial between 619 and 637 then 0.016
when ${TABLE}.level_serial between 637 and 646 then 0.016
when ${TABLE}.level_serial between 646 and 667 then 0.008
when ${TABLE}.level_serial between 667 and 673 then 0
when ${TABLE}.level_serial between 673 and 692 then 0.016
when ${TABLE}.level_serial between 692 and 697 then 0.058
when ${TABLE}.level_serial between 697 and 715 then 0.018
when ${TABLE}.level_serial between 715 and 730 then 0.009
when ${TABLE}.level_serial between 730 and 754 then 0.009
when ${TABLE}.level_serial between 754 and 759 then 0.009
when ${TABLE}.level_serial between 759 and 759 then 0.009
when ${TABLE}.level_serial between 759 and 764 then 0
when ${TABLE}.level_serial between 764 and 764 then 0.019
when ${TABLE}.level_serial between 764 and 774 then 0.01
when ${TABLE}.level_serial between 774 and 779 then 0.029
when ${TABLE}.level_serial between 779 and 775 then 0
when ${TABLE}.level_serial between 775 and 781 then 0.01
when ${TABLE}.level_serial between 781 and 784 then 0.01
when ${TABLE}.level_serial between 784 and 791 then 0.01
when ${TABLE}.level_serial between 791 and 789 then 0.01
when ${TABLE}.level_serial between 789 and 794 then 0
when ${TABLE}.level_serial between 794 and 794 then 0.01
when ${TABLE}.level_serial between 794 and 799 then 0
when ${TABLE}.level_serial between 799 and 801 then 0.01
when ${TABLE}.level_serial between 801 and 799 then 0.011
when ${TABLE}.level_serial between 799 and 803 then 0.021
when ${TABLE}.level_serial between 803 and 804 then 0
when ${TABLE}.level_serial between 804 and 809 then 0.022
when ${TABLE}.level_serial between 809 and 810 then 0
when ${TABLE}.level_serial between 810 and 811 then 0.022
when ${TABLE}.level_serial between 811 and 813 then 0.011
when ${TABLE}.level_serial between 813 and 814 then 0
when ${TABLE}.level_serial between 814 and 814 then 0.011
when ${TABLE}.level_serial between 814 and 818 then 0.012
when ${TABLE}.level_serial between 818 and 819 then 0
when ${TABLE}.level_serial between 819 and 819 then 0.024
when ${TABLE}.level_serial between 819 and 824 then 0
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 814 then 0.012
when ${TABLE}.level_serial between 814 and 818 then 0.012
when ${TABLE}.level_serial between 818 and 824 then 0
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 827 then 0.012
when ${TABLE}.level_serial between 827 and 824 then 0.013
when ${TABLE}.level_serial between 824 and 819 then 0
when ${TABLE}.level_serial between 819 and 824 then 0
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 824 then 0.013
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 821 then 0
when ${TABLE}.level_serial between 821 and 824 then 0
when ${TABLE}.level_serial between 824 and 824 then 0.013
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 829 then 0
when ${TABLE}.level_serial between 829 and 825 then 0
when ${TABLE}.level_serial between 825 and 824 then 0.013
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 833 then 0
when ${TABLE}.level_serial between 833 and 824 then 0
when ${TABLE}.level_serial between 824 and 824 then 0
when ${TABLE}.level_serial between 824 and 829 then 0.013
when ${TABLE}.level_serial between 829 and 828 then 0
when ${TABLE}.level_serial between 828 and 824 then 0

  else 0

  end
  "
}

###################################################################
# Puzzle Piece # Mapping by Date
###################################################################

## Spreadsheet here
## https://docs.google.com/spreadsheets/d/1j44GjJdNNn6bNXDDp4y_3HgKxZ7QXOMH__UI9jibyAM/edit?usp=sharing

constant: puzzle_piece_number_mapping_by_date {
  value: "
    case
      when date(${TABLE}.rdg_date) between '2023-09-27' and '2023-10-03' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-10-04' and '2023-10-10' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-10-11' and '2023-10-17' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-10-18' and '2023-10-24' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-10-25' and '2023-10-31' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-11-01' and '2023-11-07' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-11-08' and '2023-11-14' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-11-15' and '2023-11-21' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-11-22' and '2023-11-28' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-11-29' and '2023-12-05' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-12-06' and '2023-12-12' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-12-13' and '2023-12-19' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-12-20' and '2023-12-26' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2023-12-27' and '2024-01-02' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-01-03' and '2024-01-09' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-01-10' and '2024-01-16' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-01-17' and '2024-01-23' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-01-24' and '2024-01-30' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-01-31' and '2024-02-06' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-02-07' and '2024-02-13' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-02-14' and '2024-02-20' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-02-21' and '2024-02-27' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-02-28' and '2024-03-05' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-03-06' and '2024-03-12' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-03-13' and '2024-03-19' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-03-20' and '2024-03-26' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-03-27' and '2024-04-02' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-04-03' and '2024-04-09' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-04-10' and '2024-04-16' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-04-17' and '2024-04-23' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-04-24' and '2024-04-30' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-05-01' and '2024-05-07' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-05-08' and '2024-05-14' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-05-15' and '2024-05-21' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-05-22' and '2024-05-28' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-05-29' and '2024-06-04' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-06-05' and '2024-06-11' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-06-12' and '2024-06-18' then '25 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-06-19' and '2024-06-25' then '36 Piece Puzzle'
      when date(${TABLE}.rdg_date) between '2024-06-26' and '2024-07-02' then '25 Piece Puzzle'
    end"
}

constant: puzzle_piece_number_mapping_start_date {
  value: "
  case
    when date(${TABLE}.rdg_date) between '2023-09-27' and '2023-10-03' then '2023-09-27'
    when date(${TABLE}.rdg_date) between '2023-10-04' and '2023-10-10' then '2023-10-04'
    when date(${TABLE}.rdg_date) between '2023-10-11' and '2023-10-17' then '2023-10-11'
    when date(${TABLE}.rdg_date) between '2023-10-18' and '2023-10-24' then '2023-10-18'
    when date(${TABLE}.rdg_date) between '2023-10-25' and '2023-10-31' then '2023-10-25'
    when date(${TABLE}.rdg_date) between '2023-11-01' and '2023-11-07' then '2023-11-01'
    when date(${TABLE}.rdg_date) between '2023-11-08' and '2023-11-14' then '2023-11-08'
    when date(${TABLE}.rdg_date) between '2023-11-15' and '2023-11-21' then '2023-11-15'
    when date(${TABLE}.rdg_date) between '2023-11-22' and '2023-11-28' then '2023-11-22'
    when date(${TABLE}.rdg_date) between '2023-11-29' and '2023-12-05' then '2023-11-29'
    when date(${TABLE}.rdg_date) between '2023-12-06' and '2023-12-12' then '2023-12-06'
    when date(${TABLE}.rdg_date) between '2023-12-13' and '2023-12-19' then '2023-12-13'
    when date(${TABLE}.rdg_date) between '2023-12-20' and '2023-12-26' then '2023-12-20'
    when date(${TABLE}.rdg_date) between '2023-12-27' and '2024-01-02' then '2023-12-27'
    when date(${TABLE}.rdg_date) between '2024-01-03' and '2024-01-09' then '2024-01-03'
    when date(${TABLE}.rdg_date) between '2024-01-10' and '2024-01-16' then '2024-01-10'
    when date(${TABLE}.rdg_date) between '2024-01-17' and '2024-01-23' then '2024-01-17'
    when date(${TABLE}.rdg_date) between '2024-01-24' and '2024-01-30' then '2024-01-24'
    when date(${TABLE}.rdg_date) between '2024-01-31' and '2024-02-06' then '2024-01-31'
    when date(${TABLE}.rdg_date) between '2024-02-07' and '2024-02-13' then '2024-02-07'
    when date(${TABLE}.rdg_date) between '2024-02-14' and '2024-02-20' then '2024-02-14'
    when date(${TABLE}.rdg_date) between '2024-02-21' and '2024-02-27' then '2024-02-21'
    when date(${TABLE}.rdg_date) between '2024-02-28' and '2024-03-05' then '2024-02-28'
    when date(${TABLE}.rdg_date) between '2024-03-06' and '2024-03-12' then '2024-03-06'
    when date(${TABLE}.rdg_date) between '2024-03-13' and '2024-03-19' then '2024-03-13'
    when date(${TABLE}.rdg_date) between '2024-03-20' and '2024-03-26' then '2024-03-20'
    when date(${TABLE}.rdg_date) between '2024-03-27' and '2024-04-02' then '2024-03-27'
    when date(${TABLE}.rdg_date) between '2024-04-03' and '2024-04-09' then '2024-04-03'
    when date(${TABLE}.rdg_date) between '2024-04-10' and '2024-04-16' then '2024-04-10'
    when date(${TABLE}.rdg_date) between '2024-04-17' and '2024-04-23' then '2024-04-17'
    when date(${TABLE}.rdg_date) between '2024-04-24' and '2024-04-30' then '2024-04-24'
    when date(${TABLE}.rdg_date) between '2024-05-01' and '2024-05-07' then '2024-05-01'
    when date(${TABLE}.rdg_date) between '2024-05-08' and '2024-05-14' then '2024-05-08'
    when date(${TABLE}.rdg_date) between '2024-05-15' and '2024-05-21' then '2024-05-15'
    when date(${TABLE}.rdg_date) between '2024-05-22' and '2024-05-28' then '2024-05-22'
    when date(${TABLE}.rdg_date) between '2024-05-29' and '2024-06-04' then '2024-05-29'
    when date(${TABLE}.rdg_date) between '2024-06-05' and '2024-06-11' then '2024-06-05'
    when date(${TABLE}.rdg_date) between '2024-06-12' and '2024-06-18' then '2024-06-12'
    when date(${TABLE}.rdg_date) between '2024-06-19' and '2024-06-25' then '2024-06-19'
    when date(${TABLE}.rdg_date) between '2024-06-26' and '2024-07-02' then '2024-06-26'
  end"
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
