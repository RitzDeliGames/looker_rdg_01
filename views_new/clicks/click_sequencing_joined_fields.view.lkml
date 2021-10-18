view: click_sequence_joined_fields {
  dimension: sequence_after_first {
    hidden: yes
    type: number
    sql: ${next_in_sequence.click_sequence_num} - ${click_sequence.click_sequence_num} ;;
  }
  }
