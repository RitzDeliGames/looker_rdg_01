view: click_stream {
  derived_table: {
    sql:

      select
        rdg_id
        ,country
        ,install_version
        ,version
        ,timestamp
        ,event_name
        ,engagement_ticks
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_02") as numeric) currency_02_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_05") as numeric) currency_05_balance
        ,cast(last_level_serial as int64) last_level_serial
        ,json_extract_scalar(extra_json,"$.button_tag") button_tag
        ,experiments
        ,extra_json
        ,last_level_id
        ,lag(timestamp)
            over (partition by rdg_id order by timestamp desc) greater_level_completed
      from `eraser-blast.game_data.events`
      where event_name = 'ButtonClicked'
        and DATE(timestamp) >= DATE_ADD(CURRENT_DATE(), INTERVAL -9 DAY)
        AND DATE(timestamp) <= DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY)
        and user_type = 'external'
        and country != 'ZZ'
        and coalesce(install_version,'null') <> '-1'
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

      /*

      -- New SQL For Puzzles Only
      -- 2023-03-28
      -- SQL To Analyze First Week of Puzzles

      with

      ---------------------------------------------------------------------------
      -- Puzzle Button Clicks
      ---------------------------------------------------------------------------

      puzzle_button_clicks as (

        select
          rdg_id
          , first_value(country) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as country

          , first_value(install_version) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as install_version

          , first_value(version) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as version

          , first_value(timestamp) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as timestamp

          , first_value(event_name) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as event_name

          , first_value(engagement_ticks) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as engagement_ticks

          , first_value(cast(json_extract_scalar(currencies,"$.CURRENCY_02") as numeric)) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as currency_02_balance

          , first_value(cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric)) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as currency_03_balance

          , first_value(cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric)) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as currency_04_balance

          , first_value(cast(json_extract_scalar(currencies,"$.CURRENCY_05") as numeric)) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as currency_05_balance

          , first_value(last_level_serial) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as last_level_serial

          ,json_extract_scalar(extra_json,"$.button_tag") button_tag

          , first_value(experiments) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as experiments

          , first_value(extra_json) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as extra_json

          , first_value(last_level_id) over (
              partition by rdg_id, json_extract_scalar(extra_json,"$.button_tag")
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as last_level_id

            ,lag(timestamp)
                over (partition by rdg_id order by timestamp desc) greater_level_completed
        from
          `eraser-blast.game_data.events`
        where
          date(timestamp) between "2023-03-22" and '2023-03-27'
          and event_name = 'ButtonClicked'
          and json_extract_scalar(extra_json,"$.button_tag") in (
            'Puzzle.pz_event_01'
            , 'Sheet_Puzzles.GotIt'
            , 'Sheet_Puzzles.Pregame'
            , 'Sheet_Puzzles.RewardReveal'
            , 'Sheet_Puzzles.Claim'
            , 'Sheet_Puzzles.Finish' )

      )

      ---------------------------------------------------------------------------
      -- Puzzle Button Clicks Summarized By Player
      ---------------------------------------------------------------------------

      , puzzle_button_clicks_summarized_by_player as (

        select
          rdg_id
          ,min(country) as country
          ,min(install_version) as install_version
          ,min(version) as version
          ,min(timestamp) as timestamp
          ,min(event_name) as event_name
          ,min(engagement_ticks) as engagement_ticks
          ,min(currency_02_balance) as currency_02_balance
          ,min(currency_03_balance) as currency_03_balance
          ,min(currency_04_balance) as currency_04_balance
          ,min(currency_05_balance) as currency_05_balance
          ,min(last_level_serial) as last_level_serial
          ,button_tag
          ,min(experiments) as experiments
          ,min(extra_json) as extra_json
          ,min(last_level_id) as last_level_id
          ,min(greater_level_completed) as greater_level_completed
        from
          puzzle_button_clicks
        group by
          rdg_id, button_tag
      )

      ---------------------------------------------------------------------------
      -- Round End Win Events For Puzzle
      ---------------------------------------------------------------------------

      , puzzle_round_wins as (

        select
          rdg_id
          , 1 as count_wins

          , first_value(country) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as country

          , first_value(install_version) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as install_version

          , first_value(version) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as version

          , first_value(timestamp) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as timestamp

          , first_value(event_name) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as event_name

          , first_value(engagement_ticks) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as engagement_ticks

          , first_value(cast(json_extract_scalar(currencies,"$.CURRENCY_02") as numeric)) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as currency_02_balance

          , first_value(cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric)) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as currency_03_balance

          , first_value(cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric)) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as currency_04_balance

          , first_value(cast(json_extract_scalar(currencies,"$.CURRENCY_05") as numeric)) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as currency_05_balance

          , first_value(last_level_serial) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as last_level_serial

          , first_value(experiments) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as experiments

          , first_value(extra_json) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as extra_json

          , first_value(last_level_id) over (
              partition by rdg_id
              order by timestamp
              rows between unbounded preceding and unbounded following
              ) as last_level_id

            ,lag(timestamp)
                over (partition by rdg_id order by timestamp desc) greater_level_completed



        from
          `eraser-blast.game_data.events`
        where
          date(timestamp) between "2023-03-22" and '2023-03-27'
          and event_name = 'round_end'
          and json_extract_scalar(extra_json,"$.game_mode") = 'puzzle'
          and cast(json_extract_scalar( extra_json , "$.quest_complete") as boolean) = true


      )

      ---------------------------------------------------------------------------
      -- Round End Win Events For Puzzle Summarized
      ---------------------------------------------------------------------------

      , puzzle_round_wins_summarized as (

      select

          rdg_id
          ,min(country) as country
          ,min(install_version) as install_version
          ,min(version) as version
          ,min(timestamp) as timestamp
          ,min(event_name) as event_name
          ,min(engagement_ticks) as engagement_ticks
          ,min(currency_02_balance) as currency_02_balance
          ,min(currency_03_balance) as currency_03_balance
          ,min(currency_04_balance) as currency_04_balance
          ,min(currency_05_balance) as currency_05_balance
          ,min(last_level_serial) as last_level_serial
          ,case
            when sum(1) <= 1 then '1 Puzzle Round Won'
            when sum(1) between 2 and 9 then '2-9 Puzzle Rounds Won'
            else '10+ Puzzle Rounds Won'
            end as button_tag
          -- 'Puzzle Round Wins: '|| sum(1) as button_tag
          ,min(experiments) as experiments
          ,min(extra_json) as extra_json
          ,min(last_level_id) as last_level_id
          ,min(greater_level_completed) as greater_level_completed


      from
        puzzle_round_wins
      group by
        1
      )

      ---------------------------------------------------------------------------
      -- Union Together
      ---------------------------------------------------------------------------

      select
        *
      from
        puzzle_round_wins_summarized
      union all
      select
        *
      from
        puzzle_button_clicks_summarized_by_player
      order by
        timestamp

    */


      ;;
    datagroup_trigger: change_at_midnight
    publish_as_db_view: yes

  }
  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${event_raw} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    hidden: no
  }
  dimension: country {
    group_label: "Device & OS Dimensions"
    label: "Device Country"
    type: string
  }
  dimension: region {
    group_label: "Device & OS Dimensions"
    label: "Device Region"
    type: string
    sql: @{country_region} ;;
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,month
      ,week
      ,year
    ]
  }
  dimension: greater_level_completed {}
  dimension: is_churned {
    type: yesno
    sql: ${greater_level_completed} is null ;;
  }
  dimension: install_version {
    group_label: "Versions"
  }
  dimension: version {
    group_label: "Versions"
    label: "Release Version"
  }
  dimension: event_name {}
  dimension: engagement_ticks {
    type: number
    sql: ${TABLE}.engagement_ticks ;;
  }
  dimension: engagement_minutes {
    type: number
    sql: ${TABLE}.engagement_ticks / 2 ;;
  }
  dimension: currency_02_balance {
    group_label: "Currencies"
    label: "Gems"
    type: number
  }
  dimension: currency_03_balance {
    group_label: "Currencies"
    label: "Coins"
    type: number
  }
  dimension: currency_04_balance {
    group_label: "Currencies"
    label: "Lives"
    type: number
  }
  dimension:  currency_04_balance_tiers {
    group_label: "Currencies"
    label: "Lives Tiers"
    tiers: [0,1,2,3,4,5]
    style: integer
    sql: ${currency_04_balance} ;;
  }
  dimension: currency_05_balance {
    group_label: "Currencies"
    label: "AFH Tokens"
    type: number
  }
  measure: engagement_minutes_med {
    label: "Engagement Minutes - Median"
    type: median
    sql:  ${engagement_minutes};;
  }
  dimension: last_level_id {
    label: "Last Level - Id"
  }
  dimension: last_level_serial {
    label: "Last Level"
    type: number
    sql: ${TABLE}.last_level_serial ;;
  }
  dimension: extra_json {
    hidden: yes
  }
  dimension: button_tag_raw {
    sql: ${TABLE}.button_tag ;;
  }
  dimension: button_tag {
    sql: @{button_tags} ;;
  }
  parameter: player_button_tag_filter {
    label: "Player Count Button Tag Filter"
    suggest_dimension: button_tag
  }
  measure: player_count {
    label: "Player Count"
    type: count_distinct
    sql: ${rdg_id};;
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  measure: filtered_player_count {
    label: "Player Count (Filtered)"
    type: count_distinct
    sql:
        case
          when
            {% condition player_button_tag_filter %} ${button_tag} {% endcondition %}
          then ${rdg_id}
        end
      ;;
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  measure: button_clicks {
    label: "Click Count"
    type: count
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  measure: filtered_click_count {
    label: "Click Count (Filtered)"
    type: count_distinct
    sql:
        case
          when
            {% condition player_button_tag_filter %} ${button_tag} {% endcondition %}
          then ${primary_key}
        end
      ;;
    drill_fields: [rdg_id,event_time,button_tag,button_tag_raw]
  }
  dimension: experiments {
    type: string
    sql: ${TABLE}.experiments ;;
    hidden: no
  }
  parameter: experiment_id {
    type: string
    suggestions:  ["$.altFUE2_20221011"
      ,"$.altFUE2v2_20221024"
      ,"$.autoPurchase_20221017"
      ,"$.blockSymbols_20221017"
      ,"$.collection_01192023"
      ,"$.difficultyStars_09202022"
      ,"$.dynamicRewards_20221018"
      ,"$.extraMovesCurrency_20221017"
      ,"$.fueDismiss_20221010"
      ,"$.gridGravity_20221003"
      ,"$.gridGravity2_20221012"
      ,"$.livesTimer_01092023"
      ,"$.mMStreaks_09302022"
      ,"$.newLevelPass_20220926"
      ,"$.vfxReduce_20221017"
      ,"$.vfxReduce_2_20221024"
      ,"$.zoneOrder2_09302022"
      ,"$.zoneStarCosts_09222022"]
  }
  dimension: experiment_variant {
    label: "Experiment Variant"
    type: string
    suggestions: ["control"
      ,"variant_a"
      ,"variant_b"
      ,"variant_c"
      ,"variant_d"]
    # sql: json_extract_scalar(${experiments},{% parameter experiment_id %}) ;;
    sql: json_extract_scalar(${experiments},"$.altFUE2v2_20221024") ;;
  }
}
