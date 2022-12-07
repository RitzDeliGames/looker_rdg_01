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
      where date(created_at) between '2019-01-01' and current_date()
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1')

      select
        fa.rdg_id
        ,fa.device_id
        ,fa.advertising_id
        ,fa.user_id
        ,fa.platform
        ,fa.country
        ,max(ltv) ltv
        ,min(created_at) created
        ,min(datetime(created_at,'US/Pacific')) created_pst
        ,max(session_id) last_session
        ,max(session_count) lifetime_sessions
        ,max(timestamp) last_event
        ,cast(max(last_level_serial) as int64) last_level_serial
        ,cast(max(engagement_ticks) as int64) engagement_ticks
        ,min(version) version
        ,max(install_version) install_version
        ,max(cast(json_extract_scalar(extra_json,"$.config_timestamp") as numeric)) config_timestamp
        ,min(cast(json_extract_scalar(extra_json,"$.config_timestamp") as numeric)) install_config_timestamp
        ,max(days_played_past_week) days_played_past_week
        --,percentile_cont(cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric),0.5) over (partition by date(timestamp),rdg_id) currency_02_balance_median
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
      group by 1,2,3,4,5,6--,7,8,9
    ;;

    datagroup_trigger: change_6_hrs
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
  dimension: engagement_min {
    group_label: "Minutes Played"
    label: "Max Minutes Played"
    type: number
    sql: ${TABLE}.engagement_ticks / 2 ;;
  }
  dimension: last_level_id {
    group_label: "Level Dimensions"
    label: "Last Level Completed - Id"
    type: string
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
  }
  dimension: days_between_first_and_last_event {
    type: number
    sql: case when ${created_date} >= ${last_event_date} then date_diff(${last_event_date},${created_date},day) else null end ;;
  }
  dimension: days_since_last_event {
    type:number
    sql: case when ${last_event_date} <= current_date() then cast(date_diff(current_date(),${last_event_date},day) as int64) else null end ;;
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
    hidden: no
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
  dimension: config_version_string {
    group_label: "Version Dimensions"
    label: "Config Version - String"
    type: string
    sql: cast(${TABLE}.config_timestamp as string);;
  }
  dimension: install_config_timestamp {
    group_label: "Version Dimensions"
    label: "Install Config Version"
    type: number
    value_format: "0"
    sql: ${TABLE}.install_config_timestamp;;
  }
  dimension: install_config_version_string {
    group_label: "Version Dimensions"
    label: "Install Config Version - String"
    type: string
    sql: cast(${TABLE}.install_config_timestamp as string);;
  }
  measure: count {
    label: "Count of Players"
    type: count_distinct
    sql: ${rdg_id} ;;
    drill_fields: [rdg_id, created_date, churned]
  }
  measure: user_id_count {
    label: "Count of User Ids"
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [user_id, rdg_id, created_date, churned]
  }
  measure: count_rows {
    type: count
  }
  # measure: spend_amount {
  #   type: sum
  #   sql: ${purchase_amt} ;;
  #   value_format_name: usd
  # }
  measure: completed_levels {
    type: sum
    sql: ${last_level_serial} ;;
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
  # dimension: currency_02_balance_median {
  #   type: number
  #   hidden: yes
  #   sql: ${TABLE}.currency_02_balance_median ;;
  # }
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
