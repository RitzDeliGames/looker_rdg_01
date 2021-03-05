view: test_retention {
  derived_table: {
    sql:
with stg as (
  select
    timestamp_trunc(uf.created_at, day) signup_day,
    timestamp_trunc(e.timestamp, day) activity_day,
    count(distinct uf.device_id) user_count
  from (
    select
      device_id,
      min(created_at) created_at
    from `eraser-blast.game_data.events`
    where timestamp >= '2021-02-01'
    and timestamp < '2021-02-17'
    group by 1
  ) uf
  inner join `eraser-blast.game_data.events` e
    on uf.device_id = e.device_id
    and e.timestamp >= '2021-02-01'
    and e.timestamp < '2021-02-17'
    and e.user_type = 'external'
    and uf.created_at < e.timestamp
  where uf.created_at >= '2021-02-10'
  and uf.created_at < '2021-02-17'
  group by 1,2
)
select
  s1.signup_day,
  s1.activity_day,
  date_diff(date(s1.activity_day),date(s1.signup_day),day) activity_day_num,
  s1.user_count active_user_cnt,
  s2.user_count cohort_user_cnt
from stg s1
inner join (
  select signup_day, user_count
  from stg
  where signup_day = activity_day
) s2
  on s1.signup_day = s2.signup_day
    ;;
  }
  dimension_group: signup_day {
    type: time
    intervals: [
      day,
      week
    ]
  }
  dimension_group: activity_day {
    type: time
    intervals: [
      day,
      week
    ]
  }
  dimension: activity_day_num {
    type: number
  }
  measure: active_user_cnt {
    type: sum
  }
  measure: cohort_user_cnt {
    type: sum
  }
  measure: pct_retained {
    type: number
    sql: round(((${active_user_cnt} / ${cohort_user_cnt}) * 100), 2) ;;
  }
}
