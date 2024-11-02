-- Databricks notebook source
DECLARE OR REPLACE VARIABLE catalog_use STRING DEFAULT 'mgiglia';
DECLARE OR REPLACE VARIABLE schema_use STRING DEFAULT 'hls_genie';
DECLARE OR REPLACE VARIABLE table_use STRING DEFAULT 'claims';
DECLARE OR REPLACE VARIABLE table_fk_column STRING DEFAULT 'patient_id';
DECLARE OR REPLACE VARIABLE foriegn_key STRING DEFAULT "patient_id";
DECLARE OR REPLACE VARIABLE foriegn_table STRING DEFAULT "patients";

-- COMMAND ----------

SET VARIABLE catalog_use = :`bundle.catalog`;
SET VARIABLE schema_use = :`bundle.schema`;  
SET VARIABLE table_use = :table_name;
SET VARIABLE table_fk_column = :table_fk_column;
SET VARIABLE foriegn_key = :foriegn_key;
SET VARIABLE foriegn_table = :foriegn_table;

-- COMMAND ----------

SELECT 
  catalog_use
  ,schema_use
  ,table_use
  ,table_fk_column
  ,foriegn_key
  ,foriegn_table

-- COMMAND ----------

EXECUTE IMMEDIATE "USE IDENTIFIER(catalog_use || '.' || schema_use)";

-- COMMAND ----------

SELECT current_catalog(), current_schema();

-- COMMAND ----------

DECLARE OR REPLACE VARIABLE drop_fk STRING;

SET VARIABLE drop_fk = "ALTER TABLE IDENTIFIER(table_use) DROP CONSTRAINT IF EXISTS " || table_use || "_" || foriegn_table || "_" || table_fk_column || "_fk;";
SELECT drop_fk;

-- COMMAND ----------

EXECUTE IMMEDIATE drop_fk;

-- COMMAND ----------

DECLARE OR REPLACE VARIABLE set_fk STRING;

SET VARIABLE set_fk = "ALTER TABLE IDENTIFIER(table_use) ADD CONSTRAINT " || table_use || "_" || foriegn_table || "_" || table_fk_column || "_fk FOREIGN KEY (" || table_fk_column || ") REFERENCES " || foriegn_table|| "(" || table_fk_column ||");";

SELECT set_fk;

-- COMMAND ----------

EXECUTE IMMEDIATE set_fk;

-- COMMAND ----------

-- ALTER TABLE claims ADD CONSTRAINT claims_patients_fk FOREIGN KEY (patient_id) REFERENCES patients(patient_id);

-- COMMAND ----------

-- ALTER TABLE claims ADD CONSTRAINT claims_providers_fk FOREIGN KEY (provider_id) REFERENCES providers(provider_id);

-- COMMAND ----------

-- ALTER TABLE claims ADD CONSTRAINT claims_primary_ins_fk FOREIGN KEY (primary_patient_insurance_id) REFERENCES payers(payer_id);

-- COMMAND ----------

-- ALTER TABLE claims ADD CONSTRAINT claims_secondary_ins_fk FOREIGN KEY (secondary_patient_insurance_id) REFERENCES payers(payer_id);
