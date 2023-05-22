import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME', 'S3_INPUT_PATH', 'S3_OUTPUT_PATH'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

source_path = args['S3_INPUT_PATH']
target_path = args['S3_OUTPUT_PATH']

df = glueContext.create_dynamic_frame.from_options(
    "s3",
    {
        "paths": [source_path],
        "recurse": True
    },
    format="json"
    )

df = df.toDF()

from pyspark.sql.functions import current_date

df = df.withColumn("date", current_date()).repartition("date")

df.write.partitionBy("date").parquet(target_path)

job.commit()