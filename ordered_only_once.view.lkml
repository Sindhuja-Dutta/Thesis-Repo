view: ordered_only_once {
  derived_table: {
    sql: SELECT
        orders.user_id  AS orders_user_id,
        products.product_id  AS products_product_id,
        COUNT(DISTINCT products.product_id ) AS products_count
      FROM instacart_market_basket_analysis.order_products__prior  AS order_products__prior
      LEFT JOIN instacart_market_basket_analysis.products  AS products ON order_products__prior.product_id = products.product_id
      LEFT JOIN instacart_market_basket_analysis.orders  AS orders ON order_products__prior.order_id = orders.order_id

      GROUP BY 1,2
      HAVING
        (COUNT(DISTINCT products.product_id ) = 1)
      ORDER BY 1
       ;;
      persist_for: "24 hour"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: orders_user_id {
    type: number
    sql: ${TABLE}.orders_user_id ;;
  }

  dimension: products_product_id {
    type: number
    sql: ${TABLE}.products_product_id ;;
  }

  dimension: products_count {
    type: number
    sql: ${TABLE}.products_count ;;
  }

measure: count_of_users_ordered_product_once {
  type: count_distinct
  sql: ${orders_user_id} ;;
}

  set: detail {
    fields: [orders_user_id, products_product_id, products_count]
  }
}
