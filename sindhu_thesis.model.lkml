connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: sindhu_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sindhu_thesis_default_datagroup

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

  join: count_products_each_order {
    type: left_outer
    sql_on: ${count_products_each_order.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: pdt_test {
    type: left_outer
    sql_on: ${pdt_test.user_id} = ${orders.user_id} ;;
    relationship: many_to_one
  }

  join: orders_per_user {
    type: left_outer
    sql_on: ${orders_per_user.user_id} = ${orders.user_id} ;;
    relationship: many_to_one
  }

  join: max_hour_of_day {
    type: left_outer
    sql_on:  1=1 ;;
    relationship: :many_to_one
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
