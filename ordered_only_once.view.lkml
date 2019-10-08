view: ordered_only_once {
  derived_table: {
    sql: SELECT
  orders.user_id  AS orders_user_id,
  products.product_name  AS products_product_name,
  COUNT(DISTINCT orders.order_id) AS orders_count
FROM instacart_market_basket_analysis.order_products__prior  AS order_products__prior
LEFT JOIN instacart_market_basket_analysis.products  AS products ON order_products__prior.product_id = products.product_id
LEFT JOIN instacart_market_basket_analysis.orders  AS orders ON order_products__prior.order_id = orders.order_id

GROUP BY 1,2
HAVING
  (COUNT(DISTINCT orders.order_id) = 1)
ORDER BY 1;;
      persist_for: "24 hour"
  }

  dimension: orders_user_id {
    label: "User ID"
    type: number
    sql: ${TABLE}.orders_user_id ;;
  }

  dimension: products_product_name {
    label: "Product Name"
    type: string
    sql: ${TABLE}.products_product_name ;;
  }

  dimension: orders_count {
    label: "Count of Orders"
    type: number
    sql: ${TABLE}.orders_count ;;
  }

measure: count_of_users_ordered_product_once {
  label: "Count of users who ordered product once"
  drill_fields: [detail*]
  type: count_distinct
  sql: ${orders_user_id} ;;
}

  set: detail {
    fields: [orders_user_id, products_product_name, orders_count]
  }
}
