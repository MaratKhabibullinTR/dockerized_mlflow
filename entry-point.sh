#!/usr/bin/env bash

set -e

export GCP_PROJECT="a208358-plx-ai-sandbox"

export ARTIFACT_URL="$(python3 /app/get_secret.py --project="${GCP_PROJECT}" --secret=a208358-sandbox-mlflow-server-artifact-root)"

if [[ -z "${DATABASE_URL}" ]]; then # Allow overriding for local deployment
    export DATABASE_URL="$(python3 /app/get_secret.py --project="${GCP_PROJECT}" --secret=a208358-sandbox-mlflow-database-url)"
fi

if [[ -z "${PORT}" ]]; then
    export PORT=8080
fi

if [[ -z "${HOST}" ]]; then
    export HOST=0.0.0.0
fi

export _MLFLOW_SERVER_ARTIFACT_ROOT="${ARTIFACT_URL}"
export _MLFLOW_SERVER_FILE_STORE="${DATABASE_URL}"

echo "_MLFLOW_SERVER_ARTIFACT_ROOT:${_MLFLOW_SERVER_ARTIFACT_ROOT}"
echo "_MLFLOW_SERVER_FILE_STORE:${_MLFLOW_SERVER_FILE_STORE}"

# Start MLflow and ngingx using supervisor
exec gunicorn \
    -b "${HOST}:${PORT}" \
    -w 4 \
    --log-level debug \
    --access-logfile=- \
    --error-logfile=- \
    --log-level=debug \
    mlflow_app:app
