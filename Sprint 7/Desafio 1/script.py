import boto3
import datetime

session = boto3.Session(profile_name="487725688515_AdministratorAccess",region_name="us-east-1")

s3 = session.client('s3')

now = datetime.datetime.now()

s3.upload_file("movies.csv", "guga-data-lake", f"RAW/Local/CSV/Movies/{now.year}/{now.month}/{now.day}/movies.csv")
s3.upload_file("series.csv", "guga-data-lake", f"RAW/Local/CSV/Series/{now.year}/{now.month}/{now.day}/series.csv")