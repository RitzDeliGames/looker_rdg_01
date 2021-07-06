view: erasers {
  derived_table: {
    sql: select *
      from `eraser-blast.game_data.erasers`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: character_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.character_id ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  set: detail {
    fields: [character_id, display_name]
  }
}
