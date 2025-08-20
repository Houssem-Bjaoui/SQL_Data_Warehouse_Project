/* ============================================================================  
   Project: Data Warehouse (PostgreSQL Version)  
   Layer:   Gold (Dimensional Model)  
   Author:  [Ton Nom]  
   Date:    [mettre la date]  
   Note:    Ce script crée les vues dimensionnelles et factuelles (dim_customers,  
            dim_products, fact_sales) à partir des tables Silver.  
            - Compatible PostgreSQL  
            - Ajout de surrogate keys avec ROW_NUMBER()  
            - Peut être relancé sans erreur (DROP VIEW IF EXISTS)  
============================================================================ */

-- ============================================================================
-- Dimension: dim_customers
-- ============================================================================

DROP VIEW IF EXISTS gold.dim_customers;

CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key,  -- Surrogate key
    ci.cst_id         AS customer_id,       -- Business ID (source CRM)
    ci.cst_key        AS customer_number,   -- Natural key
    ci.cst_firstname  AS first_name,
    ci.cst_lastname   AS last_name,
    la.cntry          AS country,
    ci.cst_marital_status AS marital_status,
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr        -- CRM priorité pour le genre
        ELSE COALESCE(ca.gen, 'n/a')                      -- Fallback sur ERP
    END              AS gender,
    ca.bdate          AS birthdate,
    ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
       ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
       ON ci.cst_key = la.cid;

-- ============================================================================
-- Dimension: dim_products
-- ============================================================================

DROP VIEW IF EXISTS gold.dim_products;

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,  -- Surrogate key
    pn.prd_id        AS product_id,        -- Business ID
    pn.prd_key       AS product_number,    -- Natural key
    pn.prd_nm        AS product_name,
    pn.cat_id        AS category_id,
    pc.cat           AS category,
    pc.subcat        AS subcategory,
    pc.maintenance   AS maintenance,
    pn.prd_cost      AS cost,
    pn.prd_line      AS product_line,
    pn.prd_start_dt  AS start_date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
       ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;   -- Exclure les produits historiques (fin de vie)

-- ============================================================================
-- Fact Table: fact_sales
-- ============================================================================

DROP VIEW IF EXISTS gold.fact_sales;

CREATE VIEW gold.fact_sales AS
SELECT
    sd.sls_ord_num   AS order_number,    -- Business key (order number)
    pr.product_key   AS product_key,     -- FK vers dim_products
    cu.customer_key  AS customer_key,    -- FK vers dim_customers
    sd.sls_order_dt  AS order_date,
    sd.sls_ship_dt   AS shipping_date,
    sd.sls_due_dt    AS due_date,
    sd.sls_sales     AS sales_amount,
    sd.sls_quantity  AS quantity,
    sd.sls_price     AS price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
       ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
       ON sd.sls_cust_id = cu.customer_id;
