view: ab_test_full_iterations {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    with

---------------------------------------------------------------------------------------
-- first test group
---------------------------------------------------------------------------------------

group_a as (

    select
      rdg_id
      -- , days_played_in_first_7_days as metric
      , case
          when 'days_played_in_first_7_days' = {% parameter selected_metric %} then days_played_in_first_7_days

          when 'cumulative_ad_views_d1' = {% parameter selected_metric %} then cumulative_ad_views_d1
          when 'cumulative_ad_views_d2' = {% parameter selected_metric %} then cumulative_ad_views_d2
          when 'cumulative_ad_views_d7' = {% parameter selected_metric %} then cumulative_ad_views_d7
          when 'cumulative_ad_views_d14' = {% parameter selected_metric %} then cumulative_ad_views_d14
          when 'cumulative_ad_views_d30' = {% parameter selected_metric %} then cumulative_ad_views_d30
          when 'cumulative_ad_views_d60' = {% parameter selected_metric %} then cumulative_ad_views_d60
          when 'cumulative_ad_views_d90' = {% parameter selected_metric %} then cumulative_ad_views_d90
          when 'cumulative_ad_views_current' = {% parameter selected_metric %} then cumulative_ad_views_current
          when 'retention_d2' = {% parameter selected_metric %} then retention_d2
          when 'retention_d7' = {% parameter selected_metric %} then retention_d7
          when 'retention_d8' = {% parameter selected_metric %} then retention_d8
          when 'retention_d9' = {% parameter selected_metric %} then retention_d9
          when 'retention_d10' = {% parameter selected_metric %} then retention_d10
          when 'retention_d11' = {% parameter selected_metric %} then retention_d11
          when 'retention_d12' = {% parameter selected_metric %} then retention_d12
          when 'retention_d13' = {% parameter selected_metric %} then retention_d13
          when 'retention_d14' = {% parameter selected_metric %} then retention_d14
          when 'retention_d21' = {% parameter selected_metric %} then retention_d21
          when 'retention_d30' = {% parameter selected_metric %} then retention_d30
          when 'retention_d60' = {% parameter selected_metric %} then retention_d60
          when 'retention_d90' = {% parameter selected_metric %} then retention_d90

          when 'cumulative_mtx_purchase_dollars_d1' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d1
          when 'cumulative_mtx_purchase_dollars_d2' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d2
          when 'cumulative_mtx_purchase_dollars_d7' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d7
          when 'cumulative_mtx_purchase_dollars_d14' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d14
          when 'cumulative_mtx_purchase_dollars_d30' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d30
          when 'cumulative_mtx_purchase_dollars_d60' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d60
          when 'cumulative_mtx_purchase_dollars_d90' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d90
          when 'cumulative_mtx_purchase_dollars_current' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_current


          when 'cumulative_count_mtx_purchases_d1' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d1
          when 'cumulative_count_mtx_purchases_d2' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d2
          when 'cumulative_count_mtx_purchases_d7' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d7
          when 'cumulative_count_mtx_purchases_d14' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d14
          when 'cumulative_count_mtx_purchases_d30' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d30
          when 'cumulative_count_mtx_purchases_d60' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d60
          when 'cumulative_count_mtx_purchases_current' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_current


          when 'cumulative_ad_view_dollars_d1' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d1
          when 'cumulative_ad_view_dollars_d2' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d2
          when 'cumulative_ad_view_dollars_d7' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d7
          when 'cumulative_ad_view_dollars_d14' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d14
          when 'cumulative_ad_view_dollars_d30' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d30
          when 'cumulative_ad_view_dollars_d60' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d60
          when 'cumulative_ad_view_dollars_d90' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d90
          when 'cumulative_ad_view_dollars_current' = {% parameter selected_metric %} then cumulative_ad_view_dollars_current
          when 'cumulative_combined_dollars_d1' = {% parameter selected_metric %} then cumulative_combined_dollars_d1
          when 'cumulative_combined_dollars_d2' = {% parameter selected_metric %} then cumulative_combined_dollars_d2
          when 'cumulative_combined_dollars_d7' = {% parameter selected_metric %} then cumulative_combined_dollars_d7
          when 'cumulative_combined_dollars_d14' = {% parameter selected_metric %} then cumulative_combined_dollars_d14
          when 'cumulative_combined_dollars_d21' = {% parameter selected_metric %} then cumulative_combined_dollars_d21
          when 'cumulative_combined_dollars_d30' = {% parameter selected_metric %} then cumulative_combined_dollars_d30
          when 'cumulative_combined_dollars_d60' = {% parameter selected_metric %} then cumulative_combined_dollars_d60
          when 'cumulative_combined_dollars_d90' = {% parameter selected_metric %} then cumulative_combined_dollars_d90
          when 'cumulative_combined_dollars_d120' = {% parameter selected_metric %} then cumulative_combined_dollars_d120
          when 'cumulative_combined_dollars_current' = {% parameter selected_metric %} then cumulative_combined_dollars_current
          when 'highest_last_level_serial_d1' = {% parameter selected_metric %} then highest_last_level_serial_d1
          when 'highest_last_level_serial_d2' = {% parameter selected_metric %} then highest_last_level_serial_d2
          when 'highest_last_level_serial_d7' = {% parameter selected_metric %} then highest_last_level_serial_d7
          when 'highest_last_level_serial_d14' = {% parameter selected_metric %} then highest_last_level_serial_d14
          when 'highest_last_level_serial_d30' = {% parameter selected_metric %} then highest_last_level_serial_d30
          when 'highest_last_level_serial_d60' = {% parameter selected_metric %} then highest_last_level_serial_d60
          when 'highest_last_level_serial_d90' = {% parameter selected_metric %} then highest_last_level_serial_d90
          when 'highest_last_level_serial_current' = {% parameter selected_metric %} then highest_last_level_serial_current

          when 'days_played_in_first_7_days' = {% parameter selected_metric %} then days_played_in_first_7_days
          when 'days_played_in_first_14_days' = {% parameter selected_metric %} then days_played_in_first_14_days
          when 'days_played_in_first_21_days' = {% parameter selected_metric %} then days_played_in_first_21_days
          when 'days_played_in_first_30_days' = {% parameter selected_metric %} then days_played_in_first_30_days

          when 'minutes_played_in_first_1_days' = {% parameter selected_metric %} then minutes_played_in_first_1_days
          when 'minutes_played_in_first_2_days' = {% parameter selected_metric %} then minutes_played_in_first_2_days
          when 'minutes_played_in_first_7_days' = {% parameter selected_metric %} then minutes_played_in_first_7_days
          when 'minutes_played_in_first_14_days' = {% parameter selected_metric %} then minutes_played_in_first_14_days
          when 'minutes_played_in_first_21_days' = {% parameter selected_metric %} then minutes_played_in_first_21_days
          when 'minutes_played_in_first_30_days' = {% parameter selected_metric %} then minutes_played_in_first_30_days

          when 'cumulative_coins_spend_d1' = {% parameter selected_metric %} then cumulative_coins_spend_d1
          when 'cumulative_coins_spend_d2' = {% parameter selected_metric %} then cumulative_coins_spend_d2
          when 'cumulative_coins_spend_d7' = {% parameter selected_metric %} then cumulative_coins_spend_d7
          when 'cumulative_coins_spend_d14' = {% parameter selected_metric %} then cumulative_coins_spend_d14
          when 'cumulative_coins_spend_d30' = {% parameter selected_metric %} then cumulative_coins_spend_d30
          when 'cumulative_coins_spend_d60' = {% parameter selected_metric %} then cumulative_coins_spend_d60
          when 'cumulative_coins_spend_d90' = {% parameter selected_metric %} then cumulative_coins_spend_d90
          when 'cumulative_coins_spend_current' = {% parameter selected_metric %} then cumulative_coins_spend_current

          when 'puzzle_rounds_played_in_first_1_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_1_days
          when 'puzzle_rounds_played_in_first_2_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_2_days
          when 'puzzle_rounds_played_in_first_7_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_7_days
          when 'puzzle_rounds_played_in_first_14_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_14_days
          when 'puzzle_rounds_played_in_first_21_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_21_days
          when 'puzzle_rounds_played_in_first_30_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_30_days



        else 1
        end as metric

    from
      ${player_summary_new.SQL_TABLE_NAME}

    where
      1=1

        -- and json_extract_scalar(experiments,'$.dynamicDropBiasv3_20230627') = 'control'
        {% if selected_experiment._is_filtered %}
        and json_extract_scalar(experiments,{% parameter selected_experiment %}) = {% parameter selected_variant_a %}
        {% endif %}

        -- and max_available_day_number >= 7
        {% if selected_lowest_max_available_day_number._is_filtered %}
        and max_available_day_number >= {% parameter selected_lowest_max_available_day_number %}
        {% endif %}

)

---------------------------------------------------------------------------------------
-- second test group
---------------------------------------------------------------------------------------

, group_b as (

    select
      rdg_id
      -- , days_played_in_first_7_days as metric
      , case
          when 'days_played_in_first_7_days' = {% parameter selected_metric %} then days_played_in_first_7_days

          when 'cumulative_ad_views_d1' = {% parameter selected_metric %} then cumulative_ad_views_d1
          when 'cumulative_ad_views_d2' = {% parameter selected_metric %} then cumulative_ad_views_d2
          when 'cumulative_ad_views_d7' = {% parameter selected_metric %} then cumulative_ad_views_d7
          when 'cumulative_ad_views_d14' = {% parameter selected_metric %} then cumulative_ad_views_d14
          when 'cumulative_ad_views_d30' = {% parameter selected_metric %} then cumulative_ad_views_d30
          when 'cumulative_ad_views_d60' = {% parameter selected_metric %} then cumulative_ad_views_d60
          when 'cumulative_ad_views_d90' = {% parameter selected_metric %} then cumulative_ad_views_d90
          when 'cumulative_ad_views_current' = {% parameter selected_metric %} then cumulative_ad_views_current
          when 'retention_d2' = {% parameter selected_metric %} then retention_d2
          when 'retention_d7' = {% parameter selected_metric %} then retention_d7
          when 'retention_d8' = {% parameter selected_metric %} then retention_d8
          when 'retention_d9' = {% parameter selected_metric %} then retention_d9
          when 'retention_d10' = {% parameter selected_metric %} then retention_d10
          when 'retention_d11' = {% parameter selected_metric %} then retention_d11
          when 'retention_d12' = {% parameter selected_metric %} then retention_d12
          when 'retention_d13' = {% parameter selected_metric %} then retention_d13
          when 'retention_d14' = {% parameter selected_metric %} then retention_d14
          when 'retention_d21' = {% parameter selected_metric %} then retention_d21
          when 'retention_d30' = {% parameter selected_metric %} then retention_d30
          when 'retention_d60' = {% parameter selected_metric %} then retention_d60
          when 'retention_d90' = {% parameter selected_metric %} then retention_d90

          when 'cumulative_mtx_purchase_dollars_d1' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d1
          when 'cumulative_mtx_purchase_dollars_d2' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d2
          when 'cumulative_mtx_purchase_dollars_d7' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d7
          when 'cumulative_mtx_purchase_dollars_d14' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d14
          when 'cumulative_mtx_purchase_dollars_d30' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d30
          when 'cumulative_mtx_purchase_dollars_d60' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d60
          when 'cumulative_mtx_purchase_dollars_d90' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_d90
          when 'cumulative_mtx_purchase_dollars_current' = {% parameter selected_metric %} then cumulative_mtx_purchase_dollars_current


          when 'cumulative_count_mtx_purchases_d1' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d1
          when 'cumulative_count_mtx_purchases_d2' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d2
          when 'cumulative_count_mtx_purchases_d7' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d7
          when 'cumulative_count_mtx_purchases_d14' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d14
          when 'cumulative_count_mtx_purchases_d30' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d30
          when 'cumulative_count_mtx_purchases_d60' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_d60
          when 'cumulative_count_mtx_purchases_current' = {% parameter selected_metric %} then cumulative_count_mtx_purchases_current


          when 'cumulative_ad_view_dollars_d1' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d1
          when 'cumulative_ad_view_dollars_d2' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d2
          when 'cumulative_ad_view_dollars_d7' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d7
          when 'cumulative_ad_view_dollars_d14' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d14
          when 'cumulative_ad_view_dollars_d30' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d30
          when 'cumulative_ad_view_dollars_d60' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d60
          when 'cumulative_ad_view_dollars_d90' = {% parameter selected_metric %} then cumulative_ad_view_dollars_d90
          when 'cumulative_ad_view_dollars_current' = {% parameter selected_metric %} then cumulative_ad_view_dollars_current
          when 'cumulative_combined_dollars_d1' = {% parameter selected_metric %} then cumulative_combined_dollars_d1
          when 'cumulative_combined_dollars_d2' = {% parameter selected_metric %} then cumulative_combined_dollars_d2
          when 'cumulative_combined_dollars_d7' = {% parameter selected_metric %} then cumulative_combined_dollars_d7
          when 'cumulative_combined_dollars_d14' = {% parameter selected_metric %} then cumulative_combined_dollars_d14
          when 'cumulative_combined_dollars_d21' = {% parameter selected_metric %} then cumulative_combined_dollars_d21
          when 'cumulative_combined_dollars_d30' = {% parameter selected_metric %} then cumulative_combined_dollars_d30
          when 'cumulative_combined_dollars_d60' = {% parameter selected_metric %} then cumulative_combined_dollars_d60
          when 'cumulative_combined_dollars_d90' = {% parameter selected_metric %} then cumulative_combined_dollars_d90
          when 'cumulative_combined_dollars_d120' = {% parameter selected_metric %} then cumulative_combined_dollars_d120
          when 'cumulative_combined_dollars_current' = {% parameter selected_metric %} then cumulative_combined_dollars_current
          when 'highest_last_level_serial_d1' = {% parameter selected_metric %} then highest_last_level_serial_d1
          when 'highest_last_level_serial_d2' = {% parameter selected_metric %} then highest_last_level_serial_d2
          when 'highest_last_level_serial_d7' = {% parameter selected_metric %} then highest_last_level_serial_d7
          when 'highest_last_level_serial_d14' = {% parameter selected_metric %} then highest_last_level_serial_d14
          when 'highest_last_level_serial_d30' = {% parameter selected_metric %} then highest_last_level_serial_d30
          when 'highest_last_level_serial_d60' = {% parameter selected_metric %} then highest_last_level_serial_d60
          when 'highest_last_level_serial_d90' = {% parameter selected_metric %} then highest_last_level_serial_d90
          when 'highest_last_level_serial_current' = {% parameter selected_metric %} then highest_last_level_serial_current

          when 'days_played_in_first_7_days' = {% parameter selected_metric %} then days_played_in_first_7_days
          when 'days_played_in_first_14_days' = {% parameter selected_metric %} then days_played_in_first_14_days
          when 'days_played_in_first_21_days' = {% parameter selected_metric %} then days_played_in_first_21_days
          when 'days_played_in_first_30_days' = {% parameter selected_metric %} then days_played_in_first_30_days

          when 'minutes_played_in_first_1_days' = {% parameter selected_metric %} then minutes_played_in_first_1_days
          when 'minutes_played_in_first_2_days' = {% parameter selected_metric %} then minutes_played_in_first_2_days
          when 'minutes_played_in_first_7_days' = {% parameter selected_metric %} then minutes_played_in_first_7_days
          when 'minutes_played_in_first_14_days' = {% parameter selected_metric %} then minutes_played_in_first_14_days
          when 'minutes_played_in_first_21_days' = {% parameter selected_metric %} then minutes_played_in_first_21_days
          when 'minutes_played_in_first_30_days' = {% parameter selected_metric %} then minutes_played_in_first_30_days

          when 'cumulative_coins_spend_d1' = {% parameter selected_metric %} then cumulative_coins_spend_d1
          when 'cumulative_coins_spend_d2' = {% parameter selected_metric %} then cumulative_coins_spend_d2
          when 'cumulative_coins_spend_d7' = {% parameter selected_metric %} then cumulative_coins_spend_d7
          when 'cumulative_coins_spend_d14' = {% parameter selected_metric %} then cumulative_coins_spend_d14
          when 'cumulative_coins_spend_d30' = {% parameter selected_metric %} then cumulative_coins_spend_d30
          when 'cumulative_coins_spend_d60' = {% parameter selected_metric %} then cumulative_coins_spend_d60
          when 'cumulative_coins_spend_d90' = {% parameter selected_metric %} then cumulative_coins_spend_d90
          when 'cumulative_coins_spend_current' = {% parameter selected_metric %} then cumulative_coins_spend_current

          when 'puzzle_rounds_played_in_first_1_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_1_days
          when 'puzzle_rounds_played_in_first_2_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_2_days
          when 'puzzle_rounds_played_in_first_7_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_7_days
          when 'puzzle_rounds_played_in_first_14_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_14_days
          when 'puzzle_rounds_played_in_first_21_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_21_days
          when 'puzzle_rounds_played_in_first_30_days' = {% parameter selected_metric %} then puzzle_rounds_played_in_first_30_days

        else 1
        end as metric

    from
      ${player_summary_new.SQL_TABLE_NAME}

    where
      1=1

        -- and json_extract_scalar(experiments,'$.dynamicDropBiasv3_20230627') = 'control'
        {% if selected_experiment._is_filtered %}
        and json_extract_scalar(experiments,{% parameter selected_experiment %}) = {% parameter selected_variant_b %}
        {% endif %}

        -- and max_available_day_number >= 7
        {% if selected_lowest_max_available_day_number._is_filtered %}
        and max_available_day_number >= {% parameter selected_lowest_max_available_day_number %}
        {% endif %}

)

---------------------------------------------------------------------------------------
-- create first data set
---------------------------------------------------------------------------------------

, combined_data_set as (

  select rdg_id, metric, 'a' as my_group, from group_a
  union all
  select rdg_id, metric, 'b' as my_group, from group_b

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
  a.metric
  , a.my_group
  , b.iteration_number
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
    metric
    , my_group
    , iteration_number
    , random_number
    , case
        when iteration_number = 1 then my_group
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
    iteration_number
    , my_sampled_group
    , sum(1) as count_players
    , avg( metric ) as average_metric
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
    value_format_name: decimal_3
    }

  dimension: group_b {
    label: "Group B Metric Average"
    type: number
    value_format_name: decimal_3
  }

  dimension: my_difference {
    label: "Difference in Average Metric"
    type: number
    value_format_name: decimal_3
    }

  dimension: my_abs_difference {
    label: "Absolute Difference in Average Metric"
    type: number
    value_format_name: decimal_3
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
    value_format_name: decimal_3
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

      , "puzzle_rounds_played_in_first_1_days"
      , "puzzle_rounds_played_in_first_2_days"
      , "puzzle_rounds_played_in_first_7_days"
      , "puzzle_rounds_played_in_first_14_days"
      , "puzzle_rounds_played_in_first_21_days"
      , "puzzle_rounds_played_in_first_30_days"


      ]
  }



}
