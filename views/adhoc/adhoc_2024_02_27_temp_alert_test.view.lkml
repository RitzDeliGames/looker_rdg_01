view: adhoc_2024_02_27_temp_alert_test {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

   select extract(minute from DATE_ADD(timestamp_trunc(current_timestamp, hour), INTERVAL -5 minute)) as the_check

      ;;
    # publish_as_db_view: no
    sql_trigger_value: select DATE_ADD(timestamp_trunc(current_timestamp, hour), INTERVAL -5 minute) ;;
    publish_as_db_view: yes
  }


################################################################
## Measures
################################################################

  measure: my_check {
    type: number
    sql:
        max(${TABLE}.the_check)

      ;;
    value_format_name: decimal_0
  }




}
