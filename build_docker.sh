#!/usr/bin/env bash

cd $(rospack find hbba_docker)/docker
docker build -t hbba_docker .
