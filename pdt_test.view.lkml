

view: pdt_test {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
  products.product_name  AS products_product_name,
  COUNT(DISTINCT orders.order_id ) AS orders_count,
  RANK() OVER ( PARTITION BY products.product_name ORDER BY COUNT(DISTINCT orders.order_id ) DESC) as rank
FROM instacart_market_basket_analysis.order_products__prior  AS order_products__prior
LEFT JOIN instacart_market_basket_analysis.products  AS products ON order_products__prior.product_id = products.product_id
LEFT JOIN instacart_market_basket_analysis.orders  AS orders ON order_products__prior.order_id = orders.order_id

GROUP BY 1
ORDER BY 2 ASC
LIMIT 500

      ;;
  }

  # Define your dimensions and measures here, like this:
  dimension: user_id {
    description: "Unique ID for each user that has ordered"
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_orders {
    description: "The total number of orders for each user"
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension_group: most_recent_purchase {
    description: "The date when each user last ordered"
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.most_recent_purchase_at ;;
  }

  measure: total_lifetime_orders {
    description: "Use this for counting lifetime orders across many users"
    type: sum
    sql: ${lifetime_orders} ;;
  }
}
