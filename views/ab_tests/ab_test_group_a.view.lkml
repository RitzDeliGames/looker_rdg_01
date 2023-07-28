view: ab_test_group_a {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

select
  rdg_id
  , days_played_in_first_7_days as metric

from
  eraser-blast.looker_scratch.6Y_ritz_deli_games_player_summary_new




where
  1=1

  and json_extract_scalar(experiments,'$.dynamicDropBiasv3_20230627') = 'control'
  and max_available_day_number >= 7








      ;;
    persist_for: "48 hours"
    publish_as_db_view: no

  }
        # select * from ${player_summary_new.SQL_TABLE_NAME}
        # saving code for later
        # {% if selected_display_name._is_filtered %}
        # and display_name = {% parameter selected_display_name %}
        # {% endif %}


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
  # dimension: rdg_id {group_label:"Player IDs" type: string}

  dimension: rdg_id {type: string}
  dimension: metric {type: number}

  # dimension: display_name {group_label:"Player IDs" type: string}

  # parameter: selected_display_name {
  #   type: string
  #   suggestions:  [
  #     "Amborz"
  #     ,"notAmborz"
  #     ]
  # }

}
