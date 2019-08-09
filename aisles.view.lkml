view: aisles {
  sql_table_name: instacart_market_basket_analysis.aisles ;;
  drill_fields: [aisle_id]

  dimension: aisle_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.aisle_id ;;
  }

  dimension: aisle {
    type: string
    sql: ${TABLE}.aisle ;;
  }

  measure: count {
    type: count
    drill_fields: [aisle_id, products.count]
  }
}
