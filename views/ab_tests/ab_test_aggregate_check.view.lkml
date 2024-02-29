view: ab_test_aggregate_check {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    with

--------------------------------------------------------------------------------------------------------------------------------
-- Player Summary
--------------------------------------------------------------------------------------------------------------------------------

player_summary as ( select * from eraser-blast.looker_scratch.6Y_ritz_deli_games_player_summary_new )

--------------------------------------------------------------------------------------------------------------------------------
-- All Players
--------------------------------------------------------------------------------------------------------------------------------

, all_players as (

  select * from (
    select "" as test_name, '' as rdg_id, null as variant, -1 as max_available_day_number
      union all select "loAdMax_20240131" as test_name, rdg_id, json_extract_scalar(experiments,"$.loAdMax_20240131") as variant, max_available_day_number from player_summary
      union all select "swapTeamp2_20240209" as test_name, rdg_id, json_extract_scalar(experiments, "$.swapTeamp2_20240209") as variant, max_available_day_number  from player_summary
      union all select "goFishAds_20240208" as test_name, rdg_id, json_extract_scalar(experiments, "$.goFishAds_20240208") as variant, max_available_day_number  from player_summary
      union all select "dailyPopups_20240207" as test_name, rdg_id, json_extract_scalar(experiments, "$.dailyPopups_20240207") as variant, max_available_day_number  from player_summary
      union all select "ExtraMoves1k_20240130" as test_name, rdg_id, json_extract_scalar(experiments, "$.ExtraMoves1k_20240130") as variant, max_available_day_number  from player_summary
      union all select "loAdMax_20240131" as test_name, rdg_id, json_extract_scalar(experiments, "$.loAdMax_20240131") as variant, max_available_day_number  from player_summary
      union all select "extendedQPO_20240131" as test_name, rdg_id, json_extract_scalar(experiments, "$.extendedQPO_20240131") as variant, max_available_day_number  from player_summary
      union all select "propBehavior_20240118" as test_name, rdg_id, json_extract_scalar(experiments, "$.propBehavior_20240118") as variant, max_available_day_number  from player_summary
      union all select "lv400500MovesTest_20240116" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv400500MovesTest_20240116") as variant, max_available_day_number  from player_summary
      union all select "lv200300MovesTest_20240116" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv200300MovesTest_20240116") as variant, max_available_day_number  from player_summary
      union all select "extraMovesOffering_20240111" as test_name, rdg_id, json_extract_scalar(experiments, "$.extraMovesOffering_20240111") as variant, max_available_day_number  from player_summary
      union all select "lv650800Moves_20240105" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv650800Moves_20240105") as variant, max_available_day_number  from player_summary
      union all select "lv100200Movesp2_20240103" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv100200Movesp2_20240103") as variant, max_available_day_number  from player_summary
      union all select "fueLevelsV3p2_20240102" as test_name, rdg_id, json_extract_scalar(experiments, "$.fueLevelsV3p2_20240102") as variant, max_available_day_number  from player_summary
      union all select "scrollableTT_20231213" as test_name, rdg_id, json_extract_scalar(experiments, "$.scrollableTT_20231213") as variant, max_available_day_number  from player_summary
      union all select "coinMultiplier_20231208" as test_name, rdg_id, json_extract_scalar(experiments, "$.coinMultiplier_20231208") as variant, max_available_day_number  from player_summary
      union all select "lv100200Moves_20231207" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv100200Moves_20231207") as variant, max_available_day_number  from player_summary
      union all select "fueLevelsV3_20231207" as test_name, rdg_id, json_extract_scalar(experiments, "$.fueLevelsV3_20231207") as variant, max_available_day_number  from player_summary
  )
  where
    variant is not null
    and max_available_day_number >= {% parameter selected_lowest_max_available_day_number %}

)

--------------------------------------------------------------------------------------------------------------------------------
-- Add Metrics
--------------------------------------------------------------------------------------------------------------------------------

, combined_data_set as (

  select
    a.*
    , 1 as count_players
    , case
        when {% parameter selected_metric %} = 'cumulative_ad_views_d1' then b.cumulative_ad_views_d1
        when {% parameter selected_metric %} = 'cumulative_ad_views_d2' then b.cumulative_ad_views_d2
        when {% parameter selected_metric %} = 'cumulative_ad_views_d7' then b.cumulative_ad_views_d7
        when {% parameter selected_metric %} = 'cumulative_ad_views_d14' then b.cumulative_ad_views_d14
        when {% parameter selected_metric %} = 'cumulative_ad_views_d30' then b.cumulative_ad_views_d30
        when {% parameter selected_metric %} = 'cumulative_ad_views_d60' then b.cumulative_ad_views_d60
        when {% parameter selected_metric %} = 'cumulative_ad_views_d90' then b.cumulative_ad_views_d90
        when {% parameter selected_metric %} = 'cumulative_ad_views_current' then b.cumulative_ad_views_current
        when {% parameter selected_metric %} = 'retention_d2' then b.retention_d2
        when {% parameter selected_metric %} = 'retention_d7' then b.retention_d7
        when {% parameter selected_metric %} = 'retention_d8' then b.retention_d8
        when {% parameter selected_metric %} = 'retention_d9' then b.retention_d9
        when {% parameter selected_metric %} = 'retention_d10' then b.retention_d10
        when {% parameter selected_metric %} = 'retention_d11' then b.retention_d11
        when {% parameter selected_metric %} = 'retention_d12' then b.retention_d12
        when {% parameter selected_metric %} = 'retention_d13' then b.retention_d13
        when {% parameter selected_metric %} = 'retention_d14' then b.retention_d14
        when {% parameter selected_metric %} = 'retention_d21' then b.retention_d21
        when {% parameter selected_metric %} = 'retention_d30' then b.retention_d30
        when {% parameter selected_metric %} = 'retention_d60' then b.retention_d60
        when {% parameter selected_metric %} = 'retention_d90' then b.retention_d90
        when {% parameter selected_metric %} = 'cumulative_mtx_purchase_dollars_d1' then b.cumulative_mtx_purchase_dollars_d1
        when {% parameter selected_metric %} = 'cumulative_mtx_purchase_dollars_d2' then b.cumulative_mtx_purchase_dollars_d2
        when {% parameter selected_metric %} = 'cumulative_mtx_purchase_dollars_d7' then b.cumulative_mtx_purchase_dollars_d7
        when {% parameter selected_metric %} = 'cumulative_mtx_purchase_dollars_d14' then b.cumulative_mtx_purchase_dollars_d14
        when {% parameter selected_metric %} = 'cumulative_mtx_purchase_dollars_d30' then b.cumulative_mtx_purchase_dollars_d30
        when {% parameter selected_metric %} = 'cumulative_mtx_purchase_dollars_d60' then b.cumulative_mtx_purchase_dollars_d60
        when {% parameter selected_metric %} = 'cumulative_mtx_purchase_dollars_d90' then b.cumulative_mtx_purchase_dollars_d90
        when {% parameter selected_metric %} = 'cumulative_mtx_purchase_dollars_current' then b.cumulative_mtx_purchase_dollars_current
        when {% parameter selected_metric %} = 'cumulative_count_mtx_purchases_d1' then b.cumulative_count_mtx_purchases_d1
        when {% parameter selected_metric %} = 'cumulative_count_mtx_purchases_d2' then b.cumulative_count_mtx_purchases_d2
        when {% parameter selected_metric %} = 'cumulative_count_mtx_purchases_d7' then b.cumulative_count_mtx_purchases_d7
        when {% parameter selected_metric %} = 'cumulative_count_mtx_purchases_d14' then b.cumulative_count_mtx_purchases_d14
        when {% parameter selected_metric %} = 'cumulative_count_mtx_purchases_d30' then b.cumulative_count_mtx_purchases_d30
        when {% parameter selected_metric %} = 'cumulative_count_mtx_purchases_d60' then b.cumulative_count_mtx_purchases_d60
        when {% parameter selected_metric %} = 'cumulative_count_mtx_purchases_current' then b.cumulative_count_mtx_purchases_current
        when {% parameter selected_metric %} = 'cumulative_ad_view_dollars_d1' then b.cumulative_ad_view_dollars_d1
        when {% parameter selected_metric %} = 'cumulative_ad_view_dollars_d2' then b.cumulative_ad_view_dollars_d2
        when {% parameter selected_metric %} = 'cumulative_ad_view_dollars_d7' then b.cumulative_ad_view_dollars_d7
        when {% parameter selected_metric %} = 'cumulative_ad_view_dollars_d14' then b.cumulative_ad_view_dollars_d14
        when {% parameter selected_metric %} = 'cumulative_ad_view_dollars_d30' then b.cumulative_ad_view_dollars_d30
        when {% parameter selected_metric %} = 'cumulative_ad_view_dollars_d60' then b.cumulative_ad_view_dollars_d60
        when {% parameter selected_metric %} = 'cumulative_ad_view_dollars_d90' then b.cumulative_ad_view_dollars_d90
        when {% parameter selected_metric %} = 'cumulative_ad_view_dollars_current' then b.cumulative_ad_view_dollars_current
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d1' then b.cumulative_combined_dollars_d1
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d2' then b.cumulative_combined_dollars_d2
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d7' then b.cumulative_combined_dollars_d7
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d14' then b.cumulative_combined_dollars_d14
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d21' then b.cumulative_combined_dollars_d21
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d30' then b.cumulative_combined_dollars_d30
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d60' then b.cumulative_combined_dollars_d60
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d90' then b.cumulative_combined_dollars_d90
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_d120' then b.cumulative_combined_dollars_d120
        when {% parameter selected_metric %} = 'cumulative_combined_dollars_current' then b.cumulative_combined_dollars_current
        when {% parameter selected_metric %} = 'highest_last_level_serial_d1' then b.highest_last_level_serial_d1
        when {% parameter selected_metric %} = 'highest_last_level_serial_d2' then b.highest_last_level_serial_d2
        when {% parameter selected_metric %} = 'highest_last_level_serial_d7' then b.highest_last_level_serial_d7
        when {% parameter selected_metric %} = 'highest_last_level_serial_d14' then b.highest_last_level_serial_d14
        when {% parameter selected_metric %} = 'highest_last_level_serial_d30' then b.highest_last_level_serial_d30
        when {% parameter selected_metric %} = 'highest_last_level_serial_d60' then b.highest_last_level_serial_d60
        when {% parameter selected_metric %} = 'highest_last_level_serial_d90' then b.highest_last_level_serial_d90
        when {% parameter selected_metric %} = 'highest_last_level_serial_current' then b.highest_last_level_serial_current
        when {% parameter selected_metric %} = 'days_played_in_first_7_days' then b.days_played_in_first_7_days
        when {% parameter selected_metric %} = 'days_played_in_first_14_days' then b.days_played_in_first_14_days
        when {% parameter selected_metric %} = 'days_played_in_first_21_days' then b.days_played_in_first_21_days
        when {% parameter selected_metric %} = 'days_played_in_first_30_days' then b.days_played_in_first_30_days
        when {% parameter selected_metric %} = 'minutes_played_in_first_1_days' then b.minutes_played_in_first_1_days
        when {% parameter selected_metric %} = 'minutes_played_in_first_2_days' then b.minutes_played_in_first_2_days
        when {% parameter selected_metric %} = 'minutes_played_in_first_7_days' then b.minutes_played_in_first_7_days
        when {% parameter selected_metric %} = 'minutes_played_in_first_14_days' then b.minutes_played_in_first_14_days
        when {% parameter selected_metric %} = 'minutes_played_in_first_21_days' then b.minutes_played_in_first_21_days
        when {% parameter selected_metric %} = 'minutes_played_in_first_30_days' then b.minutes_played_in_first_30_days
        when {% parameter selected_metric %} = 'cumulative_coins_spend_d1' then b.cumulative_coins_spend_d1
        when {% parameter selected_metric %} = 'cumulative_coins_spend_d2' then b.cumulative_coins_spend_d2
        when {% parameter selected_metric %} = 'cumulative_coins_spend_d7' then b.cumulative_coins_spend_d7
        when {% parameter selected_metric %} = 'cumulative_coins_spend_d14' then b.cumulative_coins_spend_d14
        when {% parameter selected_metric %} = 'cumulative_coins_spend_d30' then b.cumulative_coins_spend_d30
        when {% parameter selected_metric %} = 'cumulative_coins_spend_d60' then b.cumulative_coins_spend_d60
        when {% parameter selected_metric %} = 'cumulative_coins_spend_d90' then b.cumulative_coins_spend_d90
        when {% parameter selected_metric %} = 'cumulative_coins_spend_current' then b.cumulative_coins_spend_current
        when {% parameter selected_metric %} = 'puzzle_rounds_played_in_first_1_days' then b.puzzle_rounds_played_in_first_1_days
        when {% parameter selected_metric %} = 'puzzle_rounds_played_in_first_2_days' then b.puzzle_rounds_played_in_first_2_days
        when {% parameter selected_metric %} = 'puzzle_rounds_played_in_first_7_days' then b.puzzle_rounds_played_in_first_7_days
        when {% parameter selected_metric %} = 'puzzle_rounds_played_in_first_14_days' then b.puzzle_rounds_played_in_first_14_days
        when {% parameter selected_metric %} = 'puzzle_rounds_played_in_first_21_days' then b.puzzle_rounds_played_in_first_21_days
        when {% parameter selected_metric %} = 'puzzle_rounds_played_in_first_30_days' then b.puzzle_rounds_played_in_first_30_days
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d1' then b.cumulative_total_chum_powerups_used_d1
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d2' then b.cumulative_total_chum_powerups_used_d2
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d7' then b.cumulative_total_chum_powerups_used_d7
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d8' then b.cumulative_total_chum_powerups_used_d8
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d14' then b.cumulative_total_chum_powerups_used_d14
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d15' then b.cumulative_total_chum_powerups_used_d15
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d21' then b.cumulative_total_chum_powerups_used_d21
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d30' then b.cumulative_total_chum_powerups_used_d30
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d31' then b.cumulative_total_chum_powerups_used_d31
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d46' then b.cumulative_total_chum_powerups_used_d46
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d60' then b.cumulative_total_chum_powerups_used_d60
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d61' then b.cumulative_total_chum_powerups_used_d61
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d90' then b.cumulative_total_chum_powerups_used_d90
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d120' then b.cumulative_total_chum_powerups_used_d120
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d180' then b.cumulative_total_chum_powerups_used_d180
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d270' then b.cumulative_total_chum_powerups_used_d270
        when {% parameter selected_metric %} = 'cumulative_total_chum_powerups_used_d360' then b.cumulative_total_chum_powerups_used_d360
        else 1 end as metric_numerator
    , 1 as metric_denominator

  from
    all_players a
    inner join player_summary b
      on a.rdg_id = b.rdg_id

)

---------------------------------------------------------------------------------------
-- create iteration table
---------------------------------------------------------------------------------------

, my_iteration_table as (

  select iteration_number
  from
    unnest( generate_array(1,10000 + 1) ) as iteration_number

)

---------------------------------------------------------------------------------------
-- create iterations
---------------------------------------------------------------------------------------

, my_iterations as (

select
  a.test_name
  , a.variant as my_group
  , b.iteration_number
  , a.metric_numerator
  , a.metric_denominator
  , rand() as random_number
from
  combined_data_set a
  cross join my_iteration_table b

)

---------------------------------------------------------------------------------------
-- sample w/ replacement
---------------------------------------------------------------------------------------

, my_sample_with_replacement as (

  select
    test_name
    , metric_numerator
    , metric_denominator
    , my_group
    , iteration_number
    , random_number
    , case
        when iteration_number = 1 and my_group = {% parameter selected_variant_a %} then 'a'
        when iteration_number = 1 and my_group = {% parameter selected_variant_b %} then 'b'
        when
          iteration_number > 1
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
    test_name
    , iteration_number
    , my_sampled_group
    , sum(1) as count_players
    , safe_divide( sum(metric_numerator), sum(metric_denominator) ) as average_metric
  from
    my_sample_with_replacement
  group by
    1,2,3

)

---------------------------------------------------------------------------------------
-- difference by metric
-- step 1 - pivot by group
---------------------------------------------------------------------------------------

, difference_by_metric_step_1 as (

  select
    test_name
    , iteration_number
    , sum( case when my_sampled_group = 'a' then count_players else 0 end ) as group_a_players
    , sum( case when my_sampled_group = 'b' then count_players else 0 end ) as group_b_players
    , sum( case when my_sampled_group = 'a' then average_metric else 0 end ) as group_a
    , sum( case when my_sampled_group = 'b' then average_metric else 0 end ) as group_b
  from
    my_average_metric_by_iteration
  group by
    1,2

)

---------------------------------------------------------------------------------------
-- difference by metric
-- step 2 - calculate difference
---------------------------------------------------------------------------------------

, difference_by_metric_step_2 as (

  select
    test_name
    , iteration_number
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
    test_name
    , max( iteration_number ) as iteration_number
    , max( group_a_players ) as group_a_players
    , max( group_b_players ) as group_b_players
    , max( group_a ) as group_a
    , max( group_b ) as group_b
    , max( my_difference ) as my_difference
    , max( my_abs_difference ) as my_abs_difference
  from
    difference_by_metric_step_2
  where
    iteration_number = 1
  group by
    1

)



---------------------------------------------------------------------------------------
-- calculate instances where iteration 1 has an absolute diference bigger than other iterations
---------------------------------------------------------------------------------------

, calculate_greater_than_instances as (

  select
    a.test_name
    , a.iteration_number
    , a.group_a_players
    , a.group_b_players
    , a.group_a
    , a.group_b
    , a.my_difference
    , a.my_abs_difference
    , b.my_abs_difference as iteration_1_abs_difference
    , case when b.my_abs_difference > a.my_abs_difference then 1 else 0 end as my_greater_than_indicator
  from
    difference_by_metric_step_2 a
    inner join iteration_1_only b
      on a.test_name = b.test_name
  where
    a.iteration_number > 1

)

---------------------------------------------------------------------------------------
-- summarize percent_greater_than
---------------------------------------------------------------------------------------

, summarize_results as (

  select
    test_name
    , max(iteration_number)-1 as my_iterations
    , avg(my_greater_than_indicator) as percent_greater_than
    , case
        when avg(my_greater_than_indicator) >= safe_divide(95,100)
        then safe_cast(95 as string) || '% Significant!'
        else 'NOT ' || safe_cast(95 as string) || '% Significant!'
        end as significance_95

  from
    calculate_greater_than_instances
  group by
    1

)

---------------------------------------------------------------------------------------
-- summarize percent_greater_than
---------------------------------------------------------------------------------------

, summarize_percent_greater_than as (

  select
    a.test_name
    , a.iteration_number
    , a.group_a_players
    , a.group_b_players
    , a.group_a
    , a.group_b
    , a.my_difference
    , a.my_abs_difference
    , b.my_iterations
    , b.percent_greater_than
    , b.significance_95

  from
    iteration_1_only a
    inner join summarize_results b
      on a.test_name = b.test_name

)

---------------------------------------------------------------------------------------
-- output
---------------------------------------------------------------------------------------

select * from summarize_percent_greater_than


      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: my_primary_key {
    type: string
    sql:
    ${TABLE}.test_name
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

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

      , "puzzle_rounds_played_in_first_1_days"
      , "puzzle_rounds_played_in_first_2_days"
      , "puzzle_rounds_played_in_first_7_days"
      , "puzzle_rounds_played_in_first_14_days"
      , "puzzle_rounds_played_in_first_21_days"
      , "puzzle_rounds_played_in_first_30_days"

      , "cumulative_total_chum_powerups_used_d1"
      , "cumulative_total_chum_powerups_used_d2"
      , "cumulative_total_chum_powerups_used_d7"
      , "cumulative_total_chum_powerups_used_d8"
      , "cumulative_total_chum_powerups_used_d14"
      , "cumulative_total_chum_powerups_used_d15"
      , "cumulative_total_chum_powerups_used_d21"
      , "cumulative_total_chum_powerups_used_d30"
      , "cumulative_total_chum_powerups_used_d31"
      , "cumulative_total_chum_powerups_used_d46"
      , "cumulative_total_chum_powerups_used_d60"
      , "cumulative_total_chum_powerups_used_d61"
      , "cumulative_total_chum_powerups_used_d90"
      , "cumulative_total_chum_powerups_used_d120"
      , "cumulative_total_chum_powerups_used_d180"
      , "cumulative_total_chum_powerups_used_d270"
      , "cumulative_total_chum_powerups_used_d360"


    ]
  }

