view: active_ab_tests_list {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-03-25'

      select '$.No_AB_Test_Split' as experiment_name
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
      union all select 'v650800Moves_20240105'
      union all select 'v100200Movesp2_20240103'
      union all select 'ueLevelsV3p2_20240102'
      union all select 'howLockedCharacters_20231215'
      union all select 'crollableTT_20231213'
      union all select 'oinMultiplier_20231208'
      union all select 'v100200Moves_20231207'
      union all select 'ueLevelsV3_20231207'
      union all select 'apticv3_20231207'
      union all select 'wapTeam_20231206'
      union all select 'olorBoost_20231205'
      union all select 'v300400MovesTest_20231207'
      union all select 'udSquirrel_20231128'
      union all select 'lockSize_11152023'
      union all select 'ockedEvents_20231107'
      union all select 'oinPayout_20231108'
      union all select 'skForHelp_20231023'
      union all select 'oinPayout_20230824'
      union all select 'ustardPretzel_09262023'
      union all select 'humPrompt_09262023'
      union all select 'ynamicRewardsRatio_20230922'
      union all select 'educedMoves_20230919'
      union all select 'utoRestore_20230912'
      union all select 'oFish_20230915'
      union all select 'xtraMoves_20230908'
      union all select 'preadsheetMove_20230829'
      union all select 'teakSwap_20230823'
      union all select 'ravityTest_20230821'
      union all select 'olorballBehavior_20230828'
      union all select 'olorballBehavior_20230817'
      union all select 'skForHelp_20230816'
      union all select 'inigameGo_20230814'
      union all select 'uzzleLives_20230814'
      union all select 'ropBehavior_20230814'
      union all select 'lourFrenzyRepeat_20230807'
      union all select 'ynamicDropBiasv4_20230802'
      union all select 'onePayout_20230728'
      union all select 'ropBehavior_20230726'
      union all select 'ropBehavior_20230717'
      union all select 'oneDrops_20230718'
      union all select 'oneDrops_20230712'
      union all select 'otdogContest_20230713'
      union all select 'ue1213_20230713'
      union all select 'agnifierRegen_20230711'
      union all select 'MTiers_20230712'
      union all select 'ynamicDropBiasv3_20230627'
      union all select 'opupPri_20230628'
      union all select 'eactivationIAM_20230622'
      union all select 'layNext_20230612'
      union all select 'layNext_20230607'
      union all select 'layNext_20230503'
      union all select 'estoreBehavior_20230601'
      union all select 'oveTrim_20230601'
      union all select 'skForHelp_20230531'
      union all select 'apticv2_20230524'
      union all select 'inalMoveAnim'
      union all select 'opUpManager_20230502'
      union all select 'ueSkip_20230425'
      union all select 'utoRestore_20230502'
      union all select 'layNext_20230503'
      union all select 'ynamicDropBiasv2_20230423'
      union all select 'uzzleEventv2_20230421'
      union all select 'igBombs_20230410'
      union all select 'oardClear_20230410'
      union all select 'ceCreamOrder_20230419'
      union all select 'iceGame_20230419'
      union all select 'ueUnlocks_20230419'
      union all select 'aptic_20230326'
      union all select 'ynamicDropBias_20230329'
      union all select 'oldBehavior_20230329'
      union all select 'trawSkills_20230331'
      union all select 'ustardSingleClear_20230329'
      union all select 'uzzleEvent_20230318'
      union all select 'xtraMoves_20230313'
      union all select 'astLifeTimer_20230313'
      union all select 'rameRate_20230302'
      union all select 'avBar_20230228'
      union all select 'ltFUE2_20221011'
      union all select 'ltFUE2v2_20221024'
      union all select 'ltFUE2v3_20221031'
      union all select 'utoPurchase_20221017'
      union all select 'lockSymbols_20221017'
      union all select 'lockSymbolFrames_20221027'
      union all select 'lockSymbolFrames2_20221109'
      union all select 'oardColor_01122023'
      union all select 'ollection_01192023'
      union all select 'ifficultyStars_09202022'
      union all select 'ynamicRewards_20221018'
      union all select 'xtraMovesCurrency_20221017'
      union all select 'lourFrenzy_20221215'
      union all select 'ueDismiss_20221010'
      union all select 'ue00_v3_01182023'
      union all select 'ridGravity_20221003'
      union all select 'ridGravity2_20221012'
      union all select 'ivesTimer_01092023'
      union all select 'Mads_01052023'
      union all select 'MStreaks_09302022'
      union all select 'MStreaksv2_20221031'
      union all select 'ewLevelPass_20220926'
      union all select 'izzaTime_01192023'
      union all select 'eedTest_20221028'
      union all select 'toreUnlock_20221102'
      union all select 'reasureTrove_20221114'
      union all select '2aFUE20221115'
      union all select '2ap2_FUE20221209'
      union all select 'fxReduce_20221017'
      union all select 'fxReduce_2_20221024'
      union all select 'oneOrder2_09302022'
      union all select 'oneStarCosts_09222022'

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
