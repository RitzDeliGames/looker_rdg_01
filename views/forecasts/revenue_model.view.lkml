view: revenue_model {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:


    with

    --------------------------------------------------------------
    -- UA Spend dates
    -- main inputs: start date, number of days to spend
    --------------------------------------------------------------

    my_ua_spend_dates as (

    select
      install_date
    from
      unnest( generate_date_array('2023-07-01', date_add('2023-07-01', interval 365 day))) as install_date

    )

    --------------------------------------------------------------
    -- UA Spend
    --------------------------------------------------------------

    , my_ua_spend as (

    select
      install_date
      , 'US' as region
      , safe_cast(17 as float64) as cpi
      , 117486.39 * 0.62 as ua_spend
    from
      my_ua_spend_dates

    union all
    select
      install_date
      , 'WW' as region
      , safe_cast(4.50 as float64) as cpi
      , 117486.39 * (1-0.62) as ua_spend
    from
      my_ua_spend_dates

    )

    --------------------------------------------------------------
    -- UA installs
    --------------------------------------------------------------

    , my_ua_installs as (

      select
        install_date
        , region
        , cpi
        , ua_spend
        , safe_cast( round( safe_divide( ua_spend , cpi ), 0) as int64) as installs
      from
        my_ua_spend

    )

    --------------------------------------------------------------
    -- organic installs
    --------------------------------------------------------------

    , my_organic_installs as (

      select
        install_date
        , region
        , 0 as cpi
        , 0 as ua_spend
        , safe_cast( round( installs * 0.54 , 0) as int64) as installs
      from
        my_ua_installs

    )

    --------------------------------------------------------------
    -- combined installs
    --------------------------------------------------------------

    , my_combined_installs as (

      select
        install_date
        , region
        , 'paid' as paid_vs_organic
        , cpi
        , ua_spend
        , installs
      from
        my_ua_installs

      union all

      select
        install_date
        , region
        , 'organic' as paid_vs_organic
        , cpi
        , ua_spend
        , installs
      from
        my_organic_installs

    )

    --------------------------------------------------------------
    -- Retention Curve
    -- step 1
    -- here I'm building out 2000 days, which should be enough for 5 year modeling
    --------------------------------------------------------------

    , my_retention_curve_step_1 as (

      select
        day_number
        , safe_cast( 0.45 as float64 ) as retention_d2
        , safe_cast( 0.22 as float64 ) as retention_d8
        , safe_cast( 0.12 as float64 ) as retention_d31
        , safe_cast( 0.075 as float64 ) as retention_d91
        , safe_cast( 0.053 as float64 ) as retention_d181
        , safe_cast( 0.032 as float64 ) as retention_d366
        , safe_cast( 0.016 as float64 ) as retention_d731

      from
        unnest(
          generate_array(1,2000)
        ) as day_number

    )

    --------------------------------------------------------------
    -- Retention Curve
    -- step 2
    --------------------------------------------------------------

    , my_retention_curve as (

      select
          day_number
          , retention_d2
          , retention_d8
          , retention_d31
          , retention_d91
          , retention_d181
          , retention_d366
          , retention_d731
          , safe_cast( case
              when day_number <= 1 then round( 1 , 4 )
              when day_number <= 2 then round( retention_d2 , 4 )

              when day_number <= 3 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.45 ) , 4 )
              when day_number <= 4 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.65 ) , 4 )
              when day_number <= 5 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.80 ) , 4 )
              when day_number <= 6 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.87 ) , 4 )
              when day_number <= 7 then round( retention_d2 - ( (retention_d2 - retention_d8) * 0.95 ) , 4 )

              when day_number <= 8 then retention_d8

              when day_number <= 9 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.17 ) , 4 )
              when day_number <= 10 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.29 ) , 4 )
              when day_number <= 11 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.38 ) , 4 )
              when day_number <= 12 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.46 ) , 4 )
              when day_number <= 13 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.51 ) , 4 )
              when day_number <= 14 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.56 ) , 4 )
              when day_number <= 15 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.6 ) , 4 )
              when day_number <= 16 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.64 ) , 4 )
              when day_number <= 17 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.68 ) , 4 )
              when day_number <= 18 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.72 ) , 4 )
              when day_number <= 19 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.75 ) , 4 )
              when day_number <= 20 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.78 ) , 4 )
              when day_number <= 21 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.81 ) , 4 )
              when day_number <= 22 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.84 ) , 4 )
              when day_number <= 23 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.86 ) , 4 )
              when day_number <= 24 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.88 ) , 4 )
              when day_number <= 25 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.91 ) , 4 )
              when day_number <= 26 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.93 ) , 4 )
              when day_number <= 27 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.95 ) , 4 )
              when day_number <= 28 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.97 ) , 4 )
              when day_number <= 29 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.98 ) , 4 )
              when day_number <= 30 then round( retention_d8 - ( (retention_d8 - retention_d31) * 0.98 ) , 4 )

              when day_number <= 31 then round( retention_d31 , 4 )

              when day_number <= 90 then round( retention_d31 - ( ( retention_d31 - retention_d91 ) * safe_divide( day_number - 31 , 60 ) ), 4 )
              when day_number <= 91 then round( retention_d91 , 4 )

              when day_number <= 180 then round( retention_d91 - ( ( retention_d91 - retention_d181 ) * safe_divide( day_number - 91 , 90 ) ), 4 )
              when day_number <= 181 then round( retention_d181 , 4 )

              when day_number <= 365 then round( retention_d181 - ( ( retention_d181 - retention_d366 ) * safe_divide( day_number - 181 , 185 ) ), 4 )
              when day_number <= 366 then round( retention_d366 , 4 )

              when day_number <= 730 then round( retention_d366 - ( ( retention_d366 - retention_d731 ) * safe_divide( day_number - 366 , 365 ) ), 4 )
              when day_number <= 731 then round( retention_d731 , 4 )

              when day_number <= 1999 then round( retention_d731 - ( ( retention_d731 - safe_divide( retention_d731, 2) ) * safe_divide( day_number - 731 , 1269 ) ), 4 )
              when day_number <= 2000 then round( safe_divide( retention_d731, 2)  , 4 )

              when day_number <= 3999 then round( safe_divide( retention_d731, 2) - ( ( safe_divide( retention_d731, 2) - safe_divide( retention_d731, 4) ) * safe_divide( day_number - 2000 , 2000 ) ), 4 )
              when day_number <= 4000 then round( safe_divide( retention_d731, 4)  , 4 )



              else safe_divide( retention_d731, 4) end
              as float64
              ) as retention_curve
      from
        my_retention_curve_step_1

    )

    --------------------------------------------------------------
    -- Combine Retention Curve With Installs
    -- this will calculate DAU
    -- also add Gross ARPDAU for Ads and MTX
    --------------------------------------------------------------

    -- US Gross ARPDAU: $0.65 (Gross is before platform fees are subtracted)
    -- WW Gross ARPDAU: $0.32 (proportional to assumed CPI ratios)
    -- % Ads of Gross: 35%
    -- (Tal: this means
    --   US MTX = 0.65 * 0.65 = 0.4225
    --   WW MTX = 0.32 * 0.65 = 0.208

    --   US Ads = 0.65 * 0.35 = 0.2275
    --   WW Ads = 0.32 * 0.35 = 0.112

    --   )

    , full_dau_curve as (

      select
          a.install_date
          , a.region
          , a.paid_vs_organic
          , a.installs as retention_denominator
          , round( case when b.day_number = 1 then a.ua_spend else 0 end , 2 ) as ua_spend
          , case when b.day_number = 1 then a.installs else 0 end as installs
          , cast( round( a.installs * retention_curve , 0 ) as int64 ) as daily_active_users
          , b.day_number
          , date_add(a.install_date, interval b.day_number - 1 day ) as rdg_date
          , b.retention_curve
          , safe_cast( round( case
              when region = 'US' then 0.65 * (1-0.35)
              when region = 'WW' then 0.32 * (1-0.35)
              else 0
              end , 4 ) as float64 )
              as gross_mtx_arpdau
          , safe_cast( round( case
              when region = 'US' then 0.65 * (0.35)
              when region = 'WW' then 0.32 * (0.35)
              else 0
              end , 4 ) as float64 )
              as gross_ads_arpdau
      from
        my_combined_installs a
        cross join my_retention_curve b

    )

    --------------------------------------------------------------
    -- add revenue
    --------------------------------------------------------------

    , full_revenue_curve as (

      select
          timestamp(date(install_date)) as install_date
          , region
          , paid_vs_organic
          , ua_spend
          , installs
          , retention_denominator
          , daily_active_users
          , day_number
          , timestamp(date(rdg_date)) as rdg_date

          -- Gross Revenue
          , safe_cast( round( gross_mtx_arpdau * daily_active_users , 2 ) as float64 ) as gross_mtx_revenue
          , safe_cast( round( gross_ads_arpdau * daily_active_users , 2 ) as float64 ) as gross_ads_revenue
          , safe_cast( round( ( gross_mtx_arpdau + gross_ads_arpdau ) * daily_active_users , 2 ) as float64 ) as gross_combined_revenue

          -- Net Revenue (excluding 30% app store cut)
          , safe_cast( round( gross_mtx_arpdau * daily_active_users * 0.70 , 2 ) as float64 ) as net_mtx_revenue
          , safe_cast( round( gross_ads_arpdau * daily_active_users * 0.70 , 2 ) as float64 ) as net_ads_revenue
          , safe_cast( round( ( gross_mtx_arpdau + gross_ads_arpdau ) * daily_active_users * 0.70 , 2 ) as float64 ) as net_combined_revenue

      from
        full_dau_curve

    )

    --------------------------------------------------------------
    -- Summary
    --------------------------------------------------------------

    select * from full_revenue_curve

      ;;
    publish_as_db_view: no


  }
  # select * from ${player_summary_new.SQL_TABLE_NAME}
  # saving code for later
  # {% if selected_display_name._is_filtered %}
  # and display_name = {% parameter selected_display_name %}
  # {% endif %}


