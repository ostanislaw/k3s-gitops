#!/bin/bash

docker buildx build\
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    --load -t k3s_maintenance .
