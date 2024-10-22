-- Databricks notebook source
DECLARE OR REPLACE VARIABLE catalog_use STRING DEFAULT 'mgiglia';
DECLARE OR REPLACE VARIABLE schema_use STRING DEFAULT 'hls_genie';
DECLARE OR REPLACE VARIABLE table_name STRING;
DECLARE OR REPLACE VARIABLE catalog_original STRING DEFAULT 'mgiglia';
DECLARE OR REPLACE VARIABLE schema_original STRING DEFAULT 'synthea_dev';

-- COMMAND ----------

SET VARIABLE catalog_use = :`bundle.catalog`;
SET VARIABLE schema_use = :`bundle.schema`;
SET VARIABLE table_name = :table_name;

-- COMMAND ----------

EXECUTE IMMEDIATE "USE IDENTIFIER(catalog_use || '.' || schema_use)";

-- COMMAND ----------

SELECT current_catalog(), current_schema();

-- COMMAND ----------

DECLARE OR REPLACE VARIABLE crtas_stmnt STRING;

SET VAR crtas_stmnt = "
  CREATE OR REPLACE TABLE " || catalog_use || '.' || schema_use || '.' || table_name || " AS 
  SELECT
    *
  FROM 
    " || catalog_original || '.' || schema_original || '.' || table_name || "
  ;
";

SELECT crtas_stmnt;

-- COMMAND ----------

EXECUTE IMMEDIATE crtas_stmnt;
