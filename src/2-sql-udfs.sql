-- Databricks notebook source
DECLARE OR REPLACE VARIABLE catalog_use STRING DEFAULT 'mgiglia';
DECLARE OR REPLACE VARIABLE schema_use STRING DEFAULT 'hls_genie';

-- COMMAND ----------

SET VARIABLE catalog_use = :`bundle.catalog`;
SET VARIABLE schema_use = :`bundle.schema`;

-- COMMAND ----------

EXECUTE IMMEDIATE "USE IDENTIFIER(catalog_use || '.' || schema_use)";

-- COMMAND ----------

SELECT current_catalog(), current_schema();

-- COMMAND ----------

CREATE OR REPLACE FUNCTION gen_summary(
  expr STRING COMMENT "Input text or data to summarize."
  ,num_words INT COMMENT "The maximum number of words to return in the summary." DEFAULT 100
)
RETURNS TABLE(
  expr_summ STRING COMMENT "The returned summary based on the input expr string."
)
RETURN
SELECT ai_summarize(expr,num_words);

-- COMMAND ----------

SELECT * FROM gen_summary(
  "What is Databricks AI/BI Genie and how does it help business users?"
)

-- COMMAND ----------

-- DROP FUNCTION IF EXISTS concat_descriptions;

-- COMMAND ----------

CREATE OR REPLACE FUNCTION concat_descriptions(
  table_name STRING COMMENT "The table name to query for descriptions."
  ,description_col STRING COMMENT "The description column to concanate into a single string."
)
RETURNS TABLE(
  patient_id STRING COMMENT "The unique patient identifier."
  ,description STRING COMMENT "The concatendated descriptions of the requested descriiption column for the patient's records in a comma-separated string."
)
RETURN 
SELECT patient_id, 
       concat_ws(', ', collect_list(description)) AS descriptions
FROM careplans
GROUP BY patient_id;


-- COMMAND ----------

SELECT * FROM concat_descriptions('careplans', 'description')

-- COMMAND ----------

SELECT * FROM concat_descriptions("encounters", "description") LIMIT 100

-- COMMAND ----------

CREATE OR REPLACE FUNCTION gen_summary_scalar(
  expr STRING COMMENT "Input text or data to summarize."
  ,num_words INT COMMENT "The maximum number of words to return in the summary." DEFAULT 100
)
RETURNS STRING COMMENT "Returns a summary of the input text or data."
RETURN ai_summarize(expr,num_words)

-- COMMAND ----------

WITH careplan_descriptions AS (
  SELECT * FROM concat_descriptions('careplans', 'description') LIMIT 10
)
SELECT
  t1.patient_id
  ,t1.description
  ,gen_summary_scalar(t1.description) as summary
FROM
  careplan_descriptions t1

-- COMMAND ----------

-- DROP FUNCTION IF EXISTS gen_ai_description_summaries;

-- COMMAND ----------

CREATE OR REPLACE FUNCTION gen_ai_description_summaries(
  table_name STRING COMMENT "The table name to query for descriptions."
  ,description_col STRING COMMENT "The description column to concanate into a single string."
)
RETURNS TABLE(
  patient_id STRING COMMENT "The unique patient identifier."
  ,description STRING COMMENT "The concatendated descriptions of the requested descriiption column for the patient's records in a comma-separated string."
  ,summary STRING COMMENT "Returns a summary of the input text or data."
)
RETURN
WITH descriptions AS (
  SELECT * FROM concat_descriptions(table_name, description_col) LIMIT 100
)
SELECT
  t1.patient_id
  ,t1.description
  ,ai_summarize(t1.description, 100) as summary
FROM
  descriptions t1

-- COMMAND ----------

SELECT * FROM gen_ai_description_summaries("encounters", "description")

-- COMMAND ----------

CREATE OR REPLACE FUNCTION gen_ai_description_summaries(
  table_name STRING COMMENT "The table name to query for descriptions."
  ,description_col STRING COMMENT "The description column to concanate into a single string."
)
RETURNS TABLE(
  patient_id STRING COMMENT "The unique patient identifier."
  ,description STRING COMMENT "The concatendated descriptions of the requested descriiption column for the patient's records in a comma-separated string."
  ,summary STRING COMMENT "Returns a summary of the input text or data."
)
RETURN
WITH descriptions AS (
  SELECT * FROM concat_descriptions(table_name, description_col) LIMIT 100
)
SELECT
  t1.patient_id
  ,t1.description
  ,ai_summarize(t1.description, 100) as summary
FROM
  descriptions t1

-- COMMAND ----------

SELECT 2+2

-- COMMAND ----------

-- MAGIC %md
-- MAGIC This is markdown.
