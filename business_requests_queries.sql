-- Query 1: List of products with a base price greater than 500 and featured in 'BOGOF'
SELECT
    dp.product_name,
    dp.category,
    fe.base_price,
    fe.promo_type
FROM
    dim_products dp
JOIN
    fact_events fe ON dp.product_code = fe.product_code
WHERE
    fe.base_price > 500
    AND fe.promo_type = 'BOGOF';
    
-- Query 2:  Generate a report that provides an overview of the number of stores in each city. The results will be sorted in descending order of store counts, allowing us to identify the cities with the highest store presence. The report includes two essential fields: city and store count, which will assist in optimizing our retail operations
    
SELECT
    ds.city,
    COUNT(ds.store_id) AS store_count
FROM
    dim_stores ds
JOIN
    fact_events fe ON ds.store_id = fe.store_id
GROUP BY
    ds.city
ORDER BY
    store_count DESC;
    
-- Query 3: Select the campaign name and the sum of base price times quantity sold before and after the promotion

SELECT 
    c.campaign_name,
    ROUND(SUM(f.base_price * f.`quantity_sold(before_promo)`) / 1000000, 2) AS total_revenue_before_promotion,
    ROUND(SUM(f.base_price * f.`quantity_sold(after_promo)`) / 1000000, 2) AS total_revenue_after_promotion
FROM 
    retail_events_db.dim_campaigns c
JOIN 
    retail_events_db.fact_events f ON c.campaign_id = f.campaign_id
GROUP BY 
    c.campaign_name
LIMIT 0, 1000;

-- Query 4:report that calculates the Incremental Sold Quantity (ISU%) for each category during the Diwali campaign, including ranking

WITH CategoryDiwali AS (
    SELECT
        dp.category,
        SUM(fe.`quantity_sold(before_promo)`) AS total_before_promo,
        SUM(fe.`quantity_sold(after_promo)`) AS total_after_promo
    FROM
        dim_campaigns dc
    JOIN
        fact_events fe ON dc.campaign_id = fe.campaign_id
    JOIN
        dim_products dp ON fe.product_code = dp.product_code
    WHERE
        dc.campaign_name = 'Diwali'
    GROUP BY
        dp.category
)

SELECT
    cd.category,
    ROUND(((cd.total_after_promo - cd.total_before_promo) / cd.total_before_promo) * 100, 2) AS isu_percentage,
    RANK() OVER (ORDER BY ((cd.total_after_promo - cd.total_before_promo) / cd.total_before_promo) DESC) AS rank_order
FROM
    CategoryDiwali cd;

    
-- Query 5: report featuring the Top 5 products, ranked by Incremental Revenue Percentage (IR%) across all campaigns

WITH Product_IR AS (
    SELECT 
        dp.product_name,
        dp.category,
        ((SUM(fe.base_price * fe.`quantity_sold(after_promo)`) - SUM(fe.base_price * fe.`quantity_sold(before_promo)`)) / 
        SUM(fe.base_price * fe.`quantity_sold(before_promo)`) * 100) AS ir_percentage
    FROM 
        retail_events_db.dim_products dp
    JOIN 
        retail_events_db.fact_events fe ON dp.product_code = fe.product_code
    GROUP BY 
        dp.product_name, dp.category
)
SELECT 
    product_name,
    category,
    ROUND(ir_percentage, 2) AS ir_percentage
FROM 
    Product_IR
ORDER BY 
    ir_percentage DESC
LIMIT 5;


