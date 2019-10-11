view: order_probability {
  derived_table: {
    sql: SELECT
  orders.user_id  AS orders_user_id,
  COUNT(DISTINCT orders.order_id) AS orders_count
FROM instacart_market_basket_analysis.order_products__prior  AS order_products__prior
LEFT JOIN instacart_market_basket_analysis.orders  AS orders ON order_products__prior.order_id = orders.order_id

GROUP BY 1
ORDER BY 1;;
      persist_for: "24 hour"
  }

  dimension: orders_user_id {
    label: "User ID"
    type: number
    sql: ${TABLE}.orders_user_id ;;
  }

dimension: orders_count   {
  label: "Count of Orders"
  type: number
  sql: ${TABLE}.orders_count ;;
}

dimension: more_than_once {
  label: "More than one order"
  type: yesno
  sql: ${orders_count} >= 2 ;;
}

  set: detail {
    fields: [orders_user_id, orders_count]
  }
}
