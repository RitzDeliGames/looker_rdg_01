view: big_query_cost_log_incremental {
#   # # You can specify the table name if it's different from the view name:
#   derived_table: {
#     sql:

#       -- ccb_aggregate_update_tag
#       -- update '2024-02-23'

#       select
#         timestamp(date(timestamp)) as rdg_date
#         , timestamp as timestamp_utc
#         , `project` as project
#         , principalEmail
#         , query
#         , sum(gigabytes) as gigabytes
#         , sum(dollars) as dollars
#         , sum(safe_cast(totalBilledBytes as bigint)) as totalBilledBytes
#       from
#         `eraser-blast.bq_cost.costly-query-log`
#       where
#         ------------------------------------------------------------------------
#         -- Date selection
#         -- We use this because the FIRST time we run this query we want all the data going back
#         -- but future runs we only want the last 9 days
#         ------------------------------------------------------------------------

#         date(timestamp) >=
#             case
#                 -- select date(current_date())
#                 when date(current_date()) <= '2024-02-23' -- Last Full Update
#                 then '2022-06-01'
#                 else date_add(current_date(), interval -9 day)
#                 end
#         and date(timestamp) <= date_add(current_date(), interval -1 DAY)
#       group by
#         1,2,3,4,5

#       ;;
#     ## sql_trigger_value: select date(timestamp_add(current_timestamp(),interval -1 hour)) ;;
#     sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (1) + 2 )*( -10 ) minute)) ;;

#     publish_as_db_view: yes
#     partition_keys: ["rdg_date"]
#     increment_key: "rdg_date"
#     increment_offset: 7

#   }

# ####################################################################
# ## Primary Key
# ####################################################################

#   dimension: primary_key {
#     type: string
#     sql:
#     ${TABLE}.rdg_date
#     || '_' || ${TABLE}.timestamp_utc
#     || '_' || ${TABLE}.project
#     || '_' || ${TABLE}.principalEmail
#     || '_' || ${TABLE}.query


#     ;;
#     primary_key: yes
#     hidden: yes
#   }

# ####################################################################
# ## Dimensions
# ####################################################################

#   dimension_group: rdg_date_analysis {
#     description: "date as defined by rdg_date function"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.rdg_date ;;
#   }

#   dimension: rdg_date {
#     type: date
#   }

# ####################################################################
# ## Measures
# ####################################################################

#   measure: dollars {
#     label: "Dollars Billed"
#     type: number
#     sql: sum(${TABLE}.dollars) ;;
#     value_format_name: usd
#   }



}
