view: singular_daily_agg_export {
  derived_table: {
    sql:
        with country_code_helper as (
          select
            Country country_name
            ,Alpha_2_code country
            ,Alpha_3_code
          from `eraser-blast.singular.country_codes`
          ),
        singular_export as (
          select
            date
            ,source
            ,platform
            ,country_field
            ,adn_campaign_name campaign_name
            ,adn_campaign_id campaign_id
            ,adn_sub_campaign_name ad_set_name
            ,adn_sub_campaign_id ad_set_id
            ,cast(adn_impressions as int64) impressions
            ,cast(adn_cost as float64) AS spend
            ,cast(adn_original_cost as float64) AS original_spend
            ,cast(adn_installs AS int64) AS installs
            ,timestamp(date) date_time --is this still needed if we are importing from Singular rather than FB?
          from `eraser-blast.singular.marketing_data`)
        select country_code_helper.*, singular_export.*
        from singular_export
        join country_code_helper
        on singular_export.country_field = country_code_helper.Alpha_3_code
          ;;
      datagroup_trigger: change_6_hrs
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
  dimension_group: facebook_export { #is this still needed if we are importing from Singular rather than FB?
    label: "Date"
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.date_time ;;
  }
  dimension: source {
    label: "Ad Network"
  }
  dimension: platform {
    label: "Device Platform"
    type: string
    sql: @{device_platform_mapping} ;;
  }
  dimension: country {
    group_label: "Geographic Targeting"
  }
  dimension: region {
    group_label: "Geographic Targeting"
    label: "Device Region"
    type: string
    sql: @{country_region} ;;
  }
  dimension: campaign_id {}
  dimension: campaign_name {
    label: "Campaign Name - Long"
  }
  # dimension: campaign_name_clean {
  #   label: "Campaign Name - Short"
  #   sql: @{campaign_name_clean} ;;
  # }
  dimension: ad_set_name {}
  dimension: ad_set_id {}
  dimension: impressions {
    type: number
  }
  measure: total_impressions {
    type: sum
    value_format: "#,###"
    sql: ${impressions} ;;
  }
  measure: ipm {
    label: "IPM"
    type: number
    value_format: "#.00"
    sql: safe_divide(${total_installs},(${total_impressions}/1000)) ;;
  }
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
  dimension: original_spend {
    type: number
    value_format:"$#.00"
  }
  measure: total_spend {
    label: "Total UA Spend"
    type: sum
    value_format:"$#,###"
    sql: ${spend} ;;
  }
  measure: total_original_spend {
    label: "Total Original Spend"
    type: sum
    value_format:"$#,###"
    sql: ${original_spend} ;;
  }
  measure: cpi {
    label: "CPI"
    type: number
    value_format: "$#.00"
    sql: safe_divide(${total_spend},${total_installs}) ;;
  }
  measure: ecpi {
    label: "eCPI"
    type: number
    value_format: "$#.00"
    sql: safe_divide(${total_original_spend},${total_installs}) ;;
  }
}
