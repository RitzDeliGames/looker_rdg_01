view: display_name_helper {
  derived_table: {
    sql:
        with display_names as (
        select
          rdg_id
          ,display_name
          ,timestamp
          ,last_value(display_name)
            over(partition by rdg_id order by timestamp asc
            rows between unbounded preceding and unbounded following) current_display_name
        from `eraser-blast.game_data.events`
        where date(timestamp) between '2019-01-01' and current_date()
          and event_name = 'round_end'
        order by 1, 2 asc)

        select
          display_names.rdg_id rdg_id
          ,display_names.current_display_name current_display_name
        from display_names
        group by 1,2
      ;;

    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
    #partition_keys: ["created"]
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    sql: ${rdg_id} || '_' || ${display_name} ;;
    hidden: yes
  }

  dimension: rdg_id {
    group_label: "Player IDs"
    hidden: yes
    sql: ${TABLE}.rdg_id ;;
  }

  dimension:  display_name {
    group_label: "Player IDs"
    label: "Current Display Name"
    sql: ${TABLE}.current_display_name ;;
  }

  # measure: user_id_count {
  #   label: "Count of RDG Ids"
  #   type: count_distinct
  #   sql: ${rdg_id} ;;
  # }

  # measure: current_display_name_count {
  #   label: "Count of Display Names"
  #   type: count_distinct
  #   sql: ${display_name} ;;
  # }
}
