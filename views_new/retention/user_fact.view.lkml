view: user_fact {
  derived_table: {
    sql:
      select
        rdg_id user_id,
        case
          when platform LIKE '%iOS%' THEN 'Apple'
          WHEN platform LIKE '%Android%' THEN 'Google'
          ELSE 'Other'
        END platform,
        country,
        ltv,
        min(created_at) created,
        max(timestamp) last_event,
        count(distinct session_id) lifetime_sessions,
        max(quests_completed) quests_completed,
        -- sum(ifnull(case when json_extract_scalar(extra_json,"$.transaction_id") is not null then (cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") as numeric) / 100) end,0)) purchase_amt,
        max(json_extract_scalar(extra_json,"$.card_id")) current_card,
        max(last_unlocked_card) last_unlocked_card,
        min(version) version,
        max(install_version) install_version,
        max(player_level_xp) player_level_xp
      from `eraser-blast.game_data.events`
      where created_at >= '2019-01-01'
      and user_type = 'external'
      and country != 'ZZ'
      group by user_id, country, platform, country, ltv
    ;;
    datagroup_trigger: change_at_midnight
    publish_as_db_view: yes
    partition_keys: ["created"]
  }
  dimension: user_id {
    type: string
    primary_key: yes
  }
  dimension_group: created {
    type: time
    timeframes: [
      time,
      date,
      month,
      year
    ]
  }
  dimension_group: created_pst {
    group_label: "Created Date - PST"
    type: time
    sql: datetime(${TABLE}.created,'US/Pacific') ;;
    timeframes: [
      raw
      ,date
      ,month
      ,year
    ]
  }
  dimension_group: last_event {
    type: time
    timeframes: [
      time,
      date,
      month,
      year
    ]
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
  dimension: platform {
    group_label: "Device & OS Dimensions"
    label: "Device Platform"
    type: string
    sql: ${TABLE}.platform ;;
  }
  dimension: quests_completed {
    type: number
    hidden: yes
  }
  # dimension: purchase_amt {
  #   type: number
  #   value_format_name: usd
  #   hidden: yes
  # }
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
  dimension: ltv {
    label: "LTV"
    type: number
    sql: ${TABLE}.ltv / 100 ;;
  }
  dimension: payer {
    type: yesno
    sql:  ${ltv} > 0;;
  }
  # dimension: spend_tier {
  #   type: string
  #   sql: case when ${purchase_amt} = 0 then '$0.00'
  #     when ${purchase_amt} > 0 and ${purchase_amt} < 10 then '$1.00 - $9.99'
  #     when ${purchase_amt} >= 10 and ${purchase_amt} < 50 then '$10.00 - $49.99'
  #     when ${purchase_amt} >= 50 and ${purchase_amt} < 100 then '$50.00 - $99.99'
  #     when ${purchase_amt} >= 100 and ${purchase_amt} then '$100.00 +'
  #     end ;;
  # }
  dimension: lifetime_sessions {
    type: number
  }
  dimension: current_card {
    type: string
  }
  dimension: last_unlocked_card {
    type: string
  }
  dimension: current_card_no {
    type: number
    value_format: "####"
    sql: @{current_card_numbered};;
  }
  dimension: session_tier {
    type: tier
    sql: ${lifetime_sessions} ;;
    tiers: [1,2,3,5,10,20,50,100]
    style: integer
  }
  dimension: version {
    type: string
    hidden: yes
  }
  dimension: derived_install_minor_release_version {
    hidden: yes
    type: string
    sql: @{release_version_minor} ;;
  }
  dimension: install_version {
    type: number
    hidden: no
    sql: cast(${TABLE}.install_version as int64) ;;
  }
  dimension: install_minor_release_version {
    hidden: yes
    type: string
    sql: @{install_release_version_minor};;
  }
  dimension: minor_release_version {
    label: "Install Minor Release Version"
    type: string
    sql: coalesce(${install_minor_release_version},${derived_install_minor_release_version}) ;;
  }
  dimension: player_level_xp {
    hidden: yes
  }
  measure: player_level_xp_025 {
    group_label: "Player XP"
    label: "Player XP - 2.5%"
    type: percentile
    percentile: 2.5
    sql: ${player_level_xp} ;;
  }
  measure: player_level_xp_25 {
    group_label: "Player XP"
    label: "Player XP - 25%"
    type: percentile
    percentile: 25
    sql: ${player_level_xp} ;;
  }
  measure: player_level_xp_med {
    group_label: "Player XP"
    label: "Player XP - Median"
    type: median
    sql: ${player_level_xp} ;;
  }
  measure: player_level_xp_75 {
    group_label: "Player XP"
    label: "Player XP - 75%"
    type: percentile
    percentile: 75
    sql: ${player_level_xp} ;;
  }
  measure: player_level_xp_975 {
    group_label: "Player XP"
    label: "Player XP - 97.5%"
    type: percentile
    percentile: 97.5
    sql: ${player_level_xp} ;;
  }
  measure: count {
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
}
