 ## SQL_Data_Warehouse_Project

## Project Overview

**SQL_Data_Warehouse_Project** is a modular Data Warehouse solution built on PostgreSQL. It implements a classic multi-layered architecture—**bronze**, **silver**, and **gold**—to support robust data ingestion, transformation, and analytics. The project is designed for scalable, auditable, and high-quality data processing, making it suitable for enterprise analytics and reporting.

- **Bronze Layer:** Raw data ingestion and staging.
- **Silver Layer:** Data cleansing, transformation, and integration.
- **Gold Layer:** Business-ready dimensional and fact tables for analytics.

---

## Repository Structure

```
scripts/
  init_database.sql
  bronze/
    ddl_bronze.sql
    proc_load_bronze.sql
  silver/
    ddl_silver.sql
    proc_load_silver.sql
  gold/
    ddl_gold.sql
  tests/
    checks_silver.sql
```

- **scripts/init_database.sql**: Initializes the database and creates required schemas.
- **scripts/bronze/**: 
  - `ddl_bronze.sql`: DDL for bronze (raw) tables.
  - `proc_load_bronze.sql`: Procedures for loading raw data.
- **scripts/silver/**:
  - `ddl_silver.sql`: DDL for silver (cleansed/transformed) tables.
  - `proc_load_silver.sql`: Procedures for transforming and loading data into silver.
- **scripts/gold/**:
  - `ddl_gold.sql`: DDL for gold (analytics-ready) tables/views.
- **scripts/tests/**:
  - `checks_silver.sql`: Data quality and validation checks for the silver layer.

---

## Database Initialization

### Prerequisites

- **PostgreSQL** version 13 or higher is recommended.
- Ensure the following PostgreSQL extensions are enabled (if used in your scripts):
  - `uuid-ossp`
  - `pgcrypto`
  - Any other extensions referenced in the DDL scripts.

### Steps

1. Create a new PostgreSQL database (e.g., `data_warehouse`).
2. Run the initialization script to set up schemas:
   ```sql
   \i scripts/init_database.sql
   ```
3. Execute the DDL scripts for each layer:
   ```sql
   \i scripts/bronze/ddl_bronze.sql
   \i scripts/silver/ddl_silver.sql
   \i scripts/gold/ddl_gold.sql
   ```

---

## Data Loading Process (ETL Flow)

1. **Bronze Layer (Raw Ingestion):**
   - Use `proc_load_bronze.sql` to load raw data into staging tables.
   - Example:
     ```sql
     \i scripts/bronze/proc_load_bronze.sql
     CALL load_bronze_data();
     ```

2. **Silver Layer (Transformation & Cleansing):**
   - Use `proc_load_silver.sql` to transform and cleanse data.
   - Example:
     ```sql
     \i scripts/silver/proc_load_silver.sql
     CALL load_silver_data();
     ```

3. **Gold Layer (Analytics & Reporting):**
   - Use `ddl_gold.sql` to create business-ready tables/views.
   - Example:
     ```sql
     \i scripts/gold/ddl_gold.sql
     ```

---

## Quality Checks

- The `scripts/tests/checks_silver.sql` script contains SQL queries and assertions to validate data quality in the silver layer.
- Checks may include:
  - Null value checks
  - Referential integrity
  - Duplicate detection
  - Business rule validations

Run the checks:
```sql
\i scripts/tests/checks_silver.sql
```

---

## How to Run

1. **Clone the repository:**
   ```powershell
   git clone https://github.com/Houssem-Bjaoui/SQL_Data_Warehouse_Project.git
   cd SQL_Data_Warehouse_Project
   ```

2. **Set up PostgreSQL and create a database.**

3. **Initialize schemas and tables:**
   ```sql
   \i scripts/init_database.sql
   \i scripts/bronze/ddl_bronze.sql
   \i scripts/silver/ddl_silver.sql
   \i scripts/gold/ddl_gold.sql
   ```

4. **Load and transform data:**
   ```sql
   \i scripts/bronze/proc_load_bronze.sql
   CALL load_bronze_data();

   \i scripts/silver/proc_load_silver.sql
   CALL load_silver_data();
   ```

5. **Run data quality checks:**
   ```sql
   \i scripts/tests/checks_silver.sql
   ```

6. **Query gold layer tables/views for analytics.**

---

## Customization

- **Adapting to New Data Sources:**  
  Update or add new procedures in `bronze/proc_load_bronze.sql` to handle different raw data formats.
- **Business Rules:**  
  Modify transformation logic in `silver/proc_load_silver.sql` to reflect new or changing business requirements.
- **Schema Changes:**  
  Adjust DDL scripts in each layer to add/remove columns or tables as needed.
- **Testing:**  
  Add new SQL scripts in `tests/` to cover additional data quality checks.

---

## Contributing

1. Fork the repository and create a new branch for your feature or bugfix.
2. Follow the existing code and documentation style.
3. Submit a pull request with a clear description of your changes.
4. Report issues or suggest enhancements via the GitHub Issues tab.

---

-
