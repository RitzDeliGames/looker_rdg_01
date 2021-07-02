view: facebook_daily_export {
  derived_table: {
    sql: SELECT date,
                country,
                campaign_name,
                campaign_id,
                ad_set_name,
                ad_set_id,
                reach,
                CAST(impressions AS INT64) AS impressions,
                frequency,
                CAST(spend AS FLOAT64) AS spend,
                CAST(installs AS INT64) AS installs,
                timestamp(date) date_time
      FROM `eraser-blast.game_data.facebook_daily_ad_export`
      WHERE campaign_name LIKE "%Android%"
      ORDER BY 1 ASC, 3 DESC ;;
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.date, ' ', ${TABLE}.country, ' ', ${TABLE}.campaign_id, ' ', ${TABLE}.ad_set_id, ' ', ${TABLE}.spend) ;;
  }

  dimension: date {
    type: date
    hidden: yes
  }
  dimension_group: facebook_export {
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.date_time ;;
  }
  dimension: country {}
  dimension: campaign_name {}
  dimension: campaign_id {}
  dimension: ad_set_name {}
  dimension: ad_set_id {}
  dimension: reach {
    type: number
  }
  dimension: impressions {
    type: number
  }
  measure: total_impressions {
    type: sum
    value_format: "#,###"
    sql: ${impressions} ;;
  }
  measure: ipm {
    label: "ipm"
    type: number
    value_format: "#.00"
    sql: ${total_installs}/(${total_impressions}/1000) ;;
  }
  dimension: frequency {}
  dimension: installs {
    type: number
  }
  measure: total_installs {
    type: sum
    value_format: "#,###"
    sql: ${installs} ;;
  }
  dimension: spend {
    type: number
    value_format:"$#.00"
  }
  measure: total_spend {
    label: "Total UA Spend"
    type: sum
    value_format:"$#,###"
    sql: ${spend} ;;
  }
  measure: cpi {
    label: "cpi"
    type: number
    value_format: "$.00"
    sql: ${total_spend}/${total_installs} ;;
  }
}
