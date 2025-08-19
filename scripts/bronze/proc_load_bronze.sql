
/*
===========================================================
 Note:
 This script loads data into bronze schema tables from CSV
 files using PostgreSQL's COPY command. It truncates tables
 before loading and provides row counts for verification.
 Update file paths as needed before running.
===========================================================
*/



-- ============================
-- CRM TABLES
-- ============================

-- crm_cust_info
TRUNCATE TABLE bronze.crm_cust_info;
COPY bronze.crm_cust_info
FROM 'C:/Program Files/PostgreSQL/17/datasets/source_crm/cust_info.csv'
DELIMITER ','
CSV HEADER;

-- crm_prd_info
TRUNCATE TABLE bronze.crm_prd_info;
COPY bronze.crm_prd_info
FROM 'C:/Program Files/PostgreSQL/17/datasets/source_crm/prd_info.csv'
DELIMITER ','
CSV HEADER;

-- crm_sales_details
TRUNCATE TABLE bronze.crm_sales_details;
COPY bronze.crm_sales_details
FROM 'C:/Program Files/PostgreSQL/17/datasets/source_crm/sales_details.csv'
DELIMITER ','
CSV HEADER;

-- ============================
-- ERP TABLES
-- ============================

-- erp_cust_az12
TRUNCATE TABLE bronze.erp_cust_az12;
COPY bronze.erp_cust_az12
FROM 'C:/Program Files/PostgreSQL/17/datasets/source_erp/CUST_AZ12.csv'
DELIMITER ','
CSV HEADER;

-- erp_loc_a101
TRUNCATE TABLE bronze.erp_loc_a101;
COPY bronze.erp_loc_a101
FROM 'C:/Program Files/PostgreSQL/17/datasets/source_erp/LOC_A101.csv'
DELIMITER ','
CSV HEADER;

-- erp_px_cat_g1v2
TRUNCATE TABLE bronze.erp_px_cat_g1v2;
COPY bronze.erp_px_cat_g1v2
FROM 'C:/Program Files/PostgreSQL/17/datasets/source_erp/PX_CAT_G1V2.csv'
DELIMITER ','
CSV HEADER;

-- ============================
-- END OF SCRIPT
-- ============================



SELECT COUNT(*) FROM bronze.crm_cust_info;
SELECT COUNT(*) FROM bronze.crm_prd_info;
SELECT COUNT(*) FROM bronze.crm_sales_details;
SELECT COUNT(*) FROM bronze.erp_cust_az12;
SELECT COUNT(*) FROM bronze.erp_loc_a101;
SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;