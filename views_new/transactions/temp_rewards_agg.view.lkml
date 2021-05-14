view: temp_rewards_agg {
  derived_table: {
    sql: WITH rewards AS (select
        rdg_id
        ,event_name
        ,timestamp
        ,lower(hardware) device_model_number
        ,round(cast(engagement_ticks as int64) / 2) minutes_played
        ,current_card
        ,last_unlocked_card
        ,cast(current_quest as int64) current_quest
        ,json_extract_scalar(extra_json,'$.reward_event') reward_event
        ,json_extract_scalar(extra_json,'$.reward_type') reward_type
        ,cast(json_extract_scalar(extra_json,'$.reward_amount') as int64) reward_amount
        ,cast(json_extract_scalar(extra_json,'$.round_id') as int64) round_id
      from game_data.events
      where event_name = 'reward'
      and user_type = 'external'
      and country != 'ZZ'
      and coalesce(install_version,'null') <> '-1'
    )
SELECT
    economy.rdg_id  AS economy_rdg_id,
    coalesce(economy.last_unlocked_card,economy.current_card)  AS economy_card_id,
    CASE
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_001_a' THEN 100
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_001_untimed' THEN 100
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_002_b' THEN 120
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_003_b' THEN 150
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_002_a' THEN 200
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_002_untimed' THEN 200
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_003_a' THEN 300
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_003_untimed' THEN 300
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_002' THEN 400
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_002_inverted' THEN 400
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_039' THEN 400
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_004_untimed' THEN 400
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_003' THEN 500
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_003_20210329' THEN 500
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_040' THEN 500
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_005_untimed' THEN 500
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_004' THEN 600
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_004_20210329' THEN 600
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_041' THEN 600
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_006_untimed' THEN 600
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_005' THEN 700
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_006' THEN 800
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_007' THEN 900
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_008' THEN 1000
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_009' THEN 1100
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_010' THEN 1200
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_011' THEN 1300
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_012' THEN 1400
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_013' THEN 1500
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_014' THEN 1600
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_015' THEN 1700
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_016' THEN 1800
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_017' THEN 1900
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_018' THEN 2000
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_019' THEN 2100
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_020' THEN 2200
              WHEN coalesce(economy.last_unlocked_card,economy.current_card) = 'card_001_b' THEN 100
          END  AS economy_current_card_numbered,
    economy.reward_type  AS economy_reward_type,
    COALESCE(SUM(economy.reward_amount ), 0) AS economy_currency_rewarded_amount_sum
FROM rewards AS economy
WHERE ((( economy.timestamp  ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( economy.timestamp  ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) AND ((economy.reward_event ) LIKE '%bingo%' OR (economy.reward_event ) LIKE '%round%')
GROUP BY
    1,
    2,
    3,
    4
ORDER BY
    1 DESC
LIMIT 500
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: economy_rdg_id {
    type: string
    sql: ${TABLE}.economy_rdg_id ;;
  }

  dimension: economy_card_id {
    type: string
    sql: ${TABLE}.economy_card_id ;;
  }

  dimension: economy_current_card_numbered {
    type: number
    sql: ${TABLE}.economy_current_card_numbered ;;
  }

  dimension: economy_reward_type {
    type: string
    sql: ${TABLE}.economy_reward_type ;;
  }

  dimension: economy_currency_rewarded_amount_sum {
    type: number
    sql: ${TABLE}.economy_currency_rewarded_amount_sum ;;
  }

  measure: currency_rewarded_025  {
    type: percentile
    percentile: 2.5
    sql: ${economy_currency_rewarded_amount_sum} ;;
  }
  measure: currency_rewarded_25  {
    type: percentile
    percentile: 25
    sql: ${economy_currency_rewarded_amount_sum} ;;
  }
  measure: currency_rewarded_med  {
    type: median
    sql: ${economy_currency_rewarded_amount_sum} ;;
  }
  measure: currency_rewarded_75  {
    type: percentile
    percentile: 75
    sql: ${economy_currency_rewarded_amount_sum} ;;
  }
  measure: currency_rewarded_975  {
    type: percentile
    percentile: 97.5
    sql: ${economy_currency_rewarded_amount_sum} ;;
  }
  set: detail {
    fields: [economy_rdg_id, economy_card_id, economy_current_card_numbered, economy_reward_type, economy_currency_rewarded_amount_sum]
  }
}
