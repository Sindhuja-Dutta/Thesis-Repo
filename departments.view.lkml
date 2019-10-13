view: departments {
  sql_table_name: instacart_market_basket_analysis.departments ;;
  drill_fields: [department_id]

  dimension: department_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.department_id ;;
  }

  dimension: department {
    label: "Department Name"
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: food_item_yesno {
    label: "Is it a food item?"
    type: yesno
    sql: ${department} like 'produce' or
         ${department} like 'dairy eggs' or
         ${department} like 'beverages' or
         ${department} like 'snacks' or
         ${department} like 'frozen' or
         ${department} like 'pantry' or
         ${department} like 'bakery' or
         ${department} like 'deli' or
         ${department} like 'canned goods' or
         ${department} like 'dry goods pasta' or
         ${department} like 'meat seafood' or
         ${department} like 'breakfast' or
         ${department} like 'international';;
  }

measure: count_of_total_food_items {
  label: "Count of Total Food Items"
  type: count
  drill_fields: [department, products.count]
  filters:{
  field: food_item_yesno
  value: "yes"
  }
}

  measure: count {
    type: count
    drill_fields: [department, products.count]
  }

}
