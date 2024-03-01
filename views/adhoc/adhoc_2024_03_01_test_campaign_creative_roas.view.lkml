view: adhoc_2024_03_01_test_campaign_creative_roas {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

       select
        @{singular_simple_ad_name_without_table} as singular_simple_ad_name
        -- 1 as singular_simple_ad_name
       from
        ${player_summary_new.SQL_TABLE_NAME}
       group by
        1

      ;;
    publish_as_db_view: no
  }


################################################################
## Dimensions
################################################################

dimension: singular_simple_ad_name {
  type: string
  sql: ${TABLE}.singular_simple_ad_name ;;
}




}
