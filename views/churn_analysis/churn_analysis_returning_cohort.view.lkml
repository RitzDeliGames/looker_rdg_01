# If necessary, uncomment the line below to include explore_source.
# include: "rdg.model.lkml"

view: churn_analysis_returning_cohort {
  derived_table: {
    explore_source: churn_analysis_install_cohort {
      column: count_unique_person_id {}
      column: player_id {}
      filters: {
        field: churn_analysis_install_cohort.user_first_seen_date
        value: "2020/10/09"
      }
      filters: {
        field: churn_analysis_install_cohort.consecutive_days
        value: ">=1"
      }
    }
  }
  dimension: count_unique_person_id {
    label: "Churn Analysis Install Cohort Count of Unique Players"
    type: number
  }
  dimension: player_id {}
}
