#!/bin/bash

NAME="pyload"
SOURCE="HelmRepository/k8s-at-home-charts.flux-system"
CATEGORY="media"
INTERVAL="5m"
VERSION="6.2.0"

ROOT_PATH_FOR_APPS="/repo/cluster/apps"
CHART_DIR="${ROOT_PATH_FOR_APPS}/${CATEGORY}/${NAME}"
CHART_FILE="helm-release.yaml"
VALUES_FILE="values.yaml"
CHART_PATH="${CHART_DIR}/${CHART_FILE}"
mkdir -p "${CHART_DIR}"

flux create hr ${NAME} --source ${SOURCE} --chart=${NAME} --chart-version=${VERSION=} --interval=${INTERVAL} --namespace=${CATEGORY} --values=${VALUES_FILE} --export > ${CHART_PATH}
