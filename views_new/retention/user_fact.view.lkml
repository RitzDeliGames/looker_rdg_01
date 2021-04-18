view: user_fact {
  derived_table: {
    sql:
      select
        rdg_id user_id,
        platform,
        country,
        min(created_at) created,
        max(timestamp) last_event,
        count(distinct session_id) lifetime_sessions,
        max(quests_completed) quests_completed,
        -- sum(ifnull(case when json_extract_scalar(extra_json,"$.transaction_id") is not null then (cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") as numeric) / 100) end,0)) purchase_amt,
        max(json_extract_scalar(extra_json,"$.card_id")) current_card,
        --max(coalesce(events.last_unlocked_card,events.current_card)) current_card,
        min(version) version,
        max(install_version) install_version
      from `eraser-blast.game_data.events`
      where created_at >= '2019-01-01'
      and user_type = 'external'
      group by user_id, country, platform
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
    sql: @{device_platform_mapping} ;;
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
