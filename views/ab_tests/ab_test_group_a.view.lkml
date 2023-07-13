view: ab_test_group_a {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      select * from ${player_summary_new.SQL_TABLE_NAME}

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -5 hour)) ;;
    publish_as_db_view: yes
    partition_keys: ["created_date"]

  }


}
