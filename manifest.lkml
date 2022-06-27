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
          when ${TABLE}.platform like '%iOS 14%' THEN 'iOS 14'
          when ${TABLE}.platform like '%iOS 13%' THEN 'iOS 13'
          when ${TABLE}.platform like '%iOS 12%' THEN 'iOS 12'
          when ${TABLE}.platform like '%iOS 11%' THEN 'iOS 11'
          when ${TABLE}.platform like '%iOS 10%' THEN 'iOS 10'
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

constant: device_internal_tester_mapping {
  value: "('596c5959-d64b-4b9a-92e2-02ac0da551db'
            ,'052c6660-1668-40bc-938e-b35472d61d28'
            ,'d766305b-e03b-433c-abe2-78fa6d4f827d'
            ,'617c0432-a178-476c-b394-68abe694b54e'
            ,'7322ecb2-2b37-4308-8489-16296bf0a76a'
            ,'3c562719-a555-4989-a3ce-d1e6544eb8f8')"
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
            ,'b045fdff-9f95-4c95-9421-5f676c11df13'
            ,'f95ac130-e521-4538-8497-4c39abc78a14'
            ,'e1c576c2-e424-40f2-bad9-33e1d0e0c172'
            ,'12e6ee11-5190-418f-88bd-c61c5206025f'
            ,'d85e4635-c0a7-450c-999f-c2220154e351'
            ,'b3be97cd-f7f7-4c9e-aa47-1a0ad2ec4361'
            ,'8282a558-f3ad-4b47-bee4-8b22e682d258'
            ,'9c9ad2ed-5356-4926-91a3-831c92a3204e'
            ,'8587a16b-6e14-445b-9bd6-901c86a49585'
            ,'577347e2-ae91-4d81-9868-a48398a80986'
            ,'022c5eec-1bc7-40d8-aa57-04407097d3cb'
            ,'616c50be-c5f4-4d82-b5df-6e13e3443917'
            ,'31df8aae-d7ff-49b4-8a37-025807e79f35'
            ,'aff247e5-3268-424b-9fa7-fc7a31e25cfb'
            ,'96656ebf-7125-48d5-8ea9-337724173c1a'
            ,'054bf199-3fd3-4be0-a53b-62256d15d077'
            ,'a0dce422-3e68-47a3-a475-fc2fe7ed295a'
            ,'766fc669-8ce4-470f-abfe-0ef1f609a0aa'
            ,'7ad84723-eca2-4343-988a-a3e5bbd3e499'
            ,'21b7b19b-1ee9-4091-b144-70a32ca9a0bc'
            ,'3a8ea274-debc-46c5-81b1-c8315740db25'
            ,'5af24a60-6a50-467a-8f26-073384fc0ec9')"
}
constant: cheaters {
  value: "('')"
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
            when ${TABLE}.version = '10100' then '1.10.100'
            when ${TABLE}.version = '10200' then '1.10.200'
            when ${TABLE}.version = '10300' then '1.10.300'
            when ${TABLE}.version = '10400' then '1.10.400'
            when ${TABLE}.version = '10500' then '1.10.500'
            when ${TABLE}.version = '10600' then '1.10.600'
            when ${TABLE}.version = '10700' then '1.10.700'
            when ${TABLE}.version = '10800' then '1.10.800'
            when ${TABLE}.version = '10900' then '1.10.900'
            when ${TABLE}.version = '10950' then '1.10.950'
            when ${TABLE}.version = '11100' then '1.11.100'
            when ${TABLE}.version = '11200' then '1.11.200'
            when ${TABLE}.version = '11300' then '1.11.300'
            when ${TABLE}.version = '11400' then '1.11.400'
            when ${TABLE}.version = '11500' then '1.11.500'
            when ${TABLE}.version = '11600' then '1.11.600'
            when ${TABLE}.version = '11700' then '1.11.700'
            when ${TABLE}.version = '11800' then '1.11.800'
            when ${TABLE}.version = '11850' then '1.11.850'
            when ${TABLE}.version = '11860' then '1.11.860'
            when ${TABLE}.version = '11870' then '1.11.870'
            when ${TABLE}.version = '12100' then '1.12.100'
            when ${TABLE}.version = '12200' then '1.12.200'
            when ${TABLE}.version = '12300' then '1.12.300'
            when ${TABLE}.version = '12400' then '1.12.400'
            when ${TABLE}.version = '12500' then '1.12.500'
            when ${TABLE}.version = '12612' then '1.12.600'
            when ${TABLE}.version = '12700' then '1.12.700'
            when ${TABLE}.version = '12840' then '1.12.840'
            when ${TABLE}.version = '12850' then '1.12.850'
            when ${TABLE}.version = '12860' then '1.12.860'
            when ${TABLE}.version = '12870' then '1.12.870'
            when ${TABLE}.version = '12906' then '1.12.906'
          end"
}

