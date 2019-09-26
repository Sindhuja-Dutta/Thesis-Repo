view: orders {
  sql_table_name: instacart_market_basket_analysis.orders ;;
  drill_fields: [order_id]

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: days_since_prior_order {
    label: "Number of days since prior order"
    type: number
    sql: ${TABLE}.days_since_prior_order ;;
  }

  dimension: eval_set {
    type: string
    sql: ${TABLE}.eval_set ;;
  }

  dimension: order_dow {
    label: "Day of Week"
    type: number
    sql: ${TABLE}.order_dow ;;
  }

  dimension: order_hour_of_day {
    label: "Hour of Day"
    type: number
    sql: ${TABLE}.order_hour_of_day ;;
  }

  dimension: order_number {
    label: "Order number for each user"
    type: number
    sql: ${TABLE}.order_number ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: visit_time {
    label: "Time of visit during day"
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

measure: count_of_first_test {
  label: "Count of First Time Orders"
  type: count_distinct
  sql: ${order_id} ;;
  filters: {
    field: products.product_name
    value: "Banana"
  }
  filters: {
    field: order_number
    value: "1"
  }
}

  measure: count_of_reordered {
    label: "Count of orders after First Time"
    type: count_distinct
    sql: ${order_id} ;;
    filters: {
      field: products.product_name
      value: "Banana"
    }
    filters: {
      field: order_number
      value: "-1"
    }
  }

 measure: count_of_users {
  type: count_distinct
   label: "Count of Users"
  sql: ${user_id} ;;
  drill_fields: [user_id, order_products__train.count, order_products__prior.count]
 }

  measure: count {
    type: count
    drill_fields: [order_id, order_products__train.count, order_products__prior.count]
  }
}
