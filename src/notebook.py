# Databricks notebook source
# MAGIC %pip install git+https://github.com/matthew-gigl-db/dabAssist.git

# COMMAND ----------

dbutils.library.restartPython()

# COMMAND ----------

dbutils.widgets.text("db_pat_secret", "databricks_pat", "DB Secret for PAT")

# COMMAND ----------

# DBTITLE 1,Determine Secret Scope
user_name = spark.sql("select current_user()").collect()[0][0]
secret_scope = user_name.split(sep="@")[0].replace(".", "-")
secret_scope

# COMMAND ----------

from dab_assist import dabAssist

# COMMAND ----------

dc = dabAssist.databricksCli(
  workspace_url="https://e2-demo-field-eng.cloud.databricks.com/"
  ,db_pat=dbutils.secrets.get(secret_scope, dbutils.widgets.get("db_pat_secret"))
)