constant: install_release_version_minor {
  value: "case
            when ${TABLE}.install_version = '1579' then '1.0.100'
            when ${TABLE}.install_version = '2047' then '1.1.001'
            when ${TABLE}.install_version = '2100' then '1.1.100'
            when ${TABLE}.install_version = '3028' then '1.2.028'
            when ${TABLE}.install_version = '3043' then '1.2.043'
            when ${TABLE}.install_version = '3100' then '1.2.100'
            when ${TABLE}.install_version = '4017' then '1.3.017'
            when ${TABLE}.install_version = '4100' then '1.3.100'
            when ${TABLE}.install_version = '5006' then '1.5.006'
            when ${TABLE}.install_version = '5100' then '1.5.100'
            when ${TABLE}.install_version = '6100' then '1.6.100'
            when ${TABLE}.install_version = '6200' then '1.6.200'
            when ${TABLE}.install_version = '6300' then '1.6.300'
            when ${TABLE}.install_version = '6400' then '1.6.400'
            when ${TABLE}.install_version = '7100' then '1.7.100'
            when ${TABLE}.install_version = '7200' then '1.7.200'
            when ${TABLE}.install_version = '7300' then '1.7.300'
            when ${TABLE}.install_version = '7400' then '1.7.400'
            when ${TABLE}.install_version = '7500' then '1.7.500'
            when ${TABLE}.install_version = '7600' then '1.7.600'
            when ${TABLE}.install_version = '8000' then '1.8.000'
            when ${TABLE}.install_version = '8100' then '1.8.100'
            when ${TABLE}.install_version = '8200' then '1.8.200'
            when ${TABLE}.install_version = '8300' then '1.8.300'
            when ${TABLE}.install_version = '8400' then '1.8.400'
            when ${TABLE}.install_version = '9100' then '1.9.100'
            when ${TABLE}.install_version = '9200' then '1.9.200'
            when ${TABLE}.install_version = '9300' then '1.9.300'
            when ${TABLE}.install_version = '9400' then '1.9.400'
            when ${TABLE}.install_version = '9500' then '1.9.500'
            when ${TABLE}.install_version = '10100' then '1.10.100'
            when ${TABLE}.install_version = '10200' then '1.10.200'
            when ${TABLE}.install_version = '10300' then '1.10.300'
            when ${TABLE}.install_version = '10400' then '1.10.400'
            when ${TABLE}.install_version = '10500' then '1.10.500'
            when ${TABLE}.install_version = '10600' then '1.10.600'
            when ${TABLE}.install_version = '10700' then '1.10.700'
            when ${TABLE}.install_version = '10800' then '1.10.800'
            when ${TABLE}.install_version = '10900' then '1.10.900'
            when ${TABLE}.install_version = '10950' then '1.10.950'
            when ${TABLE}.install_version = '11100' then '1.11.100'
            when ${TABLE}.install_version = '11200' then '1.11.200'
            when ${TABLE}.install_version = '11300' then '1.11.300'
            when ${TABLE}.install_version = '11400' then '1.11.400'
            when ${TABLE}.install_version = '11500' then '1.11.500'
            when ${TABLE}.install_version = '11600' then '1.11.600'
            when ${TABLE}.install_version = '11700' then '1.11.700'
            when ${TABLE}.install_version = '11800' then '1.11.800'
            when ${TABLE}.install_version = '11850' then '1.11.850'
            when ${TABLE}.install_version = '11860' then '1.11.860'
            when ${TABLE}.install_version = '11870' then '1.11.870'
            when ${TABLE}.install_version = '12100' then '1.12.100'
            when ${TABLE}.install_version = '12200' then '1.12.200'
            when ${TABLE}.install_version = '12300' then '1.12.300'
            when ${TABLE}.install_version = '12400' then '1.12.400'
            when ${TABLE}.install_version = '12500' then '1.12.500'
            when ${TABLE}.install_version = '12612' then '1.12.600'
            when ${TABLE}.install_version = '12700' then '1.12.700'
            when ${TABLE}.install_version = '12840' then '1.12.840'
            when ${TABLE}.install_version = '12850' then '1.12.850'
            when ${TABLE}.install_version = '12860' then '1.12.860'
            when ${TABLE}.install_version = '12870' then '1.12.870'
            when ${TABLE}.install_version = '12906' then '1.12.906'
          end"
}

constant: country_region {
  value: "case
            when ${TABLE}.country like 'ZZ' THEN 'N/A'
            when ${TABLE}.country IN ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE') THEN 'LATAM-ES'
            when ${TABLE}.country like 'BR' THEN 'LATAM-BR'
            when ${TABLE}.country IN ('SE', 'NO', 'DK','SE', 'NO', 'IS','FI') THEN 'Scandinavia'
            when ${TABLE}.country IN ('GB', 'IE', 'ES') THEN 'UK-EU'
            when ${TABLE}.country IN ('US', 'CA') THEN 'NA-EN'
            else 'OTHER'
          end"
}

