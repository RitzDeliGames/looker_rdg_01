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
      union all select 'aee7fa89-0b8e-4581-b579-e6ab291202de'
      union all select '604531b8-e07e-4173-acfa-66a5f8575454'
      union all select 'b46e876c-e30a-4ac7-bd5e-0c79e7d07546'
      union all select '2a983566-2bd1-473f-9fda-0ab60b419279'

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
