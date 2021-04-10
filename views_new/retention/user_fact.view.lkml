view: user_fact {
  derived_table: {
    sql:
      select
        rdg_id user_id,
        country,
        min(created_at) created,
        max(timestamp) last_event,
        count(distinct session_id) lifetime_sessions,
        max(quests_completed) quests_completed,
        -- sum(ifnull(case when json_extract_scalar(extra_json,"$.transaction_id") is not null then (cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") as numeric) / 100) end,0)) purchase_amt,
        max(json_extract_scalar(extra_json,"$.card_id")) current_card,
        min(version) version,
        max(install_version) install_version
      from `eraser-blast.game_data.events`
      where created_at >= '2019-01-01'
      and user_type = 'external'
      group by user_id, country
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
    type: string
  }
  dimension: region {
    type: string
    sql: @{country_region} ;;
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
    sql:
      case
        when ${version} = '1579' then '1.0.100'
        when ${version} = '2047' then '1.1.001'
        when ${version} = '2100' then '1.1.100'
        when ${version} = '3028' then '1.2.028'
        when ${version} = '3043' then '1.2.043'
        when ${version} = '3100' then '1.2.100'
        when ${version} = '4017' then '1.3.017'
        when ${version} = '4100' then '1.3.100'
        else null
      end
    ;;
  }
  dimension: install_version {
    type: string
    hidden: yes
  }
  dimension: install_minor_release_version {
    hidden: yes
    type: string
    sql:
      case
        when ${install_version} = '1568' then '1.0.001'
        when ${install_version} = '1579' then '1.0.100'
        when ${install_version} = '2047' then '1.1.001'
        when ${install_version} = '2100' then '1.1.100'
        when ${install_version} = '3028' then '1.2.028'
        when ${install_version} = '3043' then '1.2.043'
        when ${install_version} = '3100' then '1.2.100'
        when ${install_version} = '4017' then '1.3.017'
        when ${install_version} = '4100' then '1.3.100'
        when ${install_version} = '5006' then '1.5.006'
        when ${install_version} = '5100' then '1.5.100'
        when ${install_version} = '6100' then '1.6.100'
        when ${install_version} = '6200' then '1.6.200'
        when ${install_version} = '6300' then '1.6.300'
        when ${install_version} = '6400' then '1.6.400'
        when ${install_version} = '7100' then '1.7.100'
        when ${install_version} = '7200' then '1.7.200'
        when ${install_version} = '7300' then '1.7.300'
        when ${install_version} = '7400' then '1.7.400'
        when ${install_version} = '7500' then '1.7.500'
        when ${install_version} = '7600' then '1.7.600'
        when ${install_version} = '8000' then '1.8.000'
        when ${install_version} = '8100' then '1.8.100'
        when ${install_version} = '8200' then '1.8.200'
        when ${install_version} = '8300' then '1.8.300'
        when ${install_version} = '8400' then '1.8.400'
        when ${install_version} = '9100' then '1.9.100'
        else null
      end
    ;;
  }
  dimension: minor_release_version {
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
