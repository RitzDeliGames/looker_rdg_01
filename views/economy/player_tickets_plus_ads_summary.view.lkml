view: player_tickets_plus_ads_summary {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      -- ccb_aggregate_update_tag
      -- last update: '2024-05-17'

      with

      ------------------------------------------------------------------------
      -- tickets information
      ------------------------------------------------------------------------

      tickets_spend_table as (

        select
          -- unique fields
          rdg_id
          , rdg_date
          , ad_placement

          -- max fields
          , max(created_date) as created_date
          , max(days_since_created) as days_since_created
          , max(day_number) as day_number
          , max(safe_cast(version as numeric)) as version_number
          , max(experiments) as experiments
          , max(coins_balance) as coins_balance
          , max(lives_balance) as lives_balance
          , max(stars_balance) as stars_balance
          , max(last_level_serial) as last_level_serial

          -- sum fields
          , sum(0) as ad_views
          , sum(tickets_spend) as tickets_spend

        from
          ${player_ticket_spend_summary.SQL_TABLE_NAME}

        group by
          1,2,3

      )

      ------------------------------------------------------------------------
      -- ads information
      ------------------------------------------------------------------------

      , ad_view_table as (

        select
          -- unique fields
          rdg_id
          , rdg_date
          , ad_placement

          -- max fields
          , max(created_date) as created_date
          , max(days_since_created) as days_since_created
          , max(day_number) as day_number
          , max(safe_cast(version as numeric)) as version_number
          , max(experiments) as experiments
          , max(coins_balance) as coins_balance
          , max(lives_balance) as lives_balance
          , max(stars_balance) as stars_balance
          , max(current_level_serial) as last_level_serial

          -- sum fields
          , sum(count_ad_views) as ad_views
          , sum(0) as tickets_spend

        from
          ${player_ad_view_summary.SQL_TABLE_NAME}
        group by
          1,2,3

      )

      ------------------------------------------------------------------------
      -- combine tables
      ------------------------------------------------------------------------

      , my_combined_tables as (

        select * from tickets_spend_table
        union all
        select * from ad_view_table

      )

      ------------------------------------------------------------------------
      -- summarize tables
      ------------------------------------------------------------------------

      , my_summarize_tables as (

        select
          -- unique fields
          rdg_id
          , rdg_date
          , ad_placement

          -- max fields
          , max(created_date) as created_date
          , max(days_since_created) as days_since_created
          , max(day_number) as day_number
          , max(version_number) as version_number
          , max(experiments) as experiments
          , max(coins_balance) as coins_balance
          , max(lives_balance) as lives_balance
          , max(stars_balance) as stars_balance
          , max(last_level_serial) as last_level_serial

          -- sum fields
          , sum(ad_views) as ad_views
          , sum(tickets_spend) as tickets_spend

        from
          my_combined_tables
        group by
          1,2,3

      )

      select * from my_summarize_tables


      ;;
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
    publish_as_db_view: yes
    partition_keys: ["rdg_date"]

  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    || '_' || ${TABLE}.rdg_date
    || '_' || ${TABLE}.ad_placement
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Parameters
################################################################

  parameter: selected_experiment {
    type: string
    default_value:  "$.No_AB_Test_Split"
  }


################################################################
## Dimensions
################################################################

  dimension: rdg_id { type:string }

  dimension_group: rdg_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.rdg_date ;;
  }

  dimension: ad_placement { type:string }

  dimension_group: created_date {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.created_date ;;
  }

  dimension: days_since_created {type:number}

  dimension: day_number {type:number}

  dimension: version_number {type:number}

  dimension: experiments { type:string }

  dimension: last_level_serial {
    type: number
    label: "Highest Level Serial"
    sql: ${TABLE}.last_level_serial ;;
  }

  dimension: coins_balance {type:number}

  dimension: lives_balance {type:number}

  dimension: stars_balance {type:number}

  dimension: experiment_variant {
    type: string
    sql:
    safe_cast(
        json_extract_scalar(${TABLE}.experiments,{% parameter selected_experiment %})
        as string)
    ;;
  }

################################################################
## Measures
################################################################

  measure: count_distinct_users {
    type: count_distinct
    sql: ${TABLE}.rdg_id ;;
  }

  measure: sum_ad_views {
    type: sum
    sql: ${TABLE}.ad_views;;
    value_format_name: decimal_0
    }

  measure: sum_tickets_spend {
    type: sum
    sql: ${TABLE}.tickets_spend;;
    value_format_name: decimal_0
    }

  measure: ticket_spend_per_dau_spending_tickets_or_viewing_ads {
    label: "Ticket Spend Per DAU Spending Tickets or Viewing Ads"
    type: number
    sql:
      safe_divide(
        sum(${TABLE}.tickets_spend)
        , sum(1)
        )
    ;;
    value_format_name:  decimal_1

  }

  measure: ad_views_per_dau_spending_tickets_or_viewing_ads {
    label: "Ad Views Per DAU Spending Tickets or Viewing Ads"
    type: number
    sql:
    safe_divide(
      sum(${TABLE}.ad_views)
      , sum(1)
      )
    ;;
    value_format_name:  decimal_1
  }

}
