view: hour_of_day {
derived_table: {
    sql: select orders.hour_of_day from orders where  (select min(orders_count) from (
    SELECT orders.order_hour_of_day AS orders_order_hour_of_day,
  COUNT(DISTINCT orders.order_id ) AS orders_count
FROM instacart_market_basket_analysis.order_products__prior  AS order_products__prior
LEFT JOIN instacart_market_basket_analysis.orders  AS orders ON order_products__prior.order_id = orders.order_id

GROUP BY 1
ORDER BY 2 DESC
LIMIT 500) ) ;;

}

  dimension: hour_of_day {
    type: number
  }

#   dimension: orders_count {
#     type: number
#   }

}
