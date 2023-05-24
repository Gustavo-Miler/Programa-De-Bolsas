import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

df = glueContext.create_dynamic_frame.from_options(
    "s3",
    {
        "paths": ["s3://guga-data-lake/TRT/TMDB/"],
        "recurse": True
    },
    "parquet"
    )

df = df.toDF()
df = df.filter("id IS NOT NULL")

from pyspark.sql.functions import col, when, explode

df_movie = df.select(
    'id',
    'imdb_id',
    'adult',
    'backdrop_path',
    when(col("belongs_to_collection").isNotNull(), col("belongs_to_collection").getField("id")).alias('collection_id'),
    'budget',
    'homepage',
    'original_language',
    'original_title',
    'overview',
    'popularity',
    'poster_path',
    'release_date',
    'runtime',
    'status',
    'tagline',
    'title',
    'video',
    'vote_average',
    'vote_count',
    'success',
    'status_code',
    'status_message'
    )

df_revenue = df.select(
    col('id').alias('movie_id'),
    when(col("revenue").isNotNull(), col("revenue").getField("int")).alias("int"),
    when(col("revenue").isNotNull(), col("revenue").getField("long")).alias("long")
    ).filter("movie_id IS NOT NULL")

df_collection = df.select(
    when(col("belongs_to_collection").isNotNull(), col("belongs_to_collection").getField("id")).alias("id"),
    when(col("belongs_to_collection").isNotNull(), col("belongs_to_collection").getField("name")).alias("name"),
    when(col("belongs_to_collection").isNotNull(), col("belongs_to_collection").getField("poster_path")).alias("poster_path"),
    when(col("belongs_to_collection").isNotNull(), col("belongs_to_collection").getField("backdrop_path")).alias("backdrop_path")
    ).filter("id IS NOT NULL").drop_duplicates()

df_movie_company = df.select(
    col('id').alias('movie_id'),
    explode("production_companies").alias("struct")
    ).select('movie_id', col('struct.id').alias("company_id")).drop_duplicates()

df_company = df.select(
    explode("production_companies").alias("struct")
    ).select(
        'struct.id',
        'struct.logo_path',
        'struct.name',
        'struct.origin_country'
        ).drop_duplicates()

df_movie_genre = df.select(
    col('id').alias('movie_id'),
    explode("genres").alias("struct")
    ).select(
        'movie_id',
        col('struct.id').alias('genre_id')
        ).drop_duplicates()

df_genre = df.select(
    explode('genres').alias('struct')
    ).select(
        'struct.id',
        'struct.name'
        ).drop_duplicates()

df_movie_production_country = df.select(
    col('id').alias('movie_id'),
    explode('production_countries').alias('struct')
    ).select(
        'movie_id',
        'struct.iso_3166_1'
        ).drop_duplicates()

df_country = df.select(
    explode('production_countries').alias('struct')
    ).select(
        'struct.iso_3166_1',
        'struct.name'
        ).drop_duplicates()

df_movie_language = df.select(
    col('id').alias('movie_id'),
    explode('spoken_languages').alias('struct')
    ).select(
        'movie_id',
        'struct.iso_639_1'
        ).drop_duplicates()

df_language = df.select(
    explode('spoken_languages').alias('struct')
    ).select(
        'struct.iso_639_1',
        'struct.name',
        'struct.english_name'
        ).drop_duplicates()

df_movie.write.parquet('s3://guga-data-lake/RFN/TMDB/movie')

df_revenue.write.parquet('s3://guga-data-lake/RFN/TMDB/revenue')

df_collection.write.parquet('s3://guga-data-lake/RFN/TMDB/collection')

df_movie_company.write.parquet('s3://guga-data-lake/RFN/TMDB/movieCompany')
df_company.write.parquet('s3://guga-data-lake/RFN/TMDB/company')

df_movie_genre.write.parquet('s3://guga-data-lake/RFN/TMDB/movieGenre')
df_genre.write.parquet('s3://guga-data-lake/RFN/TMDB/genre')

df_movie_production_country.write.parquet('s3://guga-data-lake/RFN/TMDB/movieProductionCountry')
df_country.write.parquet('s3://guga-data-lake/RFN/TMDB/country')

df_movie_language.write.parquet('s3://guga-data-lake/RFN/TMDB/movieLanguage')
df_language.write.parquet('s3://guga-data-lake/RFN/TMDB/language')

job.commit()