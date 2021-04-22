view: user_card {
  derived_table: {
    sql:
      select
        rdg_id
        ,card_id
        ,min(card_start_time) card_start_time
        ,max(card_end_time) card_end_time
        ,max(session) total_sessions
        ,max(round) total_rounds
        ,max(node_end_tick) time_spent
        ,max(case when node_id = 1 and node_end_tick is not null then node_round end) node_1_completed_round
        ,max(case when node_id = 1 then node_end_tick end) node_1_end_tick
        ,max(case when node_id = 1 then node_attempts_explicit end) node_1_explicit
        ,max(case when node_id = 1 then node_attempts_passive end) node_1_passive
        ,max(case when node_id = 2 and node_end_tick is not null then node_round end) node_2_completed_round
        ,max(case when node_id = 2 then node_end_tick end) node_2_end_tick
        ,max(case when node_id = 2 then node_attempts_explicit end) node_2_explicit
        ,max(case when node_id = 2 then node_attempts_passive end) node_2_passive
        ,max(case when node_id = 3 and node_end_tick is not null then node_round end) node_3_completed_round
        ,max(case when node_id = 3 then node_end_tick end) node_3_end_tick
        ,max(case when node_id = 3 then node_attempts_explicit end) node_3_explicit
        ,max(case when node_id = 3 then node_attempts_passive end) node_3_passive
        ,max(case when node_id = 4 and node_end_tick is not null then node_round end) node_4_completed_round
        ,max(case when node_id = 4 then node_end_tick end) node_4_end_tick
        ,max(case when node_id = 4 then node_attempts_explicit end) node_4_explicit
        ,max(case when node_id = 4 then node_attempts_passive end) node_4_passive
        ,max(case when node_id = 5 and node_end_tick is not null then node_round end) node_5_completed_round
        ,max(case when node_id = 5 then node_end_tick end) node_5_end_tick
        ,max(case when node_id = 5 then node_attempts_explicit end) node_5_explicit
        ,max(case when node_id = 5 then node_attempts_passive end) node_5_passive
        ,max(case when node_id = 6 and node_end_tick is not null then node_round end) node_6_completed_round
        ,max(case when node_id = 6 then node_end_tick end) node_6_end_tick
        ,max(case when node_id = 6 then node_attempts_explicit end) node_6_explicit
        ,max(case when node_id = 6 then node_attempts_passive end) node_6_passive
        ,max(case when node_id = 7 and node_end_tick is not null then node_round end) node_7_completed_round
        ,max(case when node_id = 7 then node_end_tick end) node_7_end_tick
        ,max(case when node_id = 7 then node_attempts_explicit end) node_7_explicit
        ,max(case when node_id = 7 then node_attempts_passive end) node_7_passive
        ,max(case when node_id = 8 and node_end_tick is not null then node_round end) node_8_completed_round
        ,max(case when node_id = 8 then node_end_tick end) node_8_end_tick
        ,max(case when node_id = 8 then node_attempts_explicit end) node_8_explicit
        ,max(case when node_id = 8 then node_attempts_passive end) node_8_passive
        ,max(case when node_id = 9 and node_end_tick is not null then node_round end) node_9_completed_round
        ,max(case when node_id = 9 then node_end_tick end) node_9_end_tick
        ,max(case when node_id = 9 then node_attempts_explicit end) node_9_explicit
        ,max(case when node_id = 9 then node_attempts_passive end) node_9_passive
        ,max(case when node_id = 10 and node_end_tick is not null then node_round end) node_10_completed_round
        ,max(case when node_id = 10 then node_end_tick end) node_10_end_tick
        ,max(case when node_id = 10 then node_attempts_explicit end) node_10_explicit
        ,max(case when node_id = 10 then node_attempts_passive end) node_10_passive
        ,max(case when node_id = 11 and node_end_tick is not null then node_round end) node_11_completed_round
        ,max(case when node_id = 11 then node_end_tick end) node_11_end_tick
        ,max(case when node_id = 11 then node_attempts_explicit end) node_11_explicit
        ,max(case when node_id = 11 then node_attempts_passive end) node_11_passive
        ,max(case when node_id = 12 and node_end_tick is not null then node_round end) node_12_completed_round
        ,max(case when node_id = 12 then node_end_tick end) node_12_end_tick
        ,max(case when node_id = 12 then node_attempts_explicit end) node_12_explicit
        ,max(case when node_id = 12 then node_attempts_passive end) node_12_passive
        ,max(case when node_id = 13 and node_end_tick is not null then node_round end) node_13_completed_round
        ,max(case when node_id = 13 then node_end_tick end) node_13_end_tick
        ,max(case when node_id = 13 then node_attempts_explicit end) node_13_explicit
        ,max(case when node_id = 13 then node_attempts_passive end) node_13_passive
        ,max(case when node_id = 14 and node_end_tick is not null then node_round end) node_14_completed_round
        ,max(case when node_id = 14 then node_end_tick end) node_14_end_tick
        ,max(case when node_id = 14 then node_attempts_explicit end) node_14_explicit
        ,max(case when node_id = 14 then node_attempts_passive end) node_14_passive
        ,max(case when node_id = 15 and node_end_tick is not null then node_round end) node_15_completed_round
        ,max(case when node_id = 15 then node_end_tick end) node_15_end_tick
        ,max(case when node_id = 15 then node_attempts_explicit end) node_15_explicit
        ,max(case when node_id = 15 then node_attempts_passive end) node_15_passive
        ,max(case when node_id = 16 and node_end_tick is not null then node_round end) node_16_completed_round
        ,max(case when node_id = 16 then node_end_tick end) node_16_end_tick
        ,max(case when node_id = 16 then node_attempts_explicit end) node_16_explicit
        ,max(case when node_id = 16 then node_attempts_passive end) node_16_passive
        ,max(case when node_id = 17 and node_end_tick is not null then node_round end) node_17_completed_round
        ,max(case when node_id = 17 then node_end_tick end) node_17_end_tick
        ,max(case when node_id = 17 then node_attempts_explicit end) node_17_explicit
        ,max(case when node_id = 17 then node_attempts_passive end) node_17_passive
        ,max(case when node_id = 18 and node_end_tick is not null then node_round end) node_18_completed_round
        ,max(case when node_id = 18 then node_end_tick end) node_18_end_tick
        ,max(case when node_id = 18 then node_attempts_explicit end) node_18_explicit
        ,max(case when node_id = 18 then node_attempts_passive end) node_18_passive
        ,max(case when node_id = 19 and node_end_tick is not null then node_round end) node_19_completed_round
        ,max(case when node_id = 19 then node_end_tick end) node_19_end_tick
        ,max(case when node_id = 19 then node_attempts_explicit end) node_19_explicit
        ,max(case when node_id = 19 then node_attempts_passive end) node_19_passive
        ,max(case when node_id = 20 and node_end_tick is not null then node_round end) node_20_completed_round
        ,max(case when node_id = 20 then node_end_tick end) node_20_end_tick
        ,max(case when node_id = 20 then node_attempts_explicit end) node_20_explicit
        ,max(case when node_id = 20 then node_attempts_passive end) node_20_passive
        ,max(case when node_id = 21 and node_end_tick is not null then node_round end) node_21_completed_round
        ,max(case when node_id = 21 then node_end_tick end) node_21_end_tick
        ,max(case when node_id = 21 then node_attempts_explicit end) node_21_explicit
        ,max(case when node_id = 21 then node_attempts_passive end) node_21_passive
        ,max(case when node_id = 22 and node_end_tick is not null then node_round end) node_22_completed_round
        ,max(case when node_id = 22 then node_end_tick end) node_22_end_tick
        ,max(case when node_id = 22 then node_attempts_explicit end) node_22_explicit
        ,max(case when node_id = 22 then node_attempts_passive end) node_22_passive
        ,max(case when node_id = 23 and node_end_tick is not null then node_round end) node_23_completed_round
        ,max(case when node_id = 23 then node_end_tick end) node_23_end_tick
        ,max(case when node_id = 23 then node_attempts_explicit end) node_23_explicit
        ,max(case when node_id = 23 then node_attempts_passive end) node_23_passive
        ,max(case when node_id = 24 and node_end_tick is not null then node_round end) node_24_completed_round
        ,max(case when node_id = 24 then node_end_tick end) node_24_end_tick
        ,max(case when node_id = 24 then node_attempts_explicit end) node_24_explicit
        ,max(case when node_id = 24 then node_attempts_passive end) node_24_passive
      from (
        select
          rdg_id
          ,json_extract_scalar(extra_json,'$.card_id') card_id
          ,timestamp_millis(cast(json_extract_scalar(extra_json,'$.card_start_time') as int64)) card_start_time
          ,timestamp_millis(cast(json_extract_scalar(extra_json,'$.card_end_time') as int64)) card_end_time
          ,cast(json_extract_scalar(extra_json,'$.rounds') as int64) round
          ,cast(json_extract_scalar(extra_json,'$.sessions') as int64) session
          ,cast(json_extract_scalar(node_data,'$.node_id') as int64) node_id
          ,cast(json_extract_scalar(node_data,'$.node_end_tick') as int64) node_end_tick
          ,cast(json_extract_scalar(node_data,'$.rounds') as int64) node_round
          ,cast(json_extract_scalar(node_data,'$.node_attempts_explicit') as int64) node_attempts_explicit
          ,cast(json_extract_scalar(node_data,'$.node_attempts_passive') as int64) node_attempts_passive
        from game_data.events
        left join unnest(json_extract_array(extra_json,'$.node_data')) node_data
        where event_name = 'cards'
          and user_type = 'external'
          -- and timestamp >= timestamp(current_date() - 30)
          -- and timestamp < timestamp(current_date())
          -- and rdg_id = 'de47b3ed-6b5a-4824-b19a-53b2ea2bc453'
          -- and json_extract_scalar(extra_json,'$.card_id') = 'card_003'
      ) x
      group by 1,2
    ;;
    datagroup_trigger: change_at_midnight
    # indexes: ["card_id"]
  }
  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: ${rdg_id} || ${card_id} ;;
  }
  dimension: rdg_id {}
  dimension: card_id {}
  dimension: card_start_time {}
  dimension: card_end_time {}
  dimension: is_complete {
    type: yesno
    sql: ${card_end_time} is not null ;;
  }
  dimension: total_sessions {}
  dimension: total_rounds {}
  dimension: time_spent {
    description: "Total time spent in minutes"
    type: number
    sql: ${TABLE}.time_spent * .5 ;;
    value_format_name: decimal_1
  }
  dimension: node_1_completed_round {
    group_label: " Node 1"
  }
  dimension: node_1_time_to_complete {
    group_label: " Node 1"
    description: "Time to complete Node 1 in minutes"
    type: number
    sql: ${TABLE}.node_1_end_tick * .5 ;;
  }
  dimension: node_1_explicit {
    group_label: " Node 1"
    type: number
  }
  dimension: node_1_passive {
    group_label: " Node 1"
    type: number
  }
  dimension: node_1_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_1_explicit} + ${node_1_passive} ;;
  }
  dimension: node_2_completed_round {
    group_label: " Node 2"
  }
  dimension: node_2_time_to_complete {
    group_label: " Node 2"
    description: "Time to complete Node 2 in minutes"
    type: number
    sql: ${TABLE}.node_2_end_tick * .5 ;;
  }
  dimension: node_2_explicit {
    group_label: " Node 2"
    type: number
  }
  dimension: node_2_passive {
    group_label: " Node 2"
    type: number
  }
  dimension: node_2_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_2_explicit} + ${node_2_passive} ;;
  }
  dimension: node_3_completed_round {
    group_label: " Node 3"
  }
  dimension: node_3_time_to_complete {
    group_label: " Node 3"
    description: "Time to complete Node 3 in minutes"
    type: number
    sql: ${TABLE}.node_3_end_tick * .5 ;;
  }
  dimension: node_3_explicit {
    group_label: " Node 3"
    type: number
  }
  dimension: node_3_passive {
    group_label: " Node 3"
    type: number
  }
  dimension: node_3_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_3_explicit} + ${node_3_passive} ;;
  }
  dimension: node_4_completed_round {
    group_label: " Node 4"
  }
  dimension: node_4_time_to_complete {
    group_label: " Node 4"
    description: "Time to complete Node 4 in minutes"
    type: number
    sql: ${TABLE}.node_4_end_tick * .5 ;;
  }
  dimension: node_4_explicit {
    group_label: " Node 4"
    type: number
  }
  dimension: node_4_passive {
    group_label: " Node 4"
    type: number
  }
  dimension: node_4_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_4_explicit} + ${node_4_passive} ;;
  }
  dimension: node_5_completed_round {
    group_label: " Node 5"
  }
  dimension: node_5_time_to_complete {
    group_label: " Node 5"
    description: "Time to complete Node 5 in minutes"
    type: number
    sql: ${TABLE}.node_5_end_tick * .5 ;;
  }
  dimension: node_5_explicit {
    group_label: " Node 5"
    type: number
  }
  dimension: node_5_passive {
    group_label: " Node 5"
    type: number
  }
  dimension: node_5_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_5_explicit} + ${node_5_passive} ;;
  }
  dimension: node_6_completed_round {
    group_label: " Node 6"
  }
  dimension: node_6_time_to_complete {
    group_label: " Node 6"
    description: "Time to complete Node 6 in minutes"
    type: number
    sql: ${TABLE}.node_6_end_tick * .5 ;;
  }
  dimension: node_6_explicit {
    group_label: " Node 6"
    type: number
  }
  dimension: node_6_passive {
    group_label: " Node 6"
    type: number
  }
  dimension: node_6_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_6_explicit} + ${node_6_passive} ;;
  }
  dimension: node_7_completed_round {
    group_label: " Node 7"
  }
  dimension: node_7_time_to_complete {
    group_label: " Node 7"
    description: "Time to complete Node 7 in minutes"
    type: number
    sql: ${TABLE}.node_7_end_tick * .5 ;;
  }
  dimension: node_7_explicit {
    group_label: " Node 7"
    type: number
  }
  dimension: node_7_passive {
    group_label: " Node 7"
    type: number
  }
  dimension: node_7_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_7_explicit} + ${node_7_passive} ;;
  }
  dimension: node_8_completed_round {
    group_label: " Node 8"
  }
  dimension: node_8_time_to_complete {
    group_label: " Node 8"
    description: "Time to complete Node 8 in minutes"
    type: number
    sql: ${TABLE}.node_8_end_tick * .5 ;;
  }
  dimension: node_8_explicit {
    group_label: " Node 8"
    type: number
  }
  dimension: node_8_passive {
    group_label: " Node 8"
    type: number
  }
  dimension: node_8_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_8_explicit} + ${node_8_passive} ;;
  }
  dimension: node_9_completed_round {
    group_label: " Node 9"
  }
  dimension: node_9_time_to_complete {
    group_label: " Node 9"
    description: "Time to complete Node 9 in minutes"
    type: number
    sql: ${TABLE}.node_9_end_tick * .5 ;;
  }
  dimension: node_9_explicit {
    group_label: " Node 9"
    type: number
  }
  dimension: node_9_passive {
    group_label: " Node 9"
    type: number
  }
  dimension: node_9_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_9_explicit} + ${node_9_passive} ;;
  }
  dimension: node_10_completed_round {
    group_label: " Node 10"
  }
  dimension: node_10_time_to_complete {
    group_label: " Node 10"
    description: "Time to complete Node 10 in minutes"
    type: number
    sql: ${TABLE}.node_10_end_tick * .5 ;;
  }
  dimension: node_10_explicit {
    group_label: " Node 10"
    type: number
  }
  dimension: node_10_passive {
    group_label: " Node 10"
    type: number
  }
  dimension: node_10_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_10_explicit} + ${node_10_passive} ;;
  }
  dimension: node_11_completed_round {
    group_label: "Node 11"
  }
  dimension: node_11_time_to_complete {
    group_label: " Node 11"
    description: "Time to complete Node 11 in minutes"
    type: number
    sql: ${TABLE}.node_11_end_tick * .5 ;;
  }
  dimension: node_11_explicit {
    group_label: " Node 11"
    type: number
  }
  dimension: node_11_passive {
    group_label: " Node 11"
    type: number
  }
  dimension: node_11_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_11_explicit} + ${node_11_passive} ;;
  }
  dimension: node_12_completed_round {
    group_label: " Node 12"
  }
  dimension: node_12_time_to_complete {
    group_label: " Node 12"
    description: "Time to complete Node 12 in minutes"
    type: number
    sql: ${TABLE}.node_12_end_tick * .5 ;;
  }
  dimension: node_12_explicit {
    group_label: " Node 12"
    type: number
  }
  dimension: node_12_passive {
    group_label: " Node 12"
    type: number
  }
  dimension: node_12_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_12_explicit} + ${node_12_passive} ;;
  }
  dimension: node_13_completed_round {
    group_label: " Node 13"
  }
  dimension: node_13_time_to_complete {
    group_label: " Node 13"
    description: "Time to complete Node 13 in minutes"
    type: number
    sql: ${TABLE}.node_13_end_tick * .5 ;;
  }
  dimension: node_13_explicit {
    group_label: " Node 13"
    type: number
  }
  dimension: node_13_passive {
    group_label: " Node 13"
    type: number
  }
  dimension: node_13_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_13_explicit} + ${node_13_passive} ;;
  }
  dimension: node_14_completed_round {
    group_label: "Node 14"
  }
  dimension: node_14_time_to_complete {
    group_label: "Node 14"
    description: "Time to complete Node 14 in minutes"
    type: number
    sql: ${TABLE}.node_14_end_tick * .5 ;;
  }
  dimension: node_14_explicit {
    group_label: "Node 14"
    type: number
  }
  dimension: node_14_passive {
    group_label: "Node 14"
    type: number
  }
  dimension: node_14_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_14_explicit} + ${node_14_passive} ;;
  }
  dimension: node_15_completed_round {
    group_label: "Node 15"
  }
  dimension: node_15_time_to_complete {
    group_label: "Node 15"
    description: "Time to complete Node 15 in minutes"
    type: number
    sql: ${TABLE}.node_15_end_tick * .5 ;;
  }
  dimension: node_15_explicit {
    group_label: "Node 15"
    type: number
  }
  dimension: node_15_passive {
    group_label: "Node 15"
    type: number
  }
  dimension: node_15_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_15_explicit} + ${node_15_passive} ;;
  }
  dimension: node_16_completed_round {
    group_label: "Node 16"
  }
  dimension: node_16_time_to_complete {
    group_label: "Node 16"
    description: "Time to complete Node 16 in minutes"
    type: number
    sql: ${TABLE}.node_16_end_tick * .5 ;;
  }
  dimension: node_16_explicit {
    group_label: "Node 16"
    type: number
  }
  dimension: node_16_passive {
    group_label: "Node 16"
    type: number
  }
  dimension: node_16_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_16_explicit} + ${node_16_passive} ;;
  }
  dimension: node_17_completed_round {
    group_label: "Node 17"
  }
  dimension: node_17_time_to_complete {
    group_label: "Node 17"
    description: "Time to complete Node 17 in minutes"
    type: number
    sql: ${TABLE}.node_17_end_tick * .5 ;;
  }
  dimension: node_17_explicit {
    group_label: "Node 17"
    type: number
  }
  dimension: node_17_passive {
    group_label: "Node 17"
    type: number
  }
  dimension: node_17_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_17_explicit} + ${node_17_passive} ;;
  }
  dimension: node_18_completed_round {
    group_label: "Node 18"
  }
  dimension: node_18_time_to_complete {
    group_label: "Node 18"
    description: "Time to complete Node 18 in minutes"
    type: number
    sql: ${TABLE}.node_18_end_tick * .5 ;;
  }
  dimension: node_18_explicit {
    group_label: "Node 18"
    type: number
  }
  dimension: node_18_passive {
    group_label: "Node 18"
    type: number
  }
  dimension: node_18_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_18_explicit} + ${node_18_passive} ;;
  }
  dimension: node_19_completed_round {
    group_label: "Node 19"
  }
  dimension: node_19_time_to_complete {
    group_label: "Node 19"
    description: "Time to complete Node 19 in minutes"
    type: number
    sql: ${TABLE}.node_19_end_tick * .5 ;;
  }
  dimension: node_19_explicit {
    group_label: "Node 19"
    type: number
  }
  dimension: node_19_passive {
    group_label: "Node 19"
    type: number
  }
  dimension: node_19_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_19_explicit} + ${node_19_passive} ;;
  }
  dimension: node_20_completed_round {
    group_label: "Node 20"
  }
  dimension: node_20_time_to_complete {
    group_label: "Node 20"
    description: "Time to complete Node 20 in minutes"
    type: number
    sql: ${TABLE}.node_20_end_tick * .5 ;;
  }
  dimension: node_20_explicit {
    group_label: "Node 20"
    type: number
  }
  dimension: node_20_passive {
    group_label: "Node 20"
    type: number
  }
  dimension: node_20_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_20_explicit} + ${node_20_passive} ;;
  }
  dimension: node_21_completed_round {
    group_label: "Node 21"
  }
  dimension: node_21_time_to_complete {
    group_label: "Node 21"
    description: "Time to complete Node 21 in minutes"
    type: number
    sql: ${TABLE}.node_21_end_tick * .5 ;;
  }
  dimension: node_21_explicit {
    group_label: "Node 21"
    type: number
  }
  dimension: node_21_passive {
    group_label: "Node 21"
    type: number
  }
  dimension: node_21_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_21_explicit} + ${node_21_passive} ;;
  }
  dimension: node_22_completed_round {
    group_label: "Node 22"
  }
  dimension: node_22_time_to_complete {
    group_label: "Node 22"
    description: "Time to complete Node 22 in minutes"
    type: number
    sql: ${TABLE}.node_22_end_tick * .5 ;;
  }
  dimension: node_22_explicit {
    group_label: "Node 22"
    type: number
  }
  dimension: node_22_passive {
    group_label: "Node 22"
    type: number
  }
  dimension: node_22_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_22_explicit} + ${node_22_passive} ;;
  }
  dimension: node_23_completed_round {
    group_label: "Node 23"
  }
  dimension: node_23_time_to_complete {
    group_label: "Node 23"
    description: "Time to complete Node 23 in minutes"
    type: number
    sql: ${TABLE}.node_23_end_tick * .5 ;;
  }
  dimension: node_23_explicit {
    group_label: "Node 23"
    type: number
  }
  dimension: node_23_passive {
    group_label: "Node 23"
    type: number
  }
  dimension: node_23_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_23_explicit} + ${node_23_passive} ;;
  }
  dimension: node_24_completed_round {
    group_label: "Node 24"
  }
  dimension: node_24_time_to_complete {
    group_label: "Node 24"
    description: "Time to complete Node 24 in minutes"
    type: number
    sql: ${TABLE}.node_24_end_tick * .5 ;;
  }
  dimension: node_24_explicit {
    group_label: "Node 24"
    type: number
  }
  dimension: node_24_passive {
    group_label: "Node 24"
    type: number
  }
  dimension: node_24_progress_attempts {
    hidden: yes
    type: number
    sql: ${node_24_explicit} + ${node_24_passive} ;;
  }
  measure: attempted_count {
    type: count
  }
  measure: completed_count {
    type: count
    filters: [
      is_complete: "yes"
    ]
  }
  measure: average_time_to_complete {
    type: average
    sql: ${time_spent} ;;
    filters: [
      is_complete: "yes"
    ]
    value_format_name: decimal_1
  }
  measure: average_sessions_to_complete {
    type: average
    sql: ${total_sessions} ;;
    filters: [
      is_complete: "yes"
    ]
    value_format_name: decimal_1
  }
  measure: average_rounds_to_complete {
    type: average
    sql: ${total_rounds} ;;
    filters: [
      is_complete: "yes"
    ]
  }
  measure: rounds_to_complete_025 {
    group_label: "Rounds to Complete Card"
    label: "Rounds to Complete Card - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${total_rounds} ;;
    filters: [
      is_complete: "yes"
    ]
  }
  measure: rounds_to_complete_25 {
    group_label: "Rounds to Complete Card"
    label: "Rounds to Complete Card - 25%"
    type: percentile
    percentile: 25
    sql: ${total_rounds} ;;
    filters: [
      is_complete: "yes"
    ]
  }
  measure: rounds_to_complete_med {
    group_label: "Rounds to Complete Card"
    label: "Rounds to Complete Card - Median"
    type: median
    sql: ${total_rounds} ;;
    filters: [
      is_complete: "yes"
    ]
  }
  measure: rounds_to_complete_75 {
    group_label: "Rounds to Complete Card"
    label: "Rounds to Complete Card - 75%"
    type: percentile
    percentile: 75
    sql: ${total_rounds} ;;
    filters: [
      is_complete: "yes"
    ]
  }
  measure: rounds_to_complete_975 {
    group_label: "Rounds to Complete Card"
    label: "Rounds to Complete Card - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${total_rounds} ;;
    filters: [
      is_complete: "yes"
    ]
  }
  measure: average_node_1_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_1_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_2_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_2_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_3_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_3_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_4_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_4_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_5_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_5_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_6_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_6_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_7_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_7_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_8_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_8_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_9_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_9_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_10_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_10_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_11_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_11_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_12_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_12_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_13_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_13_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_14_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_14_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_15_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_15_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_16_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_16_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_17_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_17_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_18_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_18_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_19_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_19_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_20_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_20_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_21_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_21_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_22_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_22_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_23_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_23_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_24_completion_time {
    group_label: "Completion Time Averages"
    type: average
    sql: ${node_24_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_1_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_1_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_2_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_2_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_3_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_3_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_4_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_4_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_5_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_5_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_6_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_6_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_7_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_7_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_8_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_8_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_9_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_9_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_10_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_10_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_11_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_11_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_12_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_12_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_13_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_13_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_14_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_14_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_15_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_15_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_16_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_16_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_17_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_17_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_18_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_18_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_19_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_19_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_20_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_20_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_21_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_21_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_22_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_22_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_23_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_23_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_24_completion_round {
    group_label: "Completion Round Averages"
    type: average
    sql: ${node_24_time_to_complete} ;;
    value_format_name: decimal_1
  }
  measure: average_node_1_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_1_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_2_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_2_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_3_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_3_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_4_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_4_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_5_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_5_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_6_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_6_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_7_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_7_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_8_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_8_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_9_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_9_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_10_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_10_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_11_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_11_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_12_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_12_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_13_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_13_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_14_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_14_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_15_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_15_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_16_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_16_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_17_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_17_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_18_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_18_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_19_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_19_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_20_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_20_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_21_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_21_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_22_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_22_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_23_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_23_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: average_node_24_progress_count {
    group_label: "Node Progress Count Averages"
    type: average
    sql: ${node_24_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_1_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 1"
    type: median
    sql: ${node_1_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_2_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 2"
    type: median
    sql: ${node_2_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_3_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 3"
    type: median
    sql: ${node_3_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_4_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 4"
    type: median
    sql: ${node_4_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_5_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 5"
    type: median
    sql: ${node_5_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_6_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 6"
    type: median
    sql: ${node_6_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_7_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 7"
    type: median
    sql: ${node_7_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_8_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 8"
    type: median
    sql: ${node_8_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_9_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 9"
    type: median
    sql: ${node_9_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_10_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 10"
    type: median
    sql: ${node_10_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_11_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 11"
    type: median
    sql: ${node_11_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_12_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 12"
    type: median
    sql: ${node_12_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_13_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 13"
    type: median
    sql: ${node_13_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_14_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 4"
    type: median
    sql: ${node_14_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_15_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 15"
    type: median
    sql: ${node_15_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_16_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 16"
    type: median
    sql: ${node_16_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_17_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 17"
    type: median
    sql: ${node_17_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_18_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 18"
    type: median
    sql: ${node_18_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_19_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 19"
    type: median
    sql: ${node_19_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_20_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 20"
    type: median
    sql: ${node_20_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_21_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 21"
    type: median
    sql: ${node_21_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_22_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 22"
    type: median
    sql: ${node_22_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_23_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 23"
    type: median
    sql: ${node_23_progress_attempts} ;;
    value_format_name: decimal_1
  }
  measure: median_node_24_progress_count {
    group_label: "Tile Progress Count - Median"
    label: "Tile 24"
    type: median
    sql: ${node_24_progress_attempts} ;;
    value_format_name: decimal_1
  }
}
