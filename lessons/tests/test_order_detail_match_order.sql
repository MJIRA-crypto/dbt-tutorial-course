
WITH order_detail AS (
    SELECT
        order_id,
        count(*) ASnum_of_items_in_order
    FROM {{ ref('stg_ecommerce__order_items') }}
    GROUP BY 1
)

SELECT
    o.order_id,
    o.num_items_ordered,
    od.num_of_items_in_order

FROM {{ ref('stg_ecommerce__orders') }} AS o
FULL OUTER JOIN order_detail AS od USING (order_id)
WHERE o.order_id IS NULL
    OR od.order_id IS NULL
    OR o.num_items_ordered != od.num_of_items_in_order