view: round_end {
# this table builds the fact table for the round end events - this is at the user and round grain
  derived_table: {
    sql:
      select distinct
        rdg_id
        ,timestamp
        ,engagement_ticks
        ,session_id
        ,last_level_id
        ,json_extract_scalar(extra_json,"$.level_id") level_id
        ,cast(last_level_serial as int64) last_level_serial
        ,cast(json_extract_scalar(extra_json,'$.round_id') as int64) round_id
        ,cast(json_extract_scalar(extra_json,"$.rounds") as int64) rounds
        ,cast(json_extract_scalar(extra_json,'$.quest_complete') as boolean) quest_complete
        ,json_extract_scalar(extra_json,'$.game_mode') game_mode
        ,json_extract_scalar(extra_json,'$.team_slot_0') primary_team_slot
        ,json_extract_scalar(extra_json,'$.team_slot_skill_0') primary_team_slot_skill
        ,cast(json_extract_scalar(extra_json,'$.team_slot_level_0') as int64) primary_team_slot_level
        ,cast(json_extract_scalar(extra_json,'$.moves') as int64) moves
        ,cast(json_extract_scalar(extra_json,'$.moves_added') as boolean) moves_added
        ,cast(json_extract_scalar(extra_json,'$.moves_remaining') as int64) moves_remaining
        ,cast(json_extract_scalar(extra_json,'$.coins_earned') as int64) coins_earned
        ,cast(json_extract_scalar(extra_json,'$.round_length') as int64) round_length
        ,cast(replace(json_extract_scalar(extra_json,'$.proximity_to_completion'),',','') as float64) proximity_to_completion
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_02") as numeric) currency_02_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric) currency_03_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric) currency_04_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_05") as numeric) currency_05_balance
        ,cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric) currency_07_balance
        --,cast(json_extract_scalar(extra_json,'$.rocket_boost') as int64) rocket_boost
        --,cast(json_extract_scalar(extra_json,'$.bomb_boost') as int64) bomb_boost
        --,cast(json_extract_scalar(extra_json,'$.color_ball_boost') as int64) color_ball_boost
        --,cast(json_extract_scalar(extra_json,'$.propeller_boost') as int64) propeller_boost
        --,cast(json_extract_scalar(extra_json,'$.powerup_rocket_vertical') as int64) powerup_rocket_vertical
        --,cast(json_extract_scalar(extra_json,'$.powerup_rocket_horizontal') as int64) powerup_rocket_horizontal
        --,cast(json_extract_scalar(extra_json,'$.powerup_color_ball') as int64) powerup_color_ball
        --,cast(json_extract_scalar(extra_json,'$.powerup_bomb') as int64) powerup_bomb
        --,cast(json_extract_scalar(extra_json,'$.powerup_propeller') as int64) powerup_propeller
        --,cast(json_extract_scalar(extra_json,'$.powerup_combo_color_ball_propeller') as int64) powerup_combo_color_ball_propeller
        --,cast(json_extract_scalar(extra_json,'$.powerup_combo_color_ball_bomb') as int64) powerup_combo_color_ball_bomb
        --,cast(json_extract_scalar(extra_json,'$.powerup_combo_color_ball_rocket') as int64) powerup_combo_color_ball_rocket
        --,cast(json_extract_scalar(extra_json,'$.powerup_combo_propeller_bomb') as int64) powerup_combo_propeller_bomb
        --,cast(json_extract_scalar(extra_json,'$.powerup_combo_propeller_rocket') as int64) powerup_combo_propeller_rocket
        --,cast(json_extract_scalar(extra_json,'$.powerup_combo_bomb_rocket') as int64) powerup_combo_bomb_rocket
        --,cast(json_extract_scalar(extra_json,'$.powerup_combo_color_ball') as int64) powerup_combo_color_ball
        --,cast(json_extract_scalar(extra_json,'$.powerup_piping_bag') as int64) powerup_piping_bag
        --,cast(json_extract_scalar(extra_json,'$.powerup_rolling_pin') as int64) powerup_rolling_pin
        --,cast(json_extract_scalar(extra_json,'$.powerup_hammer') as int64) powerup_hammer
    from game_data.events
    where event_name = 'round_end'
      and date(timestamp) between '2022-06-01' and current_date()
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
    ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
  }

  dimension: primary_key {
    type: string
    sql: ${rdg_id} || '_' || ${round_id} || '_' || ${event_time} ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
    # hidden: yes
  }
  measure: player_count {
    type: count_distinct
    sql: ${rdg_id} ;;
  }
  dimension_group: event {
    type: time
    sql: ${TABLE}.timestamp ;;
    timeframes: [
      raw
      ,time
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]
  }
  dimension: days_since_created {
    label: "Days Since Created"
    type: number
    sql: date_diff(${event_date},${user_fact.created_date},day) ;;
  }
  # dimension: retention_days_cohort {
  #   label: "Days Since Created"
  #   type: string
  #   sql: 'D' || cast((${days_since_created} + 1) as string) ;;
  #   order_by_field: days_since_created
  # }
  dimension: engagement_ticks {
    hidden: yes
  }
  dimension: engagement_min {
    group_label: "Minutes Played"
    label: "Minutes Played"
    type: number
    sql: ${TABLE}.engagement_ticks / 2 ;;
  }
  dimension: engagement_min_cohort {
    group_label: "Minutes Played"
    label: "Minutes Played Cohort"
    type: string
    sql: 'MP' || cast((${engagement_min}) as string) ;;
    order_by_field: engagement_min
  }
  dimension: engagement_2_min_interval {
    group_label: "Minutes Played"
    label: "Minutes Played - 2 Min Tiers"
    type: tier
    tiers: [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60]
    style: integer
    sql: ${engagement_min} ;;
  }
  dimension: engagement_min_interval {
    group_label: "Minutes Played"
    label: "Minutes Played - 5 Min Tiers"
    type: tier
    tiers: [0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120]
    style: integer
    sql: ${engagement_min} ;;
  }
  dimension: engagement_15_min_interval {
    group_label: "Minutes Played"
    label: "Minutes Played - 15 Min Tiers"
    type: tier
    tiers: [0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,225,240,255,270,285,300,315,330,345,360]
    style: integer
    sql: ${engagement_min} ;;
  }
  dimension: engagement_30_min_interval {
    group_label: "Minutes Played"
    label: "Minutes Played - 30 Min Tiers"
    type: tier
    tiers: [0,30,60,90,120,150,180,210,240,270,300,330,360,390,420,450,480,510,540,570,600]
    style: integer
    sql: ${engagement_min} ;;
  }
  measure: engagement_min_025 {
    group_label: "Minutes Played"
    label: "Minutes Played - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${engagement_min} ;;
  }
  measure: engagement_min_25 {
    group_label: "Minutes Played"
    label: "Minutes Played - 25%"
    type: percentile
    percentile: 25
    sql: ${engagement_min} ;;
  }
  measure: engagement_min_med {
    group_label: "Minutes Played"
    label: "Minutes Played - Median"
    type: median
    sql: ${engagement_min} ;;
  }
  measure: engagement_min_75 {
    group_label: "Minutes Played"
    label: "Minutes Played - 75%"
    type: percentile
    percentile: 75
    sql: ${engagement_min} ;;
  }
  measure: engagement_min_975 {
    group_label: "Minutes Played"
    label: "Minutes Played - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${engagement_min} ;;
  }
  dimension: session_id {}
  dimension: game_mode {
    label: "Game Mode (Unconsolidated)"
  }
  dimension: game_mode_consolidated {
    label: "Game Mode"
    sql: @{game_mode_consolidated} ;;
  }
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
  }
  dimension: level_id {
    group_label: "Level Dimensions"
    label: "Current Level - Id"
    type: string
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
  }
  dimension: last_level_serial_offset {
    group_label: "Level Dimensions"
    label: "Current Level"
    type: number
    sql: ${last_level_serial} + 1 ;;
  }
  measure: last_level_completed {
    group_label: "Level Measures"
    label: "Levels Completed - Max"
    type: max
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_025 {
    group_label: "Level Measures"
    label: "Levels Completed - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_25 {
    group_label: "Level Measures"
    label: "Levels Completed - 25%"
    type: percentile
    percentile: 25
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_med {
    group_label: "Level Measures"
    label: "Levels Completed - Median"
    type: median
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_75 {
    group_label: "Level Measures"
    label: "Levels Completed - 75%"
    type: percentile
    percentile: 75
    sql: ${last_level_serial} ;;
  }
  measure: last_level_completed_975 {
    group_label: "Level Measures"
    label: "Levels Completed - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${last_level_serial} ;;
  }
  dimension: round_id {
    type: number
    sql: ${TABLE}.round_id ;;
  }
  dimension: rounds {
    label: "Attempts"
    type: number
    sql: ${TABLE}.rounds ;;
  }
  measure: round_end_count {
    label: "Rounds Played"
    type: count
  }
  dimension: quest_complete {
    type: yesno
    sql: ${TABLE}.quest_complete ;;
  }
  dimension: primary_team_slot {
    type: string
    sql: ${TABLE}.primary_team_slot ;;
  }
  dimension: primary_team_slot_skill {
    type: string
    sql: ${TABLE}.primary_team_slot_skill ;;
  }
  dimension: primary_team_slot_level {
    type: number
    sql: ${TABLE}.primary_team_slot_level ;;
  }
  dimension: proximity_to_completion {
    group_label: "Proximity to Completion"
    label: "Proximity to Completion"
    type:  number
    sql: ${TABLE}.proximity_to_completion ;;
  }
  dimension: proximity_to_completion_int {
    group_label: "Proximity to Completion"
    label: "Proximity to Completion (Integer)"
    type:  number
    sql: if(${TABLE}.proximity_to_completion <= 1, ${TABLE}.proximity_to_completion * 100, ${TABLE}.proximity_to_completion);;
  }
  dimension: proximity_to_completion_tiers {
    group_label: "Proximity to Completion"
    label: "Proximity to Completion Tiers"
    type: tier
    style: integer
    tiers: [-1,0,1,6,11,16,21,26,31,36,41,46,51,56,61,66,71,76,81,86,91,96,100,101]
    sql: ${proximity_to_completion_int} ;;
  }
  # dimension: requirement_amount {
  #   hidden: yes
  # }
  # dimension: rocket_boost {
  #   group_label: "Boost Impact"
  #   label: "Rocket Boost"
  #   type: number
  # }
  # dimension: rocket_boost_used {
  #   group_label: "Boosts Used"
  #   label: "Rocket Boost"
  #   sql: if(${TABLE}.rocket_boost>0,"yes","no") ;;
  # }
  # dimension: bomb_boost {
  #   group_label: "Boost Impact"
  #   label: "Bomb Boost"
  #   type: number
  # }
  # dimension: bomb_boost_used {
  #   group_label: "Boosts Used"
  #   label: "Bomb Boost"
  #   sql: if(${TABLE}.bomb_boost>0,"yes","no") ;;
  # }
  # dimension: color_ball_boost {
  #   group_label: "Boost Impact"
  #   label: "Color Ball Boost"
  #   type: number
  # }
  # dimension: color_ball_boost_used {
  #   group_label: "Boosts Used"
  #   label: "Color Ball Boost"
  #   sql: if(${TABLE}.color_ball_boost>0,"yes","no") ;;
  # }
  # dimension: propeller_boost {
  #   group_label: "Boost Impact"
  #   label: "Propeller Boost"
  #   type: number
  # }
  # dimension: propeller_boost_used {
  #   group_label: "Boosts Used"
  #   label: "Propeller Boost"
  #   sql: if(${TABLE}.propeller_boost>0,"yes","no") ;;
  # }
  # dimension:  powerup_rocket_vertical {
  #   group_label: "Power Ups"
  #   label: "Vertical Rocket"
  #   type: number
  # }
  # measure:  powerup_rocket_vertical_sum {
  #   group_label: "Power Ups"
  #   label: "Vertical Rocket"
  #   type: sum
  #   sql: ${powerup_rocket_vertical} ;;
  # }
  # dimension:  powerup_rocket_horizontal {
  #   group_label: "Power Ups"
  #   label: "Horizontal Rocket"
  #   type: number
  # }
  # measure:  powerup_rocket_horizontal_sum {
  #   group_label: "Power Ups"
  #   label: "Horizontal Rocket"
  #   type: sum
  #   sql: ${powerup_rocket_horizontal} ;;
  # }
  # dimension: powerup_color_ball {
  #   group_label: "Power Ups"
  #   label: "Color Ball"
  #   type: number
  # }
  # measure:  powerup_color_ball_sum {
  #   group_label: "Power Ups"
  #   label: "Color Ball"
  #   type: sum
  #   sql: ${powerup_color_ball} ;;
  # }
  # dimension:  powerup_bomb {
  #   group_label: "Power Ups"
  #   label: "Bomb"
  #   type: number
  # }
  # measure:  powerup_bomb_sum {
  #   group_label: "Power Ups"
  #   label: "Bomb"
  #   type: sum
  #   sql: ${powerup_bomb} ;;
  # }
  # dimension:  powerup_propeller {
  #   group_label: "Power Ups"
  #   label: "Propeller"
  #   type: number
  # }
  # measure:  powerup_propeller_sum {
  #   group_label: "Power Ups"
  #   label: "Propeller"
  #   type: sum
  #   sql: ${powerup_propeller} ;;
  # }
  # dimension:  powerup_combo_rocket_color_ball {
  #   group_label: "Power Ups"
  #   label: "Combo Rocket + Color Ball"
  #   type: number
  # }
  # measure:  powerup_combo_rocket_color_ball_sum {
  #   group_label: "Power Ups"
  #   label: "Combo Rocket + Color Ball"
  #   type: sum
  #   sql: ${powerup_combo_rocket_color_ball} ;;
  # }
  # dimension:  powerup_combo_rocket_bomb {
  #   group_label: "Power Ups"
  #   label: "Combo Rocket + Bomb"
  #   type: number
  # }
  # measure:  powerup_combo_rocket_bomb_sum {
  #   group_label: "Power Ups"
  #   label: "Combo Rocket + Bomb"
  #   type: sum
  #   sql: ${powerup_combo_rocket_bomb} ;;
  # }
  # dimension:  powerup_combo_rocket_propeller {
  #   group_label: "Power Ups"
  #   label: "Combo Rocket + Propeller"
  #   type: number
  # }
  # measure:  powerup_combo_rocket_propeller_sum {
  #   group_label: "Power Ups"
  #   label: "Combo Rocket + Propeller"
  #   type: sum
  #   sql: ${powerup_combo_rocket_propeller} ;;
  # }
  # dimension:  powerup_combo_color_ball_propeller {
  #   group_label: "Power Ups"
  #   label: "Combo Propeller + Color Ball"
  #   type: number
  # }
  # measure:  powerup_combo_propeller_color_ball_sum {
  #   group_label: "Power Ups"
  #   label: "Combo Propeller + Color Ball"
  #   type: sum
  #   sql: ${powerup_combo_color_ball_propeller} ;;
  # }
  # dimension:  powerup_combo_color_ball {
  #   group_label: "Power Ups"
  #   label: "Combo Color Balls"
  #   type: number
  # }
  # measure:  powerup_combo_color_ball_sum {
  #   group_label: "Power Ups"
  #   label: "Combo Color Balls"
  #   type: sum
  #   sql: ${powerup_combo_color_ball} ;;
  # }
  # dimension:  powerup_piping_bag{
  #   hidden: yes
  # }
  # dimension:  powerup_rolling_pin{
  #   hidden: yes
  # }
  # dimension:  powerup_hammer{
  #   hidden: yes
  # }
  dimension: moves {
    label: "Moves Made"
    type: number
  }
  measure: moves_made_025 {
    group_label: "Moves Made"
    label: "Moves Made - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${moves} ;;
  }
  measure: moves_made_25 {
    group_label: "Moves Made"
    label: "Moves Made - 25%"
    type: percentile
    percentile: 25
    sql: ${moves} ;;
  }
  measure: moves_made_med {
    group_label: "Moves Made"
    label: "Moves Made - Median"
    type: median
    sql: ${moves} ;;
  }
  measure: moves_made_75 {
    group_label: "Moves Made"
    label: "Moves Made - 75%"
    type: percentile
    percentile: 75
    sql: ${moves} ;;
  }
  measure: moves_made_975 {
    group_label: "Moves Made"
    label: "Moves Made - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${moves} ;;
  }
  dimension: moves_added {
    type: yesno
    sql: ${TABLE}.moves_added ;;
  }
  dimension: moves_remaining {
    type: number
  }
  measure: moves_remaining_025 {
    group_label: "Moves Remaining"
    label: "Moves Remaining - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${moves_remaining} ;;
  }
  measure: moves_remaining_25 {
    group_label: "Moves Remaining"
    label: "Moves Remaining - 25%"
    type: percentile
    percentile: 25
    sql: ${moves_remaining} ;;
  }
  measure: moves_remaining_med {
    group_label: "Moves Remaining"
    label: "Moves Remaining - Median"
    type: median
    sql: ${moves_remaining} ;;
  }
  measure: moves_remaining_75 {
    group_label: "Moves Remaining"
    label: "Moves Remaining - 75%"
    type: percentile
    percentile: 75
    sql: ${moves_remaining} ;;
  }
  measure: moves_remaining_975 {
    group_label: "Moves Remaining"
    label: "Moves Remaining - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${moves_remaining} ;;
  }
  dimension: coins_earned {
    type: number
    sql: ${TABLE}.coins_earned ;;
  }
  measure: coins_earned_025 {
    group_label: "Coins Earned"
    label: "Coins Earned - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${coins_earned} ;;
  }
  measure: coins_earned_25 {
    group_label: "Coins Earned"
    label: "Coins Earned - 25%"
    type: percentile
    percentile: 25
    sql: ${coins_earned} ;;
  }
  measure: coins_earned_50 {
    group_label: "Coins Earned"
    label: "Coins Earned - Median"
    type: median
    sql: ${coins_earned} ;;
  }
  measure: coins_earned_75 {
    group_label: "Coins Earned"
    label: "Coins Earned - 75%"
    type: percentile
    percentile: 75
    sql: ${coins_earned} ;;
  }
  measure: coins_earned_975 {
    group_label: "Coins Earned"
    label: "Coins Earned - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${coins_earned} ;;
  }
  measure: session_count {
    label: "Sessions Played"
    type: count_distinct
    sql: ${TABLE}.session_id ;;
  }
  dimension: round_length {
    type: number
    sql: ${TABLE}.round_length ;;
  }
  dimension: round_length_num {
    type: number
    sql: ${TABLE}.round_length / 1000;;
  }
  measure: round_length_sum {
    label: "Round Length Sum"
    type: sum
    sql: ${round_length_num} ;;
  }
  measure: round_length_025 {
    group_label: "Round Length"
    label: "Round Length - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${round_length_num} ;;
  }
  measure: round_length_25 {
    group_label: "Round Length"
    label: "Round Length - 25%"
    type: percentile
    percentile: 25
    sql: ${round_length_num} ;;
  }
  measure: round_length_med {
    group_label: "Round Length"
    label: "Round Length - Median"
    type: median
    sql: ${round_length_num} ;;
  }
  measure: round_length_75 {
    group_label: "Round Length"
    label: "Round Length - 75%"
    type: percentile
    percentile: 75
    sql: ${round_length_num} ;;
  }
  measure: round_length_975 {
    group_label: "Round Length"
    label: "Round Length - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${round_length_num} ;;
  }
  measure: max_attempts {
    label: "Max Attempts per Level"
    type: max
    sql: ${rounds} ;;
  }
  measure:  proximity_to_completion_int_avg {
    label: "Avg. Proximity to Completion"
    type: average
    sql: ${proximity_to_completion_int} ;;
  }
  dimension: currency_02_balance {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_02_balance ;;
  }
  measure: currency_02_balance_025 {
    group_label: "Gem Balance"
    label: "Gem Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_02_balance} ;;
  }
  measure: currency_02_balance_25 {
    group_label: "Gem Balance"
    label: "Gem Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_02_balance} ;;
  }
  measure: currency_02_balance_med {
    group_label: "Gem Balance"
    label: "Gem Balance - Median"
    type: median
    sql: ${currency_02_balance} ;;
  }
  measure: currency_02_balance_75 {
    group_label: "Gem Balance"
    label: "Gem Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_02_balance} ;;
  }
  measure: currency_02_balance_975 {
    group_label: "Gem Balance"
    label: "Gem Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_02_balance} ;;
  }
  dimension: currency_03_balance {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_03_balance ;;
  }
  measure: currency_03_balance_025 {
    group_label: "Coin Balance"
    label: "Coin Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_03_balance} ;;
  }
  measure: currency_03_balance_25 {
    group_label: "Coin Balance"
    label: "Coin Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_03_balance} ;;
  }
  measure: currency_03_balance_med {
    group_label: "Coin Balance"
    label: "Coin Balance - Median"
    type: median
    sql: ${currency_03_balance} ;;
  }
  measure: currency_03_balance_75 {
    group_label: "Coin Balance"
    label: "Coin Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_03_balance} ;;
  }
  measure: currency_03_balance_975 {
    group_label: "Coin Balance"
    label: "Coin Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_03_balance} ;;
  }
  dimension: currency_07_balance {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_07_balance ;;
  }
  measure: currency_07_balance_025 {
    group_label: "Star Balance"
    label: "Star Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_07_balance} ;;
  }
  measure: currency_07_balance_25 {
    group_label: "Star Balance"
    label: "Star Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_07_balance} ;;
  }
  measure: currency_07_balance_med {
    group_label: "Star Balance"
    label: "Star Balance - Median"
    type: median
    sql: ${currency_07_balance} ;;
  }
  measure: currency_07_balance_75 {
    group_label: "Star Balance"
    label: "Star Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_07_balance} ;;
  }
  measure: currency_07_balance_975 {
    group_label: "Star Balance"
    label: "Star Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_07_balance} ;;
  }

  drill_fields: [rdg_id,last_level_serial,last_level_serial_offset,last_level_id,rounds,proximity_to_completion]
}
