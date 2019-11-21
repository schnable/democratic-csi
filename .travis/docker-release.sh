#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

export DOCKER_ORG="democraticcsi"
export DOCKER_PROJECT="democratic-csi"
export DOCKER_REPO="${DOCKER_ORG}/${DOCKER_PROJECT}"

if [[ -n "${TRAVIS_TAG}" ]];then
	docker build --pull -t ${DOCKER_REPO}:${TRAVIS_TAG} .
	docker push ${DOCKER_REPO}:${TRAVIS_TAG}
elif [[ -n "${TRAVIS_BRANCH}" ]];then
	if [[ "${TRAVIS_BRANCH}" == "master" ]];then
		docker build --pull -t ${DOCKER_REPO}:latest .
		docker push ${DOCKER_REPO}:latest
	else
		docker build --pull -t ${DOCKER_REPO}:${TRAVIS_BRANCH} .
		docker push ${DOCKER_REPO}:${TRAVIS_BRANCH}
	fi
else
	:
fi