view: order_products__train {
  sql_table_name: instacart_market_basket_analysis.order_products__train ;;

  dimension: add_to_cart_order {
    type: number
    sql: ${TABLE}.add_to_cart_order ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension: reordered {
    type: yesno
    sql: ${TABLE}.reordered ;;
  }

  measure: count {
    type: count
    drill_fields: [products.product_id, products.product_name, orders.order_id]
  }
}
