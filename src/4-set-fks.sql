-- Databricks notebook source
DECLARE OR REPLACE VARIABLE catalog_use STRING DEFAULT 'mgiglia';
DECLARE OR REPLACE VARIABLE schema_use STRING DEFAULT 'hls_genie';
-- DECLARE OR REPLACE VARIABLE table_use STRING DEFAULT 'claims';
-- DECLARE OR REPLACE VARIABLE foriegn_keys STRING DEFAULT '["patient_id", "provider_id", ]';

-- COMMAND ----------

SET VARIABLE catalog_use = :`bundle.catalog`;
SET VARIABLE schema_use = :`bundle.schema`;  
-- SET VARIABLE table_use = :table_name;
-- SET VARIABLE primary_key = :primary_key;

-- COMMAND ----------

SELECT 
  catalog_use
  ,schema_use
  -- ,table_use
  -- ,primary_key

-- COMMAND ----------

EXECUTE IMMEDIATE "USE IDENTIFIER(catalog_use || '.' || schema_use)";

-- COMMAND ----------

SELECT current_catalog(), current_schema();

-- COMMAND ----------

ALTER TABLE claims ADD CONSTRAINT claims_patients_fk FOREIGN KEY (patient_id) REFERENCES patients(patient_id);

-- COMMAND ----------

ALTER TABLE claims ADD CONSTRAINT claims_providers_fk FOREIGN KEY (provider_id) REFERENCES providers(provider_id);

-- COMMAND ----------

ALTER TABLE claims ADD CONSTRAINT claims_primary_ins_fk FOREIGN KEY (primary_patient_insurance_id) REFERENCES payers(payer_id);

-- COMMAND ----------

ALTER TABLE claims ADD CONSTRAINT claims_secondary_ins_fk FOREIGN KEY (secondary_patient_insurance_id) REFERENCES payers(payer_id);
