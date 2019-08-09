connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: sindhu_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sindhu_thesis_default_datagroup

explore: aisles {}

explore: departments {}

explore: order_products__prior {
  join: products {
    type: left_outer
    sql_on: ${order_products__prior.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_products__prior.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: departments {
    type: left_outer
    sql_on: ${products.department_id} = ${departments.department_id} ;;
    relationship: many_to_one
  }

  join: aisles {
    type: left_outer
    sql_on: ${products.aisle_id} = ${aisles.aisle_id} ;;
    relationship: many_to_one
  }
}

explore: order_products__train {
  join: products {
    type: left_outer
    sql_on: ${order_products__train.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_products__train.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: departments {
    type: left_outer
    sql_on: ${products.department_id} = ${departments.department_id} ;;
    relationship: many_to_one
  }

  join: aisles {
    type: left_outer
    sql_on: ${products.aisle_id} = ${aisles.aisle_id} ;;
    relationship: many_to_one
  }
}

explore: orders {}

explore: products {
  join: departments {
    type: left_outer
    sql_on: ${products.department_id} = ${departments.department_id} ;;
    relationship: many_to_one
  }

  join: aisles {
    type: left_outer
    sql_on: ${products.aisle_id} = ${aisles.aisle_id} ;;
    relationship: many_to_one
  }
}
