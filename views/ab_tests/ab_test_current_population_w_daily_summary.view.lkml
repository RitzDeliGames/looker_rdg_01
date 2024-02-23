view: ab_test_current_population_w_daily_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    with

                  ---------------------------------------------------------------------------------------
                  -- base data from round summary
                  ---------------------------------------------------------------------------------------

      base_data as (

      select
        rdg_id
        , max(json_extract_scalar(experiments,{% parameter selected_experiment %})) as variant
        , sum(1) as count_days_played
        , sum(time_played_minutes) as time_played_minutes
        , sum(round_end_events_gofish) as go_fish_rounds
      from
        ${player_daily_summary.SQL_TABLE_NAME}
      where

        -- Date Filters
        date(rdg_date) >= date({% parameter start_date %})
        and date(rdg_date) <= date({% parameter end_date %})

        --Test Filter
        and json_extract_scalar(experiments,{% parameter selected_experiment %}) in ( {% parameter selected_variant_a %} , {% parameter selected_variant_b %} )

        -- Level Filter (start)
        {% if start_level_serial._is_filtered %}
        and highest_last_level_serial >= {% parameter start_level_serial %}
        {% endif %}

        -- Level Filter (end)
        {% if end_level_serial._is_filtered %}
        and highest_last_level_serial <= {% parameter end_level_serial %}
        {% endif %}

        -- Day Number (min)
        {% if day_number_min._is_filtered %}
        and day_number >= {% parameter day_number_min %}
        {% endif %}

        -- Day Number (max)
        {% if day_number_max._is_filtered %}
        and day_number <= {% parameter day_number_max %}
        {% endif %}

      group by
        1

      )

      ---------------------------------------------------------------------------------------
      -- create iteration table
      ---------------------------------------------------------------------------------------

      , my_iteration_table as (

      select iteration_number
      from
      unnest( generate_array(1,{% parameter selected_iterations %}+1) ) as iteration_number

      )

      ---------------------------------------------------------------------------------------
      -- create iterations
      ---------------------------------------------------------------------------------------

      , my_iterations as (

      select
      a.*
      , case
      when a.variant = {% parameter selected_variant_a %} then 'a'
      when a.variant = {% parameter selected_variant_b %} then 'b'
      else 'other'
      end as my_group
      , b.iteration_number
      , rand() as random_number
      from
      base_data a
      cross join my_iteration_table b

      )

      ---------------------------------------------------------------------------------------
      -- sample w/ replacement
      ---------------------------------------------------------------------------------------

      , my_sample_with_replacement as (

      select
      *
      , case
      when iteration_number = 1 then my_group
      when iteration_number > 1
      and random_number < 0.50 then 'a'
      else 'b'
      end as my_sampled_group

      from
      my_iterations

      )

      ---------------------------------------------------------------------------------------
      -- average metric by iteration
      ---------------------------------------------------------------------------------------

      , my_average_metric_by_iteration as (

      select
        iteration_number
        , my_sampled_group
        , sum(1) as count_players
        , case
            when 'Average Minutes Played Per Day' = {% parameter selected_metric %} then safe_divide( sum( time_played_minutes ) , sum( count_days_played ) )
            when 'Average Go Fish Rounds Played Per Day' = {% parameter selected_metric %} then safe_divide( sum( go_fish_rounds ) , sum( count_days_played ) )
            else null end
          as average_metric
      from
        my_sample_with_replacement
      group by
        1,2

      )

      ---------------------------------------------------------------------------------------
      -- difference by metric
      -- step 1 - pivot by group
      ---------------------------------------------------------------------------------------

      , difference_by_metric_step_1 as (

      select
      iteration_number
      , sum( case when my_sampled_group = 'a' then count_players else 0 end ) as group_a_players
      , sum( case when my_sampled_group = 'b' then count_players else 0 end ) as group_b_players
      , sum( case when my_sampled_group = 'a' then average_metric else 0 end ) as group_a
      , sum( case when my_sampled_group = 'b' then average_metric else 0 end ) as group_b
      from
      my_average_metric_by_iteration
      group by
      1

      )

      ---------------------------------------------------------------------------------------
      -- difference by metric
      -- step 2 - calculate difference
      ---------------------------------------------------------------------------------------

      , difference_by_metric_step_2 as (

      select
      iteration_number
      , group_a_players
      , group_b_players
      , group_a
      , group_b
      , group_b - group_a as my_difference
      , abs( group_b - group_a ) as my_abs_difference
      from
      difference_by_metric_step_1

      )

      ---------------------------------------------------------------------------------------
      -- iterattion_1_only
      ---------------------------------------------------------------------------------------

      , iteration_1_only as (

      select
      iteration_number
      , group_a_players
      , group_b_players
      , group_a
      , group_b
      , my_difference
      , my_abs_difference
      from
      difference_by_metric_step_2
      where
      iteration_number = 1

      )

      ---------------------------------------------------------------------------------------
      -- calculate instances where iteration 1 has an absolute diference bigger than other iterations
      ---------------------------------------------------------------------------------------

      , calculate_greater_than_instances as (

      select
      a.*
      , b.my_abs_difference as iteration_1_abs_difference
      , case when b.my_abs_difference > a.my_abs_difference then 1 else 0 end as my_greater_than_indicator
      from
      difference_by_metric_step_2 a
      cross join iteration_1_only b
      where
      a.iteration_number > 1

      )

      ---------------------------------------------------------------------------------------
      -- summarize percent_greater_than
      ---------------------------------------------------------------------------------------

      , summarize_results as (

      select
      max(iteration_number)-1 as my_iterations
      , avg(my_greater_than_indicator) as percent_greater_than
      , case
      when avg(my_greater_than_indicator) >= safe_divide({% parameter selected_significance %},100)
      then safe_cast({% parameter selected_significance %} as string) || '% Significant!'
      else 'NOT ' || safe_cast({% parameter selected_significance %} as string) || '% Significant!'
      end as significance_95

      from
      calculate_greater_than_instances

      )

      ---------------------------------------------------------------------------------------
      -- summarize percent_greater_than
      ---------------------------------------------------------------------------------------

      , summarize_percent_greater_than as (

      select
      *
      from
      iteration_1_only a
      cross join summarize_results b

      )

      ---------------------------------------------------------------------------------------
      -- output before rounding
      ---------------------------------------------------------------------------------------

      , output_before_rounding as (

      select
      iteration_number
      , group_a_players
      , group_b_players
      , group_a
      , group_b
      , my_difference
      , my_abs_difference
      , my_iterations
      , percent_greater_than
      , significance_95
      , 0 as count_iterations
      , 'actual' as iteration_type
      from
      summarize_percent_greater_than

      union all
      select
      iteration_number
      , group_a_players
      , group_b_players
      , group_a
      , group_b
      , my_difference
      , my_abs_difference
      , 0 as my_iterations
      , 0 as percent_greater_than
      , '' as significance_95
      , 1 as count_iterations
      , 'iterations' as iteration_type
      from
      calculate_greater_than_instances

      )

      ---------------------------------------------------------------------------------------
      -- output with rounding
      ---------------------------------------------------------------------------------------

      , output_with_rounding as (

      select
      iteration_number
      , group_a_players
      , group_b_players
      , group_a
      , group_b
      , my_difference
      , my_abs_difference
      , my_iterations
      , percent_greater_than
      , significance_95
      , count_iterations
      , iteration_type
      , safe_cast(
      round(
      round( safe_divide( max(my_abs_difference) over (), 50 ) , 4 )
      *
      safe_cast(round(
      safe_divide(
      my_abs_difference
      , safe_divide( max(my_abs_difference) over (), 50 )
      )
      , 0 ) as int64)
      ,4)
      as float64) as my_abs_difference_rounded
      from
      output_before_rounding

      )

      ---------------------------------------------------------------------------------------
      -- output
      ---------------------------------------------------------------------------------------

      select * from output_with_rounding

      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: iteration_number_key {
    type: string
    sql:
    ${TABLE}.iteration_number
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################


  dimension: iteration_number {type: number}

  dimension: group_a_players {
    label: "Group A Players"
    type: number
    value_format_name: decimal_0
  }

  dimension: group_b_players {
    label: "Group B Players"
    type: number
    value_format_name: decimal_0
  }

  dimension: group_a {
    label: "Group A Metric Average"
    type: number
    value_format_name: decimal_4
  }

  dimension: group_b {
    label: "Group B Metric Average"
    type: number
    value_format_name: decimal_4
  }

  dimension: my_difference {
    label: "Difference in Average Metric"
    type: number
    value_format_name: decimal_4
  }

  dimension: my_abs_difference {
    label: "Absolute Difference in Average Metric"
    type: number
    value_format_name: decimal_4
  }

  dimension: my_iterations {
    label: "Total Iterations"
    type: number
    value_format_name: decimal_0
  }

  dimension: percent_greater_than {
    label: "Estimated Significance Level"
    type: number
    value_format_name: percent_0
  }

  dimension: significance_95 {
    label: "Siginficance Check"
    type: string
  }

  dimension: my_abs_difference_rounded {
    label: "Rounded Difference"
    type: number
    value_format_name: decimal_4
  }

  dimension: iteration_type {
    label: "Iteration Type"
    type: string
  }

  measure: count_iterations {
    type:  sum
  }

  dimension: count_iterations_dimension {
    type:  number
    sql: ${TABLE}.count_iterations ;;
  }


  parameter: selected_experiment {
    type: string
    default_value: "$.dynamicDropBiasv3_20230627"
    suggestions:  [

      , "$.swapTeamp2_20240209"
      , "$.goFishAds_20240208"
      , "$.dailyPopups_20240207"

      , "$.ExtraMoves1k_20240130"
      , "$.loAdMax_20240131"
      , "$.extendedQPO_20240131"

      , "$.blockColor_20240119"
      , "$.propBehavior_20240118"
      , "$.lv400500MovesTest_20240116"
      , "$.lv200300MovesTest_20240116"
      , "$.extraMovesOffering_20240111"

      ,"$.lv650800Moves_20240105"
      ,"$.lv100200Movesp2_20240103"
      ,"$.fueLevelsV3p2_20240102"
      ,"$.showLockedCharacters_20231215"
      ,"$.scrollableTT_20231213"
      ,"$.coinMultiplier_20231208"

      ,"$.lv100200Moves_20231207"
      ,"$.fueLevelsV3_20231207"
      ,"$.hapticv3_20231207"
      ,"$.swapTeam_20231206"
      ,"$.colorBoost_20231205"
      ,"$.lv300400MovesTest_20231207"

      ,"$.hudSquirrel_20231128"
      ,"$.blockSize_11152023"
      ,"$.lockedEvents_20231107"

      ,"$.coinPayout_20231108"

      ,"$.askForHelp_20231023"

      ,"$.coinPayout_20230824"

      ,"$.mustardPretzel_09262023"
      ,"$.chumPrompt_09262023"
      ,"$.dynamicRewardsRatio_20230922"
      ,"$.reducedMoves_20230919"
      ,"$.autoRestore_20230912"

      ,"$.goFish_20230915"

      ,"$.extraMoves_20230908"
      ,"$.spreadsheetMove_20230829"

      ,"$.steakSwap_20230823"
      ,"$.gravityTest_20230821"
      ,"$.colorballBehavior_20230828"


      ,"$.colorballBehavior_20230817"
      ,"$.askForHelp_20230816"
      ,"$.minigameGo_20230814"
      ,"$.puzzleLives_20230814"
      ,"$.propBehavior_20230814"
      ,"$.flourFrenzyRepeat_20230807"

      ,"$.dynamicDropBiasv4_20230802"
      ,"$.zonePayout_20230728"
      ,"$.propBehavior_20230726"

      ,"$.propBehavior_20230717"

      ,"$.zoneDrops_20230718"
      ,"$.zoneDrops_20230712"
      ,"$.hotdogContest_20230713"
      ,"$.fue1213_20230713"
      ,"$.magnifierRegen_20230711"
      ,"$.mMTiers_20230712"
      ,"$.dynamicDropBiasv3_20230627"
      ,"$.popupPri_20230628"
      ,"$.reactivationIAM_20230622"
      ,"$.playNext_20230612"
      ,"$.playNext_20230607"
      ,"$.playNext_20230503"
      ,"$.restoreBehavior_20230601"
      ,"$.moveTrim_20230601"
      ,"$.askForHelp_20230531"
      ,"$.hapticv2_20230524"
      ,"$.finalMoveAnim"
      ,"$.popUpManager_20230502"
      ,"$.fueSkip_20230425"
      ,"$.autoRestore_20230502"
      ,"$.playNext_20230503"
      ,"$.dynamicDropBiasv2_20230423"
      ,"$.puzzleEventv2_20230421"
      ,"$.bigBombs_20230410"
      ,"$.boardClear_20230410"
      ,"$.iceCreamOrder_20230419"
      ,"$.diceGame_20230419"
      ,"$.fueUnlocks_20230419"
      ,"$.haptic_20230326"
      ,"$.dynamicDropBias_20230329"
      ,"$.moldBehavior_20230329"
      ,"$.strawSkills_20230331"
      ,"$.mustardSingleClear_20230329"
      ,"$.puzzleEvent_20230318"
      ,"$.extraMoves_20230313"
      ,"$.fastLifeTimer_20230313"
      ,"$.frameRate_20230302"
      ,"$.navBar_20230228"
      ,"$.altFUE2_20221011"
      ,"$.altFUE2v2_20221024"
      ,"$.altFUE2v3_20221031"
      ,"$.autoPurchase_20221017"
      ,"$.blockSymbols_20221017"
      ,"$.blockSymbolFrames_20221027"
      ,"$.blockSymbolFrames2_20221109"
      ,"$.boardColor_01122023"
      ,"$.collection_01192023"
      ,"$.difficultyStars_09202022"
      ,"$.dynamicRewards_20221018"
      ,"$.extraMovesCurrency_20221017"
      ,"$.flourFrenzy_20221215"
      ,"$.fueDismiss_20221010"
      ,"$.fue00_v3_01182023"
      ,"$.gridGravity_20221003"
      ,"$.gridGravity2_20221012"
      ,"$.livesTimer_01092023"
      ,"$.MMads_01052023"
      ,"$.mMStreaks_09302022"
      ,"$.mMStreaksv2_20221031"
      ,"$.newLevelPass_20220926"
      ,"$.pizzaTime_01192023"
      ,"$.seedTest_20221028"
      ,"$.storeUnlock_20221102"
      ,"$.treasureTrove_20221114"
      ,"$.u2aFUE20221115"
      ,"$.u2ap2_FUE20221209"
      ,"$.vfxReduce_20221017"
      ,"$.vfxReduce_2_20221024"
      ,"$.zoneOrder2_09302022"
      ,"$.zoneStarCosts_09222022"]
  }

  parameter: selected_variant_a {
    type: string
    default_value: "control"
    suggestions:  ["control","variant_a","variant_b","variant_c","variant_d"]
  }

  parameter: selected_variant_b {
    type: string
    default_value: "variant_a"
    suggestions:  ["control","variant_a","variant_b","variant_c","variant_d"]
  }

  parameter: start_date {
    type: date
    default_value: "2024-01-01"
  }

  parameter: end_date {
    type: date
    default_value: "2024-01-01"
  }

  parameter: start_level_serial {
    label: "Lowest Level Serial"
    type: number
  }

  parameter: end_level_serial {
    label: "Highest Level Serial"
    type: number
  }

  parameter: day_number_min {
    type: number
  }

  parameter: day_number_max {
    type: number
  }

  parameter: selected_minimum_system_memory_size {
    type: number
  }

  # parameter: selected_device_platform_os {
  #   type: string
  #   default_value: "Android"
  #   suggestions:  ["Android","iOS"]
  # }

  parameter: selected_iterations {
    type: number
  }

  parameter: selected_significance {
    type: number
  }

  parameter: selected_rounding {
    type: number
  }

  parameter: selected_metric {
    type: string
    default_value: "Average Minutes Played Per Day"
    suggestions:  [

      , "Average Minutes Played Per Day"
      , "Average Go Fish Rounds Played Per Day"

    ]
  }



}