####################################################################
## Primary Key
####################################################################

  dimension: my_primary_key {
    type: string
    sql:
    ${TABLE}.install_date
    || ${TABLE}.region
    || ${TABLE}.paid_vs_organic
    || ${TABLE}.day_number
    || ${TABLE}.rdg_date
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################


  dimension_group: install_date {
    group_label: "Dates"
    label: "Install Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.install_date ;;
  }

  dimension: region { type: string }
  dimension: paid_vs_organic { type: string }

  dimension: day_number {
    label: "Day Number"
    type: number
    value_format_name: decimal_0
  }

  dimension_group: rdg_date {
    group_label: "Dates"
    label: "Activity Date"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

####################################################################
## Measures
####################################################################

  measure: total_installs {
    label: "Total Installs"
    type: sum
    value_format_name: decimal_0
    sql: ${TABLE}.installs ;;
  }

  measure: total_ua_spend {
    label: "Total UA Spend"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.ua_spend ;;

  }

  measure: average_daily_active_users {
    label: "Average Daily Active Users"
    type: average
    value_format_name: decimal_0
    sql: ${TABLE}.daily_active_users ;;
  }

  measure: total_gross_mtx_revenue {
    label: "Total Gross MTX Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_mtx_revenue ;;
  }

  measure: total_gross_ads_revenue {
    label: "Total Gross Ads Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_ads_revenue ;;
  }

  measure: total_gross_combined_revenue {
    label: "Total Gross Combined Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.gross_combined_revenue ;;
  }

  measure: total_net_mtx_revenue {
    label: "Total Net MTX Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_mtx_revenue ;;
  }

  measure: total_net_ads_revenue {
    label: "Total Net Ads Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_ads_revenue ;;
  }

  measure: total_net_combined_revenue {
    label: "Total Net Combined Revenue"
    type: sum
    value_format_name: decimal_2
    sql: ${TABLE}.net_combined_revenue ;;
  }

  measure: net_mtx_arpdau {
    label: "Net Mtx ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.net_mtx_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: gross_mtx_arpdau {
    label: "Gross Mtx ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.gross_mtx_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: net_ads_arpdau {
    label: "Net Ads ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.net_ads_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: gross_ads_arpdau {
    label: "Gross Ads ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.gross_ads_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: net_combined_arpdau {
    label: "Net Combined ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.net_combined_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: gross_combined_arpdau {
    label: "Gross Combined ARPDAU"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.gross_combined_revenue) , sum(${TABLE}.daily_active_users) ) ;;
  }

  measure: retention {
    label: "Retention"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.daily_active_users) , sum(${TABLE}.retention_denominator) ) ;;
  }

  measure: cpi {
    label: "CPI"
    type: number
    value_format_name: decimal_2
    sql: safe_divide( sum(${TABLE}.ua_spend ) , sum(${TABLE}.installs) ) ;;
  }

  measure: net_combined_roas {
    label: "Net Combiend ROAS"
    type: number
    value_format_name: percent_1
    sql: safe_divide( sum(${TABLE}.net_combined_revenue ) , sum(${TABLE}.ua_spend) ) ;;
  }

