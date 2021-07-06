view: user_fact {
# this is at the grain of the user
  view_label: "Users"
  derived_table: {
    sql:
       with first_activity as (select
        rdg_id
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
        ,fa.platform
        ,fa.country
        ,max(ltv) ltv
        ,min(created_at) created
        ,min(datetime(created_at,'US/Pacific')) created_pst
        ,max(timestamp) last_event
        ,count(distinct session_id) lifetime_sessions
        ,max(quests_completed) quests_completed
        ,max(json_extract_scalar(extra_json,"$.card_id")) current_card  -- need to do the max on the current card num, card_003_b (150) is coming through instead of card_002 (400)
        ,max(last_unlocked_card) last_unlocked_card -- need to do the max on the last unlocked card num, card_003_b (150) is coming through instead of card_002 (400)
        ,min(version) version
        ,max(install_version) install_version
        ,max(player_level_xp) player_level_xp
        ,max(days_played_past_week) days_played_past_week
      from first_activity fa
      left join `eraser-blast.game_data.events` gde
        on fa.rdg_id = gde.rdg_id
      where gde.created_at >= '2019-01-01'
      and gde.user_type = 'external'
      and gde.country != 'ZZ'
      and coalesce(gde.install_version,'null') <> '-1'
      and fa.rn = 1
      group by 1, 2, 3
    ;;
    datagroup_trigger: change_3_hrs
    publish_as_db_view: yes
    partition_keys: ["created"]
  }
  dimension: rdg_id {
    type: string
    primary_key: yes
    sql: ${TABLE}.rdg_id ;;
  }
  dimension_group: created {
    type: time
    timeframes: [
      time,
      hour_of_day,
      date,
      month,
      year
    ]
  }
  dimension_group: created_pst {
    group_label: "Created Date - PST"
    datatype: datetime
    type: time
    timeframes: [
      time
      ,date
      ,month
      ,year
    ]
  }
  dimension_group: last_event {
    type: time
    timeframes: [
      raw,
      hour_of_day,
      date,
      month,
      year
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
  dimension: session_tier {
    type: tier
    sql: ${lifetime_sessions} ;;
    tiers: [1,2,3,5,10,20,50,100]
    style: integer
  }
  dimension: version {
    label: "Release Version"
    value_format: "0"
    type: number
    sql: cast(${TABLE}.version as int64) ;;
  }
  dimension: derived_install_minor_release_version {
    label: "Minor Release Version"
    type: string
    sql: @{release_version_minor} ;;
  }
  dimension: install_version {
    label: "Install Version"
    type: number
    hidden: no
    value_format: "0"
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
  dimension: minor_release_version_x {
    label: "Install Release Version"
    type: number
    value_format: "0"
    sql: coalesce(${install_version},${version}) ;;
  }
  dimension: player_level_xp {
    hidden: no
  }
  dimension: player_xp {
    type: number
    sql: trunc(${player_level_xp}) ;;
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
    label: "Count of Players"
    type: count_distinct
    sql: ${rdg_id} ;;
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
}
