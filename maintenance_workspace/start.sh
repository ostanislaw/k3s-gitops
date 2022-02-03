#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
K3S_GITOPS_ROOT_DIR="$(dirname "$SCRIPTPATH")"

docker run --rm -it \
    -v ${K3S_GITOPS_ROOT_DIR}:/repo \
    -v ${HOME}:/home/developer \
    -w="/repo" \
    k3s_maintenance:latest \
    bash
