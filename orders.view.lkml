view: orders {
  sql_table_name: instacart_market_basket_analysis.orders ;;
  drill_fields: [order_id]

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id;;

  }

  dimension: days_since_prior_order {
    label: "Number of days since prior order"
    type: number
    sql: ${TABLE}.days_since_prior_order ;;
  }

  dimension: eval_set {
    type: string
    sql: ${TABLE}.eval_set ;;
  }

  dimension: order_dow {
    label: "Day of Week Num"
    type: number
    sql: ${TABLE}.order_dow ;;
  }

  dimension:  order_dow_name{
    label: "Day of Week Name"
    type: string
    case: {
      when: {
        sql: ${order_dow} = 0 ;;
        label: "Saturday"
      }
      when: {
        sql: ${order_dow} = 1 ;;
        label: "Sunday"
      }
      when: {
        sql: ${order_dow} = 2 ;;
        label: "Monday"
      }
      when: {
        sql: ${order_dow} = 3 ;;
        label: "Tuesday"
      }
      when: {
        sql: ${order_dow} = 4 ;;
        label: "Wednesday"
      }
      when: {
        sql: ${order_dow} = 5 ;;
        label: "Thursday"
      }
      when: {
        sql: ${order_dow} = 6 ;;
        label: "Friday"
      }
      else: "unknown"
    }
  }

  dimension: order_hour_of_day {
    label: "Hour of Day 24 Hour Clock"
    type: number
    sql: ${TABLE}.order_hour_of_day ;;
  }

  # Used a harcoded LookML case statement to get the auto sorting
  dimension: order_hour_of_day_12_hour_format {
    label: "Hour of Day 12 Hour Clock"
    type: string
    case: {
      when: {
        label: "12 AM"
        sql:  ${order_hour_of_day} = 0 ;;
      }
      when: {
        label: "1 AM"
        sql:  ${order_hour_of_day} = 1 ;;
      }
      when: {
        label: "2 AM"
        sql:  ${order_hour_of_day} = 2 ;;
      }
      when: {
        label: "3 AM"
        sql:  ${order_hour_of_day} = 3 ;;
      }
      when: {
        label: "4 AM"
        sql:  ${order_hour_of_day} = 4 ;;
      }
      when: {
        label: "5 AM"
        sql:  ${order_hour_of_day} = 5 ;;
      }
      when: {
        label: "6 AM"
        sql:  ${order_hour_of_day} = 6 ;;
      }
      when: {
        label: "7 AM"
        sql:  ${order_hour_of_day} = 7 ;;
      }
      when: {
        label: "8 AM"
        sql:  ${order_hour_of_day} = 8 ;;
      }
      when: {
        label: "9 AM"
        sql:  ${order_hour_of_day} = 9 ;;
      }
      when: {
        label: "10 AM"
        sql:  ${order_hour_of_day} = 10 ;;
      }
      when: {
        label: "11 AM"
        sql:  ${order_hour_of_day} = 11 ;;
      }
      when: {
        label: "12 PM"
        sql:  ${order_hour_of_day} = 12 ;;
      }
      when: {
        label: "1 PM"
        sql:  ${order_hour_of_day} = 13 ;;
      }
      when: {
        label: "2 PM"
        sql:  ${order_hour_of_day} = 14 ;;
      }
      when: {
        label: "3 PM"
        sql:  ${order_hour_of_day} = 15 ;;
      }
      when: {
        label: "4 PM"
        sql:  ${order_hour_of_day} = 16 ;;
      }
      when: {
        label: "5 PM"
        sql:  ${order_hour_of_day} = 17 ;;
      }
      when: {
        label: "6 PM"
        sql:  ${order_hour_of_day} = 18 ;;
      }
      when: {
        label: "7 PM"
        sql:  ${order_hour_of_day} = 19 ;;
      }
      when: {
        label: "8 PM"
        sql:  ${order_hour_of_day} = 20 ;;
      }
      when: {
        label: "9 PM"
        sql:  ${order_hour_of_day} = 21 ;;
      }
      when: {
        label: "10 PM"
        sql:  ${order_hour_of_day} = 22 ;;
      }
      when: {
        label: "11 PM"
        sql:  ${order_hour_of_day} = 23 ;;
      }
    }
  }


  dimension: order_number {
    label: "Order number for each user"
    type: number
    sql: ${TABLE}.order_number ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: visit_time {
    label: "Time of visit during day"
    case: {
      when: {
        sql: ${order_hour_of_day} < 6;;
        label: "Midnight"
      }
      when: {
        sql:  ${order_hour_of_day} < 12;;
        label: "Morning"
      }
      when: {
        sql: ${order_hour_of_day} < 18;;
        label: "Noon"
      }
      else:"Night"
    }
  }

 measure: count_of_users {
  type: count_distinct
   label: "Count of Users"
  sql: ${user_id} ;;
  drill_fields: [user_id, order_products__train.count, order_products__prior.count]
  link: { label: "Drill Dashboard" url: "/dashboards/427?Count of Orders={{ value }}" }
 }

  measure: count {
    link: { label: "Drill Dashboard" url: "/dashboards/433?Product Count={{ value }}" }
    type: count
    drill_fields: [order_id, order_products__train.count, order_products__prior.count]
  }
}
