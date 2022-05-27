view: user_fact {
# this is at the grain of the user
  view_label: "Users"
  derived_table: {
    sql:
       with first_activity as (select
        rdg_id
        ,device_id
        ,advertising_id
        ,user_id
        ,platform
        ,country
        ,row_number() over (partition by rdg_id order by timestamp asc) rn
      from `eraser-blast.game_data.events`
      where created_at >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1')
      -- group by rdg_id, country, platform
      select
        fa.rdg_id
        ,fa.device_id
        ,fa.advertising_id
        ,fa.user_id
        ,fa.platform
        ,fa.country
        ,hardware
        ,(select string_agg(json_extract_scalar(device_array, '$.screenWidth'), ' ,') from unnest(json_extract_array(devices)) device_array) screen_width
        ,(select string_agg(json_extract_scalar(device_array, '$.screenHeight'), ' ,') from unnest(json_extract_array(devices)) device_array) screen_height
        ,max(ltv) ltv
        ,min(created_at) created
        ,min(datetime(created_at,'US/Pacific')) created_pst
        ,max(current_quest) highest_quest_reached
        ,max(session_id) last_session
        ,max(session_count) lifetime_sessions
        ,max(timestamp) last_event
        ,cast(max(quests_completed) as int64) quests_completed
        ,max(json_extract_scalar(extra_json,"$.card_id")) current_card  -- need to do the max on the current card num, card_003_b (150) is coming through instead of card_002 (400)
        ,max(last_unlocked_card) last_unlocked_card -- need to do the max on the last unlocked card num, card_003_b (150) is coming through instead of card_002 (400)
        ,min(version) version
        ,max(install_version) install_version
        ,max(cast(json_extract_scalar(extra_json,"$.config_timestamp") as numeric)) config_timestamp
        ,min(cast(json_extract_scalar(extra_json,"$.config_timestamp") as numeric)) install_config_timestamp
        ,max(days_played_past_week) days_played_past_week
        ,max(cast(json_extract_scalar(currencies,"$.CURRENCY_02") as numeric)) currency_02_balance_max
        ,max(cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric)) currency_03_balance_max
        ,max(cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric)) currency_04_balance_max
        ,max(cast(json_extract_scalar(currencies,"$.CURRENCY_05") as numeric)) currency_05_balance_max
        ,max(cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric)) currency_07_balance_max
        ,min(cast(json_extract_scalar(currencies,"$.CURRENCY_02") as numeric)) currency_02_balance_min
        ,min(cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric)) currency_03_balance_min
        ,min(cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric)) currency_04_balance_min
        ,min(cast(json_extract_scalar(currencies,"$.CURRENCY_05") as numeric)) currency_05_balance_min
        ,min(cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric)) currency_07_balance_min
        ,max(cast(json_extract_scalar(tickets,"$.box_001") as numeric)) box_001_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.box_002") as numeric)) box_002_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.box_007") as numeric)) box_007_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.COIN") as numeric)) coin_boost_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.TIME") as numeric)) time_boost_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.FIVE_TO_FOUR") as numeric)) five_to_four_boost_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.BUBBLE") as numeric)) bubble_boost_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.SCORE") as numeric)) score_boost_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.SKILL") as numeric)) skill_ticket_balance_max
        ,max(cast(json_extract_scalar(tickets,"$.LEVEL") as numeric)) level_ticket_balance_max
        ,min(cast(json_extract_scalar(tickets,"$.box_001") as numeric)) box_001_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.box_002") as numeric)) box_002_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.box_007") as numeric)) box_007_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.COIN") as numeric)) coin_boost_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.TIME") as numeric)) time_boost_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.FIVE_TO_FOUR") as numeric)) five_to_four_boost_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.BUBBLE") as numeric)) bubble_boost_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.SCORE") as numeric)) score_boost_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.SKILL") as numeric)) skill_ticket_balance_min
        ,min(cast(json_extract_scalar(tickets,"$.LEVEL") as numeric)) level_ticket_balance_min

      from first_activity fa
      left join `eraser-blast.game_data.events` gde
        on fa.rdg_id = gde.rdg_id
      where gde.created_at >= '2019-01-01'
      and gde.user_type = 'external'
      and gde.country != 'ZZ'
      and coalesce(gde.install_version,'null') <> '-1'
      and fa.rn = 1
      group by 1,2,3,4,5,6,7,8,9
    ;;

    datagroup_trigger: change_8_hrs
    publish_as_db_view: yes
    partition_keys: ["created"]
  }
  dimension: rdg_id {
    group_label: "Player IDs"
    type: string
    primary_key: yes
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: device_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.device_id ;;
  }
  dimension: advertising_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.advertising_id ;;
  }
  dimension: user_id {
    group_label: "Player IDs"
    type: string
    sql: ${TABLE}.user_id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [
      time
      ,hour_of_day
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]
  }
  dimension_group: created_pst {
    group_label: "Created Date - PST"
    datatype: datetime
    type: time
    timeframes: [
      time
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]
  }
  dimension_group: last_event {
    type: time
    timeframes: [
      raw
      ,hour_of_day
      ,date
      ,week
      ,month
      ,quarter
      ,year
    ]}
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
  dimension: platform {
    group_label: "Device & OS Dimensions"
    label: "Device Platform"
    type: string
    sql: @{device_platform_mapping} ;;
  }
  dimension: manufacturer {
    group_label: "Device & OS Dimensions"
    label: "Device Manufacturer"
    type: string
    sql: @{device_manufacturer_mapping} ;;
  }
  dimension: hardware {
    group_label: "Device & OS Dimensions"
    label: "Device Hardware"
    type: string
    sql: ${TABLE}.hardware ;;
  }
  dimension: screen_width {
    group_label: "Device & OS Dimensions"
    label: "Screen Width"
    type: string
    sql: ${TABLE}.screen_width ;;
  }
  dimension: screen_height {
    group_label: "Device & OS Dimensions"
    label: "Screen Height"
    type: string
    sql: ${TABLE}.screen_height ;;
  }
  dimension: screen_height_x_width {
    group_label: "Device & OS Dimensions"
    label: "Screen Height x Width"
    type: string
    sql: concat(concat(${screen_height},'x'),${screen_width}) ;;
  }
  dimension: aspect_ratio {
    group_label: "Device & OS Dimensions"
    label: "Aspect Ratio"
    type: number
    value_format: "#.00"
    sql: cast(${screen_height} as integer) / cast(${screen_width} as integer);;
  }
  dimension: quests_completed {
    type: number
    hidden: no
  }
  dimension: days_between_first_and_last_event {
    type: number
    sql: case when ${created_date} >= ${last_event_date} then date_diff(${last_event_date},${created_date},day) else null end ;;
  }
  dimension: days_since_last_event {
    type:number
    sql: case when ${last_event_date} <= current_date() then date_diff(current_date(),${last_event_date},day) else null end ;;
  }
  dimension: churned {
    type: yesno
    sql: ${days_since_last_event} > 1 ;;
  }
  dimension: days_played_past_week {
    label: "Number of Days Played Over Last 7 Days"
    type: number
  }
  dimension: ltv {
    label: "Net LTV"
    value_format: "$#.00"
    type: number
    sql: (${TABLE}.ltv / 100) * 0.85 ;;
  }
  dimension: payer {
    type: yesno
    sql:  ${ltv} > 0;;
  }
  dimension: lifetime_sessions {
    type: number
  }
  dimension: session_tier {
    type: tier
    sql: ${lifetime_sessions} ;;
    tiers: [1,2,3,5,10,20,50,100]
    style: integer
  }
  measure: lifetime_sessions_025 {
    group_label: "Lifetime Sessions"
    label: "Lifetime Sessions - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${lifetime_sessions} ;;
  }
  measure: lifetime_sessions_25 {
    group_label: "Lifetime Sessions"
    label: "Lifetime Sessions - 25%"
    type: percentile
    percentile: 25
    sql: ${lifetime_sessions} ;;
  }
  measure: lifetime_sessions_med {
    group_label: "Lifetime Sessions"
    label: "Lifetime Sessions - Median"
    type: median
    sql: ${lifetime_sessions} ;;
  }
  measure: lifetime_sessions_75 {
    group_label: "Lifetime Sessions"
    label: "Lifetime Sessions - 75%"
    type: percentile
    percentile: 75
    sql: ${lifetime_sessions} ;;
  }
  measure: lifetime_sessions_975 {
    group_label: "Lifetime Sessions"
    label: "Lifetime Sessions - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${lifetime_sessions} ;;
  }
  # dimension: current_card {
  #   group_label: "Card Dimensions"
  #   label: "Player Current Card"
  #   type: string
  # }
  # dimension: last_unlocked_card {
  #   group_label: "Card Dimensions"
  #   label: "Player Last Unlocked Card"
  #   type: string
  # }
  # dimension: current_card_no {
  #   group_label: "Card Dimensions"
  #   label: "Player Current Card (Numbered)"
  #   type: number
  #   value_format: "####"
  #   sql: @{current_card_numbered};;
  # }
  dimension: version {
    group_label: "Version Dimensions"
    label: "Release Version"
    value_format: "0"
    type: number
    sql: cast(${TABLE}.version as int64) ;;
  }
  dimension: derived_install_minor_release_version {
    group_label: "Version Dimensions"
    label: "Minor Release Version"
    type: string
    sql: @{release_version_minor} ;;
  }
  dimension: install_version {
    group_label: "Version Dimensions"
    label: "Install Version"
    type: number
    hidden: no
    value_format: "0"
    sql: cast(${TABLE}.install_version as int64) ;;
  }
  dimension: install_minor_release_version {
    group_label: "Version Dimensions"
    hidden: yes
    type: string
    sql: @{install_release_version_minor};;
  }
  dimension: minor_release_version {
    group_label: "Version Dimensions"
    label: "Install Minor Release Version"
    type: string
    sql: coalesce(${install_minor_release_version},${derived_install_minor_release_version}) ;;
  }
  dimension: minor_release_version_x {
    group_label: "Version Dimensions"
    label: "Install Release Version"
    type: number
    value_format: "0"
    sql: coalesce(${install_version},${version}) ;;
  }
  dimension: config_version {
    group_label: "Version Dimensions"
    label: "Config Version"
    type: number
    value_format: "0"
    sql: ${TABLE}.config_timestamp;;
  }
  dimension: install_config_timestamp {
    group_label: "Version Dimensions"
    label: "Install Config Version"
    type: number
    value_format: "0"
    sql: ${TABLE}.install_config_timestamp;;
  }
  measure: count {
    label: "Count of Players"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [hardware, rdg_id, created_date, churned]
  }
  measure: count_rows {
    type: count
  }
  # measure: spend_amount {
  #   type: sum
  #   sql: ${purchase_amt} ;;
  #   value_format_name: usd
  # }
  measure: completed_quests {
    type: sum
    sql: ${quests_completed} ;;
  }
  measure: sum_net_ltv {
    label: "Net LTV"
    value_format: "$#.00"
    type: sum
    sql: ${ltv} ;;
  }
  dimension: currency_02_balance_max {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_02_balance_max ;;
  }
  measure: currency_02_balance_025 {
    group_label: "Gem Balance - Max"
    label: "Max Daily Gem Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_02_balance_max} ;;
  }
  measure: currency_02_balance_25 {
    group_label: "Gem Balance - Max"
    label: "Max Daily Gem Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_02_balance_max} ;;
  }
  measure: currency_02_balance_med {
    group_label: "Gem Balance - Max"
    label: "Max Daily Gem Balance - Median"
    type: median
    sql: ${currency_02_balance_max} ;;
  }
  measure: currency_02_balance_75 {
    group_label: "Gem Balance - Max"
    label: "Max Daily Gem Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_02_balance_max} ;;
  }
  measure: currency_02_balance_975 {
    group_label: "Gem Balance - Max"
    label: "Max Daily Gem Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_02_balance_max} ;;
  }
  dimension: currency_02_balance_min {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_02_balance_min ;;
  }
  measure: currency_02_balance_min_025 {
    group_label: "Gem Balance - Min"
    label: "Min Daily Gem Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_02_balance_min} ;;
  }
  measure: currency_02_balance_min_25 {
    group_label: "Gem Balance - Min"
    label: "Min Daily Gem Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_02_balance_min} ;;
  }
  measure: currency_02_balance_min_med {
    group_label: "Gem Balance - Min"
    label: "Min Daily Gem Balance - Median"
    type: median
    sql: ${currency_02_balance_min} ;;
  }
  measure: currency_02_balance_min_75 {
    group_label: "Gem Balance - Min"
    label: "Min Daily Gem Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_02_balance_min} ;;
  }
  measure: currency_02_balance_min_975 {
    group_label: "Gem Balance - Min"
    label: "Min Daily Gem Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_02_balance_min} ;;
  }
  dimension: currency_03_balance_max {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_03_balance_max ;;
  }
  measure: currency_03_balance_025 {
    group_label: "Coin Balance - Max"
    label: "Max Daily Coin Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_03_balance_max} ;;
  }
  measure: currency_03_balance_25 {
    group_label: "Coin Balance - Max"
    label: "Max Daily Coin Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_03_balance_max} ;;
  }
  measure: currency_03_balance_med {
    group_label: "Coin Balance - Max"
    label: "Max Daily Coin Balance - Median"
    type: median
    sql: ${currency_03_balance_max} ;;
  }
  measure: currency_03_balance_75 {
    group_label: "Coin Balance - Max"
    label: "Max Daily Coin Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_03_balance_max} ;;
  }
  measure: currency_03_balance_975 {
    group_label: "Coin Balance - Max"
    label: "Max Daily Coin Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_03_balance_max} ;;
  }
  dimension: currency_03_balance_min {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_03_balance_min ;;
  }
  measure: currency_03_balance_min_025 {
    group_label: "Coin Balance - Min"
    label: "Min Daily Coin Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_03_balance_min} ;;
  }
  measure: currency_03_balance_min_25 {
    group_label: "Coin Balance - Min"
    label: "Min Daily Coin Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_03_balance_min} ;;
  }
  measure: currency_03_balance_min_med {
    group_label: "Coin Balance - Min"
    label: "Min Daily Coin Balance - Median"
    type: median
    sql: ${currency_03_balance_min} ;;
  }
  measure: currency_03_balance_min_75 {
    group_label: "Coin Balance - Min"
    label: "Min Daily Coin Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_03_balance_min} ;;
  }
  measure: currency_03_balance_min_975 {
    group_label: "Coin Balance - Min"
    label: "Min Daily Coin Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_03_balance_min} ;;
  }
  dimension: currency_04_balance_max {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_04_balance_max ;;
  }
  measure: currency_04_balance_025 {
    group_label: "Lives Balance"
    label: "Max Daily Lives Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_04_balance_max} ;;
  }
  measure: currency_04_balance_25 {
    group_label: "Lives Balance"
    label: "Max Daily Lives Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_04_balance_max} ;;
  }
  measure: currency_04_balance_med {
    group_label: "Lives Balance"
    label: "Max Daily Lives Balance - Median"
    type: median
    sql: ${currency_04_balance_max} ;;
    drill_fields: [rdg_id,currency_04_balance_max]
  }
  measure: currency_04_balance_75 {
    group_label: "Lives Balance"
    label: "Max Daily Lives Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_04_balance_max} ;;
  }
  measure: currency_04_balance_975 {
    group_label: "Lives Balance"
    label: "Max Daily Lives Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_04_balance_max} ;;
  }
  dimension: currency_05_balance_max {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_05_balance_max ;;
  }
  measure: currency_05_balance_025 {
    group_label: "AFH Token Balance - Max"
    label: "Max Daily AFH Token Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_05_balance_max} ;;
  }
  measure: currency_05_balance_25 {
    group_label: "AFH Token Balance - Max"
    label: "Max Daily AFH Token Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_05_balance_max} ;;
  }
  measure: currency_05_balance_med {
    group_label: "AFH Token Balance - Max"
    label: "Max Daily AFH Token Balance - Median"
    type: median
    sql: ${currency_05_balance_max} ;;
  }
  measure: currency_05_balance_75 {
    group_label: "AFH Token Balance - Max"
    label: "Max Daily AFH Token Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_05_balance_max} ;;
  }
  measure: currency_05_balance_975 {
    group_label: "AFH Token Balance - Max"
    label: "Max Daily AFH Token Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_05_balance_max} ;;
  }
  dimension: currency_05_balance_min {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_05_balance_min ;;
  }
  measure: currency_05_balance_025_min {
    group_label: "AFH Token Balance - Min"
    label: "Min Daily AFH Token Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_05_balance_min} ;;
  }
  measure: currency_05_balance_25_min {
    group_label: "AFH Token Balance - Min"
    label: "Min Daily AFH Token Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_05_balance_min} ;;
  }
  measure: currency_05_balance_med_min {
    group_label: "AFH Token Balance - Min"
    label: "Min Daily AFH Token Balance - Median"
    type: median
    sql: ${currency_05_balance_min} ;;
  }
  measure: currency_05_balance_75_min {
    group_label: "AFH Token Balance - Min"
    label: "Min Daily AFH Token Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_05_balance_min} ;;
  }
  measure: currency_05_balance_975_min {
    group_label: "AFH Token Balance - Min"
    label: "Min Daily AFH Token Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_05_balance_min} ;;
  }
  dimension: currency_07_balance_max {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_07_balance_max ;;
  }
  measure: currency_07_balance_025 {
    group_label: "Star Balance - Max"
    label: "Max Daily Star Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_07_balance_max} ;;
  }
  measure: currency_07_balance_25 {
    group_label: "Star Balance - Max"
    label: "Max Daily Star Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_07_balance_max} ;;
  }
  measure: currency_07_balance_med {
    group_label: "Star Balance - Max"
    label: "Max Daily Star Balance - Median"
    type: median
    sql: ${currency_07_balance_max} ;;
  }
  measure: currency_07_balance_75 {
    group_label: "Star Balance - Max"
    label: "Max Daily Star Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_07_balance_max} ;;
  }
  measure: currency_07_balance_975 {
    group_label: "Star Balance - Max"
    label: "Max Daily Star Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_07_balance_max} ;;
  }
  dimension: currency_07_balance_min {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_07_balance_min ;;
  }
  measure: currency_07_balance_025_min {
    group_label: "Star Balance - Min"
    label: "Min Daily Star Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_07_balance_min} ;;
  }
  measure: currency_07_balance_25_min {
    group_label: "Star Balance - Min"
    label: "Min Daily Star Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_07_balance_min} ;;
  }
  measure: currency_07_balance_med_min {
    group_label: "Star Balance - Min"
    label: "Min Daily Star Balance - Median"
    type: median
    sql: ${currency_07_balance_min} ;;
  }
  measure: currency_07_balance_75_min {
    group_label: "Star Balance - Min"
    label: "Min Daily Star Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_07_balance_min} ;;
  }
  measure: currency_07_balance_975_min {
    group_label: "Star Balance - Min"
    label: "Min Daily Star Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_07_balance_min} ;;
  }
  measure: first_created_date {
    type: date
    sql: cast(MIN(${created_date}) as timestamp) ;;
    convert_tz: no
  }
  set: cohort_set {
    fields: [
      created_date,
      created_week,
      payer,
      count
    ]
  }

}
