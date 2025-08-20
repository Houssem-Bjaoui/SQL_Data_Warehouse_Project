/*
===========================================================
 Note:
 This script initializes the DataWarehouse database and its
 schemas (bronze, silver, gold). Review and update as needed
 before running. For PostgreSQL: connect to the database
 before executing schema commands.
===========================================================
*/

-- Drop the database if it exists
DROP DATABASE IF EXISTS DataWarehouse;

-- Create the database
CREATE DATABASE DataWarehouse; 


CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;



