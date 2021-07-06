view: id_helper {
      derived_table: {
        sql:
          select
            rdg_id
            ,user_id
          from game_data.events
          where timestamp >= '2019-01-01'
            and user_type = 'external'
            and country != 'ZZ'
            and coalesce(install_version,'null') <> '-1'
          group by 1, 2
          order by 2 desc;;
      }

    dimension: rdg_id {}
    dimension: user_id {}
    measure: rdg_id_count {
      type: count_distinct
      sql: ${TABLE}.rdg_id ;;
    }
    measure: user_id_count {
      type: count_distinct
      sql: ${TABLE}.user_id ;;
    }
}