constant: current_card_numbered_coalesced {
  value: "CASE
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_a' THEN 100
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_b' THEN 100
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_b_i' THEN 100
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_001_untimed' THEN 100
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_b' THEN 120
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_b_i' THEN 120
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_b' THEN 150
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_b_i' THEN 150
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_a' THEN 200
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_a_i' THEN 200
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_untimed' THEN 200
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_a' THEN 300
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_a_i' THEN 300
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_untimed' THEN 300
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002' THEN 400
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_i' THEN 400
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_002_inverted' THEN 400
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_039' THEN 400
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_004_untimed' THEN 400
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003' THEN 500
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_20210329' THEN 500
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_003_20210329_i' THEN 500
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_040' THEN 500
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_005_untimed' THEN 500
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_004' THEN 600
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_004_20210329' THEN 600
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_004_20210329_i' THEN 600
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_041' THEN 600
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_006_untimed' THEN 600
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_005' THEN 700
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_005_i' THEN 700
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_006' THEN 800
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_007' THEN 900
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_008' THEN 1000
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_009' THEN 1100
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_010' THEN 1200
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_011' THEN 1300
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_012' THEN 1400
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_013' THEN 1500
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_014' THEN 1600
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_015' THEN 1700
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_016' THEN 1800
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_017' THEN 1900
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_018' THEN 2000
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_019' THEN 2100
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_020' THEN 2200
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'card_021' THEN 2300
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'ce_001_card_001' then 20210601
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'ce_001_card_002' then 20210602
              when coalesce(${TABLE}.last_unlocked_card,${TABLE}.current_card) = 'ce_001_card_003' then 20210603
          END"
}

constant: current_card_numbered {
  value: "case
            when ${TABLE}.current_card = 'card_001_a' then 100
            when ${TABLE}.current_card = 'card_001_b' then 100
            when ${TABLE}.current_card = 'card_001_b_i' then 100
            when ${TABLE}.current_card = 'card_001_untimed' then 100
            when ${TABLE}.current_card = 'card_002_b' then 120
            when ${TABLE}.current_card = 'card_002_b_i' then 120
            when ${TABLE}.current_card = 'card_003_b' then 150
            when ${TABLE}.current_card = 'card_003_b_i' then 150
            when ${TABLE}.current_card = 'card_002_a' then 200
            when ${TABLE}.current_card = 'card_002_a_i' then 200
            when ${TABLE}.current_card = 'card_002_untimed' then 200
            when ${TABLE}.current_card = 'card_003_a' then 300
            when ${TABLE}.current_card = 'card_003_a_i' then 300
            when ${TABLE}.current_card = 'card_003_untimed' then 300
            when ${TABLE}.current_card = 'card_002' then 400
            when ${TABLE}.current_card = 'card_002_i' then 400
            when ${TABLE}.current_card = 'card_002_inverted' then 400
            when ${TABLE}.current_card = 'card_039' then 400
            when ${TABLE}.current_card = 'card_004_untimed' then 400
            when ${TABLE}.current_card = 'card_003' then 500
            when ${TABLE}.current_card = 'card_003_20210329' then 500
            when ${TABLE}.current_card = 'card_003_20210329_i' then 500
            when ${TABLE}.current_card = 'card_040' then 500
            when ${TABLE}.current_card = 'card_005_untimed' then 500
            when ${TABLE}.current_card = 'card_004' then 600
            when ${TABLE}.current_card = 'card_004_20210329' then 600
            when ${TABLE}.current_card = 'card_004_20210329_i' then 600
            when ${TABLE}.current_card = 'card_041' then 600
            when ${TABLE}.current_card = 'card_006_untimed' then 600
            when ${TABLE}.current_card = 'card_005' then 700
            when ${TABLE}.current_card = 'card_005_i' then 700
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
            when ${TABLE}.current_card = 'ce_004_card_001' then 20210901
            when ${TABLE}.current_card = 'ce_004_card_002' then 20210902
            when ${TABLE}.current_card = 'ce_004_card_003' then 20210903
            when ${TABLE}.current_card = 'ce_005_card_001' then 20211001
            when ${TABLE}.current_card = 'ce_005_card_002' then 20211002
            when ${TABLE}.current_card = 'ce_005_card_003' then 20211003
            when ${TABLE}.current_card = 'ce_006_card_001' then 20211001
            when ${TABLE}.current_card = 'ce_006_card_002' then 20211002
            when ${TABLE}.current_card = 'ce_006_card_003' then 20211003
            when ${TABLE}.current_card = 'ce_007_card_001' then 20212001
            when ${TABLE}.current_card = 'ce_007_card_002' then 20212002
            when ${TABLE}.current_card = 'ce_007_card_003' then 20212003
            when ${TABLE}.current_card = 'tu_001_card_001' then 30210801
            when ${TABLE}.current_card = 'tu_001_card_002' then 30210802
            when ${TABLE}.current_card = 'tu_001_card_003' then 30210803
            when ${TABLE}.current_card = 'tu_002_card_001' then 30210901
            when ${TABLE}.current_card = 'tu_002_card_002' then 30210902
            when ${TABLE}.current_card = 'tu_002_card_003' then 30210903
            when ${TABLE}.current_card = 'tu_003_card_001' then 30211001
            when ${TABLE}.current_card = 'tu_003_card_002' then 30211002
            when ${TABLE}.current_card = 'tu_003_card_003' then 30211003
            when ${TABLE}.current_card = 'tu_004_card_001' then 30211101
            when ${TABLE}.current_card = 'tu_004_card_002' then 30211102
            when ${TABLE}.current_card = 'tu_004_card_003' then 30211103
            when ${TABLE}.current_card = 'tu_005_card_001' then 30211201
            when ${TABLE}.current_card = 'tu_005_card_002' then 30211202
            when ${TABLE}.current_card = 'tu_005_card_003' then 30211203
          end"
}

