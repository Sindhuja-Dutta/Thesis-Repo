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

  dimension: order_quantity_tier {
    label: "Quantity of Orders"
    case: {
      when: {
        sql: ${count} <= 5;;
        label: "Less than 5"
      }
      when: {
        sql:  ${count} > 5 AND ${count} <= 15;;
        label: "Less than 15"
      }
      when: {
        sql: ${count} > 15;;
        label: "More than 15"
      }
      else:"Unknown"
    }
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