################################################################
## Dimensions
################################################################

  dimension: test_name {
    label: "AB Test"
    type: string
    sql: ${TABLE}.test_name ;;
    }

  dimension: iteration_number {
    type: number
  }

################################################################
## Measures
################################################################

  measure: group_a_players {
    label: "Group A Players"
    type: number
    value_format_name: decimal_0
    sql: max(${TABLE}.group_a_players) ;;
  }

  measure: group_b_players {
    label: "Group B Players"
    type: number
    value_format_name: decimal_0
    sql: max(${TABLE}.group_b_players) ;;
  }

  measure: group_a_metric {
    label: "Group A Metric"
    type: number
    value_format_name: decimal_2
    sql: max(${TABLE}.group_a) ;;
  }

  measure: group_b_metric {
    label: "Group B Metric"
    type: number
    value_format_name: decimal_2
    sql: max(${TABLE}.group_b) ;;
  }

  measure: my_difference {
    label: "Difference"
    type: number
    value_format_name: decimal_2
    sql: max(${TABLE}.my_difference) ;;
  }

  measure: my_abs_difference {
    label: "Absolute Difference"
    type: number
    value_format_name: decimal_2
    sql: max(${TABLE}.my_abs_difference) ;;
  }

  measure: my_iterations {
    label: "Total Iterations"
    type: number
    value_format_name: decimal_0
    sql: max(${TABLE}.my_iterations) ;;
  }

  measure: percent_greater_than {
    label: "Total Iterations"
    type: number
    value_format_name: percent_0
    sql: max(${TABLE}.percent_greater_than) ;;
  }




}
