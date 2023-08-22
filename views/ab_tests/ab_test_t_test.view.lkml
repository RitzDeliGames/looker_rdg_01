view: ab_test_t_test {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

   with

---------------------------------------------------------------------------
-- base data
---------------------------------------------------------------------------

base_data as (

  select
    rdg_id
    , safe_cast(
        json_extract_scalar(
            experiments
            , "$.dynamicDropBiasv3_20230627"
        )
        as string) as experiment_variant
    , retention_d2 as metric
  from
    eraser-blast.looker_scratch.6Y_ritz_deli_games_player_summary_new
  where
    safe_cast(
        json_extract_scalar(
            experiments
            , "$.dynamicDropBiasv3_20230627"
        )
        as string) in ('control', 'variant_a')
    and max_available_day_number >= 2

)

---------------------------------------------------------------------------
-- break out into columns
---------------------------------------------------------------------------

, break_out_into_columns as (

  select
    rdg_id
    , case when experiment_variant = 'control' then metric else null end as metric_control
    , case when experiment_variant = 'variant_a' then metric else null end as metric_variant_a

  from
    base_data

)

---------------------------------------------------------------------------
-- check averages
---------------------------------------------------------------------------

-- select
--   avg(metric_control) as metric_control
--   , avg(metric_variant_a) as metric_variant_a
-- from
--   break_out_into_columns

---------------------------------------------------------------------------
-- select output
---------------------------------------------------------------------------

select * from break_out_into_columns


      ;;
    publish_as_db_view: no
  }

####################################################################
## Primary Key
####################################################################

  dimension: my_primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################


  dimension: rdg_id {type: string}
  dimension: metric_control {type: number}
  dimension: metric_variant_a {type: number}

################################################################
## Measures
################################################################

  measure: average_metric_control {
    type: number
    value_format_name: percent_1
    sql: avg(${TABLE}.metric_control) ;;

  }

  measure: average_metric_variant_a {
    type: number
    value_format_name: percent_1
    sql: avg(${TABLE}.metric_variant_a) ;;

  }


}
