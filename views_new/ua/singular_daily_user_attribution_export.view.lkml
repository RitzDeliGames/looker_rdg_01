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
        ;;
    datagroup_trigger: change_3_hrs
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
  dimension: campaign_name {}
  dimension: creative_name {}
 }
