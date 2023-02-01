view: dates {
  derived_table: {
    sql:
     SELECT cast(date as date) as date
     FROM UNNEST(GENERATE_DATE_ARRAY(DATE_SUB(CURRENT_DATE, INTERVAL 5 YEAR), CURRENT_DATE)) date
      ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    sql: ${TABLE}.date ;;
  }
}
