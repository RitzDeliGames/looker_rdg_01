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
            when lower(${TABLE}.hardware) like '%iPhone%' THEN 'Apple'
            when lower(${TABLE}.hardware) like '%iPad%' THEN 'Apple'

            when lower(${TABLE}.hardware) like '%along%' THEN 'Along'
            when lower(${TABLE}.hardware) like '%amazon%' THEN 'Amazon'
            when lower(${TABLE}.hardware) like '%alco%' THEN 'Alco'
            when lower(${TABLE}.hardware) like '%asus%' THEN 'Asus'
            when lower(${TABLE}.hardware) like '%acer%' THEN 'Acer'
            when lower(${TABLE}.hardware) like '%blackview%' THEN 'Blackview'
            when lower(${TABLE}.hardware) like '%blu%' THEN 'BLU'
            when lower(${TABLE}.hardware) like '%coosea%' THEN 'Coosea'
            when lower(${TABLE}.hardware) like '%dialn%' THEN 'DIALN'
            when lower(${TABLE}.hardware) like '%foxx%' THEN 'Foxxcon'
            when lower(${TABLE}.hardware) like '%fih%' THEN 'FIH'
            when lower(${TABLE}.hardware) like '%google%' THEN 'Google'
            when lower(${TABLE}.hardware) like '%pixel%' THEN 'Google'
            when lower(${TABLE}.hardware) like '%hena%' THEN 'Hena'
            when lower(${TABLE}.hardware) like '%hisense%' THEN 'Hisense'
            when lower(${TABLE}.hardware) like '%incar%' THEN 'Incar'
            when lower(${TABLE}.hardware) like '%pepper%' THEN 'Hot Pepper'
            when lower(${TABLE}.hardware) like '%honor%' THEN 'Honor'
            when lower(${TABLE}.hardware) like '%htc%' THEN 'HTC'
            when lower(${TABLE}.hardware) like '%huawei%' THEN 'Huawei'
            when lower(${TABLE}.hardware) like '%joyar%' THEN 'Joyar'
            when lower(${TABLE}.hardware) like '%kyocera%' THEN 'Kyocera'
            when lower(${TABLE}.hardware) like '%infinix%' THEN 'Infinix'
            when lower(${TABLE}.hardware) like '%lg%' THEN 'LG'
            when lower(${TABLE}.hardware) like '%lenovo%' THEN 'Lenovo'
            when lower(${TABLE}.hardware) like '%maxwest%' THEN 'Maxwest'
            when lower(${TABLE}.hardware) like '%moto%' THEN 'Motorola'
            when lower(${TABLE}.hardware) like '%nokia%' THEN 'Nokia'
            when lower(${TABLE}.hardware) like 'nst%' THEN 'NST'
            when lower(${TABLE}.hardware) like '%nuu%' THEN 'Nuu'
            when lower(${TABLE}.hardware) like '%ox tab%' THEN 'Ox Tab'
            when lower(${TABLE}.hardware) like '%hmd%' THEN 'Nokia'
            when lower(${TABLE}.hardware) like '%onn%' THEN 'OnePlus'
            when lower(${TABLE}.hardware) like '%oneplus%' THEN 'OnePlus'
            when lower(${TABLE}.hardware) like '%oppo%' THEN 'OPPO'
            when lower(${TABLE}.hardware) like '%pritom%' THEN 'Pritom'
            when lower(${TABLE}.hardware) like '%realme%' THEN 'Realme'
            when lower(${TABLE}.hardware) like '%samsung%' THEN 'Samsung'
            when lower(${TABLE}.hardware) like '%sky%' THEN 'Sky'
            when lower(${TABLE}.hardware) like '%sony%' THEN 'Sony'
            when lower(${TABLE}.hardware) like '%tcl%' THEN 'TCL'
            when lower(${TABLE}.hardware) like '%tecno%' THEN 'Tecno'
            when lower(${TABLE}.hardware) like '%teclast%' THEN 'Teclast'
            when lower(${TABLE}.hardware) like '%tinno%' THEN 'Tinno'
            when lower(${TABLE}.hardware) like '%vivo%' THEN 'Vivo'
            when lower(${TABLE}.hardware) like '%vortex%' THEN 'Vortex'
            when lower(${TABLE}.hardware) like '%whoop%' THEN 'Whoop'
            when lower(${TABLE}.hardware) like '%wingtech%' THEN 'Wingtech'
            when lower(${TABLE}.hardware) like '%xiaomi%' THEN 'Xiaomi'
            when lower(${TABLE}.hardware) like '%xmobile%' THEN 'XMobile'
            when lower(${TABLE}.hardware) like '%xwireless%' THEN 'XWireless'
            when lower(${TABLE}.hardware) like '%visual%' THEN 'Visual-Land'
            when lower(${TABLE}.hardware) like '%yulong%' THEN 'Yulong'
            when lower(${TABLE}.hardware) like '%zonko%' THEN 'Zonko'
            when lower(${TABLE}.hardware) like '%vsmart%' THEN 'VSmart'
            when lower(${TABLE}.hardware) like '%zte%' THEN 'ZTE'
            when lower(${TABLE}.hardware) like '%zuum%' THEN 'Zuum'
            else ${TABLE}.hardware --'Unmapped'
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

