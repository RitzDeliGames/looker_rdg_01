view: gogame_data {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- update '2024-09-26'

      with

      base_data as (

        SELECT
          REGISTRATION_DATE
          , AFFILIATE_NAME
          , CAMPAIGN_NAME
          , CAMPAIGN_ID
          , BUSINESS_PARTNER
          , PARTNER_ACCOUNT_ID
          , GAME
          , PLATFORM
          , REAL_COUNTRY
          , COUNTRY_ID
          , COUNTRY_CODE
          , TOTAL_SPEND
          , PARTNER_IMPRESSIONS
          , PARTNER_CLICKS
          , PARTNER_INSTALLS
          , TOTAL_UNIQUE_INSTALLS
          , TOTAL_REGS
          , UAINSTALLS
          , UADEPOSITNET_D0
          , UADEPOSITNET_D3
          , UADEPOSITNET_D7
          , UAADREVENUE_D0
          , UAADREVENUE_D3
          , UAADREVENUE_D7
          , UAREGS_D0
          , UAREGS_D3
          , UAREGS_D7
          , UARETENTION_D1
          , UARETENTION_D3
          , UARETENTION_D7
          , lower(CAMPAIGN_NAME) as campaign
          , publisher
          , publisher_Id

        FROM
          `eraser-blast.bfg_import.gogame_data`

      )

      select
        *
        , @{bfg_campaign_name_mapping} as mapped_campaign_name
      from
        base_data b

      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (1) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
      ${TABLE}.REGISTRATION_DATE
      || '_' || ${TABLE}.AFFILIATE_NAME
      || '_' || ${TABLE}.CAMPAIGN_NAME
      || '_' || ${TABLE}.CAMPAIGN_ID
      || '_' || ${TABLE}.BUSINESS_PARTNER
      || '_' || ${TABLE}.PARTNER_ACCOUNT_ID
      || '_' || ${TABLE}.GAME
      || '_' || ${TABLE}.PLATFORM
      || '_' || ${TABLE}.REAL_COUNTRY
      || '_' || ${TABLE}.COUNTRY_ID
      || '_' || ${TABLE}.COUNTRY_CODE
      || '_' || ${TABLE}.publisher
      || '_' || ${TABLE}.publisher_Id
      ;;
    primary_key: yes
    hidden: yes
  }


####################################################################
## Date Groups
####################################################################

  dimension_group: REGISTRATION_DATE {
    label: "Registration"
    type: time
    timeframes: [date, week, month, year]
    sql: timestamp(${TABLE}.REGISTRATION_DATE) ;;
  }

  measure: earliest_registration_date {
    label: "Earlist Registration Date"
    type: date
    timeframes: [date]
    sql: min(${TABLE}.REGISTRATION_DATE) ;;
  }

####################################################################
## Other Dimensions
####################################################################

  dimension: AFFILIATE_NAME {type: string}
  dimension: CAMPAIGN_NAME   {group_label: "Campaign Mapping" label: "Campaign Name" type: string}
  dimension: Campaign_name_lower  {
    group_label: "Campaign Mapping"
    label: "Campaign Name (Lower)"
    type: string
    sql:
      lower(${TABLE}.CAMPAIGN_NAME)
    ;;}
  dimension: mapped_campaign_name  {group_label: "Campaign Mapping" label: "Campaign Name Mapped" type: string}
  dimension: BUSINESS_PARTNER {type: string}
  dimension: GAME {type: string}
  dimension: PLATFORM {type: string}
  dimension: REAL_COUNTRY {type: string}
  dimension: COUNTRY_ID {type: string}
  dimension: COUNTRY_CODE {type: string}
  dimension: CAMPAIGN_ID  {type: number}
  dimension: PARTNER_ACCOUNT_ID {type: number}
  dimension: TOTAL_REGS {type: number}
  dimension: TOTAL_SPEND  {type: number}
  dimension: PARTNER_IMPRESSIONS  {type: number}
  dimension: PARTNER_CLICKS {type: number}
  dimension: PARTNER_INSTALLS {type: number}
  dimension: TOTAL_UNIQUE_INSTALLS  {type: number}
  dimension: UAINSTALLS {type: number}
  dimension: UADEPOSITNET_D0  {type: number}
  dimension: UADEPOSITNET_D3  {type: number}
  dimension: UADEPOSITNET_D7  {type: number}
  dimension: UAADREVENUE_D0 {type: number}
  dimension: UAADREVENUE_D3 {type: number}
  dimension: UAADREVENUE_D7 {type: number}
  dimension: UAREGS_D0  {type: number}
  dimension: UAREGS_D3  {type: number}
  dimension: UAREGS_D7  {type: number}
  dimension: UARETENTION_D1 {type: number}
  dimension: UARETENTION_D3 {type: number}
  dimension: UARETENTION_D7 {type: number}
  dimension: publisher {type: string}
  dimension: publisher_Id {type: number}


}
