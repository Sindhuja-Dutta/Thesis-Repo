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
      sql: ${count} ;;
      type: average

    }
  }
