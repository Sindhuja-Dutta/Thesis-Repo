view: order_products__prior {
  sql_table_name: instacart_market_basket_analysis.order_products__prior ;;

  dimension: add_to_cart_order {
    label: "Order in which item was added to cart"
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
    label: "Item reordered or not?"
    type: yesno
    sql: ${TABLE}.reordered=1;;

  }

  measure: count {
    type: count
    drill_fields: [products.product_name,orders.count ]
  }
}