constant: card_id_numbered {
    value: "case
            when ${TABLE}.card_id = 'card_001_a' then 100
            when ${TABLE}.card_id = 'card_001_b' then 100
            when ${TABLE}.card_id = 'card_001_b_i' then 100
            when ${TABLE}.card_id = 'card_001_untimed' then 100
            when ${TABLE}.card_id = 'card_002_b' then 120
            when ${TABLE}.card_id = 'card_002_b_i' then 120
            when ${TABLE}.card_id = 'card_003_b' then 150
            when ${TABLE}.card_id = 'card_003_b_i' then 150
            when ${TABLE}.card_id = 'card_002_a' then 200
            when ${TABLE}.card_id = 'card_002_a_i' then 200
            when ${TABLE}.card_id = 'card_002_untimed' then 200
            when ${TABLE}.card_id = 'card_003_a' then 300
            when ${TABLE}.card_id = 'card_003_a_i' then 300
            when ${TABLE}.card_id = 'card_003_untimed' then 300
            when ${TABLE}.card_id = 'card_002' then 400
            when ${TABLE}.card_id = 'card_002_i' then 400
            when ${TABLE}.card_id = 'card_002_inverted' then 400
            when ${TABLE}.card_id = 'card_039' then 400
            when ${TABLE}.card_id = 'card_004_untimed' then 400
            when ${TABLE}.card_id = 'card_003' then 500
            when ${TABLE}.card_id = 'card_003_20210329' then 500
            when ${TABLE}.card_id = 'card_003_20210329_i' then 500
            when ${TABLE}.card_id = 'card_040' then 500
            when ${TABLE}.card_id = 'card_005_untimed' then 500
            when ${TABLE}.card_id = 'card_004' then 600
            when ${TABLE}.card_id = 'card_004_20210329' then 600
            when ${TABLE}.card_id = 'card_004_20210329_i' then 600
            when ${TABLE}.card_id = 'card_041' then 600
            when ${TABLE}.card_id = 'card_006_untimed' then 600
            when ${TABLE}.card_id = 'card_005' then 700
            when ${TABLE}.card_id = 'card_005_i' then 700
            when ${TABLE}.card_id = 'card_006' then 800
            when ${TABLE}.card_id = 'card_007' then 900
            when ${TABLE}.card_id = 'card_008' then 1000
            when ${TABLE}.card_id = 'card_009' then 1100
            when ${TABLE}.card_id = 'card_010' then 1200
            when ${TABLE}.card_id = 'card_011' then 1300
            when ${TABLE}.card_id = 'card_012' then 1400
            when ${TABLE}.card_id = 'card_013' then 1500
            when ${TABLE}.card_id = 'card_014' then 1600
            when ${TABLE}.card_id = 'card_015' then 1700
            when ${TABLE}.card_id = 'card_016' then 1800
            when ${TABLE}.card_id = 'card_017' then 1900
            when ${TABLE}.card_id = 'card_018' then 2000
            when ${TABLE}.card_id = 'card_019' then 2100
            when ${TABLE}.card_id = 'card_020' then 2200
            when ${TABLE}.card_id = 'card_021' then 2300
            when ${TABLE}.card_id = 'ce_001_card_001' then 20210601
            when ${TABLE}.card_id = 'ce_001_card_002' then 20210602
            when ${TABLE}.card_id = 'ce_001_card_003' then 20210603
            when ${TABLE}.card_id = 'ce_002_card_001' then 20210701
            when ${TABLE}.card_id = 'ce_002_card_002' then 20210702
            when ${TABLE}.card_id = 'ce_002_card_003' then 20210703
            when ${TABLE}.card_id = 'ce_003_card_001' then 20210711
            when ${TABLE}.card_id = 'ce_003_card_002' then 20210712
            when ${TABLE}.card_id = 'ce_003_card_003' then 20210713
            when ${TABLE}.card_id = 'ce_004_card_001' then 20210901
            when ${TABLE}.card_id = 'ce_004_card_002' then 20210902
            when ${TABLE}.card_id = 'ce_004_card_003' then 20210903
            when ${TABLE}.card_id = 'ce_005_card_001' then 20211001
            when ${TABLE}.card_id = 'ce_005_card_002' then 20211002
            when ${TABLE}.card_id = 'ce_005_card_003' then 20211003
            when ${TABLE}.card_id = 'ce_006_card_001' then 20211001
            when ${TABLE}.card_id = 'ce_006_card_002' then 20211002
            when ${TABLE}.card_id = 'ce_006_card_003' then 20211003
            when ${TABLE}.card_id = 'ce_007_card_001' then 20212001
            when ${TABLE}.card_id = 'ce_007_card_002' then 20212002
            when ${TABLE}.card_id = 'ce_007_card_003' then 20212003
            when ${TABLE}.card_id = 'tu_001_card_001' then 30210801
            when ${TABLE}.card_id = 'tu_001_card_002' then 30210802
            when ${TABLE}.card_id = 'tu_001_card_003' then 30210803
            when ${TABLE}.card_id = 'tu_002_card_001' then 30210901
            when ${TABLE}.card_id = 'tu_002_card_002' then 30210902
            when ${TABLE}.card_id = 'tu_002_card_003' then 30210903
            when ${TABLE}.card_id = 'tu_003_card_001' then 30211001
            when ${TABLE}.card_id = 'tu_003_card_002' then 30211002
            when ${TABLE}.card_id = 'tu_003_card_003' then 30211003
            when ${TABLE}.card_id = 'tu_004_card_001' then 30211101
            when ${TABLE}.card_id = 'tu_004_card_002' then 30211102
            when ${TABLE}.card_id = 'tu_004_card_003' then 30211103
            when ${TABLE}.card_id = 'tu_005_card_001' then 30211201
            when ${TABLE}.card_id = 'tu_005_card_002' then 30211202
            when ${TABLE}.card_id = 'tu_005_card_003' then 30211203
          end"
}

