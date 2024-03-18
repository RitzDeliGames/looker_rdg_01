view: ab_test_full_iterations_new {

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
      rdg_id
      , json_extract_scalar(experiments,{% parameter selected_experiment %}) as variant
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
      ${player_summary_new.SQL_TABLE_NAME}

    where
        -- Check Parameters
        {% parameter selected_metric_daily %} = 'None'
        and {% parameter selected_metric %} <> 'None'
        and {% parameter selected_metric_campaign_level %} = 'None'

        -- Date Filters
        and date(created_date) >= date({% parameter start_date %})
        and date(created_date) <= date({% parameter end_date %})

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

      ---------------------------------------------------------------------------------------
      -- Data From Daily Summary
      ---------------------------------------------------------------------------------------
      union all
      select
        a.rdg_id
        , max(json_extract_scalar(a.experiments,{% parameter selected_experiment %})) as variant
        , case
            when {% parameter selected_metric_daily %} = "Average Minutes Played Per Day" then sum(a.round_time_in_minutes)
            when {% parameter selected_metric_daily %} = "Average Go Fish Rounds Played Per Day" then sum(a.round_end_events_gofish)
            when {% parameter selected_metric_daily %} = "Average Go Fish Ad Views Per Day" then sum(a.ad_views_go_fish)
            when {% parameter selected_metric_daily %} = "Average Moves Master Ad Views Per Day" then sum(a.ad_views_moves_master)

            when {% parameter selected_metric_daily %} = "IAP ARPDAU" then sum(a.mtx_purchase_dollars)
            when {% parameter selected_metric_daily %} = "IAP Conversion per Day" then sum(case when a.mtx_purchase_dollars > 0 then 1 else 0 end)
            when {% parameter selected_metric_daily %} = "IAP Revenue Per Player" then sum(a.mtx_purchase_dollars)
            when {% parameter selected_metric_daily %} = "IAP Conversion Per Player" then sum(case when a.mtx_purchase_dollars > 0 then 1 else 0 end)
            when {% parameter selected_metric_daily %} = "IAP Revenue Per Spender" then sum(a.mtx_purchase_dollars)

            when {% parameter selected_metric_daily %} = "IAA ARPDAU" then sum(a.ad_view_dollars)
            when {% parameter selected_metric_daily %} = "IAA Conversion per Day" then sum(case when a.ad_view_dollars > 0 then 1 else 0 end)
            when {% parameter selected_metric_daily %} = "IAA Revenue Per Player" then sum(a.ad_view_dollars)
            when {% parameter selected_metric_daily %} = "IAA Conversion Per Player" then sum(case when a.ad_view_dollars > 0 then 1 else 0 end)
            when {% parameter selected_metric_daily %} = "IAA Revenue Per Ads Viewer" then sum(a.ad_view_dollars)

            when {% parameter selected_metric_daily %} = "Combined ARPDAU" then sum(a.combined_dollars)
            when {% parameter selected_metric_daily %} = "Combined Conversion per Day" then sum(case when a.combined_dollars > 0 then 1 else 0 end)
            when {% parameter selected_metric_daily %} = "Combined Revenue Per Player" then sum(a.combined_dollars)
            when {% parameter selected_metric_daily %} = "Combined Conversion Per Player" then sum(case when a.combined_dollars > 0 then 1 else 0 end)
            when {% parameter selected_metric_daily %} = "Combined Revenue Per IAP Spender" then sum(a.combined_dollars)

            else sum(1) end as numerator
        , case
            when {% parameter selected_metric_daily %} = "Average Minutes Played Per Day" then sum(1)
            when {% parameter selected_metric_daily %} = "Average Go Fish Rounds Played Per Day" then sum(1)
            when {% parameter selected_metric_daily %} = "Average Go Fish Ad Views Per Day" then sum(1)
            when {% parameter selected_metric_daily %} = "Average Moves Master Ad Views Per Day" then sum(1)

            when {% parameter selected_metric_daily %} = "IAP ARPDAU" then sum(a.count_days_played)
            when {% parameter selected_metric_daily %} = "IAP Conversion per Day" then sum(a.count_days_played)
            when {% parameter selected_metric_daily %} = "IAP Revenue Per Player" then max(1)
            when {% parameter selected_metric_daily %} = "IAP Conversion Per Player" then max(1)
            when {% parameter selected_metric_daily %} = "IAP Revenue Per Spender" then max(case when a.mtx_purchase_dollars > 0 then 1 else 0 end)

            when {% parameter selected_metric_daily %} = "IAA ARPDAU" then sum(a.count_days_played)
            when {% parameter selected_metric_daily %} = "IAA Conversion per Day" then sum(a.count_days_played)
            when {% parameter selected_metric_daily %} = "IAA Revenue Per Player" then max(1)
            when {% parameter selected_metric_daily %} = "IAA Conversion Per Player" then max(1)
            when {% parameter selected_metric_daily %} = "IAA Revenue Per Ads Viewer" then max(case when a.ad_view_dollars > 0 then 1 else 0 end)

            when {% parameter selected_metric_daily %} = "Combined ARPDAU" then sum(a.count_days_played)
            when {% parameter selected_metric_daily %} = "Combined Conversion per Day" then sum(a.count_days_played)
            when {% parameter selected_metric_daily %} = "Combined Revenue Per Player" then max(1)
            when {% parameter selected_metric_daily %} = "Combined Conversion Per Player" then max(1)
            when {% parameter selected_metric_daily %} = "Combined Revenue Per IAP Spender" then max(case when a.mtx_purchase_dollars > 0 then 1 else 0 end)

            else sum(1) end as denominator
      from
        ${player_daily_summary.SQL_TABLE_NAME} a
        inner join ${player_summary_new.SQL_TABLE_NAME} b
          on a.rdg_id = b.rdg_id
      where

        -- Check Parameters
        {% parameter selected_metric_daily %} <> 'None'
        and {% parameter selected_metric %} = 'None'
        and {% parameter selected_metric_campaign_level %} = 'None'

        -- Date Filters
        and date(a.rdg_date) >= date({% parameter start_date %})
        and date(a.rdg_date) <= date({% parameter end_date %})

        --Test Filter
        and json_extract_scalar(a.experiments,{% parameter selected_experiment %}) in ( {% parameter selected_variant_a %} , {% parameter selected_variant_b %} )

        -- Level Filter (start)
        {% if start_level_serial._is_filtered %}
        and a.highest_last_level_serial >= {% parameter start_level_serial %}
        {% endif %}

        -- Level Filter (end)
        {% if end_level_serial._is_filtered %}
        and a.highest_last_level_serial <= {% parameter end_level_serial %}
        {% endif %}

        -- Day Number (min)
        {% if day_number_min._is_filtered %}
        and a.day_number >= {% parameter day_number_min %}
        {% endif %}

        -- Day Number (max)
        {% if day_number_max._is_filtered %}
        and a.day_number <= {% parameter day_number_max %}
        {% endif %}

        -- filter for device platform
        {% if selected_device_platform_os._is_filtered %}
        and b.device_platform_mapping_os = {% parameter selected_device_platform_os %}
        {% endif %}

        -- minimum system memory
        {% if selected_minimum_system_memory_size._is_filtered %}
        and b.system_memory_size >= {% parameter selected_minimum_system_memory_size %}
        {% endif %}

        -- country filter
        {% if country._is_filtered %}
        and b.country = {% parameter country %}
        {% endif %}

      group by
        1

      ---------------------------------------------------------------------------------------
      -- Data From Campaign Summary
      ---------------------------------------------------------------------------------------

      union all
      select
        a.rdg_id
        , max(json_extract_scalar(a.experiments,{% parameter selected_experiment %})) as variant
        , case
          when {% parameter selected_metric_campaign_level %} = "Average APS" then sum(a.count_rounds)
          when {% parameter selected_metric_campaign_level %} = "Average Chums Used Per Level" then sum(a.total_chum_powerups_used)
          when {% parameter selected_metric_campaign_level %} = "Average Churn Rate Per Level" then max(a.churn_indicator)
          when {% parameter selected_metric_campaign_level %} = "Average In Round Coin Spend Per Level" then sum(a.in_round_coin_spend)
          when {% parameter selected_metric_campaign_level %} = "Average Moves Remaining Per Level" then sum(a.moves_remaining_on_win)


          else sum(1) end as numerator

        , case
          when {% parameter selected_metric_campaign_level %} = "Average APS" then sum(a.count_wins)
          when {% parameter selected_metric_campaign_level %} = "Average Chums Used Per Level" then sum(1)
          when {% parameter selected_metric_campaign_level %} = "Average Churn Rate Per Level" then sum(1)
          when {% parameter selected_metric_campaign_level %} = "Average In Round Coin Spend Per Level" then sum(1)
          when {% parameter selected_metric_campaign_level %} = "Average Moves Remaining Per Level" then sum(1)


          else sum(1) end as denominator
      from
        ${player_campaign_level_summary.SQL_TABLE_NAME} a
        inner join ${player_summary_new.SQL_TABLE_NAME} b
          on a.rdg_id = b.rdg_id
      where
        -- Check Parameters
        {% parameter selected_metric_daily %} = 'None'
        and {% parameter selected_metric %} = 'None'
        and {% parameter selected_metric_campaign_level %} <> 'None'

        -- Date Filters
        and date(a.first_played_rdg_date) >= date({% parameter start_date %})
        and date(a.first_played_rdg_date) <= date({% parameter end_date %})

        --Test Filter
        and json_extract_scalar(a.experiments,{% parameter selected_experiment %}) in ( {% parameter selected_variant_a %} , {% parameter selected_variant_b %} )

        -- Level Filter (start)
        {% if start_level_serial._is_filtered %}
        and level_serial >= {% parameter start_level_serial %}
        {% endif %}

        -- Level Filter (end)
        {% if end_level_serial._is_filtered %}
        and level_serial <= {% parameter end_level_serial %}
        {% endif %}

        -- Day Number (min)
        {% if day_number_min._is_filtered %}
        and day_number >= {% parameter day_number_min %}
        {% endif %}

        -- Day Number (max)
        {% if day_number_max._is_filtered %}
        and day_number <= {% parameter day_number_max %}
        {% endif %}

        -- filter for device platform
        {% if selected_device_platform_os._is_filtered %}
        and b.device_platform_mapping_os = {% parameter selected_device_platform_os %}
        {% endif %}

        -- minimum system memory
        {% if selected_minimum_system_memory_size._is_filtered %}
        and b.system_memory_size >= {% parameter selected_minimum_system_memory_size %}
        {% endif %}

        -- country filter
        {% if country._is_filtered %}
        and b.country = {% parameter country %}
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

      , "$.altLevelOrderp2_20240314"
      , "$.reversedQPO_20240313"

      , "$.livesCosting_20240202"

      , "$.hudOffers_20240228"
      , "$.movesMasterTune_20240227"
      , "$.dynamicEggs_20240223"
      , "$.altLevelOrder_20240220"

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
      , "Average Minutes Played Per Day"
      , "Average Go Fish Rounds Played Per Day"
      , "Average Go Fish Ad Views Per Day"
      , "Average Moves Master Ad Views Per Day"

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

    ]
  }

  parameter: selected_metric {
    label: "Selected Metric: Player Summary"
    type: string
    default_value: "None"
    suggestions:  [

      , "None"
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
