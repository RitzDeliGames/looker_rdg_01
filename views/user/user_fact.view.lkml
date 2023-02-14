view: user_fact {
# this is at the grain of the user
  view_label: "Users"
  derived_table: {
    sql:
        select
          first_activity.device_id
          ,first_activity.advertising_id
          ,first_activity.user_id
          ,first_activity.platform
          ,first_activity.country
          ,gde.*
          ,median_balance.daily_median_coin_balance currency_03_balance_med
          ,median_balance.daily_median_life_balance currency_04_balance_med
          ,median_balance.daily_median_star_balance currency_07_balance_med
          ,ending_balance.daily_ending_coin_balance currency_03_balance_ending
        from
          (select
            rdg_id
            ,device_id
            ,advertising_id
            ,user_id
            ,platform
            ,country
            ,row_number() over (partition by rdg_id order by timestamp asc) rn
          from `eraser-blast.game_data.events`
          where date(created_at) between '2019-01-01' and current_date()
            and date(timestamp) between '2019-01-01' and current_date()
            and user_type = 'external'
            and country != 'ZZ') first_activity
        left join
          (select
            rdg_id
            ,max(ltv) ltv
            ,min(created_at) created
            ,min(datetime(created_at,'US/Pacific')) created_pst
            ,max(session_id) last_session
            ,max(session_count) lifetime_sessions
            ,max(timestamp) last_event
            ,cast(max(last_level_serial) as int64) last_level_serial
            ,cast(max(engagement_ticks) as int64) engagement_ticks
            ,max(version) version
            ,max(install_version) install_version
            ,max(cast(json_extract_scalar(extra_json,"$.config_timestamp") as numeric)) config_timestamp
            ,min(cast(json_extract_scalar(extra_json,"$.config_timestamp") as numeric)) install_config_timestamp
            ,max(days_played_past_week) days_played_past_week
          from `eraser-blast.game_data.events`
          where date(created_at) between '2019-01-01' and current_date()
            and date(timestamp) between '2019-01-01' and current_date()
            and user_type = 'external'
            and country != 'ZZ'
          group by 1) gde
        on first_activity.rdg_id = gde.rdg_id
        left join
          (with median_balance_calc as
            (select
              rdg_id
              ,timestamp
              ,percentile_cont(cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric), 0.5) over (partition by rdg_id, date(timestamp)) as daily_median_coin_balance
              ,percentile_cont(cast(json_extract_scalar(currencies,"$.CURRENCY_04") as numeric), 0.5) over (partition by rdg_id, date(timestamp)) as daily_median_life_balance
              ,percentile_cont(cast(json_extract_scalar(currencies,"$.CURRENCY_07") as numeric), 0.5) over (partition by rdg_id, date(timestamp)) as daily_median_star_balance
            from `eraser-blast.game_data.events`
            where date(timestamp) between '2019-01-01' and current_date())
          select
            median_balance_calc.rdg_id
            ,median_balance_calc.daily_median_coin_balance
            ,median_balance_calc.daily_median_life_balance
            ,median_balance_calc.daily_median_star_balance
            ,max(median_balance_calc.timestamp) last_event
          from median_balance_calc
          group by 1,2,3,4) median_balance
        on first_activity.rdg_id = median_balance.rdg_id
        and gde.last_event = median_balance.last_event
        left join
          (with ending_balance_calc as
            (select
              rdg_id
              ,timestamp
              ,last_value(cast(json_extract_scalar(currencies,"$.CURRENCY_03") as numeric))
                over (partition by rdg_id,date(timestamp) order by date(timestamp) asc
                rows between unbounded preceding and unbounded following) daily_ending_coin_balance
            from `eraser-blast.game_data.events`
            where date(timestamp) between '2019-01-01' and current_date())
          select
            ending_balance_calc.rdg_id
            ,ending_balance_calc.daily_ending_coin_balance
            ,max(ending_balance_calc.timestamp) last_event
          from ending_balance_calc
          group by 1,2) ending_balance
        on first_activity.rdg_id = ending_balance.rdg_id
        and gde.last_event = ending_balance.last_event
        where rn = 1
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
  dimension: last_level_serial_offset {
    group_label: "Level Dimensions"
    label: "Current Level"
    type: number
    sql: ${last_level_serial} + 1 ;;
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
    group_label: "Net LTV"
    label: "Net LTV"
    value_format: "$#.00"
    type: number
    sql: (${TABLE}.ltv / 100) * 0.85 ;;
  }
  dimension: ltv_tier {
    group_label: "Net LTV - $5 Tiers"
    label: "Net LTV Tiers"
    value_format: "$#.00"
    tiers: [0,5,10,15,20]
    style: integer
    sql: ${ltv};;
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
    tiers: [1,2,3,5,10,20,50,100]
    style: integer
    sql: ${lifetime_sessions} ;;
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
  dimension: currency_03_balance_ending {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_03_balance_ending ;;
  }
  measure: currency_03_ending_balance_025 {
    group_label: "Daily Coin Balance - Ending"
    label: "Ending Daily Coin Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_03_balance_ending} ;;
  }
  measure: currency_03_ending_balance_25 {
    group_label: "Daily Coin Balance - Ending"
    label: "Ending Daily Coin Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_03_balance_ending} ;;
  }
  measure: currency_03_ending_balance_50 {
    group_label: "Daily Coin Balance - Ending"
    label: "Ending Daily Coin Balance - Median"
    type: median
    sql: ${currency_03_balance_ending} ;;
  }
  measure: currency_03_ending_balance_75 {
    group_label: "Daily Coin Balance - Ending"
    label: "Ending Daily Coin Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_03_balance_ending} ;;
  }
  measure: currency_03_ending_balance_975 {
    group_label: "Daily Coin Balance - Ending"
    label: "Ending Daily Coin Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_03_balance_ending} ;;
  }
  dimension: currency_03_balance_med {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_03_balance_med ;;
  }
  measure: currency_03_med_balance_025 {
    group_label: "Daily Coin Balance - Median"
    label: "Median Daily Coin Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_03_balance_med} ;;
  }
  measure: currency_03_med_balance_25 {
    group_label: "Daily Coin Balance - Median"
    label: "Median Daily Coin Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_03_balance_med} ;;
  }
  measure: currency_03_med_balance_50 {
    group_label: "Daily Coin Balance - Median"
    label: "Median Daily Coin Balance - Median"
    type: median
    sql: ${currency_03_balance_med} ;;
  }
  measure: currency_03_med_balance_75 {
    group_label: "Daily Coin Balance - Median"
    label: "Median Daily Coin Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_03_balance_med} ;;
  }
  measure: currency_03_med_balance_975 {
    group_label: "Daily Coin Balance - Median"
    label: "Median Daily Coin Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_03_balance_med} ;;
  }
  # dimension: currency_03_balance {
  #   group_label: "Currency Balance"
  #   label: "Coin Balance"
  #   type: number
  #   hidden: no
  #   sql: ${TABLE}.currency_03_balance_min ;;
  # }
  dimension: currency_04_balance_med {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_04_balance_med ;;
  }
  measure: currency_04_med_balance_025 {
    group_label: "Daily Lives Balance - Median"
    label: "Median Daily Lives Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_04_balance_med} ;;
  }
  measure: currency_04_med_balance_25 {
    group_label: "Daily Lives Balance - Median"
    label: "Median Daily Lives Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_04_balance_med} ;;
  }
  measure: currency_04_med_balance_50 {
    group_label: "Daily Lives Balance - Median"
    label: "Median Daily Lives Balance - Median"
    type: median
    sql: ${currency_04_balance_med} ;;
  }
  measure: currency_04_med_balance_75 {
    group_label: "Daily Lives Balance - Median"
    label: "Median Daily Lives Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_04_balance_med} ;;
  }
  measure: currency_04_med_balance_975 {
    group_label: "Daily Lives Balance - Median"
    label: "Median Daily Lives Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_04_balance_med} ;;
  }
  dimension: currency_07_balance_med {
    type: number
    hidden: yes
    sql: ${TABLE}.currency_07_balance_med ;;
  }
  measure: currency_07_med_balance_025 {
    group_label: "Daily Star Balance - Median"
    label: "Median Daily Star Balance - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${currency_07_balance_med} ;;
  }
  measure: currency_07_med_balance_25 {
    group_label: "Daily Star Balance - Median"
    label: "Median Daily Star Balance - 25%"
    type: percentile
    percentile: 25
    sql: ${currency_07_balance_med} ;;
  }
  measure: currency_07_med_balance_50 {
    group_label: "Daily Star Balance - Median"
    label: "Median Daily Star Balance - Median"
    type: median
    sql: ${currency_07_balance_med} ;;
  }
  measure: currency_07_med_balance_75 {
    group_label: "Daily Star Balance - Median"
    label: "Median Daily Star Balance - 75%"
    type: percentile
    percentile: 75
    sql: ${currency_07_balance_med} ;;
  }
  measure: currency_07_med_balance_975 {
    group_label: "Daily Star Balance - Median"
    label: "Median Daily Star Balance - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${currency_07_balance_med} ;;
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
