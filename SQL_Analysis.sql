-- ============================================================
-- E-commerce Revenue Analysis
-- Olist Brazilian E-commerce Dataset
-- Tool: Google BigQuery / Standard SQL
-- ============================================================

-- Tables used:
-- olist_orders_dataset
-- olist_order_items_dataset
-- olist_customers_dataset

-- NOTE:
-- Replace `project.dataset` with your BigQuery project and dataset.
-- Example:
-- `my-project.ecommerce.olist_orders_dataset`


-- ============================================================
-- 1. MONTHLY REVENUE AND ORDERS
-- Business question:
-- How do revenue and order volume change over time?
-- ============================================================

SELECT
  DATE_TRUNC(DATE(o.order_purchase_timestamp), MONTH) AS YearMonth,
  ROUND(SUM(oi.price), 2) AS Revenue,
  COUNT(DISTINCT o.order_id) AS Orders,
  ROUND(
    SAFE_DIVIDE(SUM(oi.price), COUNT(DISTINCT o.order_id)),
    2
  ) AS AOV
FROM `project.dataset.olist_orders_dataset` AS o
JOIN `project.dataset.olist_order_items_dataset` AS oi
  ON o.order_id = oi.order_id
GROUP BY YearMonth
ORDER BY YearMonth;


-- ============================================================
-- 2. AVERAGE ORDER VALUE
-- Business question:
-- What is the average revenue generated per order?
-- ============================================================

SELECT
  ROUND(SUM(oi.price), 2) AS Total_Revenue,
  COUNT(DISTINCT o.order_id) AS Total_Orders,
  ROUND(
    SAFE_DIVIDE(SUM(oi.price), COUNT(DISTINCT o.order_id)),
    2
  ) AS Average_Order_Value
FROM `project.dataset.olist_orders_dataset` AS o
JOIN `project.dataset.olist_order_items_dataset` AS oi
  ON o.order_id = oi.order_id;


-- ============================================================
-- 3. MONTHLY REVENUE GROWTH
-- Business question:
-- How does revenue change compared with the previous month?
-- ============================================================

WITH monthly_revenue AS (
  SELECT
    DATE_TRUNC(DATE(o.order_purchase_timestamp), MONTH) AS YearMonth,
    SUM(oi.price) AS Revenue
  FROM `project.dataset.olist_orders_dataset` AS o
  JOIN `project.dataset.olist_order_items_dataset` AS oi
    ON o.order_id = oi.order_id
  GROUP BY YearMonth
)

SELECT
  YearMonth,
  ROUND(Revenue, 2) AS Revenue,
  ROUND(
    SAFE_DIVIDE(
      Revenue - LAG(Revenue) OVER (ORDER BY YearMonth),
      LAG(Revenue) OVER (ORDER BY YearMonth)
    ) * 100,
    2
  ) AS Revenue_Growth_Percent
FROM monthly_revenue
ORDER BY YearMonth;


-- ============================================================
-- 4. KEY PERFORMANCE INDICATORS
-- Business question:
-- What are the overall revenue and order KPIs?
-- ============================================================

SELECT
  ROUND(SUM(oi.price), 2) AS Total_Revenue,
  COUNT(DISTINCT o.order_id) AS Total_Orders,
  ROUND(
    SAFE_DIVIDE(SUM(oi.price), COUNT(DISTINCT o.order_id)),
    2
  ) AS Average_Order_Value
FROM `project.dataset.olist_orders_dataset` AS o
JOIN `project.dataset.olist_order_items_dataset` AS oi
  ON o.order_id = oi.order_id;


-- ============================================================
-- 5. DELIVERY PERFORMANCE
-- Business question:
-- What percentage of delivered orders arrived on time?
-- ============================================================

SELECT
  CASE
    WHEN DATE(o.order_delivered_customer_date)
         <= DATE(o.order_estimated_delivery_date)
      THEN 'On-Time'
    ELSE 'Late'
  END AS Delivery_Status,
  COUNT(DISTINCT o.order_id) AS Orders,
  ROUND(
    SAFE_DIVIDE(
      COUNT(DISTINCT o.order_id),
      SUM(COUNT(DISTINCT o.order_id)) OVER ()
    ) * 100,
    2
  ) AS Order_Percentage
FROM `project.dataset.olist_orders_dataset` AS o
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY Delivery_Status
ORDER BY Orders DESC;


-- ============================================================
-- 6. REVENUE BY CUSTOMER STATE
-- Business question:
-- Which Brazilian states generate the most revenue?
-- ============================================================

SELECT
  c.customer_state AS State,
  ROUND(SUM(oi.price), 2) AS Revenue,
  COUNT(DISTINCT o.order_id) AS Orders
FROM `project.dataset.olist_orders_dataset` AS o
JOIN `project.dataset.olist_order_items_dataset` AS oi
  ON o.order_id = oi.order_id
JOIN `project.dataset.olist_customers_dataset` AS c
  ON o.customer_id = c.customer_id
GROUP BY State
ORDER BY Revenue DESC;


-- ============================================================
-- 7. TOP PRODUCTS BY REVENUE
-- Business question:
-- Which products generate the highest revenue?
-- ============================================================

SELECT
  oi.product_id AS Product_ID,
  ROUND(SUM(oi.price), 2) AS Revenue,
  COUNT(*) AS Items_Sold
FROM `project.dataset.olist_order_items_dataset` AS oi
GROUP BY Product_ID
ORDER BY Revenue DESC
LIMIT 10;
