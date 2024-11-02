-- Databricks notebook source
DECLARE OR REPLACE VARIABLE catalog_use STRING DEFAULT 'mgiglia';
DECLARE OR REPLACE VARIABLE schema_use STRING DEFAULT 'hls_genie';
DECLARE OR REPLACE VARIABLE table_use STRING DEFAULT 'claims';

-- COMMAND ----------

SET VARIABLE catalog_use = :`bundle.catalog`;
SET VARIABLE schema_use = :`bundle.schema`; 
SET VARIABLE table_use = :table_name;

-- COMMAND ----------

SELECT 
  catalog_use
  ,schema_use
  ,table_use

-- COMMAND ----------

EXECUTE IMMEDIATE "USE IDENTIFIER(catalog_use || '.' || schema_use)";

-- COMMAND ----------

SELECT current_catalog(), current_schema();

-- COMMAND ----------

SHOW CREATE TABLE IDENTIFIER(table_use);