constant: last_unlocked_card_numbered {
  value: "case
            when ${TABLE}.last_unlocked_card = 'card_001_a' then 100
            when ${TABLE}.last_unlocked_card = 'card_001_b' then 100
            when ${TABLE}.last_unlocked_card = 'card_001_b_i' then 100
            when ${TABLE}.last_unlocked_card = 'card_001_untimed' then 100
            when ${TABLE}.last_unlocked_card = 'card_002_b' then 120
            when ${TABLE}.last_unlocked_card = 'card_002_b_i' then 120
            when ${TABLE}.last_unlocked_card = 'card_003_b' then 150
            when ${TABLE}.last_unlocked_card = 'card_003_b_i' then 150
            when ${TABLE}.last_unlocked_card = 'card_002_a' then 200
            when ${TABLE}.last_unlocked_card = 'card_002_a_i' then 200
            when ${TABLE}.last_unlocked_card = 'card_002_untimed' then 200
            when ${TABLE}.last_unlocked_card = 'card_003_a' then 300
            when ${TABLE}.last_unlocked_card = 'card_003_a_i' then 300
            when ${TABLE}.last_unlocked_card = 'card_003_untimed' then 300
            when ${TABLE}.last_unlocked_card = 'card_002' then 400
            when ${TABLE}.last_unlocked_card = 'card_002_i' then 400
            when ${TABLE}.last_unlocked_card = 'card_002_inverted' then 400
            when ${TABLE}.last_unlocked_card = 'card_039' then 400
            when ${TABLE}.last_unlocked_card = 'card_004_untimed' then 400
            when ${TABLE}.last_unlocked_card = 'card_003' then 500
            when ${TABLE}.last_unlocked_card = 'card_003_20210329' then 500
            when ${TABLE}.last_unlocked_card = 'card_003_20210329_i' then 500
            when ${TABLE}.last_unlocked_card = 'card_040' then 500
            when ${TABLE}.last_unlocked_card = 'card_005_untimed' then 500
            when ${TABLE}.last_unlocked_card = 'card_004' then 600
            when ${TABLE}.last_unlocked_card = 'card_004_20210329' then 600
            when ${TABLE}.last_unlocked_card = 'card_004_20210329_i' then 600
            when ${TABLE}.last_unlocked_card = 'card_041' then 600
            when ${TABLE}.last_unlocked_card = 'card_006_untimed' then 600
            when ${TABLE}.last_unlocked_card = 'card_005' then 700
            when ${TABLE}.last_unlocked_card = 'card_005_i' then 700
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
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_001_b_i' then 100
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_b' then 120
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_b_i' then 120
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_b' then 150
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_b_i' then 150
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_a' then 200
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_a_i' then 200
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_a' then 300
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_a_i' then 300
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_untimed' then 300
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_i' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_002_inverted' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_039' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_004_untimed' then 400
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_20210329' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_003_20210329_i' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_040' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_005_untimed' then 500
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_004' then 600
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_004_20210329' then 600
      when json_extract_scalar(extra_json,'$.request_card_id') = 'card_004_20210329_i' then 600
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
              when json_extract_scalar(${TABLE}.extra_json,'$.source_id') like 'Sheet_ManageLives.QuickPurchase.%' THEN 'Lives Quick Purchase Sheet'
              when json_extract_scalar(${TABLE}.extra_json,'$.source_id') like 'Sheet_CurrencyPack.QuickPurchase.%' THEN 'Coins Quick Purchase Sheet'
              when json_extract_scalar(${TABLE}.extra_json,'$.source_id') like 'Panel_Store.Purchase.%' THEN 'Store'
              when json_extract_scalar(${TABLE}.extra_json,'$.source_id') like 'Panel_QuickPurchase.Purchase.%' THEN 'Quick Purchase'
              when json_extract_scalar(${TABLE}.extra_json,'$.source_id') like '%BuyMoreTime%' THEN 'Mini-Game'
              ELSE 'OTHER'
          END"
}

constant: purchase_iap_strings {
  value: "case
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_001%' then 'Free Ticket Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_017%' then 'Free Coin Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_018%' then 'Free Boost Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_002%' then 'Housepets Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_003%' then 'Fun Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_019%' then 'Super Fun Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_022%' then 'Jumbo Fun Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_045%' then 'Spooky Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_046%' then 'Eraser Direct Purchase - Salem'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_004%' then 'Peewee Coin Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_005%' then 'Small Coin Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_006%' then 'Medium Coin Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_007%' then 'Large Coin Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_020%' then 'Huge Coin Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_021%' then 'Jumbo Coin Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_008%' then 'Peewee Gem Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_009%' then 'Small Gem Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_010%' then 'Medium Gem Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_011%' then 'Large Gem Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_012%' then 'Huge Gem Machine'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_013%' then 'Jumbo Gem Machine'
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
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%item_037%' then 'CE 202109_a - Lives & Coins Bundle'
            when json_extract_scalar(${TABLE}.extra_json,'$.sheet_id') like '%BuyMoreTime%' then 'More Time'
          else 'OTHER'
          end"
}

