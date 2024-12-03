view: active_ab_tests_list {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-06-11'

      select '$.No_AB_Test_Split' as experiment_name

      union all select '$.boostersByAds_20240910'
      union all select '$.fakeProfiles2_20240910'
      union all select '$.altLevelOrderp5_20240911'
      union all select '$.movesMasterTune_20240611'
      union all select '$.memThresholdv2_20240923'
      union all select '$.moreAdsPizzaAndDice_20240924'
      union all select '$.colorBiasat01_20241021'
      union all select '$.localPricingLatamV2_20241025'
      union all select '$.foodTruckTuning_20241031'
      union all select '$.goFishRanksRebalance_20241031'
      union all select '$.mixedTreasureTrove_20241101'
      union all select '$.newGameFUEp2_20241105'
      union all select '$.adBreakp2_20241105'
      union all select '$.pizzaTime15DayDuration_20241105'
      union all select '$.social_20241112'
      union all select '$.IAMlimits_20241120'
      union all select '$.starterBucketTuning_20241121'
      union all select '$.starterBucketTuningp2_20241121_1393'
      union all select '$.dynamicMovesp2_20241121'
      union all select '$.colorBiasat01p2_20241121'
      union all select '$.rewardsReduction_20241121'
      union all select '$.rewardedGemDoubler_20241126'

      union all select '$.newCoinsQPO_20241022'
      union all select '$.seasonPassQPO_20241016'

      union all select '$.bypassRestorePrerequisites_20241004'
      union all select '$.newGameFUE_20240927'
      union all select '$.eorRewardedStars_20240925'

      union all select '$.adBreak_20240923'
      union all select '$.notificationIAM_20240923'
      union all select '$.dailyRewardsBig_20240923'
      union all select '$.memThresholdv2_20240923'
      union all select '$.castleClimbAdRewards_20240924'
      union all select '$.moreAdsPizzaAndDice_20240924'

      union all select '$.featureUnlocks2_20240910'
      union all select '$.boostersByAds_20240910'
      union all select '$.fakeProfiles2_20240910'
      union all select '$.altLevelOrderp5_20240911'
      union all select '$.dynamicMoves_20240911'
      union all select '$.foodTruckv2_20240910'
      union all select '$.moves26to500_20240904'
      union all select '$.movesMasterTune_20240611'

      union all select '$.scrollableHUDOffers_06122024'
      union all select '$.ticketQPO_20240626'

      union all select '$.deferTicketFUE_20240731'

      union all select '$.popupPriority_20240807'
      union all select '$.dynamicRewards_20240813'
      union all select '$.disableLogging_20240809'

      union all select '$.foodTruck_20240731'
      union all select '$.donutSprint_20240619'

      union all select '$.triggerOnRelease_20240715'
      union all select '$.powerupBlockSwap_20240711'
      union all select '$.triggerOnSwipe_20240715'
      union all select '$.unlosable10_20240710'

      union all select '$.loLockedIcons_20240702'
      union all select '$.lv1and2_20240701'
      union all select '$.lv25Moves_20240701'
      union all select '$.gemQuestDifficulty_20240701'
      union all select '$.memThreshold_20240701'
      union all select '$.ticketQPO_20240626'
      union all select '$.bunnySkill_20240626'

      union all select '$.altLevelOrderp4_20240508_8142'

      union all select '$.coinMultiplier_20240607'
      union all select '$.fakeProfiles_20240531'
      union all select '$.donutSprint_20240422'

      union all select '$.rewardedAdsGQ_20240427'

      union all select '$.ticketsv2_20240510'
      union all select '$.haptics_20240509'
      union all select '$.retainBoosters_20240508'
      union all select '$.castleClimb_20240805'
      union all select '$.altLevelOrderp3_20240508'

      union all select '$.dynamicEggFue_20240326'
      union all select '$.localNotes_20240328'
      union all select '$.tickets_20240403'
      union all select '$.dynamicEggsv2_20240223_8827'

      union all select '$.gemQuestEventv2_20240312'
      union all select '$.altLevelOrderp2_20240314'
      union all select '$.reversedQPO_20240313'

      union all select '$.livesCosting_20240202'

      union all select '$.hudOffers_20240228'
      union all select '$.movesMasterTune_20240227'
      union all select '$.dynamicEggs_20240223'
      union all select '$.altLevelOrder_20240220'

      union all select '$.swapTeamp2_20240209'
      union all select '$.goFishAds_20240208'
      union all select '$.dailyPopups_20240207'

      union all select '$.ExtraMoves1k_20240130'
      union all select '$.loAdMax_20240131'
      union all select '$.extendedQPO_20240131'

      union all select '$.blockColor_20240119'
      union all select '$.propBehavior_20240118'
      union all select '$.lv400500MovesTest_20240116'
      union all select '$.lv200300MovesTest_20240116'
      union all select '$.extraMovesOffering_20240111'

      union all select '$.lv650800Moves_20240105'
      union all select '$.lv100200Movesp2_20240103'
      union all select '$.fueLevelsV3p2_20240102'
      union all select '$.showLockedCharacters_20231215'
      union all select '$.scrollableTT_20231213'
      union all select '$.coinMultiplier_20231208'

      union all select '$.lv100200Moves_20231207'
      union all select '$.fueLevelsV3_20231207'
      union all select '$.hapticv3_20231207'
      union all select '$.swapTeam_20231206'
      union all select '$.colorBoost_20231205'
      union all select '$.lv300400MovesTest_20231207'

      union all select '$.hudSquirrel_20231128'
      union all select '$.blockSize_11152023'
      union all select '$.lockedEvents_20231107'

      union all select '$.coinPayout_20231108'

      union all select '$.askForHelp_20231023'

      union all select '$.coinPayout_20230824'

      union all select '$.mustardPretzel_09262023'
      union all select '$.chumPrompt_09262023'
      union all select '$.dynamicRewardsRatio_20230922'
      union all select '$.reducedMoves_20230919'
      union all select '$.autoRestore_20230912'

      union all select '$.goFish_20230915'

      union all select '$.extraMoves_20230908'
      union all select '$.spreadsheetMove_20230829'

      union all select '$.steakSwap_20230823'
      union all select '$.gravityTest_20230821'
      union all select '$.colorballBehavior_20230828'

      union all select '$.colorballBehavior_20230817'
      union all select '$.askForHelp_20230816'
      union all select '$.minigameGo_20230814'
      union all select '$.puzzleLives_20230814'
      union all select '$.propBehavior_20230814'
      union all select '$.flourFrenzyRepeat_20230807'

      union all select '$.dynamicDropBiasv4_20230802'
      union all select '$.zonePayout_20230728'
      union all select '$.propBehavior_20230726'

      union all select '$.propBehavior_20230717'
      union all select '$.zoneDrops_20230718'
      union all select '$.zoneDrops_20230712'
      union all select '$.hotdogContest_20230713'
      union all select '$.fue1213_20230713'
      union all select '$.magnifierRegen_20230711'
      union all select '$.mMTiers_20230712'
      union all select '$.dynamicDropBiasv3_20230627'
      union all select '$.popupPri_20230628'
      union all select '$.reactivationIAM_20230622'
      union all select '$.playNext_20230612'
      union all select '$.playNext_20230607'
      union all select '$.playNext_20230503'
      union all select '$.restoreBehavior_20230601'
      union all select '$.moveTrim_20230601'
      union all select '$.askForHelp_20230531'
      union all select '$.hapticv2_20230524'
      union all select '$.finalMoveAnim'
      union all select '$.popUpManager_20230502'
      union all select '$.fueSkip_20230425'
      union all select '$.autoRestore_20230502'
      union all select '$.playNext_20230503'
      union all select '$.dynamicDropBiasv2_20230423'
      union all select '$.puzzleEventv2_20230421'
      union all select '$.bigBombs_20230410'
      union all select '$.boardClear_20230410'
      union all select '$.iceCreamOrder_20230419'
      union all select '$.diceGame_20230419'
      union all select '$.fueUnlocks_20230419'
      union all select '$.haptic_20230326'
      union all select '$.dynamicDropBias_20230329'
      union all select '$.moldBehavior_20230329'
      union all select '$.strawSkills_20230331'
      union all select '$.mustardSingleClear_20230329'
      union all select '$.puzzleEvent_20230318'
      union all select '$.extraMoves_20230313'
      union all select '$.fastLifeTimer_20230313'
      union all select '$.frameRate_20230302'
      union all select '$.navBar_20230228'
      union all select '$.altFUE2_20221011'
      union all select '$.altFUE2v2_20221024'
      union all select '$.altFUE2v3_20221031'
      union all select '$.autoPurchase_20221017'
      union all select '$.blockSymbols_20221017'
      union all select '$.blockSymbolFrames_20221027'
      union all select '$.blockSymbolFrames2_20221109'
      union all select '$.boardColor_01122023'
      union all select '$.collection_01192023'
      union all select '$.difficultyStars_09202022'
      union all select '$.dynamicRewards_20221018'
      union all select '$.extraMovesCurrency_20221017'
      union all select '$.flourFrenzy_20221215'
      union all select '$.fueDismiss_20221010'
      union all select '$.fue00_v3_01182023'
      union all select '$.gridGravity_20221003'
      union all select '$.gridGravity2_20221012'
      union all select '$.livesTimer_01092023'
      union all select '$.MMads_01052023'
      union all select '$.mMStreaks_09302022'
      union all select '$.mMStreaksv2_20221031'
      union all select '$.newLevelPass_20220926'
      union all select '$.pizzaTime_01192023'
      union all select '$.seedTest_20221028'
      union all select '$.storeUnlock_20221102'
      union all select '$.treasureTrove_20221114'
      union all select '$.u2aFUE20221115'
      union all select '$.u2ap2_FUE20221209'
      union all select '$.vfxReduce_20221017'
      union all select '$.vfxReduce_2_20221024'
      union all select '$.zoneOrder2_09302022'
      union all select '$.zoneStarCosts_09222022'

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (1) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes

  }


####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.experiment_name
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

dimension: experiment_name {
  label: "Experiment Name"
  type: string

}


}
