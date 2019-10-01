view: orders_per_user {
    derived_table: {
      explore_source: order_products__prior {
        column: user_id { field: orders.user_id }
        column: count { field: orders.count }
      }
    }
    dimension: user_id {
      primary_key: yes
      type: number
    }
    dimension: count {
      type: number
    }

    measure: average_orders {
      drill_fields: [user_id,count]
      sql: ${count} ;;
      type: average

    }

    measure: max_orders {
      drill_fields: [user_id,count]
      sql: ${count} ;;
      type: max
    }

    measure: min_orders {
      drill_fields: [user_id,count]
      sql: ${count} ;;
      type: min
    }
  }
