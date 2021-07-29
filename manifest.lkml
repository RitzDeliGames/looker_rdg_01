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
  value: "('7721b79b-d8c6-4f6a-9ebb-d6afa43daed7','7acaf400-0343-4cb8-be6c-8707dd8d1efa','daf7c573-13dc-41b8-a173-915faf888c71','891b3c15-9451-45d0-a7b8-1459e4252f6c','9a804252-3902-43fb-8cab-9f1876420b5a','8824596a-5182-4287-bcd9-9154c1c70514','891b3c15-9451-45d0-a7b8-1459e4252f6c','ce4e1795-6a2b-4642-94f2-36acc148853e','1c54bae7-da32-4e68-b510-ef6e8c459ac8','c0e75463-850c-4a25-829e-6c6324178622','3f2eddee-3070-4966-8d51-495605ec2352','e4590cf5-244c-425d-bf7e-4ebf0416e9c5','c83b1dc7-24cd-40b8-931f-d73c69c949a9','39786fde-b372-4814-a488-bfb1bf89af8a','7f98585f-34ca-4322-beda-fa4ff51a8721','e699b639-924f-4854-8856-54f3019ecca1','397322b8-1459-4da7-a807-bc0d0404990d','a8092c91-4a71-45f8-8366-0b198adf1219')"
}
constant: cheaters {
  value: "('ee2740bb-59dd-460a-9034-69824d0306a2',
            '78170416-756f-47d0-a0a1-577d7dc6c63f',
            'b7de9a80-5d04-4559-ba77-544f7c632c47',
            '86336e86-8e30-43b2-8dc4-47477f9d0121',
            '47822920-0a91-4f3f-a835-28d8e0ae76b7',
            '66277914-bcd1-4b33-b548-15fa3d797c81',
            'b7de9a80-5d04-4559-ba77-544f7c632c47',
            'bca02bbb-ad1b-4895-9200-15ba00bc64a9',
            'f1da12ca-8f68-4bfd-8e67-8311d23a5c0a',
            'faf7ccc8-8b89-4010-98bc-2c74e02df822',
            '0b843df1-456b-4400-9222-af0ee2366641',
            '3ab8cb64-31f2-44b3-989a-16ae766b9103',
            '063a1bf2-593c-43be-8e3e-cd42bf9483e5',
            'fb9fcbca-a1a2-4fc7-8641-7a1ef237a192',
            '96f1b0a9-55d3-477a-86b9-0579336bfb67',
            'b7eaf85b-ea28-4ab2-bb1d-d716d0ff77a5',
            '13059c68-5c70-4135-89c4-550203990a20',
            'fb778503-9170-4c04-95c5-5af35fe9dbb3',
            '7e19c292-b55a-4c9c-9152-a9f6487552d0',
            '5940a8a3-f3af-4e5b-8035-3a7a0cd318cd',
            '2b086585-3189-4b41-97f0-a3476bfa34d3',
            'a4bb8fab-7467-4800-aedd-4dc2a59decc1',
            'f35fd442-533f-48eb-a66e-1bc0a4f77878',
            'cd826314-2603-4cb3-b0c4-929df25a2420',
            'f2344ca8-4d6a-451b-800d-453af906cd69',
            '01592809-70bd-4374-8ce4-76e61ba068d9',
            '4e83fab3-f976-46c5-bd95-4ec04a00f100',
            'b3382b2e-678e-4980-b15e-7693842377ea',
            '4735045a-0a3e-48b7-b38d-4167043eb660',
            '54166117-0af2-4ad5-ab5a-f70b9b05b1a2',
            '68cfff50-2d1f-48b2-ad97-3b6b4fa58fde',
            'bfa5c969-d4e7-4129-9a64-68d0da5aeef9',
            '54166117-0af2-4ad5-ab5a-f70b9b05b1a2',
            'f50948c8-de4e-413d-b889-8a7c848d2867',
            '829a7c05-560c-410a-9647-597843fadee3',
            '88f3075f-da65-4bc5-919b-6b4cc93ce7e8',
            'ec72c559-be5c-49d5-b454-672f00b112ff',
            'c48adabe-0f53-41c0-b5e5-964b53ffe8eb',
            'b3382b2e-678e-4980-b15e-7693842377ea',
            'd297c9be-ce1c-4a76-9b03-7cbb3800a280',
            'ec660da9-464c-4485-8420-f214e0b9b398',
            'ee70bf38-7cf1-4cc6-905d-4872fe0af134',
            'f50f3c54-c1d0-463f-8837-ade9c4aff127',
            'c91fe6bb-95a6-47b3-a9ae-e5a41297ea28',
            'eff2211a-d96b-49ef-84e6-29b33a9e41a9',
            '95107a6b-c283-4637-a1ce-366d54e691d0',
            'af5f59ad-0c58-4f01-9bf8-9230b8ab29cc',
            '1d10d0e4-f217-4910-84de-44a01884df6d',
            'e955bb4d-2f20-4524-a370-7204fa249d6f',
            '405f1162-7667-4f6c-a8a7-7a79c15b4734',
            'ecea8541-944b-4a56-bbc1-92f2e7045d08',
            '1d10d0e4-f217-4910-84de-44a01884df6d',
            'e3c0347d-8aa8-431e-9aed-b210a11c3f3f',
            '6142a709-9a93-4f46-b071-20170d7cfe56',
            'b14c828a-72b4-4fd9-a151-bc63cfd91299',
            '683082f8-2002-488f-84c6-6281e2a162e0',
            '9e950194-cebf-441a-adaa-27a9b76a3f48',
            '04e1739f-a203-4e6d-be39-a3decdf5f053',
            'f6b124a5-a030-4acb-9df6-1b97aa61023e',
            '7c80d873-993f-4ab7-b569-89ed5690aa79',
            '6ff283b7-7b1d-43cc-a144-24c723fb0338',
            '60fd9ec2-1226-43e7-971c-daf6b1727baa',
            '6142a709-9a93-4f46-b071-20170d7cfe56',
            'fd9c7056-b02d-4132-8c0d-d60b7a70cd68',
            '5bdbb1ff-5585-470d-a51a-32ec4ac6f73d',
            '60fd9ec2-1226-43e7-971c-daf6b1727baa',
            'b3382b2e-678e-4980-b15e-7693842377ea',
            '47822920-0a91-4f3f-a835-28d8e0ae76b7',
            '96f1b0a9-55d3-477a-86b9-0579336bfb67',
            '7635bd58-3592-44dd-a6c4-6ed765588174',
            'b7de9a80-5d04-4559-ba77-544f7c632c47',
            'b14c828a-72b4-4fd9-a151-bc63cfd91299',
            'afc04814-defa-423e-b1f6-cebfe2f4febc',
            'b695c771-6dbf-4a9c-b5f4-5c00c28ac0c5',
            'efaddf41-ea03-4c4e-9073-7ed7d2c67ace',
            'c48adabe-0f53-41c0-b5e5-964b53ffe8eb',
            'de7eae87-9e7c-4c63-98e8-6690edfb81ca',
            'bfa5c969-d4e7-4129-9a64-68d0da5aeef9',
            'b5078a45-6501-4694-b12f-6e124dce560e',
            'c91fe6bb-95a6-47b3-a9ae-e5a41297ea28',
            'ec660da9-464c-4485-8420-f214e0b9b398',
            'f8718c4c-26b6-4eaf-8d2e-ca10fddcfbcc',
            'f35fd442-533f-48eb-a66e-1bc0a4f77878',
            '4a5a0c69-7322-4855-beaf-618f696cd9ed',
            'ee70bf38-7cf1-4cc6-905d-4872fe0af134',
            'f5f0af29-c87c-4c0d-be5e-b03b9a42bc53',
            '4498cae1-f753-49b9-a864-50797e9ae2bf',
            '6bc2f83a-c890-4863-9fcd-c69a27643334',
            '7f8537fe-377d-4ecf-bfb3-37885d86dd3c')"
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
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_BuyMoreTime_V3.Confirm' then 'BuyMoreTime - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_BuyMoreTime.Confirm' then 'BuyMoreTime - Confirm'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_BuyMoreTime_V3.Close' then 'BuyMoreTime - Close'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_BuyMoreTime.Close' then 'BuyMoreTime - Close'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Panel_PreGame_V3.PlayFromQuest' then 'PlayFromQuest'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_BingoQuestDetails.PlayFromQuest' then 'PlayFromQuest'
              when json_extract_scalar(extra_json,'$.button_tag') like 'Sheet_BingoQuestDetails_Legacy.PlayFromQuest' then 'PlayFromQuest'
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
