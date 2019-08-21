view: each_order_products {
    derived_table: {
      sql:
      SELECT
        order_id,count(product_id)
      FROM
        order_products_prior
      GROUP BY
        order_id ;;

}
}
