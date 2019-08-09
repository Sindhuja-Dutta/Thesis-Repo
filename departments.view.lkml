view: departments {
  sql_table_name: instacart_market_basket_analysis.departments ;;
  drill_fields: [department_id]

  dimension: department_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.department_id ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  measure: count {
    type: count
    drill_fields: [department_id, products.count]
  }
}
