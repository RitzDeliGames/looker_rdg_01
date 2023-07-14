view: ab_test_group_a {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      select * from ${player_summary_new.SQL_TABLE_NAME}

      where
        1=1

        {% if selected_display_name._is_filtered %}
        and display_name = {% parameter selected_display_name %}
        {% endif %}
      ;;
    persist_for: "48 hours"
    publish_as_db_view: no
    partition_keys: ["created_date"]

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

  # strings
  dimension: rdg_id {group_label:"Player IDs" type: string}
  dimension: display_name {group_label:"Player IDs" type: string}

  parameter: selected_display_name {
    type: string
    suggestions:  [
      "Amborz"
      ,"notAmborz"
      ]
  }

}
