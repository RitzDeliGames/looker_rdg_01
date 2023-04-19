view: level_mechanics {

################################################################
## View SQL
################################################################

    derived_table: {
      sql:

      -- ccb_aggregate_update_tag
      -- last manual update: '2023-04-19' (2)

      select * from tal_scratch.level_mechanics_from_chum_mastersheet_hardcoded

      ;;
      sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -4 hour)) ;;
      publish_as_db_view: yes

    }

####################################################################
## Primary Key
####################################################################

    dimension: primary_key {
      type: string
      sql:
          ${TABLE}.level_serial
          ;;
      primary_key: yes
      hidden: yes
    }

################################################################
## Dimensions
################################################################

    dimension: level_serial {type:number}
    dimension: intended_difficulty {type:string}
    dimension: mechanics_list {type:string}

  }
