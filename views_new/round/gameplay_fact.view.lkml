# If necessary, uncomment the line below to include explore_source.
# include: "ritz_deli_games.model.lkml"

# Link to original explore:
# https://ritzdeligames.looker.com/explore/ritz_deli_games/gameplay?qid=BKN63Xqngl9ffcjHsSUwNx

#

view: gameplay_fact {
  derived_table: {
    explore_source: gameplay {
      column: rdg_id {}
      column: round_id {}
      column: event_time {}
      derived_column: greater_round_id {
        sql: LAG(round_id)
    OVER (PARTITION BY rdg_id ORDER BY round_id DESC) ;;
      }
    }
  }
  dimension: pk {
    description: "A compound primary key to uniquely identify each row in the table"
    primary_key: yes
    hidden: yes
    type: string
    sql: ${rdg_id} || '_' || ${round_id} ;;
  }
  dimension: greater_round_id {
    description: "The next round_id for the player in sequence"
    type: number
  }
  dimension: rdg_id {
    description: "Unique identifier of a player in the game"
    type: string
  }
  dimension: round_id {
    description: "Incremented value that increases each time a player plays the game"
    type: number
  }
  dimension: event_time {
    description: "Timestamp of the play"
    type: date_time
  }
  dimension: is_churn {
    description: "Identifies if a greater_round_id exists for the rdg_id (player), if the greater_round_id is NULL, they did not play again and are considered churned"
    type: yesno
    sql: ${greater_round_id} is NULL ;;
  }
  measure: count {
    description: "A count of gameplays found for the player (there are round_ids missing from the data, so this calculates only the round_ids that exist)"
    label: "Count Gameplays"
    drill_fields: [detail*]
    type: count
  }
  set: detail {
    fields: [
      rdg_id,
      round_id,
      greater_round_id,
      event_time,
      is_churn,
      count
    ]
  }
}
