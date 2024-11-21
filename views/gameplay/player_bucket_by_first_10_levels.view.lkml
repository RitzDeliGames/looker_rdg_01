view: player_bucket_by_first_10_levels {

################################################################
## View SQL
################################################################

  derived_table: {
    sql:

      with

      base_data as (


        select
          rdg_id
          , sum(moves_made) as moves_made
        from
          -- eraser-blast.looker_scratch.6Y_ritz_deli_games_player_round_summary
          --`eraser-blast.looker_scratch.LR_6YUH51731695813779_player_round_summary`
          ${player_round_summary.SQL_TABLE_NAME}
        where
          1=1
          -- and date(rdg_date) = '2024-11-14'
          and date(rdg_date) between '2024-07-23' and '2024-11-14'
          and lower(game_mode) = 'campaign'
          and level_serial between 0 and 10
          and
            ( case
                when
                  date(rdg_date) between '2024-07-23' and '2024-09-09'
                  and safe_cast(json_extract_scalar(experiments,'$.unlosable10_20240710') as string) = 'variant_a'
                then 1
                when
                  date(rdg_date) between '2024-10-01' and date_add(current_date(), interval -1 DAY)
                then 1
                else 0
                end ) = 1
        group by
          1
        having
          max(level_serial) = 10

      )

      select
        *
        , floor(100 * cume_dist() over (order by moves_made )) moves_made_percentile
      from
        base_data

      ;;
    publish_as_db_view: yes
    sql_trigger_value: select date(timestamp_add(current_timestamp(),interval ( (5) + 2 )*( -10 ) minute)) ;;
  }

####################################################################
## Primary Key
####################################################################

  dimension: primary_key {
    type: string
    sql:
    ${TABLE}.rdg_id
    ;;
    primary_key: yes
    hidden: yes
  }

################################################################
## Dimensions
################################################################

  dimension: rdg_id {type: string}
  dimension: moves_made {type:number}
  dimension: moves_made_percentile {type:number}

  parameter: moves_made_percentile_bucket_size {
    type: number
  }

  dimension: moves_made_percentile_bucket {
    type:string
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.moves_made_percentile,{% parameter moves_made_percentile_bucket_size %}))*{% parameter moves_made_percentile_bucket_size %}
      as string
      )
    || ' to '
    ||
    safe_cast(
      ceiling(safe_divide(${TABLE}.moves_made_percentile+1,{% parameter moves_made_percentile_bucket_size %}))*{% parameter moves_made_percentile_bucket_size %}-1
      as string
      )
    ;;
  }

  dimension: moves_made_percentile_bucket_order {
    type:number
    sql:
    safe_cast(
      floor( safe_divide(${TABLE}.moves_made_percentile,{% parameter moves_made_percentile_bucket_size %}))*{% parameter moves_made_percentile_bucket_size %}
      as int64
      )
    ;;
  }

################################################################
## Measures
################################################################

  measure: count_distinct_rdg_id {
    label: "Count Distinct Players"
    type: number
    value_format_name: decimal_0
    sql: count(distinct ${TABLE}.rdg_id) ;;
  }





}