view: adhoc_2024_03_01_test_campaign_creative_roas {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

       select
        @{singular_campaign_id_override_without_table} as singular_campaign_id_override
        , @{singular_simple_ad_name_without_table} as singular_simple_ad_name
        , sum( cumulative_mtx_purchase_dollars_d8 )  as big_fish_d8
       from
        ${player_summary_new.SQL_TABLE_NAME}
       group by
        1,2

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

dimension: singular_campaign_id_override {
  type: string
  sql: ${TABLE}.singular_campaign_id_override ;;

}


}
