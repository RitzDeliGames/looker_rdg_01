view: singular_daily_user_attribution_export {
  derived_table: {
    sql: select
          event_timestamp
          ,etl_record_processing_hour_utc
          ,device_id
          ,device_id_type
          ,platform hardware
          ,app_version
          ,country
          ,singular_partner_name
          ,campaign_id
          ,campaign_name
          ,creative_id
          ,creative_name
        from `eraser-blast.singular.user_level_attributions`
        where date(event_timestamp) >= '2021-06-01'
        ;;
    datagroup_trigger: change_6_hrs
    publish_as_db_view: yes
    partition_keys: ["etl_record_processing_hour_utc"]
    }

  dimension: primary_key {
    type: string
    primary_key: yes
    sql: cast(format_date("%Y%m%d",${event_timestamp_date}) as string) || '_' || ${device_id} ;;
    hidden: yes
  }
  dimension_group: event_timestamp {
    type: time
    timeframes: [
      date,
      hour_of_day,
      month,
      quarter,
      year
    ]
  }
  dimension: device_id {
    label: "Advertising ID"
    type: string
  }
  measure: players {
    label: "Count of Players"
    type: count_distinct
    sql: ${device_id} ;;
    drill_fields: [device_id,platform,singular_partner_name,campaign_name,creative_name]
  }
  dimension: device_id_type {}
  dimension: platform {
    label: "Device Platform"
    type: string
    sql: @{device_platform_mapping} ;;
  }
  dimension: version {
    label: "Minor Release Version"
    type: number
    sql: ${TABLE}.app_version ;;
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
  dimension: singular_partner_name {
    label: "Ad Network"
  }
  dimension: campaign_id {}
  dimension: campaign_name {
    label: "Campaign Name - Long"
  }
  dimension: campaign_name_clean {
    label: "Campaign Name - Short"
    sql: @{campaign_name_clean} ;;
  }
  dimension: creative_name {
  label: "Creative Name - Long"
  }
  dimension: creative_name_short {
    label: "Creative Name - Short"
    sql: @{creative_name_clean} ;;
  }
 }
