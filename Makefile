RADAR_VERSION=v1
GOOGLE_PROJECT_ID=${PROJECT_ID}
DOCKER_REPOSITORY=europe-west2-docker.pkg.dev/${GOOGLE_PROJECT_ID}/radar
DOCKER_IMAGE=radar-redirect

GIT_SHA_FETCH := $(shell git rev-parse HEAD | cut -c 1-8)
export GIT_SHA=$(GIT_SHA_FETCH)

build:
	docker build -t ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:${GIT_SHA} .

run:
	docker run -p 8080:8080 -e RADAR_VERSION=${RADAR_VERSION} ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:${GIT_SHA}

push:
	docker tag ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:${GIT_SHA} ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:${RADAR_VERSION}
	docker tag ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:${GIT_SHA} ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:latest
	docker push ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:${GIT_SHA}
	docker push ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:${RADAR_VERSION}
	docker push ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:latest

deploy:
	gcloud run deploy radar-redirect --image ${DOCKER_REPOSITORY}/${DOCKER_IMAGE}:${RADAR_VERSION} --platform managed --region europe-west2 --allow-unauthenticated --set-env-vars RADAR_VERSION=${RADAR_VERSION}
