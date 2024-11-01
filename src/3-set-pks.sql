-- Databricks notebook source
DECLARE OR REPLACE VARIABLE catalog_use STRING DEFAULT 'mgiglia';
DECLARE OR REPLACE VARIABLE schema_use STRING DEFAULT 'hls_genie';
DECLARE OR REPLACE VARIABLE table_use STRING DEFAULT 'claims';
DECLARE OR REPLACE VARIABLE primary_key STRING DEFAULT 'claim_id';

-- COMMAND ----------

SET VARIABLE catalog_use = :`bundle.catalog`;
SET VARIABLE schema_use = :`bundle.schema`; 
SET VARIABLE table_use = :table_name;
SET VARIABLE primary_key = :primary_key;

-- COMMAND ----------

SELECT 
  catalog_use
  ,schema_use
  ,table_use
  ,primary_key

-- COMMAND ----------

EXECUTE IMMEDIATE "USE IDENTIFIER(catalog_use || '.' || schema_use)";

-- COMMAND ----------

SELECT current_catalog(), current_schema();

-- COMMAND ----------

DECLARE OR REPLACE VARIABLE pk_not_null STRING;

SET VARIABLE pk_not_null = "ALTER TABLE IDENTIFIER(table_use) ALTER COLUMN " || primary_key || " SET NOT NULL;";
SELECT pk_not_null;

-- COMMAND ----------

EXECUTE IMMEDIATE pk_not_null;

-- COMMAND ----------

DECLARE OR REPLACE VARIABLE drop_pk STRING;

SET VARIABLE drop_pk = "ALTER TABLE IDENTIFIER(table_use) DROP CONSTRAINT IF EXISTS " || table_use || "_pk;";
SELECT drop_pk;

-- COMMAND ----------

EXECUTE IMMEDIATE drop_pk;

-- COMMAND ----------

DECLARE OR REPLACE VARIABLE set_pk STRING;

SET VARIABLE set_pk = "ALTER TABLE IDENTIFIER(table_use) ADD CONSTRAINT " || table_use || "_pk PRIMARY KEY ("|| primary_key || ")";
SELECT set_pk;

-- COMMAND ----------

EXECUTE IMMEDIATE set_pk;
