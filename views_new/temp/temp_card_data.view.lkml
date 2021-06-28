view: temp_card_data {
  derived_table: {
    datagroup_trigger: change_at_midnight
    sql: select
          --json_query(extra_json,'$.node_data[12]') current_node_entry,
          json_query(extra_json,'$.node_data[0]') node_data_1
          ,json_query(extra_json,'$.node_data[1]') node_data_2
          ,json_query(extra_json,'$.node_data[2]') node_data_3
          ,json_query(extra_json,'$.node_data[3]') node_data_4
          ,json_query(extra_json,'$.node_data[4]') node_data_5
          ,json_query(extra_json,'$.node_data[5]') node_data_6
          ,json_query(extra_json,'$.node_data[6]') node_data_7
          ,json_query(extra_json,'$.node_data[7]') node_data_8
          ,json_query(extra_json,'$.node_data[8]') node_data_9
          ,json_query(extra_json,'$.node_data[9]') node_data_10
          ,json_query(extra_json,'$.node_data[10]') node_data_11
          ,json_query(extra_json,'$.node_data[11]') node_data_12
          ,json_query(extra_json,'$.node_data[12]') node_data_13
          ,json_query(extra_json,'$.node_data[13]') node_data_14
          ,json_query(extra_json,'$.node_data[14]') node_data_15
          ,json_query(extra_json,'$.node_data[15]') node_data_16
          ,json_query(extra_json,'$.node_data[16]') node_data_17
          ,json_query(extra_json,'$.node_data[17]') node_data_18
          ,json_query(extra_json,'$.node_data[18]') node_data_19
          ,json_query(extra_json,'$.node_data[19]') node_data_20
          ,json_query(extra_json,'$.node_data[20]') node_data_21
          ,json_query(extra_json,'$.node_data[21]') node_data_22
          ,json_query(extra_json,'$.node_data[22]') node_data_23
          ,json_query(extra_json,'$.node_data[23]') node_data_24
          ,timestamp
          ,json_extract_scalar(extra_json,'$.card_id') card_id
          ,rdg_id

        from game_data.events
        where user_type = 'external'
          and event_name = 'cards'
          and timestamp >= timestamp(current_date() - 1)
        order by timestamp desc
  ;;}

dimension: primary_key {
  hidden: yes
  type: string
  sql: ${rdg_id} || ${timestamp} ;;
}

dimension: node_data_1 {
  type: string
  sql:  ${TABLE}.node_data_1 ;;
}

dimension: node_data_2 {
    type: string
    sql:  ${TABLE}.node_data_2 ;;
  }

dimension: node_data_3 {
    type: string
    sql:  ${TABLE}.node_data_3 ;;
  }

dimension: rdg_id {}

dimension: timestamp {
  type: date_time
}

dimension: card_id {}
}
