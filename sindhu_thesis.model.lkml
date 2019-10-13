connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: sindhu_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: sindhu_thesis_default_datagroup

explore: order_products__prior {
  label: "Order Products"
  join: products {
    view_label: "Product Details"
    type: left_outer
    sql_on: ${order_products__prior.product_id} = ${products.product_id} ;;
    relationship: many_to_one
  }

  join: orders {
    view_label: "Orders"
    type: left_outer
    sql_on: ${order_products__prior.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: departments {
    view_label: "Department Details"
    type: left_outer
    sql_on: ${products.department_id} = ${departments.department_id} ;;
    relationship: many_to_one
  }

  join: aisles {
    view_label: "Aisle Details"
    type: left_outer
    sql_on: ${products.aisle_id} = ${aisles.aisle_id} ;;
    relationship: many_to_one
  }

  join: count_products_each_order {
    view_label: "Products in Each Order"
    type: left_outer
    sql_on: ${count_products_each_order.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }


  join: orders_per_user {
    view_label: "Orders Per User"
    type: left_outer
    sql_on: ${orders_per_user.user_id} = ${orders.user_id} ;;
    relationship: many_to_one
  }

  join: max_hour_of_day {
    view_label: "Hour of Day with Max Orders"
    type: left_outer
    sql_on:  1=1 ;;
    relationship: :many_to_one
  }


}
