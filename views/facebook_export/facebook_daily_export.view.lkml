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
                CAST(installs AS INT64) AS installs
      FROM `eraser-blast.game_data.facebook_daily_ad_export`
      WHERE campaign_name LIKE "%Android%"
      ORDER BY 1 ASC, 3 DESC ;;
  }

  dimension: compound_primary_key {
    primary_key: yes
    hidden: yes
    type: string
    sql: CONCAT(${TABLE}.date, ' ', ${TABLE}.country, ' ', ${TABLE}.campaign_id) ;;
  }

  dimension: date {
    type: date
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
    type: sum
    value_format:"$#.00"
    sql: ${spend} ;;
  }
  measure: cpi {
    label: "cpi"
    type: number
    value_format: "$.00"
    sql: ${total_spend}/${total_installs} ;;
  }
}
