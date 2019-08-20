view: each_order_products {
    derived_table: {
      sql:
      SELECT
        order_id
      FROM
        orders
      GROUP BY
        order_id ;;

}
}
