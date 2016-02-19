#!/usr/bin/env bash

HOST_IP=$(ip route | awk '/docker0/ { print $NF }')
HOSTNAME=$(hostname)

if [[ "$(docker images -q francoisferland/hbba 2> /dev/null)" == "" ]]; then
    echo "!!! Unable to find francoisferland/hbba, see README.md in hbba_docker for details."
    exit 1
fi

docker run --add-host=$HOSTNAME:$HOST_IP francoisferland/hbba roslaunch hbba_synth base_nodes_r2.launch
