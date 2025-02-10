view: player_block_list {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2025-02-10'

      select '' as rdg_id

      union all select '6a7e54eb-c520-4f61-9323-dc37c0207bcd'

      ;;
    sql_trigger_value: select extract( year from current_timestamp());;
    publish_as_db_view: yes

  }


####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: rdg_id {
    type: string
  }


}
