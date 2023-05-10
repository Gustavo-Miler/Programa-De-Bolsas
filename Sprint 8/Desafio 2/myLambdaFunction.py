import botocore
import boto3

def lambda_handler(event, context):
    s3 = boto3.resource('s3')
    bucket = s3.Bucket('guga-data-lake')
    exists = True

    try:
        s3.meta.client.head_bucket(Bucket='guga-data-lake')
    except botocore.exceptions.ClientError as e:
        # If a client error is thrown, then check that it was a 404 error.
        # If it was a 404 error, then the bucket does not exist.
        error_code = int(e.response['Error']['Code'])
        if error_code == 404:
            exists = False

s3 = boto3.client('s3')

import pandas as pd

raw_csv = s3.get_object(Bucket="guga-data-lake", Key="RAW/Local/CSV/Movies/2023/4/24/movies.csv")["Body"]
data = pd.read_csv(raw_csv, delimiter='|')

imdb_ids = data[data['genero'].str.contains("Action")]['id'].drop_duplicates().to_numpy()

import requests
import json
import datetime

api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
now = datetime.datetime.now()

for movie_id in imdb_ids:
    url = f'https://api.themoviedb.org/3/movie/{movie_id}?api_key={api_key}&language=en-US'
    response = requests.get(url)
    data = response.json()
    s3.put_object(Body=json.dumps(data), Bucket="guga-data-lake", Key=f"RAW/TMDB/JSON/{now.year}/{now.month}/{now.day}/{movie_id}.json")