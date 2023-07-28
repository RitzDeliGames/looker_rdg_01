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
  , case when avg(my_greater_than_indicator) >= 0.95 then '95% Significant!' else 'NOT 95% Significant!' end as significance_95

from
  calculate_greater_than_instances

)

---------------------------------------------------------------------------------------
-- summarize percent_greater_than
---------------------------------------------------------------------------------------

select
  *
from
  iteration_1_only a
  cross join summarize_results b





      ;;
    persist_for: "48 hours"
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
  dimension: group_a_players {type: number}
  dimension: group_b_players {type: number}
  dimension: group_a {type: number}
  dimension: group_b {type: number}
  dimension: my_difference {type: number}
  dimension: my_abs_difference {type: number}
  dimension: my_iterations {type: number}
  dimension: percent_greater_than {type: number}
  dimension: significance_95 {type: string}

  parameter: selected_experiment {
    type: string
    default_value: "$.dynamicDropBiasv3_20230627"
    suggestions:  [
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
    ]
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

  parameter: selected_metric {
    type: string
    default_value: "days_played_in_first_7_days"
    suggestions:  [
      "days_played_in_first_7_days"

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

      ]
  }



}
