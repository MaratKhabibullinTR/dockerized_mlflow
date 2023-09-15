FROM python:3.10-slim

# displays logs imidietly to the stream, they wont be part of the buffer
ENV PYTHONUNBUFFERED True

WORKDIR /app

COPY ./requirements.txt ./requirements.txt

RUN pip install -r requirements.txt

COPY entry-point.sh /app/entry-point.sh
COPY get_secret.py /app/get_secret.py
COPY mlflow_app.py /app/mlflow_app.py

ENTRYPOINT ["/usr/bin/env", "bash", "/app/entry-point.sh"]

EXPOSE 8080
