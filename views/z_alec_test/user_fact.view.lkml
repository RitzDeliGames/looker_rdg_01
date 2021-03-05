view: user_fact {
  derived_table: {
    sql:
      select
        user_id,
        min(created_at) created,
        max(timestamp) last_event,
        max(quests_completed) quests_completed,
        sum(ifnull(case when json_extract_scalar(extra_json,"$.transaction_id") is not null then (cast(json_extract_scalar(extra_json,"$.transaction_purchase_amount") as numeric) / 100) end,0)) purchase_amt
      from `eraser-blast.game_data.events`
      group by user_id
    ;;
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
  dimension: quests_completed {
    type: number
  }
  dimension: purchase_amt {
    type: number
    value_format_name: usd
  }
  dimension: days_between_first_and_last_event {
    type: number
    sql: case when ${created_date} >= ${last_event_date} then date_diff(${last_event_date},${created_date},day) else null end ;;
  }
  dimension: days_since_last_event {
    type:number
    sql: case when ${last_event_date} <= current_date() then date_diff(current_date(),${last_event_date},day) else null end ;;
  }
  dimension: spend_tier {
    type: tier
    sql: ${purchase_amt} ;;
    tiers: [1,10,50,100]
    style: integer
  }
  measure: count {
    type: count
  }
  measure: purchase_amount {
    type: sum
    sql: ${purchase_amt} ;;
    value_format_name: usd
  }
}
