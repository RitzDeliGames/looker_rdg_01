view: player_achievement_summary {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-12-11'


      with

      ----------------------------------------------------------------------
      -- get last timestamp per day
      ----------------------------------------------------------------------

      last_timestamp_table as (

        select
          rdg_id
          , rdg_date
          , max(timestamp_utc) as max_timestamp_utc
        from
          ${player_achievement_incremental.SQL_TABLE_NAME}
        group by
          1,2
      )

      ----------------------------------------------------------------------
      -- filter to latest timestamp for each day
      ----------------------------------------------------------------------

      , filtered_data_table as (

        select
          a.rdg_id
          , a.rdg_date
          , max(a.timestamp_utc) as timestamp_utc
          , max(a.created_at) as created_at
          , max(a.version) as version
          , max(a.user_type) as user_type
          , max(a.extra_json) as extra_json
          , max(a.experiments) as experiments
          , max(a.win_streak) as win_streak
          , max(a.currencies) as currencies
          , max(a.last_level_serial) as last_level_serial
          , max(a.engagement_ticks) as engagement_ticks
          , max(a.cumulative_time_played_minutes) as cumulative_time_played_minutes
        from
          ${player_achievement_incremental.SQL_TABLE_NAME} a
          inner join last_timestamp_table b
            on a.rdg_id = b.rdg_id
            and a.rdg_date = b.rdg_date
            and a.timestamp_utc = b.max_timestamp_utc
        group by
          a.rdg_id
          , a.rdg_date

      )

      ----------------------------------------------------------------------
      -- extract achievements from extra json
      ----------------------------------------------------------------------

      , extract_achievements_table as (

        select
          *
          , json_extract( extra_json , "$.achievements" ) as achievements_json
        from
          filtered_data_table

      )

      ----------------------------------------------------------------------
      -- get all the achievements
      ----------------------------------------------------------------------

      select
        *
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.characters_collected" ) as int64 ) , 0 ) as characters_collected
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.wins_total" ) as int64 ) , 0 ) as wins_total
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.max_streak" ) as int64 ) , 0 ) as max_streak
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.go_fish_rank" ) as int64 ) , 0 ) as go_fish_rank
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.gem_quest_trophy" ) as int64 ) , 0 ) as gem_quest_trophy
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.puzzles_completed" ) as int64 ) , 0 ) as puzzles_completed
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.moves_master_rank_1" ) as int64 ) , 0 ) as moves_master_rank_1
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.moves_master_rank_2_5" ) as int64 ) , 0 ) as moves_master_rank_2_5
        , ifnull( safe_cast( json_extract_scalar( achievements_json , "$.secret_eggs" ) as int64 ) , 0 ) as secret_eggs
      from
        extract_achievements_table


      ;;
    ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (2) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

  ####################################################################
  ## Primary Key
  ####################################################################

  dimension: primary_key {
    type: string
    sql:
      ${TABLE}.rdg_id
      || '_' || ${TABLE}.rdg_date
      || '_' || ${TABLE}.timestamp_utc
      ;;
    primary_key: yes
    hidden: yes
  }

####################################################################
## Generic Dimensions
####################################################################

  dimension: rdg_id {type:string}
  dimension: version {type:string}
  dimension: version_number {type:number sql: safe_cast(${TABLE}.version as numeric ) ;;}
  dimension: experiments {type:string}
  dimension: win_streak {type:number}
  dimension: last_level_serial {type:number}
  dimension: cumulative_time_played_minutes {type:number}
  dimension: day_number {type: number}

####################################################################
## Date Group
####################################################################

  dimension_group: rdg_date_analysis {
    label: "Activity"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

####################################################################
## Experiments
####################################################################

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

####################################################################
## Level Buckets
####################################################################

  parameter: dynamic_level_bucket_size {
    type: number
  }

  dimension: dynamic_level_bucket {
    label: "Dynamic Level Bucket"
    type:string
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.last_level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as string
      )
    || ' to '
    ||
    safe_cast(
      ceiling(safe_divide(${TABLE}.last_level_serial+1,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}-1
      as string
      )
    ;;
  }

  dimension: dynamic_level_bucket_order {
    label: "Dynamic Level Bucket Order"
    type:number
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.last_level_serial,{% parameter dynamic_level_bucket_size %}))*{% parameter dynamic_level_bucket_size %}
      as int64
      )
    ;;
  }

####################################################################
## Measures
####################################################################

  measure: count_distinct_active_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: count_rows {
    type: sum
    sql: 1 ;;
  }

####################################################################
## Custom Measures
####################################################################

  measure: average_characters_collected { type: average sql: ${TABLE}.characters_collected ;; }
  measure: average_wins_total { type: average sql: ${TABLE}.wins_total ;; }
  measure: average_max_streak { type: average sql: ${TABLE}.max_streak ;; }
  measure: average_go_fish_rank { type: average sql: ${TABLE}.go_fish_rank ;; }
  measure: average_gem_quest_trophy { type: average sql: ${TABLE}.gem_quest_trophy ;; }
  measure: average_puzzles_completed { type: average sql: ${TABLE}.puzzles_completed ;; }
  measure: average_moves_master_rank_1 { type: average sql: ${TABLE}.moves_master_rank_1 ;; }
  measure: average_moves_master_rank_2_5 { type: average sql: ${TABLE}.moves_master_rank_2_5 ;; }
  measure: average_secret_eggs { type: average sql: ${TABLE}.secret_eggs ;; }

















}
