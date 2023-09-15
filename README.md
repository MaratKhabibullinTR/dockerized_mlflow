# build:
	docker build -t mlflow .

# docker-auth:
	gcloud auth configure-docker

# tag:
	docker tag mlflow europe-west3-docker.pkg.dev/a208358-plx-ai-sandbox/ml-training/mlflow:__version__

# push:
	docker push europe-west3-docker.pkg.dev/a208358-plx-ai-sandbox/ml-training/mlflow:__version__
