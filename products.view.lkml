view: products {
  sql_table_name: instacart_market_basket_analysis.products ;;
  drill_fields: [product_id]

  dimension: product_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: aisle_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.aisle_id ;;
  }

  dimension: department_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.department_id ;;
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: is_organic {
    type: yesno
    sql: ${product_name} LIKE '%Organic%' ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      product_id,
      product_name,
      departments.department_id,
      aisles.aisle_id,
      order_products__train.count,
      order_products__prior.count
    ]
  }
}
