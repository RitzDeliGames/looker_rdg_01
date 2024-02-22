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

    player_summary as ( select * from ${player_summary_new.SQL_TABLE_NAME} )

    --------------------------------------------------------------------------------------------------------------------------------
    -- All Players
    --------------------------------------------------------------------------------------------------------------------------------

    , all_players as (

      select * from (
        select "" as test_name, '' as rdg_id, null as variant
          union all select "loAdMax_20240131" as test_name, rdg_id, json_extract_scalar(experiments,"$.loAdMax_20240131") as variant from player_summary
          union all select "swapTeamp2_20240209" as test_name, rdg_id, json_extract_scalar(experiments, "$.swapTeamp2_20240209") as variant from player_summary
          union all select "goFishAds_20240208" as test_name, rdg_id, json_extract_scalar(experiments, "$.goFishAds_20240208") as variant from player_summary
          union all select "dailyPopups_20240207" as test_name, rdg_id, json_extract_scalar(experiments, "$.dailyPopups_20240207") as variant from player_summary
          union all select "ExtraMoves1k_20240130" as test_name, rdg_id, json_extract_scalar(experiments, "$.ExtraMoves1k_20240130") as variant from player_summary
          union all select "loAdMax_20240131" as test_name, rdg_id, json_extract_scalar(experiments, "$.loAdMax_20240131") as variant from player_summary
          union all select "extendedQPO_20240131" as test_name, rdg_id, json_extract_scalar(experiments, "$.extendedQPO_20240131") as variant from player_summary
          union all select "propBehavior_20240118" as test_name, rdg_id, json_extract_scalar(experiments, "$.propBehavior_20240118") as variant from player_summary
          union all select "lv400500MovesTest_20240116" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv400500MovesTest_20240116") as variant from player_summary
          union all select "lv200300MovesTest_20240116" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv200300MovesTest_20240116") as variant from player_summary
          union all select "extraMovesOffering_20240111" as test_name, rdg_id, json_extract_scalar(experiments, "$.extraMovesOffering_20240111") as variant from player_summary
          union all select "lv650800Moves_20240105" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv650800Moves_20240105") as variant from player_summary
          union all select "lv100200Movesp2_20240103" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv100200Movesp2_20240103") as variant from player_summary
          union all select "fueLevelsV3p2_20240102" as test_name, rdg_id, json_extract_scalar(experiments, "$.fueLevelsV3p2_20240102") as variant from player_summary
          union all select "scrollableTT_20231213" as test_name, rdg_id, json_extract_scalar(experiments, "$.scrollableTT_20231213") as variant from player_summary
          union all select "coinMultiplier_20231208" as test_name, rdg_id, json_extract_scalar(experiments, "$.coinMultiplier_20231208") as variant from player_summary
          union all select "lv100200Moves_20231207" as test_name, rdg_id, json_extract_scalar(experiments, "$.lv100200Moves_20231207") as variant from player_summary
          union all select "fueLevelsV3_20231207" as test_name, rdg_id, json_extract_scalar(experiments, "$.fueLevelsV3_20231207") as variant from player_summary
          union all select "blockColor_20240119" as test_name, rdg_id, json_extract_scalar(experiments, "$.blockColor_20240119") as variant from player_summary
      )
      where
        variant is not null

    )

    --------------------------------------------------------------------------------------------------------------------------------
    -- Add Metrics
    --------------------------------------------------------------------------------------------------------------------------------

    , combined_data_set as (

      select
        a.*
        , 1 as count_players
        , b.retention_d2
      from
        all_players a
        inner join player_summary b
          on a.rdg_id = b.rdg_id

    )

    --------------------------------------------------------------------------------------------------------------------------------
    -- Sumarize
    --------------------------------------------------------------------------------------------------------------------------------

    select
      test_name
      , sum( case when variant = 'control' then count_players else 0 end ) as control_count_players
      , sum( case when variant = 'variant_a' then count_players else 0 end ) as variant_a_count_players
      , sum( case when variant = 'control' then retention_d2 else 0 end ) as control_retention_d2
      , sum( case when variant = 'variant_a' then retention_d2 else 0 end ) as variant_a_retention_d2

    from
      combined_data_set
    group by
      1

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
## Dimensions
################################################################

  dimension: test_name {
    label: "AB Test"
    type: string
    sql: ${TABLE}.test_name ;;
    }

  dimension: control_count_players {
    label: "Control Players"
    type: number
    sql: ${TABLE}.control_count_players;;
    }

  dimension: variant_a_count_players {
    label: "Variant A Players"
    type: number
    sql: ${TABLE}.variant_a_count_players;;
    }

  dimension: control_retention_d2 {
    label: "Control Retention Numerator"
    type: number
    sql: ${TABLE}.control_retention_d2;;
    }

  dimension: variant_a_retention_d2 {
    label: "Variant A Retention Numerator"
    type: number
    sql: ${TABLE}.variant_a_retention_d2;; }

################################################################
## Measures
################################################################

measure: control_installs {
  label: "Control Installs"
  type: number
  value_format_name: decimal_0
  sql: sum(${TABLE}.control_count_players) ;;
}

  measure: variant_a_installs {
    label: "Variant A Installs"
    type: number
    value_format_name: decimal_0
    sql: sum(${TABLE}.variant_a_count_players) ;;
  }

 measure: control_retention {
  label: "Control Retention"
  type: number
  value_format_name: percent_1
  sql:
    safe_divide(
      sum( ${TABLE}.control_retention_d2)
      ,
      sum( ${TABLE}.control_count_players)
      )
        ;;
 }

  measure: variant_a_retention {
    label: "Variant A Retention"
    type: number
    value_format_name: percent_1
    sql:
    safe_divide(
      sum( ${TABLE}.variant_a_retention_d2)
      ,
      sum( ${TABLE}.variant_a_count_players)
      )
        ;;
  }



}