constant: button_tags {
  value: "case
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_LuckyDice.Roll' then 'Luck Dice - Roll'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_LuckyDice.Close' then 'Luck Dice - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_QuickPurchase.Close' then 'Quick Purchase - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_EndOfRound_Failure.Continue' then 'Mini-Game - EoR - Continue'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_GoFish.Play' then 'Go Fish - Play'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BattlePass.' then 'BattlePass'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Puzzle.Pregame' then 'Puzzle - PreGame'
            when json_extract_scalar(extra_json,'$.button_tag') = 'SheetContainer.OverlayClose' then 'Close Overlay'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_BattlePass.Close' then 'BattlePass - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_HotdogContest.PlayFromFeature' then 'Hotdog - Play'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_HotdogContest.PlayerProfile' then 'Hotdog - Profile'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_QuickPurchase.Basic' then 'Quick Purchase - Basic'
            when json_extract_scalar(extra_json,'$.button_tag') like '%Panel_ZoneHome.BattlePass%' then 'BattlePass'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_GemQuest.GoPoolOfTorches' then 'GemQuest - PoolOfTorches'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TreasureTrove.Close' then 'TreasureTrove - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TreasureTrove.Purchase.' then 'TreasureTrove - Purchase'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneHome.Tasks' then 'Zones Home - Open'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneHome.Play' then 'Zones Home - Play'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneHome.NewZone' then 'Zones Home - New Zone'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_ZoneUnlock.Unlock' then 'Zone Home - Unlock'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_Zones.Restore' then 'Zone Task List - Restore'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Panel_ZoneRestore.' then 'Zone - Zone Complete'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_Zones.Close' then 'Zone Task List - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_Tasks_NoStars.' then 'Zone Task List - No Stars'
            when json_extract_scalar(extra_json,'$.button_tag') like '%Panel_ZoneExplorer.Zone.%' then 'Zone Explorer'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_UnlockStreakBonus.UnlockConfirm' then 'Streak Bonus'
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
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_PM_DailyReward.Continue' then 'Daily Rewards - Continue'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_DailyReward.Close' then 'Daily Rewards - Close'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_TicketsFUE.Claim' then 'Tickets - Claim'
            when json_extract_scalar(extra_json,'$.button_tag') = 'Sheet_DailyReward.Claim' then 'Daily Rewards - Claim'
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

constant: campaign_name_mapped {
  value: "
    case
      when lower(campaign_name) = 'ccb|uac|rdg|android|us|tcpa|engagement_threshold_d2_m35|nov24_1539735' then '20241108 - Android - Google - USA - D2_Engagement'
      when lower(campaign_name) = 'ccb|fb|rdg|android|us|aeo|engagement_threshold_d2_m35|nov24_1539487' then '20241108 - Android - Meta - USA - D2_Engagement'
      when lower(campaign_name) = 'ccb|fb|rdg|android|latam|aeo|60minutes_1535952' then '20241025 - Android - Meta - LATAM - 60 Min'
      when lower(campaign_name) = 'ccb|uac|gentlemen|android|br|tcpa|60minutes_1554904' then '20241019 - Android - Google - LATAM - 60 Min'
      when lower(campaign_name) = 'ccb|uac|gentlemen|android|us|hybrid_1554905' then '20241019 - Android - Google - USA - Hybrid'
      when lower(campaign_name) = 'ccb|uac|gentlemen|android|latam|hybrid_1554335' then '20241011 - Android - Google - LATAM - Hybrid'
      when lower(campaign_name) = 'ccb|fb|gentlemen|android|us|aeo|60minutes|highenddevice_1554334' then '20241015 - Android - Meta - USA - 60 Min'
      when lower(campaign_name) = 'ccb|fb|gentlemen|ios|us|aeo|purchase|_1542891' then '20240924 - iOS - Meta - USA - Purchase'
      when lower(campaign_name) = 'ccb|fb|gentleman|android|tier1|vo|purchase|1_1539921' then '20240924 - Android - Meta - Tier 1 - Value'
      when lower(campaign_name) = 'ccb|fb|gentlemen|android|tier1|vo|purchase|1_1539921' then '20240924 - Android - Meta - Tier 1 - Value'
      when lower(campaign_name) = 'ccb|fb|gentlemen|ios|us|aeo|purchase|_1542892' then '20240924 - iOS - Meta - USA - Purchase'
      when lower(campaign_name) = 'ccb|fb|gentlemen|ios|us|aeo|tutorialcomplete|_1542895' then '20240914 - iOS - Meta - USA - Tutorial Complete'
      when lower(campaign_name) = 'ccb|uac|gentlemen|android|us|troas|purchase|09122024_1548667' then '20240913 - Android - Google - USA - Purchase'
      when lower(campaign_name) = 'ccb_ios_anonymized_ua+re_137778' then 'iOS - Anonymized'
      when lower(campaign_name) = 'ccb_android_anonymized_ua+re_137777' then 'Android - Anonymized'
      when lower(campaign_name) = 'ccb|uac|gentlemen|android|us|troas|purchase|_1539737' then '20240905 - Android - Google - USA - Purchase'
      when lower(campaign_name) = 'ccb_applovin_gentlemen_android_os10_us_iaproasd7_broad_1541379' then '20240905 - Android - Applovin - USA - Purchase'
      when lower(campaign_name) = 'ccb|fb|gentlemen|ios|us|aeo|purchase|_1542873' then '20240904 - iOS - Meta - USA - Purchase'
      when lower(campaign_name) = 'ccb|fb|gentlemen|ios|us|mai|install|_1542872' then '20240904 - iOS - Meta - USA - Install'
      when lower(campaign_name) = 'mistplay-ccb_and_invoicereadjustment-may2024_may1-2-missingspends_1515359' then '20240424 - Android - Mistplay - USA - ROAS'
      when lower(campaign_name) = 'ccb|uac|gentlemen|android|us|tcpa|purchase|_1539736' then '20240830 - Android - Google - USA - Purchase'
      when lower(campaign_name) like 'ccb|fb|rdg|android|us|aeo|60minutes|2024.08.14_1539485%' then '20240830 - Android - Meta - USA - 60 Min'
      when lower(campaign_name) = 'ccb|fb|rdg|android|latam|aeo|tutorialcomplete|1_1539505' then '20240819 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|fb|rdg|android|latam|aeo|tutorialcomplete|2_1539506' then '20240819 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|fb|rdg|android|latam|aeo|tutorialcomplete|2024.08.19_1539506' then '20240819 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|fb|rdg|android|us|aeo|purchase|2024.08.06_1535953' then '20240806 - Android - Meta - USA - Purchase'
      when lower(campaign_name) = 'ccb|fb|rdg|android|us|aeo|tutorialcomplete|2024.08.02|_1535951' then '20240802 - Android - Meta - USA - Tutorial Complete'
      when lower(campaign_name) = 'ccb|rdg|facebook|creativetest|android|us|mai|rdgapp|jul24_1533998' then '20240801 - Android - Meta - USA - Creative Test'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|rdgapp|localized|jul24_1534808' then '20240801 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|rdg|facebook|install|android|us|mai|rdgapp|jul24_1534693' then '20240731 - Android - Meta - USA - MAI'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|rdgapp|jul24_1532599' then '20240725 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|jul24_1526879 campaign' then '20240711 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|latam|aa+|aeo|engagement60|jul24_1526475' then '20240710 - Android - Meta - LATAM - 60 Min'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|jul24_1526471' then '20240710 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|jul24_1526879' then '20240710 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|us|aa+|aeo|tutorial|jul24_1522313' then '20240703 - Android - Meta - USA - Tutorial Complete'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|latam|aa+|aeo|tutorial|jun24_1520208' then '20240624 - Android - Meta - LATAM - Tutorial Complete'
      when lower(campaign_name) = 'ccb|android|facebook|us|charactermarketability|linkclick|cell1|may24_1507641' then '20240524 - Android - Meta - USA - Marketability'
      when lower(campaign_name) = 'ccb|android|facebook|us|charactermarketability|linkclick|cell2|may24_1507648' then '20240524 - Android - Meta - USA - Marketability'
      when lower(campaign_name) = 'ccb|android|facebook|us|charactermarketability|linkclick|cell3|may24_1507652' then '20240524 - Android - Meta - USA - Marketability'
      when lower(campaign_name) = 'chum|facebook|android|latam|aa+|mai|apr24_137769' then '20240424 - Android - Meta - LATAM - MAI'
      when lower(campaign_name) = 'chum|facebook|android|us|aa+|aeo|apr24_1500678' then '20240424 - Android - Meta - USA - Purchase'
      when lower(campaign_name) = 'chum|facebook|android|us|aa+|aeo|may24_1506781' then '20240524 - Android - Meta - USA - Purchase'
      when lower(campaign_name) = 'chum|facebook|creativetest|android|us|mai|may24_1508328' then '20240524 - Android - Meta - USA - Creative Test'
      when lower(campaign_name) = 'mistplay-ccb-android-os12-us-roasopti-all18_137763' then '20240424 - Android - Mistplay - USA - ROAS'
      when lower(campaign_name) = 'ccb|facebook|android|us|aa+|mai|may24_1510798' then '20240524 - Android - Meta - USA - MAI'
      when lower(campaign_name) = 'chum|facebook|ios|latam|aa+|mai|apr24_137765' then '20240424 - Android - Meta - LATAM - MAI'
      when lower(campaign_name) = 'chum|facebook|creativetest|android|us|aa+|mai|may24_1508328' then '20240524 - Android - Meta - USA - Creative Test'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|us|aa+|aeo|tutorialcomplete|may24_1510911' then '20240530 - Android - Meta - USA - Tutorial Complete'
      when lower(campaign_name) = 'ccb|rdg|facebook|creativetest|android|us|mai|may24_1510912' then '20240530 - Android - Meta - USA - Creative Test'
      when lower(campaign_name) = 'ccb|rdg|facebook|android|us|aa+|aeo|purchase|may24_1510988' then '20240605 - Android - Meta - USA - Purchase'

      when campaign_name = 'CHUM|Facebook|Android|US|AA+|20240307' then '20240307 - Android - Meta - USA - Purchase'
      when campaign_name = 'CHUM|Facebook|Android|LATAM-ES|AA+|Mar03' then '20240303 - Android - Meta - LATAM/ES - 30 Min'
      when campaign_name = 'CHUM|Facebook|Android|US|AA+|Jan24' then '20240103 - Android - Meta - USA - Purchase'
      when campaign_name = 'Android_AAA+_30_Minutes_MX_20231214' then '20231214 - Android - Meta - MX - 30 Min'
      when campaign_name = 'Android_AAA+_30_Minutes_MX_20231129' then '20231129 - Android - Meta - MX - 30 Min'
      when campaign_name = 'Android_AAA+_MAI_US_20231110' then '20231110 - Android - Meta - USA - Install'
      when campaign_name = 'Android_AAA+TutorialComplete_US_20231030' then '20231030 - Android - Meta - USA - Tutorial Complete'
      when campaign_name = 'Android_AAA+_30_Minutes_LATAM/ES_20231019' then '20231019 - Android - Meta - LATAM/ES - 30 Min'
      when campaign_name = 'iOS_AAA+_Install_LATAM/ES_20231019' then '20231019 - Android - Meta - LATAM/ES - 30 Min'
      when campaign_name = 'Android_AAA+_30_Minutes_US_20230828' then '20230828 - Android - Meta - USA - 30 Min'
      when campaign_name = 'Android_AAA+_60_Minutes_US_20230825' then '20230825 - Android - Meta - USA - 60 Min'
      when campaign_name = 'Android_AAA_MAI_US_20230705' then '20230705 - Android - Meta - USA - Install'
      when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_US_N/A' then '20230131 - Android - Meta - USA - Purchase'
      when campaign_name = 'Android_AAA_Purchase_US_20230523' then '20230523 - Android - Meta - USA - Purchase'
      when campaign_name = 'Android_AAA+_Purchase_US_20230808' then '20230808 - Android - Meta - USA - Purchase'
      when campaign_name = 'Android_AAA+_Purchase_US_20230809' then '20230808 - Android - Meta - USA - Purchase'
      when campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_US_N/A' then '20230308 - Android - Meta - USA - 15 Min'
      when campaign_name = 'Android_AAA_15_Minutes_US_20230427' then '20230427 - Android - Meta - USA - 15 Min'
      when campaign_name = 'Android_AAA_30_Minutes_US_20230710' then '20230710 - Android - Meta - USA - 30 Min'
      when campaign_name = 'Android_AAA+_30_Minutes_US_20230721' then '20230721 - Android - Meta - USA - 30 Min'
      when campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_LATAM/ES_N/A' then 'Meta - AAA - LATAM/ES - No Event'
      when campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_LATAM/ES_N/A v2' then 'Meta - AAA - LATAM/ES - No Event'
      when campaign_name = 'Android_AAA_Events_5_Minutes_Women&Men_LATAM/ES_N/A' then 'Meta - AAA - LATAM/ES - 5 Min'
      when campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/ES_N/A' then 'Meta - AAA - LATAM/ES - 15 Min'
      when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230413' then '20230413 - Android - Meta - LATAM/ES - 15 Min'
      when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230510' then '20230510 - Android - Meta - LATAM/ES - 15 Min'
      when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230523' then '20230523 - Android - Meta - LATAM/ES - 15 Min'
      when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230607' then '20230607 - Android - Meta - LATAM/ES - 15 Min'
      when campaign_name = 'Android_AAA_15_Minutes_LATAM/ES_20230807' then '20230807 - Android - Meta - LATAM/ES - 15 Min'
      when campaign_name = 'Android_AAA_30_Minutes_LATAM/ES_20230717' then '20230717 - Android - Meta - LATAM/ES - 30 Min'
      when campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_LATAM/PTBR_N/A' then 'Meta - AAA - LATAM/BR - 15 Min'
      when campaign_name = 'Android_AAA_Installs_No_Event_Women&Men_Scan_N/A' then 'Meta - AAA - Scandinavia - No Event'
      when campaign_name = 'Android_AAA_Events_15_Minutes_Women&Men_Scan_N/A' then 'Meta - AAA - Scandinavia - 15 Min'
      when campaign_name = 'Android_AAA_Events_Purchases_Women&Men_Scandinavia_N/A' then 'Meta - AAA - Scandinavia - Purchase'
      when campaign_name = 'Android_AAA_Events_30_Minutes_Women&Men_LATAM/ES_N/A' then 'Meta - AAA - LATAM/ES - 30 Min'
      when campaign_name = 'Android_AAA_Events_30_Minutes_Women&Men_LATAM/BR_N/A' then 'Meta - AAA - LATAM/BR - 30 Min'
      when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/PTBR_N/A' then 'Meta - AAA - LATAM/BR - Purchase'
      when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/PTBR_N/A_v2' then 'Meta - AAA - LATAM/BR - Purchase'
      when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/ES_N/A' then 'Meta - AAA - LATAM/ES - Purchase'
      when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_LATAM/ES_N/A_v2' then 'Meta - AAA - LATAM/ES - Purchase'
      when campaign_name = 'Android_AAA_Events_Purchase_Women&Men_Chile_N/A' then 'Meta - AAA - Chile - Purchase'
      when campaign_name = 'Art_Test_Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle Games' then 'Meta - MAI - No Event -     Puzzle Games'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle Games' then 'Meta - MAI - No Event - Puzzle Games'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'Meta - MAI - 5 Min - Puzzle Games'
      when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'Meta - MAI - 15 Min - Puzzle Games'
      when campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Puzzle Games' then 'Meta - MAI - 30 Min - Puzzle Games'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Candy Crush' then 'Meta - MAI - No Event - Candy Crush'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Candy Crush' then 'Meta - MAI - 5 Min - Candy Crush'
      when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Candy Crush' then 'Meta - MAI - 15 Min - Candy Crush'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle & Decorate' then 'Meta - MAI - No Event - Puzzle &     Decorate'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Puzzle&Decorate' then 'Meta - MAI - No Event - Puzzle &     Decorate'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Puzzle & Decorate' then 'Meta - MAI - 5 Min - Puzzle &    Decorate'
      when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Puzzle & Decorate' then 'Meta - MAI - 15 Min - Puzzle &     Decorate'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Coin_Master' then 'Meta - MAI - No Event - Coin Master'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Coin Master' then 'Meta - MAI - 5 Min - Coin Master'
      when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Coin Master' then 'Meta - MAI - 15 Min - Coin Master'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_LATAM/MX - LAL - 1% - L7D_4+' then 'Meta - MAI - No Event     - 4 of 7 Days'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_LATAM/MX - LAL - 1% - L7D_4+' then 'Meta - MAI - 5 Min - 4     of 7 Days'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_LATAM/ES - LAL - 1% - Initiate Checkout' then 'Meta - MAI     - No Event - Start Checkout'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES - LAL - 1% - Like Page' then 'Meta - MAI - 5 Min - Like     Page'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_LATAM/ES - LAL - 1% - Initiate Checkout' then 'Meta - MAI     - 5 Min - Start Checkout'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Bubble Shooter' then 'Meta - MAI - No Event - Bubble     Shooter'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'Meta - MAI - 5 Min - Bubble Shooter'
      when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'Meta - MAI - 15 Min - Bubble     Shooter'
      when campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Bubble Shooter' then 'Meta - MAI - 30 Min - Bubble     Shooter'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Tile Blast' then 'Meta - MAI - No Event - Tile Blast'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'Meta - MAI - 5 Min - Tile Blast'
      when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'Meta - MAI - 15 Min - Tile Blast'
      when campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Tile Blast' then 'Meta - MAI - 30 Min - Tile Blast'
      when campaign_name = 'Android_Manual_Installs_No_Event_Women&Men_LATAM/ES_Blitz' then 'Meta - MAI - No Event - Blitz'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Blitz' then 'Meta - MAI - 5 Min - Blitz'
      when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Blitz' then 'Meta - MAI - 15 Min - Blitz'
      when campaign_name = 'Android_Manual_Events_5_Minutes_Women&Men_LATAM/ES_Walmart' then 'Meta - MAI - 5 Min - Walmart'
      when campaign_name = 'Android_Manual_Events_15_Minutes_Women&Men_LATAM/ES_Walmart' then 'Meta - MAI - 15 Min - Walmart'
      when campaign_name = 'Android_Manual_Events_30_Minutes_Women&Men_LATAM/ES_Walmart' then 'Meta - MAI - 30 Min - Walmart'
      else campaign_name
  end"
}



constant: campaign_milestone_category {
  value: "
  case
    when
      ${TABLE}.campaign_name in (
        '20240924 - Android - Meta - Tier 1 - Value'
        , '20240830 - Android - Meta - USA - 60 Min'
        )
      and date(${TABLE}.created_date) between '2024-09-23' and '2024-10-06'
    then 'Milestone 2'
    else 'Other'
    end
  "
}

constant: campaign_install_category {
  value: "
      case
        when ${TABLE}.campaign_name is null then 'Organic'
        when
          ${TABLE}.campaign_name not like '%Google%'
          and ${TABLE}.campaign_name not like '%Mistplay%'
          and ${TABLE}.campaign_name not like '%Meta%'
          and ${TABLE}.campaign_name not like '%Facebook%'
          and ${TABLE}.campaign_name not like '%Applovin%'
          then 'Unmapped Campaign'
        else
          case
            when ${TABLE}.campaign_name like '%Google%' then 'Google - '
            when ${TABLE}.campaign_name like '%Mistplay%' then 'Mistplay - '
            when ${TABLE}.campaign_name like '%Meta%' then 'Meta - '
            when ${TABLE}.campaign_name like '%Facebook%' then 'Meta - '
            when ${TABLE}.campaign_name like '%Applovin%' then 'Applovin - '
          else ''
          end
          ||
          case
            when ${TABLE}.campaign_name is null then 'Organic'
            when ${TABLE}.campaign_name like '%Purchase%' then 'Purchase Campaign'
            when ${TABLE}.campaign_name like '%Value%' then 'Purchase Campaign'
            when ${TABLE}.campaign_name like '%MAE%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%5 Min%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%15 Min%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%30 Min%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%60 Min%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%10_Minutes%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%Tutorial Complete%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%Engagement%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%Install%' then 'Install Campaign'
            when ${TABLE}.campaign_name like '%Creative%' then 'Install Campaign'
            when ${TABLE}.campaign_name like '%MAI%' then 'Install Campaign'
            when ${TABLE}.campaign_name like '%UAI%' then 'Install Campaign'
            when ${TABLE}.campaign_name like '%VAI%' then 'Install Campaign'
            when ${TABLE}.campaign_name like '%tCPI%' then 'Install Campaign'
            when ${TABLE}.campaign_name like '%No Event%' then 'Install Campaign'
            when ${TABLE}.campaign_name like '%Marketability%' then 'Install Campaign'
            when ${TABLE}.campaign_name like '%tCPA%' then 'Engagement Campaign'
            when ${TABLE}.campaign_name like '%ROAS%' then 'RoAS Campaign'
          else 'Other Campaign'
          end
        end
  "
}

constant: singular_campaign_name_override {
  value: "
  case

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2024-03-04' and '2024-03-27'
  then '20240307 - Android - Meta - USA - Purchase'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2024-01-03' and '2024-01-24'
  then '20240103 - Android - Meta - USA - Purchase'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2023-11-10' and '2023-11-14'
  then '20231110 - Android - Meta - USA - Install'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2023-10-30' and '2023-11-04'
  then '20231030 - Android - Meta - USA - Tutorial Complete'

  when
  singular_partner_name is null
  and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
  and platform like '%iOS%'
  and date(created_date) between '2023-10-19' and '2023-10-24'
  then '20231019 - Android - Meta - LATAM/ES - 30 Min'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country = 'US'
  and date(created_date) between '2023-01-30' and '2023-02-14'
  then '20230131 - Android - Meta - USA - Purchase'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
  and date(created_date) between '2023-04-11' and '2023-04-13'
  then 'Meta - AAA - LATAM/ES - 15 Min'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('AR','BO','BZ','CL','CO','CR','EC','SV','GT','HN','MX','NI','PA','PY', 'PE', 'UY', 'VE')
  and date(created_date) between '2023-04-14' and '2023-04-23'
  then '20230413 - Android - Meta - LATAM/ES - 15 Min'

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
  then '20230427 - Android - Meta - USA - 15 Min'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('US','CA')
  and date(created_date) between '2023-07-11' and '2023-07-12'
  then '20230710 - Android - Meta - USA - 30 Min'

  when
  singular_partner_name = 'Unattributed'
  and singular_campaign_id = ''
  and country in ('US','CA')
  and date(created_date) between '2023-07-21' and '2023-07-25'
  then '20230721 - Android - Meta - USA - 30 Min'

  else singular_campaign_name_mapped
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

constant: ad_reward_id_strings {
  value: "
  case
  when ${TABLE}.ad_reward_source_id = 'quick_boost_rocket' then 'Rocket'
  when ${TABLE}.ad_reward_source_id = 'quick_lives' then 'Lives'
  when ${TABLE}.ad_reward_source_id = 'quick_magnifiers' then 'Magnifiers'
  when ${TABLE}.ad_reward_source_id = 'treasure_trove' then 'Treasure Trove'
  when ${TABLE}.ad_reward_source_id = 'quick_boost_bomb' then 'Bomb'
  when ${TABLE}.ad_reward_source_id = 'quick_boost_color_ball' then 'Color Ball'
  else ${TABLE}.ad_reward_source_id
  end"
}

constant: ad_placements_for_ad_summary {
  value: "case

  when source_id like '%Castle_Climb%' then 'Castle Climb'
  when source_id like '%DailyReward' then 'Daily Reward'
  when source_id like '%Moves_Master%' then 'Moves Master'
  when source_id like '%Pizza%' then 'Pizza'
  when source_id like '%Lucky_Dice%' then 'Lucky Dice'
  when source_id like '%RequestHelp%' then 'Ask For Help'
  when source_id like '%Battle_Pass%' then 'Battle Pass'
  when source_id like '%Puzzles%' then 'Puzzles'
  when source_id like '%Go_Fish%' then 'Go Fish'
  when source_id like '%Gem_Quest%' then 'Gem Quest'
  when source_id like '%TreasureTrove%' then 'Treasure Trove'
  when source_id like '%Interstitial%' then 'Startup Interstitial'
  when source_id like '%EoR_Doubler%' then 'End of Round Doubler'

  when ad_reward_source_id = 'quick_boost_rocket' then 'Rocket'
  when ad_reward_source_id = 'quick_lives' then 'Lives'
  when ad_reward_source_id = 'quick_magnifiers' then 'Magnifiers'
  when ad_reward_source_id = 'treasure_trove' then 'Treasure Trove'
  when ad_reward_source_id = 'castle_climb_rescue' then 'Castle Climb'
  when ad_reward_source_id = 'quick_torches' then 'Gem Quest'
  when ad_reward_source_id = 'quick_boost_bomb' then 'Bomb'
  when ad_reward_source_id = 'quick_boost_color_ball' then 'Color Ball'

  else 'Unmapped'
  end"
}

constant: ad_placements_for_tickets_spend {
  value: "case

  when source_id like '%Castle_Climb%' then 'Castle Climb'
  when source_id like '%DailyReward' then 'Daily Reward'
  when source_id like '%Moves_Master%' then 'Moves Master'
  when source_id like '%Pizza%' then 'Pizza'
  when source_id like '%Lucky_Dice%' then 'Lucky Dice'
  when source_id like '%RequestHelp%' then 'Ask For Help'
  when source_id like '%Battle_Pass%' then 'Battle Pass'
  when source_id like '%Puzzles%' then 'Puzzles'
  when source_id like '%Go_Fish%' then 'Go Fish'
  when source_id like '%Gem_Quest%' then 'Gem Quest'
  when source_id like '%TreasureTrove%' then 'Treasure Trove'
  when source_id like '%Interstitial%' then 'Startup Interstitial'

  when source_id like '%DefaultRewardedVideo' then 'Generic Reward'
  when source_id like '%Rewarded' then 'Generic Reward'

  when source_id = 'quick_boost_rocket' then 'Rocket'
  when source_id = 'quick_lives' then 'Lives'
  when source_id = 'treasure_trove' then 'Treasure Trove'
  when source_id = 'quick_torches' then 'Gem Quest'
  when source_id = 'castle_climb_rescue' then 'Castle Climb'
  when source_id = 'quick_boost_bomb' then 'Bomb'
  when source_id = 'quick_boost_color_ball' then 'Color Ball'

  else source_id
  end"
}

###################################################################
# IAP Names
###################################################################

constant: iap_id_strings_new {
  value: "
  case
    when a.iap_id like 'item_001' then 'Free Ticket Machine'
    when a.iap_id like 'item_017' then 'Free Coin Machine'
    when a.iap_id like 'item_018' then 'Free Boost Machine'
    when a.iap_id like 'item_004' then 'Peewee Coin Capsule'
    when a.iap_id like 'item_005' then 'Small Coin Capsule'
    when a.iap_id like 'item_006' then 'Medium Coin Capsule'
    when a.iap_id like 'item_007' then 'Large Coin Capsule'
    when a.iap_id like 'item_020' then 'Huge Coin Capsule'
    when a.iap_id like 'item_021' then 'Jumbo Coin Capsule'
    when a.iap_id like 'item_008' then 'Peewee Gem Capsule'
    when a.iap_id like 'item_026' then 'Peewee Gem Capsule'
    when a.iap_id like 'item_009' then 'Small Gem Capsule'
    when a.iap_id like 'item_010' then 'Medium Gem Capsule'
    when a.iap_id like 'item_011' then 'Large Gem Capsule'
    when a.iap_id like 'item_012' then 'Huge Gem Capsule'
    when a.iap_id like 'item_013' then 'Jumbo Gem Capsule'
    when a.iap_id like 'item_023' then 'Peewee Life Pack'
    when a.iap_id like 'item_014' then 'Small Life Pack'
    when a.iap_id like 'item_015' then 'Medium Life Pack'
    when a.iap_id like 'item_016' then 'Large Life Pack'
    when a.iap_id like 'item_024' then 'Huge Life Pack'
    when a.iap_id like 'item_025' then 'Jumbo Life Pack'
    when a.iap_id like 'item_028' then '24h Infinite Lives'
    when a.iap_id = 'COLOR_BALL' then 'Color Ball Boost'
    when a.iap_id = 'BOMB' then 'Bomb Boost'
    when a.iap_id = 'ROCKET' then 'Rocket Boost'
    when a.iap_id = 'clear_cell' then 'Clear Cell Skill'
    when a.iap_id = 'clear_vertical' then '1x Clear Vertical Skill'
    when a.iap_id = 'clear_horizontal' then '1x Clear Horizontal Skill'

    when a.iap_id = 'item_clear_cell' then '1x Clear Cell Skill'
    when a.iap_id = 'item_clear_cell_bulk' then '5x Clear Cell Skill'
    when a.iap_id = 'item_clear_horizontal' then '1x Clear Horizontal Skill'
    when a.iap_id = 'item_clear_horizontal_bulk' then '5x Clear Horizontal Skill'
    when a.iap_id = 'item_clear_vertical' then '1x Clear Vertical Skill'
    when a.iap_id = 'item_clear_vertical_bulk' then '5x Clear Vertical Skill'
    when a.iap_id = 'item_shuffle' then '1x Shuffle Skill'
    when a.iap_id = 'item_shuffle_bulk' then '5x Shuffle Skill'
    when a.iap_id = 'item_chopsticks_bulk' then '5x Chopsticks Skill'
    when a.iap_id = 'item_skillet' then '1x Skillet Skill'
    when a.iap_id = 'item_skillet_bulk' then '5x Skillet Skill'
    when a.iap_id = 'item_disc' then '1x Disco Skill'
    when a.iap_id = 'item_disco_bulk' then '5x Disco Skill'

    when a.iap_id = 'item_disco_unlock' then 'Chum Chum Unlock: Karma Chameleon'

    when a.iap_id = 'item_rocket' then '1x Rocket Boost'
    when a.iap_id = 'item_rocket_bulk' then '8x Rocket Boost'
    when a.iap_id = 'item_color_ball' then '1x Color Ball Boost'
    when a.iap_id = 'item_color_ball_bulk' then '5x Color Ball Boost'
    when a.iap_id = 'item_bomb' then '1x Bomb Boost'
    when a.iap_id = 'item_bomb_bulk' then '6x Bomb Boost'
    when a.iap_id = 'extra_moves_5' then '5x Extra Moves'

    when a.iap_id = 'item_051' then 'Giant Power Up Pack!'

    when a.iap_id = 'item_052' then 'Hammer Chum Chums & Coins Special!'
    when a.iap_id = 'item_054' then 'Vertical Chum Chums & Coins Special!'
    when a.iap_id = 'item_053' then 'Horizontal Chum Chums & Coins Special!'
    when a.iap_id = 'item_075' then 'Shuffle Chum Chums & Coins Special!'
    when a.iap_id = 'item_095' then 'Skillet Chum Chums & Coins Special!'
    when a.iap_id = 'item_105' then 'Chopsticks Chum Chums & Coins Special!'
    when a.iap_id = 'item_088' then 'Karma Chum Chums & Coins Special!'

    when a.iap_id = 'item_055' then 'Coins (S)'
    when a.iap_id = 'item_056' then 'Coins (M)'
    when a.iap_id = 'item_057' then 'Coins (L)'
    when a.iap_id = 'item_097' then 'Coins (XL)'


    when a.iap_id = 'item_058' then 'Lives (S)'
    when a.iap_id = 'item_059' then 'Lives (M)'
    when a.iap_id = 'item_060' then 'Lives (L)'

    when a.iap_id = 'item_063' then 'Treasure Trove (XS)'
    when a.iap_id = 'item_066' then 'Treasure Trove (S)'
    when a.iap_id = 'item_069' then 'Treasure Trove (M)'
    when a.iap_id = 'item_072' then 'Treasure Trove (L)'
    when a.iap_id = 'item_099' then 'Treasure Trove (XL)'

    when a.iap_id = 'item_076' then 'Magnifiers (S)'
    when a.iap_id = 'item_077' then 'Magnifiers (M)'
    when a.iap_id = 'item_078' then 'Magnifiers (L)'

    when a.iap_id = 'item_089' then 'Level Bundle (100)'
    when a.iap_id = 'item_090' then 'Level Bundle (200)'
    when a.iap_id = 'item_091' then 'Level Bundle (300)'
    when a.iap_id = 'item_092' then 'Level Bundle (400)'
    when a.iap_id = 'item_098' then 'Level Bundle (500)'

    when a.iap_id = 'battle_pass' then 'Premium Battle Pass'

    when a.iap_id = 'item_ticket_basic' then 'Tickets (S)'
    when a.iap_id = 'item_ticket_premium' then 'Tickets (M)'
    when a.iap_id = 'item_ticket_mega' then 'Tickets (L)'

    when a.iap_id = 'item_bundle_100k5tick' then 'Item Bundle: 100K Coins 5 Tickets'
    when a.iap_id = 'item_bundle_3chums' then 'Item Bundle: 3 Chums'
    when a.iap_id = 'item_bundle_062024' then 'Item Bundle: Extra Moves, Coins, Tickets'
    when a.iap_id = 'item_chopsticks' then 'Chopsticks'

    when a.iap_id = 'item_bundle_halloween1' then 'Halloween: Grim Rewards 1 (Spender)'
    when a.iap_id = 'item_bundle_halloween2' then 'Halloween: Grim Rewards 2 (Non-Spender)'
    when a.iap_id = 'item_bundle_halloween3' then 'Halloween: Grim Rewards 3 (Spender)'
    when a.iap_id = 'item_bundle_halloween4' then 'Halloween: Grim Rewards 4 (Non-Spender Early Game)'
    when a.iap_id = 'item_bundle_halloween5' then 'Halloween: Grim Rewards 5 (Non-Spender Mid/Late Game)'

    when a.iap_id = 'item_121' then 'Halloween Treasure Trove: 4'
    when a.iap_id = 'item_118' then 'Halloween Treasure Trove: 3'
    when a.iap_id = 'item_114' then 'Halloween Treasure Trove: 2'
    when a.iap_id = 'item_109' then 'Halloween Treasure Trove: 1'




    else a.iap_id
  end"
}

constant: iap_id_strings_grouped_new {
  value: "
    case
      when a.iap_id = 'item_001' then 'Free Machine'
      when a.iap_id = 'item_017' then 'Free Machine'
      when a.iap_id = 'item_018' then 'Free Machine'
      when a.iap_id = 'item_004' then 'Coins'
      when a.iap_id = 'item_005' then 'Coins'
      when a.iap_id = 'item_006' then 'Coins'
      when a.iap_id = 'item_007' then 'Coins'
      when a.iap_id = 'item_020' then 'Coins'
      when a.iap_id = 'item_021' then 'Coins'
      when a.iap_id = 'item_057' then 'Coins'
      when a.iap_id = 'item_097' then 'Coins'
      when a.iap_id = 'item_008' then 'Gems'
      when a.iap_id = 'item_026' then 'Gems'
      when a.iap_id = 'item_009' then 'Gems'
      when a.iap_id = 'item_010' then 'Gems'
      when a.iap_id = 'item_011' then 'Gems'
      when a.iap_id = 'item_012' then 'Gems'
      when a.iap_id = 'item_013' then 'Gems'
      when a.iap_id = 'item_023' then 'Lives'
      when a.iap_id = 'item_014' then 'Lives'
      when a.iap_id = 'item_015' then 'Lives'
      when a.iap_id = 'item_016' then 'Lives'
      when a.iap_id = 'item_024' then 'Lives'
      when a.iap_id = 'item_025' then 'Lives'
      when a.iap_id = 'item_028' then 'Lives'
      when a.iap_id = 'item_037' then 'Lives & Coins Bundle'
      when a.iap_id = 'boost_001' then 'Boosts'
      when a.iap_id = 'boost_002' then 'Boosts'
      when a.iap_id = 'boost_003' then 'Boosts'
      when a.iap_id = 'boost_004' then 'Boosts'
      when a.iap_id = 'boost_005' then 'Boosts'
      when a.iap_id = 'boost_006' then 'Boosts'
      when a.iap_id = 'box_000' then 'Free Machine'
      when a.iap_id = 'box_004' then 'Free Machine'
      when a.iap_id = 'box_005' then 'Free Machine'

      when a.iap_id like '%clear_cell%' then 'Chum Chum Skills'
      when a.iap_id like '%clear_horizontal%' then 'Chum Chum Skills'
      when a.iap_id like '%clear_vertical%' then 'Chum Chum Skills'
      when a.iap_id = 'item_shuffle' then 'Chum Chum Skills'
      when a.iap_id = 'item_shuffle_bulk' then 'Chum Chum Skills'
      when a.iap_id = 'item_chopsticks_bulk' then 'Chum Chum Skills'
      when a.iap_id = 'item_skillet' then 'Chum Chum Skills'
      when a.iap_id = 'item_skillet_bulk' then 'Chum Chum Skills'
      when a.iap_id = 'item_disc' then 'Chum Chum Skills'
      when a.iap_id = 'item_disco_bulk' then 'Chum Chum Skills'

      when a.iap_id like '%bomb%' then 'Pre-Game Boosts'
      when a.iap_id like '%rocket%' then 'Pre-Game Boosts'
      when a.iap_id like '%color_ball%' then 'Pre-Game Boosts'
      when a.iap_id like '%zone%' then 'Zone Restoration'
      when a.iap_id like '%extra_moves%' then 'Extra Moves'

      when a.iap_id = 'item_051' then 'Giant Power Up Pack!'

      when a.iap_id = 'item_052' then 'Chum Chums & Coins'
      when a.iap_id = 'item_054' then 'Chum Chums & Coins'
      when a.iap_id = 'item_053' then 'Chum Chums & Coins'
      when a.iap_id = 'item_075' then 'Chum Chums & Coins'
      when a.iap_id = 'item_095' then 'Chum Chums & Coins'
      when a.iap_id = 'item_105' then 'Chum Chums & Coins'
      when a.iap_id = 'item_088' then 'Chum Chums & Coins'

      when a.iap_id = 'item_055' then 'Coins'
      when a.iap_id = 'item_056' then 'Coins'
      when a.iap_id = 'item_057' then 'Coins'
      when a.iap_id = 'item_097' then 'Coins'

      when a.iap_id = 'item_058' then 'Lives'
      when a.iap_id = 'item_059' then 'Lives'
      when a.iap_id = 'item_060' then 'Lives'

      when a.iap_id = 'item_063' then 'Treasure Trove'
      when a.iap_id = 'item_066' then 'Treasure Trove'
      when a.iap_id = 'item_069' then 'Treasure Trove'
      when a.iap_id = 'item_072' then 'Treasure Trove'
      when a.iap_id = 'item_099' then 'Treasure Trove'

      when a.iap_id = 'item_076' then 'Magnifiers'
      when a.iap_id = 'item_077' then 'Magnifiers'
      when a.iap_id = 'item_078' then 'Magnifiers'

      when a.iap_id = 'item_089' then 'Level Bundle'
      when a.iap_id = 'item_090' then 'Level Bundle'
      when a.iap_id = 'item_091' then 'Level Bundle'
      when a.iap_id = 'item_092' then 'Level Bundle'
      when a.iap_id = 'item_098' then 'Level Bundle'

      when a.iap_id = 'battle_pass' then 'Premium Battle Pass'

      when a.iap_id = 'item_ticket_basic' then 'Tickets'
      when a.iap_id = 'item_ticket_premium' then 'Tickets'
      when a.iap_id = 'item_ticket_mega' then 'Tickets'

      when a.iap_id = 'item_disco_unlock' then 'Chum Chum Unlock'

    when a.iap_id = 'item_bundle_100k5tick' then 'Item Bundles'
    when a.iap_id = 'item_bundle_3chums' then 'Item Bundles'
    when a.iap_id = 'item_bundle_062024' then 'Item Bundles'
    when a.iap_id = 'item_chopsticks' then 'Chum Chum Skills'

    when a.iap_id = 'item_bundle_halloween1' then 'Halloween Offers'
    when a.iap_id = 'item_bundle_halloween2' then 'Halloween Offers'
    when a.iap_id = 'item_bundle_halloween3' then 'Halloween Offers'
    when a.iap_id = 'item_bundle_halloween4' then 'Halloween Offers'
    when a.iap_id = 'item_bundle_halloween5' then 'Halloween Offers'

    when a.iap_id = 'item_121' then 'Halloween: Treasure Trove'
    when a.iap_id = 'item_118' then 'Halloween: Treasure Trove'
    when a.iap_id = 'item_114' then 'Halloween: Treasure Trove'
    when a.iap_id = 'item_109' then 'Halloween: Treasure Trove'

      else a.iap_id
  end"
}



###################################################################
# In App Messenging
###################################################################

constant: iam_type {
  value: "
  case
  when ${TABLE}.button_tag like 'Sheet_InAppMessaging%' then 'IAM'
  when ${TABLE}.button_tag like 'Sheet_PM_%' then 'Popup'

  else 'UnMapped'
  end"
}

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

    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_BoostEquip.' then 'Boost Equip'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_IAP_bundle.' then 'IAP Bundle'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Toaster.Close' then 'Toaster'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Notifications.IAM' then 'Notifications'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Chameleon.IAM' then 'Chameleon'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Chameleon.Close' then 'Chameleon'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Spring.' then 'MTXOffer: Spring'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Spring.Close' then 'MTXOffer: Spring'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Lemonade.' then 'MTXOffer: Lemonade'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Lemonade.Close' then 'MTXOffer: Lemonade'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Survey.' then 'Survey'

    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Ad.ShowAd' then 'ShowAd'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Discounted.' then 'MTXOffer: Discounted'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Discounted.Close' then 'MTXOffer: Discounted'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Halloween.' then 'MTXOffer: Halloween'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Halloween.Close' then 'MTXOffer: Halloween'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_StarterOffer.' then 'MTXOffer: StarterOffer'
    when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_StarterOffer.Close' then 'MTXOffer: StarterOffer'
    when ${TABLE}.button_tag = 'Sheet_PM_BattlePass.Close' then 'BattlePass'
    when ${TABLE}.button_tag = 'Sheet_PM_BattlePass.Continue' then 'BattlePass'
    when ${TABLE}.button_tag = 'Sheet_PM_CastleClimb.Close' then 'CastleClimb'
    when ${TABLE}.button_tag = 'Sheet_PM_CastleClimb.Continue' then 'CastleClimb'
    when ${TABLE}.button_tag = 'Sheet_PM_DailyReward.Close' then 'DailyReward'
    when ${TABLE}.button_tag = 'Sheet_PM_DailyReward.Continue' then 'DailyReward'
    when ${TABLE}.button_tag = 'Sheet_PM_DonutSprint.Close' then 'DonutSprint'
    when ${TABLE}.button_tag = 'Sheet_PM_DonutSprint.Continue' then 'DonutSprint'
    when ${TABLE}.button_tag = 'Sheet_PM_FlourFrenzy.Close' then 'FlourFrenzy'
    when ${TABLE}.button_tag = 'Sheet_PM_FlourFrenzy.Continue' then 'FlourFrenzy'
    when ${TABLE}.button_tag = 'Sheet_PM_FoodTruck.Close' then 'FoodTruck'
    when ${TABLE}.button_tag = 'Sheet_PM_FoodTruck.Continue' then 'FoodTruck'
    when ${TABLE}.button_tag = 'Sheet_PM_GemQuest.Close' then 'GemQuest'
    when ${TABLE}.button_tag = 'Sheet_PM_GemQuest.Continue' then 'GemQuest'
    when ${TABLE}.button_tag = 'Sheet_PM_GoFish.Close' then 'GoFish'
    when ${TABLE}.button_tag = 'Sheet_PM_GoFish.Continue' then 'GoFish'
    when ${TABLE}.button_tag = 'Sheet_PM_HotdogContest.Close' then 'HotdogContest'
    when ${TABLE}.button_tag = 'Sheet_PM_HotdogContest.Continue' then 'HotdogContest'
    when ${TABLE}.button_tag = 'Sheet_PM_LuckyDice.Close' then 'LuckyDice'
    when ${TABLE}.button_tag = 'Sheet_PM_LuckyDice.Continue' then 'LuckyDice'
    when ${TABLE}.button_tag = 'Sheet_PM_MovesMaster.Close' then 'MovesMaster'
    when ${TABLE}.button_tag = 'Sheet_PM_MovesMaster.Continue' then 'MovesMaster'
    when ${TABLE}.button_tag = 'Sheet_PM_PizzaTime.Close' then 'PizzaTime'
    when ${TABLE}.button_tag = 'Sheet_PM_PizzaTime.Continue' then 'PizzaTime'
    when ${TABLE}.button_tag = 'Sheet_PM_Puzzle.Close' then 'Puzzle'
    when ${TABLE}.button_tag = 'Sheet_PM_Puzzle.Continue' then 'Puzzle'
    when ${TABLE}.button_tag = 'Sheet_PM_Puzzles.Close' then 'Puzzle'
    when ${TABLE}.button_tag = 'Sheet_PM_Puzzles.Continue' then 'Puzzle'
    when ${TABLE}.button_tag = 'Sheet_PM_TreasureTrove.Close' then 'TreasureTrove'
    when ${TABLE}.button_tag = 'Sheet_PM_TreasureTrove.Continue' then 'TreasureTrove'
    when ${TABLE}.button_tag = 'Sheet_PM_UpdateApp.Close' then 'UpdateApp'
    when ${TABLE}.button_tag = 'Sheet_PM_UpdateApp.Continue' then 'UpdateApp'


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

  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_BoostEquip.' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_IAP_bundle.' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Toaster.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Notifications.IAM' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Chameleon.IAM' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Chameleon.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Spring.' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Spring.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Lemonade.' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Lemonade.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Survey.' then 0

  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_Ad.ShowAd' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Discounted.' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Discounted.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Halloween.' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_Halloween.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_StarterOffer.' then 1
  when ${TABLE}.button_tag = 'Sheet_InAppMessaging_MTXOffer_StarterOffer.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_BattlePass.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_BattlePass.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_CastleClimb.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_CastleClimb.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_DailyReward.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_DailyReward.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_DonutSprint.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_DonutSprint.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_FlourFrenzy.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_FlourFrenzy.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_FoodTruck.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_FoodTruck.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_GemQuest.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_GemQuest.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_GoFish.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_GoFish.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_HotdogContest.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_HotdogContest.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_LuckyDice.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_LuckyDice.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_MovesMaster.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_MovesMaster.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_PizzaTime.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_PizzaTime.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_Puzzle.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_Puzzle.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_Puzzles.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_Puzzles.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_TreasureTrove.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_TreasureTrove.Continue' then 1
  when ${TABLE}.button_tag = 'Sheet_PM_UpdateApp.Close' then 0
  when ${TABLE}.button_tag = 'Sheet_PM_UpdateApp.Continue' then 1

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

    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'battle_pass' then 'Battle Pass'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'castle_climb' then 'Castle Climb'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'donut_sprint' then 'Donut Sprint'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_apple_tree' then 'Apple Tree'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_honey' then 'Honey'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_ice_cream' then 'Ice Cream'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_oven' then 'Oven'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_pumpkin' then 'Pumpkin'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'gem_quest' then 'Gem Quest'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'head_2_head' then 'Go Fish'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_051' then 'Bomb'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_051' then 'Color Ball'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_051' then 'Rocket'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_059' then 'Lives'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_060' then 'Lives'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_088' then 'Chopsticks'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_095' then 'Skillet'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_098' then 'Item 098'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_099' then 'Treasure Trove'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_105' then 'Disco'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bomb' then 'Bomb'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bomb_bulk' then 'Bomb'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bundle_062024' then 'Bundle 062024'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bundle_100k5tick' then 'Bundle 100K Tick'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bundle_3chums' then 'Bundle 3 Chums'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_chopsticks' then 'Chopsticks'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_chopsticks_bulk' then 'Chopsticks Bulk'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_cell' then 'Clear Cell'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_cell_bulk' then 'Clear Cell Bulk'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_horizontal' then 'Clear Horizontal'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_horizontal_bulk' then 'Clear Horizontal Bulk'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_vertical' then 'Clear Vertical'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_vertical_bulk' then 'Clear Vertical Bulk'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_color_ball' then 'Color Ball'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_color_ball_bulk' then 'Color Ball Bulk'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_disco_unlock' then 'Disco Unlock'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_disco_unlock' then 'Disco Unlock'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_disco_unlock' then 'Disco Unlock'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_rocket_bulk' then 'Rocket Bulk'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_shuffle' then 'Shuffle'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_shuffle_bulk' then 'Shuffle Bulk'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_skillet' then 'Skillet'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_ticket_basic' then 'Tickets Basic'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_ticket_mega' then 'Tickets Mega'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_ticket_premium' then 'Tickets Premium'

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

    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'battle_pass' then 'Battle Pass'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'castle_climb' then 'Live Ops'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'donut_sprint' then 'Live Ops'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_apple_tree' then 'Food Truck'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_honey' then 'Food Truck'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_ice_cream' then 'Food Truck'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_oven' then 'Food Truck'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'food_truck_pumpkin' then 'Food Truck'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'gem_quest' then 'Gem Quest'
    when ${TABLE}.coin_source_type = 'reward' and ${TABLE}.coin_source_iap_item = 'head_2_head' then 'Go Fish'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_051' then 'Boosts'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_051' then 'Boosts'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_051' then 'Boosts'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_059' then 'Lives'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_060' then 'Lives'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_088' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_095' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_098' then 'IAM Offers'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_099' then 'Treasure Trove'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_105' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bomb' then 'Boosts'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bomb_bulk' then 'Boosts'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bundle_062024' then 'IAM Offers'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bundle_100k5tick' then 'Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_bundle_3chums' then 'IAM Offers'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_chopsticks' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_chopsticks_bulk' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_cell' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_cell_bulk' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_horizontal' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_horizontal_bulk' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_vertical' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_clear_vertical_bulk' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_color_ball' then 'Boosts'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_color_ball_bulk' then 'Boosts'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_disco_unlock' then 'Unlock Character'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_disco_unlock' then 'IAM Offers'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_disco_unlock' then 'IAM Offers'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_rocket_bulk' then 'Boosts'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_shuffle' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_shuffle_bulk' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_skillet' then 'Chum Chums and Coins'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_ticket_basic' then 'Tickets'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_ticket_mega' then 'Tickets'
    when ${TABLE}.coin_source_type = 'transaction' and ${TABLE}.coin_source_iap_item = 'item_ticket_premium' then 'Tickets'


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
when a.source_id = 'menu' and a.iap_id = 'menu' then 'Menu'
when a.source_id = 'plot_02' and a.iap_id = 'plot_02' then 'Plot 02'
when a.source_id = 'plot_08' and a.iap_id = 'plot_08' then 'Plot 08'
when a.source_id = 'plot_04' and a.iap_id = 'plot_04' then 'Plot 04'
when a.source_id = 'plot_06' and a.iap_id = 'plot_06' then 'Plot 06'
when a.source_id = 'plot_05' and a.iap_id = 'plot_05' then 'Plot 05'
when a.source_id = 'oven' and a.iap_id = 'oven' then 'Oven'
when a.source_id = 'croissant_table' and a.iap_id = 'croissant_table' then 'Croissant Table'
when a.source_id = 'honey' and a.iap_id = 'honey' then 'Honey'
when a.source_id = 'apple_tree' and a.iap_id = 'apple_tree' then 'Apple Tree'
when a.source_id = 'ice_cream' and a.iap_id = 'ice_cream' then 'Ice Cream'
when a.source_id = 'plot_03' and a.iap_id = 'plot_03' then 'Plot 03'
when a.source_id = 'donut_table' and a.iap_id = 'donut_table' then 'Donut Table'
when a.source_id = 'plot_07' and a.iap_id = 'plot_07' then 'Plot 07'
when a.source_id = 'plot_13' and a.iap_id = 'plot_13' then 'Plot 13'
when a.source_id = 'plot_14' and a.iap_id = 'plot_14' then 'Plot 14'
when a.source_id = 'plot_09' and a.iap_id = 'plot_09' then 'Plot 09'
when a.source_id = 'plot_11' and a.iap_id = 'plot_11' then 'Plot 11'
when a.source_id = 'picnic' and a.iap_id = 'picnic' then 'Picnic'
when a.source_id = 'tree_stump' and a.iap_id = 'tree_stump' then 'Tree Stump'
when a.source_id = 'sign' and a.iap_id = 'sign' then 'Sign'
when a.source_id = 'tea_table' and a.iap_id = 'tea_table' then 'Tea Table'
when a.source_id = 'hay' and a.iap_id = 'hay' then 'Hay'
when a.source_id = 'bush' and a.iap_id = 'bush' then 'Bush'


    when a.source_id = 'castle_climb_rescue' and a.iap_id = 'item_rescue' then 'Castle Climb Rescue'
    when a.source_id = 'character' and a.iap_id = 'item_moves_unlock' then 'Moves Bunny Unlock'
    when a.source_id = 'extra_moves_12' and a.iap_id = 'extra_moves_12' then 'Extra Moves'
    when a.source_id = 'extra_moves_15' and a.iap_id = 'extra_moves_15' then 'Extra Moves'
    when a.source_id = 'extra_moves_9' and a.iap_id = 'extra_moves_9' then 'Extra Moves'
    when a.source_id = 'gem_quest' and a.iap_id = 'item_torch' then 'Gem Quest Torch'
    when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'item_002' then 'Legacy'
    when a.source_id = 'Panel_Store.Purchase.item_019' and a.iap_id = 'item_019' then 'Extra Moves'
    when a.source_id = 'quick_skill_disco' and a.iap_id = 'item_disco' then 'Disco Chameleon'
    when a.source_id = 'quick_skill_disco' and a.iap_id = 'item_disco_bulk' then 'Disco Chameleon'
    when a.source_id = 'quick_skill_moves' and a.iap_id = 'item_moves' then 'Moves Bunny'
    when a.source_id = 'quick_skill_moves' and a.iap_id = 'item_moves_bulk' then 'Moves Bunny'

    when a.source_id = 'extra_moves_7' and a.iap_id = 'extra_moves_7' then 'Extra Moves'
    when a.source_id = 'character' and a.iap_id = 'item_skillet_unlock' then 'Skillet Unlock'
    when a.source_id = 'extra_moves_10' and a.iap_id = 'extra_moves_10' then 'Extra Moves'
    when a.source_id = 'quick_skill_skillet' and a.iap_id = 'item_skillet_bulk' then 'Skillet'
    when a.source_id = 'quick_skill_chopsticks' and a.iap_id = 'item_chopsticks_bulk' then 'Chopsticks'
    when a.source_id = 'quick_skill_chopsticks' and a.iap_id = 'item_chopsticks' then 'Chopsticks'
    when a.source_id = 'request_help' and a.iap_id = 'request_help' then 'Request Help'
    when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'item_022' then 'Legacy'
    when a.source_id = 'quick_skill_skillet' and a.iap_id = 'item_skillet' then 'Skillet'
    when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'item_003' then 'Legacy'
    when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'item_002' then 'Legacy'
    when a.source_id = 'Panel_Store.Purchase.item_003' and a.iap_id = 'item_003' then 'Legacy'
    when a.source_id is null and a.iap_id = 'item_clear_cell' then 'Clear Cell'
    when a.source_id is null and a.iap_id = 'item_clear_horizontal' then 'Clear Horizontal'

   when a.source_id = 'extra_moves_5' and a.iap_id = 'extra_moves_5' then 'Extra Moves'
   when a.source_id = 'quick_lives' and a.iap_id = 'item_059' then 'Lives'
   when a.source_id = 'quick_lives' and a.iap_id = 'item_058' then 'Lives'
   when a.source_id = 'quick_lives' and a.iap_id = 'item_060' then 'Lives'
   when a.source_id = 'quick_skill_clear_cell' and a.iap_id = 'item_clear_cell' then 'Clear Cell'
   when a.source_id = 'quick_skill_clear_vertical' and a.iap_id = 'item_clear_vertical' then 'Clear Verticle'
   when a.source_id = 'quick_skill_clear_horizontal' and a.iap_id = 'item_clear_horizontal' then 'Clear Horizontal'
   when a.source_id = 'quick_skill_clear_vertical' and a.iap_id = 'item_clear_vertical_bulk' then 'Clear Verticle'
   when a.source_id = 'quick_magnifiers' and a.iap_id = 'item_077' then 'Magnifiers'
   when a.source_id = 'quick_skill_clear_horizontal' and a.iap_id = 'item_clear_horizontal_bulk' then 'Clear Horizontal'
   when a.source_id = 'quick_boost_color_ball' and a.iap_id = 'item_color_ball_bulk' then 'Color Ball'
   when a.source_id = 'quick_skill_clear_cell' and a.iap_id = 'item_clear_cell_bulk' then 'Clear Cell'
   when a.source_id = 'quick_boost_color_ball' and a.iap_id = 'item_color_ball' then 'Color Ball'
   when a.source_id = 'quick_boost_bomb' and a.iap_id = 'item_bomb' then 'Bomb'
   when a.source_id = 'quick_boost_bomb' and a.iap_id = 'item_bomb_bulk' then 'Bomb'
   when a.source_id = 'quick_magnifiers' and a.iap_id = 'item_078' then 'Magnifiers'
   when a.source_id = 'quick_boost_rocket' and a.iap_id = 'item_rocket' then 'Rocket'
   when a.source_id = 'quick_skill_shuffle' and a.iap_id = 'item_shuffle' then 'Shuffle'
   when a.source_id = 'quick_boost_rocket' and a.iap_id = 'item_rocket_bulk' then 'Rocket'
   when a.source_id = 'quick_skill_shuffle' and a.iap_id = 'item_shuffle_bulk' then 'Shuffle'
   when a.source_id = 'character' and a.iap_id = 'item_chopsticks_unlock' then 'Chopsticks Unlock'
   when a.source_id = 'quick_magnifiers' and a.iap_id = 'item_076' then 'Magnifiers'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_clear_vertical' then 'Clear Verticle'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_clear_horizontal' then 'Clear Horizontal'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_clear_cell' then 'Clear Cell'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_color_ball' then 'Color Ball'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_rocket' then 'Rocket'
   when a.source_id = 'Panel_Store.Purchase.item_003' and a.iap_id = 'box_001' then 'Legacy'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_bomb' then 'Bomb'
   when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'box_007' then 'Legacy'
   when a.source_id = 'COLOR_BALL' and a.iap_id = '' then 'Color Ball'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.FIVE_TO_FOUR' and a.iap_id = 'boost_006' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_019' and a.iap_id = 'box_002' then 'Legacy'
   when a.source_id = 'BOMB' and a.iap_id = '' then 'Bomb'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.BUBBLE' and a.iap_id = 'boost_005' then 'Legacy'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'clear_vertical' then 'Clear Verticle'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'clear_horizontal' then 'Clear Horizontal'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'box_006' then 'Legacy'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'COLOR_BALL' then 'Color Ball'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'clear_cell' then 'Clear Cell'
   when a.source_id = 'ROCKET' and a.iap_id = '' then 'Rocket'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.TIME' and a.iap_id = 'boost_004' then 'Legacy'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.EXP' and a.iap_id = 'boost_003' then 'Legacy'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.COIN' and a.iap_id = 'boost_002' then 'Legacy'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'ROCKET' then 'Rocket'
   when a.source_id = 'clear_cell' and a.iap_id = '' then 'Clear Cell'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.SCORE' and a.iap_id = 'boost_001' then 'Legacy'
   when a.source_id = 'clear_horizontal' and a.iap_id = '' then 'Clear Horizontal'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'BOMB' then 'Bomb'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'box_006' then 'Legacy'
   when a.source_id = 'clear_vertical' and a.iap_id = '' then 'Clear Verticle'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'box_002' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'box_002' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'box_006' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'item_019' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'box_002' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'box_007' then 'Legacy'
   when a.source_id = 'BUBBLE' and a.iap_id = '' then 'Legacy'
   when a.source_id = 'FIVE_TO_FOUR' and a.iap_id = '' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'box_001' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'box_007' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'item_003' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'item_003' then 'Legacy'
   when a.source_id = 'TIME' and a.iap_id = '' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'item_002' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_018' and a.iap_id = 'box_007' then 'Legacy'
   when a.source_id = 'FIVE_TO_FOUR' and a.iap_id = 'boost_006' then 'Legacy'
   when a.source_id = 'BUBBLE' and a.iap_id = 'boost_005' then 'Legacy'
   when a.source_id = 'TIME' and a.iap_id = 'boost_004' then 'Legacy'


  when a.source_id like 'Panel_Store.Purchase.item_%' then 'Legacy'
  else 'Unmapped'
  end
  "
}

constant: coin_spend_name_group {
  value: "
  case

    when a.source_id = 'plot_02' and a.iap_id = 'plot_02' then 'Food Truck'
    when a.source_id = 'plot_08' and a.iap_id = 'plot_08' then 'Food Truck'
    when a.source_id = 'plot_04' and a.iap_id = 'plot_04' then 'Food Truck'
    when a.source_id = 'plot_06' and a.iap_id = 'plot_06' then 'Food Truck'
    when a.source_id = 'plot_05' and a.iap_id = 'plot_05' then 'Food Truck'
    when a.source_id = 'oven' and a.iap_id = 'oven' then 'Food Truck'
    when a.source_id = 'menu' and a.iap_id = 'menu' then 'Food Truck'
    when a.source_id = 'croissant_table' and a.iap_id = 'croissant_table' then 'Food Truck'
    when a.source_id = 'honey' and a.iap_id = 'honey' then 'Food Truck'
    when a.source_id = 'apple_tree' and a.iap_id = 'apple_tree' then 'Food Truck'
    when a.source_id = 'ice_cream' and a.iap_id = 'ice_cream' then 'Food Truck'
    when a.source_id = 'plot_03' and a.iap_id = 'plot_03' then 'Food Truck'
    when a.source_id = 'donut_table' and a.iap_id = 'donut_table' then 'Food Truck'
    when a.source_id = 'plot_07' and a.iap_id = 'plot_07' then 'Food Truck'
    when a.source_id = 'plot_13' and a.iap_id = 'plot_13' then 'Food Truck'
    when a.source_id = 'plot_14' and a.iap_id = 'plot_14' then 'Food Truck'
    when a.source_id = 'plot_09' and a.iap_id = 'plot_09' then 'Food Truck'
    when a.source_id = 'plot_11' and a.iap_id = 'plot_11' then 'Food Truck'
    when a.source_id = 'picnic' and a.iap_id = 'picnic' then 'Food Truck'
    when a.source_id = 'tree_stump' and a.iap_id = 'tree_stump' then 'Food Truck'
    when a.source_id = 'sign' and a.iap_id = 'sign' then 'Food Truck'
    when a.source_id = 'tea_table' and a.iap_id = 'tea_table' then 'Food Truck'
    when a.source_id = 'hay' and a.iap_id = 'hay' then 'Food Truck'
    when a.source_id = 'bush' and a.iap_id = 'bush' then 'Food Truck'

    when a.source_id = 'castle_climb_rescue' and a.iap_id = 'item_rescue' then 'Castle Climb'
    when a.source_id = 'character' and a.iap_id = 'item_moves_unlock' then 'New Chum Chum'
    when a.source_id = 'extra_moves_12' and a.iap_id = 'extra_moves_12' then 'Extra Moves'
    when a.source_id = 'extra_moves_15' and a.iap_id = 'extra_moves_15' then 'Extra Moves'
    when a.source_id = 'extra_moves_9' and a.iap_id = 'extra_moves_9' then 'Extra Moves'
    when a.source_id = 'gem_quest' and a.iap_id = 'item_torch' then 'Gem Quest'
    when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'item_002' then 'Legacy'
    when a.source_id = 'Panel_Store.Purchase.item_019' and a.iap_id = 'item_019' then 'Extra Moves'
    when a.source_id = 'quick_skill_disco' and a.iap_id = 'item_disco' then 'Chum Chum Skill'
    when a.source_id = 'quick_skill_disco' and a.iap_id = 'item_disco_bulk' then 'Chum Chum Skill'
    when a.source_id = 'quick_skill_moves' and a.iap_id = 'item_moves' then 'Chum Chum Skill'
    when a.source_id = 'quick_skill_moves' and a.iap_id = 'item_moves_bulk' then 'Chum Chum Skill'

    when a.source_id = 'extra_moves_7' and a.iap_id = 'extra_moves_7' then 'Extra Moves'
    when a.source_id = 'character' and a.iap_id = 'item_skillet_unlock' then 'New Chum Chum'
    when a.source_id = 'extra_moves_10' and a.iap_id = 'extra_moves_10' then 'Extra Moves'
    when a.source_id = 'quick_skill_skillet' and a.iap_id = 'item_skillet_bulk' then 'Chum Chum Skill'
    when a.source_id = 'quick_skill_chopsticks' and a.iap_id = 'item_chopsticks_bulk' then 'Chum Chum Skill'
    when a.source_id = 'quick_skill_chopsticks' and a.iap_id = 'item_chopsticks' then 'Chum Chum Skill'
    when a.source_id = 'request_help' and a.iap_id = 'request_help' then 'Ask For Help'
    when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'item_022' then 'Legacy'
    when a.source_id = 'quick_skill_skillet' and a.iap_id = 'item_skillet' then 'Chum Chum Skill'
    when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'item_003' then 'Legacy'
    when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'item_002' then 'Legacy'
    when a.source_id = 'Panel_Store.Purchase.item_003' and a.iap_id = 'item_003' then 'Legacy'
    when a.source_id is null and a.iap_id = 'item_clear_cell' then 'Chum Chum Skill'
    when a.source_id is null and a.iap_id = 'item_clear_horizontal' then 'Chum Chum Skill'

   when a.source_id = 'extra_moves_5' and a.iap_id = 'extra_moves_5' then 'Extra Moves'
   when a.source_id = 'quick_lives' and a.iap_id = 'item_059' then 'Lives'
   when a.source_id = 'quick_lives' and a.iap_id = 'item_058' then 'Lives'
   when a.source_id = 'quick_lives' and a.iap_id = 'item_060' then 'Lives'
   when a.source_id = 'quick_skill_clear_cell' and a.iap_id = 'item_clear_cell' then 'Chum Chum Skill'
   when a.source_id = 'quick_skill_clear_vertical' and a.iap_id = 'item_clear_vertical' then 'Chum Chum Skill'
   when a.source_id = 'quick_skill_clear_horizontal' and a.iap_id = 'item_clear_horizontal' then 'Chum Chum Skill'
   when a.source_id = 'quick_skill_clear_vertical' and a.iap_id = 'item_clear_vertical_bulk' then 'Chum Chum Skill'
   when a.source_id = 'quick_magnifiers' and a.iap_id = 'item_077' then 'Magnifiers'
   when a.source_id = 'quick_skill_clear_horizontal' and a.iap_id = 'item_clear_horizontal_bulk' then 'Chum Chum Skill'
   when a.source_id = 'quick_boost_color_ball' and a.iap_id = 'item_color_ball_bulk' then 'Boost'
   when a.source_id = 'quick_skill_clear_cell' and a.iap_id = 'item_clear_cell_bulk' then 'Chum Chum Skill'
   when a.source_id = 'quick_boost_color_ball' and a.iap_id = 'item_color_ball' then 'Boost'
   when a.source_id = 'quick_boost_bomb' and a.iap_id = 'item_bomb' then 'Boost'
   when a.source_id = 'quick_boost_bomb' and a.iap_id = 'item_bomb_bulk' then 'Boost'
   when a.source_id = 'quick_magnifiers' and a.iap_id = 'item_078' then 'Magnifiers'
   when a.source_id = 'quick_boost_rocket' and a.iap_id = 'item_rocket' then 'Boost'
   when a.source_id = 'quick_skill_shuffle' and a.iap_id = 'item_shuffle' then 'Chum Chum Skill'
   when a.source_id = 'quick_boost_rocket' and a.iap_id = 'item_rocket_bulk' then 'Boost'
   when a.source_id = 'quick_skill_shuffle' and a.iap_id = 'item_shuffle_bulk' then 'Chum Chum Skill'
   when a.source_id = 'character' and a.iap_id = 'item_chopsticks_unlock' then 'New Chum Chum'
   when a.source_id = 'quick_magnifiers' and a.iap_id = 'item_076' then 'Magnifiers'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_clear_vertical' then 'Chum Chum Skill'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_clear_horizontal' then 'Chum Chum Skill'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_clear_cell' then 'Chum Chum Skill'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_color_ball' then 'Boost'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_rocket' then 'Boost'
   when a.source_id = 'Panel_Store.Purchase.item_003' and a.iap_id = 'box_001' then 'Legacy'
   when a.source_id = 'auto_purchase' and a.iap_id = 'item_bomb' then 'Boost'
   when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'box_007' then 'Legacy'
   when a.source_id = 'COLOR_BALL' and a.iap_id = '' then 'Boost'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.FIVE_TO_FOUR' and a.iap_id = 'boost_006' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_019' and a.iap_id = 'box_002' then 'Legacy'
   when a.source_id = 'BOMB' and a.iap_id = '' then 'Boost'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.BUBBLE' and a.iap_id = 'boost_005' then 'Legacy'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'clear_vertical' then 'Chum Chum Skill'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'clear_horizontal' then 'Chum Chum Skill'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'box_006' then 'Legacy'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'COLOR_BALL' then 'Boost'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'clear_cell' then 'Chum Chum Skill'
   when a.source_id = 'ROCKET' and a.iap_id = '' then 'Boost'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.TIME' and a.iap_id = 'boost_004' then 'Legacy'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.EXP' and a.iap_id = 'boost_003' then 'Legacy'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.COIN' and a.iap_id = 'boost_002' then 'Legacy'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'ROCKET' then 'Boost'
   when a.source_id = 'clear_cell' and a.iap_id = '' then 'Chum Chum Skill'
   when a.source_id = 'Panel_Boosts_V3.BoostUI.SCORE' and a.iap_id = 'boost_001' then 'Legacy'
   when a.source_id = 'clear_horizontal' and a.iap_id = '' then 'Chum Chum Skill'
   when a.source_id = 'Sheet_Boost_Purchase' and a.iap_id = 'BOMB' then 'Boost'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'box_006' then 'Legacy'
   when a.source_id = 'clear_vertical' and a.iap_id = '' then 'Chum Chum Skill'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'box_002' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'box_002' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'box_006' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'item_019' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_002' and a.iap_id = 'box_002' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'box_007' then 'Legacy'
   when a.source_id = 'BUBBLE' and a.iap_id = '' then 'Legacy'
   when a.source_id = 'FIVE_TO_FOUR' and a.iap_id = '' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'box_001' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'box_007' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_001' and a.iap_id = 'item_003' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'item_003' then 'Legacy'
   when a.source_id = 'TIME' and a.iap_id = '' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_017' and a.iap_id = 'item_002' then 'Legacy'
   when a.source_id = 'Panel_Store.Purchase.item_018' and a.iap_id = 'box_007' then 'Legacy'
   when a.source_id = 'FIVE_TO_FOUR' and a.iap_id = 'boost_006' then 'Legacy'
   when a.source_id = 'BUBBLE' and a.iap_id = 'boost_005' then 'Legacy'
   when a.source_id = 'TIME' and a.iap_id = 'boost_004' then 'Legacy'

  when a.source_id like 'Panel_Store.Purchase.item_%' then 'Legacy'
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


constant: creative_name_mapping {
  value: "
  case

    when creative_name like '%Zen%' then 'Zen'
    when creative_name like '%WeirdTreats%' then 'WeirdTreats'
    when creative_name like '%WeirdTeddyDog%' then 'WeirdTeddyDog'
    when creative_name like '%WeirdTeddyBear%' then 'WeirdTeddyBear'
    when creative_name like '%TiltingTableDangerous%' then 'TiltingTableDangerous'
    when creative_name like '%TiltingTable%' then 'TiltingTable'
    when creative_name like '%SimpleMatch%' then 'SimpleMatch'
    when creative_name like '%Simple Blast%' then 'SimpleBlast'
    when creative_name like '%SimpleBlast%' then 'SimpleBlast'
    when creative_name like '%Match3%' then 'Match3'
    when creative_name like '%ElevatorDangerous%' then 'ElevatorDangerous'
    when creative_name like '%Elevator%' then 'Elevator'
    when creative_name like '%TTC%' then 'TTC'
    when creative_name like '%SassyDog%' then 'SassyDog'
    when creative_name like '%AirTrafficTestimonial%' then 'AirTrafficTestimonial'
    when creative_name like '%Chef%' then 'Chef'
    when creative_name like '%APVUpdate%' then 'APVUpdate'
    when creative_name like '%FullBoard_2%' then 'FullBoard'
    when creative_name like '%FullBoard%' then 'FullBoard'
    when creative_name like '%MeetChumChumsTransition%' then 'MeetChumChums'
    when creative_name like '%meet chum chums fb port%' then 'MeetChumChums'
    when creative_name like '%Meet chum chums port%' then 'MeetChumChums'
    when creative_name like '%MeetChumChums%' then 'MeetChumChums'
    when creative_name like '%MeetChumcChums%' then 'MeetChumChums'
    when creative_name like '%MinuteCombo%' then 'MinuteCombo'
    when creative_name like '%ApvUpdate_NewFootage%' then 'ApvUpdate'
    when creative_name like '%ApvUpdate%' then 'ApvUpdate'
    when creative_name like '%FillTheOrders%' then 'FillTheOrders'
    when creative_name like '%Multiboard%' then 'Multiboard'
    when creative_name like '%DropTheCharacters%' then 'DropTheCharacters'
    when creative_name like '%ChumChumPainting%' then 'ChumChumPainting'
    when creative_name like '%ChumChumPainting%' then 'ChumChumPainting'
    when creative_name like '%ChumChumPainting%' then 'ChumChumPainting'
    when creative_name like '%ChumChumPainting%' then 'ChumChumPainting'
    when creative_name like '%ChumChumsPainting%' then 'ChumChumPainting'
    when creative_name like '%Smog%' then 'Smog'
    when creative_name like '%Tap by Number%' then 'TapByNumbers'
    when creative_name like '%TapbyNumber%' then 'TapByNumbers'
    when creative_name like '%TapByNumber%' then 'TapByNumbers'
    when creative_name like '%Connect the Dots%' then 'ConnectDots'
    when creative_name like '%ConnectDots%' then 'ConnectDots'
    when creative_name like '%Oil Splatter%' then 'OilSplatter'
    when creative_name like '%OilSplatter%' then 'OilSplatter'
    when creative_name like '%SimulatedGameplay%' then 'SimulatedGameplay'
    when creative_name like '%ChallengeFail%' then 'ChallengeFail'
    when creative_name like '%AppStoreTrailer%' then 'AppStoreTrailer'
    when creative_name like '%App Store Trailer%' then 'AppStoreTrailer'
    when creative_name like '%ASOTrailer%' then 'ASOTrailer'
    when creative_name like '%Level Progression%' then 'LevelProgression'
    when creative_name like '%Bump Off%' then 'BumpOff'
    when creative_name like '%Place of Friends%' then 'PlaceOfFriends'
    when creative_name like '%Simulated Play%' then 'SimulatedPlay'
    when creative_name like '%Grid Erasers%' then 'GridErasers'
    when creative_name like '%Cascading Erasers%' then 'CascadingErasers'
    when creative_name like '%Spiral Win%' then 'SpiralWin'
    when creative_name like '%Paw Play%' then 'PawPlay'
    when creative_name like '%PlayableLead-InVideo%' then 'PlayableLeadInVideo'
    when creative_name like '%PlayableLeadInVideo%' then 'PlayableLeadInVideo'
    when creative_name like '%TiltingTableDangerous%' then 'TiltingTableDangerous'
    when creative_name like '%Tilting Table - Dangerous%' then 'TiltingTableDangerous'
    when creative_name like '%Tilting Table%' then 'TiltingTable'
    when creative_name like '%TiltingTable%' then 'TiltingTable'
    when creative_name like '%Asian Baby%' then 'AsianBaby'
    when creative_name like '%Girl With Cats%' then 'GirlWithCats'

    when creative_name like '%Handsome Man w/Horse%' then 'HandsomeManWithHorse'
    when creative_name like '%Handsome Man%' then 'HandsomeMan'
    when creative_name like '%HandsomeMan%' then 'HandsomeMan'
    when creative_name like '%LadyBossWithCats%' then 'LadyBossWithCats'
    when creative_name like '%LadyBossWithDogs%' then 'LadyBossWithDogs'
    when creative_name like '%Lady Boss%' then 'LadyBoss'
    when creative_name like '%Punk Grandma%' then 'PunkGrandma'
    when creative_name like '%Spin Girl%' then 'SpinGirl'
    when creative_name like '%Yoga Girl%' then 'YogaGirl'
    when creative_name like '%ComboVideo%' then 'ComboVideo'
    when creative_name like '%DesignYourLevel%' then 'DesignYourLevel'
    when creative_name like '%ImpressiveCascade%' then 'ImpressiveCascade'
    when creative_name like '%LevelProgression%' then 'LevelProgression'
    when creative_name like '%MeetNewChumChum%' then 'MeetNewChumChum'
    when creative_name like '%CutenessOverload%' then 'CutenessOverload'
    when creative_name like '%8BitChum%' then '8BitChum'
    when creative_name like '%8BitFoodStart%' then '8BitFoodStart'
    when creative_name like '%ExcuseMe%' then 'ExcuseMe'
    when creative_name like '%GiantTV%' then 'GiantTV'
    when creative_name like '%LongGameplay%' then 'LongGameplay'
    when creative_name like '%MomtoMom%' then 'MomToMom'
    when creative_name like '%MultipleGameplay%' then 'MultipleGameplay'
    when creative_name like '%PostWorkout%' then 'PostWorkout'
    when creative_name like '%TruthorDare%' then 'TruthOrDare'
    when creative_name like '%WomanToWoman%' then 'WomanToWoman'
    when creative_name like '%Altered gameplay%' then 'AlteredGameplay'
    when creative_name like '%CharacterAppeal%' then 'CharacterAppeal'
    when creative_name like '%FlexibleImages%' then 'FlexibleImages'
    when creative_name like '%Interview%' then 'Interview'
    when creative_name like '%Brain_Female1%' then 'BrainFemale1'
    when creative_name like '%Brain_Female2%' then 'BrainFemale2'
    when creative_name like '%FarmCars%' then 'FarmCars'
    when creative_name like '%Makeover%' then 'Makeover'
    when creative_name like '%OutOfMoves%' then 'OutOfMoves'
    when creative_name like '%UGCAI_4%' then 'UGCAI_4'
    when creative_name like '%CCB_Matej_UGCAI_VerA%' then 'UGCAI_A'
    when creative_name like '%UGCAI1%' then 'UGCAI_1'
    when creative_name like '%UGCAI2%' then 'UGCAI_2'
    when creative_name like '%UGCAI3%' then 'UGCAI_3'
    when creative_name like '%UGCAI4%' then 'UGCAI_4'
    when creative_name like '%OneMoveLeft%' then 'OneMoveLeft'
    when creative_name like '%ManWithHorse%' then 'ManWithHorse'
    when creative_name like '%YogaWithSloth%' then 'YogaWithSloth'
    when creative_name like '%AllTheEggs%' then 'AllTheEggs'
    when creative_name like '%TheEggs%' then 'TheEggs'
    when creative_name like '%AdoptMe%' then 'AdoptMe'
    when creative_name like '%ArrowBlocker%' then 'ArrowBlocker'
    when creative_name like '%BuildingALevelI%' then 'BuildingALevelI'
    when creative_name like '%BuildtheLogo%' then 'BuildTheLogo'

    when creative_name like '%ChumChumBoost%' then 'ChumChumBoost'
    when creative_name like '%ChumChumQuiz%' then 'ChumChumQuiz'
    when creative_name like '%ChumChumWorkout%' then 'ChumChumWorkout'
    when creative_name like '%ChumsDoItAll%' then 'ChumsDoItAll'
    when creative_name like '%ConveyerBelt%' then 'ConveyerBelt'
    when creative_name like '%CoupleBet%' then 'CoupleBet'
    when creative_name like '%FeedChumChums%' then 'FeedChumChums'
    when creative_name like '%FeedingChums%' then 'FeedingChums'
    when creative_name like '%FullMealFood%' then 'FullMealFood'
    when creative_name like '%HungryChum%' then 'HungryChum'

    when creative_name like '%InsidetheMind%' then 'InsidetheMind'
    when creative_name like '%IntroThenButts%' then 'IntroThenButts'
    when creative_name like '%ManOutside%' then 'ManOutside'
    when creative_name like '%MovesMasterExplanation%' then 'MovesMasterExplanation'
    when creative_name like '%NatureDoc%' then 'NatureDoc'
    when creative_name like '%OneMoveLeft%' then 'OneMoveLeft'
    when creative_name like '%OverTheCliff%' then 'OverTheCliff'
    when creative_name like '%Paintingmodels%' then 'Paintingmodels'
    when creative_name like '%PostWorkout%' then 'PostWorkout'
    when creative_name like '%PullthePinSalad%' then 'PullthePinSalad'
    when creative_name like '%RedditChallenge%' then 'RedditChallenge'
    when creative_name like '%RelaxAndUnlock30Sec%' then 'RelaxAndUnlock30Sec'
    when creative_name like '%RelaxAndUnlock7Sec%' then 'RelaxAndUnlock7Sec'
    when creative_name like '%RelaxingGameplay%' then 'RelaxingGameplay'
    when creative_name like '%TapForNoise%' then 'TapForNoise'
    when creative_name like '%WhatisaChumChum%' then 'WhatIsAChumChum'
    when creative_name like '%WomanCar%' then 'WomanCar'
    when creative_name like '%WomanCouch%' then 'WomanCouch'
    when creative_name like '%WomanWalking%' then 'WomanWalking'
    when creative_name like '%CrossBridge%' then 'CrossBridge'
    when creative_name like '%chum chums%' then 'ChumChums'
    when creative_name like '%GameplayPlayable%' then 'GameplayPlayable'
    when creative_name like '%AppIconSimple%' then 'AppIconSimple'
    when creative_name like '%Mistplay%' and creative_name like '%ROAS%' then 'MistplayROAS'
    when creative_name like '%Takeaway%' then 'Takeaway'
    when creative_name like '%UGCAI_VersionA%' then 'UGCAI_A'
    when creative_name like '%UGCAI_VersionB%' then 'UGCAI_B'
    when creative_name like '%WomanWithSheep%' then 'WomanWithSheep'


  when creative_name like '%Testimonial%' then 'Testimonial'
  when length(creative_name) > 50 and creative_name not like '%|%' then 'Unmapped Hash'
  else creative_name


  end
  "
}

constant: creative_original_creator {
  value: "
    case
        when lower(creative_name) like '%matej%' then 'Matej'
        when date(first_creative_date) between '2024-05-01' and '2024-11-13' then 'BFG'
        else 'RDG'
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
