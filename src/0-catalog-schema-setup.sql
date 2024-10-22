-- Databricks notebook source
DECLARE OR REPLACE VARIABLE catalog_use STRING DEFAULT 'mgiglia';
DECLARE OR REPLACE VARIABLE schema_use STRING DEFAULT 'hls_genie';

-- COMMAND ----------

SET VARIABLE catalog_use = :`bundle.catalog`; 
SET VARIABLE schema_use = :`bundle.schema`; 

-- COMMAND ----------

EXECUTE IMMEDIATE "CREATE SCHEMA IF NOT EXISTS IDENTIFIER(catalog_use || '.' || schema_use);"

-- COMMAND ----------

EXECUTE IMMEDIATE "USE IDENTIFIER(catalog_use || '.' || schema_use);"

-- COMMAND ----------

SELECT current_catalog(), current_schema();
