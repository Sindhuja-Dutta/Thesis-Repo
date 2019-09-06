view: orders {
  sql_table_name: instacart_market_basket_analysis.orders ;;
  drill_fields: [order_id]

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: days_since_prior_order {
    type: number
    sql: ${TABLE}.days_since_prior_order ;;
  }

  dimension: eval_set {
    type: string
    sql: ${TABLE}.eval_set ;;
  }

  dimension: order_dow {
    type: number
    sql: ${TABLE}.order_dow ;;
  }

  dimension: order_hour_of_day {
    type: number
    sql: ${TABLE}.order_hour_of_day ;;
  }

  dimension: order_number {
    type: number
    sql: ${TABLE}.order_number ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: visit_time {
    case: {
      when: {
        sql: ${order_hour_of_day} < 6;;
        label: "Midnight"
      }
      when: {
        sql:  ${order_hour_of_day} < 12;;
        label: "Morning"
      }
      when: {
        sql: ${order_hour_of_day} < 18;;
        label: "Noon"
      }
      else:"Night"
    }
  }

  measure: count {
    type: count
    drill_fields: [order_id, order_products__train.count, order_products__prior.count]
  }
}