####################################################################
## Parameters
####################################################################


  parameter: selected_experiment {
    type: string
    default_value: "$.dynamicDropBiasv3_20230627"
    suggestions:  [
      "$.propBehavior_20230717"
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


  parameter: selected_lowest_max_available_day_number {
    type: number
  }

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
    default_value: "days_played_in_first_7_days"
    suggestions:  [

      , "cumulative_ad_views_d1"
      , "cumulative_ad_views_d2"
      , "cumulative_ad_views_d7"
      , "cumulative_ad_views_d14"
      , "cumulative_ad_views_d30"
      , "cumulative_ad_views_d60"
      , "cumulative_ad_views_d90"
      , "cumulative_ad_views_current"

      , "retention_d2"
      , "retention_d7"
      , "retention_d8"
      , "retention_d9"
      , "retention_d10"
      , "retention_d11"
      , "retention_d12"
      , "retention_d13"
      , "retention_d14"
      , "retention_d21"
      , "retention_d30"
      , "retention_d60"
      , "retention_d90"

      , "cumulative_mtx_purchase_dollars_d1"
      , "cumulative_mtx_purchase_dollars_d2"
      , "cumulative_mtx_purchase_dollars_d7"
      , "cumulative_mtx_purchase_dollars_d14"
      , "cumulative_mtx_purchase_dollars_d30"
      , "cumulative_mtx_purchase_dollars_d60"
      , "cumulative_mtx_purchase_dollars_d90"
      , "cumulative_mtx_purchase_dollars_current"

      , "cumulative_count_mtx_purchases_d1"
      , "cumulative_count_mtx_purchases_d2"
      , "cumulative_count_mtx_purchases_d7"
      , "cumulative_count_mtx_purchases_d14"
      , "cumulative_count_mtx_purchases_d30"
      , "cumulative_count_mtx_purchases_d60"
      , "cumulative_count_mtx_purchases_current"

      , "cumulative_ad_view_dollars_d1"
      , "cumulative_ad_view_dollars_d2"
      , "cumulative_ad_view_dollars_d7"
      , "cumulative_ad_view_dollars_d14"
      , "cumulative_ad_view_dollars_d30"
      , "cumulative_ad_view_dollars_d60"
      , "cumulative_ad_view_dollars_d90"
      , "cumulative_ad_view_dollars_current"
      , "cumulative_combined_dollars_d1"
      , "cumulative_combined_dollars_d2"
      , "cumulative_combined_dollars_d7"
      , "cumulative_combined_dollars_d14"
      , "cumulative_combined_dollars_d21"
      , "cumulative_combined_dollars_d30"
      , "cumulative_combined_dollars_d60"
      , "cumulative_combined_dollars_d90"
      , "cumulative_combined_dollars_d120"
      , "cumulative_combined_dollars_current"
      , "highest_last_level_serial_d1"
      , "highest_last_level_serial_d2"
      , "highest_last_level_serial_d7"
      , "highest_last_level_serial_d14"
      , "highest_last_level_serial_d30"
      , "highest_last_level_serial_d60"
      , "highest_last_level_serial_d90"
      , "highest_last_level_serial_current"

      , "days_played_in_first_7_days"
      , "days_played_in_first_14_days"
      , "days_played_in_first_21_days"
      , "days_played_in_first_30_days"

      , "minutes_played_in_first_1_days"
      , "minutes_played_in_first_2_days"
      , "minutes_played_in_first_7_days"
      , "minutes_played_in_first_14_days"
      , "minutes_played_in_first_21_days"
      , "minutes_played_in_first_30_days"

      , "cumulative_coins_spend_d1"
      , "cumulative_coins_spend_d2"
      , "cumulative_coins_spend_d7"
      , "cumulative_coins_spend_d14"
      , "cumulative_coins_spend_d30"
      , "cumulative_coins_spend_d60"
      , "cumulative_coins_spend_d90"
      , "cumulative_coins_spend_current"

    ]
  }



}
