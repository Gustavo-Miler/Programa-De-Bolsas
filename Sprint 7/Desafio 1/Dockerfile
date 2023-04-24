FROM python:latest

WORKDIR /home

COPY credentials /root/.aws/

RUN pip install boto3[crt]

CMD ["python", "./script.py"]