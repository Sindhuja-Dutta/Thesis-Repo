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

  dimension: is_asian {
    type: yesno
    sql: ${product_name} LIKE '%Asian%' ;;
  }

  dimension: is_gluten_free {
    type: yesno
    sql: ${product_name} LIKE '%Gluten%' ;;
  }

  measure: count {
    type: count
    link: { label: "Go to Product Details Dashboard" url: "/dashboards/431" }
  }

  measure: count_of_organic{
    type: count
    drill_fields: [detail*]
    filters: {
      field: is_organic
      value: "yes"
    }
    }

  measure: percent_of_organic {
    type: number
    drill_fields: [detail*]
    sql: (${count_of_organic}/${count}) ;;
    value_format_name: "percent_1"
  }

  measure: count_of_asian_food{
    type: count
    drill_fields: [detail*]
    filters: {
      field: is_asian
      value: "yes"
    }
  }

  measure: percent_of_asian_food {
    type: number
    drill_fields: [detail*]
    sql: (${count_of_asian_food}/${count})*100 ;;
    value_format: "0.00\%"

  }

  #measure: average_products {
   # type: average
  #  sql:  ${TABLE}. ;;
  #}
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
