view: count_products_each_order {
    derived_table: {
      explore_source: order_products__prior {
        column: order_id {}
        column: count_products { field: products.count }
      }
    }
    dimension: order_id {
      type: number
    }
    dimension: count_products {
      type: number
    }

  dimension: order_quantity_tier {
  case: {
    when: {
      sql: ${count_products} <= 5;;
      label: "Less than 5"
    }
    when: {
      sql:  ${count_products} > 5 AND ${count_products} <= 15;;
      label: "Less than 15"
    }
    when: {
      sql: ${count_products} > 15;;
      label: "More than 15"
    }
    else:"Unknown"
  }
  }

}
