view: adhoc_2024_02_27_temp_alert_test {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

    select
      case
      when current_time() <= '16:20:03.170243'
      then 2
      else 3
      end as the_check

      ;;
    publish_as_db_view: no
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
