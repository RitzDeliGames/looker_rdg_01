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

        -- and json_extract_scalar(experiments,'$.dynamicDropBiasv3_20230627') = 'control'
        {% if selected_experiment._is_filtered %}
        and json_extract_scalar(experiments,{% parameter selected_experiment %}) = {% parameter selected_variant %}
        {% endif %}

        -- and max_available_day_number >= 7
        {% if selected_lowest_max_available_day_number._is_filtered %}
        and max_available_day_number >= {% parameter selected_lowest_max_available_day_number %}
        {% endif %}

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

  parameter: selected_experiment {
    type: string
    default_value: "$.dynamicDropBiasv3_20230627"
    suggestions:  [
      ,"$.propBehavior_20230717"
      ,"$.zoneDrops_20230718"
      ,"$.zoneDrops_20230712"
      ,"$.hotdogContest_20230713"
      ,"$.fue1213_20230713"
      ,"$.magnifierRegen_20230711"
      ,"$.mMTiers_20230712"
      ,"$.dynamicDropBiasv3_20230627"
      ,"$.popupPri_20230628"
      ,"$.reactivationIAM_20230622"
      ,"$.playNext_20230612"
      ,"$.playNext_20230607"
      ,"$.playNext_20230503"
      ,"$.restoreBehavior_20230601"
      ,"$.moveTrim_20230601"
      ,"$.askForHelp_20230531"
      ,"$.hapticv2_20230524"
      ,"$.finalMoveAnim"
      ,"$.popUpManager_20230502"
      ,"$.fueSkip_20230425"
      ,"$.autoRestore_20230502"
      ,"$.playNext_20230503"
      ]
  }

  parameter: selected_variant {
    type: string
    default_value: "control"
    suggestions:  [
      ,"control"
      ,"variant_a"
      ,"variant_b"
      ,"variant_c"
      ,"variant_d"

    ]
  }

  parameter: selected_lowest_max_available_day_number {
    type: number
    }





}
