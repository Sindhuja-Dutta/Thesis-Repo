view: ordered_after_first_time {
  derived_table: {
sql:SELECT
  orders.user_id  AS orders_user_id,
  products.product_name  AS products_product_name,
  COUNT(DISTINCT orders.order_id) AS orders_count
FROM instacart_market_basket_analysis.order_products__prior  AS order_products__prior
LEFT JOIN instacart_market_basket_analysis.products  AS products ON order_products__prior.product_id = products.product_id
LEFT JOIN instacart_market_basket_analysis.orders  AS orders ON order_products__prior.order_id = orders.order_id

GROUP BY 1,2
HAVING
  (COUNT(DISTINCT orders.order_id) >= 2)
ORDER BY 1;;
}

  dimension: orders_user_id_reorder {
    label: "User ID"
    type: number
    sql: ${TABLE}.orders_user_id ;;
  }

  dimension: products_product_name_reorder {
    label: "Product Name"
    type: string
    sql: ${TABLE}.products_product_name ;;
  }

  dimension: orders_count_reorder {
    label: "Count of Orders"
    type: number
    sql: ${TABLE}.orders_count ;;
  }

  measure: count_of_users_ordered_product_after_first_time {
    label: "Count of users who ordered product after first time"
    drill_fields: [detail*]
    type: count_distinct
    sql: ${orders_user_id_reorder} ;;
  }

  set: detail {
    fields: [orders_user_id_reorder, products_product_name_reorder, orders_count_reorder]
  }
}