constant: iap_id_strings {
  value: "case
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_001' then 'Free Ticket Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_017' then 'Free Coin Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_018' then 'Free Boost Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_002' then 'Housepets Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_003' then 'Fun Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_019' then 'Super Fun Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_022' then 'Jumbo Fun Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_045' then 'Spooky Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_046' then 'Eraser Direct Purchase - Salem'
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
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_036' then 'TU Energy Refill'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_037' then 'CE 202109_a - Lives & Coins Bundle'
            when json_extract_scalar(extra_json,'$.iap_id') like 'more_time_highscore' then 'More Time - Score'
            when json_extract_scalar(extra_json,'$.iap_id') like 'more_time_quest' then 'More Time - Quest'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_001' then 'Score Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_002' then 'Coin Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_004' then 'Time Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_005' then 'Bubble Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_006' then '5-to-4 Boost'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_000' then 'Free Ticket Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_001' then 'Fun Machine Ticket'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_002' then 'Super Fun Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_004' then 'Free Coin Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_005' then 'Free Boost Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_006' then 'Jumbo Fun Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_007' then 'Housepets Machine Ticket'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_009' then 'Spooky Machine Ticket'
            else 'other'
          end"
}

constant: iap_id_strings_grouped {
  value: "case
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_001' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_017' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_018' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_002' then 'Eraser Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_003' then 'Eraser Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_019' then 'Eraser Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_022' then 'Eraser Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_045' then 'Eraser Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_046' then 'Eraser Direct Purchase - Salem'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_004' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_005' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_006' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_007' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_020' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_021' then 'Coin Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_008' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_026' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_009' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_010' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_011' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_012' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_013' then 'Gem Capsule'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_023' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_014' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_015' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_016' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_024' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_025' then 'Life Pack'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_028' then '24h Infinite Lives'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_029' then 'More Time'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_030' then 'More Time'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_031' then 'More Time'
            when json_extract_scalar(extra_json,'$.iap_id') like 'more_time_highscore' then 'More Time'
            when json_extract_scalar(extra_json,'$.iap_id') like 'more_time_quest' then 'More Time'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_036' then 'TU Energy'
            when json_extract_scalar(extra_json,'$.iap_id') like 'item_037' then 'Lives & Coins Bundle'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_001' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_002' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_003' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_004' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_005' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like 'boost_006' then 'Boosts'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_000' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_001' then 'Eraser Machine Ticket'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_002' then 'Eraser Machine Ticket'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_004' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_005' then 'Free Machine'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_006' then 'Eraser Machine Ticket'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_007' then 'Eraser Machine Ticket'
            when json_extract_scalar(extra_json,'$.iap_id') like 'box_009' then 'Spooky Machine Ticket'
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
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V3.Confirm' then 'MG - Buy More Time - High Score - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V3.Close' then 'MG - Buy More Time - High Score - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V3.Confirm.quest' then 'MG - Buy More Time - Quest - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V3.Close.quest' then 'MG - Buy More Time - Quest - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BuyMoreTime.Confirm' then 'MG - Buy More Time - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V4.Confirm' then 'MG - Buy More Time - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BuyMoreTime.V4.Close' then 'MG - Buy More Time - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BuyMoreTime_V4.Close' then 'MG - Buy More Time - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_BuyExtra.Close' then 'MG - Buy More Time - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BuyMoreTime.Close' then 'MG - Buy More Time - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_BuyExtra.Continue' then 'MG - Buy More Time - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_legacy.EndOfRound.Character' then 'EoR - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_legacy.TryAgain' then 'EoR - Try Again'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_legacy.Back' then 'EoR - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound.Back' then 'EoR - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_legacy.Continue' then 'EoR - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound.Continue' then 'EoR - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_v3.Continue' then 'EoR - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_v3.TryAgain' then 'EoR - Try Again'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound.TryAgain' then 'EoR - Try Again'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_Failure.Continue' then 'EoR - Fail - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_Failure.TryAgain' then 'EoR - Fail - Try Again'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound.EndOfRound.Character' then 'EoR - Eraser Collected'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndOfRoundReward_V3.Close' then 'EoR - Reward - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_Failure.BoostInfo' then 'EoR - Boost Info'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_Failure.GetHelp' then 'EoR - AFH - Ask for Help'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EraserReward.Continue' then 'EoR - Reward - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CollectHelpRequest.TryAgain' then 'EoR - AFH - Try Again'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CollectHelpRequest.Back' then 'EoR - AFH - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CollectHelpRequest.Collect' then 'EoR - AFH - Collect Token'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_v3.Back' then 'EoR - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CameraScroller_Fixed-TopDown.WorldTapDispatcher' then 'WM - Tap Map'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CameraScroller_Classic-Flow.WorldTapDispatchers' then 'WM - Tap Map'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CameraScroller_Classic-Flow.WorldTapDispatcher' then 'WM - Tap Map'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CameraScroller_Fixed-TopDown.PlayNavigation' then 'WM - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CameraScroller_Classic-Flow.PlayNavigation' then 'WM - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_CameraScroller_Classic-Flow.BingoList' then  'WM - Tap List View'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_BingoHome_V3.TileProgress.Free%' then 'Bingo Card - Tap Tile'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_BingoHome_V3.QuestNode%' then 'WM - Tap Tile'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_Home.QuestNode.%' then 'WM - Tap Tile'
              when json_extract_scalar(extra_json,'$.button_tag') like 'UseHeroPower.character_%' then 'MG - Eraser Skill'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Pause' then 'MG - Pause'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Pause.Close' then 'MG - Pause - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Pause_V2.Close' then 'MG - Pause - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Pause_V2.OverlayClose' then 'MG - Pause - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Pause.OverlayClose' then 'MG - Pause - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Pause_V2.Quit' then 'MG - Pause - Quit'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Pause.Quit' then 'MG - Pause - Quit'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_QuitConfirm_V2.Close' then 'MG - Pause - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Settings.Close' then 'Settings - Close'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_Character_Dialogue%' then 'WM - Dialog'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_Join.Join' then 'WM - Team Up - FUE - Join'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_FUE.Next' then 'WM - Team Up - FUE - Next'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_FUE.Skip' then 'WM - Team Up - FUE - Skip'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_FUE.Back' then 'WM - Team Up - FUE - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_FUE.Close' then 'WM - Team Up - FUE - Close'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_CommunityEvent_SelectTeam.CommunityTeamSelect.%' then 'CE - Select Team'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps.Home' then 'Team Up - FUE - Home'
              when json_extract_scalar(extra_json,'$.button_tag') = 'TeamUpSelect' then 'WM - Team Up - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUp_Main.Join' then 'Team Up - Main - Join Team'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUp_Main.Play' then 'Team Up - Main - Play Card'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUp_Main.Home' then 'Team Up - Main - Back to World Map'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_TeamUps_Bingo.QuestNode%' then 'Team Up - Bingo Card - Tap Tile'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps_Bingo.Back' then 'Team Up - Bingo Card - Back to Main'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps_Bingo.Home' then 'Team Up - Bingo Card - Back to World Map'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps_Bingo.Activity' then 'Team Up - Bingo Card - Tap Activity Feed'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps_Bingo.Claim' then 'Team Up - Activity - Claim Any Reward'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps_Bingo.Request' then 'Team Up - Activity - Request Energy'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps_Bingo.Donate' then 'Team Up - Activity - Donate Energy'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_Refill.Refill' then 'Team Up - Out of Energy - Buy'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_Refill.Ok' then 'Team Up - Out of Energy - Buy - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps_Bingo.Chat' then 'Team Up - Bingo Card - Tap Chat Feed'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_TeamUp_Chat.ChatEmoji.%' then 'Team Up - Chat - Type'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_Chat.Submit' then 'Team Up - Chat - Send'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_Chat.Delete' then 'Team Up - Chat - Delete'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TeamUp_Chat.Close' then 'Team Up - Chat - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_TeamUps_Bingo.like' then 'Team Up - Chat - like'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.PlayFromQuest' and ${TABLE}.current_card like 'tu%' then 'Team Up - PG - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BingoQuestDetails_Legacy.PlayFromQuest' then 'PG - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.PlayFromQuest' then 'PG - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.EmptyTeam' then 'PG - Play (No Eraser Selected)'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame.EmptyTeam' then 'PG - Play (No Eraser Selected)'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.EraserSlot.' then 'PG - Play (No Eraser Selected)'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.Boosts' then 'PG - Open Boost Shop'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_Boosts_V3.BoostUI.%' then 'PG - Equip Boost'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Boosts_V3.OverlayClose' then 'PG - Close Boost Shop'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Boosts_V3.respite' then 'PG - Do Not Show Boost Shop'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Boost_Purchase.Purchase' then 'PG - Boost Shop - Purchase'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.Back' then 'PG - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BingoQuestDetails.PlayFromQuest' then 'PG - Play'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_PreGame_V3.QuestEraserSelection%' then 'PG - Select / Deselect Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Boosts_V3.Close' then 'PG - Close Boost Dialog'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_InAppMessaging_CE.' then 'PG - ToTD'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame_V3.RequestHelp' then 'PG - AFH'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_AddEraser_V3.QuestEraserSelection.%' then 'PG - Add Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_AddEraser.QuestEraserSelection.%' then 'PG - Add Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame.Add Eraser' then 'PG - Add Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_EraserDetail.Use.character_%' then 'PG - Use Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_EraserDetail.Remove.character_%' then 'PG - Remove Eraser'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_CommunityEvents_Bingo.QuestNode%' then 'Community Event - Bingo Card - Tap Tile '
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Eraser_Dialogue.Confirm' then 'WM - Story'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Narrator_Dialogue.Confirm' then 'WM - Story'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Narrator_Dialogue.Close' then 'WM - Story'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Eraser_Dialogue.Close' then 'WM - Story'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Eraser_Dialogue.SkipDialogue' then 'WM - Story - Skip'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Narrator_Dialogue.SkipDialogue' then 'WM - Story - Skip'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_DailyRewards.Claim' then 'Daily Rewards - Claim'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BingoHome_V3.Stars' then 'Stars - Bingo Card - Star Jar'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_BingoHome_V3.Restore%' then 'Stars - Restoration - Restore'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BingoHome_V3.Confirm' then 'Stars - Restoration - Restore All'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BingoHome_V3.PropBack' then 'Stars - Bingo Card - Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_BingoHome_V3.CompleteBingoCard' then 'Stars - Restoration - Continue'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_DailyRewards.OverlayClose' then 'Daily Rewards - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_DailyRewards.Close.' then 'Daily Rewards - Close'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_QuickPurchase.Close' then 'QP - Close'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_QuickPurchase.Purchase%' then 'QP - Select IAP'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_Purchase.Close' then 'QP - Close Purchase Panel'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Store' then 'Store'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_Store.Purchase.%' then 'Store - Select Currency'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_Purchase.Purchase%' then 'Store - Purchase Currency'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Purchase.Continue' then 'Store - Close IAP Confirmation'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Purchase.Close' then 'Store - Close IAP Confirmation'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_Gacha.Purchase.%' then 'Store - Select Machine'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Eraser_LevelUp.Collect' then 'Store - Machine - Collect'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Gacha.Close.' then 'Store - Machine - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Reward.Continue' then 'Store - Daily Reward - Collect'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_EndOfRound_Success.Collect' then 'EoR - Collect Star'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneHome.Tasks' then 'Zones - Task List'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneHome.Play' then 'Zones - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_Zones.Restore' then 'Zones - Task List - Restore'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_Zones.Close' then 'Zones - Task List - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame.PlayFromQuest' then 'PG - Play'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_NoStars.Ok' then 'Zones - Task List - Insufficient Stars'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_NoStars.Close' then 'Zones - Task List - Insufficient Stars - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_PreGame.Close' then 'PG - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'SheetContainer.OverlayClose' then 'Close Sheet'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_InAppMessaging_RateUs.' then 'IAM - Rate Us'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_InAppMessaging_Survey.' then 'IAM - Survey'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_RequestHelp_Completed.HighFive' then 'AFH - Thank You'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_RequestHelp_HighFive_Ack.HighFive' then 'AFH - Welcome'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_RequestHelp_HighFive_Ack' then 'AFH - Welcome Back'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_InAppMessaging_NameChange.' then 'IAM - Set Username'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Profile.Close' then 'Profile - Close'
              when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_Collection.EraserSlot.' then 'Collection - Eraser'
              else json_extract_scalar(extra_json,'$.button_tag')
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

  constant: event_names {
    value: "case
              when json_extract_scalar(${TABLE}.extra_json,'$.event_id') = 'event_id_202106_a' then 'Spring'
              when json_extract_scalar(${TABLE}.extra_json,'$.event_id') = 'event_id_202107_a' then 'Summer'
              when json_extract_scalar(${TABLE}.extra_json,'$.event_id') = 'event_id_202107_b' then 'Olympics'
              when json_extract_scalar(${TABLE}.extra_json,'$.event_id') = 'event_id_202109_a' then 'Back-to-School'
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
              when ${TABLE}.reward_type = 'boost_004' then 'Time Boost'
              when ${TABLE}.reward_type = 'boost_005' then 'Bubble Boost'
              when ${TABLE}.reward_type = 'boost_006' then '5-to-4 Boost'
              when ${TABLE}.reward_type = 'LEVEL' then 'Level Ticket'
              when ${TABLE}.reward_type = 'SKILL' then 'Skill Ticket'
              when ${TABLE}.reward_type = 'box_009' then 'Spooky Machine Ticket'
            end"
  }
constant: reward_events {
    value: "case
              when ${TABLE}.reward_event like '%initial%' then 'Initial Reward'
              when ${TABLE}.reward_event like '%level%' then 'Level Up'
              when ${TABLE}.reward_event like '%bingo%' then 'Bingo Card'
              --when ${TABLE}.reward_event = 'bingo_reward_COMP' then 'Bingo Card Completion'
              --when ${TABLE}.reward_event like '%bingo_reward_C%' then 'Bingo Card Column'
              --when ${TABLE}.reward_event like '%bingo_reward_R%' then 'Bingo Card Row'
              --when ${TABLE}.reward_event like '%bingo_reward_D%' then 'Bingo Card Diagonal'
              when ${TABLE}.reward_event = 'round_end' then 'Round End'
              when ${TABLE}.reward_event = 'facebook_connect' then 'Facebook Connect'
              when ${TABLE}.reward_event = 'global_leaderboard' then 'Global Leaderboard Reward'
              when ${TABLE}.reward_event like '%gacha_box%' then 'Free Machine'
              --when ${TABLE}.reward_event = 'gacha_box_000' then 'Free Ticket Machine'
              --when ${TABLE}.reward_event = 'gacha_box_004' then 'Free Coin Machine'
              --when ${TABLE}.reward_event = 'gacha_box_005' then 'Free Boost Machine'
              else ${TABLE}.reward_event
            end"
}

constant: campaign_name_clean {
  value: "case
            when ${TABLE}.singular_partner_name = 'Organic' then 'Organic'
            when ${TABLE}.singular_partner_name = 'Unattributed' then 'Unattributed'
            when ${TABLE}.campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_LATAM/ES_N/A' then 'AAA - No Event'
            when ${TABLE}.campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_LATAM/ES_N/A v2' then 'AAA - No Event'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_5_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - 5 Min'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - 15 Min'
            when ${TABLE}.campaign_name = 'Android_AAA_Events_30_Minutes_Women&Men_LATAM/ES_N/A' then 'AAA - 30 Min'
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
