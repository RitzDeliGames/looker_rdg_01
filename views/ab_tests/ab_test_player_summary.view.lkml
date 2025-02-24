view: ab_test_player_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    with

      ---------------------------------------------------------------------------------------
      -- base data
      ---------------------------------------------------------------------------------------

      base_data as (

      ---------------------------------------------------------------------------------------
      -- Data From Player Summary
      ---------------------------------------------------------------------------------------

      select
      a.rdg_id
      , json_extract_scalar(experiments,{% parameter selected_experiment %}) as variant
      , case

      when 'day_1_conversion_to_5_minutes_plus' = {% parameter selected_metric %} then case when minutes_played_in_first_1_days >= 5 then 1 else 0 end
      when 'day_1_conversion_to_10_minutes_plus' = {% parameter selected_metric %} then case when minutes_played_in_first_1_days >= 10 then 1 else 0 end
      when 'day_1_conversion_to_15_minutes_plus' = {% parameter selected_metric %} then case when minutes_played_in_first_1_days >= 15 then 1 else 0 end
      when 'day_1_conversion_to_30_minutes_plus' = {% parameter selected_metric %} then case when minutes_played_in_first_1_days >= 30 then 1 else 0 end
      when 'day_1_conversion_to_45_minutes_plus' = {% parameter selected_metric %} then case when minutes_played_in_first_1_days >= 45 then 1 else 0 end
      when 'day_1_conversion_to_60_minutes_plus' = {% parameter selected_metric %} then case when minutes_played_in_first_1_days >= 60 then 1 else 0 end

      when 'retention_on_or_after_d2' = {% parameter selected_metric %} then case when highest_played_day_number >= 2 then 1 else 0 end
      when 'retention_on_or_after_d7' = {% parameter selected_metric %} then case when highest_played_day_number >= 7 then 1 else 0 end
      when 'retention_on_or_after_d14' = {% parameter selected_metric %} then case when highest_played_day_number >= 14 then 1 else 0 end
      when 'retention_on_or_after_d21' = {% parameter selected_metric %} then case when highest_played_day_number >= 21 then 1 else 0 end
      when 'retention_on_or_after_d30' = {% parameter selected_metric %} then case when highest_played_day_number >= 30 then 1 else 0 end

      when 'iap_conversion_d1' = {% parameter selected_metric %} then case when cumulative_mtx_purchase_dollars_d1 > 0 then 1 else 0 end
      when 'iap_conversion_d2' = {% parameter selected_metric %} then case when cumulative_mtx_purchase_dollars_d2 > 0 then 1 else 0 end
      when 'iap_conversion_d7' = {% parameter selected_metric %} then case when cumulative_mtx_purchase_dollars_d7 > 0 then 1 else 0 end
      when 'iap_conversion_d14' = {% parameter selected_metric %} then case when cumulative_mtx_purchase_dollars_d14 > 0 then 1 else 0 end
      when 'iap_conversion_d30' = {% parameter selected_metric %} then case when cumulative_mtx_purchase_dollars_d30 > 0 then 1 else 0 end
      when 'iap_conversion_d60' = {% parameter selected_metric %} then case when cumulative_mtx_purchase_dollars_d60 > 0 then 1 else 0 end
      when 'iap_conversion_d90' = {% parameter selected_metric %} then case when cumulative_mtx_purchase_dollars_d90 > 0 then 1 else 0 end

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

      -- cumulative_total_chum_powerups_used
      when 'cumulative_total_chum_powerups_used_d1' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d1
      when 'cumulative_total_chum_powerups_used_d2' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d2
      when 'cumulative_total_chum_powerups_used_d7' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d7
      when 'cumulative_total_chum_powerups_used_d8' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d8
      when 'cumulative_total_chum_powerups_used_d14' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d14
      when 'cumulative_total_chum_powerups_used_d15' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d15
      when 'cumulative_total_chum_powerups_used_d21' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d21
      when 'cumulative_total_chum_powerups_used_d30' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d30
      when 'cumulative_total_chum_powerups_used_d31' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d31
      when 'cumulative_total_chum_powerups_used_d46' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d46
      when 'cumulative_total_chum_powerups_used_d60' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d60
      when 'cumulative_total_chum_powerups_used_d61' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d61
      when 'cumulative_total_chum_powerups_used_d90' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d90
      when 'cumulative_total_chum_powerups_used_d120' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d120
      when 'cumulative_total_chum_powerups_used_d180' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d180
      when 'cumulative_total_chum_powerups_used_d270' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d270
      when 'cumulative_total_chum_powerups_used_d360' = {% parameter selected_metric %} then cumulative_total_chum_powerups_used_d360


      else 1
      end as numerator
      , 1 as denominator

      from
      ${player_summary_new.SQL_TABLE_NAME} a
      left join ${player_bucket_by_first_10_levels.SQL_TABLE_NAME} b
        on a.rdg_id = b.rdg_id

      where
      1=1

      -- Auto Day number
      and max_available_day_number >= case
        when right({% parameter selected_metric %},2)= 'd1' then 1
        when right({% parameter selected_metric %},2)= 'd2' then 2
        when right({% parameter selected_metric %},2)= 'd7' then 7
        when right({% parameter selected_metric %},2)= 'd8' then 8
        when right({% parameter selected_metric %},3)= 'd14' then 14
        when right({% parameter selected_metric %},3)= 'd15' then 15
        when right({% parameter selected_metric %},3)= 'd21' then 21
        when right({% parameter selected_metric %},3)= 'd30' then 30
        when right({% parameter selected_metric %},3)= 'd31' then 31
        when right({% parameter selected_metric %},3)= 'd46' then 46
        when right({% parameter selected_metric %},3)= 'd60' then 60
        when right({% parameter selected_metric %},3)= 'd61' then 61
        when right({% parameter selected_metric %},3)= 'd90' then 90
        when right({% parameter selected_metric %},4)= 'd120' then 120
        when right({% parameter selected_metric %},4)= 'd180' then 180
        when right({% parameter selected_metric %},4)= 'd270' then 270
        when right({% parameter selected_metric %},4)= 'd360' then 360

        when right({% parameter selected_metric %},7)= '_1_days' then 1
        when right({% parameter selected_metric %},7)= '_2_days' then 2
        when right({% parameter selected_metric %},7)= '_7_days' then 7
        when right({% parameter selected_metric %},8)= '_14_days' then 14
        when right({% parameter selected_metric %},8)= '_21_days' then 21
        when right({% parameter selected_metric %},8)= '_30_days' then 30

        else 0
        end

      -- Date Filters
      {% if start_date._is_filtered %}
      and date(created_date) >= date({% parameter start_date %})
      {% endif %}

      {% if end_date._is_filtered %}
      and date(created_date) <= date({% parameter end_date %})
      {% endif %}

      --Test Filter
      and json_extract_scalar(experiments,{% parameter selected_experiment %}) in ( {% parameter selected_variant_a %} , {% parameter selected_variant_b %} )

      -- Day Number (min)
      {% if day_number_min._is_filtered %}
      and max_available_day_number >= {% parameter day_number_min %}
      {% endif %}

      -- Day Number (max)
      {% if day_number_max._is_filtered %}
      and max_available_day_number <= {% parameter day_number_max %}
      {% endif %}

      -- filter for device platform
      {% if selected_device_platform_os._is_filtered %}
      and device_platform_mapping_os = {% parameter selected_device_platform_os %}
      {% endif %}

      -- minimum system memory
      {% if selected_minimum_system_memory_size._is_filtered %}
      and system_memory_size >= {% parameter selected_minimum_system_memory_size %}
      {% endif %}

      -- maximum system memory
      {% if selected_maximum_system_memory_size._is_filtered %}
      and system_memory_size <= {% parameter selected_maximum_system_memory_size %}
      {% endif %}

      -- Level Filter (start)
      {% if start_level_serial._is_filtered %}
      and highest_last_level_serial_current >= {% parameter start_level_serial %}
      {% endif %}

      -- Level Filter (end)
      {% if end_level_serial._is_filtered %}
      and highest_last_level_serial_current <= {% parameter end_level_serial %}
      {% endif %}

      -- country filter
      {% if country._is_filtered %}
      and country = {% parameter country %}
      {% endif %}

      -- Moves To Beat First 10 Levels (Min)
      {% if moves_to_beat_first_10_levels_min._is_filtered %}
      and b.moves_made >= {% parameter moves_to_beat_first_10_levels_min %}
      {% endif %}

      -- Moves To Beat First 10 Levels (Max)
      {% if moves_to_beat_first_10_levels_max._is_filtered %}
      and b.moves_made <= {% parameter moves_to_beat_first_10_levels_max %}
      {% endif %}


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
      , safe_divide( sum( numerator ) , sum( denominator ) ) as average_metric
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
      round( safe_divide( max(my_abs_difference) over (), 50 ) , 6 )
      *
      safe_cast(round(
      safe_divide(
      my_abs_difference
      , safe_divide( max(my_abs_difference) over (), 50 )
      )
      , 0 ) as int64)
      ,6)
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
    label: "Significance Check"
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

  measure: count_of_iterations {
    type:  number
    sql:
     sum(
      case
        when ${TABLE}.iteration_type = 'iterations'
        then ${TABLE}.count_iterations
        else 0
        end
      )
    ;;
  }

  measure: count_of_actuals {
    type:  number
    sql:
     sum(
      case
        when ${TABLE}.iteration_type = 'actual'
        then 1
        else 0
        end
      )
    ;;
  }


  parameter: selected_experiment {
    type: string
    default_value: "$.dynamicDropBiasv3_20230627"
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

  parameter: mininum_start_level_serial {
    label: "Minimum Lowest Level Serial"
    type: number
  }

  parameter: maximum_end_level_serial {
    label: "Maximum Highest Level Serial"
    type: number
  }

  parameter: day_number_min {
    type: number
  }

  parameter: day_number_max {
    type: number
  }

  parameter: moves_to_beat_first_10_levels_min {
    type: number
  }

  parameter: moves_to_beat_first_10_levels_max {
    type: number
  }

  parameter: selected_minimum_system_memory_size {
    type: number
  }

  parameter: selected_maximum_system_memory_size {
    type: number
  }

  parameter: selected_device_platform_os {
    type: string
    default_value: "Android"
    suggestions:  ["Android","iOS"]
  }

  parameter: country {
    type: string
    default_value: "US"
    suggestions:  ["US"]
  }

  parameter: selected_iterations {
    type: number
  }

  parameter: selected_significance {
    type: number
  }

  parameter: selected_metric_daily {
    label: "Selected Metric: Daily Summary"
    type: string
    default_value: "None"
    suggestions:  [

      , "None"
      , "Average Go Fish Rounds Played Per Day"
      , "Average Go Fish Rounds Played Per Player"

      , "Average Moves Master Rounds Played Per Day"
      , "Average Moves Master Rounds Played Per Player"

      , "Average Gem Quest Rounds Played Per Day"
      , "Average Gem Quest Rounds Played Per Player"

      , "Average Go Fish Ad Views Per Day"
      , "Average Moves Master Ad Views Per Day"
      , "Average Ad Views Per Day"

      , "Average Go Fish Ad Views Per Player"
      , "Average Moves Master Ad Views Per Player"
      , "Average Ad Views Per Player"

      , "IAP ARPDAU"
      , "IAP Conversion per Day"
      , "IAP Revenue Per Player"
      , "IAP Conversion Per Player"
      , "IAP Revenue Per Spender"

      , "IAA ARPDAU"
      , "IAA Conversion per Day"
      , "IAA Revenue Per Player"
      , "IAA Conversion Per Player"
      , "IAA Revenue Per Ads Viewer"

      , "Combined ARPDAU"
      , "Combined Conversion per Day"
      , "Combined Revenue Per Player"
      , "Combined Conversion Per Player"
      , "Combined Revenue Per IAP Spender"

      , "Average Coin Spend Per Day"
      , "Average Coin Spend Per Player"

      , "Average Days Played Per Player"
      , "Average Round End Events Per Player"
      , "Average Churn Rate Per Player"

      , "Average Daily Feature Participation (Any Event)"

    ]
  }

  parameter: selected_metric {
    label: "Selected Metric: Player Summary"
    type: string
    default_value: "None"
    suggestions:  [

      , "None"

      , "day_1_conversion_to_5_minutes_plus"
      , "day_1_conversion_to_10_minutes_plus"
      , "day_1_conversion_to_15_minutes_plus"
      , "day_1_conversion_to_30_minutes_plus"
      , "day_1_conversion_to_45_minutes_plus"
      , "day_1_conversion_to_60_minutes_plus"

      , "retention_on_or_after_d2"
      , "retention_on_or_after_d7"
      , "retention_on_or_after_d14"
      , "retention_on_or_after_d21"
      , "retention_on_or_after_d30"

      , "iap_conversion_d1"
      , "iap_conversion_d2"
      , "iap_conversion_d7"
      , "iap_conversion_d14"
      , "iap_conversion_d30"
      , "iap_conversion_d60"
      , "iap_conversion_d90"

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

  parameter: selected_metric_campaign_level {
    label: "Selected Metric: Campaign Summary"
    type: string
    default_value: "None"
    suggestions:  [

      , "None"
      , "Average APS"
      , "Average Chums Used Per Level"
      , "Average Churn Rate Per Level"
      , "Average In Round Coin Spend Per Level"
      , "Average Moves Remaining Per Level"


    ]
  }


}
