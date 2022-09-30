view: firebase_analytics {
  derived_table: {
    sql: select distinct
                user_pseudo_id,
                event_name,
                event_date,
                event_timestamp,
                event_previous_timestamp,
                event_value_in_usd,
                event_bundle_sequence_id,
                event_server_timestamp_offset,
                user_id,
                user_first_touch_timestamp,
                stream_id,
                platform
          from `eraser-blast.analytics_215101505.events_*`
         where _TABLE_SUFFIX between FORMAT_DATE('%Y%m%d',{% date_start date_filter %}) and FORMAT_DATE('%Y%m%d',{% date_end date_filter %}) ;;
  }

  ### FILTERS ###

  filter: date_filter {
    description: "Choose a date range to query multiple partitioned Firebase tables as needed"
    type: date
  }

  ### PRIMARY KEY ###

  dimension: primary_key {
    hidden: yes
    type: string
    primary_key: yes
    sql: ${user_pseudo_id} || ${event_name} || ${event_timestamp} ;;
  }

  ### DIMENSIONS ###

  dimension: days_since_created {
    type: number
    sql: round(cast((${event_timestamp}/(86400000000)) - (${user_first_touch_timestamp}/(86400000000)) as int64),0) ;;
  }

  dimension_group: event {
    description: "The date on which the event was logged (in the registered timezone of your app)."
    type: time
    can_filter: no
    sql: PARSE_DATE('%Y%m%d',cast(${TABLE}.event_date as string)) ;;
  }

  dimension: event_bundle_sequence_id {
    description: "The sequential ID of the bundle in which these events were uploaded."
    type: string
    sql: ${TABLE}.event_bundle_sequence_id ;;
  }
  dimension: event_name {
    description: "The name of the event"
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: event_previous_timestamp {
    description: "TThe time (in microseconds, UTC) at which the event was previously logged on the client."
    type: string
    sql: ${TABLE}.event_previous_timestamp ;;
  }

  dimension: event_server_timestamp_offset {
    description: "Timestamp offset between collection time and upload time in micros."
    type: string
    sql: ${TABLE}.event_server_timestamp_offset ;;
  }

  dimension: event_timestamp {
    description: "The time (in microseconds, UTC) at which the event was logged on the client."
    type: number
    sql: ${TABLE}.event_timestamp ;;
    can_filter: no
  }

  dimension: event_value_in_usd {
    description: "The currency-converted value (in USD) of the event's \"value\" parameter."
    type: string
    sql: ${TABLE}.event_value_in_usd ;;
  }

  dimension: platform {
    description: "The platform on which the app was built."
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: stream_id {
    description: "The numeric ID of the stream."
    type: string
    sql: ${TABLE}.stream_id ;;
  }

  dimension: user_first_touch_timestamp {
    description: "The time (in microseconds) at which the user first opened the app or visited the site."
    type: number
    sql: ${TABLE}.user_first_touch_timestamp ;;
  }

  dimension_group: created_at {
    type: time
    sql: cast(${TABLE}.user_first_touch_timestamp/1000000 as int64) ;;
    datatype: epoch
  }

  dimension: retention_days_cohort {
    type: string
    sql: 'D' || cast((${days_since_created} + 1) as string) ;;
    order_by_field: days_since_created
  }

  dimension: user_id {
    description: "The user ID set via the setUserId API."
    type: string
    sql:${TABLE}.user_id ;;
  }

  dimension: user_pseudo_id {
    description: "The pseudonymous id (e.g., app instance ID) for the user."
    type: string
    sql: ${TABLE}.user_pseudo_id ;;
  }

  ### MEASURES ###

  measure: count {
    hidden: yes
    description: "Count of Rows"
    type: count
  }

  measure: total_firebase_users {
    description: "Distinct count of User Pseudo IDs"
    type: count_distinct
    sql: ${user_pseudo_id} ;;
  }

  measure: total_user_ids {
    description: "Distinct count of User IDs"
    type: count_distinct
    sql: ${user_id} ;;
  }

  measure: total_value_in_usd {
    description: "Sum of Event Value In USD"
    type: sum
    sql: ${event_value_in_usd} ;;
  }

  #### DEVICES JSON #####

  # dimension: mobile_model_name {
  #   group_label: "Devices"
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.mobile_model_name') ;;
  # }

  # dimension: is_limited_ad_tracking {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.is_limited_ad_tracking') ;;
  # }

  # dimension: advertising_id {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.advertising_id') ;;
  # }

  # dimension: language {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.language') ;;
  # }

  # dimension: mobile_brand_name {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.mobile_brand_name') ;;
  # }

  # dimension: web_info {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.web_info') ;;
  # }

  # dimension: mobile_os_hardware_model {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.mobile_os_hardware_model') ;;
  # }

  # dimension: operating_system {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.operating_system') ;;
  # }

  # dimension: mobile_marketing_name {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.mobile_marketing_name') ;;
  # }

  # dimension: browser_version {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.browser_version') ;;
  # }

  # dimension: category {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.category') ;;
  # }

  # dimension: time_zone_offset_seconds {
  #   group_label: "Devices"
  #   type: string
  #   sql: json_extract_scalar(to_json(${TABLE}.device), '$.time_zone_offset_seconds') ;;
  # }

  ### DEVICES END #######
}
