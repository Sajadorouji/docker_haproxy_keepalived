#!/bin/bash

containerName="${1:-haproxy_keepalived}"
containerVersion="${2:-v1.0}"

cd ./DockerData
docker build -t $containerName:$containerVersion .

if [ $? -eq 0 ]; then
  echo "Build Successfuly finished"
else
  echo "Build Faild!!!"
fi
