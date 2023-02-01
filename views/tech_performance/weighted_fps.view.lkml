view: weighted_fps {
  derived_table: {
    sql: select
          weighted_fps.install_version
          ,weighted_fps.rdg_id
          ,weighted_fps.last_level_serial
          ,sum(weighted_fps.weighted_avg) weighted_avg
      from
          (select
              fps.*
              ,fps_sum.fps_frame_count_sum
              ,ms_per_frame * (fps.fps_frame_count_sum / fps_sum.fps_frame_count_sum) weighted_avg
          from
              (select
                  fps.rdg_id
                  ,fps.last_level_serial
                  ,fps.ms_per_frame
                  ,user_fact.install_version
                  ,coalesce(sum(fps.frame_count ), 0) fps_frame_count_sum
              from `eraser-blast.looker_scratch.6Y_ritz_deli_games_fps` fps
              left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_fact` user_fact
                  on fps.rdg_id = user_fact.rdg_id
              where fps.event_name = 'round_end'
              group by 1,2,3,4
              order by 3) fps
          left join
              (select
                  fps.rdg_id
                  ,fps.last_level_serial
                  ,user_fact.install_version
                  ,COALESCE(SUM(fps.frame_count ), 0) fps_frame_count_sum
              from `eraser-blast.looker_scratch.6Y_ritz_deli_games_fps` AS fps
              left join `eraser-blast.looker_scratch.6Y_ritz_deli_games_user_fact` as user_fact
                  on fps.rdg_id = user_fact.rdg_id
              where fps.event_name = 'round_end'
              group by 1,2,3) fps_sum
          on fps.rdg_id = fps_sum.rdg_id
              and fps.last_level_serial = fps_sum.last_level_serial
              and fps.install_version = fps_sum.install_version
          order by last_level_serial asc, fps.ms_per_frame asc) weighted_fps
      group by 1,2,3
      order by 1,2,3
       ;;
  }

  dimension: rdg_id {
    type: string
    sql: ${TABLE}.rdg_id ;;
  }
  dimension: install_version {
    type: string
    sql: ${TABLE}.install_version ;;
  }
  dimension: last_level_serial {
    group_label: "Level Dimensions"
    label: "Last Level Completed"
    type: number
    sql: ${TABLE}.last_level_serial ;;
  }
  dimension: last_level_serial_offset {
    group_label: "Level Dimensions"
    label: "Current Level"
    type: number
    sql: ${last_level_serial} + 1 ;;
  }
  dimension: weighted_avg {
    label: "Weighted Avg. MS/Frame"
    type: number
    sql: ${TABLE}.weighted_avg ;;
  }
  measure: weighted_avg_025 {
    group_label: "Weighted Avg MS/Frame"
    label: "Weighted Avg MS/Frame - 2.5%"
    type: percentile
    percentile: 2.5
    value_format: "#.#"
    sql: ${weighted_avg} ;;
  }
  measure: weighted_avg_25 {
    group_label: "Weighted Avg MS/Frame"
    label: "Weighted Avg MS/Frame - 25%"
    type: percentile
    percentile: 25
    value_format: "#.#"
    sql: ${weighted_avg} ;;
  }
  measure: weighted_avg_med {
    group_label: "Weighted Avg MS/Frame"
    label: "Weighted Avg MS/Frame - Median"
    type: median
    value_format: "#.#"
    sql: ${weighted_avg} ;;
  }
  measure: weighted_avg_75 {
    group_label: "Weighted Avg MS/Frame"
    label: "Weighted Avg MS/Frame - 75%"
    type: percentile
    percentile: 75
    value_format: "#.#"
    sql: ${weighted_avg} ;;
  }
  measure: weighted_avg_975 {
    group_label: "Weighted Avg MS/Frame"
    label: "Weighted Avg MS/Frame - 97.5%"
    type: percentile
    percentile: 97.5
    value_format: "#.#"
    sql: ${weighted_avg} ;;
  }
  set: detail {
    fields: [install_version, rdg_id, last_level_serial, weighted_avg]
  }
}
